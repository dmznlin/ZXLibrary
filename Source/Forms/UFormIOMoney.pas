{*******************************************************************************
  作者: dmzn@163.com 2020-08-17
  描述: 出入金
*******************************************************************************}
unit UFormIOMoney;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  USysBusiness, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxRadioGroup, cxCalendar,
  cxGroupBox;

type
  TfFormIOMoney = class(TfFormNormal)
    EditMemo: TcxMemo;
    dxLayout1Item5: TdxLayoutItem;
    EditPayment: TcxComboBox;
    dxLayout1Item6: TdxLayoutItem;
    EditCard: TcxTextEdit;
    dxLayout1Item4: TdxLayoutItem;
    EditName: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    EditPhone: TcxTextEdit;
    dxLayout1Item8: TdxLayoutItem;
    EditLevel: TcxTextEdit;
    dxLayout1Item9: TdxLayoutItem;
    dxLayout1Group2: TdxLayoutGroup;
    EditMoney: TcxTextEdit;
    dxLayout1Item10: TdxLayoutItem;
    RadioPay: TcxRadioButton;
    dxLayout1Item11: TdxLayoutItem;
    RadioTui: TcxRadioButton;
    dxLayout1Item12: TdxLayoutItem;
    cxLabel1: TcxLabel;
    dxLayout1Item13: TdxLayoutItem;
    EditValid: TcxDateEdit;
    dxLayout1Item3: TdxLayoutItem;
    GroupDate: TcxRadioGroup;
    dxLayout1Item14: TdxLayoutItem;
    dxLayout1Group4: TdxLayoutGroup;
    cxLabel2: TcxLabel;
    dxLayout1Item15: TdxLayoutItem;
    cxLabel3: TcxLabel;
    dxLayout1Item16: TdxLayoutItem;
    dxLayout1Group6: TdxLayoutGroup;
    dxLayout1Group5: TdxLayoutGroup;
    dxLayout1Group3: TdxLayoutGroup;
    dxlytmLayout1Item17: TdxLayoutItem;
    Label1: TcxLabel;
    EditCN: TcxTextEdit;
    dxlytmLayout1Item18: TdxLayoutItem;
    EditEN: TcxTextEdit;
    dxlytmLayout1Item19: TdxLayoutItem;
    dxGroupLayout1Group7: TdxLayoutGroup;
    dxGroupLayout1Group8: TdxLayoutGroup;
    EditPlay: TcxTextEdit;
    dxlytmLayout1Item20: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure GroupDatePropertiesEditValueChanged(Sender: TObject);
    procedure RadioPayClick(Sender: TObject);
  private
    { Private declarations }
    FMember: TMemberItem;
    {*会员编号*}
    procedure InitFormData(const nOnMoney: Boolean);
    {*界面数据*}
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
    function OnVerifyCtrl(Sender: TObject; var nHint: string): Boolean; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UFormCtrl, UFormBase, UMgrControl, UDataModule, USysDB,
  USysConst;

class function TfFormIOMoney.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  with TfFormIOMoney.Create(Application) do
  begin
    if nP.FCommand = cCmd_DeleteData then
         Caption := '会员 - 退款'
    else Caption := '会员 - 交款';

    FMember.FMID := nP.FParamA;
    EditMoney.Text := nP.FParamB;
    InitFormData(nP.FParamC = sFlag_Yes);
    
    nP.FCommand := cCmd_ModalResult;
    nP.FParamA := ShowModal;
    nP.FParamB := EditPayment.Text;
    Free;
  end;
end;

class function TfFormIOMoney.FormID: integer;
begin
  Result := cFI_FormInOutMoney;
end;

procedure TfFormIOMoney.FormCreate(Sender: TObject);
begin
  inherited;
  LoadFormConfig(Self);
end;

procedure TfFormIOMoney.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormIOMoney.InitFormData(const nOnMoney: Boolean);
var nStr: string;
    nMems: TMembers;
    nPayment: TBaseDataItem;
begin
  ActiveControl := EditMoney;
  EditValid.Enabled := False;

  GroupDate.Enabled := not nOnMoney;
  EditValid.Enabled := not nOnMoney;
  EditCN.Enabled := not nOnMoney;
  EditEN.Enabled := not nOnMoney;
  EditPlay.Enabled := not nOnMoney;

  if EditPayment.Properties.Items.Count < 1 then
  begin
    LoadBaseDataList(EditPayment.Properties.Items, sFlag_Base_Payment, @nPayment);
    EditPayment.ItemIndex := EditPayment.Properties.Items.IndexOf(nPayment.FName);
  end;
       
  if not LoadMembers(FMember.FMID, nMems, nStr) then
  begin
    BtnOK.Enabled := False;
    ShowMsg(nStr, sHint); Exit;
  end;

  FMember := nMems[0];
  with FMember do
  begin
    EditCard.Text := FCard;
    EditName.Text := FName;
    EditPhone.Text := FPhone;
    EditLevel.Text := FLevel;

    EditCN.Text := IntToStr(FMonCH);
    EditEN.Text := IntToStr(FMonEN);
    EditPlay.Text := IntToStr(FPlayArea);
    EditValid.Date := FValidDate;
  end;
