{*******************************************************************************
  作者: dmzn@163.com 2020-08-25
  描述: 零售和游玩区
*******************************************************************************}
unit UFramePlayGoods;

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
  TfFramePlayGoods = class(TfFrameNormal)
    cxTextEdit1: TcxTextEdit;
    dxLayout1Item2: TdxLayoutItem;
    cxTextEdit2: TcxTextEdit;
    dxLayout1Item3: TdxLayoutItem;
    EditName: TcxButtonEdit;
    dxLayout1Item4: TdxLayoutItem;
    cxTextEdit3: TcxTextEdit;
    dxLayout1Item5: TdxLayoutItem;
    dxLayout1Item7: TdxLayoutItem;
    EditDate: TcxButtonEdit;
    dxlytmLayout1Item1: TdxLayoutItem;
    EditGoods: TcxButtonEdit;
    procedure EditNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
  private
    { Private declarations }
    FStart,FEnd: TDate;
    //时间区间
    FFilteDate: Boolean;
    //筛选日期
  public
    { Public declarations }
    class function FrameID: integer; override;
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    {*基类函数*}
    function InitFormDataSQL(const nWhere: string): string; override;
    procedure AfterInitFormData; override;
    {*查询SQL*}
  end;

implementation

{$R *.dfm}

uses
  IniFiles, ULibFun, UMgrControl, USysConst, USysDB, USysPopedom, USysBusiness,
  UDataModule, UFormBase, UFormDateFilter;

class function TfFramePlayGoods.FrameID: integer;
begin
  Result := cFI_FramePlayGoods;
end;

procedure TfFramePlayGoods.OnCreateFrame;
begin
  inherited;
  FFilteDate := True;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFramePlayGoods.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFramePlayGoods.InitFormDataSQL(const nWhere: string): string;
begin
  Result := '';
  EditDate.Text := Format('%s 至 %s', [Date2Str(FStart), Date2Str(FEnd)]);

  if FFilteDate then
  begin
    Result := ' Where (P_Date>=''%s'' and P_Date <''%s'')';
    Result := Format(Result, [Date2Str(FStart), Date2Str(FEnd+1)]);
  end;

  if nWhere <> '' then
  begin
    if Result = '' then
         Result := ' Where (' + nWhere + ')'
    else Result := Result + ' And (' + nWhere + ')';
  end;

  Result := 'Select pg.*,M_Name From $PG pg ' +
            ' Left Join $MM mm On mm.M_ID=pg.P_Member ' + Result;
  Result := MacroValue(Result, [MI('$PG', sTable_PlayGoods),
            MI('$MM', sTable_Members)]);
  //xxxxx
end;

procedure TfFramePlayGoods.AfterInitFormData;
begin
  FFilteDate := True;
end;

procedure TfFramePlayGoods.EditNamePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditName then
  begin
    EditName.Text := Trim(EditName.Text);
    if EditName.Text = '' then Exit;
    FFilteDate := False;

    FWhere := 'M_Name like ''%%$Name%%'' Or M_Py like ''%%$Name%%'' Or ' +
              'M_Card like ''%%$Name%%'' Or M_Phone like ''%%$Name%%''';
    FWhere := MacroValue(FWhere, [MI('$Name', EditName.Text)]);
    InitFormData(FWhere);
  end else

  if Sender = EditGoods then
  begin
    EditGoods.Text := Trim(EditGoods.Text);
    if EditGoods.Text = '' then Exit;
    FFilteDate := False;

    FWhere := 'P_GoodsName like ''%%$Name%%'' Or P_GoodsPy like ''%%$Name%%''';
    FWhere := MacroValue(FWhere, [MI('$Name', EditGoods.Text)]);
    InitFormData(FWhere);
  end
end;

//Desc: 日期筛选
procedure TfFramePlayGoods.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then
  begin
    FFilteDate := True;
    InitFormData(FWhere);
  end;
end;

//Desc: 游玩
procedure TfFramePlayGoods.BtnAddClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormPlayArea, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

//Desc: 零售
procedure TfFramePlayGoods.BtnEditClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormSaleGoods, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

initialization
  gControlManager.RegCtrl(TfFramePlayGoods, TfFramePlayGoods.FrameID);
end.
