{*******************************************************************************
  ����: dmzn@163.com 2020-08-14
  ����: ϵͳҵ����
*******************************************************************************}
unit USysBusiness;
{$I Link.inc}
interface

uses
  Windows, DB, Classes, Controls, SysUtils, UDataModule, UDataReport,
  UFormBase, ULibFun, UFormCtrl, USysConst, USysDB, USysLoger;

function GetSerailID(var nID: string; const nGroup,nObject: string;
  const nUserDate: Boolean = True): Boolean;
{*��ȡ����*}
function LoadBaseDataList(const nList: TStrings; const nGroup: string;
  const nDefault: PBaseDataItem = nil): Boolean;
function LoadBaseDataItem(const nGroup,nItem: string;
  var nValue: TBaseDataItem): Boolean;
procedure SaveBaseDataItem(const nValue: PBaseDataItem;
  const nOverride: Boolean = False);
procedure SaveBaseDataItemNoExists(const nGroup,nText: string);
{*��������ҵ��*}
procedure SyncBookNumber(const nBookID: string);
{*ͬ��ͼ������*}

implementation

//Desc: ��¼��־
procedure WriteLog(const nEvent: string);
begin
  gSysLoger.AddLog(nEvent);
end;

//Date: 2020-08-14
//Parm: ����;����;
//Desc: �������������б��
function GetSerailID(var nID: string; const nGroup,nObject: string;
  const nUserDate: Boolean): Boolean;
var nInt: Integer;
    nInTrans: Boolean;
    nStr,nP,nB: string;
begin
  nInTrans := FDM.ADOConn.InTransaction;
  if not nInTrans then FDM.ADOConn.BeginTrans;
  try
    Result := False;
    nStr := 'Update %s Set B_Base=B_Base+1 ' +
            'Where B_Group=''%s'' And B_Object=''%s''';
    nStr := Format(nStr, [sTable_SerialBase, nGroup, nObject]);
    FDM.ExecuteSQL(nStr);

    nStr := 'Select B_Prefix,B_IDLen,B_Base,B_Date,%s as B_Now From %s ' +
            'Where B_Group=''%s'' And B_Object=''%s''';
    nStr := Format(nStr, [sField_SQLServer_Now, sTable_SerialBase,
            nGroup, nObject]);
    //xxxxx

    with FDM.QueryTemp(nStr) do
    begin
      if RecordCount < 1 then
      begin
        nID := 'û��[ %s.%s ]�ı�������.';
        nID := Format(nID, [nGroup, nObject]);

        FDM.ADOConn.RollbackTrans;
        Exit;
      end;

      nP := FieldByName('B_Prefix').AsString;
      nB := FieldByName('B_Base').AsString;
      nInt := FieldByName('B_IDLen').AsInteger;

      if nUserDate then //�����ڱ���
      begin
        nStr := Date2Str(FieldByName('B_Date').AsDateTime, False);
        //old date

        if (nStr <> Date2Str(FieldByName('B_Now').AsDateTime, False)) and
           (FieldByName('B_Now').AsDateTime > FieldByName('B_Date').AsDateTime) then
        begin
          nStr := 'Update %s Set B_Base=1,B_Date=%s ' +
                  'Where B_Group=''%s'' And B_Object=''%s''';
          nStr := Format(nStr, [sTable_SerialBase, sField_SQLServer_Now,
                  nGroup, nObject]);
          FDM.ExecuteSQL(nStr);

          nB := '1';
          nStr := Date2Str(FieldByName('B_Now').AsDateTime, False);
          //now date
        end;

        System.Delete(nStr, 1, 2);
        //yymmdd
        nInt := nInt - Length(nP) - Length(nStr) - Length(nB);
        nID := nP + nStr + StringOfChar('0', nInt) + nB;
      end else
      begin
        nInt := nInt - Length(nP) - Length(nB);
        nStr := StringOfChar('0', nInt);
        nID := nP + nStr + nB;
      end;
    end;

    if not nInTrans then
      FDM.ADOConn.CommitTrans;
    Result := True;
  except
    if not nInTrans then
      FDM.ADOConn.RollbackTrans;
    raise;
  end;
end;

//Date: 2020-08-17
//Parm: �б�;��������;Ĭ��ֵ
//Desc: ��ȡnGroup�ĵ����嵥,����nList
function LoadBaseDataList(const nList: TStrings; const nGroup: string;
  const nDefault: PBaseDataItem): Boolean;
