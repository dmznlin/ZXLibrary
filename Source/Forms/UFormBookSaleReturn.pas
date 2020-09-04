{*******************************************************************************
  作者: dmzn@163.com 2020-09-04
  描述: 图书销售退回
*******************************************************************************}
unit UFormBookSaleReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  USysBusiness, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, ComCtrls, cxListView, ImgList;

type
  TfFormBookSaleReturn = class(TfFormNormal)
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
    EditISDN: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    dxLayout1Item8: TdxLayoutItem;
    ListBooks: TcxListView;
    dxLayout1Item9: TdxLayoutItem;
    ListDetail: TcxListView;
    dxGroup2: TdxLayoutGroup;
    cxImageList1: TcxImageList;
    dxLayout1Item11: TdxLayoutItem;
    EditMemo: TcxMemo;
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
    FBooksReturn: TBooks;
    {*数据相关*}
    procedure InitFormData(const nID: string);
    procedure LoadMember(const nData: PMemberItem = nil);
    procedure LoadListViewData(const nList: TcxListView; const nBooks: TBooks);
    procedure ReturnBook(const nIdx: Integer);
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

class function TfFormBookSaleReturn.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else nP := nil;

  with TfFormBookSaleReturn.Create(Application) do
  try
    Caption := '图书 - 退回';
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

class function TfFormBookSaleReturn.FormID: integer;
begin
  Result := cFI_FormBookSaleReturn;
end;

procedure TfFormBookSaleReturn.FormCreate(Sender: TObject);
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

procedure TfFormBookSaleReturn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gLookupComboBoxAdapter.DeleteGroup(Name);
  SaveFormConfig(Self);
  SavecxListViewConfig(Name, ListBooks);
  SavecxListViewConfig(Name, ListDetail);

  FreeAndNil(FListA);
  inherited;
end;

procedure TfFormBookSaleReturn.InitFormData(const nID: string);
var nStr,nTmp: string;
    nDStr: TDynamicStrArray;
    nItem: TLookupComboBoxItem;
begin
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

procedure TfFormBookSaleReturn.EditMemPropertiesEditValueChanged(Sender: TObject);
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

procedure TfFormBookSaleReturn.LoadMember(const nData: PMemberItem);
var nStr: string;
begin
  BtnOK.Enabled := Assigned(nData);
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

    nStr := '购买 %d 次,共计 %d 本';
    SetLableCaption('M_Total', Format(nStr, [FBuyNum, FBuyBooks]));
  end;
end;

//Desc: 根据Hint设置标题
procedure TfFormBookSaleReturn.SetLableCaption(const nHint, nText: string);
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
procedure TfFormBookSaleReturn.ClearLabelCaption(const nHint,nCaption: string);
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

