{*******************************************************************************
  ����: dmzn@163.com 2008-08-07
  ����: ϵͳ���ݿⳣ������

  ��ע:
  *.�Զ�����SQL���,֧�ֱ���:$Inc,����;$Float,����;$Integer=sFlag_Integer;
    $Decimal=sFlag_Decimal;$Image,��������
*******************************************************************************}
unit USysDB;

{$I Link.inc}
interface

uses
  SysUtils, Classes;

const
  cSysDatabaseName: array[0..4] of String = (
     'Access', 'SQL', 'MySQL', 'Oracle', 'DB2');
  //db names

type
  TSysDatabaseType = (dtAccess, dtSQLServer, dtMySQL, dtOracle, dtDB2);
  //db types

  PSysTableItem = ^TSysTableItem;
  TSysTableItem = record
    FTable: string;
    FNewSQL: string;
  end;
  //ϵͳ����

  PNameAndValue = ^TNameAndValue;
  TNameAndValue = record
    FName     : string;     //��������
    FDesc     : string;     //��������
    FValue    : string;     //����ȡֵ
  end;

  //��������
  PBaseDataItem = ^TBaseDataItem;
  TBaseDataItem = record
    FRecord   : string;     //��¼���
    FGroup    : string;     //�����ʶ
    FGroupName: string;     //��������
    FName     : string;     //����
    FParamA   : string;     //����A
    FParamB   : string;     //����B
    FDefault  : Boolean;    //Ĭ��ֵ
    FMemo     : string;     //��ע��Ϣ
  end;

var
  gSysTableList: TList = nil;                        //ϵͳ������
  gSysDBType: TSysDatabaseType = dtSQLServer;        //ϵͳ��������

//------------------------------------------------------------------------------
const
  //�����ֶ�
  sField_Access_AutoInc          = 'Counter';
  sField_SQLServer_AutoInc       = 'Integer IDENTITY (1,1) PRIMARY KEY';

  //С���ֶ�
  sField_Access_Decimal          = 'Float';
  sField_SQLServer_Decimal       = 'Decimal(15, 5)';

  //ͼƬ�ֶ�
  sField_Access_Image            = 'OLEObject';
  sField_SQLServer_Image         = 'Image';

  //�������
  sField_SQLServer_Now           = 'getDate()';

const
  sFlag_Base_Lanuage             = 'lanuage';        //��������: ����
  sFlag_Base_Author              = 'author';         //��������: ����
  sFlag_Base_Publish             = 'publish';        //��������: ������
  sFlag_Base_Provide             = 'provide';        //��������: ������
  sFlag_Base_Age                 = 'age';            //��������: �����
  sFlag_Base_Payment             = 'payment';        //��������: ���ʽ
  sFlag_Base_BookClass           = 'bookclass';      //��������: ͼ�����
  sFlag_Base_MemLevel            = 'memlevel';       //��������: ��Ա�ȼ�
  sFlag_Base_Goods               = 'goods';          //��������: ������Ʒ

  sFlag_Language_CN               = '����';
  sFlag_Language_EN               = 'Ӣ��';
  sFlag_Language_Default          = sFlag_Language_CN + '|' + sFlag_Language_EN;

  sFlag_Member_Level_VIP         = 'VIP��Ա';
  sFlag_Member_Level_Common      = '��ͨ��Ա';
  sFlag_Member_Levels            = sFlag_Member_Level_VIP + '|' +
                                   sFlag_Member_Level_Common;
  //��Ա�ȼ��б�

  cBaseData: array[0..8] of TNameAndValue = (
    (FName: sFlag_Base_Lanuage;  FDesc: '����';     FValue: sFlag_Language_Default),
    (FName: sFlag_Base_Author;   FDesc: '����';     FValue: ''),
    (FName: sFlag_Base_Publish;  FDesc: '������';   FValue: ''),
    (FName: sFlag_Base_Provide;  FDesc: '��Ӧ��';   FValue: ''),
    (FName: sFlag_Base_Age;      FDesc: '�����';   FValue: ''),
    (FName: sFlag_Base_MemLevel; FDesc: '��Ա�ȼ�'; FValue: sFlag_Member_Levels),
    (FName: sFlag_Base_Payment;  FDesc: '���ʽ'; FValue: ''),
    (FName: sFlag_Base_BookClass;FDesc: 'ͼ�����'; FValue: ''),
    (FName: sFlag_Base_Goods;    FDesc: '������Ʒ'; FValue: '')
  ); //�������б�

