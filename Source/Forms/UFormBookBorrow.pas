{*******************************************************************************
  作者: dmzn@163.com 2020-08-23
  描述: 图书借阅
*******************************************************************************}
unit UFormBookBorrow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  USysBusiness, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, ComCtrls, cxListView, ImgList;

type
  TfFormBookBorrow = class(TfFormNormal)
    dxGroup3: TdxLayoutGroup;
    EditMem: TcxLookupComboBox;
    dxlytmLayout1Item3: TdxLayoutItem;
    Label1: TcxLabel;
    dxlytmLayout1Item4: TdxLayoutItem;
    Label2: TcxLabel;
    dxlytmLayout1Item5: TdxLayoutItem;
    dxlytmLayout1Item6: TdxLayoutItem;
    Label3: TcxLabel;
    dxGroupLayout1Group2: TdxLayoutGroup;
    dxlytmLayout1Item7: TdxLayoutItem;
    Label4: TcxLabel;
    dxlytmLayout1Item8: TdxLayoutItem;
    Label5: TcxLabel;
    dxlytmLayout1Item9: TdxLayoutItem;
    Label6: TcxLabel;
    dxlytmLayout1Item10: TdxLayoutItem;
    Label7: TcxLabel;
    dxlytmLayout1Item11: TdxLayoutItem;
    Label8: TcxLabel;
    dxGroupLayout1Group3: TdxLayoutGroup;
    dxGroupLayout1Group5: TdxLayoutGroup;
    dxGroupLayout1Group6: TdxLayoutGroup;
    dxGroupLayout1Group4: TdxLayoutGroup;
    dxGroupLayout1Group7: TdxLayoutGroup;
    dxlytmLayout1Item12: TdxLayoutItem;
    Label9: TcxLabel;
    dxGroupLayout1Group8: TdxLayoutGroup;
    dxlytmLayout1Item13: TdxLayoutItem;
    Label10: TcxLabel;
    dxGroupLayout1Group9: TdxLayoutGroup;
    dxLayout1Item3: TdxLayoutItem;
    cxLabel1: TcxLabel;
    dxLayout1Item4: TdxLayoutItem;
    cxLabel2: TcxLabel;
    dxLayout1Group2: TdxLayoutGroup;
    dxLayout1Item5: TdxLayoutItem;
    cxLabel3: TcxLabel;
    dxLayout1Group3: TdxLayoutGroup;
    dxLayout1Item6: TdxLayoutItem;
    cxLabel4: TcxLabel;
    dxLayout1Group4: TdxLayoutGroup;
    EditISDN: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    dxLayout1Item8: TdxLayoutItem;
    ListBooks: TcxListView;
    dxLayout1Item9: TdxLayoutItem;
    ListDetail: TcxListView;
    dxGroup2: TdxLayoutGroup;
    cxImageList1: TcxImageList;
    EditMemo: TcxTextEdit;
    dxLayout1Item10: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditMemPropertiesEditValueChanged(Sender: TObject);
    procedure EditISDNKeyPress(Sender: TObject; var Key: Char);
    procedure ListBooksDblClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure ListDetailDblClick(Sender: TObject);
  private
    { Private declarations }
    FListA: TStrings;
    FMember: TMemberItem;
    FBookISDN: string;
    FBooks: TBooks;
    FBooksBorrow: TBooks;
    {*数据相关*}
    procedure InitFormData(const nID: string);
    procedure LoadMember(const nData: PMemberItem = nil);
    procedure LoadListViewData(const nList: TcxListView; const nBooks: TBooks);
    procedure BorrowBook(const nIdx: Integer);
    {*界面数据*}
    procedure SetLableCaption(const nHint,nText: string);
    procedure ClearLabelCaption(const nHint: string = '';
      const nCaption: string = '');
    {*标签标题*}
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UFormCtrl, UFormBase, UMgrControl, USysDB, USysConst,
  UMgrLookupAdapter, USysGrid, UDataModule;

class function TfFormBookBorrow.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else nP := nil;

  with TfFormBookBorrow.Create(Application) do
  try
    Caption := '图书 - 借阅';
    LoadMember(nil);
    InitFormData('');

    if Assigned(nP) then
    begin
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := ShowModal;
    end else ShowModal;
  finally
    Free;
  end;
