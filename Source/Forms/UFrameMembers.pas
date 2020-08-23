{*******************************************************************************
  作者: dmzn@163.com 2020-08-13
  描述: 会员信息管理
*******************************************************************************}
unit UFrameMembers;

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
  TfFrameMembers = class(TfFrameNormal)
    cxTextEdit1: TcxTextEdit;
    dxLayout1Item2: TdxLayoutItem;
    cxTextEdit2: TcxTextEdit;
    dxLayout1Item3: TdxLayoutItem;
    EditName: TcxButtonEdit;
    dxLayout1Item4: TdxLayoutItem;
    cxTextEdit3: TcxTextEdit;
    dxLayout1Item5: TdxLayoutItem;
    dxLayout1Item1: TdxLayoutItem;
    EditPhone: TcxButtonEdit;
    dxLayout1Item6: TdxLayoutItem;
    EditCard: TcxButtonEdit;
    dxLayout1Item7: TdxLayoutItem;
    EditDate: TcxButtonEdit;
    dxLayout1Item8: TdxLayoutItem;
    cxTextEdit4: TcxTextEdit;
    PMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure EditNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnRefreshClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure cxView1DblClick(Sender: TObject);
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

class function TfFrameMembers.FrameID: integer;
begin
  Result := cFI_FrameMembers;
end;

procedure TfFrameMembers.OnCreateFrame;
begin
  inherited;
  FFilteDate := False;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFrameMembers.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFrameMembers.InitFormDataSQL(const nWhere: string): string;
begin
  Result := '';
  EditDate.Text := Format('%s 至 %s', [Date2Str(FStart), Date2Str(FEnd)]);

  if FFilteDate then
  begin
    Result := ' Where (M_JoinDate>=''%s'' and M_JoinDate <''%s'')';
    Result := Format(Result, [Date2Str(FStart), Date2Str(FEnd+1)]);
  end;

  if nWhere <> '' then
  begin
    if Result = '' then
         Result := ' Where (' + nWhere + ')'
    else Result := Result + ' And (' + nWhere + ')';
  end;

  Result := 'Select *,(Case When M_ValidDate > $Now then ''$Yes'' ' +
            'Else ''$No'' End) as M_Valid From $Mem ' + Result;
  Result := MacroValue(Result, [MI('$Now', sField_SQLServer_Now),
            MI('$Yes', sFlag_Yes), MI('$No', sFlag_No),
            MI('$Mem', sTable_Members)]);
  //xxxxx
end;

procedure TfFrameMembers.AfterInitFormData;
begin
  //FFilteDate := False;
end;

procedure TfFrameMembers.EditNamePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditName then
  begin
    EditName.Text := Trim(EditName.Text);
    if EditName.Text = '' then Exit;

    FWhere := 'M_Name like ''%%%s%%'' Or M_Py like ''%%%s%%''';
    FWhere := Format(FWhere, [EditName.Text, EditName.Text]);
    InitFormData(FWhere);
  end else

  if Sender = EditCard then
  begin
    EditCard.Text := Trim(EditCard.Text);
    if EditCard.Text = '' then Exit;

    FWhere := Format('M_Name like ''%%%s%%''', [EditCard.Text]);
    InitFormData(FWhere);
  end else

  if Sender = EditPhone then
  begin
    EditPhone.Text := Trim(EditPhone.Text);
    if EditPhone.Text = '' then Exit;

    FWhere := Format('M_Phone like ''%%%s%%''', [EditPhone.Text]);
    InitFormData(FWhere);
  end;
end;

//Desc: 日期筛选
procedure TfFrameMembers.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then
  begin
    FFilteDate := True;
    InitFormData(FWhere);
  end;
end;

procedure TfFrameMembers.BtnRefreshClick(Sender: TObject);
begin
  FFilteDate := False;
  inherited;         
end;

//------------------------------------------------------------------------------
//Desc: 添加
procedure TfFrameMembers.BtnAddClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormMembers, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

//Desc: 修改
procedure TfFrameMembers.BtnEditClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要编辑的会员', sHint); Exit;
  end;

  nParam.FCommand := cCmd_EditData;
  nParam.FParamA := SQLQuery.FieldByName('R_ID').AsString;
  CreateBaseFormItem(cFI_FormMembers, PopedomItem, @nParam);

  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    InitFormData(FWhere);
  end;
end;

//Desc: 删除
procedure TfFrameMembers.BtnDelClick(Sender: TObject);
var nStr,nAsk: string;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要删除的会员', sHint); Exit;
  end;

  nAsk := '';
  nStr := Trim(SQLQuery.FieldByName('M_Name').AsString);
  if nStr <> '' then nAsk := Format('姓名为[ %s ]', [nStr]);

  if nAsk = '' then
  begin
    nStr := Trim(SQLQuery.FieldByName('M_Phone').AsString);
    if nStr <> '' then nAsk := Format('手机号为[ %s ]', [nStr]);
  end;

  if nAsk = '' then
  begin
    nStr := Trim(SQLQuery.FieldByName('M_Card').AsString);
    if nStr <> '' then nAsk := Format('卡号为[ %s ]', [nStr]);
  end;

  if nAsk = '' then
  begin
    nStr := Trim(SQLQuery.FieldByName('M_ID').AsString);
    if nStr <> '' then nAsk := Format('编号为[ %s ]', [nStr]);
  end;

  nAsk := Format('确定要删除%s的会员吗?', [nAsk]);
  if not QueryDlg(nAsk, sAsk) then Exit;

  nStr := SQLQuery.FieldByName('R_ID').AsString;
  nStr := Format('Delete From %s Where R_ID=%s', [sTable_Members, nStr]);
  FDM.ExecuteSQL(nStr);
  
  InitFormData(FWhere);
  ShowMsg('删除成功', sHint);
end;

//Desc: 会员交费
procedure TfFrameMembers.N1Click(Sender: TObject);
var nParam: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要交费的会员', sHint); Exit;
  end;

  nParam.FCommand := cCmd_AddData;
  nParam.FParamA := SQLQuery.FieldByName('M_ID').AsString;
  CreateBaseFormItem(cFI_FormInOutMoney, PopedomItem, @nParam);

  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    InitFormData(FWhere);
  end;
end;

procedure TfFrameMembers.cxView1DblClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nParam.FCommand := cCmd_ViewData;
    nParam.FParamA := SQLQuery.FieldByName('R_ID').AsString;
    CreateBaseFormItem(cFI_FormMembers, PopedomItem, @nParam);
  end;
end;

initialization
  gControlManager.RegCtrl(TfFrameMembers, TfFrameMembers.FrameID);
end.
