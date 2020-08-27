{*******************************************************************************
  作者: dmzn@163.com 2020-08-26
  描述: 零售
*******************************************************************************}
unit UFormSaleGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  USysBusiness, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxLayoutControl, StdCtrls, cxContainer, cxEdit, cxMemo, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxLabel, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, ComCtrls, cxListView, ImgList,
  cxSpinEdit, Menus, cxButtons;

type
  TGoodsItem = record
    FID      : string;
    FName    : string;
    FNum     : Integer;
    FPrice   : Double;
    FMoney   : Double;
    FEnabled : Boolean;
  end;
  TGoods = array of TGoodsItem;

  TfFormSaleGoods = class(TfFormNormal)
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
    dxLayout1Item3: TdxLayoutItem;
    cxLabel1: TcxLabel;
    dxLayout1Item4: TdxLayoutItem;
    cxLabel2: TcxLabel;
    dxLayout1Group2: TdxLayoutGroup;
    dxGroup2: TdxLayoutGroup;
    EditNum: TcxSpinEdit;
    dxlytmLayout1Item14: TdxLayoutItem;
    EditMemo: TcxMemo;
    dxlytmLayout1Item17: TdxLayoutItem;
    dxlytmLayout1Item15: TdxLayoutItem;
    EditName: TcxLookupComboBox;
    dxlytmLayout1Item16: TdxLayoutItem;
    ListDetail: TcxListView;
    dxlytmLayout1Item18: TdxLayoutItem;
    BtnAdd: TcxButton;
    dxlytmLayout1Item19: TdxLayoutItem;
    BtnDel: TcxButton;
    dxGroupLayout1Group10: TdxLayoutGroup;
    cxImageList1: TcxImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditMemPropertiesEditValueChanged(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure EditNameKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
  private
    { Private declarations }
    FMember: TMemberItem;
    FGoods: TGoods;
    FMoneyAll: Double;
    {*数据相关*}
    procedure InitFormData(const nID: string);
    procedure LoadMember(const nData: PMemberItem = nil);
    procedure LoadGoodsDetail;
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

class function TfFormSaleGoods.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else nP := nil;

  with TfFormSaleGoods.Create(Application) do
  try
    Caption := '会员 - 零售';
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

class function TfFormSaleGoods.FormID: integer;
begin
  Result := cFI_FormSaleGoods;
end;

procedure TfFormSaleGoods.FormCreate(Sender: TObject);
begin
  inherited;
  dxGroup1.AlignVert := avTop;
  dxGroup2.AlignVert := avClient;

  LoadFormConfig(Self);
  LoadcxListViewConfig(Name, ListDetail);
end;

procedure TfFormSaleGoods.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  gLookupComboBoxAdapter.DeleteGroup(Name);
  SavecxListViewConfig(Name, ListDetail);
  SaveFormConfig(Self);
  inherited;
end;

procedure TfFormSaleGoods.InitFormData(const nID: string);
var nStr,nTmp: string;
    nDStr: TDynamicStrArray;
    nItem: TLookupComboBoxItem;
begin
  ActiveControl := EditMem;
  BtnOK.Enabled := False;
  
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

  if not Assigned(EditName.Properties.ListSource) then
  begin
    nStr := 'Select B_Text,B_Py,B_ParamA,B_ParamB From %s ' +
            'Where B_Group=''%s''';
    nStr := Format(nStr, [sTable_BaseInfo, sFlag_Base_Goods]);

    nTmp := Name + 'GD';
    SetLength(nDStr, 3);
    nDStr[0] := 'B_Py';
    nDStr[1] := 'B_ParamA';
    nDStr[2] := 'B_ParamB';

    nItem := gLookupComboBoxAdapter.MakeItem(Name, nTmp, nStr, 'B_Text', 0,
             [MI('B_Text', '名称'), MI('B_Py', '助记码'),
              MI('B_ParamA', '编号'), MI('B_ParamB', '价格')], nDStr);
    gLookupComboBoxAdapter.AddItem(nItem);
    gLookupComboBoxAdapter.BindItem(nTmp, EditName);
  end;
end;

procedure TfFormSaleGoods.EditMemPropertiesEditValueChanged(Sender: TObject);
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
    ActiveControl := EditName;
  end;
end;

procedure TfFormSaleGoods.LoadMember(const nData: PMemberItem);
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
  end;
end;

procedure TfFormSaleGoods.LoadGoodsDetail;
var nIdx,nSelected: Integer;
begin
  with ListDetail do
  try
    if Assigned(Selected) then
         nSelected := Integer(Selected.Data)
    else nSelected := -1;

    Items.BeginUpdate;
    Items.Clear;
    FMoneyAll := 0;

    for nIdx:=Low(FGoods) to High(FGoods) do
     if FGoods[nIdx].FEnabled then
      with Items.Add, FGoods[nIdx] do
      begin
        Caption := FID;
        SubItems.Add(FName);
        SubItems.Add(Format('%.2f', [FPrice]));
        SubItems.Add(IntToStr(FNum));
        SubItems.Add(Format('%.2f', [FMoney]));

        Data := Pointer(nIdx);
        FMoneyAll := FMoneyAll + FMoney;

        if nIdx = nSelected then
          Selected := True;
        //xxxxx
      end;

    if FMoneyAll = 0 then
         dxGroup2.Caption := '零售明细'
    else dxGroup2.Caption := Format('合计: %.2f 元', [FMoneyAll]);
  finally
    ListDetail.Items.EndUpdate;
  end;
end;

procedure TfFormSaleGoods.EditNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    BtnAdd.Click();
  end;
end;

//Desc: 根据Hint设置标题
procedure TfFormSaleGoods.SetLableCaption(const nHint, nText: string);
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
procedure TfFormSaleGoods.ClearLabelCaption(const nHint,nCaption: string);
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

procedure TfFormSaleGoods.BtnAddClick(Sender: TObject);
var nStr: string;
    nInt: Integer;
begin
  if EditName.Text = '' then
  begin
    ShowMsg('请选择商品', sHint);
    Exit;
  end;

  nStr := 'Select * From %s Where B_Group=''%s'' And B_Text=''%s''';
  nStr := Format(nStr, [sTable_BaseInfo, sFlag_Base_Goods, EditName.Text]);
  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount < 1 then
    begin
      ShowMsg('商品信息已丢失', sHint);
      Exit;
    end;

    nInt := Length(FGoods);
    SetLength(FGoods, nInt + 1);
    with FGoods[nInt] do
    begin
      FEnabled := True;
      FID := FieldByName('B_ParamA').AsString;
      FName := FieldByName('B_Text').AsString;

      nStr := FieldByName('B_ParamB').AsString;
      if not IsNumber(nStr, True) then
        nStr := '0';
      FPrice := StrToFloat(nStr);
      FNum := EditNum.Value;
      FMoney := Float2Float(FPrice * FNum, 100, False);
    end;

    LoadGoodsDetail;
  end; 
end;

procedure TfFormSaleGoods.BtnDelClick(Sender: TObject);
var nIdx,nInt: Integer;
begin
  if not Assigned(ListDetail.Selected) then
  begin
    ShowMsg('请选择要删除的记录', sHint);
    Exit;
  end;

  nInt := Integer(ListDetail.Selected.Data);
  FGoods[nInt].FEnabled := False;
  nIdx := ListDetail.ItemIndex;

  LoadGoodsDetail;
  if ListDetail.Items.Count > 0 then
  begin
    if ListDetail.Items.Count > nIdx then
         ListDetail.ItemIndex := nIdx
    else ListDetail.ItemIndex := ListDetail.Items.Count-1;
  end;
end;

procedure TfFormSaleGoods.BtnOKClick(Sender: TObject);
var nStr: string;
    nIdx: Integer;
    nParam: TFormCommandParam;
begin
  if ListDetail.Items.Count < 1 then
  begin
    ShowMsg('请添加商品', sHint);
    Exit;
  end;

  nParam.FCommand := cCmd_AddData;
  nParam.FParamA := FMember.FMID;
  nParam.FParamB := FMoneyAll;
  nParam.FParamC := sFlag_Yes;
  CreateBaseFormItem(cFI_FormInOutMoney, PopedomItem, @nParam);

  if (nParam.FCommand <> cCmd_ModalResult) or (nParam.FParamA <> mrOK) then
    Exit;
  //取消付款

  FDM.ADOConn.BeginTrans;
  try
    for nIdx:=Low(FGoods) to High(FGoods) do
    with FGoods[nIdx] do
    begin
      if not FEnabled then Continue;
      nStr := MakeSQLByStr([SF('P_Member', FMember.FMID),
          SF('P_GoodsID', FID),
          SF('P_GoodsName', FName),
          SF('P_GoodsPy', GetPinYinOfStr(FName)),
          SF('P_Number', FNum, sfVal),
          SF('P_Price', FPrice, sfVal),
          SF('P_Money', FMoney, sfVal),
          SF('P_Payment', nParam.FParamB),
          SF('P_Man', gSysParam.FUserID),
          SF('P_Date', sField_SQLServer_Now, sfVal),
          SF('P_Memo', EditMemo.Text)
        ], sTable_PlayGoods, '', True);
      FDM.ExecuteSQL(nStr);
    end;

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
  gControlManager.RegCtrl(TfFormSaleGoods, TfFormSaleGoods.FormID);
end.
