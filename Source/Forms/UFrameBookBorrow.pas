{*******************************************************************************
  ����: dmzn@163.com 2020-08-22
  ����: ͼ�����
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
    procedure EditNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnDelClick(Sender: TObject);
  private
    { Private declarations }
    FInOut: string;
    FStart,FEnd: TDate;
    //ʱ������
    FFilteDate: Boolean;
    //ɸѡ����
  public
    { Public declarations }
    class function FrameID: integer; override;
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    procedure OnLoadGridConfig(const nIni: TIniFile); override;
    {*���ຯ��*}
    function InitFormDataSQL(const nWhere: string): string; override;
    procedure AfterInitFormData; override;
    {*��ѯSQL*}
  end;

implementation

{$R *.dfm}

uses
  ULibFun, UMgrControl, USysDataDict, USysConst, USysDB, USysPopedom, USysGrid,
  USysBusiness, UDataModule, UFormBase, UFormDateFilter;

class function TfFrameBookBorrow.FrameID: integer;
begin
  Result := cFI_FrameBookBorrow;
end;

procedure TfFrameBookBorrow.OnCreateFrame;
begin
  inherited;
  FFilteDate := True;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFrameBookBorrow.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

procedure TfFrameBookBorrow.OnLoadGridConfig(const nIni: TIniFile);
begin
  if CompareText(FPopedom, 'MAIN_B04') = 0 then
       FInOut := sFlag_Out //����(���)
  else FInOut := sFlag_In;

  FWhere := Format('B_Type=''%s''', [FInOut]);
  if FInOut = sFlag_In then
  begin
    gSysEntityManager.BuildViewColumn(cxView1, 'MAIN_B04');
    InitTableView(Name, cxView1, nIni);
  end;
end;

function TfFrameBookBorrow.InitFormDataSQL(const nWhere: string): string;
begin
  Result := '';
  EditDate.Text := Format('%s �� %s', [Date2Str(FStart), Date2Str(FEnd)]);

  if FFilteDate then
  begin
    Result := ' Where (br.B_Date>=''%s'' and br.B_Date <''%s'')';
    Result := Format(Result, [Date2Str(FStart), Date2Str(FEnd+1)]);
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
  end;
end;

//Desc: ����ɸѡ
procedure TfFrameBookBorrow.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then
  begin
    FFilteDate := True;
    InitFormData(FWhere);
  end;
end;

//Desc: ���
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

//Desc: ����
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

initialization
  gControlManager.RegCtrl(TfFrameBookBorrow, TfFrameBookBorrow.FrameID);
end.