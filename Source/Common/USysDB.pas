{*******************************************************************************
  作者: dmzn@163.com 2008-08-07
  描述: 系统数据库常量定义

  备注:
  *.自动创建SQL语句,支持变量:$Inc,自增;$Float,浮点;$Integer=sFlag_Integer;
    $Decimal=sFlag_Decimal;$Image,二进制流
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
  //系统表项

  PNameAndValue = ^TNameAndValue;
  TNameAndValue = record
    FName     : string;     //数据名称
    FDesc     : string;     //数据描述
    FValue    : string;     //数据取值
  end;

  //基础档案
  PBaseDataItem = ^TBaseDataItem;
  TBaseDataItem = record
    FRecord   : string;     //记录编号
    FGroup    : string;     //分组标识
    FGroupName: string;     //分组名称
    FName     : string;     //名称
    FParamA   : string;     //参数A
    FParamB   : string;     //参数B
    FDefault  : Boolean;    //默认值
    FMemo     : string;     //备注信息
  end;

var
  gSysTableList: TList = nil;                        //系统表数组
  gSysDBType: TSysDatabaseType = dtSQLServer;        //系统数据类型

//------------------------------------------------------------------------------
const
  //自增字段
  sField_Access_AutoInc          = 'Counter';
  sField_SQLServer_AutoInc       = 'Integer IDENTITY (1,1) PRIMARY KEY';

  //小数字段
  sField_Access_Decimal          = 'Float';
  sField_SQLServer_Decimal       = 'Decimal(15, 5)';

  //图片字段
  sField_Access_Image            = 'OLEObject';
  sField_SQLServer_Image         = 'Image';

  //日期相关
  sField_SQLServer_Now           = 'getDate()';

const
  sFlag_Base_Lanuage             = 'lanuage';        //基础档案: 语言
  sFlag_Base_Author              = 'author';         //基础档案: 作者
  sFlag_Base_Publish             = 'publish';        //基础档案: 出版社
  sFlag_Base_Provide             = 'provide';        //基础档案: 供货商
  sFlag_Base_Age                 = 'age';            //基础档案: 年龄段
  sFlag_Base_Payment             = 'payment';        //基础档案: 付款方式
  sFlag_Base_BookClass           = 'bookclass';      //基础档案: 图书分类
  sFlag_Base_MemLevel            = 'memlevel';       //基础档案: 会员等级
  sFlag_Base_Goods               = 'goods';          //基础档案: 零售商品

  sFlag_Language_CN               = '中文';
  sFlag_Language_EN               = '英文';
  sFlag_Language_Default          = sFlag_Language_CN + '|' + sFlag_Language_EN;

  sFlag_Member_Level_VIP         = 'VIP会员';
  sFlag_Member_Level_Common      = '普通会员';
  sFlag_Member_Levels            = sFlag_Member_Level_VIP + '|' +
                                   sFlag_Member_Level_Common;
  //会员等级列表

  cBaseData: array[0..8] of TNameAndValue = (
    (FName: sFlag_Base_Lanuage;  FDesc: '语言';     FValue: sFlag_Language_Default),
    (FName: sFlag_Base_Author;   FDesc: '作者';     FValue: ''),
    (FName: sFlag_Base_Publish;  FDesc: '出版社';   FValue: ''),
    (FName: sFlag_Base_Provide;  FDesc: '供应商';   FValue: ''),
    (FName: sFlag_Base_Age;      FDesc: '年龄段';   FValue: ''),
    (FName: sFlag_Base_MemLevel; FDesc: '会员等级'; FValue: sFlag_Member_Levels),
    (FName: sFlag_Base_Payment;  FDesc: '付款方式'; FValue: ''),
    (FName: sFlag_Base_BookClass;FDesc: '图书分类'; FValue: ''),
    (FName: sFlag_Base_Goods;    FDesc: '零售商品'; FValue: '')
  ); //基础项列表

ResourceString
  {*权限项*}
  sPopedom_Read       = 'A';                         //浏览
  sPopedom_Add        = 'B';                         //添加
  sPopedom_Edit       = 'C';                         //修改
  sPopedom_Delete     = 'D';                         //删除
  sPopedom_Preview    = 'E';                         //预览
  sPopedom_Print      = 'F';                         //打印
  sPopedom_Export     = 'G';                         //导出

  {*相关标记*}
  sFlag_Yes           = 'Y';                         //是
  sFlag_No            = 'N';                         //否
  sFlag_Enabled       = 'Y';                         //启用
  sFlag_Disabled      = 'N';                         //禁用

  sFlag_Integer       = 'I';                         //整数
  sFlag_Decimal       = 'D';                         //小数

  sFlag_Male          = 'M';                         //性别: 男
  sFlag_Female        = 'F';                         //性别: 女

  sFlag_In            = 'I';                         //方向: 进系统
  sFlag_Out           = 'O';                         //方向: 出系统

  sFlag_ID_BusGroup   = 'BusFunction';               //业务编码组
  sFlag_ID_Member     = 'Bus_Member';                //会员编号
  sFlag_ID_Books      = 'Bus_Books';                 //图书档案编号
  sFlag_ID_BookDtl    = 'Bus_BookDtl';               //图书明细编号

  sFlag_PlayArea      = 'yw001';                     //游玩区标识
  sFlag_Member        = 'Member';                    //会员相关

  {*数据表*}
  sTable_Group        = 'Sys_Group';                 //用户组
  sTable_User         = 'Sys_User';                  //用户表
  sTable_Menu         = 'Sys_Menu';                  //菜单表
  sTable_Popedom      = 'Sys_Popedom';               //权限表
  sTable_PopItem      = 'Sys_PopItem';               //权限项
  sTable_Entity       = 'Sys_Entity';                //字典实体
  sTable_DictItem     = 'Sys_DataDict';              //字典明细

  sTable_SysDict      = 'Sys_Dict';                  //系统字典
  sTable_ExtInfo      = 'Sys_ExtInfo';               //附加信息
  sTable_SysLog       = 'Sys_EventLog';              //系统日志
  sTable_SerialBase   = 'Sys_SerialBase';            //编码种子
  sTable_BaseInfo     = 'Sys_BaseInfo';              //基础信息
  sTable_Members      = 'M_Members';                 //会员档案
  sTable_InOutMoney   = 'M_InOutMoney';              //资金明细
  sTable_PlayGoods    = 'M_PlayGoods';               //游玩零售

  sTable_Books        = 'B_Books';                   //图书
  sTable_BookDetail   = 'B_BookDtl';                 //图书明细(丛书)
  sTable_BookInOut    = 'B_BookInOut';               //出入库记录
  sTable_BookBorrow   = 'B_BookBorrow';              //图书借阅
  sTable_BookSale     = 'B_BookSale';                //图书销售

  {*新建表*}
  sSQL_NewSysDict = 'Create Table $Table(D_ID $Inc, D_Name varChar(15),' +
       'D_Desc varChar(30), D_Value varChar(50), D_Memo varChar(20),' +
       'D_ParamA $Float, D_ParamB varChar(50), D_Index Integer Default 0)';
  {-----------------------------------------------------------------------------
   系统字典: SysDict
   *.D_ID: 编号
   *.D_Name: 名称
   *.D_Desc: 描述
   *.D_Value: 取值
   *.D_Memo: 相关信息
   *.D_ParamA: 浮点参数
   *.D_ParamB: 字符参数
   *.D_Index: 显示索引
  -----------------------------------------------------------------------------}
  
  sSQL_NewExtInfo = 'Create Table $Table(I_ID $Inc, I_Group varChar(20),' +
       'I_ItemID varChar(20), I_Item varChar(30), I_Info varChar(500),' +
       'I_ParamA $Float, I_ParamB varChar(50), I_Index Integer Default 0)';
  {-----------------------------------------------------------------------------
   扩展信息表: ExtInfo
   *.I_ID: 编号
   *.I_Group: 信息分组
   *.I_ItemID: 信息标识
   *.I_Item: 信息项
   *.I_Info: 信息内容
   *.I_ParamA: 浮点参数
   *.I_ParamB: 字符参数
   *.I_Memo: 备注信息
   *.I_Index: 显示索引
  -----------------------------------------------------------------------------}
  
  sSQL_NewSysLog = 'Create Table $Table(L_ID $Inc, L_Date DateTime,' +
       'L_Man varChar(32),L_Group varChar(20), L_ItemID varChar(20),' +
       'L_KeyID varChar(20), L_Event varChar(220))';
  {-----------------------------------------------------------------------------
   系统日志: SysLog
   *.L_ID: 编号
   *.L_Date: 操作日期
   *.L_Man: 操作人
   *.L_Group: 信息分组
   *.L_ItemID: 信息标识
   *.L_KeyID: 辅助标识
   *.L_Event: 事件
  -----------------------------------------------------------------------------}

  sSQL_NewSerialBase = 'Create Table $Table(R_ID $Inc, B_Group varChar(15),' +
       'B_Object varChar(32), B_Prefix varChar(25), B_IDLen Integer,' +
       'B_Base Integer, B_Date DateTime)';
  {-----------------------------------------------------------------------------
   串行编号基数表: SerialBase
   *.R_ID: 编号
   *.B_Group: 分组
   *.B_Object: 对象
   *.B_Prefix: 前缀
   *.B_IDLen: 编号长
   *.B_Base: 基数
   *.B_Date: 参考日期
  -----------------------------------------------------------------------------}

  sSQL_NewBaseInfo = 'Create Table $Table(B_ID $Inc, B_Group varChar(15),' +
       'B_GroupName varChar(50), B_Text varChar(100), B_Py varChar(25),' +
       'B_ParamA varChar(100), B_ParamB varChar(100), B_Default Char(1),' +
       'B_Memo varChar(50), B_PID Integer, B_Index Float)';
  {-----------------------------------------------------------------------------
   基本信息表: BaseInfo
   *.B_ID: 编号
   *.B_Group: 分组
   *.B_Text: 内容
   *.B_Py: 拼音简写
   *.B_ParamA,B_ParamB:参数
   *.B_Default: 默认
   *.B_Memo: 备注信息
   *.B_PID: 上级节点
   *.B_Index: 创建顺序
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
   会员档案: Members
   *.R_ID: 记录编号
   *.M_ID: 会员编号
   *.M_Name,M_Py: 会员名称
   *.M_Card: 会员卡号
   *.M_Phone: 手机号
   *.M_Sex: 性别
   *.M_Level: 会员等级
   *.M_JoinDate: 入会时间
   *.M_ValidDate: 有效时间
   *.M_BorrowNum: 借阅次数
   *.M_BorrowBooks: 书本数
   *.M_BuyNum: 购买次数
   *.M_BuyBooks: 购买本数
   *.M_NoReturnAllowed: 允许借出未还的本数
   *.M_MonCH: 可借阅中文本数
   *.M_MonCHHas: 当月中文已借
   *.M_MonEN: 可借阅外文本数
   *.M_MonENHas: 当月英文已借
   *.M_Month: 计数月份
   *.M_PlayArea: 游玩区计数
   *.M_Memo: 备注信息
  -----------------------------------------------------------------------------}

  sSQL_NewInOutMoney = 'Create Table $Table(R_ID $Inc, M_MemID varChar(15),' +
       'M_MemName varChar(80), M_Type Char(1), M_Payment varChar(100),' +
       'M_Money $Float, M_Man varChar(32),' +
       'M_Date DateTime, M_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   出入金明细: InOutMoney
   *.M_MemID: 会员编号
   *.M_MemName:会员姓名
   *.M_Type: 入金,出金
   *.M_Payment:付款方式
   *.M_Money:缴纳金额
   *.M_Date:操作日期
   *.M_Man:操作人
   *.M_Memo:描述
  -----------------------------------------------------------------------------}

  sSQL_NewBooks = 'Create Table $Table(R_ID $Inc, B_ID varChar(15),' +
       'B_ISBN varChar(32), B_Name varChar(100), B_Py varChar(100),' +
       'B_Author varChar(80), B_Lang varChar(80), B_Class varChar(80),' +
       'B_NumAll Integer, B_NumIn Integer, B_NumOut Integer,' +
       'B_NumSale Integer, B_Valid Char(1),' +
       'B_Man varChar(32), B_Date DateTime, B_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   图书档案: Books
   *.B_ID: 图书编号
   *.B_ISBN: isbn
   *.B_Name,B_Py: 图书名称
   *.B_Author:作者
   *.B_Lang:语种
   *.B_Class:分类
   *.B_NumAll: 总库存
   *.B_NumIn: 未出借
   *.B_NumOut: 已出借
   *.B_NumSale: 售出量
   *.B_Valid: 有效(Y/N)
   *.B_Date:建档日期
   *.B_Man:建档人
   *.B_Memo:备注
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
   图书明细: BookDtl
   *.D_ID: 图书编号
   *.D_Book: 图书档案
   *.D_ISBN: isbn
   *.D_Name,D_Py: 图书名称
   *.D_Author,D_AuthorPy:作者
   *.D_Publisher:出版商
   *.D_PubTime:版次
   *.D_Provider:供应商
   *.D_PubPrice:定价
   *.D_GetPrice: 采购价
   *.D_SalePrice: 销售价
   *.D_NumAll: 总库存
   *.D_NumIn: 未出借
   *.D_NumOut: 已出借
   *.D_NumSale: 售出量
   *.D_Valid: 有效(Y/N)
   *.D_Man:入库人
   *.D_Date:入库日期
   *.D_Memo: 备注
  -----------------------------------------------------------------------------}

  sSQL_NewBookInOut = 'Create Table $Table(R_ID $Inc, I_Book varChar(15),' +
       'I_BookDtl varChar(15), I_Type Char(1), I_Num Integer, I_NumBefore Integer,' +
       'I_Man varChar(32), I_Date DateTime, I_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   图书出入库: BookInOut
   *.I_Book,I_BookDtl: 图书编号
   *.I_Type: 入库/出库
   *.I_Num: 图书数量
   *.I_NumBefore: 未入库前库存
   *.I_Man:入库人
   *.I_Date:入库日期
   *.I_Memo: 备注
  -----------------------------------------------------------------------------}

  sSQL_NewBookBorrow = 'Create Table $Table(R_ID $Inc, B_Member varChar(15),' +
       'B_Book varChar(15), B_BookDtl varChar(15), B_Type Char(1),' +
       'B_NumBorrow Integer, B_NumReturn Integer,' +
       'B_ManBorrow varChar(32), B_ManReturn varChar(32),' +
       'B_DateBorrow DateTime, B_DateReturn DateTime, B_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   图书借阅: BookBorrow
   *.B_Member: 会员编号
   *.B_Book,B_BookDtl: 图书编号
   *.B_Type: 借阅/购买
   *.B_NumBorrow: 借阅数量
   *.B_NumReturn: 归还数量
   *.B_ManBorrow,B_ManReturn:操作人
   *.B_DateBorrow,B_DateReturn:日期
   *.B_Memo: 备注
  -----------------------------------------------------------------------------}

  sSQL_NewBookSale = 'Create Table $Table(R_ID $Inc, S_Member varChar(15),' +
       'S_Book varChar(15), S_BookDtl varChar(15), S_Type Char(1),' +
       'S_Num Integer, S_Return Integer,' +
       'S_Man varChar(32), S_Date DateTime, S_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   图书销售: BookSale
   *.S_Member: 会员编号
   *.S_Book,S_BookDtl: 图书编号
   *.S_Type: 销售/退还
   *.S_Num: 数量
   *.S_Return: 退回
   *.S_Man:操作人
   *.S_Date:日期
   *.S_Memo: 备注
  -----------------------------------------------------------------------------}

  sSQL_NewPlayGoods = 'Create Table $Table(R_ID $Inc, P_Member varChar(15),' +
       'P_GoodsID varChar(32), P_GoodsName varChar(100), P_GoodsPy varChar(100),' +
       'P_Number Integer, P_Price $Float, P_Money $Float, P_Payment varChar(100),' +
       'P_Man varChar(32), P_Date DateTime, P_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   游玩零售: PlayGoods
   *.P_Member: 会员编号
   *.P_GoodsID: 商品标识
   *.P_GoodsName,P_GoodsPy: 商品名称
   *.P_Number: 商品数量
   *.P_Price: 商品价格
   *.P_Money: 商品金额
   *.P_Payment: 支付方式
   *.P_Man:操作人
   *.P_Date:日期
   *.P_Memo: 备注
  -----------------------------------------------------------------------------}

implementation

//------------------------------------------------------------------------------
//Desc: 添加系统表项
procedure AddSysTableItem(const nTable,nNewSQL: string);
var nP: PSysTableItem;
begin
  New(nP);
  gSysTableList.Add(nP);

  nP.FTable := nTable;
  nP.FNewSQL := nNewSQL;
end;

//Desc: 系统表
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

//Desc: 清理系统表
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