end;

class function TfFormBookBorrow.FormID: integer;
begin
  Result := cFI_FormBookBorrow;
end;

procedure TfFormBookBorrow.FormCreate(Sender: TObject);
begin
  inherited;
  dxGroup1.AlignVert := avTop;
  dxGroup2.AlignVert := avTop;
  dxGroup3.AlignVert := avClient;

  FListA := TStringList.Create;
  LoadFormConfig(Self);
  LoadcxListViewConfig(Name, ListBooks);
  LoadcxListViewConfig(Name, ListDetail);
end;

procedure TfFormBookBorrow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gLookupComboBoxAdapter.DeleteGroup(Name);
  SaveFormConfig(Self);
  SavecxListViewConfig(Name, ListBooks);
  SavecxListViewConfig(Name, ListDetail);

  FreeAndNil(FListA);
  inherited;
end;

procedure TfFormBookBorrow.InitFormData(const nID: string);
var nStr,nTmp: string;
    nDStr: TDynamicStrArray;
    nItem: TLookupComboBoxItem;
begin
  BtnOK.Enabled := False;
  ActiveControl := EditMem;
  
  if not Assigned(gLookupComboBoxAdapter) then
    gLookupComboBoxAdapter := TLookupComboBoxAdapter.Create(FDM.ADOConn);
  //xxxxx

  if not Assigned(EditMem.Properties.ListSource) then
  begin
    nStr := 'Select M_ID,M_Name,M_Py,M_Card,M_Phone From %s';
    nStr := Format(nStr, [sTable_Members]);

    nTmp := Name + 'mem';
    SetLength(nDStr, 4);
    nDStr[0] := 'M_Py';
    nDStr[1] := 'M_Card';
    nDStr[2] := 'M_Phone';
    nDStr[3] := 'M_ID';

    nItem := gLookupComboBoxAdapter.MakeItem(Name, nTmp, nStr, 'M_ID', 0,
             [MI('M_ID', '编号'), MI('M_Name', '姓名'), MI('M_Py', '助记码'),
              MI('M_Card', '卡号'), MI('M_Phone', '手机号码')], nDStr);
    gLookupComboBoxAdapter.AddItem(nItem);
    gLookupComboBoxAdapter.BindItem(nTmp, EditMem);
  end;
end;

procedure TfFormBookBorrow.EditMemPropertiesEditValueChanged(Sender: TObject);
var nStr: string;
    nMems: TMembers;
begin
  if EditMem.Focused and (EditMem.Text <> '') then
  begin
    if not LoadMembers(EditMem.Text, nMems, nStr) then
    begin
      LoadMember(nil);
      Exit;
    end;

    FMember := nMems[0];
    LoadMember(@FMember);
    ActiveControl := EditISDN;
  end;
end;

procedure TfFormBookBorrow.LoadMember(const nData: PMemberItem);
var nStr: string;
begin
  if not Assigned(nData) then
  begin
    ClearLabelCaption();
    Exit;
  end;

  with nData^ do
  begin
    SetLableCaption('M_Card', FCard);
    SetLableCaption('M_Name', FName);
    SetLableCaption('M_Phone', EncodePhone(FPhone));
    SetLableCaption('M_Level', FLevel);
    SetLableCaption('M_ValidDate', DateTime2Str(FValidDate));

    nStr := '中文 %d 本,英文 %d 本';
    SetLableCaption('M_Quanyi', Format(nStr, [FMonCH, FMonEN]));

    BtnOK.Enabled := Now() < FValidDate;
    if BtnOK.Enabled then
    begin
      nStr := Format(nStr, [FMonCH-FMonCHHas, FMonEN-FMonENHas]);
      SetLableCaption('M_CanBorrow', nStr)
    end else
    begin
      SetLableCaption('M_CanBorrow', '会员已过期,无法借阅');
    end;
  end;
end;

