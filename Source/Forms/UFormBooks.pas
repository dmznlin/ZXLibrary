{*******************************************************************************
  作者: dmzn@163.com 2020-08-17
  描述: 图书档案
*******************************************************************************}
unit UFormBooks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  USysBusiness, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxRadioGroup, cxCalendar,
  cxGroupBox, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, ComCtrls,
  cxListView, Menus, cxButtons, ImgList;

type
  TfFormBooks = class(TfFormNormal)
    EditISBN: TcxTextEdit;
    dxLayout1Item4: TdxLayoutItem;
    EditName: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    dxLayout1Item17: TdxLayoutItem;
    Check1: TcxCheckBox;
    dxLayout1Item5: TdxLayoutItem;
    EditClass: TcxComboBox;
    dxLayout1Item6: TdxLayoutItem;
    EditLang: TcxComboBox;
    dxLayout1Item8: TdxLayoutItem;
    EditMemo: TcxMemo;
    EditAuthor: TcxLookupComboBox;
    dxLayout1Item12: TdxLayoutItem;
    dxLayout1Group3: TdxLayoutGroup;
    dxGroup2: TdxLayoutGroup;
    EditDISBN: TcxTextEdit;
    dxLayout1Item3: TdxLayoutItem;
    EditDName: TcxTextEdit;
    dxLayout1Item13: TdxLayoutItem;
    dxLayout1Group2: TdxLayoutGroup;
    dxLayout1Group5: TdxLayoutGroup;
    EditPubPrice: TcxTextEdit;
    dxLayout1Item16: TdxLayoutItem;
    EditGetPrice: TcxTextEdit;
    dxLayout1Item18: TdxLayoutItem;
    EditSalePrice: TcxTextEdit;
    dxLayout1Item19: TdxLayoutItem;
    dxLayout1Group7: TdxLayoutGroup;
    cxLabel2: TcxLabel;
    dxLayout1Item20: TdxLayoutItem;
    dxLayout1Item21: TdxLayoutItem;
    EditNumOut: TcxTextEdit;
    dxLayout1Item22: TdxLayoutItem;
    EditNumAll: TcxTextEdit;
    dxLayout1Item23: TdxLayoutItem;
    EditNumIn: TcxTextEdit;
    dxLayout1Group9: TdxLayoutGroup;
    dxLayout1Group10: TdxLayoutGroup;
    ListDetail: TcxListView;
    dxLayout1Item24: TdxLayoutItem;
    dxLayout1Item25: TdxLayoutItem;
    EditProvider: TcxLookupComboBox;
    dxLayout1Item26: TdxLayoutItem;
    EditPublisher: TcxLookupComboBox;
    dxLayout1Group11: TdxLayoutGroup;
    dxLayout1Group6: TdxLayoutGroup;
    dxLayout1Item14: TdxLayoutItem;
    cxLabel3: TcxLabel;
    dxLayout1Item15: TdxLayoutItem;
    RadioNormal: TcxRadioButton;
    dxLayout1Item27: TdxLayoutItem;
    RadioForbid: TcxRadioButton;
    dxLayout1Group8: TdxLayoutGroup;
    dxLayout1Group12: TdxLayoutGroup;
    BtnDel: TcxButton;
    dxLayout1Item29: TdxLayoutItem;
    dxLayout1Item30: TdxLayoutItem;
    cxLabel4: TcxLabel;
    dxLayout1Group13: TdxLayoutGroup;
    cxImageList1: TcxImageList;
    dxLayout1Item9: TdxLayoutItem;
    BtnAdd: TcxButton;
    EditDMemo: TcxTextEdit;
    dxLayout1Item10: TdxLayoutItem;
    dxLayout1Item11: TdxLayoutItem;
    BtnEdit: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure ListDetailDblClick(Sender: TObject);
    procedure EditDNameKeyPress(Sender: TObject; var Key: Char);
    procedure EditDISBNKeyPress(Sender: TObject; var Key: Char);
    procedure EditISBNKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FRecordID: string;
    FBookID: string;
    {*图书编号*}
    FBooks: array of TBookItem;
    {*图书明细*}
    FListA: TStrings;
    FSaveResult: Integer;
    procedure ResetFormData;
    procedure InitFormData(const nID: string);
    procedure LoadBookDetail;
    {*界面数据*}
    function SaveBook(var nBookID: string): Boolean;
    function SaveBookDetail(const nBookID: string): Boolean;
    {*保存数据*}
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
    function OnVerifyCtrl(Sender: TObject; var nHint: string): Boolean; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UFormCtrl, UFormBase, UMgrControl, UMgrLookupAdapter, UDataModule,
  USysGrid, USysDB, USysConst;