ResourceString
  {*Ȩ����*}
  sPopedom_Read       = 'A';                         //���
  sPopedom_Add        = 'B';                         //���
  sPopedom_Edit       = 'C';                         //�޸�
  sPopedom_Delete     = 'D';                         //ɾ��
  sPopedom_Preview    = 'E';                         //Ԥ��
  sPopedom_Print      = 'F';                         //��ӡ
  sPopedom_Export     = 'G';                         //����

  {*��ر��*}
  sFlag_Yes           = 'Y';                         //��
  sFlag_No            = 'N';                         //��
  sFlag_Enabled       = 'Y';                         //����
  sFlag_Disabled      = 'N';                         //����

  sFlag_Integer       = 'I';                         //����
  sFlag_Decimal       = 'D';                         //С��

  sFlag_Male          = 'M';                         //�Ա�: ��
  sFlag_Female        = 'F';                         //�Ա�: Ů

  sFlag_In            = 'I';                         //����: ��ϵͳ
  sFlag_Out           = 'O';                         //����: ��ϵͳ

  sFlag_ID_BusGroup   = 'BusFunction';               //ҵ�������
  sFlag_ID_Member     = 'Bus_Member';                //��Ա���
  sFlag_ID_Books      = 'Bus_Books';                 //ͼ�鵵�����
  sFlag_ID_BookDtl    = 'Bus_BookDtl';               //ͼ����ϸ���

  sFlag_PlayArea      = 'yw001';                     //��������ʶ
  sFlag_Member        = 'Member';                    //��Ա���

  {*���ݱ�*}
  sTable_Group        = 'Sys_Group';                 //�û���
  sTable_User         = 'Sys_User';                  //�û���
  sTable_Menu         = 'Sys_Menu';                  //�˵���
  sTable_Popedom      = 'Sys_Popedom';               //Ȩ�ޱ�
  sTable_PopItem      = 'Sys_PopItem';               //Ȩ����
  sTable_Entity       = 'Sys_Entity';                //�ֵ�ʵ��
  sTable_DictItem     = 'Sys_DataDict';              //�ֵ���ϸ

  sTable_SysDict      = 'Sys_Dict';                  //ϵͳ�ֵ�
  sTable_ExtInfo      = 'Sys_ExtInfo';               //������Ϣ
  sTable_SysLog       = 'Sys_EventLog';              //ϵͳ��־
  sTable_SerialBase   = 'Sys_SerialBase';            //��������
  sTable_BaseInfo     = 'Sys_BaseInfo';              //������Ϣ
  sTable_Members      = 'M_Members';                 //��Ա����
  sTable_InOutMoney   = 'M_InOutMoney';              //�ʽ���ϸ
  sTable_PlayGoods    = 'M_PlayGoods';               //��������

  sTable_Books        = 'B_Books';                   //ͼ��
  sTable_BookDetail   = 'B_BookDtl';                 //ͼ����ϸ(����)
  sTable_BookInOut    = 'B_BookInOut';               //������¼
  sTable_BookBorrow   = 'B_BookBorrow';              //ͼ�����
  sTable_BookSale     = 'B_BookSale';                //ͼ������

  {*�½���*}
  sSQL_NewSysDict = 'Create Table $Table(D_ID $Inc, D_Name varChar(15),' +
       'D_Desc varChar(30), D_Value varChar(50), D_Memo varChar(20),' +
       'D_ParamA $Float, D_ParamB varChar(50), D_Index Integer Default 0)';
  {-----------------------------------------------------------------------------
   ϵͳ�ֵ�: SysDict
   *.D_ID: ���
   *.D_Name: ����
   *.D_Desc: ����
   *.D_Value: ȡֵ
   *.D_Memo: �����Ϣ
   *.D_ParamA: �������
   *.D_ParamB: �ַ�����
   *.D_Index: ��ʾ����
  -----------------------------------------------------------------------------}
  
  sSQL_NewExtInfo = 'Create Table $Table(I_ID $Inc, I_Group varChar(20),' +
       'I_ItemID varChar(20), I_Item varChar(30), I_Info varChar(500),' +
       'I_ParamA $Float, I_ParamB varChar(50), I_Index Integer Default 0)';
  {-----------------------------------------------------------------------------
   ��չ��Ϣ��: ExtInfo
   *.I_ID: ���
   *.I_Group: ��Ϣ����
   *.I_ItemID: ��Ϣ��ʶ
   *.I_Item: ��Ϣ��
   *.I_Info: ��Ϣ����
   *.I_ParamA: �������
   *.I_ParamB: �ַ�����
   *.I_Memo: ��ע��Ϣ
   *.I_Index: ��ʾ����
  -----------------------------------------------------------------------------}
  
  sSQL_NewSysLog = 'Create Table $Table(L_ID $Inc, L_Date DateTime,' +
       'L_Man varChar(32),L_Group varChar(20), L_ItemID varChar(20),' +
       'L_KeyID varChar(20), L_Event varChar(220))';
  {-----------------------------------------------------------------------------
   ϵͳ��־: SysLog
   *.L_ID: ���
   *.L_Date: ��������
   *.L_Man: ������
   *.L_Group: ��Ϣ����
   *.L_ItemID: ��Ϣ��ʶ
   *.L_KeyID: ������ʶ
   *.L_Event: �¼�
  -----------------------------------------------------------------------------}

  sSQL_NewSerialBase = 'Create Table $Table(R_ID $Inc, B_Group varChar(15),' +
       'B_Object varChar(32), B_Prefix varChar(25), B_IDLen Integer,' +
       'B_Base Integer, B_Date DateTime)';
  {-----------------------------------------------------------------------------
   ���б�Ż�����: SerialBase
   *.R_ID: ���
   *.B_Group: ����
   *.B_Object: ����
   *.B_Prefix: ǰ׺
   *.B_IDLen: ��ų�
   *.B_Base: ����
   *.B_Date: �ο�����
  -----------------------------------------------------------------------------}

  sSQL_NewBaseInfo = 'Create Table $Table(B_ID $Inc, B_Group varChar(15),' +
       'B_GroupName varChar(50), B_Text varChar(100), B_Py varChar(25),' +
       'B_ParamA varChar(100), B_ParamB varChar(100), B_Default Char(1),' +
       'B_Memo varChar(50), B_PID Integer, B_Index Float)';
  {-----------------------------------------------------------------------------
   ������Ϣ��: BaseInfo
   *.B_ID: ���
   *.B_Group: ����
   *.B_Text: ����
   *.B_Py: ƴ����д
   *.B_ParamA,B_ParamB:����
   *.B_Default: Ĭ��
   *.B_Memo: ��ע��Ϣ
   *.B_PID: �ϼ��ڵ�
   *.B_Index: ����˳��
  -----------------------------------------------------------------------------}

  sSQL_NewMembers = 'Create Table $Table(R_ID $Inc, M_ID varChar(15),' +
       'M_Name varChar(32), M_Py varChar(25), M_Card varChar(32),' +
       'M_Phone varChar(32), M_Sex Char(1), M_Level varChar(100),' +
       'M_JoinDate DateTime, M_ValidDate DateTime, ' +
       'M_BorrowNum Integer, M_BorrowBooks Integer,' +
       'M_BuyNum Integer, M_BuyBooks Integer,' +
       'M_NoReturnAllowed Integer,' +
       'M_MonCH Integer, M_MonCHHas Integer,' +
       'M_MonEN Integer, M_MonENHas Integer, M_Month varChar(10),' +
       'M_PlayArea Integer, M_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   ��Ա����: Members
   *.R_ID: ��¼���
   *.M_ID: ��Ա���
   *.M_Name,M_Py: ��Ա����
   *.M_Card: ��Ա����
   *.M_Phone: �ֻ���
   *.M_Sex: �Ա�
   *.M_Level: ��Ա�ȼ�
   *.M_JoinDate: ���ʱ��
   *.M_ValidDate: ��Чʱ��
   *.M_BorrowNum: ���Ĵ���
   *.M_BorrowBooks: �鱾��
   *.M_BuyNum: �������
   *.M_BuyBooks: ������
   *.M_NoReturnAllowed: ������δ���ı���
   *.M_MonCH: �ɽ������ı���
   *.M_MonCHHas: ���������ѽ�
   *.M_MonEN: �ɽ������ı���
   *.M_MonENHas: ����Ӣ���ѽ�
   *.M_Month: �����·�
   *.M_PlayArea: ����������
   *.M_Memo: ��ע��Ϣ
  -----------------------------------------------------------------------------}

  sSQL_NewInOutMoney = 'Create Table $Table(R_ID $Inc, M_MemID varChar(15),' +
       'M_MemName varChar(80), M_Type Char(1), M_Payment varChar(100),' +
       'M_Money $Float, M_Man varChar(32),' +
       'M_Date DateTime, M_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   �������ϸ: InOutMoney
   *.M_MemID: ��Ա���
   *.M_MemName:��Ա����
   *.M_Type: ���,����
   *.M_Payment:���ʽ
   *.M_Money:���ɽ��
   *.M_Date:��������
   *.M_Man:������
   *.M_Memo:����
  -----------------------------------------------------------------------------}

  sSQL_NewBooks = 'Create Table $Table(R_ID $Inc, B_ID varChar(15),' +
       'B_ISBN varChar(32), B_Name varChar(100), B_Py varChar(100),' +
       'B_Author varChar(80), B_Lang varChar(80), B_Class varChar(80),' +
       'B_NumAll Integer, B_NumIn Integer, B_NumOut Integer,' +
       'B_NumSale Integer, B_Valid Char(1),' +
       'B_Man varChar(32), B_Date DateTime, B_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   ͼ�鵵��: Books
   *.B_ID: ͼ����
   *.B_ISBN: isbn
   *.B_Name,B_Py: ͼ������
   *.B_Author:����
   *.B_Lang:����
   *.B_Class:����
   *.B_NumAll: �ܿ��
   *.B_NumIn: δ����
   *.B_NumOut: �ѳ���
   *.B_NumSale: �۳���
   *.B_Valid: ��Ч(Y/N)
   *.B_Date:��������
   *.B_Man:������
   *.B_Memo:��ע
  -----------------------------------------------------------------------------}

  sSQL_NewBookDtl = 'Create Table $Table(R_ID $Inc, D_ID varChar(15),' +
       'D_Book varChar(15), D_ISBN varChar(32),' +
       'D_Name varChar(100), D_Py varChar(100),' +
       'D_Author varChar(80), D_AuthorPy varChar(80),' +
       'D_Publisher varChar(80), D_PubTime varChar(80), D_Provider varChar(80),' +
       'D_PubPrice $Float, D_GetPrice $Float, D_SalePrice $Float,' +
       'D_NumAll Integer, D_NumIn Integer, D_NumOut Integer,' +
       'D_NumSale Integer, D_Valid Char(1),' +
       'D_Man varChar(32), D_Date DateTime, D_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   ͼ����ϸ: BookDtl
   *.D_ID: ͼ����
   *.D_Book: ͼ�鵵��
   *.D_ISBN: isbn
   *.D_Name,D_Py: ͼ������
   *.D_Author,D_AuthorPy:����
   *.D_Publisher:������
   *.D_PubTime:���
   *.D_Provider:��Ӧ��
   *.D_PubPrice:����
   *.D_GetPrice: �ɹ���
   *.D_SalePrice: ���ۼ�
   *.D_NumAll: �ܿ��
   *.D_NumIn: δ����
   *.D_NumOut: �ѳ���
   *.D_NumSale: �۳���
   *.D_Valid: ��Ч(Y/N)
   *.D_Man:�����
   *.D_Date:�������
   *.D_Memo: ��ע
  -----------------------------------------------------------------------------}

  sSQL_NewBookInOut = 'Create Table $Table(R_ID $Inc, I_Book varChar(15),' +
       'I_BookDtl varChar(15), I_Type Char(1), I_Num Integer, I_NumBefore Integer,' +
       'I_Man varChar(32), I_Date DateTime, I_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   ͼ������: BookInOut
   *.I_Book,I_BookDtl: ͼ����
   *.I_Type: ���/����
   *.I_Num: ͼ������
   *.I_NumBefore: δ���ǰ���
   *.I_Man:�����
   *.I_Date:�������
   *.I_Memo: ��ע
  -----------------------------------------------------------------------------}

  sSQL_NewBookBorrow = 'Create Table $Table(R_ID $Inc, B_Member varChar(15),' +
       'B_Book varChar(15), B_BookDtl varChar(15), B_Type Char(1),' +
       'B_NumBorrow Integer, B_NumReturn Integer,' +
       'B_ManBorrow varChar(32), B_ManReturn varChar(32),' +
       'B_DateBorrow DateTime, B_DateReturn DateTime, B_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   ͼ�����: BookBorrow
   *.B_Member: ��Ա���
   *.B_Book,B_BookDtl: ͼ����
   *.B_Type: ����/����
   *.B_NumBorrow: ��������
   *.B_NumReturn: �黹����
   *.B_ManBorrow,B_ManReturn:������
   *.B_DateBorrow,B_DateReturn:����
   *.B_Memo: ��ע
  -----------------------------------------------------------------------------}

  sSQL_NewBookSale = 'Create Table $Table(R_ID $Inc, S_Member varChar(15),' +
       'S_Book varChar(15), S_BookDtl varChar(15), S_Type Char(1),' +
       'S_Num Integer, S_Return Integer,' +
       'S_Man varChar(32), S_Date DateTime, S_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   ͼ������: BookSale
   *.S_Member: ��Ա���
   *.S_Book,S_BookDtl: ͼ����
   *.S_Type: ����/�˻�
   *.S_Num: ����
   *.S_Return: �˻�
   *.S_Man:������
   *.S_Date:����
   *.S_Memo: ��ע
  -----------------------------------------------------------------------------}

  sSQL_NewPlayGoods = 'Create Table $Table(R_ID $Inc, P_Member varChar(15),' +
       'P_GoodsID varChar(32), P_GoodsName varChar(100), P_GoodsPy varChar(100),' +
       'P_Number Integer, P_Price $Float, P_Money $Float, P_Payment varChar(100),' +
       'P_Man varChar(32), P_Date DateTime, P_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   ��������: PlayGoods
   *.P_Member: ��Ա���
   *.P_GoodsID: ��Ʒ��ʶ
   *.P_GoodsName,P_GoodsPy: ��Ʒ����
   *.P_Number: ��Ʒ����
   *.P_Price: ��Ʒ�۸�
   *.P_Money: ��Ʒ���
   *.P_Payment: ֧����ʽ
   *.P_Man:������
   *.P_Date:����
   *.P_Memo: ��ע
  -----------------------------------------------------------------------------}

