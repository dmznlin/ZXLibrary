{*******************************************************************************
  作者: dmzn@163.com 2020-08-14
  描述: 系统业务处理
*******************************************************************************}
unit USysBusiness;
{$I Link.inc}
interface

uses
  Windows, DB, Classes, Controls, SysUtils, UDataModule, UDataReport,
  UFormBase, ULibFun, UFormCtrl, USysConst, USysDB, USysLoger;

type
  TBookStatus = (bsNone, bsNew, bsEdit, bsDel);
  //图书状态
  
  PBookItem = ^TBookItem;
  TBookItem = record
    FEnabled     : Boolean;    //记录有效  
    FRecord      : string;     //记录标识
    FBookID      : string;     //档案标识
    FBookName    : string;     //系列名称
    FDetailID    : string;     //图书编号
    FAuthor      : string;     //作者
    FLang        : string;     //语种
    FClass       : string;     //分类
    FISBN        : string;     //isdn
    FName        : string;     //图书名称
    FPublisher   : string;     //出版商
    FProvider    : string;     //供应商
    FPubPrice    : Double;     //定价
    FGetPrice    : Double;     //采购价
    FSalePrice   : Double;     //销售价
    FNumAll      : Integer;    //库存
    FNumIn       : Integer;    //在库
    FNumOut      : Integer;    //借出
    FNumAfter    : Integer;
    
    FValid       : Boolean;    //有效
    FMemo        : string;
    FStatus      : TBookStatus;
  end;
  TBooks = array of TBookItem;

  PMemberData = ^TMemberData;
  TMemberData = record
    FRecord      : string;     //记录标识
    FMember      : string;     //会员编号
    FName        : string;     //会员名称
    FSex         : string;     //性别
    FCard        : string;     //会员卡号
    FPhone       : string;     //手机号码
    FLevel       : string;     //会员等级
    FValidDate   : TDateTime;  //有效期

    FMonCH       : Integer;    //每月可借: 中文
    FMonEN       : Integer;    //每月可借: 英文
    FMonth       : string;     //计数月份
    FMonCHHas    : Integer;    //当月已借: 中文
    FMonENHas    : Integer;    //当月已借: 英文
    FPlayArea    : Integer;    //游玩区次数
  end;
  TMembers = array of TMemberData;

function GetCurrentMonth: string;
{*当前月份*}
function EncodePhone(const nPhone: string): string;
{*手机号隐私处理*}
function GetSerailID(var nID: string; const nGroup,nObject: string;
  const nUserDate: Boolean = True): Boolean;
{*获取串号*}
function LoadBaseDataList(const nList: TStrings; const nGroup: string;
  const nDefault: PBaseDataItem = nil): Boolean;
function LoadBaseDataItem(const nGroup,nItem: string;
  var nValue: TBaseDataItem): Boolean;
procedure SaveBaseDataItem(const nValue: PBaseDataItem;
  const nOverride: Boolean = False);
procedure SaveBaseDataItemNoExists(const nGroup,nText: string);
{*基础档案业务*}
procedure SyncBookNumber(const nBookID: string);
{*同步图书库存量*}
function LoadBooks(const nISDN: string; var nBooks: TBooks;
  var nHint: string; nWhere: string = ''): Boolean;
{*加载图书列表*}

implementation

//Desc: 记录日志
procedure WriteLog(const nEvent: string);
begin
  gSysLoger.AddLog(nEvent);
end;

//Date: 2020-08-24
//Desc: 当前月份字符串
function GetCurrentMonth: string;
begin
  Result := Copy(DateTime2Str(Now), 1, 7);
end;

function EncodePhone(const nPhone: string): string;
var nEnd: string;
    nLen: Integer;
begin
  Result := nPhone;
  nLen := Length(Result);
  if nLen <= 4 then Exit;

  nEnd := Copy(Result, nLen - 3, 4);
  Result := Copy(Result, 1, nLen - 4);

  nLen := Length(Result);
  if nLen > 3 then
    Result := Copy(Result, 1, nLen - 3) + 'xxx';
  Result := Result + nEnd;