class function TfFormBooks.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  case nP.FCommand of
   cCmd_AddData:
    with TfFormBooks.Create(Application) do
    begin
      Caption := '添加图书';
      InitFormData('');
      ShowModal;
      
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := FSaveResult;
      Free;
    end;
   cCmd_EditData:
    with TfFormBooks.Create(Application) do
    begin
      Caption := '修改图书';
      FRecordID := nP.FParamA;
      InitFormData(FRecordID);

      ShowModal;
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := FSaveResult;
      Free;
    end;
   cCmd_ViewData:
    with TfFormBooks.Create(Application) do
    begin
      Caption := '图书信息';
      BtnOK.Enabled := False;
      FRecordID := nP.FParamA;
      
      InitFormData(FRecordID);
      ShowModal;
      Free;
    end;
  end;
end;

class function TfFormBooks.FormID: integer;
begin
  Result := cFI_FormBooks;
end;

procedure TfFormBooks.FormCreate(Sender: TObject);
begin
  inherited;
  FBookID := '';
  FRecordID := '';
  FListA := TStringList.Create;

  LoadFormConfig(Self);
  LoadcxListViewConfig(Name, ListDetail);
end;

procedure TfFormBooks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gLookupComboBoxAdapter.DeleteGroup(Name);
  SaveFormConfig(Self);
  SavecxListViewConfig(Name, ListDetail);

  FreeAndNil(FListA);
  inherited;
end;

procedure TfFormBooks.InitFormData(const nID: string);
var nStr,nTmp: string;
    nIdx: Integer;
    nDefault: TBaseDataItem;
    nDStr: TDynamicStrArray;
    nItem: TLookupComboBoxItem;
