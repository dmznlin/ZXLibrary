{*******************************************************************************
  作者: dmzn@163.com 2020-08-14
  描述: 会员档案
*******************************************************************************}
unit UFormMembers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormBase, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxCalendar, cxLabel, cxRadioGroup,
  UFormNormal, ComCtrls, cxListView;

type
  TfFormMembers = class(TBaseForm)
    dxLayout1: TdxLayoutControl;
    BtnOK: TButton;
    BtnExit: TButton;
    EditLevel: TcxComboBox;
    EditMemo: TcxMemo;
    Check1: TcxCheckBox;
    EditName: TcxTextEdit;
    EditCard: TcxTextEdit;
    EditPhone: TcxTextEdit;
    EditJoin: TcxDateEdit;
    EditValid: TcxDateEdit;
    RadioMan: TcxRadioButton;
    RadioWoman: TcxRadioButton;
    cxLabel1: TcxLabel;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayout1Group8: TdxLayoutGroup;
    dxGroup1: TdxLayoutGroup;
    dxLayout1Group2: TdxLayoutGroup;
    dxLayout1Item8: TdxLayoutItem;
    dxLayout1Item7: TdxLayoutItem;
    dxLayout1Item9: TdxLayoutItem;
    dxLayout1Group3: TdxLayoutGroup;
    dxLayout1Group5: TdxLayoutGroup;
    dxLayout1Item14: TdxLayoutItem;
    dxLayout1Item12: TdxLayoutItem;
    dxLayout1Item13: TdxLayoutItem;
    dxLayout1Item3: TdxLayoutItem;
    dxLayout1Group4: TdxLayoutGroup;
    dxLayout1Item10: TdxLayoutItem;
    dxLayout1Item11: TdxLayoutItem;
    dxLayout1Item5: TdxLayoutItem;
    dxLayout1Group6: TdxLayoutGroup;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayout1Item4: TdxLayoutItem;
    dxLayoutItem1: TdxLayoutItem;
    dxLayout1Item2: TdxLayoutItem;
    EditBorrowNum: TcxTextEdit;
    dxLayout1Item1: TdxLayoutItem;
    EditBorrowBooks: TcxTextEdit;
    dxLayout1Item6: TdxLayoutItem;
    EditBuyBooks: TcxTextEdit;
    dxLayout1Item15: TdxLayoutItem;
    cxListView1: TcxListView;
    dxLayout1Item16: TdxLayoutItem;
    dxLayout1Group1: TdxLayoutGroup;
    EditBuyNum: TcxTextEdit;
    dxLayout1Item17: TdxLayoutItem;
    dxLayout1Group7: TdxLayoutGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
  private
    { Private declarations }
    FRecordID: string;
    {*记录编号*}
    FSaveResult: Integer;
    procedure InitFormData(const nID: string);
    procedure ResetFormData;
    {*界面数据*}
    function DoMemberPayment(const nID: string): Boolean;
    {*会员付费*}
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UFormCtrl, UMgrControl, USysDB, USysConst, USysBusiness, UDataModule;

class function TfFormMembers.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  case nP.FCommand of
   cCmd_AddData:
    with TfFormMembers.Create(Application) do
    begin
      Caption := '添加会员';
      FRecordID := '';      
      InitFormData('');
      
      ShowModal;
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := FSaveResult;
      Free;
    end;
   cCmd_EditData:
    with TfFormMembers.Create(Application) do
    begin
      Caption := '修改会员';
      FRecordID := nP.FParamA;
      InitFormData(FRecordID);

      ShowModal;
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := FSaveResult;
      Free;
    end;
   cCmd_ViewData:
    with TfFormMembers.Create(Application) do
    begin
      Caption := '会员信息';
      BtnOK.Enabled := False;
      FRecordID := nP.FParamA;
      
      InitFormData(FRecordID);
      ShowModal;
      Free;
    end;
  end;
end;

class function TfFormMembers.FormID: integer;
begin
  Result := cFI_FormMembers;
end;

procedure TfFormMembers.FormCreate(Sender: TObject);
begin
  inherited;
  FSaveResult := mrCancel;
  LoadFormConfig(Self);
end;

procedure TfFormMembers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormMembers.BtnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfFormMembers.InitFormData(const nID: string);
var nStr: string;
    nLevel: TBaseDataItem;