//Desc: 根据Hint设置标题
procedure TfFormBookBorrow.SetLableCaption(const nHint, nText: string);
var nIdx: Integer;
begin
  with dxLayout1 do
  for nIdx:=ControlCount-1 downto 0 do
   if (Controls[nIdx] is TcxLabel) and
      (CompareText((Controls[nIdx] as TcxLabel).Hint, nHint) = 0) then
  begin
    (Controls[nIdx] as TcxLabel).Caption := nText;
    Break;
  end;
end;

//Desc: 清理标签标题
procedure TfFormBookBorrow.ClearLabelCaption(const nHint,nCaption: string);
var nStr: string;
    nIdx: Integer;
begin
  for nIdx:=dxLayout1.ControlCount-1 downto 0 do
  begin
    if not (dxLayout1.Controls[nIdx] is TcxLabel) then Continue;
    nStr := (dxLayout1.Controls[nIdx] as TcxLabel).Hint;
    if nStr = '' then Continue;

    if nStr = nHint then
         (dxLayout1.Controls[nIdx] as TcxLabel).Caption := nCaption
    else (dxLayout1.Controls[nIdx] as TcxLabel).Caption := '';
  end;
end;

procedure TfFormBookBorrow.EditISDNKeyPress(Sender: TObject;
  var Key: Char);
var nStr: string;
begin
  if Key = #13 then
  begin
    Key := #0;
    EditISDN.Text := Trim(EditISDN.Text);
    if EditISDN.Text = '' then
    begin
      ShowMsg('请填写ISDN码', sHint);
      Exit;
    end;

    if LoadBooks(EditISDN.Text, FBooks, nStr) then
    begin
      FBookISDN := EditISDN.Text;
      LoadListViewData(ListBooks, FBooks);

      if Length(FBooks) = 1 then
        BorrowBook(0);
      //xxxxx
    end else
    begin
      EditISDN.Text := nStr;
      LoadListViewData(ListBooks, FBooks);
    end;

    Application.ProcessMessages;
    EditISDN.SelectAll;
  end;
end;

//Desc: 载入列表数据
procedure TfFormBookBorrow.LoadListViewData(const nList: TcxListView;
  const nBooks: TBooks);
var nIdx: Integer;
begin
  nList.Items.BeginUpdate;
  try
    nList.Items.Clear;
    for nIdx:=Low(nBooks) to High(nBooks) do
     if nBooks[nIdx].FEnabled then
      with nList.Items.Add, nBooks[nIdx] do
      begin
        Data := Pointer(nIdx);
        Caption := FName;
        SubItems.Add(FBookName);
        SubItems.Add(FPublisher);
        SubItems.Add(FProvider);
        SubItems.Add(FloatToStr(FPubPrice));
        SubItems.Add(FLang);
        SubItems.Add(FClass);
        SubItems.Add(IntToStr(FNumAll - FNumOut));
      end;
  finally
    nList.Items.EndUpdate;
    if nList.Items.Count > 0 then
      nList.ItemIndex := 0;
    //xxxxx
  end;   
end;

//Desc: 借阅索引为nIdx的图书
procedure TfFormBookBorrow.BorrowBook(const nIdx: Integer);
var nInt: Integer;
begin
  if not (FBooks[nIdx].FValid and FBooks[nIdx].FBookValid)then
  begin
    EditISDN.Text := '管理员已禁止借阅此书';
    Exit;
  end;

  EditISDN.Text := FBookISDN;
  EditISDN.SelectAll;
  ActiveControl := EditISDN;

  if FBooks[nIdx].FNumIn < 1 then
  begin
    ShowMsg('库存不足', sHint);
    Exit;
  end;
  
  for nInt:=Low(FBooksBorrow) to High(FBooksBorrow) do
   with FBooksBorrow[nInt] do
    if FEnabled and (FRecord = FBooks[nIdx].FRecord) then
    begin
      ShowMsg('已借阅', sHint);
      Exit;
    end;

  nInt := Length(FBooksBorrow);
  SetLength(FBooksBorrow, nInt + 1);
  FBooksBorrow[nInt] := FBooks[nIdx];
  LoadListViewData(ListDetail, FBooksBorrow);
end;

procedure TfFormBookBorrow.ListBooksDblClick(Sender: TObject);
var nIdx: Integer;
begin
  if not Assigned(ListBooks.Selected) then Exit;
  nIdx := Integer(ListBooks.Selected.Data);
  BorrowBook(nIdx);
