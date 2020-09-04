{*******************************************************************************
  作者: dmzn@163.com 2020-09-03
  描述: 图书销售
*******************************************************************************}
unit UFrameBookSale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IniFiles, UFrameNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxContainer, dxLayoutControl, cxMaskEdit, cxButtonEdit, cxTextEdit,
  Menus, cxGridCustomPopupMenu, cxGridPopupMenu, ADODB, cxLabel,
  UBitmapPanel, cxSplitter, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, ToolWin;

type
  TfFrameBookSale = class(TfFrameNormal)
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
    dxLayout1Item8: TdxLayoutItem;
    cxTextEdit4: TcxTextEdit;
    dxlytmLayout1Item1: TdxLayoutItem;
    EditMem: TcxButtonEdit;
    procedure EditNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnDelClick(Sender: TObject);
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
  ULibFun, UMgrControl, USysDataDict, USysConst, USysDB, USysPopedom, USysGrid,
  USysBusiness, UDataModule, UFormBase, UFormDateFilter;

class function TfFrameBookSale.FrameID: integer;
begin
  Result := cFI_FrameBookSale;
end;

procedure TfFrameBookSale.OnCreateFrame;
begin
  inherited;
  FFilteDate := True;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFrameBookSale.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFrameBookSale.InitFormDataSQL(const nWhere: string): string;
begin
  Result := '';
  EditDate.Text := Format('%s 至 %s', [Date2Str(FStart), Date2Str(FEnd)]);

  if FFilteDate then
  begin
    Result := ' Where (S_Date>=''$ST'' and S_Date <''$ED'')';
    Result := MacroValue(Result, [MI('$ST', Date2Str(FStart)),
              MI('$ED', Date2Str(FEnd+1))]);
    //xxxxx
  end;

  if FWhere <> '' then
  begin
    if Result = '' then
         Result := ' Where (' + FWhere + ')'
    else Result := Result + ' And (' + FWhere + ')';
  end;

  Result := 'Select * From $BS bs' +
            '  Left Join $Mm mm On mm.M_ID=bs.S_Member' +
            '  Left Join $BK bk On bk.B_ID=bs.S_Book' +
            '  Left Join $BD bd On bd.D_ID=bs.S_BookDtl ' + Result;
  Result := MacroValue(Result, [MI('$BS', sTable_BookSale),
            MI('$Mm', sTable_Members),
            MI('$BK', sTable_Books), MI('$BD', sTable_BookDetail)]);
  //xxxxx
end;

procedure TfFrameBookSale.AfterInitFormData;
begin
  FFilteDate := True;
end;

procedure TfFrameBookSale.EditNamePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditName then
  begin
    EditName.Text := Trim(EditName.Text);
    if EditName.Text = '' then Exit;
    FFilteDate := False;

    FWhere := '(B_Name like ''%%$Name%%'' Or B_Py like ''%%$Name%%'') Or ' +
              '(D_Name like ''%%$Name%%'' Or D_Py like ''%%$Name%%'')';
    FWhere := MacroValue(FWhere, [MI('$Name', EditName.Text)]);
    InitFormData(FWhere);
  end else

  if Sender = EditMem then
  begin
    EditMem.Text := Trim(EditMem.Text);
    if EditMem.Text = '' then Exit;
    FFilteDate := False;

    FWhere := 'M_Name like ''%%$Name%%'' Or M_Py like ''%%$Name%%'' Or ' +
              'M_Card like ''%%$Name%%'' Or M_Phone like ''%%$Name%%''';
    FWhere := MacroValue(FWhere, [MI('$Name', EditMem.Text)]);
    InitFormData(FWhere);
  end;
end;

//Desc: 日期筛选
procedure TfFrameBookSale.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then
  begin
    FFilteDate := True;
    InitFormData(FWhere);
  end;
end;

//Desc: 销售
procedure TfFrameBookSale.BtnAddClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormBookSale, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

//Desc: 退回
procedure TfFrameBookSale.BtnDelClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_DeleteData;
  CreateBaseFormItem(cFI_FormBookSaleReturn, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

initialization
  gControlManager.RegCtrl(TfFrameBookSale, TfFrameBookSale.FrameID);
end.
