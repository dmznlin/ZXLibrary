{*******************************************************************************
  ����: dmzn@163.com 2020-08-25
  ����: �������Ʒ�
*******************************************************************************}
unit UFormPlayArea;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  USysBusiness, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, ComCtrls, cxListView, ImgList,
  cxSpinEdit;

type
  TfFormPlayArea = class(TfFormNormal)
    EditMem: TcxLookupComboBox;
    dxlytmLayout1Item3: TdxLayoutItem;
    Label1: TcxLabel;
    dxlytmLayout1Item4: TdxLayoutItem;
    Label2: TcxLabel;
    dxlytmLayout1Item5: TdxLayoutItem;
    dxlytmLayout1Item6: TdxLayoutItem;
    Label3: TcxLabel;
    dxGroupLayout1Group2: TdxLayoutGroup;
    dxlytmLayout1Item7: TdxLayoutItem;
    Label4: TcxLabel;
    dxlytmLayout1Item8: TdxLayoutItem;
    Label5: TcxLabel;
    dxlytmLayout1Item9: TdxLayoutItem;
    Label6: TcxLabel;
    dxlytmLayout1Item10: TdxLayoutItem;
    Label7: TcxLabel;
    dxlytmLayout1Item11: TdxLayoutItem;
    Label8: TcxLabel;
    dxGroupLayout1Group3: TdxLayoutGroup;
    dxGroupLayout1Group5: TdxLayoutGroup;
    dxGroupLayout1Group6: TdxLayoutGroup;
    dxGroupLayout1Group4: TdxLayoutGroup;
    dxGroupLayout1Group7: TdxLayoutGroup;
    dxlytmLayout1Item12: TdxLayoutItem;
    Label9: TcxLabel;
    dxGroupLayout1Group8: TdxLayoutGroup;
    dxlytmLayout1Item13: TdxLayoutItem;
    Label10: TcxLabel;
    dxGroupLayout1Group9: TdxLayoutGroup;
    dxLayout1Item3: TdxLayoutItem;
    cxLabel1: TcxLabel;
    dxLayout1Item4: TdxLayoutItem;
    cxLabel2: TcxLabel;
    dxLayout1Group2: TdxLayoutGroup;
    dxGroup2: TdxLayoutGroup;
    EditNum: TcxSpinEdit;
    dxlytmLayout1Item14: TdxLayoutItem;
    Label11: TcxLabel;
    dxlytmLayout1Item16: TdxLayoutItem;
    EditMemo: TcxMemo;
    dxlytmLayout1Item17: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditMemPropertiesEditValueChanged(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
  private
    { Private declarations }
    FMember: TMemberItem;
    {*�������*}
    procedure InitFormData(const nID: string);
    procedure LoadMember(const nData: PMemberItem = nil);
    {*��������*}
    procedure SetLableCaption(const nHint,nText: string);
    procedure ClearLabelCaption(const nHint: string = '';
      const nCaption: string = '');
    {*��ǩ����*}
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UFormCtrl, UFormBase, UMgrControl, USysDB, USysConst,
  UMgrLookupAdapter, USysGrid, UDataModule;

class function TfFormPlayArea.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else nP := nil;

  with TfFormPlayArea.Create(Application) do
  try
    Caption := '��Ա - ������';
    LoadMember(nil);
    InitFormData('');

    if Assigned(nP) then
    begin
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := ShowModal;
    end else ShowModal;
  finally
    Free;
  end;
end;

class function TfFormPlayArea.FormID: integer;
begin
  Result := cFI_FormPlayArea;
end;

procedure TfFormPlayArea.FormCreate(Sender: TObject);
begin
  inherited;
  dxGroup1.AlignVert := avTop;
  dxGroup2.AlignVert := avClient;
  LoadFormConfig(Self);
end;

procedure TfFormPlayArea.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gLookupComboBoxAdapter.DeleteGroup(Name);
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormPlayArea.InitFormData(const nID: string);
var nStr,nTmp: string;
    nDStr: TDynamicStrArray;
    nItem: TLookupComboBoxItem;
begin
  ActiveControl := EditMem;
  BtnOK.Enabled := False;
  
  if not Assigned(gLookupComboBoxAdapter) then
    gLookupComboBoxAdapter := TLookupComboBoxAdapter.Create(FDM.ADOConn);
  //xxxxx

  if not Assigned(EditMem.Properties.ListSource) then
  begin
    nStr := 'Select M_ID,M_Name,M_Py,M_Card,M_Phone From %s';
    nStr := Format(nStr, [sTable_Members]);

    nTmp := Name + 'mem';
    SetLength(nDStr, 4);
    nDStr[0] := 'M_Py';
    nDStr[1] := 'M_Card';
    nDStr[2] := 'M_Phone';
    nDStr[3] := 'M_ID';

    nItem := gLookupComboBoxAdapter.MakeItem(Name, nTmp, nStr, 'M_ID', 0,
             [MI('M_ID', '���'), MI('M_Name', '����'), MI('M_Py', '������'),
              MI('M_Card', '����'), MI('M_Phone', '�ֻ�����')], nDStr);
    gLookupComboBoxAdapter.AddItem(nItem);
    gLookupComboBoxAdapter.BindItem(nTmp, EditMem);
  end;
end;

procedure TfFormPlayArea.EditMemPropertiesEditValueChanged(Sender: TObject);
var nStr: string;
    nMems: TMembers;
begin
  if EditMem.Focused and (EditMem.Text <> '') then
  begin
    if not LoadMembers(EditMem.Text, nMems, nStr) then
    begin
      LoadMember(nil);
      Exit;
    end;

    FMember := nMems[0];
    LoadMember(@FMember);
    ActiveControl := EditNum;
  end;
end;

procedure TfFormPlayArea.LoadMember(const nData: PMemberItem);
var nStr: string;
begin
  if not Assigned(nData) then
  begin
    ClearLabelCaption();
    Exit;
  end;

  with nData^ do
  begin
    SetLableCaption('M_Card', FCard);
    SetLableCaption('M_Name', FName);
    SetLableCaption('M_Phone', EncodePhone(FPhone));
    SetLableCaption('M_Level', FLevel);
    SetLableCaption('M_ValidDate', DateTime2Str(FValidDate));

    nStr := '������ʣ�� %d ��';
    SetLableCaption('M_Quanyi', Format(nStr, [FPlayArea]));
    BtnOK.Enabled := FPlayArea > 0;
  end;
end;

//Desc: ����Hint���ñ���
procedure TfFormPlayArea.SetLableCaption(const nHint, nText: string);
var nIdx: Integer;
begin
  with dxLayout1 do
  for nIdx:=ControlCount-1 downto 0 do
   if (Controls[nIdx] is TcxLabel) and
      (CompareText((Controls[nIdx] as TcxLabel).Hint, nHint) = 0) then
  begin
    (Controls[nIdx] as TcxLabel).Caption := nText;
    Break;
  end;
end;

//Desc: �����ǩ����
procedure TfFormPlayArea.ClearLabelCaption(const nHint,nCaption: string);
var nStr: string;
    nIdx: Integer;
begin
  for nIdx:=dxLayout1.ControlCount-1 downto 0 do
  begin
    if not (dxLayout1.Controls[nIdx] is TcxLabel) then Continue;
    nStr := (dxLayout1.Controls[nIdx] as TcxLabel).Hint;
    if nStr = '' then Continue;

    if nStr = nHint then
         (dxLayout1.Controls[nIdx] as TcxLabel).Caption := nCaption
    else (dxLayout1.Controls[nIdx] as TcxLabel).Caption := '';
  end;
end;

procedure TfFormPlayArea.BtnOKClick(Sender: TObject);
var nStr: string;
begin
  if EditNum.Value = 0 then
  begin
    ActiveControl := EditNum;
    ShowMsg('���Ѵ�������Ϊ0', sHint);
    Exit;
  end;

  if EditNum.Value > FMember.FPlayArea then
  begin
    ActiveControl := EditNum;
    ShowMsg('��ԱȨ�治��', sHint);
    Exit;
  end;

  FDM.ADOConn.BeginTrans;
  try
    nStr := MakeSQLByStr([SF('P_Member', FMember.FMID),
        SF('P_GoodsID', sFlag_PlayArea),
        SF('P_GoodsName', '������'),
        SF('P_GoodsPy', 'ywq'),
        SF('P_Number', EditNum.Value, sfVal),
        SF('P_Price', 0, sfVal),
        SF('P_Man', gSysParam.FUserID),
        SF('P_Date', sField_SQLServer_Now, sfVal),
        SF('P_Memo', EditMemo.Text),

        SF_IF([SF('P_Payment', '�˺ſ۳�'),
               SF('P_Payment', '�����˺�')], EditNum.Value > 0)
      ], sTable_PlayGoods, '', True);
    FDM.ExecuteSQL(nStr);

    nStr := 'Update %s Set M_PlayArea=M_PlayArea-(%d) Where M_ID=''%s''';
    nStr := Format(nStr, [sTable_Members, StrToInt(EditNum.Value), FMember.FMID]);
    FDM.ExecuteSQL(nStr);

    FDM.ADOConn.CommitTrans;
    ModalResult := mrOk;
  except
    on nErr: Exception do
    begin
      FDM.ADOConn.RollbackTrans;
      ShowDlg(nErr.Message, sError);
    end;
  end;  
end;

initialization
  gControlManager.RegCtrl(TfFormPlayArea, TfFormPlayArea.FormID);
end.
