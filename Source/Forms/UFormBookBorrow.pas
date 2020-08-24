{*******************************************************************************
  作者: dmzn@163.com 2020-08-23
  描述: 图书借阅
*******************************************************************************}
unit UFormBookBorrow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox;

type
  PMemberData = ^TMemberData;
  TMemberData = record
    FMember: string;
    FName: string;
    FCard: string;
    FPhone: string;
    FLevel: string;
    FValid: TDateTime;

    FMonCH: Integer;
    FMonEN: Integer;
    FMonth: string;
    FMonCHHas: Integer;
    FMonENHas: Integer;
  end;

  TfFormBookBorrow = class(TfFormNormal)
    dxGroup2: TdxLayoutGroup;
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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditMemPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    FMember: TMemberData;
    {**}
    procedure InitFormData(const nID: string);
    procedure LoadMember(const nData: PMemberData = nil);
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
  ULibFun, UFormCtrl, UFormBase, UMgrControl, USysDB, USysConst, USysBusiness,
  UMgrLookupAdapter, UDataModule;

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
  dxGroup2.AlignVert := avClient;
  LoadFormConfig(Self);
end;

procedure TfFormBookBorrow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gLookupComboBoxAdapter.DeleteGroup(Name);
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormBookBorrow.InitFormData(const nID: string);
var nStr,nTmp: string;
    nDStr: TDynamicStrArray;
    nItem: TLookupComboBoxItem;
begin
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
begin
  if EditMem.Text = '' then Exit;
  nStr := 'Select * From %s Where M_ID=''%s''';
  nStr := Format(nStr, [sTable_Members, EditMem.Text]);

  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount < 1 then
    begin
      LoadMember(nil);
      Exit;
    end;

    with FMember do
    begin
      FMember    := FieldByName('M_ID').AsString;
      FName      := FieldByName('M_Name').AsString;
      FCard      := FieldByName('M_Card').AsString;
      FPhone     := FieldByName('M_Phone').AsString;
      FLevel     := FieldByName('M_Level').AsString;
      FValid     := FieldByName('M_ValidDate').AsDateTime;

      FMonCH     := FieldByName('M_MonCH').AsInteger;
      FMonEN     := FieldByName('M_MonEN').AsInteger;
      FMonth     := FieldByName('M_Month').AsString;
      FMonCHHas  := FieldByName('M_MonCHHas').AsInteger;
      FMonENHas  := FieldByName('M_MonENHas').AsInteger;
    end;

    LoadMember(@FMember);
  end;
end;

procedure TfFormBookBorrow.LoadMember(const nData: PMemberData);
begin
  if not Assigned(nData) then
  begin
    ClearLabelCaption();
    Exit;
  end;

  with nData^ do
  begin
    SetLableCaption('M_Name', FName);
    SetLableCaption('M_Phone', FPhone);
    SetLableCaption('M_Level', FLevel);
    SetLableCaption('M_ValidDate', DateTime2Str(FValid));
    SetLableCaption('M_Quanyi', Format('中文 %d 本,英文 %d 本', [FMonCH, FMonEN]));
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

initialization
  gControlManager.RegCtrl(TfFormBookBorrow, TfFormBookBorrow.FormID);
end.
