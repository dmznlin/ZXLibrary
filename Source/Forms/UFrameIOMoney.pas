{*******************************************************************************
  作者: dmzn@163.com 2020-08-25
  描述: 出入金查询
*******************************************************************************}
unit UFrameIOMoney;

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
  TfFrameIOMoney = class(TfFrameNormal)
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
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
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

class function TfFrameIOMoney.FrameID: integer;
begin
  Result := cFI_FrameInOutMoney;
end;

procedure TfFrameIOMoney.OnCreateFrame;
begin
  inherited;
  FFilteDate := True;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFrameIOMoney.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFrameIOMoney.InitFormDataSQL(const nWhere: string): string;
begin
  Result := '';
  EditDate.Text := Format('%s 至 %s', [Date2Str(FStart), Date2Str(FEnd)]);

  if FFilteDate then
  begin
    Result := ' Where (M_Date>=''%s'' and M_Date <''%s'')';
    Result := Format(Result, [Date2Str(FStart), Date2Str(FEnd+1)]);
  end;

  if nWhere <> '' then
  begin
    if Result = '' then
         Result := ' Where (' + nWhere + ')'
    else Result := Result + ' And (' + nWhere + ')';
  end;

  Result := 'Select io.* From $IO io ' +
            ' Left Join $MM mm On mm.M_ID=io.M_MemID ' + Result;
  Result := MacroValue(Result, [MI('$IO', sTable_InOutMoney),
            MI('$MM', sTable_Members)]);
  //xxxxx
end;

procedure TfFrameIOMoney.AfterInitFormData;
begin
  FFilteDate := True;
end;

procedure TfFrameIOMoney.EditNamePropertiesButtonClick(Sender: TObject;
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
  end;
end;

//Desc: 日期筛选
procedure TfFrameIOMoney.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then
  begin
    FFilteDate := True;
    InitFormData(FWhere);
  end;
end;

initialization
  gControlManager.RegCtrl(TfFrameIOMoney, TfFrameIOMoney.FrameID);
end.
