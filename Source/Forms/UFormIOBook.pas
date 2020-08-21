{*******************************************************************************
  ����: dmzn@163.com 2020-08-19
  ����: ͼ������
*******************************************************************************}
unit UFormIOBook;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxRadioGroup, cxCalendar,
  cxGroupBox, ComCtrls, ImgList, cxListView, cxSpinEdit;

type
  TBookItem = record
    FRecord      : string;
    FBookID      : string;
    FBookName    : string;
    FDetailID    : string;
    FAuthor      : string;
    FISBN        : string;
    FName        : string;
    FPublisher   : string;
    FProvider    : string;
    FPubPrice    : Double;
    FGetPrice    : Double;
    FSalePrice   : Double;
    FNumAll      : Integer;
    FNumIn       : Integer;
    FNumOut      : Integer;
    FNumAfter    : Integer;
  end;

  TfFormIOBook = class(TfFormNormal)
    EditISDN: TcxTextEdit;
    dxLayout1Item4: TdxLayoutItem;
    dxGroup2: TdxLayoutGroup;
    cxLabel1: TcxLabel;
    dxLayout1Item3: TdxLayoutItem;
    dxLayout1Item5: TdxLayoutItem;
    LabelName: TcxLabel;
    dxLayout1Group3: TdxLayoutGroup;
    dxLayout1Item6: TdxLayoutItem;
    cxLabel4: TcxLabel;
    dxLayout1Group4: TdxLayoutGroup;
    dxLayout1Item7: TdxLayoutItem;
    cxLabel5: TcxLabel;
    dxLayout1Group5: TdxLayoutGroup;
    dxLayout1Item8: TdxLayoutItem;
    cxLabel6: TcxLabel;
    dxLayout1Item9: TdxLayoutItem;
    cxLabel7: TcxLabel;
    dxLayout1Item10: TdxLayoutItem;
    cxLabel8: TcxLabel;
    dxLayout1Item11: TdxLayoutItem;
    cxLabel9: TcxLabel;
    dxLayout1Item12: TdxLayoutItem;
    cxLabel10: TcxLabel;
    dxLayout1Item13: TdxLayoutItem;
    cxLabel11: TcxLabel;
    dxLayout1Item14: TdxLayoutItem;
    cxLabel12: TcxLabel;
    dxLayout1Item15: TdxLayoutItem;
    cxLabel13: TcxLabel;
    dxLayout1Item17: TdxLayoutItem;
    cxLabel14: TcxLabel;
    dxLayout1Item18: TdxLayoutItem;
    cxLabel15: TcxLabel;
    dxLayout1Item19: TdxLayoutItem;
    cxLabel16: TcxLabel;
    dxLayout1Group6: TdxLayoutGroup;
    dxLayout1Group7: TdxLayoutGroup;
    dxLayout1Group8: TdxLayoutGroup;
    dxLayout1Group9: TdxLayoutGroup;
    dxLayout1Group10: TdxLayoutGroup;
    dxLayout1Group11: TdxLayoutGroup;
    dxLayout1Item20: TdxLayoutItem;
    cxLabel17: TcxLabel;
    dxLayout1Group12: TdxLayoutGroup;
    ListDetail: TcxListView;
    dxLayout1Item22: TdxLayoutItem;
    cxImageList1: TcxImageList;
    dxLayout1Item21: TdxLayoutItem;
    cxLabel3: TcxLabel;
    dxLayout1Item23: TdxLayoutItem;
    cxLabel18: TcxLabel;
    EditMemo: TcxTextEdit;
    dxLayout1Item24: TdxLayoutItem;
    dxLayout1Group14: TdxLayoutGroup;
    dxLayout1Group13: TdxLayoutGroup;
    dxLayout1Item25: TdxLayoutItem;
    cxLabel19: TcxLabel;
    dxLayout1Group2: TdxLayoutGroup;
    dxLayout1Item26: TdxLayoutItem;
    LabelKuCun: TcxLabel;
    dxLayout1Group15: TdxLayoutGroup;
    EditNum: TcxSpinEdit;
    dxLayout1Item27: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditISDNKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOKClick(Sender: TObject);
  private
    { Private declarations }
    FInOut: string;
    FSaveResult: Integer;
    {*ִ�н��*}
    FBooks: array of TBookItem;
    {*ͼ���б�*}
    function LoadBookData(const nISDN: string): Boolean;
    procedure LoadBookDataToForm;
    function SaveBookData: Boolean;
    procedure ApplySavedBook(const nBookIdx: Integer);
    {*��д����*}
    procedure SetLableCaption(const nHint,nText: string);
    procedure ClearLabelCaption;
    {*��ǩ����*}
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UFormCtrl, UFormBase, UMgrControl, UDataModule, USysBusiness, USysDB,
  USysGrid, USysConst;