end;

//Desc: 会员有效期
procedure TfFormIOMoney.GroupDatePropertiesEditValueChanged(
  Sender: TObject);
var nInt: Integer;
begin
  nInt := GroupDate.Properties.Items[GroupDate.ItemIndex].Tag;
  EditValid.Enabled := nInt < 0;

  if nInt <= 0 then
  begin
    EditValid.Date := FMember.FValidDate;
    Exit;
  end;

  if RadioTui.Checked then
    nInt := nInt * (-1);
  EditValid.Date := IncMonth(FMember.FValidDate, nInt);
end;

procedure TfFormIOMoney.RadioPayClick(Sender: TObject);
begin
  GroupDatePropertiesEditValueChanged(GroupDate);
end;

function TfFormIOMoney.OnVerifyCtrl(Sender: TObject;
  var nHint: string): Boolean;
begin
  Result := True;

  if Sender = EditPayment then
  begin
    Result := EditPayment.ItemIndex >= 0;
    nHint := '请选择支付方式';
  end else

  if Sender = EditCN then
  begin
    Result := IsNumber(EditCN.Text, False) and (StrToInt(EditCN.Text) >= 0);
    nHint := '请填写中文可借阅数量';
  end else

  if Sender = EditEN then
  begin
    Result := IsNumber(EditEN.Text, False) and (StrToInt(EditEN.Text) >= 0);
    nHint := '请填写英文可借阅数量';
  end else

  if Sender = EditPlay then
  begin
    Result := IsNumber(EditPlay.Text, False) and (StrToInt(EditPlay.Text) >= 0);
    nHint := '请填写游玩区次数';
  end else

  if Sender = EditMoney then
  begin
    nHint := '请填写正确的金额';
    Result := IsNumber(EditMoney.Text, True);
    if not Result then Exit;

    if RadioPay.Checked then
         Result := StrToFloat(EditMoney.Text) >= 0
    else Result := StrToFloat(EditMoney.Text) <= 0;
  end;
end;

procedure TfFormIOMoney.BtnOKClick(Sender: TObject);
var nStr,nMemo: string;
begin
  if not IsDataValid then Exit;
  //verify data

  FDM.ADOConn.BeginTrans;
  try
    nStr := MakeSQLByStr([SF('M_MemID', FMember.FMID),
      SF('M_MemName', FMember.FName),
      SF_IF([SF('M_Type', sFlag_In),
             SF('M_Type', sFlag_Out)], RadioPay.Checked),
      //xxxxx

      SF('M_Payment', EditPayment.Text),
      SF('M_Money', EditMoney.Text, sfVal),
      SF('M_Date', sField_SQLServer_Now, sfVal),
      SF('M_Man', gSysParam.FUserID),
      SF('M_Memo', nMemo)], sTable_InOutMoney, '', True);
    FDM.ExecuteSQL(nStr);

    if GroupDate.Enabled then
    begin
      nStr := MakeSQLByStr([SF('M_ValidDate', DateTime2Str(EditValid.Date)),
        SF('M_MonCH', EditCN.Text, sfVal),
        SF('M_MonEN', EditEN.Text, sfVal),
        SF('M_PlayArea', EditPlay.Text, sfVal)
        ], sTable_Members, SF('M_ID', FMember.FMID), False);
      FDM.ExecuteSQL(nStr);

      nStr := '';
      if EditValid.Date <> FMember.FValidDate then
        nStr := '会员有效期: ' + Date2Str(EditValid.Date);
      if StrToInt(EditCN.Text) <> FMember.FMonCH then
        nStr := nStr + Format(' 可借中文:[ %d>%s]', [FMember.FMonCH, EditCN.Text]);
      if StrToInt(EditEN.Text) <> FMember.FMonEN then
        nStr := nStr + Format(' 可借英文:[ %d>%s]', [FMember.FMonEN, EditEN.Text]);
      if StrToInt(EditPlay.Text) <> FMember.FPlayArea then
        nStr := nStr + Format(' 游玩区:[ %d>%s ]', [FMember.FPlayArea, EditPlay.Text]);
      FDM.WriteSysLog(sFlag_Member, FMember.FMID, nStr);
    end;

    FDM.ADOConn.CommitTrans;
    ModalResult := mrOk;

    if RadioPay.Checked then
         nStr := '付款'
    else nStr := '退款';
    ShowMsg(nStr + '操作成功', sHint);
  except
    on nErr: Exception do
    begin
      FDM.ADOConn.RollbackTrans;
      ShowDlg(nErr.Message, sError);
    end;
  end;
end;

initialization
  gControlManager.RegCtrl(TfFormIOMoney, TfFormIOMoney.FormID);
end.