begin
  ResetFormData;
  dxGroup1.AlignVert := avTop;
  dxGroup2.AlignVert := avClient;
  
  if EditClass.Properties.Items.Count < 1 then
  begin
    LoadBaseDataList(EditClass.Properties.Items, sFlag_Base_BookClass, @nDefault);
    EditClass.ItemIndex := EditClass.Properties.Items.IndexOf(nDefault.FName);
  end;

  if EditLang.Properties.Items.Count < 1 then
  begin
    LoadBaseDataList(EditLang.Properties.Items, sFlag_Base_Lanuage, @nDefault);
    EditLang.ItemIndex := EditLang.Properties.Items.IndexOf(nDefault.FName);
  end;

  if not Assigned(gLookupComboBoxAdapter) then
    gLookupComboBoxAdapter := TLookupComboBoxAdapter.Create(FDM.ADOConn);
  //xxxxx

  if not Assigned(EditAuthor.Properties.ListSource) then
  begin
    nStr := 'Select B_Text,B_Py From %s Where B_Group=''%s''';
    nStr := Format(nStr, [sTable_BaseInfo, sFlag_Base_Author]);

    nTmp := Name + 'AT';
    SetLength(nDStr, 1);
    nDStr[0] := 'B_Py';

    nItem := gLookupComboBoxAdapter.MakeItem(Name, nTmp, nStr, 'B_Text', 0,
             [MI('B_Text', '姓名'), MI('B_Py', '助记码')], nDStr);
    gLookupComboBoxAdapter.AddItem(nItem);
    gLookupComboBoxAdapter.BindItem(nTmp, EditAuthor);
  end;

  if not Assigned(EditPublisher.Properties.ListSource) then
  begin
    nStr := 'Select B_Text,B_Py From %s Where B_Group=''%s''';
    nStr := Format(nStr, [sTable_BaseInfo, sFlag_Base_Publish]);

    nTmp := Name + 'PB';
    SetLength(nDStr, 1);
    nDStr[0] := 'B_Py';

    nItem := gLookupComboBoxAdapter.MakeItem(Name, nTmp, nStr, 'B_Text', 0,
             [MI('B_Text', '名称'), MI('B_Py', '助记码')], nDStr);
    gLookupComboBoxAdapter.AddItem(nItem);
    gLookupComboBoxAdapter.BindItem(nTmp, EditPublisher);
  end;

  if not Assigned(EditProvider.Properties.ListSource) then
  begin
    nStr := 'Select B_Text,B_Py From %s Where B_Group=''%s''';
    nStr := Format(nStr, [sTable_BaseInfo, sFlag_Base_Provide]);

    nTmp := Name + 'PV';
    SetLength(nDStr, 1);
    nDStr[0] := 'B_Py';

    nItem := gLookupComboBoxAdapter.MakeItem(Name, nTmp, nStr, 'B_Text', 0,
             [MI('B_Text', '名称'), MI('B_Py', '助记码')], nDStr);
    gLookupComboBoxAdapter.AddItem(nItem);
    gLookupComboBoxAdapter.BindItem(nTmp, EditProvider);
  end;

  //---------------------------------------------------------------------------
  if nID <> '' then
  begin
    Check1.Checked := False;
    Check1.Visible := False;
    //关闭连续操作

    nStr :='Select * From %s Where R_ID=''%s''';
    nStr := Format(nStr, [sTable_Books, nID]);
    with FDM.QueryTemp(nStr) do
    begin
      if RecordCount < 1 then
      begin
        BtnOK.Enabled := False;
        ShowMsg('会员档案已丢失', sHint); Exit;
      end;

      EditISBN.Text := FieldByName('B_ISBN').AsString;
      EditName.Text := FieldByName('B_Name').AsString;
      EditAuthor.Text := FieldByName('B_Author').AsString;
      EditClass.Text := FieldByName('B_Class').AsString;
      EditLang.Text := FieldByName('B_Lang').AsString;
      EditMemo.Text := FieldByName('B_Memo').AsString;

      if FieldByName('B_Valid').AsString = sFlag_Yes then
           RadioNormal.Checked := True
      else RadioForbid.Checked := True;

      FBookID := FieldByName('B_ID').AsString;
      //档案编号
    end;

    //-------------------------------------------------------------------------
    SetLength(FBooks, 0);
    nStr := 'Select * From %s Where D_Book=''%s''';
    nStr := Format(nStr, [sTable_BookDetail, FBookID]);

    with FDM.QueryTemp(nStr) do
    if RecordCount > 0 then
    begin
      SetLength(FBooks, RecordCount);
      nIdx := 0;
      First;

      while not Eof do
      begin
        with FBooks[nIdx] do
        begin
          FRecord      := FieldByName('R_ID').AsString;
          FISBN        := FieldByName('D_ISBN').AsString;
          FName        := FieldByName('D_Name').AsString;
          FPublisher   := FieldByName('D_Publisher').AsString;
          FProvider    := FieldByName('D_Provider').AsString;
          FPubPrice    := FieldByName('D_PubPrice').AsFloat;
          FGetPrice    := FieldByName('D_GetPrice').AsFloat;
          FSalePrice   := FieldByName('D_SalePrice').AsFloat;
          FNumAll      := FieldByName('D_NumAll').AsInteger;
          FNumIn       := FieldByName('D_NumIn').AsInteger;
          FNumOut      := FieldByName('D_NumOut').AsInteger;
          FValid       := FieldByName('D_Valid').AsString = sFlag_Yes;
          FMemo        := FieldByName('D_Memo').AsString;
          FStatus      := bsNone;
        end;

        Inc(nIdx);
        Next;
      end;
    end;

    LoadBookDetail;
    //载入明细
  end;
