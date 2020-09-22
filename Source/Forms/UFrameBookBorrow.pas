{*******************************************************************************
  作者: dmzn@163.com 2020-08-22
  描述: 图书借阅
*******************************************************************************}
unit UFrameBookBorrow;

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
  TfFrameBookBorrow = class(TfFrameNormal)
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
    PMenu1: TPopupMenu;
    MenuAll: TMenuItem;
    MenuWeek: TMenuItem;
    MenuNDays: TMenuItem;
    N4: TMenuItem;
    MenuInclude: TMenuItem;
    procedure EditNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnDelClick(Sender: TObject);
    procedure MenuAllClick(Sender: TObject);
  private
    { Private declarations }
    FStart,FEnd: TDate;
    //时间区间
    FFilteDate: Boolean;
    //筛选日期
    FMenuDays: Integer;
    FMenuLast: TObject;
    //菜单筛选
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
  USysBusiness, UDataModule, UFormBase, UFormDateFilter, UFormInputbox;

class function TfFrameBookBorrow.FrameID: integer;
begin
  Result := cFI_FrameBookBorrow;
end;

procedure TfFrameBookBorrow.OnCreateFrame;
begin
  inherited;
  FMenuDays := 14;
  FMenuLast := nil;

  FFilteDate := True;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFrameBookBorrow.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFrameBookBorrow.InitFormDataSQL(const nWhere: string): string;
begin
  Result := '';
  EditDate.Text := Format('%s 至 %s', [Date2Str(FStart), Date2Str(FEnd)]);

  if FFilteDate then
  begin
    Result := ' Where ((B_DateBorrow>=''$ST'' and B_DateBorrow <''$ED'') Or ' +
              '(B_DateReturn>=''$ST'' and B_DateReturn <''$ED''))';
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

  Result := 'Select * From $BR br' +
            '  Left Join $Mm mm On mm.M_ID=br.B_Member' +
            '  Left Join $BK bk On bk.B_ID=br.B_Book' +
            '  Left Join $BD bd On bd.D_ID=br.B_BookDtl ' + Result;
  Result := MacroValue(Result, [MI('$BR', sTable_BookBorrow),
            MI('$Mm', sTable_Members),
            MI('$BK', sTable_Books), MI('$BD', sTable_BookDetail)]);
  //xxxxx
end;

procedure TfFrameBookBorrow.AfterInitFormData;
begin
  FMenuLast := nil;
  FFilteDate := True;
end;

procedure TfFrameBookBorrow.EditNamePropertiesButtonClick(Sender: TObject;
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
procedure TfFrameBookBorrow.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then
  begin
    FFilteDate := True;
    InitFormData(FWhere);
  end;
end;

//Desc: 借阅
procedure TfFrameBookBorrow.BtnAddClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormBookBorrow, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

//Desc: 归还
procedure TfFrameBookBorrow.BtnDelClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_DeleteData;
  CreateBaseFormItem(cFI_FormBookReturn, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

//Desc: 查询未归还
procedure TfFrameBookBorrow.MenuAllClick(Sender: TObject);
var nStr: string;
    nLast: TObject;
begin
  if Sender = MenuInclude then
  begin
    MenuInclude.Checked := not MenuInclude.Checked;
    MenuInclude.Tag := 10;
    nLast := FMenuLast;

    MenuAllClick(FMenuLast);
    FMenuLast := nLast;    
    MenuInclude.Tag := 0;
    Exit;
  end;

  if Sender = MenuAll then
  begin
    FFilteDate := False;
    FWhere := 'B_NumBorrow > B_NumReturn';
    InitFormData(FWhere);
  end else

  if Sender = MenuWeek then
  begin
    FFilteDate := False;
    FWhere := Format('B_DateBorrow < ''%s''', [Date2Str(Date() - 7 + 1)]);
    
    if not MenuInclude.Checked then
      FWhere := FWhere + ' And B_NumBorrow > B_NumReturn';
    InitFormData(FWhere);
  end else

  if Sender = MenuNDays then
  begin
    if MenuInclude.Tag <> 10 then
    begin
      nStr := IntToStr(FMenuDays);
      while True do //loop
      begin
        if not ShowInputBox('请输入天数:', '', nStr, 5) then Exit;
        if IsNumber(nStr, False) and (StrToInt(nStr) > 0) then Break;
      end;
      FMenuDays := StrToInt(nStr);
    end;

    FFilteDate := False;
    nStr := Date2Str(Date() - FMenuDays + 1);
    FWhere := Format('B_DateBorrow < ''%s''', [nStr]);

    if not MenuInclude.Checked then
      FWhere := FWhere + ' And B_NumBorrow > B_NumReturn';;
    InitFormData(FWhere);
  end;

  FMenuLast := Sender;
  //remember
end;

initialization
  gControlManager.RegCtrl(TfFrameBookBorrow, TfFrameBookBorrow.FrameID);
end.
