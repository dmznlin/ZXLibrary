{*******************************************************************************
  作者: dmzn@163.com 2020-08-25
  描述: 游玩区计费
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
    FMember: TMemberData;
    {*数据相关*}
    procedure InitFormData(const nID: string);
    procedure LoadMember(const nData: PMemberData = nil);
    {*界面数据*}
    procedure SetLableCaption(const nHint,nText: string);
    procedure ClearLabelCaption(const nHint: string = '';
      const nCaption: string = '');
    {*标签标题*}
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
    Caption := '会员 - 游玩区';
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
             [MI('M_ID', '编号'), MI('M_Name', '姓名'), MI('M_Py', '助记码'),
              MI('M_Card', '卡号'), MI('M_Phone', '手机号码')], nDStr);
    gLookupComboBoxAdapter.AddItem(nItem);
    gLookupComboBoxAdapter.BindItem(nTmp, EditMem);
  end;
end;

procedure TfFormPlayArea.EditMemPropertiesEditValueChanged(Sender: TObject);
var nStr: string;
begin
  if EditMem.Text = '' then Exit;
  nStr := 'Select * From %s Where M_ID=''%s''';
  nStr := Format(nStr, [sTable_Members, EditMem.Text]);

  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount < 1 then
    begin
      LoadMember(nil);
      Exit;
    end;

    with FMember do
    begin
      FMember    := FieldByName('M_ID').AsString;
      FName      := FieldByName('M_Name').AsString;
      FCard      := FieldByName('M_Card').AsString;
      FPhone     := FieldByName('M_Phone').AsString;
      FLevel     := FieldByName('M_Level').AsString;
      FValidDate := FieldByName('M_ValidDate').AsDateTime;
      FPlayArea  := FieldByName('M_PlayArea').AsInteger;
    end;

    LoadMember(@FMember);
    ActiveControl := EditNum;
  end;
end;

procedure TfFormPlayArea.LoadMember(const nData: PMemberData);
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

    nStr := '游玩区剩余 %d 次';
    SetLableCaption('M_Quanyi', Format(nStr, [FPlayArea]));
    BtnOK.Enabled := FPlayArea > 0;
  end;
end;

//Desc: 根据Hint设置标题
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

//Desc: 清理标签标题
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
    ShowMsg('消费次数不能为0', sHint);
    Exit;
  end;

  if EditNum.Value > FMember.FPlayArea then
  begin
    ActiveControl := EditNum;
    ShowMsg('会员权益不足', sHint);
    Exit;
  end;

  FDM.ADOConn.BeginTrans;
  try
    nStr := MakeSQLByStr([SF('P_Member', FMember.FMember),
        SF('P_GoodsID', sFlag_PlayArea),
        SF('P_GoodsName', '游玩区'),
        SF('P_GoodsPy', 'ywq'),
        SF('P_Number', EditNum.Value, sfVal),
        SF('P_Price', 0, sfVal),
        SF('P_Man', gSysParam.FUserID),
        SF('P_Date', sField_SQLServer_Now, sfVal),
        SF('P_Memo', EditMemo.Text),

        SF_IF([SF('P_Payment', '账号扣除'),
               SF('P_Payment', '返回账号')], EditNum.Value > 0)
      ], sTable_PlayGoods, '', True);
    FDM.ExecuteSQL(nStr);

    nStr := 'Update %s Set M_PlayArea=M_PlayArea-(%d) Where M_ID=''%s''';
    nStr := Format(nStr, [sTable_Members, StrToInt(EditNum.Value), FMember.FMember]);
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
