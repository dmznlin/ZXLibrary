{*******************************************************************************
  ����: dmzn@163.com 2020-08-13
  ����: ��������
*******************************************************************************}
unit UFormBaseInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox;

type
  TfFormBaseInfo = class(TfFormNormal)
    EditTypes: TcxComboBox;
    dxLayout1Item3: TdxLayoutItem;
    EditMemo: TcxMemo;
    dxLayout1Item5: TdxLayoutItem;
    EditName: TcxComboBox;
    dxLayout1Item6: TdxLayoutItem;
    Check1: TcxCheckBox;
    dxLayout1Item4: TdxLayoutItem;
    EditParamA: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    CheckDef: TcxCheckBox;
    dxLayout1Item8: TdxLayoutItem;
    dxGroup2: TdxLayoutGroup;
    dxLayout1Item9: TdxLayoutItem;
    EditParamB: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure EditTypesPropertiesEditValueChanged(Sender: TObject);
    procedure EditNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FRecordID: string;
    {*��¼���*}
    FBaseData: Integer;
    {*��������*}
    FSaveResult: Integer;
    procedure InitFormData(const nID: string);
    procedure ResetFormData;
    {*��������*}
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
  ULibFun, UFormCtrl, UFormBase, UMgrControl, USysDB, USysConst, USysBusiness,
  UDataModule;

class function TfFormBaseInfo.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  case nP.FCommand of
   cCmd_AddData:
    with TfFormBaseInfo.Create(Application) do
    begin
      FRecordID := '';
      FBaseData := nP.FParamA;
      if FBaseData < 0 then
           Caption := '���'
      else Caption := Format('��� - %s', [cBaseData[FBaseData].FDesc]);

      InitFormData('');
      ShowModal;
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := FSaveResult;
      Free;
    end;
   cCmd_EditData:
    with TfFormBaseInfo.Create(Application) do
    begin
      FRecordID := nP.FParamA;
      FBaseData := -1;
      InitFormData(FRecordID);

      ShowModal;
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := FSaveResult;
      Free;
    end;
  end;
end;

class function TfFormBaseInfo.FormID: integer;
begin
  Result := cFI_FormBaseInfo;
end;

procedure TfFormBaseInfo.FormCreate(Sender: TObject);
begin
  inherited;
  FSaveResult := mrCancel;
  LoadFormConfig(Self);
end;

procedure TfFormBaseInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormBaseInfo.InitFormData(const nID: string);
var nStr: string;
    nIdx: Integer;
begin
  if nID <> '' then
  begin
    Check1.Checked := False;
    Check1.Visible := False;
    nStr := Format('Select * From %s Where B_ID=%s', [sTable_BaseInfo, nID]);

    with FDM.QueryTemp(nStr) do
    begin
      if RecordCount < 1 then
      begin
        BtnOK.Enabled := False;
        ShowMsg('���������Ѷ�ʧ', sHint);
        Exit;
      end;

      EditName.Text := FieldByName('B_Text').AsString;
      EditMemo.Text := FieldByName('B_Memo').AsString;
      EditParamA.Text := FieldByName('B_ParamA').AsString;
      EditParamB.Text := FieldByName('B_ParamB').AsString;
      CheckDef.Checked := FieldByName('B_Default').AsString = sFlag_Yes;

      nStr := FieldByName('B_Group').AsString;
      for nIdx:=Low(cBaseData) to High(cBaseData) do
      if cBaseData[nIdx].FName = nStr then
      begin
        FBaseData := nIdx;
        Caption := Format('�޸� - %s', [cBaseData[nIdx].FDesc]);
        Break;
      end;
    end;
  end;

  with EditTypes.Properties do
  begin
    Items.Clear;
    for nIdx:=Low(cBaseData) to High(cBaseData) do
    begin
      Items.AddObject(IntToStr(nIdx+1) + '.' + cBaseData[nIdx].FDesc, Pointer(nIdx));
      if nIdx = FBaseData then
        EditTypes.ItemIndex := nIdx;
      //xxxxx
    end;
  end;

  if EditTypes.ItemIndex >= 0 then
    ActiveControl := EditName;
  //xxxxx
end;

//Desc: ���ý�������
procedure TfFormBaseInfo.ResetFormData;
begin
  EditName.Clear;
  EditMemo.Clear;
  CheckDef.Checked := False;
end;

procedure TfFormBaseInfo.EditTypesPropertiesEditValueChanged(Sender: TObject);
var nIdx: Integer;
begin
  with EditName.Properties do
  begin
    Items.Clear;
    if EditTypes.ItemIndex < 0 then Exit;

    nIdx := Integer(EditTypes.Properties.Items.Objects[EditTypes.ItemIndex]);
    if cBaseData[nIdx].FValue <> '' then
      SplitStr(cBaseData[nIdx].FValue, Items, 0, '|');
    //xxxxx
  end;
end;

procedure TfFormBaseInfo.EditNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    BtnOK.Click();
  end;
end;

function TfFormBaseInfo.OnVerifyCtrl(Sender: TObject;
  var nHint: string): Boolean;
begin
  Result := True;
  if Sender = EditTypes then
  begin
    nHint := '��ѡ������';
    Result := EditTypes.ItemIndex >= 0;

    if Result then
      FBaseData := Integer(EditTypes.Properties.Items.Objects[EditTypes.ItemIndex]);
    //xxxxx
  end else

  if Sender = EditName then
  begin
    Result := Trim(EditName.Text) <> '';
    nHint := '����д����';
  end;
end;

procedure TfFormBaseInfo.BtnOKClick(Sender: TObject);
var nVal: TBaseDataItem;
begin
  if not IsDataValid then Exit;
  //verify data

  with nVal do
  begin
    FRecord := FRecordID;
    FGroup := cBaseData[FBaseData].FName;
    FGroupName := cBaseData[FBaseData].FDesc;
    FName := EditName.Text;

    FParamA := EditParamA.Text;
    FParamB := EditParamB.Text;
    FMemo := EditMemo.Text;
    FDefault := CheckDef.Checked;
  end;

  SaveBaseDataItem(@nVal, True);  
  FSaveResult := mrOk;
  
  if Check1.Checked then
  begin
    ResetFormData;
    ShowMsg('����ɹ�', sHint);
  end else ModalResult := mrOk;
end;

initialization
  gControlManager.RegCtrl(TfFormBaseInfo, TfFormBaseInfo.FormID);
end.
