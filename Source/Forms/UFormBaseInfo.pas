{*******************************************************************************
  作者: dmzn@163.com 2020-08-13
  描述: 基础档案
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
    EditParam: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    CheckDef: TcxCheckBox;
    dxLayout1Item8: TdxLayoutItem;
    dxLayout1Group2: TdxLayoutGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure EditTypesPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    FRecordID: string;
    {*记录编号*}
    FBaseData: Integer;
    {*基础档案*}
    FSaveResult: Integer;
    procedure InitFormData(const nID: string);
    procedure ResetFormData;
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
  ULibFun, UFormCtrl, UFormBase, UMgrControl, USysDB, USysConst, UDataModule;

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
           Caption := '添加'
      else Caption := Format('添加 - %s', [cBaseData[FBaseData].FDesc]);

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
        ShowMsg('档案数据已丢失', sHint);
        Exit;
      end;

      EditName.Text := FieldByName('B_Text').AsString;
      EditMemo.Text := FieldByName('B_Memo').AsString;
      EditParam.Text := FieldByName('B_Params').AsString;
      CheckDef.Checked := FieldByName('B_Default').AsString = sFlag_Yes;

      nStr := FieldByName('B_Group').AsString;
      for nIdx:=Low(cBaseData) to High(cBaseData) do
      if cBaseData[nIdx].FName = nStr then
      begin
        FBaseData := nIdx;
        Caption := Format('修改 - %s', [cBaseData[nIdx].FDesc]);
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

//Desc: 重置界面数据
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

function TfFormBaseInfo.OnVerifyCtrl(Sender: TObject;
  var nHint: string): Boolean;
begin
  Result := True;
  if Sender = EditTypes then
  begin
    nHint := '请选择类型';
    Result := EditTypes.ItemIndex >= 0;

    if Result then
      FBaseData := Integer(EditTypes.Properties.Items.Objects[EditTypes.ItemIndex]);
    //xxxxx
  end else

  if Sender = EditName then
  begin
    Result := Trim(EditName.Text) <> '';
    nHint := '请填写名称';
  end;
end;

procedure TfFormBaseInfo.BtnOKClick(Sender: TObject);
var nStr: string;
begin
  if not IsDataValid then Exit;
  //verify data

  nStr := MakeSQLByStr([SF('B_Group', cBaseData[FBaseData].FName),
      SF('B_GroupName', cBaseData[FBaseData].FDesc),
      SF('B_Text', EditName.Text),
      SF('B_Py', GetPinYinOfStr(EditName.Text)),
      SF('B_Params', EditParam.Text),

      SF_IF([SF('B_Default', sFlag_Yes),
             SF('B_Default', '')], CheckDef.Checked),
      SF('B_Memo', EditMemo.Text)], sTable_BaseInfo,
      SF('B_ID', FRecordID, sfVal), FRecordID = '');
  FDM.ExecuteSQL(nStr);

  if CheckDef.Checked then
  begin
    nStr := 'Update %s Set B_Default=''%s'' ' +
            'Where B_Group=''%s'' And B_Text<>''%s''';
    nStr := Format(nStr, [sTable_BaseInfo, '',
            cBaseData[FBaseData].FName, EditName.Text]);
    //关闭其它默认项
    FDM.ExecuteSQL(nStr);
  end;
  
  FSaveResult := mrOk;
  if Check1.Checked then
  begin
    ResetFormData;
    ShowMsg('保存成功', sHint);
  end else ModalResult := mrOk;
end;

initialization
  gControlManager.RegCtrl(TfFormBaseInfo, TfFormBaseInfo.FormID);
end.