implementation

//------------------------------------------------------------------------------
//Desc: ���ϵͳ����
procedure AddSysTableItem(const nTable,nNewSQL: string);
var nP: PSysTableItem;
begin
  New(nP);
  gSysTableList.Add(nP);

  nP.FTable := nTable;
  nP.FNewSQL := nNewSQL;
end;

//Desc: ϵͳ��
procedure InitSysTableList;
begin
  gSysTableList := TList.Create;

  AddSysTableItem(sTable_SysDict, sSQL_NewSysDict);
  AddSysTableItem(sTable_ExtInfo, sSQL_NewExtInfo);
  AddSysTableItem(sTable_SysLog, sSQL_NewSysLog);
  AddSysTableItem(sTable_SerialBase, sSQL_NewSerialBase);
  AddSysTableItem(sTable_BaseInfo, sSQL_NewBaseInfo);

  AddSysTableItem(sTable_Members, sSQL_NewMembers);
  AddSysTableItem(sTable_InOutMoney, sSQL_NewInOutMoney);
  AddSysTableItem(sTable_Books, sSQL_NewBooks);
  AddSysTableItem(sTable_BookDetail, sSQL_NewBookDtl);
  AddSysTableItem(sTable_BookInOut, sSQL_NewBookInOut);
  AddSysTableItem(sTable_BookBorrow, sSQL_NewBookBorrow);
  AddSysTableItem(sTable_BookSale, sSQL_NewBookSale);
  AddSysTableItem(sTable_PlayGoods, sSQL_NewPlayGoods);
end;

//Desc: ����ϵͳ��
procedure ClearSysTableList;
var nIdx: integer;
begin
  for nIdx:= gSysTableList.Count - 1 downto 0 do
  begin
    Dispose(PSysTableItem(gSysTableList[nIdx]));
    gSysTableList.Delete(nIdx);
  end;

  FreeAndNil(gSysTableList);
end;

initialization
  InitSysTableList;
finalization
  ClearSysTableList;
end.