end;

procedure TfFormBooks.ResetFormData;
begin
  EditISBN.Text := '';
  EditName.Text := '';
  ActiveControl := EditISBN;

  EditDISBN.Text := '';
  EditDName.Text := '';

  EditNumAll.Text := '0';
  EditNumIn.Text := '0';
  EditNumOut.Text := '0';

  if not IsNumber(EditPubPrice.Text, True) then EditPubPrice.Text := '0';
  if not IsNumber(EditGetPrice.Text, True) then EditGetPrice.Text := '0';
  if not IsNumber(EditSalePrice.Text, True) then EditSalePrice.Text := '0';

  RadioNormal.Checked := True;
  SetLength(FBooks, 0);
  LoadBookDetail;
end;

procedure TfFormBooks.LoadBookDetail;
var nIdx,nSelected: Integer;
begin
  with ListDetail do
  try
    if Assigned(Selected) then
         nSelected := Integer(Selected.Data)
    else nSelected := -1;

    Items.BeginUpdate;
    Items.Clear;

    for nIdx:=Low(FBooks) to High(FBooks) do
     if FBooks[nIdx].FStatus <> bsDel then
      with Items.Add, FBooks[nIdx] do
      begin
        Caption := FISBN;
        SubItems.Add(FName);
        SubItems.Add(FPublisher);
        SubItems.Add(FProvider);
        SubItems.Add(Format('%.2f', [FPubPrice]));
        SubItems.Add(IntToStr(FNumAll));

        if FValid then
             SubItems.Add('正常')
        else SubItems.Add('禁止');

        Data := Pointer(nIdx);
        if nIdx = nSelected then
          Selected := True;
        //xxxxx
      end;
  finally
    ListDetail.Items.EndUpdate;
  end;
end;

//Desc: 添加明细
procedure TfFormBooks.BtnAddClick(Sender: TObject);
var nIdx: Integer;
    nIsEdit: Boolean;
