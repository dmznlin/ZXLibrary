{*******************************************************************************
  作者: dmzn@163.com 2020-08-17
  描述: 图书管理
*******************************************************************************}
unit UFrameBooks;

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
  TfFrameBooks = class(TfFrameNormal)
    Edit1: TcxTextEdit;
    dxLayout1Item2: TdxLayoutItem;
    Edit2: TcxTextEdit;
    dxLayout1Item3: TdxLayoutItem;
    EditName: TcxButtonEdit;
    dxLayout1Item4: TdxLayoutItem;
    Edit4: TcxTextEdit;
    dxLayout1Item5: TdxLayoutItem;
    dxLayout1Item1: TdxLayoutItem;
    EditPublisher: TcxButtonEdit;
    dxLayout1Item6: TdxLayoutItem;
    EditAuthor: TcxButtonEdit;
    dxLayout1Item7: TdxLayoutItem;
    EditDate: TcxButtonEdit;
    dxLayout1Item8: TdxLayoutItem;
    Edit3: TcxTextEdit;
    QueryDtl: TADOQuery;
    DataSource2: TDataSource;
    cxLevel2: TcxGridLevel;
    cxView2: TcxGridDBTableView;
    PMenu1: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    procedure EditNamePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnRefreshClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure PMenu1Popup(Sender: TObject);
  private
    { Private declarations }
    FStart,FEnd: TDate;
    //时间区间
    FFilteDate: Boolean;
    //筛选日期
    FWhereDtl: string;
    FQueryDtl: Boolean;
    //查询条件
  public
    { Public declarations }
    class function FrameID: integer; override;
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    procedure OnLoadGridConfig(const nIni: TIniFile); override;
    procedure OnSaveGridConfig(const nIni: TIniFile); override;
    {*基类函数*}                                               
    procedure QueryDetail(const nWhere: string);
    procedure OnInitFormData(var nDefault: Boolean; const nWhere: string = '';
     const nQuery: TADOQuery = nil); override;
     procedure AfterInitFormData; override;
    {*查询SQL*}
  end;

implementation

{$R *.dfm}

uses
  ULibFun, UMgrControl, USysDataDict, USysConst, USysDB, USysPopedom, USysGrid, 
  USysBusiness, UDataModule, UFormBase, UFormDateFilter;

class function TfFrameBooks.FrameID: integer;
begin
  Result := cFI_FrameBooks;
end;

procedure TfFrameBooks.OnCreateFrame;
begin
  inherited;
  FWhere := '';
  FWhereDtl := '';

  FQueryDtl := True;  
  FFilteDate := False;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFrameBooks.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

procedure TfFrameBooks.OnLoadGridConfig(const nIni: TIniFile);
begin
  if BtnAdd.Enabled then
       BtnAdd.Tag := 10
  else BtnAdd.Tag := 0;

  if BtnEdit.Enabled then
       BtnEdit.Tag := 10
  else BtnEdit.Tag := 0;

  if BtnDel.Enabled then
       BtnDel.Tag := 10
  else BtnDel.Tag := 0;

  cxGrid1.ActiveLevel := cxLevel1;
  gSysEntityManager.BuildViewColumn(cxView2, 'MAIN_BookDtl');
  InitTableView(Name, cxView2, nIni);
end;

procedure TfFrameBooks.OnSaveGridConfig(const nIni: TIniFile);
begin
  SaveUserDefineTableView(Name, cxView2, nIni);
end;

procedure TfFrameBooks.OnInitFormData(var nDefault: Boolean;
  const nWhere: string; const nQuery: TADOQuery);
var nStr,nSQL: string;
begin
  nDefault := False;
  //user define

  nSQL := 'Select * From ' + sTable_Books;
  //xxxxx

  if FFilteDate then //筛选日期
  begin
    nStr := ' Where (B_Date>=''%s'' and B_Date <''%s'')';
    nSQL := nSQL + Format(nStr, [Date2Str(FStart), Date2Str(FEnd+1)]);
  end;

  if FWhere <> '' then //筛选条件
  begin
    if FFilteDate then
         nSQL := nSQL + ' And (' + FWhere + ')'
    else nSQL := nSQL + ' Where (' + FWhere + ')';
  end;

  FDM.QueryData(SQLQuery, nSQL);
  if FQueryDtl then
    QueryDetail(FWhereDtl);
  //xxxxx
end;

//Desc: 查询明细
procedure TfFrameBooks.QueryDetail(const nWhere: string);
var nStr,nSQL: string;
begin
  EditDate.Text := Format('%s 至 %s', [Date2Str(FStart), Date2Str(FEnd)]);

  nSQL := 'Select dtl.*,B_Name,B_Author From %s dtl' +
          ' Left Join %s b On b.B_ID=dtl.D_Book';
  nSQL := Format(nSQL, [sTable_BookDetail, sTable_Books]);

  if FFilteDate then //筛选日期
  begin
    nStr := ' Where (D_Date>=''%s'' and D_Date <''%s'')';
    nSQL := nSQL + Format(nStr, [Date2Str(FStart), Date2Str(FEnd+1)]);
  end;

  if FWhereDtl <> '' then //筛选条件
  begin
    if FFilteDate then
         nSQL := nSQL + ' And (' + FWhereDtl + ')'
    else nSQL := nSQL + ' Where (' + FWhereDtl + ')';
  end;

  FDM.QueryData(QueryDtl, nSQL)