end;

procedure TfFormBookBorrow.ListDetailDblClick(Sender: TObject);
var nIdx: Integer;
begin
  if not Assigned(ListDetail.Selected) then Exit;
  nIdx := Integer(ListDetail.Selected.Data);
  
  FBooksBorrow[nIdx].FEnabled := False;
  LoadListViewData(ListDetail, FBooksBorrow);
end;

procedure TfFormBookBorrow.BtnOKClick(Sender: TObject);
var nStr: string;
    nIdx,nInt: Integer;
    nCN,nEN,nAll: Integer;
begin
  if ListDetail.Items.Count < 1 then
  begin
    ShowMsg('请先添加图书', sHint);
    Exit;
  end;

  nCN := 0;
  nEN := 0;
  nAll := 0;

  for nIdx:=Low(FBooksBorrow) to High(FBooksBorrow) do
  with FBooksBorrow[nIdx] do
  begin
    if not FEnabled then Continue;
    //invalid

    Inc(nAll);
    if FLang = sFlag_Language_CN then Inc(nCN);
    if FLang = sFlag_Language_EN then Inc(nEN);
  end;

  with FMember do
  begin
    nInt := nCN + FMonCHHas - FMonCH;
    if nInt > 0 then
    begin
      nStr := '中文图书超出可借阅 %d 本,请减少借阅.';
      nStr := Format(nStr, [nInt]);

      ShowDlg(nStr, sWarn);
      Exit;
    end;

    nInt := nEN + FMonENHas - FMonEN;
    if nInt > 0 then
    begin
      nStr := '英文图书超出可借阅 %d 本,请减少借阅.';
      nStr := Format(nStr, [nInt]);

      ShowDlg(nStr, sWarn);
      Exit;
    end;
  end; 

  FDM.ADOConn.BeginTrans;
  try
    FListA.Clear;
    //档案列表

    for nIdx:=Low(FBooksBorrow) to High(FBooksBorrow) do
    with FBooksBorrow[nIdx] do
    begin
      if not FEnabled then Continue;
      //invalid

      nStr := MakeSQLByStr([SF('B_Member', FMember.FMID),
          SF('B_Book', FBookID),
          SF('B_BookDtl', FDetailID),
          SF('B_Type', sFlag_Out),
          SF('B_NumBorrow', 1, sfVal),
          SF('B_NumReturn', 0, sfVal),
          SF('B_Man', gSysParam.FUserID),
          SF('B_Date', sField_SQLServer_Now, sfVal),
          SF('B_Memo', EditMemo.Text)
        ], sTable_BookBorrow, '', True);
      FDM.ExecuteSQL(nStr); //0.借阅记录

      nStr := 'Update %s Set D_NumIn=D_NumIn-1,D_NumOut=D_NumOut+1 ' +
              'Where R_ID=%s';
      nStr := Format(nStr, [sTable_BookDetail, FRecord]);
      FDM.ExecuteSQL(nStr); //1.增加借阅量

      if FListA.IndexOf(FBookID) < 0 then
        FListA.Add(FBookID);
      //2.待同步库存
    end;

    for nIdx:=FListA.Count-1 downto 0 do
      SyncBookNumber(FListA[nIdx]);
    //2.同步库存量

    nStr := 'Update %s Set ' +
            'M_BorrowNum=M_BorrowNum+1,M_BorrowBooks=M_BorrowBooks+%d,' +
            'M_MonCHHas=M_MonCHHas+%d,M_MonENHas=M_MonENHas+%d ' +
            'Where M_ID=''%s''';
    nStr := Format(nStr, [sTable_Members, nAll, nCN, nEN, FMember.FMID]);
    FDM.ExecuteSQL(nStr); //3.增加会员信息计数

    FDM.ADOConn.CommitTrans;
    ModalResult := mrOk;
  except
    on nErr: Exception do
    begin
      FDM.ADOConn.RollbackTrans;
      ShowDlg(nErr.Message, sError);
    end;
  end;  
end;

initialization
  gControlManager.RegCtrl(TfFormBookBorrow, TfFormBookBorrow.FormID);
end.