begin
  nIsEdit := Sender = BtnEdit;
  if nIsEdit and (not Assigned(ListDetail.Selected)) then
  begin
    ShowMsg('请选择要覆盖的记录', sHint);
    Exit;
  end;

  EditDISBN.Text := Trim(EditDISBN.Text);
  if EditDISBN.Text = '' then
  begin
    ActiveControl := EditDISBN;
    ShowMsg('请填写ISBN码', sHint); Exit;
  end;

  EditDName.Text := Trim(EditDName.Text);
  if EditDName.Text = '' then
  begin
    ActiveControl := EditDName;
    ShowMsg('请填写图书名称', sHint); Exit;
  end;

  if (not IsNumber(EditPubPrice.Text, True)) or
     (StrToFloat(EditPubPrice.Text) < 0) then
  begin
    ActiveControl := EditPubPrice;
    ShowMsg('请填写正确价格', sHint); Exit;
  end;

  if (not IsNumber(EditGetPrice.Text, True)) or
     (StrToFloat(EditGetPrice.Text) < 0) then
  begin
    ActiveControl := EditGetPrice;
    ShowMsg('请填写正确价格', sHint); Exit;
  end;

  if (not IsNumber(EditSalePrice.Text, True)) or
     (StrToFloat(EditSalePrice.Text) < 0) then
  begin
    ActiveControl := EditSalePrice;
    ShowMsg('请填写正确价格', sHint); Exit;
  end;

  if (not IsNumber(EditNumAll.Text, False)) or
     (StrToFloat(EditNumAll.Text) < 0) then
  begin
    ActiveControl := EditNumAll;
    ShowMsg('请填写正确数量', sHint); Exit;
  end;

  if (not IsNumber(EditNumIn.Text, False)) or
     (StrToFloat(EditNumIn.Text) < 0) then
  begin
    ActiveControl := EditNumIn;
    ShowMsg('请填写正确数量', sHint); Exit;
  end;

  if (not IsNumber(EditNumOut.Text, False)) or
     (StrToFloat(EditNumOut.Text) < 0) then
  begin
    ActiveControl := EditNumOut;
    ShowMsg('请填写正确数量', sHint); Exit;
  end;

  if nIsEdit then //修改
  begin
    nIdx := Integer(ListDetail.Selected.Data);
  end else
  begin
    nIdx := Length(FBooks);
    SetLength(FBooks, nIdx + 1);
  end;
  
  with FBooks[nIdx] do
  begin
    if nIsEdit then
    begin
      FStatus := bsEdit;
    end else
    begin
      FRecord := '';
      FStatus := bsNew;
    end;

    FISBN        := EditDISBN.Text;
    FName        := EditDName.Text;
    FPublisher   := EditPublisher.Text;
    FProvider    := EditProvider.Text;
    FMemo        := EditDMemo.Text;

    FPubPrice    := StrToFloat(EditPubPrice.Text);
    FGetPrice    := StrToFloat(EditGetPrice.Text);
    FSalePrice   := StrToFloat(EditSalePrice.Text);
    FNumAll      := StrToInt(EditNumAll.Text);
    FNumIn       := StrToInt(EditNumIn.Text);
    FNumOut      := StrToInt(EditNumOut.Text);
    FValid       := RadioNormal.Checked;
  end;
  
  if Sender = BtnAdd then
  begin
    EditDName.Text := '';
    EditNumAll.Text := '0';
    EditNumIn.Text := '0';
    EditNumOut.Text := '0';
  end;

  ActiveControl := EditDISBN;
  EditDISBN.SelectAll;
  LoadBookDetail; //载入明细
end;

//Desc: 删除明细
procedure TfFormBooks.BtnDelClick(Sender: TObject);
var nIdx,nInt: Integer;
begin
  if not Assigned(ListDetail.Selected) then
  begin
    ShowMsg('请选择要删除的记录', sHint);
    Exit;
  end;

  nInt := Integer(ListDetail.Selected.Data);
  FBooks[nInt].FStatus := bsDel;
  nIdx := ListDetail.ItemIndex;

  LoadBookDetail;
  if ListDetail.Items.Count > 0 then
  begin
    if ListDetail.Items.Count > nIdx then
         ListDetail.ItemIndex := nIdx
    else ListDetail.ItemIndex := ListDetail.Items.Count-1;
  end;
end;

//Desc: 加载明细到界面
procedure TfFormBooks.ListDetailDblClick(Sender: TObject);
var nIdx: Integer;
begin
  if not Assigned(ListDetail.Selected) then Exit;
  nIdx := Integer(ListDetail.Selected.Data);

  with FBooks[nIdx] do
  begin
    EditDISBN.Text := FISBN;
    EditDName.Text := FName;
    EditPublisher.Text := FPublisher;
    EditProvider.Text := FProvider;
    EditDMemo.Text := FMemo;

    EditPubPrice.Text := FloatToStr(FPubPrice);
    EditGetPrice.Text := FloatToStr(FGetPrice);
    EditSalePrice.Text := FloatToStr(FSalePrice);
    EditNumAll.Text := IntToStr(FNumAll);
    EditNumIn.Text := IntToStr(FNumIn);
    EditNumOut.Text := IntToStr(FNumOut);

    if FValid then
         RadioNormal.Checked := True
    else RadioForbid.Checked := True;
  end;
end;

procedure TfFormBooks.EditDNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    BtnAdd.Click();
  end;
end;

