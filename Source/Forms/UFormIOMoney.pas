{*******************************************************************************
  作者: dmzn@163.com 2020-08-17
  描述: 出入金
*******************************************************************************}
unit UFormIOMoney;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure GroupDatePropertiesEditValueChanged(Sender: TObject);
    procedure RadioPayClick(Sender: TObject);
  private
    { Private declarations }
    FMember: string;
    {*会员编号*}
    FValidDate: TDateTime;
    procedure InitFormData(const nID: string);
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
  ULibFun, UFormCtrl, UFormBase, UMgrControl, UDataModule, USysBusiness, USysDB,
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
    FMember := nP.FParamA;
    if nP.FCommand = cCmd_DeleteData then
         Caption := '会员 - 退费'
    else Caption := '会员 - 续费';

    InitFormData('');
    nP.FCommand := cCmd_ModalResult;
    nP.FParamA := ShowModal;;
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

procedure TfFormIOMoney.InitFormData(const nID: string);
var nStr: string;
    nPayment: TNameAndValue;
begin
  ActiveControl := EditMoney;
  EditValid.Enabled := False;
  
  if EditPayment.Properties.Items.Count < 1 then
  begin
    LoadBaseDataList(EditPayment.Properties.Items, sFlag_Base_Payment, @nPayment);
    EditPayment.ItemIndex := EditPayment.Properties.Items.IndexOf(nPayment.FName);
  end;

  nStr :='Select * From %s Where M_ID=''%s''';
  nStr := Format(nStr, [sTable_Members, FMember]);
  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount < 1 then
    begin
      BtnOK.Enabled := False;
      ShowMsg('会员档案已丢失', sHint); Exit;
    end;

    EditCard.Text := FieldByName('M_Card').AsString;
    EditName.Text := FieldByName('M_Name').AsString;
    EditPhone.Text := FieldByName('M_Phone').AsString;
    EditLevel.Text := FieldByName('M_Level').AsString;

    FValidDate := FieldByName('M_ValidDate').AsDateTime;
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
    EditValid.Date := FValidDate;
    Exit;
  end;

  if RadioTui.Checked then
    nInt := nInt * (-1);
  EditValid.Date := IncMonth(FValidDate, nInt);
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

  if Sender = EditMoney then
  begin
    Result := IsNumber(EditMoney.Text, True) and
              (StrToFloat(EditMoney.Text) >= 0);
    nHint := '请填写正确的金额';
  end;
end;

procedure TfFormIOMoney.BtnOKClick(Sender: TObject);
var nStr,nMemo: string;
begin
  if not IsDataValid then Exit;
  //verify data

  FDM.ADOConn.BeginTrans;
  try
    nMemo := Trim(EditMemo.Text) +
             '设定会员有效期: ' + Date2Str(EditValid.Date);
    //xxxxx

    nStr := MakeSQLByStr([SF('M_MemID', FMember),
      SF('M_MemName', EditName.Text),
      SF_IF([SF('M_Type', sFlag_InMoney),
             SF('M_Type', sFlag_OutMoney)], RadioPay.Checked),
      //xxxxx

      SF('M_Payment', EditPayment.Text),
      SF('M_Money', EditMoney.Text, sfVal),
      SF('M_Date', sField_SQLServer_Now, sfVal),
      SF('M_Man', gSysParam.FUserID),
      SF('M_Memo', nMemo)], sTable_InOutMoney, '', True);
    FDM.ExecuteSQL(nStr);

    nStr := 'Update %s Set M_ValidDate=''%s'' Where M_ID=''%s''';
    nStr := Format(nStr, [sTable_Members, DateTime2Str(EditValid.Date), FMember]);
    FDM.ExecuteSQL(nStr);

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