end;

//Date: 2020-08-14
//Parm: 分组;对象;
//Desc: 按规则生成序列编号
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
        nID := '没有[ %s.%s ]的编码配置.';
        nID := Format(nID, [nGroup, nObject]);

        FDM.ADOConn.RollbackTrans;
        Exit;
      end;

      nP := FieldByName('B_Prefix').AsString;
      nB := FieldByName('B_Base').AsString;
      nInt := FieldByName('B_IDLen').AsInteger;

      if nUserDate then //按日期编码
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
//Parm: 列表;档案分组;默认值
//Desc: 读取nGroup的档案清单,存入nList
function LoadBaseDataList(const nList: TStrings; const nGroup: string;
  const nDefault: PBaseDataItem): Boolean;
var nStr: string;
begin
  nStr := 'Select * From %s Where B_Group=''%s''';
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
      with nDefault^ do
      begin
        FRecord := FieldByName('B_ID').AsString;
        FGroup := FieldByName('B_Group').AsString;
        FGroupName := FieldByName('B_GroupName').AsString;
        FName := FieldByName('B_Text').AsString;

        FParamA := FieldByName('B_ParamA').AsString;
        FParamB := FieldByName('B_ParamB').AsString;
        FMemo := FieldByName('B_Memo').AsString;
        FDefault := FieldByName('B_Default').AsString = sFlag_Yes;
      end;
      Next;
    end;
  end;
end;

//Date: 2020-08-22
//Parm: 档案分组;档案项;取值
//Desc: 读取nGroup.nItem的内容
function LoadBaseDataItem(const nGroup,nItem: string;
  var nValue: TBaseDataItem): Boolean;
var nStr: string;
begin
  nStr := 'Select * From %s Where B_Group=''%s'' And B_Text=''%s''';
  nStr := Format(nStr, [sTable_BaseInfo, nGroup, nItem]);

  with FDM.QueryTemp(nStr) do
  begin
    Result := RecordCount > 0;
    if not Result then Exit;

    with nValue do
    begin
      FRecord := FieldByName('B_ID').AsString;
      FGroup := FieldByName('B_Group').AsString;
      FGroupName := FieldByName('B_GroupName').AsString;
      FName := FieldByName('B_Text').AsString;

      FParamA := FieldByName('B_ParamA').AsString;
      FParamB := FieldByName('B_ParamB').AsString;
      FMemo := FieldByName('B_Memo').AsString;
      FDefault := FieldByName('B_Default').AsString = sFlag_Yes;
    end;
  end;
end;

//Date: 2020-08-23
//Parm: 档案值;是否覆盖
//Desc: 保存nGroup.nItem的值nValue
procedure SaveBaseDataItem(const nValue: PBaseDataItem; const nOverride: Boolean);
var nStr: string;
    nIdx: Integer;
    nVal: TBaseDataItem;
    nLocalTrans: Boolean;
begin
  if (nValue.FGroup = '') or (nValue.FName = '') then Exit;
  //invalid data

  if (nValue.FRecord = '') and
     LoadBaseDataItem(nValue.FGroup, nValue.FName, nVal) then
  begin
    nValue.FRecord := nVal.FRecord;
    if nValue.FGroupName = '' then
      nValue.FGroupName := nVal.FGroupName;
    //xxxxx
  end;

  if (nValue.FRecord <> '') and (not nOverride) then Exit;
  //has exists

  if nValue.FGroupName = '' then
  begin
    for nIdx:=Low(cBaseData) to High(cBaseData) do
    if CompareText(cBaseData[nIdx].FName, nValue.FGroup) = 0 then
    begin
       nValue.FGroupName := cBaseData[nIdx].FDesc;
       Break;
    end;
  end;
  
  nLocalTrans := not FDM.ADOConn.InTransaction;
  if nLocalTrans then FDM.ADOConn.BeginTrans;
  try
    nStr := MakeSQLByStr([
      SF('B_Group', nValue.FGroup),
      SF('B_GroupName', nValue.FGroupName),
      SF('B_Text', nValue.FName),
      SF('B_Py', GetPinYinOfStr(nValue.FName)),
      SF('B_ParamA', nValue.FParamA),
      SF('B_ParamB', nValue.FParamB),

      SF_IF([SF('B_Default', sFlag_Yes),
             SF('B_Default', '')], nValue.FDefault),
      SF('B_Memo', nValue.FMemo)
      ], sTable_BaseInfo, SF('B_ID', nValue.FRecord), nValue.FRecord = '');
    FDM.ExecuteSQL(nStr);

    if nValue.FDefault then
    begin
      nStr := 'Update %s Set B_Default=''%s'' ' +
              'Where B_Group=''%s'' And B_Text<>''%s''';
      nStr := Format(nStr, [sTable_BaseInfo, '', nValue.FGroup, nValue.FName]);
      FDM.ExecuteSQL(nStr); //关闭其它默认项
    end;

    if nLocalTrans then
      FDM.ADOConn.CommitTrans;
    //xxxxx
  except
    if nLocalTrans then
      FDM.ADOConn.RollbackTrans;
    raise;
  end;