function TfFormBooks.OnVerifyCtrl(Sender: TObject; var nHint: string): Boolean;
var nStr: string;
begin
  Result := True;
  if Sender = EditISBN then
  begin
    nHint := '请填写ISBN码';
    EditISBN.Text := Trim(EditISBN.Text);
    Result := EditISBN.Text <> '';

    if not Result then Exit;
    nStr := 'Select R_ID From %s Where B_ISBN=''%s''';
    nStr := Format(nStr, [sTable_Books, EditISBN.Text]);

    with FDM.QueryTemp(nStr) do
    if RecordCount > 0 then
    begin
      First;
      while not Eof do
      begin
        nStr := FieldByName('R_ID').AsString;
        if (FRecordID = '') or (FRecordID <> nStr) then
        begin
          Result := False;
          nHint := '该 ISBN 已存在';
          Exit;
        end;

        Next;
      end;
    end;
  end else

  if Sender = EditName then
  begin
    EditName.Text := Trim(EditName.Text);
    Result := EditName.Text <> '';
    nHint := '请填写图书名称';
  end else

  if Sender = EditAuthor then
  begin
    EditAuthor.Text := Trim(EditAuthor.Text);
    Result := EditAuthor.Text <> '';
    nHint := '请填写作者';
  end else

  if Sender = EditClass then
  begin
    Result := EditClass.Text <> '';
    nHint := '请选择分类';
  end else

  if Sender = EditLang then
  begin
    Result := EditLang.Text <> '';
    nHint := '请选择语种';
  end;
end;

//Date: 2020-08-19
//Parm: 档案标识
//Desc: 保存图书档案
function TfFormBooks.SaveBook(var nBookID: string): Boolean;
var nStr: string;
    nIsNew: Boolean;
begin
  Result := False;
  nIsNew := FRecordID = '';
  if nIsNew then
  begin
    if not GetSerailID(nBookID, sFlag_ID_BusGroup, sFlag_ID_Books) then
    begin
      ShowMsg(nBookID, sHint);
      Exit;
    end;
  end else nBookID := FBookID;

  nStr := MakeSQLByStr([
      SF('B_ISBN', EditISBN.Text),
      SF('B_Name', EditName.Text),
      SF('B_Py', GetPinYinOfStr(EditName.Text)),

      SF('B_Author', EditAuthor.Text),
      SF('B_Lang', EditLang.Text),
      SF('B_Class', EditClass.Text),
      SF('B_Memo', EditMemo.Text),

      SF_IF([SF('B_ID', nBookID), ''], nIsNew),
      SF_IF([SF('B_Date', sField_SQLServer_Now, sfVal), ''], nIsNew),
      SF_IF([SF('B_Man', gSysParam.FUserID), ''], nIsNew),
      SF_IF([SF('B_Valid', sFlag_Yes), ''], nIsNew),

      SF_IF([SF('B_NumAll', 0), ''], nIsNew),
      SF_IF([SF('B_NumIn', 0), ''], nIsNew),
      SF_IF([SF('B_NumOut', 0), ''], nIsNew)
    ], sTable_Books, SF('R_ID', FRecordID, sfVal), nIsNew);
  //xxxxx
  
  FDM.ExecuteSQL(nStr);
  SaveBaseDataItemNoExists(sFlag_Base_Author, EditAuthor.Text);
  Result := True;
end;

//Date: 2020-08-19
//Parm: 档案标识
//Desc: 保存图书明细
function TfFormBooks.SaveBookDetail(const nBookID: string): Boolean;
var nStr,nID: string;
    nIsNew: Boolean;
    nIdx,nInt: Integer;
