{*******************************************************************************
  作者: dmzn@163.com 2020-08-19
  描述: 图书入库出库
*******************************************************************************}
unit UFrameBookInOut;

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
  TfFrameBookInOut = class(TfFrameNormal)
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
  IniFiles, ULibFun, UMgrControl, USysConst, USysDB, USysPopedom, USysBusiness,
  UDataModule, UFormBase, UFormDateFilter;

class function TfFrameBookInOut.FrameID: integer;
begin
  Result := cFI_FrameBookInOut;
end;

procedure TfFrameBookInOut.OnCreateFrame;
begin
  inherited;
  FFilteDate := True;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFrameBookInOut.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFrameBookInOut.InitFormDataSQL(const nWhere: string): string;
begin
  Result := '';
  EditDate.Text := Format('%s 至 %s', [Date2Str(FStart), Date2Str(FEnd)]);

  if FFilteDate then
  begin
    Result := ' Where (I_Date>=''%s'' and I_Date <''%s'')';
    Result := Format(Result, [Date2Str(FStart), Date2Str(FEnd+1)]);
  end;

  if nWhere <> '' then
  begin
    if Result = '' then
         Result := ' Where (' + nWhere + ')'
    else Result := Result + ' And (' + nWhere + ')';
  end;

  Result := 'Select * From $IO io' +
            '  Left Join $BK bk On bk.B_ID=io.I_Book' +
            '  Left Join $BD bd On bd.D_ID=io.I_BookDtl ' + Result;
  Result := MacroValue(Result, [MI('$IO', sTable_BookInOut),
            MI('$BK', sTable_Books), MI('$BD', sTable_BookDetail)]);
  //xxxxx
end;

procedure TfFrameBookInOut.AfterInitFormData;
begin
  FFilteDate := True;
end;

procedure TfFrameBookInOut.EditNamePropertiesButtonClick(Sender: TObject;
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
  end;
end;

//Desc: 日期筛选
procedure TfFrameBookInOut.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then
  begin
    FFilteDate := True;
    InitFormData(FWhere);
  end;
end;

//Desc: 入库
procedure TfFrameBookInOut.BtnAddClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormBookInOut, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

//Desc: 出库
procedure TfFrameBookInOut.BtnDelClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_DeleteData;
  CreateBaseFormItem(cFI_FormBookInOut, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

initialization
  gControlManager.RegCtrl(TfFrameBookInOut, TfFrameBookInOut.FrameID);
end.