end;

//Date: 2020-08-24
//Parm: 分组标识;内容
//Desc: 如果不存在,则保存基础档案nGroup.nText
procedure SaveBaseDataItemNoExists(const nGroup,nText: string);
var nVal: TBaseDataItem;
begin
  FillChar(nVal, SizeOf(nVal), #0);
  with nVal do
  begin
    FGroup := nGroup;
    FName := nText;
    FDefault := False;
  end;

  SaveBaseDataItem(@nVal, False);
end;

//Date: 2020-08-19
//Parm: 图书档案标识
//Desc: 更新nBookID的当前库存
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

//Date: 2020-08-24
//Parm: isdn;图书清单;提示信息
//Desc: 读取isdn的书单,存入nBooks
function LoadBooks(const nISDN: string; var nBooks: TBooks;
  var nHint: string; nWhere: string): Boolean;
var nStr: string;
    nIdx: Integer;
begin
  Result := False;
  SetLength(nBooks, 0);
  //init default

  if nWhere = '' then
    nWhere := Format('D_ISBN=''%s''', [nISDN]);
  //default

  nStr := 'Select dt.*,B_Name,B_Author,B_Lang,B_Class,B_Valid From %s dt ' +
          ' Left Join %s On B_ID=D_Book ' +
          'Where %s';
  nStr := Format(nStr, [sTable_BookDetail, sTable_Books, nWhere]);

  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount < 1 then
    begin
      nHint := '该条码没有图书档案';
      Exit;
    end;

    SetLength(nBooks, RecordCount);
    nIdx := 0;
    First;

    while not Eof do
    begin
      with nBooks[nIdx] do
      begin
        FRecord      := FieldByName('R_ID').AsString;
        FBookID      := FieldByName('D_Book').AsString;
        FBookName    := FieldByName('B_Name').AsString;
        FAuthor      := FieldByName('B_Author').AsString;
        FLang        := FieldByName('B_Lang').AsString;
        FClass       := FieldByName('B_Class').AsString;

        FDetailID    := FieldByName('D_ID').AsString;
        FISBN        := FieldByName('D_ISBN').AsString;
        FName        := FieldByName('D_Name').AsString;
        FPublisher   := FieldByName('D_Publisher').AsString;
        FProvider    := FieldByName('D_Provider').AsString;
        FPubPrice    := FieldByName('D_PubPrice').AsFloat;
        FGetPrice    := FieldByName('D_GetPrice').AsFloat;
        FSalePrice   := FieldByName('D_SalePrice').AsFloat;
        FNumAll      := FieldByName('D_NumAll').AsInteger;
        FNumIn       := FieldByName('D_NumIn').AsInteger;
        FNumOut      := FieldByName('D_NumOut').AsInteger;

        FValid := (FieldByName('D_Valid').AsString = sFlag_Yes) and
                  (FieldByName('B_Valid').AsString = sFlag_Yes);
        FEnabled := True;
      end;

      Inc(nIdx);
      Next;
    end;
  end;

  Result := True;
end;

end.