begin
  Result := False;
  //default
  nInt := 0;

  for nIdx:=Low(FBooks) to High(FBooks) do
  with FBooks[nIdx] do
  begin
    if FStatus = bsNone then Continue; //no change
    nIsNew := FRecord = '';

    if (FStatus = bsDel) and (not nIsNew) then //delete
    begin
      nStr := 'Delete From %s Where R_ID=%s';
      nStr := Format(nStr, [sTable_BookDetail, FRecord]);
      FDM.ExecuteSQL(nStr);
      Continue;
    end;
        
    if nIsNew and (not GetSerailID(nID, sFlag_ID_BusGroup, sFlag_ID_BookDtl)) then
    begin
      ShowMsg(nID, sHint);
      Exit;
    end;

    nStr := MakeSQLByStr([SF('D_Book', nBookID),
        SF('D_ISBN', FISBN),
        SF('D_Name', FName),
        SF('D_Py', GetPinYinOfStr(FName)),
        SF('D_Publisher', FPublisher),
        SF('D_Provider', FProvider),
        SF('D_PubPrice', FloatToStr(FPubPrice), sfVal),
        SF('D_GetPrice', FloatToStr(FGetPrice), sfVal),
        SF('D_SalePrice', FloatToStr(FSalePrice), sfVal),
        SF('D_NumAll', IntToStr(FNumAll), sfVal),
        SF('D_NumIn', IntToStr(FNumIn), sfVal),
        SF('D_NumOut', IntToStr(FNumOut), sfVal),
        SF('D_Memo', FMemo),

        SF_IF([SF('D_Valid', sFlag_Yes), SF('D_Valid', sFlag_No)], FValid),
        SF_IF([SF('D_ID', nID), ''], nIsNew),
        SF_IF([SF('D_Man', gSysParam.FUserID), ''], nIsNew),
        SF_IF([SF('D_Date', sField_SQLServer_Now, sfVal), ''], nIsNew)
      ], sTable_BookDetail, SF('R_ID', FRecord), nIsNew);
    //xxxxx

    FDM.ExecuteSQL(nStr);
    Inc(nInt);
  end;

  if nInt > 0 then
    SyncBookNumber(nBookID);
  //同步库存

  FListA.Clear;
  for nIdx:=Low(FBooks) to High(FBooks) do
   with FBooks[nIdx] do
    if FListA.IndexOf(FPublisher) < 0 then
    begin
      FListA.Add(FPublisher);
      SaveBaseDataItemNoExists(sFlag_Base_Publish, FPublisher);
    end;
  //save publisher

  FListA.Clear;
  for nIdx:=Low(FBooks) to High(FBooks) do
   with FBooks[nIdx] do
    if FListA.IndexOf(FProvider) < 0 then
    begin
      FListA.Add(FProvider);
      SaveBaseDataItemNoExists(sFlag_Base_Provide, FProvider);
    end;
  //save provider

  Result := True;
  //save done
end;

procedure TfFormBooks.BtnOKClick(Sender: TObject);
var nID: string;
begin
  if not IsDataValid then Exit;
  //verify data

  FDM.ADOConn.BeginTrans;
  try
    if SaveBook(nID) and SaveBookDetail(nID) then
    begin
      FDM.ADOConn.CommitTrans;
      //apply save
    end else
    begin
      FDM.ADOConn.RollbackTrans;
      Exit;
    end;
  except
    on nErr: Exception do
    begin
      FDM.ADOConn.RollbackTrans;
      ShowDlg(nErr.Message, sError); Exit;
    end;
  end;   
  
  FSaveResult := mrOk;
  if Check1.Checked then
  begin
    ShowMsg('图书添加成功', sHint);
    ResetFormData;
  end else ModalResult := mrOk;
end;

procedure TfFormBooks.EditDISBNKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ActiveControl := EditDName;

    EditNumAll.Text := '1';
    EditNumIn.Text := '1';
    
    {if IsNumber(EditNumAll.Text, False) then
         EditNumAll.Text := IntToStr(StrToInt(EditNumAll.Text) + 1)
    else EditNumAll.Text := '1';

    if IsNumber(EditNumIn.Text, False) then
         EditNumIn.Text := IntToStr(StrToInt(EditNumIn.Text) + 1)
    else EditNumIn.Text := '1';}
  end;
end;

procedure TfFormBooks.EditISBNKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    ActiveControl := EditName;
  end;
end;

initialization
  gControlManager.RegCtrl(TfFormBooks, TfFormBooks.FormID);
end.