class function TfFormIOBook.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  with TfFormIOBook.Create(Application) do
  begin
    if nP.FCommand = cCmd_DeleteData then
    begin
      Caption := 'ͼ�� - ����';
      FInOut := sFlag_Out;
    end else
    begin
      Caption := 'ͼ�� - ���';
      FInOut := sFlag_In;
    end;
    
    ShowModal;
    nP.FCommand := cCmd_ModalResult;
    nP.FParamA := FSaveResult;
    Free;
  end;
end;

class function TfFormIOBook.FormID: integer;
begin
  Result := cFI_FormBookInOut;
end;

procedure TfFormIOBook.FormCreate(Sender: TObject);
begin
  inherited;
  dxGroup1.AlignVert := avTop;
  dxGroup2.AlignVert := avClient;
  ClearLabelCaption;

  FSaveResult := mrCancel;
  LoadFormConfig(Self);
  LoadcxListViewConfig(Name, ListDetail);
end;

procedure TfFormIOBook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SavecxListViewConfig(Name, ListDetail);
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormIOBook.EditISDNKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    EditISDN.Text := Trim(EditISDN.Text);
    if EditISDN.Text = '' then
    begin
      ShowMsg('����дISDN��', sHint);
      Exit;
    end;

    EditISDN.SelectAll;
    BtnOK.Visible := False;
    Application.ProcessMessages;

    if LoadBookData(EditISDN.Text) then
    begin
      LoadBookDataToForm();
      if Length(FBooks) = 1 then
           BtnOK.Visible := not SaveBookData()
      else BtnOK.Visible := True;
    end;
  end;
end;

//Date: 2020-08-19
//Parm: isdn
//Desc: ����isdn��Ӧ����Ŀ
function TfFormIOBook.LoadBookData(const nISDN: string): Boolean;
var nStr: string;
    nIdx: Integer;
begin
  Result := False;
  SetLength(FBooks, 0);

  nStr := 'Select dt.*,B_Name,B_Author From %s dt ' +
          ' Left Join %s On B_ID=D_Book ' +
          'Where D_ISBN=''%s''';
  nStr := Format(nStr, [sTable_BookDetail, sTable_Books, nISDN]);

  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount < 1 then
    begin
      ShowMsg('������û��ͼ�鵵��', sHint);
      ClearLabelCaption();
      Exit;
    end;

    SetLength(FBooks, RecordCount);
    nIdx := 0;
    First;

    while not Eof do
    begin
      with FBooks[nIdx] do
      begin
        FRecord      := FieldByName('R_ID').AsString;
        FBookID      := FieldByName('D_Book').AsString;
        FBookName    := FieldByName('B_Name').AsString;
        FAuthor      := FieldByName('B_Author').AsString;
        FDetailID    := FieldByName('D_ID').AsString;
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
      end;

      Inc(nIdx);
      Next;
    end;
  end;

  Result := True;
end;

procedure TfFormIOBook.LoadBookDataToForm;
var nIdx: Integer;
begin
  ListDetail.Items.BeginUpdate;
  try
    ListDetail.Items.Clear;
    for nIdx:=Low(FBooks) to High(FBooks) do
    with ListDetail.Items.Add, FBooks[nIdx] do
    begin
      Data := Pointer(nIdx);
      Caption := FName;
      SubItems.Add(FBookName);
      SubItems.Add(FPublisher);
      SubItems.Add(FProvider);
      SubItems.Add(FloatToStr(FPubPrice));
      SubItems.Add(FloatToStr(FGetPrice));
      SubItems.Add(FloatToStr(FSalePrice));
      SubItems.Add(IntToStr(FNumAll));
    end;
  finally
    ListDetail.Items.EndUpdate;
    ListDetail.ItemIndex := 0;
  end;   
