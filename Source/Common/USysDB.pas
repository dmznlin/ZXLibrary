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
    FName: string;      //数据名称
    FDesc: string;      //数据描述
    FValue: string;     //数据取值
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
  
  sFlag_Base_MemLevel            = 'memlevel';       //基础档案: 会员等级
  sFlag_Member_Level_VIP         = 'VIP会员';
  sFlag_Member_Level_Common      = '普通会员';
  sFlag_Member_Levels            = sFlag_Member_Level_VIP + '|' +
                                   sFlag_Member_Level_Common;
  //会员等级列表

  cBaseData: array[0..6] of TNameAndValue = (
    (FName: sFlag_Base_Lanuage;  FDesc: '语言';     FValue: ''),
    (FName: sFlag_Base_Author;   FDesc: '作者';     FValue: ''),
    (FName: sFlag_Base_Publish;  FDesc: '出版社';   FValue: ''),
    (FName: sFlag_Base_Provide;  FDesc: '供应商';   FValue: ''),
    (FName: sFlag_Base_Age;      FDesc: '年龄段';   FValue: ''),
    (FName: sFlag_Base_MemLevel; FDesc: '会员等级'; FValue: sFlag_Member_Levels),
    (FName: sFlag_Base_Payment;  FDesc: '付款方式'; FValue: '')
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
  sFlag_Female        = 'W';                         //性别: 女

  sFlag_InMoney       = 'I';                         //出入金: 入金
  sFlag_OutMoney      = 'O';                         //出入金: 出金

  sFlag_ID_BusGroup   = 'BusFunction';               //业务编码组
  sFlag_ID_Member     = 'Bus_Member';                //会员编号

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
       'B_Params varChar(200), B_Default Char(1),' +
       'B_Memo varChar(50), B_PID Integer, B_Index Float)';
  {-----------------------------------------------------------------------------
   基本信息表: BaseInfo
   *.B_ID: 编号
   *.B_Group: 分组
   *.B_Text: 内容
   *.B_Py: 拼音简写
   *.B_Params: 附加参数
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
       'M_BuyNum Integer, M_BuyBooks Integer, M_Memo varChar(50))';
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
   *.M_Memo: 备注信息
  -----------------------------------------------------------------------------}

  sSQL_NewInOutMoney = 'Create Table $Table(R_ID $Inc, M_MemID varChar(15),' +
       'M_MemName varChar(80), M_Type Char(1), M_Payment varChar(100),' +
       'M_Money Decimal(15,5), M_Man varChar(32),' +
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


