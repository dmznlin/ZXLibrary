{*******************************************************************************
  作者: dmzn@163.com 2020-08-22
  描述: 图书查询
*******************************************************************************}
unit UFormBookQuery;

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
  end;

  TfFormBookQuery = class(TfFormNormal)
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
    dxLayout1Item25: TdxLayoutItem;
    cxLabel19: TcxLabel;
    dxLayout1Group2: TdxLayoutGroup;
    dxLayout1Item26: TdxLayoutItem;
    LabelKuCun: TcxLabel;
    dxLayout1Group15: TdxLayoutGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditISDNKeyPress(Sender: TObject; var Key: Char);
    procedure ListDetailSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
    FBooks: array of TBookItem;
    {*图书列表*}
    function LoadBookData(const nISDN: string): Boolean;
    procedure LoadBookDataToForm;
    procedure ApplyBook(const nBookIdx: Integer;
      const nColor: TColor = $00408000);
    {*读写数据*}
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
  ULibFun, UFormCtrl, UFormBase, UMgrControl, UDataModule, USysBusiness, USysDB,
  USysGrid, USysConst;

class function TfFormBookQuery.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
begin
  Result := nil;
  with TfFormBookQuery.Create(Application) do
  begin
    Caption := '图书 - 查询';    
    ShowModal;
    Free;
  end;
end;

class function TfFormBookQuery.FormID: integer;
begin
  Result := cFI_FormBookQuery;
end;

procedure TfFormBookQuery.FormCreate(Sender: TObject);
begin
  inherited;
  dxGroup1.AlignVert := avTop;
  dxGroup2.AlignVert := avClient;

  BtnOK.Visible := False;
  ClearLabelCaption;
  LoadFormConfig(Self);
  LoadcxListViewConfig(Name, ListDetail);
end;

procedure TfFormBookQuery.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SavecxListViewConfig(Name, ListDetail);
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormBookQuery.EditISDNKeyPress(Sender: TObject; var Key: Char);
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

    EditISDN.SelectAll;
    Application.ProcessMessages;

    if LoadBookData(EditISDN.Text) then
      LoadBookDataToForm();
    //xxxxx
  end;
end;

//Date: 2020-08-19
//Parm: isdn
//Desc: 载入isdn对应的书目
function TfFormBookQuery.LoadBookData(const nISDN: string): Boolean;
var nStr: string;
    nIdx: Integer;
begin
  Result := False;
  SetLength(FBooks, 0);

  nStr := 'Select dt.*,B_Name,B_Author From %s dt ' +
          ' Left Join %s On B_ID=D_Book ' +
          'Where D_ISBN=''%s'' Or (D_Name Like ''%%%s%%'' Or D_Py Like ''%%%s%%'')';
  nStr := Format(nStr, [sTable_BookDetail, sTable_Books, nISDN, nISDN, nISDN]);

  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount < 1 then
    begin
      ApplyBook(-1, clRed);
      ClearLabelCaption('D_NumAll', '该条码没有图书档案');
      
      LoadBookDataToForm();
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

procedure TfFormBookQuery.LoadBookDataToForm;
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
    if ListDetail.Items.Count > 0 then
      ListDetail.ItemIndex := 0;
    //xxxxx
  end;   
end;

//Desc: 根据Hint设置标题
procedure TfFormBookQuery.SetLableCaption(const nHint, nText: string);
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

//Desc: 将当前选中的图书加载到标签
procedure TfFormBookQuery.ApplyBook(const nBookIdx: Integer; const nColor: TColor);
var nStr: string;
begin
  with LabelKuCun.Style do
  begin
    if nColor = $00408000 then
    begin
      TextColor := nColor;
      TextStyle := TextStyle - [fsBold];
    end else
    begin
      TextColor := nColor;
      TextStyle := TextStyle + [fsBold];
    end;
  end;

  if nBookIdx < 0 then Exit;
  //no book

  with FBooks[nBookIdx] do
  begin
    SetLableCaption('D_Name', FName);
    SetLableCaption('B_Name', FBookName);
    SetLableCaption('B_Author', FAuthor);
    SetLableCaption('D_Publisher', FPublisher);
    SetLableCaption('D_Provider', FProvider);
    SetLableCaption('D_PubPrice', Format('%.2f 元', [FPubPrice]));
    SetLableCaption('D_GetPrice', Format('%.2f 元', [FGetPrice]));
    SetLableCaption('D_SalePrice', Format('%.2f 元', [FSalePrice]));

    nStr := '共 %d 本,在库 %d 本,借出 %d 本';
    SetLableCaption('D_NumAll', Format(nStr, [FNumAll, FNumIn, FNumOut]));
  end;
end;

//Desc: 清理标签标题
procedure TfFormBookQuery.ClearLabelCaption(const nHint,nCaption: string);
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

procedure TfFormBookQuery.ListDetailSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var nInt: Integer;
begin
  if Selected and Assigned(Item) then
  begin
    nInt := Integer(Item.Data);
    ApplyBook(nInt);
  end;
end;

initialization
  gControlManager.RegCtrl(TfFormBookQuery, TfFormBookQuery.FormID);
end.