procedure TfFormBookSaleReturn.EditISDNKeyPress(Sender: TObject;
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

    if LoadBooksSale(FMember.FMID, EditISDN.Text, FBooks, nStr) then
    begin
      FBookISDN := EditISDN.Text;
      LoadListViewData(ListBooks, FBooks);

      if Length(FBooks) = 1 then
        ReturnBook(0);
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
procedure TfFormBookSaleReturn.LoadListViewData(const nList: TcxListView;
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

        if nList = ListDetail then
             SubItems.Add(IntToStr(FSaleReturn))
        else SubItems.Add(IntToStr(FSaleNum - FSaleReturn));
      end;
  finally
    nList.Items.EndUpdate;
    if nList.Items.Count > 0 then
      nList.ItemIndex := 0;
    //xxxxx
  end;   
end;

//Desc: 退回索引为nIdx的图书
procedure TfFormBookSaleReturn.ReturnBook(const nIdx: Integer);
var nInt: Integer;

  procedure RefreshBookList;
  begin
    with FBooks[nIdx] do
    begin
      Inc(FSaleReturn);
      FEnabled := FSaleNum > FSaleReturn;
      LoadListViewData(ListBooks, FBooks);
    end;
  end;  
begin
  EditISDN.Text := FBookISDN;
  EditISDN.SelectAll;
  ActiveControl := EditISDN;

  for nInt:=Low(FBooksReturn) to High(FBooksReturn) do
   with FBooksReturn[nInt] do
    if FEnabled and (FRecord = FBooks[nIdx].FRecord) then
    begin
      Inc(FSaleReturn);
      LoadListViewData(ListDetail, FBooksReturn);
      RefreshBookList;
      
      ShowMsg('成功退回 1 本', sHint);
      Exit;
    end;

  nInt := Length(FBooksReturn);
  SetLength(FBooksReturn, nInt + 1);
  FBooksReturn[nInt] := FBooks[nIdx];

  FBooksReturn[nInt].FSaleReturn := 1;
  LoadListViewData(ListDetail, FBooksReturn);
  RefreshBookList;
end;

procedure TfFormBookSaleReturn.ListBooksDblClick(Sender: TObject);
var nIdx: Integer;
begin
  if not Assigned(ListBooks.Selected) then Exit;
  nIdx := Integer(ListBooks.Selected.Data);
  ReturnBook(nIdx);
end;

procedure TfFormBookSaleReturn.ListDetailDblClick(Sender: TObject);
var nStr: string;
    nIdx: Integer;
begin
  if not Assigned(ListDetail.Selected) then Exit;
  nIdx := Integer(ListDetail.Selected.Data);
  
  with FBooksReturn[nIdx] do
  begin
    Dec(FSaleReturn);
    if FSaleReturn < 1 then
         FEnabled := False
    else ShowMsg('已取消 1 本', sHint);

    LoadListViewData(ListDetail, FBooksReturn);
    nStr := FRecord;
  end;

  for nIdx:=Low(FBooks) to High(FBooks) do
   with FBooks[nIdx] do
    if FRecord = nStr then
    begin
      Dec(FSaleReturn);
      FEnabled := FSaleNum > FSaleReturn;
      LoadListViewData(ListBooks, FBooks);
    end;
end;

procedure TfFormBookSaleReturn.BtnOKClick(Sender: TObject);
var nStr: string;
    nIdx,nAll: Integer;
    nMoney: Double;
    nParam: TFormCommandParam;
begin
  if ListDetail.Items.Count < 1 then
  begin
    ShowMsg('请先添加图书', sHint);
    Exit;
  end;

  nMoney := 0;
  nAll := 0;
  //init

  for nIdx:=Low(FBooksReturn) to High(FBooksReturn) do
  with FBooksReturn[nIdx] do
  begin
    if not FEnabled then Continue;
    //invalid

     nAll := nAll + FSaleReturn;
     //累计数量

     nMoney := nMoney + FPubPrice * FNumNow;
     //累计金额
  end;

  nParam.FCommand := cCmd_AddData;
  nParam.FParamA := FMember.FMID;
  nParam.FParamB := Float2Float(nMoney, cPrecision, False);
  nParam.FParamC := sFlag_Yes;
  nParam.FParamD := Format('销售退回 %d 本,总金额 %.2f元', [nAll, nMoney]);
  CreateBaseFormItem(cFI_FormInOutMoney, PopedomItem, @nParam);

  if (nParam.FCommand <> cCmd_ModalResult) or (nParam.FParamA <> mrOK) then
    Exit;
  //取消付款

  FDM.ADOConn.BeginTrans;
  try

    FListA.Clear;
    //init

    for nIdx:=Low(FBooksReturn) to High(FBooksReturn) do
    with FBooksReturn[nIdx] do
    begin
      if not FEnabled then Continue;
      //invalid

      nStr := MakeSQLByStr([SF('S_Member', FMember.FMID),
          SF('S_Book', FBookID),
          SF('S_BookDtl', FDetailID),
          SF('S_Type', sFlag_In),
          SF('S_Num', FSaleReturn * (-1), sfVal),
          SF('S_Return', 0, sfVal),
          SF('S_Man', gSysParam.FUserID),
          SF('S_Date', sField_SQLServer_Now, sfVal),
          SF('S_Memo', EditMemo.Text)
        ], sTable_BookSale, '', True);
      FDM.ExecuteSQL(nStr); //0.退回记录

      nStr := 'Update %s Set S_Return=S_Return+%d Where R_ID=%s';
      nStr := Format(nStr, [sTable_BookSale, FSaleReturn, FSaleID]);
      FDM.ExecuteSQL(nStr); //1.更新原购买记录

      nStr := 'Update $BD Set D_NumAll=D_NumAll+$Num,D_NumIn=D_NumIn+$Num,' +
              'D_NumSale=D_NumSale-$Num Where R_ID=$RD';
      nStr := MacroValue(nStr, [MI('$BD', sTable_BookDetail),
              MI('$RD', FRecord), MI('$Num', IntToStr(FSaleReturn))]);
      FDM.ExecuteSQL(nStr); //2.减少售出量

      if FListA.IndexOf(FBookID) < 0 then
        FListA.Add(FBookID);
      //2.待同步库存
    end;

    for nIdx:=FListA.Count-1 downto 0 do
      SyncBookNumber(FListA[nIdx]);
    //2.同步库存量

    nStr := 'Update %s Set M_BuyBooks=M_BuyBooks-%d Where M_ID=''%s''';
    nStr := Format(nStr, [sTable_Members, nAll, FMember.FMID]);
    FDM.ExecuteSQL(nStr); //3.减少会员信息计数

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
  gControlManager.RegCtrl(TfFormBookSaleReturn, TfFormBookSaleReturn.FormID);
end.
