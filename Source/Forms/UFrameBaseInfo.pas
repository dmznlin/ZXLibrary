{*******************************************************************************
  作者: dmzn@163.com 2020-08-12
  描述: 基础信息管理
*******************************************************************************}
unit UFrameBaseInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrameNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxContainer, Menus, cxGridCustomPopupMenu, cxGridPopupMenu, ADODB,
  cxLabel, UBitmapPanel, cxSplitter, dxLayoutControl, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, ToolWin, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxButtonEdit;

type
  TfFrameBaseInfo = class(TfFrameNormal)
    EditTypes: TcxComboBox;
    dxLayout1Item1: TdxLayoutItem;
    cxTextEdit1: TcxTextEdit;
    dxLayout1Item2: TdxLayoutItem;
    cxTextEdit2: TcxTextEdit;
    dxLayout1Item3: TdxLayoutItem;
    EditName: TcxButtonEdit;
    dxLayout1Item4: TdxLayoutItem;
    cxTextEdit3: TcxTextEdit;
    dxLayout1Item5: TdxLayoutItem;
    procedure EditTypesPropertiesEditValueChanged(Sender: TObject);
    procedure EditNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
  private
    { Private declarations }
    procedure FrameConfig(const nLoad: Boolean);
    {*配置信息*}
  public
    { Public declarations }
    class function FrameID: integer; override;
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    {*基类函数*}
    function InitFormDataSQL(const nWhere: string): string; override;
    {*查询SQL*}
  end;

implementation

{$R *.dfm}

uses
  IniFiles, UDataModule, UFormBase, ULibFun, UMgrControl, USysConst, USysDB,
  USysPopedom;

class function TfFrameBaseInfo.FrameID: integer;
begin
  Result := cFI_FrameBaseInfo;
end;

procedure TfFrameBaseInfo.OnCreateFrame;
var nIdx: Integer;
begin
  inherited;
  with EditTypes.Properties do
  begin
    Items.Clear;
    Items.Add('0.全部');

    for nIdx:=Low(cBaseData) to High(cBaseData) do
      Items.AddObject(IntToStr(nIdx+1) + '.' + cBaseData[nIdx].FDesc, Pointer(nIdx));
    //xxxxx
  end;

  FrameConfig(True); 
end;

procedure TfFrameBaseInfo.OnDestroyFrame;
begin
  FrameConfig(False);
  inherited;
end;

procedure TfFrameBaseInfo.FrameConfig(const nLoad: Boolean);
var nStr: string;
    nIni: TIniFile;
begin
  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    if nLoad then
    begin
      nStr := nIni.ReadString(Name, 'DefaultType', '');
      if nStr <> '' then
        EditTypes.ItemIndex := EditTypes.Properties.Items.IndexOf(nStr);
      //xxxxx

      if EditTypes.ItemIndex < 0 then
        EditTypes.ItemIndex := 0;
      //xxxxx
    end else
    begin
      nIni.WriteString(Name, 'DefaultType', EditTypes.Text);
    end;
  finally
    nIni.Free;
  end;
end;

function TfFrameBaseInfo.InitFormDataSQL(const nWhere: string): string;
var nIdx: Integer;
begin
  Result := '';
  if EditTypes.ItemIndex > 0 then
  begin
    nIdx := Integer(EditTypes.Properties.Items.Objects[EditTypes.ItemIndex]);
    Result := Result + Format(' Where B_Group=''%s''', [cBaseData[nIdx].FName]);
  end;

  if nWhere <> '' then
  begin
    if Result = '' then
         Result := ' Where ' + nWhere
    else Result := Result + ' And ' + nWhere;
  end;

  Result := 'Select * From ' + sTable_BaseInfo + Result;
end;

procedure TfFrameBaseInfo.EditTypesPropertiesEditValueChanged(Sender: TObject);
begin
  if EditTypes.IsFocused then InitFormData(FWhere);
end;

procedure TfFrameBaseInfo.EditNamePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditName then
  begin
    EditName.Text := Trim(EditName.Text);
    if EditName.Text = '' then Exit;

    FWhere := 'B_Text like ''%%%s%%'' Or B_Py like ''%%%s%%''';
    FWhere := Format(FWhere, [EditName.Text, EditName.Text]);
    InitFormData(FWhere);
  end
end;

//------------------------------------------------------------------------------
//Desc: 添加
procedure TfFrameBaseInfo.BtnAddClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  if EditTypes.ItemIndex <= 0 then
       nParam.FParamA := -1
  else nParam.FParamA := Integer(EditTypes.Properties.Items.Objects[EditTypes.ItemIndex]);

  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormBaseInfo, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    InitFormData('');
  end;
end;

//Desc: 修改
procedure TfFrameBaseInfo.BtnEditClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要编辑的记录', sHint); Exit;
  end;

  nParam.FCommand := cCmd_EditData;
  nParam.FParamA := SQLQuery.FieldByName('B_ID').AsString;
  CreateBaseFormItem(cFI_FormBaseInfo, PopedomItem, @nParam);

  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    InitFormData(FWhere);
  end;
end;

//Desc: 删除
procedure TfFrameBaseInfo.BtnDelClick(Sender: TObject);
var nStr: string;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要删除的档案', sHint); Exit;
  end;

  nStr := SQLQuery.FieldByName('B_Text').AsString;
  if not QueryDlg('确定要删除[ ' + nStr + ' ]档案吗?', sAsk) then Exit;

  nStr := SQLQuery.FieldByName('B_ID').AsString;
  nStr := Format('Delete From %s Where B_ID=%s', [sTable_BaseInfo, nStr]);
  FDM.ExecuteSQL(nStr);
  
  InitFormData(FWhere);
  ShowMsg('删除成功', sHint);
end;

initialization
  gControlManager.RegCtrl(TfFrameBaseInfo, TfFrameBaseInfo.FrameID);
end.