var nStr: string;
begin
  nStr := 'Select B_Text,B_ParamA,B_ParamB,B_Default From %s Where B_Group=''%s''';
  nStr := Format(nStr, [sTable_BaseInfo, nGroup]);

  with FDM.QueryTemp(nStr) do
  begin
    Result := RecordCount > 0;
    if not Result then Exit;
    
    First;
    while not Eof do
    begin
      nStr := FieldByName('B_Text').AsString;
      nList.Add(nStr);

      if Assigned(nDefault) and
         (FieldByName('B_Default').AsString = sFlag_Yes) then
      begin
        nDefault.FGroup := nGroup;
        nDefault.FName := nStr;
        nDefault.FDefault := True;
        nDefault.FParamA := FieldByName('B_ParamA').AsString;
        nDefault.FParamB := FieldByName('B_ParamB').AsString;
      end;
      Next;
    end;
  end;
end;

//Date: 2020-08-22
//Parm: ��������;������;ȡֵ
//Desc: ��ȡnGroup.nItem������
function LoadBaseDataItem(const nGroup,nItem: string;
  var nValue: TBaseDataItem): Boolean;
var nStr: string;
begin
  nStr := 'Select B_Text,B_ParamA,B_ParamB,B_Default From %s ' +
          'Where B_Group=''%s'' And B_Text=''%s''';
  nStr := Format(nStr, [sTable_BaseInfo, nGroup, nItem]);

  with FDM.QueryTemp(nStr) do
  begin
    Result := RecordCount > 0;
    if not Result then Exit;

    with nValue do
    begin
      FGroup := nGroup;
      FDefault := True;
      FName := FieldByName('B_Text').AsString;
      FParamA := FieldByName('B_ParamA').AsString;
      FParamB := FieldByName('B_ParamB').AsString;
    end;
  end;
end;

//Date: 2020-08-23
//Parm: ����ֵ;�Ƿ񸲸�
//Desc: ����nGroup.nItem��ֵnValue
procedure SaveBaseDataItem(const nValue: PBaseDataItem; const nOverride: Boolean);
var nStr,nID,nGName: string;
    nIdx: Integer;
begin
  nID := '';
  nStr := 'Select B_ID From %s Where B_Group=''%s'' And B_Text=''%s''';
  nStr := Format(nStr, [sTable_BaseInfo, nValue.FGroup, nValue.FName]);

  with FDM.QueryTemp(nStr) do
   if RecordCount > 0 then
    nID := Fields[0].AsString;
  //xxxxx

  if (nID <> '') and (not nOverride) then Exit;
  nGName := '';
  //default group

  for nIdx:=Low(cBaseData) to High(cBaseData) do
   with cBaseData[nIdx] do
    if CompareText(FName, nValue.FGroup) = 0 then
     nGName := FDesc;
  //for group name

  nStr := MakeSQLByStr([SF('B_Group', nValue.FGroup),
          SF('B_GroupName', nGName),
          SF('B_Text', nValue.FName),
          SF('B_Py', GetPinYinOfStr(nValue.FName)),
          SF('B_ParamA', nValue.FParamA),
          SF('B_ParamB', nValue.FParamB),
          
          SF_IF([SF('B_Default', sFlag_Yes), ''], nValue.FDefault)
          ], sTable_BaseInfo, SF('B_ID', nID), nID = '');
  FDM.ExecuteSQL(nStr);
end;

procedure SaveBaseDataItemNoExists(const nGroup,nText: string);
var nVal: TBaseDataItem;
begin
  with nVal do
  begin
    FGroup := nGroup;
    FName := nText;
    FParamA := '';
    FParamB := '';
    FDefault := False;
  end;

  SaveBaseDataItem(@nVal, False);
end;

//Date: 2020-08-19
//Parm: ͼ�鵵����ʶ
//Desc: ����nBookID�ĵ�ǰ���
procedure SyncBookNumber(const nBookID: string);
var nStr: string;
begin
  nStr := 'Select Sum(D_NumAll) as NumAll,Sum(D_NumIn) as NumIn,' +
          'Sum(D_NumOut) as NumOut From %s Where D_Book=''%s''';
  nStr := Format(nStr, [sTable_BookDetail, nBookID]);

  with FDM.QueryTemp(nStr) do
  begin
    nStr := 'Update %s Set B_NumAll=%d,B_NumIn=%d,B_NumOut=%d Where B_ID=''%s''';
    nStr := Format(nStr, [sTable_Books,
            FieldByName('NumAll').AsInteger,
            FieldByName('NumIn').AsInteger,
            FieldByName('NumOut').AsInteger, nBookID]);
    FDM.ExecuteSQL(nStr);
  end;
end;

end.