end;

procedure TfFormIOBook.BtnOKClick(Sender: TObject);
begin
  SaveBookData();
end;

//Desc: ��������
function TfFormIOBook.SaveBookData: Boolean;
var nStr: string;
    nIdx,nInt: Integer;
begin
  Result := False;
  if not Assigned(ListDetail.Selected) then
  begin
    ShowMsg('��ѡ�������ͼ��', sHint);
    Exit;
  end;

  nInt := EditNum.Value;
  if FInOut = sFlag_Out then
    nInt := nInt * (-1);
  //xxxxx

  nIdx := Integer(ListDetail.Selected.Data);
  with FBooks[nIdx] do
  begin
    FNumAfter := FNumAll + nInt;
    if (nInt < 0) and (FNumAfter < 0) then
    begin
      with LabelKuCun.Style do
      begin
        TextColor := clRed;
        TextStyle := TextStyle + [fsBold];
      end;

      ApplySavedBook(nIdx);
      SetLableCaption('D_NumAll', '��治��');
      ShowMsg('��治��', sHint);
      Exit;
    end else
    begin
      with LabelKuCun.Style do
      begin
        TextColor := $00408000;
        TextStyle := TextStyle - [fsBold];
      end;
    end;

    FDM.ADOConn.BeginTrans;
    try
      nStr := 'Update %s Set D_NumAll=D_NumAll+%d,D_NumIn=D_NumIn+%d ' +
              'Where R_ID=%s';
      nStr := Format(nStr, [sTable_BookDetail, nInt, nInt, FRecord]);

      FDM.ExecuteSQL(nStr);
      SyncBookNumber(FBookID); //ͬ�����

      nStr := MakeSQLByStr([SF('I_Book', FBookID),
          SF('I_BookDtl', FDetailID),
          SF('I_Type', FInOut),
          SF('I_Num', IntToStr(nInt), sfVal),
          SF('I_NumBefore', IntToStr(FNumAll), sfVal),
          SF('I_Man', gSysParam.FUserID),
          SF('I_Date', sField_SQLServer_Now, sfVal),
          SF('I_Memo', EditMemo.Text)
        ], sTable_BookInOut, '', True);
      FDM.ExecuteSQL(nStr);

      FDM.ADOConn.CommitTrans;
      FSaveResult := mrOk;
      Result := True;
    except
      on nErr: Exception do
      begin
        FDM.ADOConn.RollbackTrans;
        ShowDlg(nErr.Message, sError); Exit;
      end;
    end;
  end;

  BtnOK.Visible := False;
  ApplySavedBook(nIdx);
  
  if FInOut = sFlag_In then
       ShowMsg('���ɹ�', sHint)
  else ShowMsg('����ɹ�', sHint)
end;

//Desc: ����Hint���ñ���
procedure TfFormIOBook.SetLableCaption(const nHint, nText: string);
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

procedure TfFormIOBook.ApplySavedBook(const nBookIdx: Integer);
begin
  with FBooks[nBookIdx] do
  begin
    SetLableCaption('D_Name', FName);
    SetLableCaption('B_Name', FBookName);
    SetLableCaption('B_Author', FAuthor);
    SetLableCaption('D_Publisher', FPublisher);
    SetLableCaption('D_Provider', FProvider);
    SetLableCaption('D_PubPrice', Format('%.2f Ԫ', [FPubPrice]));
    SetLableCaption('D_GetPrice', Format('%.2f Ԫ', [FGetPrice]));
    SetLableCaption('D_SalePrice', Format('%.2f Ԫ', [FSalePrice]));
    SetLableCaption('D_NumAll', Format('���� %d ��', [FNumAfter]));
  end;
end;

procedure TfFormIOBook.ClearLabelCaption;
var nIdx: Integer;
begin
  with dxLayout1 do
  for nIdx:=ControlCount-1 downto 0 do
   if (Controls[nIdx] is TcxLabel) and
      ((Controls[nIdx] as TcxLabel).Hint <> '') then
  begin
    (Controls[nIdx] as TcxLabel).Caption := '';
  end;
end;

initialization
  gControlManager.RegCtrl(TfFormIOBook, TfFormIOBook.FormID);
end.