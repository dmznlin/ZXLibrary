{*******************************************************************************
  作者: dmzn@163.com 2020-08-17
  描述: 图书档案
*******************************************************************************}
unit UFormBooks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxRadioGroup, cxCalendar,
  cxGroupBox, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

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
    cxLabel1: TcxLabel;
    dxLayout1Item9: TdxLayoutItem;
    RadioNormal: TcxRadioButton;
    dxLayout1Item10: TdxLayoutItem;
    RadioForbid: TcxRadioButton;
    dxLayout1Item11: TdxLayoutItem;
    dxLayout1Group2: TdxLayoutGroup;
    EditAuthor: TcxLookupComboBox;
    dxLayout1Item12: TdxLayoutItem;
    dxLayout1Group3: TdxLayoutGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
  private
    { Private declarations }
    FBookID: string;
    {*图书编号*}
    FSaveResult: Integer;
    procedure InitFormData(const nID: string);
    procedure ResetFormData;
    {*界面数据*}
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
  USysBusiness, USysDB, USysConst;

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
      FBookID := '';
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
      FBookID := nP.FParamA;
      InitFormData(FBookID);

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
      FBookID := nP.FParamA;
      
      InitFormData(FBookID);
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
  LoadFormConfig(Self);
end;

procedure TfFormBooks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gLookupComboBoxAdapter.DeleteGroup(Name);
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormBooks.InitFormData(const nID: string);
var nStr,nTmp: string;
    nDefault: TNameAndValue;
    nDStr: TDynamicStrArray;
    nItem: TLookupComboBoxItem;
begin
  ActiveControl := EditISBN;
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
  
  if nID <> '' then
  begin
    Check1.Checked := False;
    Check1.Visible := False;

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
    end;
  end;
end;

procedure TfFormBooks.ResetFormData;
begin
  EditISBN.Text := '';
  EditName.Text := '';
  ActiveControl := EditISBN;
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
        if (FBookID = '') or (FBookID <> nStr) then
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

procedure TfFormBooks.BtnOKClick(Sender: TObject);
var nStr,nID: string;
    nIsNew: Boolean;
begin
  if not IsDataValid then Exit;
  //verify data

  nIsNew := FBookID = '';
  //添加模式

  if nIsNew and (not GetSerailID(nID, sFlag_ID_BusGroup, sFlag_ID_Books)) then
  begin
    ShowMsg(nID, sHint);
    Exit;
  end;

  nStr := MakeSQLByStr([
      SF('B_ISBN', EditISBN.Text),
      SF('B_Name', EditName.Text),
      SF('B_Py', GetPinYinOfStr(EditName.Text)),

      SF('B_Author', EditAuthor.Text),
      SF('B_Lang', EditLang.Text),
      SF('B_Class', EditClass.Text),
      SF('B_Memo', EditMemo.Text),

      SF_IF([SF('B_ID', nID), ''], nIsNew),
      SF_IF([SF('B_Date', sField_SQLServer_Now, sfVal), ''], nIsNew),
      SF_IF([SF('B_Man', gSysParam.FUserID), ''], nIsNew),
      SF_IF([SF('B_Valid', sFlag_Yes),
             SF('B_Valid', sFlag_No)], RadioNormal.Checked),

      SF_IF([SF('B_NumAll', 0), ''], nIsNew),
      SF_IF([SF('B_NumIn', 0), ''], nIsNew),
      SF_IF([SF('B_NumOut', 0), ''], nIsNew)
    ], sTable_Books, SF('R_ID', FBookID, sfVal), nIsNew);
  FDM.ExecuteSQL(nStr);
  
  FSaveResult := mrOk;
  if Check1.Checked then
  begin
    ShowMsg('图书添加成功', sHint);
    ResetFormData;
  end else ModalResult := mrOk;
end;

initialization
  gControlManager.RegCtrl(TfFormBooks, TfFormBooks.FormID);
end.