begin
  if EditLevel.Properties.Items.Count < 1 then
  begin
    LoadBaseDataList(EditLevel.Properties.Items, sFlag_Base_MemLevel, @nLevel);
    EditLevel.Text := nLevel.FName;
  end;

  if nID = '' then //添加
  begin
    EditJoin.Date := Now;
    EditValid.Date := Now; 
  end else //修改
  begin
    Check1.Checked := False;
    Check1.Visible := False;
    nStr := Format('Select * From %s Where R_ID=%s', [sTable_Members, nID]);

    with FDM.QueryTemp(nStr) do
    begin
      if RecordCount < 1 then
      begin
        BtnOK.Enabled := False;
        ShowMsg('会员信息已丢失', sHint);
        Exit;
      end;

      EditCard.Text := FieldByName('M_Card').AsString;
      EditName.Text := FieldByName('M_Name').AsString;
      EditPhone.Text := FieldByName('M_Phone').AsString;
      EditLevel.Text := FieldByName('M_Level').AsString;

      if FieldByName('M_Sex').AsString = sFlag_Male then
           RadioMan.Checked := True
      else RadioWoman.Checked := True;

      EditJoin.Date := FieldByName('M_JoinDate').AsDateTime;
      EditValid.Date := FieldByName('M_ValidDate').AsDateTime;
      EditMemo.Text := FieldByName('M_Memo').AsString;

      EditBorrowNum.Text := FieldByName('M_BorrowNum').AsString;
      EditBorrowBooks.Text := FieldByName('M_BorrowBooks').AsString;
      EditBuyNum.Text := FieldByName('M_BuyNum').AsString;
      EditBuyBooks.Text := FieldByName('M_BuyBooks').AsString;
    end;
  end;
end;

//Desc: 重置界面数据
procedure TfFormMembers.ResetFormData;
begin
  EditCard.Text := '';
  EditName.Text := '';
  EditPhone.Text := '';
  EditMemo.Text := '';
  ActiveControl := EditCard;
end;

//Desc: 会员付费
function TfFormMembers.DoMemberPayment(const nID: string): Boolean;
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  nParam.FParamA := nID;
  
  CreateBaseFormItem(cFI_FormInOutMoney, PopedomItem, @nParam);
  Result := (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK);
end;

procedure TfFormMembers.BtnOKClick(Sender: TObject);
var nStr,nID: string;
    nIsNew: Boolean;
begin
  EditCard.Text := Trim(EditCard.Text);
  EditName.Text := Trim(EditName.Text);
  EditPhone.Text := Trim(EditPhone.Text);

  if (EditCard.Text = '') and (EditName.Text = '') and (EditPhone.Text = '') then
  begin
    ActiveControl := EditCard;
    ShowMsg('请填写会员卡或姓名', sHint); Exit;
  end;

  nIsNew := FRecordID = '';
  //添加模式

  nStr := '';
  if EditCard.Text <> '' then
    nStr := Format('Where M_Card=''%s''', [EditCard.Text]);
  //xxxxx

  if EditName.Text <> '' then
  begin
    if nStr = '' then
         nStr := Format('Where M_Name=''%s''', [EditName.Text])
    else nStr := nStr + Format(' or M_Name=''%s''', [EditName.Text]);
  end;

  if EditPhone.Text <> '' then
  begin
    if nStr = '' then
         nStr := Format('Where M_Phone=''%s''', [EditPhone.Text])
    else nStr := nStr + Format(' or M_Phone=''%s''', [EditPhone.Text]);
  end;

  nStr := Format('Select R_ID,M_Card,M_Name,M_Phone From %s %s', [sTable_Members, nStr]);
  with FDM.QueryTemp(nStr) do
  if RecordCount > 0 then
  begin
    First;
    while not Eof do
    begin
      nStr := FieldByName('R_ID').AsString;
      if nIsNew or (FRecordID <> nStr) then
      begin
        ShowMsg('该会员信息已存在', sHint);
        Exit;
      end;

      Next;
    end;
  end;

  if nIsNew and (not GetSerailID(nID, sFlag_ID_BusGroup, sFlag_ID_Member)) then
  begin
    ShowMsg(nID, sHint);
    Exit;
  end;

  nStr := MakeSQLByStr([
      SF('M_Name', EditName.Text),
      SF('M_Py', GetPinYinOfStr(EditName.Text)),
      SF('M_Card', EditCard.Text),
      SF('M_Phone', EditPhone.Text),
      SF('M_Level', EditLevel.Text),
      SF('M_Memo', EditMemo.Text),

      SF_IF([SF('M_ID', nID), ''], nIsNew),
      SF_IF([SF('M_JoinDate', DateTime2Str(EditJoin.Date)), ''], nIsNew),
      SF_IF([SF('M_ValidDate', DateTime2Str(EditValid.Date)), ''], nIsNew),
      SF_IF([SF('M_Sex', sFlag_Male),
             SF('M_Sex', sFlag_Female)], RadioMan.Checked),

      SF_IF([SF('M_BorrowNum', 0, sfVal), ''], nIsNew),
      SF_IF([SF('M_BorrowBooks', 0, sfVal), ''], nIsNew),
      SF_IF([SF('M_BuyNum', 0, sfVal), ''], nIsNew),
      SF_IF([SF('M_BuyBooks', 0, sfVal), ''], nIsNew)], sTable_Members,
      SF('R_ID', FRecordID, sfVal), nIsNew);
  FDM.ExecuteSQL(nStr);
  
  FSaveResult := mrOk;
  if Check1.Checked then
  begin
    if not DoMemberPayment(nID) then
      ShowMsg('会员添加成功', sHint);
    ResetFormData;
  end else
  begin
    if nIsNew then
      DoMemberPayment(nID);
    ModalResult := mrOk;
  end;
end;

initialization
  gControlManager.RegCtrl(TfFormMembers, TfFormMembers.FormID);
end.