end;

procedure TfFrameBooks.AfterInitFormData;
begin
  FQueryDtl := True;
end;

procedure TfFrameBooks.EditNamePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditName then
  begin
    EditName.Text := Trim(EditName.Text);
    if EditName.Text = '' then Exit;

    FWhere := 'B_Name like ''%%%s%%'' Or B_Py like ''%%%s%%''';
    FWhere := Format(FWhere, [EditName.Text, EditName.Text]);

    FWhereDtl := 'D_Name like ''%%%s%%'' Or D_Py like ''%%%s%%''';
    FWhereDtl := Format(FWhereDtl, [EditName.Text, EditName.Text]);

    FFilteDate := False;
    InitFormData;
  end else

  if Sender = EditAuthor then
  begin
    EditAuthor.Text := Trim(EditAuthor.Text);
    if EditAuthor.Text = '' then Exit;

    FWhere := Format('B_Author like ''%%%s%%''', [EditAuthor.Text]);
    FWhereDtl := FWhere;

    FFilteDate := False;
    InitFormData;
  end else

  if Sender = EditPublisher then
  begin
    EditPublisher.Text := Trim(EditPublisher.Text);
    if EditPublisher.Text = '' then Exit;

    FWhere := 'B_ID In (Select D_Book From %s Where D_Publisher like ''%%%s%%'')';
    FWhere := Format(FWhere, [sTable_BookDetail, EditPublisher.Text]);
    FWhereDtl := Format('D_Publisher like ''%%%s%%''', [EditPublisher.Text]);

    FFilteDate := False;
    InitFormData;
  end;
end;

//Desc: 日期筛选
procedure TfFrameBooks.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then
  begin
    FFilteDate := True;
    InitFormData(FWhere);
  end;
end;

procedure TfFrameBooks.BtnRefreshClick(Sender: TObject);
begin
  FWhere := '';
  FWhereDtl := '';
  FFilteDate := False;
  inherited;
end;

//------------------------------------------------------------------------------
//Desc: 添加
procedure TfFrameBooks.BtnAddClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormBooks, PopedomItem, @nParam);
  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    if FFilteDate then
      FFilteDate := (Date() >= FStart) and (Date() < FEnd + 1);
    InitFormData('');
  end;
end;

//Desc: 修改
procedure TfFrameBooks.BtnEditClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要编辑的图书', sHint); Exit;
  end;

  nParam.FCommand := cCmd_EditData;
  nParam.FParamA := SQLQuery.FieldByName('R_ID').AsString;
  CreateBaseFormItem(cFI_FormBooks, PopedomItem, @nParam);

  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    InitFormData(FWhere);
  end;
end;

//Desc: 删除
procedure TfFrameBooks.BtnDelClick(Sender: TObject);
var nStr,nAsk: string;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要删除的图书', sHint); Exit;
  end;

  nAsk := Format('确定要删除%s的会员吗?', [nAsk]);
  if not QueryDlg(nAsk, sAsk) then Exit;

  nStr := SQLQuery.FieldByName('R_ID').AsString;
  nStr := Format('Delete From %s Where R_ID=%s', [sTable_Books, nStr]);
  FDM.ExecuteSQL(nStr);
  
  InitFormData(FWhere);
  ShowMsg('删除成功', sHint);
end;

//------------------------------------------------------------------------------
procedure TfFrameBooks.PMenu1Popup(Sender: TObject);
var nIdx: Integer;
begin
  for nIdx := PMenu1.Items.Count-1 downto 0 do
  begin
    PMenu1.Items[nIdx].Enabled := cxView1.DataController.GetSelectedCount > 0;
  end;
end;

//Desc: 查看明细
procedure TfFrameBooks.N3Click(Sender: TObject);
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    FWhereDtl := 'D_Book=''%s''';
    FWhereDtl := Format(FWhereDtl, [SQLQuery.FieldByName('B_ID').AsString]);
    FFilteDate := False;

    QueryDetail('');
    if (QueryDtl.Active) and (QueryDtl.RecordCount > 0) then
      cxGrid1.ActiveLevel := cxLevel2;
    //xxxxx
  end;
end;

//Desc: 禁止借阅
procedure TfFrameBooks.N5Click(Sender: TObject);
var nStr,nValid: string;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    if TComponent(Sender).Tag = 20 then
         nValid := sFlag_No
    else nValid := sFlag_Yes;

    nStr := 'Update %s Set B_Valid=''%s'' Where R_ID=%s';
    nStr := Format(nStr, [sTable_Books, nValid,
            SQLQuery.FieldByName('R_ID').AsString]);
    FDM.ExecuteSQL(nStr);

    FQueryDtl := False;
    InitFormData(FWhere);
  end;
end;

initialization
  gControlManager.RegCtrl(TfFrameBooks, TfFrameBooks.FrameID);
end.
