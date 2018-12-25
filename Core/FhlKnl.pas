unit FhlKnl;

interface

uses
  Windows, Messages, SysUtils, Classes,Controls,Dialogs, Forms, Graphics,
  Db, ADODB, ImgList, grids,dbgrids, ComCtrls, DbCtrls,StdCtrls, Variants,Menus,
  ActnList, QrCtrls, QuickRpt, winsock, Printers,IdTCPConnection, IdTCPClient,TypInfo,
  Registry,IdHTTP,StrUtils,UnitAdoDataset,UnitDBFile,UPublicFunction,SqlTimSt,ExtCtrls ,
  Jpeg ,nb30 ,Provider ,DBClient;

const
  ClCtrlEnter:integer=15663080;
type TcontrolEx=class(Tcontrol)
end;



type
  TBeforeDeleteDict = record               //删除前提示
    Id:string;
    Hint: String;
    Proc:String;                          //删除触发存储过程
    EdtSysParams:String;
    EdtUsrParams:String;
    ErrorHint:String;
    DelRitId:String;                     //检查否有删除权限
    CmdType:integer;
end;

type
  TAfterPostDict = record          //T205
    Id:string;
    fProc:String;
    fSysParams:String;
    fDataParamFlds:String;
    fErrorHint:String;
    CmdType:integer;
  end;

type                                         //更改之前触发
  TBeforePostDict = record
    Id:string;
    AutoKeyId:String;
    AutoKeyFld:String;
    SameValFlds:wideString;
    SameValHint:wideString;
    EdtProc:String;
    EdtSysParams:String;
    EdtUsrParams:String;
    AbortStr:String;
    WarningStr:String;
    PostHint:wideString;
    PostSysParams:String;
    PostUsrParams:String;
    AddRitId:String;
    EditRitId:String;
    CmdType:integer;
end;


type
  TFinderDict = record          //自定义查询窗体
    Id:String;
    fItemIdx:Integer;
    fCompareIdx:Integer;
    fSelect:wideString;
    fWhere:wideString;
    fGroup:wideString;
    fHaving:wideString;
    fOrder:wideString;
    fSysParams:wideString;
    fDtlSql:wideString;
  end;


type
  TTreeMgrDict = record
    Id:String;
    Caption:String;
    TreeId:String;
  end;


type
    TTreeGridDict = record
    Id:String;
    Caption:String;
    DbGridId:String;
    TreeId:String;
    EditorId:String;
    Actions:String;
    IsOpen:Boolean;
    ClassFld:String;
    WriteRitId:String;
    DeleteRitId:String;
    PrintRitId:String;
    GridUserMenuIDs:integer;
    ParamFLDs:string;
  end;

type
  TTreeDlgDict = Record
    Id:String;
    Caption:String;
    ChgFldNames:String;
    LkpChgFldNames:String;
    RootText:String;
    CodeFldName:String;
    NameFldName:String;
    LkpFld:TField;
    IsExpand:Boolean;
    ParentSelect:Boolean;
   end;

  {
     ADict.Id:=FieldByName('F01').asString;
     ADict.Caption:=FieldByName('F02').asString;
     ADict.ChgFldNames:=FieldByName('F04').asString;
     ADict.LkpChgFldNames:=FieldByName('F05').asString;
     ADict.RootText:=FieldByName('F06').asString;
     ADict.CodeFldName:=FieldByName('F07').asString;
     ADict.NameFldName:=FieldByName('F08').asString;
     ADict.IsExpand:=FieldByName('F09').asBoolean;
     ADict.ParentSelect:=FieldByName('F10').AsBoolean;
     }
type tImageDlgDict=record
      id:string;
      Caption:string;
      LkpFld:TField;
      SourceFldName:string;
      end;

type
  TTabGridDict = record             //用于参考历史记录
   Id:String;
   Caption:String;
   DbGridId:String;
   Width:Integer;
   Height:Integer;
   CanInsert:Boolean;
  end;

type
  TTabEditorDict = Record              //add ,edit,delete record
   Id:String;
   Caption:String;
   BoxIds:String;
   DataSetId:String;
   Width:Integer;
   Height:Integer;
  end;
type
  TPickDictPickMulPage = record             //导入界面
   Id:String;
   Catpion:String;
   FromKeyFlds:String;
   ToKeyFlds:String;
   FromCpyFlds:wideString;
   ToCpyFlds:wideString;

   MtParams:String;
   IsOpen:Boolean;
   Actions:String;
   IsRepeat:Boolean;
   BoxID:string;
   
   DbGridIds:String;
   DbGridCaptions:String;
   mtDataSetId:string;//public
   DLParams:String;

end;

type
  TPickDict = record             //用于添加明细
   Id:String;
   Catpion:String;
   FromKeyFlds:String;
   ToKeyFlds:String;
   FromCpyFlds:wideString;
   ToCpyFlds:wideString;
   DbGridId:String;
   MtParams:String;
   IsOpen:Boolean;
   Actions:String;
   IsRepeat:Boolean;

   //2006-6-16 加入权限控制
   WarePropRitId:string ;     //器件属性权限
   slPriceInRfsRitID:string;  //进参权限
   slPriceOutRfsRitID:string ;// 售参 权限
   phQuoteRitID:string;       //供报   权限
   ydWarepropRitID:string;          // 库参 权限
   phOrderdlRitID:string;      //订参  权限
  end;                         

type
  TMore2MoreDict = record
    Id:String;
    Caption:String;
    Subject:String;
    DbGridId:String;
    mtFld:String;
    dlFld:String;
    LkpType:String;
    EditRitId:String;
  end;

type
  TLookupDict = Record
    Id:String;
    Caption:String;
    DbGridId:String;
    LkpChgFldNames:String;
    ChgFldNames:String;
    MyFld:TField;
    LkpFld:TField;
    LkpFldName:String;
    FilterFldName:String;
    DefIdx:Integer;

    fUserParametersFld:string;
   end;

type TEditorDict = Record
       Id:String;
       Caption:String;
       BoxIds:String;
       Width:Integer;
       Height:Integer;
       CpyFlds:wideString;
       DataSetId:String;
       PrintRitId:String;
       Actions:string;
       TabCaptins:string;
       BtmPrintID:String;
       OpenParameterFields:string;//for crm

       billcode:string;
       PKFieldName:string;
       CheckProc:string;
       UnCheckProc:string;
       ChkFieldName:string;
       IsChkValue:string;
     end;


type
  TTreeEditorDict = record
    Id:String;
    FrmCaption:String;
    DbGridId:String;
    BoxId:String;
    RootCaption:String;
    CodeFld:String;
    NameFld:String;
    PrintRitId:String;
    MultiLevel:boolean;
  end;


type TAnalyserDict = record
       Id:String;
       Caption:String;
       DbGridId:String;
       mtDataSetId:String;
       mtOpenParamFlds:String;
       LinkT401Pk:string;
       TopBoxId:String;
       BtmBoxId:String;
       IsOpen:Boolean;
       Actions:String; //actid 50 actbtn   like billex
       DblActIdx:Integer;
       Tag:String;


    {
       DlgIdx:Integer;
       FinderId:String;
       dsFinderId:String;
       SubSectionId:String;
        }
       QryParamsFLDs    :string ;
    //   Modeltype      :string ;//  f17
    //   FrmID          :string ;          // f18 varchar(20) ,--
       printID        :string ;
     end;

type
  TBilOpnDlgDict = Record
    Id:string;
    DbGridId:integer;
    KeyFldName:string;
    BillTitle:string;
    SearchIdx:integer;
  end;

type
  TExcPrcDict = Record
    Id:String;
    ProcName:String;
    SysParams:String;
    UsrParams:String;
    ReturnBool:Boolean;
    ResultHint:String;
    RightId:String;
  end;

type
  TBillDict = Record
       Id:String;
       mttblid:String;
       mtDataSetId:String;
       mtGridId:String;
       dlGridId:String;
       TopBoxId:String;
       BtmBoxId:String;
       mkeyfld:String;
       fkeyfld:String;
       savproc:String;
       chkproc:String;
       unchkproc:string;
       vldproc:String;
       clsproc:String;
       pickid:String;
       BillCnName:wideString;
       TitleLabelFontColor:String;
       TitleLabelFontSize:Integer;
       TitleLabelFontName:String;
       mtSumFlds:Variant;
       dlSumFlds:Variant;
       QtyFld:String;
       BillCode:String;
       ReadRitId:String;
       WriteRitId:String;
       CheckRitId:String;
       UnChkRitId:String;
       PrintRitId:String;
       PickIDMulPage:string;
     end;

type TBillDictEx=Record
        BillCode:string;
        ID :string ;
        Maincaption:string ;
        ActID :integer;
        MtDataSetID:string ;
        TopBoxID:string;
        BtmBoxID:string;
        DLGridID:string  ;
     //   DLDatSetID:string ;
        OpenID:string ;
        ImportID:string ;
        mtSumFlds:string ;
        dlSumFlds:string ;
        QtyFld:String;
        mkeyfld:String;
        fkeyfld:String;
        ChkProc:String;
        UnChkProc:String;
        ReportID:String;
        DlPriceFld  :String;
        DlFundFld:String;


        ChkRightId:string ;
        UnChkRightId:string ;
        IsNeedEdit:boolean;

        ChkFieldName:string;
        IsChkValue:string;
        AutoKeyID :string;

 //F21 varchar(20) not null ,  ChkRightId
 //F22 varchar(20) not null  UnChkRightId
end ;

type
  TdsFinderDict = Record
       Id:String;
       Caption:String;
       BoxIds:String;
       DataSetId:String;
       Width:Integer;
       Height:Integer;
       Select:wideString;
       Pre:String;
     end;
type
  TFldInitDict = record
       Name:String;
       TypeId:Integer;
       Format:String;
       DisplayLabel:String;
       Required:Boolean;
       DefaultVal:String;
       FldId:Integer;
       Size:Integer;
       KindId:String;
       KeyFlds:String;
       LkpKeyFlds:String;
       LkpResultFld:String;
       LkpDsId:Integer;
       MinValue :string ;
       MaxValue :string ;
       formula:string;
       CalField:string;

end;

type
  TDSInitDict = record
       CommandText:wideString;
       SysParams:String;
       CommandTypeId:Integer;
       LockTypeId:Integer;
       Sort:wideString;
       Filter:wideString;
       AfterInsertId:Integer;
       BeforePostId:Integer;
       BeforeDeleteId:Integer;
       AfterPostId:Integer;
       OnCalcFieldId:Integer;
       AfterOpenId:Integer;
       TableName:string;
       ColorID:integer;
       DataSetUsage:string;  //LOOPUP,EDIT,REPORT
end;

type
  TDeleteDict = record
    Hint:wideString;
    Proc:String;
    SysParams:String;
    DataParamFlds:String;
    ErrorHint:String;
    DelRitId:String;
end;

type TMenuRightDict=record
      ColVisiableRitID:string; //列可视性权限
      ColOrderRitID:string;    //列顺序权限
end;


type  TSubInterFaceDict=record
    //一个subinterfaceID
    ID  :string;
    SubInterFaceID	:string;
    SubInterFaceName:string;
    SubInterFaceCount:integer;
    ModeltypeID	:integer;
    TreeGridID	:string;
    EditorID	:string;
end;
type TCrmTreeDict=record

//一个treeID对应
    treeID:integer;
    Name:string ;
    RootTxt:string;
    RootImageIDx:integer;
    NodeTextFld:string;
    NodeDataFld:string;
    datasetID:string;
    width:integer;

    TreeIDs:string;   //Parent id
    SubInterFaceID:string;
    SubInterFace  :       TSubInterFaceDict   ;

end;



type TCRMDict=record
    FrmID:integer;
    FormCaption:string;
   
    CrmTree:array of TCrmTreeDict;    //   一个 TreeIDs:string; 对应 一个CrmTree
    CrmTreeCount:integer;
    CrmTreeIDs  :string;

    MtDatasetID:string;
    MtBoxID:string;
    MtParameters:string;
    MainGridUserMenuIDs:integer;

    MainTreeGridID:string;  //T612 add parameterFields
    MainEditorID:integer;       //二选一
    MainActions:string;

    SubInterFace:array of TSubInterFaceDict    ;      // subinterFaceID :string;
    SubInterFaceCount:integer;
    SubinterFaceID:string;
    IsTreeGridEditorDock:boolean;//  MainEditor isDock or showmodal
    
end;
  {create table T627
(
F01 int primary key identity(1000,1),
F02 varchar(30)  not null,     -- caption
F03 varchar(20) ,              --   BoxID
F04 varchar(20) default '-1' , --treeid
F05 varchar(20)  not null ,    -- girdID
F06 varchar(20) default '',    -- filter conditions  eg name =1 date =today
F07 bit         ,              -- use uni filter and qry
F08 varchar(20) default '-1',  --Editor iD
F09 bit         ,              -- default open?
F10 int         ,              -- dblclick  act id
F11 varchar(20) default '-1'               --  ToolBtns id    T525
)
}

type TLkpImportDict=record
      id:integer;
      caption:string;
      Boxid:string;
      TreeID:integer;
      GridID:string;
      MainGridID:string;
      Filters:String;
      UseDefaultFilter:boolean;
      UseDefaultqry:boolean; //f14

      EditorID:string;
      IsOpen:boolean;
      DblClick:integer;
      ToolBtnsID:string;
      mtdatasetid:string;
      IniPramFields:string ;

      OpenProcFlds:String;

      ImportSourceFlds:string;
      ImportDectFlds:string;
      ImportPK:string;

      MImportSourceFlds:string;
      MImportDectFlds:string;
      MGridParameterFlds:string;

     // Formalgin :string ;// -- F15  Form algin      alLeft alRight,alButtom,alTop ,ShowModal
end;
    {F01  int identity(1000,1),
F03   varchar(50) ,--caption
F02 varchar(50) ,--acts  --btns
F04   varchar(50) ,--Boxid  --
F05   varchar(50) ,--CandidateGridID
F06   varchar(50) ,--SerialGridID
F07   varchar(50) ,-- serialNo lenght  params
F08   varchar(20) ,--Chkproc
F09   varchar(20)   --Unchk
F10   varchar(20)   --chkCaption
F11   varchar(20)   --Unchk caption
F12  varchar(20)   --chk rightID
F13  varchar(20)   --Unchk rightID}

type TSerialNoDict=record
     caption:string ;//F03   varchar(50) ,--
     actsID:string    ;//F02 varchar(50) ,--  --btns
     Boxid  :string  ;//F04   varchar(50) ,----
     CandidateGridID:string   ;//F05   varchar(50) ,--
     SerialGridID:string     ;//F06   varchar(50) ,--/
     serialNolenghtparams:string ;//F07   varchar(50) ,--
     Chkproc:string  ;//F08   varchar(20) ,--
     UnchkProc:string ;//F09   varchar(20)   --
     chkCaption:string ;//F10   varchar(20)   --
     Unchkcaption:string ;//F11   varchar(20)   --
     chkrightID   :string ;//F12  varchar(20)   --
     UnchkrightID  :string;//F13  varchar(20)   --
     MtdatasetID:string;

     CandidateFldName:String;
     WriteSerialRitID:string;
     ChkFieldName:string;
     IsChkValue:string;
end;

{
type
  TMenuDict=record
    Caption:String;
    ShortCut:String;
    Hint:String;
    Tag:Integer;
    ImageIndex:Integer;
    Name:String;
    GroupIndex:Integer;
  end;
 }


type
  TFhlDbEdit = class(TDbEdit)
    procedure WndProc(var Message:TMessage);override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    constructor Create(AOwner: TComponent); override;
  private
    function GetTableName: string;
    procedure SetTableName(const Value: string);
 published
    property TableName : string read GetTableName write SetTableName;
  private
    FDesign:Boolean;
     FTableName  :string;
    FLookupFrm:Tform;
    function GetLookupFrm: Tform;
    procedure SetLookupFrm(const Value: Tform);
  public
    property LookupFrm:Tform read GetLookupFrm write SetLookupFrm;

  end;

type
  TFhlDbDatePicker = class(TDateTimePicker)
  private
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure wmpaint(var message: tmessage); message wm_paint;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
  protected
    procedure Change; override;
    procedure KeyPress(var Key: Char); override;
    procedure WndProc(var Message:TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

type
  TFhlImage = class(TCustomControl)
  private
    FPictureLoaded:boolean ;
    FPicture:   TPicture;
    FDataLink:  TFieldDataLink;
    FStretch:   Boolean;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function  GetDataField: string;
    function  GetDataSource: TDataSource;
    function  GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  protected
    procedure WndProc(var Message:TMessage); override;
    procedure PictureChanged(Sender: TObject);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Picture:  TPicture read FPicture write FPicture  ;
    property Stretch: Boolean read FStretch write fStretch;
    property TabOrder;
  end;

  type TTrAfterSave= record
      ProcName:string;
      sysPrama:variant;
      UserPrama:variant;
      ErrHint:string;
  end;
  type
  TFhlDbComboBox = class(TDbComboBox)
    procedure WndProc(var Message:TMessage);override;
  end;

  TFhlComboBox = class(TComboBox)
    procedure WndProc(var Message:TMessage);override;
  end;
type
  TFhlDbLookupComboBox = class(TDbLookupComboBox)
    private     Flbltext:Tlabel;
    public
      F_FilterFlds:string ;
    procedure WndProc(var Message:TMessage);override;
    procedure Click(sender:Tobject);
    Constructor create(owner:TComponent);override;
    destructor Destroy;   override;
    procedure Ponenter(sender: TObject);
    procedure Ponkeyup (Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure filter;
end;

type
  TfhlEdit = class(TEdit)
  procedure WndProc(var Message:TMessage);override;
end;

type TIntegerFieldEx=class(TIntegerField)
public
  CalField:string;
  formula:string;
  Max:double;
  Min:double;
end;
type TFloatFieldEx=class(TFloatField)
public
  CalField:string;
  formula:string;
  Max:double;
  Min:double;
end;
type TstringFieldEx=class(TstringField)
public
  CalField:string;
  formula:string;
end;
type
  TLoginInfo = record
    LoginId:String;
    EmpId:String;
    DataBaseID:String;
    TabId:String;
    ChainStoreId:String;
    LoginTime:String;
    IsLocalServer:Boolean;
    LastReceiveStr:widestring;
    //FirmInfo
    FirmCnName:widestring;
    FirmEnName:widestring;
    Address:widestring;
    Zip:String;
    Tel:String;
    Fax:String;
    //SmtpInfo
    SmtpHost:String;
    SmtpPort:Integer;
    SmtpUser:String;
    SmtpPass:String;
    SmtpFrom:String;
    // WorkPlaceId:String;
    //GroupId:String;
    LockTime:integer;  //locktime  秒内鼠标没动，自动锁屏

    ServerName:string;
    PubDataBasePreFix:string;
    SysDBPubName:string;
    SysDBToolName:string;
    LogDataBaseName:string;
    MainUserDBName:string ;

    isAdmin:boolean;
    Sys :boolean;
    SystemCaption:string;
    PrivorUserDataBase:string;
    IsTool:boolean;
    ToolDBIP:string;
    IsDev :Boolean;
    RemoteConnection:boolean;

    ChainStoreCode:string;
    ChainStoreName:string;
    OperationDate:TDatetime;

end;

type
  TFhlKnl = class(TComponent)

  private
    FADOConnection: TADOConnection;
    FAdoUserConnection: TADOConnection;

    FFre_Query: TADOQuery;    //？
    FUser_Query:TADOQuery;    //？
    FUser_DataSet:TADODataSet;    //？

    Fcfg_dataset: TADODataSet;
    Fcfg_datasetfld: TADODataSet;
    Fcfg_label: TADODataSet;
    Fcfg_dbctrl: TADODataSet;
    Fcfg_dbgridcol: TADODataSet;
    Fcfg_dbgrid: TADODataSet;

  protected
    function  q_CreateField(fDictDataSet,fFieldDataSet:TCustomAdoDataSet):TField;
    procedure q_NewDbGridCol(dt:TDataSet;col:TColumn;BDifReadOnlyClr:boolean=false);

  public
    DataSetFldFileName:string;
    GridColsFileName:string;
    DBLabelsFileName:string;
    DBCtrlsFileName:string ;
        
    procedure q_SetLabel(BoxId:String;fParent:TWinControl);
    procedure q_SetDbCtrl(ABoxId:String;ADataSource:TDataSource;AParent:TWinControl;ActnLst:TActionList);
    procedure q_CreateDbCtrl(fDataSource:TDataSource;fParent:TWinControl;ActnLst:TActionList);

    procedure q_SetDbGridColStyle(dt:TDataSet;col:TColumn;BDifReadOnlyClr:boolean=false);
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
    procedure   CloseSysDataSet;
    procedure   SetUserDataBase( UserDataBase:string);
    procedure   RefreshCfgData;
    //--------------Knl--------------
    procedure Kl_SetReg4Mssql(AConnStr:WideString);
    function  get_ComputerName:string;
    function  Kl_Connect(AConnStr:WideString):Boolean;
    procedure Kl_GetQuery2(ASql:wideString;AReturn:Boolean=True;Editing:boolean=false  );

    procedure Kl_GetUserQuery(ASql:wideString;AReturn:Boolean=True);

    //--------------Config/Init-------------
    function  Cf_SetDataSet(ADataSet:TDataSet;ADataSetId:ShortString;ActnLst:TActionList):wideString;
    function  SetColFormat(ADbGrid:TDbGrid)  :boolean;

    function  Cf_DeleteDbGridUnAuthorizeCol(GridId:string;dbGrid:TDbGrid; FempCOde,FWindowsID,BasicDataBase:string):string;
    function  Cf_GetUnAuthorizedCrmTabs(FsubInterfaceID: string; FempCOde, FWindowsID, BasicDataBase: string): TstringList;
    function  Cf_SetDbGrid(GridId:string;dbGrid:TDbGrid;BDifReadOnlyClr:boolean=false):string;
    function  Cf_SetDbGrid_PRT(GridId:string;dbGrid:TDbGrid ):string;

    procedure Cf_SetBox(ABoxId:string;ADataSource:TDataSource;AParent:TWinControl;ActnLst:TActionList);

    procedure Cf_ListAllNode(myTreeCodeDataSet:TDataSet;TreeView:TTreeView;ImgIdx,SelIdx:Integer;CodeFld,NameFld:String;ShowCode:Boolean=True;ShowDeleted:boolean=true);
    procedure Cf_ListAllNodeForMain(myTreeCodeDataSet:TDataSet;TreeView:TTreeView;ImgIdx,SelIdx:Integer;CodeFld,NameFld:String;ShowCode:Boolean=True);

    procedure Cf_SetTreeView   (ATreeId:string;ATreeView:TTreeView;ANodeDataSet:TDataSet;AParam:variant;TreeTable:string='T507');
    procedure Cf_SetTreeViewCrm(ATreeId:string;ATreeView:TTreeView;ANodeDataSet:TDataSet;AParam:variant);

    procedure Cf_SetMainMenu(MenuId:string;MainMenu:TMainMenu;ToolBar:TToolBar;ActionList:TActionList;MenuDataSet:TDataSet);
    function  Cf_GetUserMenuName(FOldCaption,FWindowsFID:string):string;
    //Dict

    function  Cf_GetDict_AfterPost(ADictId:String;var ADict:TAfterPostDict):Boolean;
    function  Cf_GetDict_BeforePost(ADictId:String;var ADict:TBeforePostDict):Boolean;
    function  Cf_GetDict_BeforeDelete(ADictId:String;var ADict:TBeforeDeleteDict):Boolean;
    function  Cf_GetDict_Finder(ADictId:String;var ADict:TFinderDict):Boolean;
    function  Cf_GetDict_TreeMgr(ADictId:String;var ADict:TTreeMgrDict):Boolean;
    function  Cf_GetDict_TreeGrid(ADictId:String;var ADict:TTreeGridDict):Boolean;
    function  Cf_GetDict_TreeDlg(ADictId:String;var ADict:TTreeDlgDict):Boolean;

    function  Cf_GetDict_TabGrid(ADictId:String;var ADict:TTabGridDict):Boolean;
    function  Cf_GetDict_TabEditor(ADictId:String;var ADict:TTabEditorDict):Boolean;
    function  Cf_GetDict_Pick(ADictId:String;var ADict:TPickDict):Boolean;
    function  Cf_GetDict_PickUniversal(ADictId:String;var ADict:TPickDictPickMulPage):Boolean;

    function  Cf_GetDict_More2More(ADictId:String;var ADict:TMore2MoreDict):Boolean;
    function  Cf_GetDict_Lookup(ADictId:String;var ADict:TLookupDict):Boolean;
    function  Cf_GetDict_Editor(ADictId:String;var ADict:TEditorDict):Boolean;
    function  Cf_GetDict_TreeEditor(ADictId:String;var ADict:TTreeEditorDict):Boolean;
    function  Cf_GetDict_Analyser(ADictId:String;var ADict:TAnalyserDict):Boolean; 

    function  Cf_GetDict_ExcPrc(AId:string;var ADict:TExcPrcDict):Boolean;
    function  Cf_GetDict_Bill(FrmId:string;var Dict:TBillDict):Boolean;
    function  Cf_GetDict_Bill_Ex(FrmId:string;var Dict:TBillDictEx):Boolean;
    function  Cf_GetDict_BilOpnDlg(AFrmId:string;var ADict:TBilOpnDlgDict):Boolean;
    function  Cf_SetdsFinderDictInfo(FrmId:string;var Dict:TdsFinderDict):Boolean;
    function  Cf_GetDict_afterSave(FrmId:String;var Dict:TTrAfterSave):Boolean;

    function  Cf_GetDict_LkpImport(FrmId:String;var Dict:TLkpImportDict):Boolean;
    function Cf_GetDict_SerialNO(FrmId: String; var Dict: TSerialNoDict): Boolean;

    function  Cf_GetDict_CrmModel(FrmId:string;var Dict:TCRMDict):Boolean;
    //--------------String------------------
    procedure St_Separate(s:string;Separator:Char;Terms:TStringList);//ok split s to    Terms

    function  St_GetTStringValues(fStr:wideString;fSeparator:Char;fNames:string):Variant;
    function  St_GetBigMoney(Aje:Currency):string;
    function  St_Encrypt(str:string):string;
    function  St_encrypt_Chy(str:string):string;
    function  St_GetPrimaryKey(ARandom:integer):string;
    function  St_GetCalcFld(AExpression:string;var ABeginPos:integer):string;
    function  St_Repeat(ASon:string;ANum:integer):widestring;
    //--------------Variants----------------
    function  Vr_MergeVarArray(varArray1,varArray2:Variant):Variant;
    function  Vr_CommaStrToVarArray(CommaStr:wideString;OnlyValues:Boolean=False):Variant;
    function  Vr_VarArrayToCommaStr(varArray:Variant):wideString;
    function  Vr_VarHaveSameVal(varArray:Variant):Boolean;
    function  Vr_ReplaceByVarArray(Str:wideString;Patern:String;VarArray:Variant):wideString;
    //--------------TreeView-------------
    function  Tv_GetTreePath(Node:TTreeNode):wideString;
    function  Tv_FindNode(TreeView:TTreeView;FindData:ShortString):TTreeNode;
    function  Tv_CreateNode(TreeView:TTreeView;FatherNode:TTreeNode;Text:ShortString;ImgIdx,SelIdx:Integer):TTreeNode;
    function  Tv_NewDataNode(ATreeView:TTreeView;AFatherNode:TTreeNode;AData,AText:ShortString;AImgIdx,ASlctIdx:Integer):TTreeNode;
    //--------------PageControl-------------
    function  Pc_CreateTabSheet(fPageControl:TPageControl;Pcaption:string=''):TTabSheet;
    //--------------ToolButton-------------
    procedure Tb_ClearTlBtn(fToolBar:TToolBar);
    procedure Tb_CreateActionBtns(fToolBar:TToolBar;fActionList:TActionList;fActions:Variant;ClearToolButton:boolean=true);
    procedure Tb_CreateActionBtns_Ex(fToolBar:TToolBar;fActionList:TActionList;fMainActID:string ;FempCode:string ='';FWindowsFID:string='');

    //--------------Menu-------------
    procedure Mn_FindMenuItem(AMenuItem:TMenuItem;AName:String;var AFindedItem:TMenuItem);
    function  Mn_FindMainMenuItem(AMainMenu:TMainMenu;AName:String):TMenuItem;
    //---------------DbGrid------------------
    function  Dg_GetDBGridEdit(fDBGrid: TDBGrid): TEdit;
    function  Dg_GetDBGridEditText(fDBGrid: TDBGrid): string;
    function  Dg_GetNextTabIndex(fDbGrid:TDbGrid;fPreIndex:Integer):Integer;
    procedure Dg_SetDbGridStyle(fDbGrid:TDbGrid;fReadOnly:Boolean;bkColor:TColor;fDbGridColsColor:Variant);
    function  Dg_SetSelectedIndex(ADbGrid:TDbGrid;AInsert:Boolean):Boolean;
    procedure Dg_DrawLineFont(Sender: TObject;const Rect: TRect; DataCol: Integer; Column: TColumn;State: TGridDrawState;AFont:TFont);
    procedure Dg_DrawZebraBackgroud(Sender: TObject;const Rect: TRect; DataCol: Integer; Column: TColumn;State: TGridDrawState;AColor0,AColor1:TColor);

    procedure Dg_Sort(ADbGrid:TDbGrid;AContainInVisible:Boolean=true);
    procedure Dg_ShowCol(ADbGrid:TDbGrid);
    procedure Dg_ColsProp(ADbGrid:TDbGrid);
    procedure Dg_SetColVisible(ADbGrid:TDbGrid);
    procedure Dg_SetColWidth(ADbGrid:TDbGrid);
    procedure Dg_SetColOrder(ADbGrid:TDbGrid);
    procedure Dg_SetColStyle(ADbGrid:TDbGrid);
    function  Dg_GetDbGrdEdtActnId(ADbGrid:TDbGrid):integer;
    procedure Dg_ConfigRight(ADbGrid:TDbGrid;Logininfo:Tlogininfo);
    //---------------DataSet------------------
    procedure Ds_Locate(ADataSet:TDataSet);
    procedure Ds_Filter(ADataSet:TDataSet;Dbgrid:Tdbgrid=nil);
    function  Ds_GetQuerySql(ADataSet: TDataSet; Dbgrid: Tdbgrid):string;
    function  Ds_Query (ADataSet:TDataSet;Dbgrid:Tdbgrid=nil):string;
    function  Ds_QuickQuery (ADataSet:TDataSet;ConSql:string):string;

    procedure Ds_FreeDataSet(DataSet:TDataSet);
    function  Ds_GetFieldValues(DataSet:TDataSet;FieldName:String):Variant;
    function  Ds_GetFieldsValue(DataSet:TDataSet;FieldNames:Variant; bPercentSign:boolean=false):Variant;

    function  Ds_GetFieldsName(DataSet:TDataSet):Variant;
    procedure Ds_ClearAllData(DataSet:TDataSet);
    procedure Ds_CopyValues(SourceDataSet,DestDataSet:TDataSet;SourceFields,DestFields:Variant;IsAppend:Boolean=True;IsPost:Boolean=True);overload;
    procedure Ds_CopyValues(SourceGrid:TdbGrid;SourceDataSet,DestDataSet:TDataSet;SourceFields,DestFields:Variant;IsAppend:Boolean=True;IsPost:Boolean=True);overload;//记录多选 2006-7-20

    procedure Ds_CopyDataSet(SourceDataSet,DestDataSet:TAdoDataSet);
    procedure Ds_AssignNulls(DataSet:TDataSet;Fields:WideString;IsPost:Boolean=True);overload;
    procedure Ds_AssignNulls(Grid:TDBGRID;DataSet:TDataSet;Fields:WideString;IsPost:Boolean=True);overload;

    procedure Ds_AssignValues(DataSet:TDataSet;Fields,Values:Variant;IsAppend:Boolean=True;IsPost:Boolean=True);
    function  Ds_SumFlds(DataSet:TDataSet;SumFlds:Variant):Variant;
    procedure Ds_SetDataSetStyle(fDataSet:TDataSet;fReadOnly:Boolean);
    procedure Ds_SetParams(ADataSet:TDataSet;AParams:Variant);
    procedure Ds_OpenDataSet(ADataSet:TDataSet;AParams:Variant);
    procedure Ds_RefreshLkpFld(fDataSet:TDataSet);
    procedure Ds_RefreshDataSet(fDataSet:TDataSet);
    procedure Ds_RequireCheck(ADataSet:TDataSet);
    function  Ds_CheckReference(ADataSet:TDataSet;var  RRef:string):boolean;

    function Ds_DuplicatedCheck(FLD: Tfield;value :variant):boolean;//验证是否有重复记录
    Function Ds_DUUnionpkCheck(ADataSet:TDataSet;var Rstr:string):boolean;

    procedure Ds_AssignDefaultVals(ADataSet:TDataSet;ACommaVals:wideString;UseEdit:boolean=true);
    function  Ds_Calc(ADataSet:TDataSet;AExpression:string):Double;
    //-----------------Vcl----------------------
    procedure Vl_ClearChild(fParent:TControl);
    procedure Vl_FocueACtrl(fParentControl:TWinControl);
    procedure Vl_DoBoxEnter(AWinControl:TWinControl);
    function  Vl_GetAlignment(fCodeId:Integer):TAlignment;
    function  Vl_FindChildFrm(const FrmName:String;ShowIt:Boolean=True):TForm;
    procedure Vl_SetCtrlStyle(bkColor:TColor;fFather:TwinControl;fCanEdit:Boolean);
    //-----------------Report-----------------------
    procedure Rp_SetRepGrid(fDBGrid:TDBGrid;fDetailBand,fColumnHeaderBand:TQrBand;fHasVerticalLine:Boolean=True);
    procedure Rp_SetRepCtrl(fDictDataSet,fDataSet:TDataSet;fParent:TQrBand;ABeginTop:integer=10;DLGrid:TDbGrid=nil);
    procedure Rp_SetRepCtrlWithSumRow(fDictDataSet,fDataSet:TDataSet;fParent:TQrBand;ABeginTop:integer=10;DLGrid:TDbGrid=nil);

    procedure Rp_SetRepLabel(fDictDataSet:TDataSet;fParent:TQrBand);
    procedure Rp_RepSet(APrinterId:string);
    procedure Rp_DbGrid(APrinterId:string;ADbGrid:TDbGrid;Title:string='');
    procedure Rp_Card(ABoxId:String;ADataSet:TDataSet);
    function  CreateQRLabel (left, Top, width, height: integer; pCaption:string; pCol:TColumn;FParent:TWinControl):TQRLabel;
    procedure CreateQRCaptions(pCols:TDBGridColumns;   FParent,fDetail: TWinControl ;pHasVerticalLine:boolean;PframeWidth:integer);

    //--------------Operator System-------------
    function  Os_GetComputerName:String;
    function  Os_GetComputerIp:String;
    function  Os_GetComputerMac:String;
    //--------------Module---------------
    function  Md_ShowDateFrm(var ADate:TDateTime;var isnull :boolean ):Integer;

    function  Md_ShowDirSelectorFrm(var ADir:wideString):Integer;
    procedure CreateUpdateBatFile;

    procedure q_SetLabel_mtn(BoxId: String; fParent: TWinControl;Fcollector:Tstrings);//create labels which  can be draged  and  their captions can be redefinded
    procedure q_SetDbCtrl_Mtn(ABoxId:String;AParent:TWinControl;ActnLst:TActionList;FCollector:Tstrings);   //create dataware controls which  can be draged  and  their options  can be redefinded

    procedure q_CreateDbCtrl_Mtn(fParent:TWinControl;ActnLst:TActionList;ABoxId:string;FCollector:Tstrings;PreviousTop:integer );
    function  GetMaxBoxID:string;
    function  GetMaxCode(Tablename,FieldName:string;wheresql: string='';leftLen:integer=3):string;
    procedure ControlDragDrop(Sender, Source: TObject; X,
    Y: Integer);
    procedure ControlDragOver(Sender, Source: TObject; X,
    Y: Integer; State: TDragState; var Accept: Boolean);
    procedure MouseDown(Sender: TObject;    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseUp(Sender: TObject;    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DblClick_Ex(Sender: TObject);

    procedure CheckUnique(Sender: TObject);
    procedure CheckCtrlFieldsUnique(Sender: Twincontrol);
    procedure Act_ConfigRight(ActLst:Tactionlist;LoginInfo:TLoginInfo);
    procedure AddColorTOCommandtext(Var CommandText:wideString; ColorID:integer);
    function  GetPostSQL(Adodataset:Tdataset;binsert:boolean;TableName:string):string;
    function  GetDeleteSQL(Adodataset:Tdataset;TableName:string):string;

    function  SaveUserDataPostLog(Adodataset:Tdataset;binsert:boolean;TableName:string):string;
    function  SaveDeleteDataLog (Adodataset:Tdataset;TableName:string):string;

    function  GetSysParametersName(PdataSet:Tdataset):string;
    function  GetCalculateFldsForLogSys(PdataSet:Tdataset):string;
    function  SubStrConut(mStr:   string;   mSub:   string):   Integer;

    Function  CheckIfIsTheLastestVersion(PdataSet:Tdataset):boolean; 

    function  TColorToHex(Color : TColor) : string;

    function HexToTColor(sColor : string) : TColor;
    function  CacheFileName(DataSetName:string):string;
  published
    property User_Query:TAdoQuery read FUser_Query write FUser_Query;
    property User_DataSet:TAdoDataset read FUser_DataSet ;//write FUser_Query;
    property FreeQuery:TAdoQuery read FFre_Query write FFre_Query;
    property Connection:TAdoConnection read FAdoConnection write FAdoConnection;
    property UserConnection:Tadoconnection read FAdoUserConnection ;
    property Cfg_DbGridCol :TAdoDataSet read   Fcfg_dbgridcol ;        //报表 加查询字段
  end;

const
       cftString = 0;
       cftDate = 1;
       cftDateTime = 2;
       cftBoolean = 3;
       cftFloat = 4;
       cftCurrency = 5;
       cftMemo = 6;
       cftBlob = 7;
       cftBytes = 8;
       cftAutoInc = 9;
       cftInteger = 10;
       cftLargeint=12;
       cftTimeStamp=13;

       cDsId01 = '538';
       cDsId02 = '539';
       cDsId03 = '492';
       cDsId04 = '463';

       cDgId01 = '355';
       cDgId02 = '352';
       cDgId03 = '421';     

procedure Register;
  function sendarp(ipaddr: ulong;  temp: dword;  ulmacaddr: pointer;  ulmacaddrleng: pointer): DWord;
  stdcall;  external 'Iphlpapi.dll' Name 'SendARP';

implementation
uses sort,colShower,colProp,Filter,RepGrid,RepCard,date,DirSelector,datamodule,UnitUpdateProerty
,UPublicCtrl,UnitUserQrRptEx,UnitGrid;

procedure Register;
begin
  RegisterComponents('Samples', [TFhlKnl]);
end;


constructor TFhlKnl.Create(AOwner:TComponent);

begin
  inherited Create(AOwner);
//  TMyThrd.Create(AOwner);

  FADOConnection:=TADOConnection.Create(self);
  with FADOConnection do
  begin
    Provider:='SQLOLEDB.1';
    LoginPrompt:=False;
  end;

  FAdoUserConnection:=TADOConnection.Create(self);
  with FAdoUserConnection do
  begin
    Provider:='SQLOLEDB.1';
    LoginPrompt:=False;
  end;
  FUser_Query:=TADOQuery.Create(self);
  FUser_Query.Connection :=FAdoUserConnection;

  FUser_DataSet :=tadodataset.Create(self);
  FUser_DataSet.Connection :=FAdoUserConnection;


  FFre_Query:=TADOQuery.Create(self);

  FFre_Query.Connection:=FADOConnection;

  Fcfg_dataset:=TADODataSet.Create(self);
  with Fcfg_dataset do
  begin
    CommandTimeOut:=600;
    LockType:=ltReadOnly;
    CommandType:=cmdText;
    CommandText:='select * from T201 ';    //    where F01=:datasetid
    Connection:=FADOConnection;//这句需放到上一句的后面,否则在F9时CommandTex赋值后会自动连接
  end;

  Fcfg_datasetfld:=TADODataSet.Create(self);
  with Fcfg_datasetfld do
  begin
    CommandTimeOut:=600;
    LockType:=ltReadOnly;
    CommandType:=cmdText;
    CommandText:='select * from V201   order by OrdIdx ';   // desc   where datasetid=:datasetid
    Connection:=FADOConnection;
  end;
  
  Fcfg_label:=TADODataSet.Create(self);
  with Fcfg_label do
  begin
    CommandTimeOut:=600;
    LockType:=ltReadOnly;
    CommandType:=cmdText;
    CommandText:='select * from T503    order by  f05,f04'; // where F02=:BoxId
    Connection:=FADOConnection;
  end;

  Fcfg_dbctrl:=TADODataSet.Create(self);
  with Fcfg_dbctrl do
  begin
    CommandTimeOut:=600;
    LockType:=ltReadOnly;
    CommandType:=cmdText;
    CommandText:='select * from V501  order by BoxId, postop ,posleft  ';   //  where BoxId=:BoxId 
    Connection:=FADOConnection;
  end;

{ } Fcfg_dbgridcol:=TADODataSet.Create(self);
  with Fcfg_dbgridcol do
  begin
    CommandTimeOut:=600;
    LockType:=ltReadOnly;
    CommandType:=cmdText;
    CommandText:='select * from V502 order by F23';   //  where convert(varchar(100),F02)=:DbGridId
    Connection:=FADOConnection;
  end;

  Fcfg_dbgrid:=TADODataSet.Create(self);
  with Fcfg_dbgrid do
  begin
    CommandTimeOut:=600;
    LockType:=ltReadOnly;
    CommandType:=cmdText;
    CommandText:='select * from T504 ';    //  where convert(varchar(100),F01 )=:dbgridid
    Connection:=FADOConnection;
  end;

end;

destructor TFhlKnl.Destroy;
begin

  FreeAndNil(FAdoConnection);
  FreeAndNil(FADOConnection);
  FreeAndNil(FFre_Query);
  FreeAndNil(Fcfg_dataset);
  FreeAndNil(Fcfg_datasetfld);
  FreeAndNil(Fcfg_label);
  FreeAndNil(Fcfg_dbctrl);
  FreeAndNil(Fcfg_dbgridcol);
  FreeAndNil(Fcfg_dbgrid);

  FreeAndNil(FUser_Query);
  FreeAndNil(FUser_DataSet);
  inherited Destroy;
end;

function TFhlKnl.get_ComputerName:string;
var ch:array[0..127]of char;
sz:dword;
begin
sz := sizeof(ch);
getComputerName(ch,sz);
result := ch;
end;
//--------------Knl-------------------
procedure TFhlKnl.Kl_SetReg4Mssql(AConnStr:widestring);
var
  t:TStringList;
  Reg: TRegistry;

  computername:string;
begin
  t:=TStringList.Create;
  Reg := TRegistry.Create;
  try
   t.CommaText:=StringReplace(AConnStr,';',',',[rfReplaceAll]);
   Reg.RootKey := HKEY_LOCAL_MACHINE;
   if Reg.OpenKey('\SOFTWARE\Microsoft\MSSQLServer\Client\ConnectTo', True) then
   begin
     computername:=get_ComputerName;
   //  if  ( UpperCase(t.Values['Source'])<>UpperCase(trim(computername))) and (t.Values['Source']<>'xts3') then  //用于测试
     if  ( UpperCase(t.Values['Source'])<>UpperCase(trim(computername)))  then  //用于测试
     Reg.WriteString(t.Values['Source'],'DBMSSOCN,' + t.Values['Source']+',7709');

     Reg.CloseKey;
   end;
  finally
   t.Free;
   Reg.Free;
  end;
end;

function TFhlKnl.Kl_Connect(AConnStr:WideString):Boolean;
begin
  try
    with FADOConnection do
    begin
      Connected:=False;
      ConnectionString:=AConnStr;
      Connected:=true;
      CommandTimeOut:=6000;

    end;
    with self.FAdoUserConnection do
    begin
      Connected:=False;
      ConnectionString:=AConnStr;
      Connected:=true;
      CommandTimeOut:=6000;      
    end;
    Result:=True;
  except
    begin
        //showmessage(LoginInfo.LastReceiveStr);
         showmessage('disconnected');
         Result:=False;
    end;
  end;

end;

procedure  TFhlKnl.Kl_GetQuery2(ASql:wideString;AReturn:Boolean=True;Editing:boolean=false);
begin
  with FFre_Query do
  begin
    Close;

      if Editing then
           LockType :=  ltOptimistic
      else
           LockType :=  ltReadOnly;

    Sql.Clear;
    Sql.Append(ASql);
    if AReturn then
      Open
    else
      ExecSql;
  end;
end;

//-------------------------------------------

function  TFhlKnl.q_CreateField(fDictDataSet,fFieldDataSet:TCustomAdoDataSet):TField;
{
type TFloatField_Rng=class(TFloatField)
     MaxValueUser:double;
     MinValueUser:double;
end;
type TFloatField_Rng=class(TFloatField)
     MaxValueUser:double;
     MinValueUser:double;
end;
   }
var
  F:TField;
  fDict:TFldInitDict;
  //c:TComponent;,s
begin
        fDict.Name:=fDictDataSet.FieldByName('Name').asString;
        fDict.TypeId:=fDictDataSet.FieldByName('TypeId').asInteger;
        fDict.Format:=fDictDataSet.FieldByName('Format').asString;
        fDict.DisplayLabel:=fDictDataSet.FieldByName('Label').asString;
        fDict.Required:=fDictDataSet.FieldByName('Required').asBoolean;
        fDict.DefaultVal:=fDictDataSet.FieldByName('DefaultVal').asString;
        fDict.FldId:=fDictDataSet.FieldByName('FldId').asInteger;
        fDict.Size:=fDictDataSet.FieldByName('Size').asInteger;//如果size为0刚看不到该字段的数据
        fDict.KindId:=fDictDataSet.FieldByName('KindId').asString;
        fDict.KeyFlds:=fDictDataSet.FieldByName('KeyFld').asString;
        fDict.LkpKeyFlds:=fDictDataSet.FieldByName('LkpKeyFld').asString;
        fDict.LkpResultFld:=fDictDataSet.FieldByName('LkpResultFld').asString;
        fDict.LkpDsId:=fDictDataSet.FieldByName('LkpDsId').asInteger;
        fDict.MinValue :=fDictDataSet.FieldByName('MinValue').AsString  ;
        fDict.MaxValue :=fDictDataSet.FieldByName('MaxValue').AsString ;
        if fDictDataSet.FindField ('formula')<>nil then
           fDict.formula :=fDictDataSet.FieldByName('formula').AsString ;
        if fDictDataSet.FindField ('CalField')<>nil then
           fDict.CalField:=fDictDataSet.FieldByName('CalField').AsString ;

       case fDict.TypeId of
        cftString:
            begin F:=TstringFieldEx.Create(fFieldDataSet);
            TstringFieldEx(f).CalField :=trim( fDict.CalField );
            TstringFieldEx(f).formula :=trim( fDict.formula );
            end;
         cftDate:
         begin
            F:=TDateField.Create(fFieldDataSet);
            TDateField(F).DisplayFormat:=fDict.Format;
         end;
         cftDateTime:begin
            F:=TDateTimeField.Create(fFieldDataSet);
            TDateTimeField(F).DisplayFormat:=fDict.Format;
           end;
         cftBoolean:begin
            F:=TBooleanField.Create(fFieldDataSet);
            TBooleanField(F).DisplayValues:=fDict.Format;
           end;
         cftFloat:begin
            F:=TFloatFieldEx.Create(fFieldDataSet);
            if  fDict.MinValue <>'' then
                TFloatField(F).MinValue :=strtofloat(fDict.MinValue );
            if  fDict.MaxValue <>'' then
                TFloatField(F).MaxValue :=strtofloat(fDict.MaxValue );
            TCurrencyField(F).DisplayFormat:=fDict.Format;//'#0.00'
            TFloatField(F).Precision:=15;
            TFloatFieldEx(f).CalField :=trim( fDict.CalField );
            TFloatFieldEx(f).formula :=trim( fDict.formula );

           end;
         cftCurrency:begin
            F:=TCurrencyField.Create(fFieldDataSet);
            if  fDict.MinValue <>'' then
                TFloatField(F).MinValue :=strtofloat(fDict.MinValue );
            if  fDict.MaxValue <>'' then
                TFloatField(F).MaxValue :=strtofloat(fDict.MaxValue );
            TCurrencyField(F).Precision:=8;
            TCurrencyField(F).Currency:=false;
            TCurrencyField(F).DisplayFormat:=fDict.Format;//'#0.00'
           end;
         cftMemo:F:=TMemoField.Create(fFieldDataSet);
         cftBlob:F:=TBlobField.Create(fFieldDataSet);
         cftBytes:F:=TBytesField.Create(fFieldDataSet);
         cftAutoInc:F:=TAutoIncField.Create(fFieldDataSet);
         cftInteger:
                    begin
                        F:=TIntegerFieldEx.Create(fFieldDataSet);
                       // F:=TIntField.Create(fFieldDataSet);

                        TIntegerFieldEx(f).CalField :=trim( fDict.CalField );
                        TIntegerFieldEx(f).formula :=trim( fDict.formula );
                        if  fDict.MinValue <>'' then
                            TIntegerFieldEx(F).MinValue :=strtoint(fDict.MinValue );
                        if  fDict.MaxValue <>'' then
                            TIntegerFieldEx(F).MaxValue :=strtoint(fDict.MaxValue );
                           {  }
                    end;
         CftLargeint:
                    begin
                      F:=TLargeintField.Create(fFieldDataSet);
                          if  fDict.MinValue <>'' then
                            TFloatField(F).MinValue :=strtoint(fDict.MinValue );
                        if  fDict.MaxValue <>'' then
                            TFloatField(F).MaxValue :=strtoint(fDict.MaxValue );
                    end;
         cftTimeStamp:
                   begin
                      F:=TSQLTimeStampField.Create(fFieldDataSet);
  
                    end;
                    //TSQLTimeStampField

         else F:=TStringField.Create(fFieldDataSet);
       end;
       F.DisplayLabel:=fDict.DisplayLabel;
       F.Required:=fDict.Required;
       F.DefaultExpression:=fDict.DefaultVal;
       F.Tag:=fDict.FldId;
       F.Size:=fDict.Size;
       if fDict.KindId='l' then
       begin
           F.FieldKind:=fkLookup;
           F.KeyFields:=fDict.KeyFlds;
           F.LookupCache:=true;
           F.LookupKeyFields:=fDict.LkpKeyFlds;
           F.LookupResultField:=fDict.LkpResultFld;

           F.LookupDataSet:=TAdoDataSet.Create(self);
           TAdoDataSet(F.LookupDataSet).Connection:=fFieldDataSet.Connection;
           F.LookupDataSet.Tag:=fDict.LkpDsId;


       end
       else if fDict.KindId='c' then
           F.FieldKind:=fkCalculated;


        F.FieldName:=fDict.Name;
        F.DataSet:=fFieldDataSet;
  Result:=F;
end;
function   TFhlKnl.SubStrConut(mStr:   string;   mSub:   string):   Integer;
  {   返回子字符串出现的次数   }   
  begin   
      Result   :=
          (Length(mStr)   -   Length(StringReplace(mStr,   mSub,   '',   [rfReplaceAll])))   div
          Length(mSub);
  end;   {   SubStrConut   }
function TFhlKnl.Cf_SetDataSet(ADataSet:TDataSet;ADataSetId:ShortString;ActnLst:TActionList):wideString;
var
  fDict:TDSInitDict;
  i,cnt:integer;
begin
    Ds_FreeDataSet(ADataSet);         //free

    if (ADataSetId='-1') or (ADataSetId='') then exit;
    ADataSet.Tag:=strToint(ADataSetId);

  dataSetFldFileName:= CacheFileName('Fcfg_datasetfld') ;//'c:\Fcfg_datasetfld'+self.FADOConnection.DefaultDatabase ;
  if  not Fcfg_datasetfld.Active   then
  begin
     if FileExists(dataSetFldFileName ) then
     begin
       Fcfg_datasetfld.LoadFromFile (dataSetFldFileName);
     end
     else
     begin
       Ds_OpenDataSet(Fcfg_datasetfld,ADataSetId);
       Fcfg_datasetfld.Filtered :=False;
       if dataSetFldFileName<>'' then
       Fcfg_datasetfld.SaveToFile(dataSetFldFileName,pfXML);
     end;
  end;             

  Fcfg_datasetfld.Filtered :=False;
  Fcfg_datasetfld.Filter :='Datasetid='+quotedstr( ADataSetId );
  Fcfg_datasetfld.Filtered :=true;

    with Fcfg_datasetfld do            //create field to ADataSet
    begin
    First;
      while not Eof do
      begin
        q_CreateField(Fcfg_datasetfld,TAdoDataSet(ADataSet));
        Next;
      end; 
    end;
//这段打开LkpDs的代码需要写到调用端,从而获取系统参数值

{
  for i:=0 to ADataSet.FieldCount-1 do
    if ADataSet.Fields[i].FieldKind=fkLookup then
    Ds_OpenDataSet(ADataSet.Fields[i].LookupDataSet,GetSysParamsVal(Cf_SetDataSet(ADataSet.Fields[i].LookupDataSet,intTostr(ADataSet.Fields[i].LookupDataSet.Tag),nil,null)));
 } //

  if  not Fcfg_dataset.Active   then
    Ds_OpenDataSet(Fcfg_dataset,ADataSetId);
  Fcfg_dataset.Filtered :=False;
  Fcfg_dataset.Filter :='F01='+ADataSetId;
  Fcfg_dataset.Filtered :=true;

  with Fcfg_dataset do
  begin
    cnt:=SubStrConut ( FieldByName('F03').asString,'%');
    if cnt<=1 then
      fDict.CommandText:=Format(FieldByName('F03').asString,[FAdoConnection.DefaultDataBase])
    else
    begin
       if cnt=2 then
       fDict.CommandText:=Format(FieldByName('F03').asString,[FAdoConnection.DefaultDataBase,FAdoConnection.DefaultDataBase]);
       if cnt=3 then
       fDict.CommandText:=Format(FieldByName('F03').asString,[FAdoConnection.DefaultDataBase,FAdoConnection.DefaultDataBase,FAdoConnection.DefaultDataBase]);
    end;

    fDict.CommandTypeId:=FieldByName('F04').asInteger;
    fDict.LockTypeId:=FieldByName('F05').AsInteger;
    fDict.Sort:=FieldByName('F07').asString;     //Specifies the sort order of the recordset.
    fDict.Filter:=FieldByName('F06').asString;
    fDict.SysParams:=FieldByName('F13').asString;
    fDict.BeforePostId:=FieldByName('F09').asInteger;
    fDict.AfterInsertId:=FieldByName('F10').asInteger;
    fDict.BeforeDeleteId:=FieldByName('F11').asInteger;
    fDict.AfterPostId:=FieldByName('F12').asInteger;
    fDict.OnCalcFieldId:=FieldByName('F14').asInteger;
    fDict.AfterOpenId:=FieldByName('F15').asInteger;
    fDict.TableName:=FieldByName('F16').AsString ;
    fDict.ColorID    :=FieldByName('F17').asInteger;

    if  FindField('F18')<>nil then
        fDict.DataSetUsage:=FieldByName('F18').AsString ;

    //Close;
  end;

  if   ADataSet is TAdoDatasetColor then
    if   TAdoDatasetColor(ADataSet ).ColorID>0  then
    begin
        TAdoDatasetColor(ADataSet ).ColorID:=   fDict.ColorID  ;
        if     fDict.ColorID >1 then
       self.AddColorTOCommandtext(fDict.CommandText ,fDict.ColorID );
    end  ;
   { }
  //  else
  //      self.AddColorTOCommandtext(fDict.CommandText ,fDict.ColorID );


  with TAdoDataSet(ADataSet) do
  begin
        if ActnLst<>nil then
        begin
            if fDict.BeforePostId>-1 then            //tg of operate
               BeforePost:=TDataSetNotifyEvent(ActnLst.Actions[fDict.BeforePostId].OnExecute);
            if fDict.BeforeDeleteId>-1 then
               BeforeDelete:=TDataSetNotifyEvent(ActnLst.Actions[fDict.BeforeDeleteId].OnExecute);
            if fDict.AfterInsertId>-1 then
               AfterInsert:=TDataSetNotifyEvent(ActnLst.Actions[fDict.AfterInsertId].OnExecute);
            if fDict.AfterPostId>-1 then
               AfterPost:=TDataSetNotifyEvent(ActnLst.Actions[fDict.AfterPostId].OnExecute);
            if fDict.OnCalcFieldId>-1 then
               OnCalcFields:=TDataSetNotifyEvent(ActnLst.Actions[fDict.OnCalcFieldId].OnExecute);
            if fDict.AfterOpenId>-1 then
               AfterOpen:=TDataSetNotifyEvent(ActnLst.Actions[fDict.AfterOpenId].OnExecute);
        end;
        case fDict.CommandTypeId of
             0:CommandType:=cmdText;
             else
               CommandType:=cmdStoredProc;
        end;
        case fDict.LockTypeId of
             0:LockType:=ltBatchOptimistic;
             1:LockType:=ltOptimistic;
             3:LockType:=ltReadOnly;
        end;
        CommandText:=fDict.CommandText;
        Filter:=fDict.Filter;

        IF fDict.DataSetUsage='LOOKUP' then
//           if FieldByName('F04').asInteger =0 then
           fDict.SysParams:= fDict.SysParams+','+fDict.TableName ;

        Result:=fDict.SysParams;
  end;
end;

procedure TFhlKnl.q_CreateDbCtrl(fDataSource:TDataSource;fParent:TWinControl;ActnLst:TActionList);
var
  fldname,fhint:String;
  l,t,w,h,ft,ClickId,DblClickId,ExitId,orderIndex:integer;
  r:boolean;
  pwchar:char;
  fntcolr:TColor;
begin
 

   with Fcfg_dbctrl do
   begin
     fldname:=FieldByName('FldName').asString;
     pwchar:=Chr(FieldByName('PwChar').asInteger);
     l:=FieldByName('PosLeft').asInteger;
     t:=FieldByName('PosTop').asInteger;
     w:=FieldByName('Width').asInteger;
     h:=FieldByName('Height').asInteger;
     r:=FieldByName('ReadOnly').asBoolean;
     ft:=FieldByName('CtrlTypeId').asInteger;
     fhint:=FieldByName('Hint').AsString;
     fntcolr:=StringToColor (FieldByName('FontColor').AsString);
     orderIndex:= Fcfg_dbctrl.RecNo ;//  FieldByName('OrderIndex').asinteger;
     ClickId:=FieldByName('ClickId').asInteger;
     ExitId:=FieldByName('ExitId').asInteger;
     DblClickId:=FieldByName('DblClickId').asInteger;

   end;
   case ft of
        1:begin
           with TFhlDbEdit.Create(fParent) do
           begin
                Left:=l;Top:=t;Width:=w;Height:=h;ReadOnly:=r;
                font.Color :=fntcolr;
                Parent:=fParent;
                PasswordChar:=pwchar;

                if fDataSource.DataSet.FindField(FldName)<>nil then
                begin
                DataSource:=fDataSource;
                DataField:=FldName;
                tablename:=  Tadodataset(fDataSource.DataSet).CommandText ;
                end
                else
                begin
                    showmessage(FldName+'不存在');
                    exit;
                end;

                Ctl3D:=false;
                Hint:=fHint;
                TabOrder:=orderIndex;
                if ClickId>-1 then
                  OnClick:=ActnLst.Actions[ClickId].OnExecute;
                if DblClickId>-1 then
                  OnDblClick:=ActnLst.Actions[DblClickId].OnExecute;
                if ExitId>-1 then
                  OnExit:=ActnLst.Actions[ExitId].OnExecute;
           end;
          end;
        5:begin
            with TFhlDbLookupComboBox.Create(fParent) do
            begin
              try
                name:='Lkp'+fldname;
                DropDownWidth:=w+150;
                font.Color  :=fntcolr;
                Parent:=fParent;
                Left:=l;Top:=t;Width:=w;Height:=h;ReadOnly:=r;
                DataSource:=fDataSource;
                DataField:=Fcfg_dbctrl.FieldByName('KeyFld').asString;
                KeyField:=Fcfg_dbctrl.FieldByName('LkpKeyFld').asString;
                ListField:=Fcfg_dbctrl.FieldByName('LkpListFlds').asString;
                ListSource:=TDataSource.Create(fParent);


                if   fDataSource.DataSet.FindField(fldname)<>nil then
                F_FilterFlds:= fDataSource.DataSet.FieldByName(fldname).DefaultExpression ;

                if fldname='' then exit;
                if fDataSource.DataSet.FindField (fldname)<>nil then
                     ListSource.DataSet:=fDataSource.DataSet.FieldByName(fldname).LookupDataSet
                else
                begin
                     showmessage(fldname+'没找到！');
                     exit;
                end;

                Ctl3D:=false;
                BevelKind:=bkNone;
                TabOrder:=orderIndex;
                NullValueKey:=vk_delete;
                DropDownRows:=12;
              except

              end;
//                OnCloseUp:=FqDoLkpBoxCloseup;
            end;
          end;
        6:begin
            with TDbMemo.Create(fParent) do
            begin
                 Parent:=fParent;
                 Left:=l;Top:=t;Width:=w;Height:=h;ReadOnly:=r;
                 font.Color  :=fntcolr;
                 Ctl3D:=false;
                 TabOrder:=orderIndex;

                 if fDataSource.DataSet.FindField(FldName)<>nil then
                begin
                DataSource:=fDataSource;
                DataField:=FldName;
                end
                else
                begin
                    showmessage(FldName+'不存在');
                    exit;
                end;

                 ScrollBars:=ssVertical;
            end;
          end;
        7:begin
            with TDbCheckBox.Create(fParent) do
            begin
                 Left:=l;Top:=t;Width:=w;Height:=h;ReadOnly:=r;
                 Parent:=fParent;
                 if fDataSource.DataSet.FindField(FldName)<>nil then
                begin
                DataSource:=fDataSource;
                DataField:=FldName;
                end
                else
                begin
                    showmessage(FldName+'不存在');
                    exit;
                end;

                 Caption:=fHint;
                 //Ctl3D:=false;
            end;
          end;
        8:begin
            with TDbText.Create(fParent) do
            begin
                 Parent:=fParent;
                 font.Color  :=fntcolr;
                 Left:=l;Top:=t;Width:=w;Height:=h;
                 if fDataSource.DataSet.FindField(FldName)<>nil then
                begin
                DataSource:=fDataSource;
                DataField:=FldName;
                end
                else
                begin
                    showmessage(FldName+'不存在');
                    exit;
                end;
                 if DblClickId>-1 then
                 OnDblClick:=ActnLst.Actions[DblClickId].OnExecute;
            end
          end;
        9:begin
            with TFhlDbDatePicker.Create(Application) do
            begin
                 Parent:=fParent;
                 Left:=l;Top:=t;Width:=w;Height:=h;

                 font.Color  :=fntcolr;
                 try
                 if fDataSource.DataSet.FindField(FldName)<>nil then
                begin
                DataSource:=fDataSource;
                DataField:=FldName;
                end
                else
                begin
                    showmessage(FldName+'不存在');
                    exit;
                end;

                Ctl3D:=false;
                BevelKind:=bkNone;
                TabOrder:=orderIndex;
                visible   :=true;
                except
                      on err :exception do
                      begin
                          showmessage(err.Message );
                          exit;
                      end  ;
                end;

            end;
          end;
        10:begin
            with TDbRadioGroup.Create(Application) do
            begin
                 Parent:=fParent;
                 //Caption:='';
                 Columns:=2;
                 Height:=31;
                 Left:=l;Top:=t;Width:=w;Height:=h;
                 Items.CommaText:=trim(Fcfg_dbctrl.FieldByName('PickList').asString);    //1
                 if fDataSource.DataSet.FindField(FldName)<>nil then
                begin
                DataSource:=fDataSource;
                DataField:=FldName;
                end
                else
                begin
                    showmessage(FldName+'不存在');
                    exit;
                end;

                TabOrder:=orderIndex;                                           //2   注意先后顺序

            end;
          end;
        12:begin
             with TDbComboBox.Create(fParent) do
             begin
                Left:=l;Top:=t;Width:=w;Height:=h;
                font.Color  :=fntcolr;
                Parent:=fParent;
                Items.CommaText:=Fcfg_dbctrl.FieldByName('PickList').asString;
                if Fcfg_dbctrl.FieldByName('OnlyPick').asBoolean then
                   Style:=csOwnerDrawFixed;
                 if fDataSource.DataSet.FindField(FldName)<>nil then
                begin
                DataSource:=fDataSource;
                DataField:=FldName;
                end
                else
                begin
                    showmessage(FldName+'不存在');
                    exit;
                end;

                BevelInner:=bvRaised;BevelKind:=bkFlat;BevelOuter:=bvRaised;
                Ctl3D:=false;
                TabOrder:=orderIndex;
             end;
        end  ;
         13:begin
                  // with TdbImage.Create(fParent) do
                   with TfhlImage.Create(fParent) do
                   begin
                      Left:=l;Top:=t;Width:=w;Height:=h;
                      Parent:=fParent;
                 if fDataSource.DataSet.FindField(FldName)<>nil then
                begin
                DataSource:=fDataSource;
                DataField:=FldName;
                end
                else
                begin
                    showmessage(FldName+'不存在');
                    exit;
                end;
                      stretch:=true;
                      if DblClickId>-1 then
                        OnDblClick:=ActnLst.Actions[DblClickId].OnExecute;
//                      Ctl3D:=false;
                     TabOrder:=orderIndex;
                   end;
           end;
         14: begin
                   with TDBFile.Create(fParent) do
                   begin
                      Left:=l;Top:=t;Width:=w;Height:=h;
                      Parent:=fParent;

                       if fDataSource.DataSet.FindField(FldName)<>nil then
                      begin
                      DataSource:=fDataSource;
                      DataField:=FldName;
                      end
                      else
                      begin
                          showmessage(FldName+'不存在');
                          exit;
                      end;

                     TabOrder:=orderIndex;
                   end;
           end;

   end;
end;

procedure TFhlKnl.q_NewDbGridCol(dt:TDataSet;col:TColumn;BDifReadOnlyClr:boolean=false);
begin
       with dt do begin
         Col.FieldName:=fieldbyname('FldName').asstring;
         col.ReadOnly:=fieldbyname('colReadOnly').asBoolean;
         col.PickList.CommaText:=fieldbyname('F11').asString;

         if FieldByName('F10').asBoolean then
            col.ButtonStyle:=cbsEllipsis ;
       end;
       q_SetDbGridColStyle(dt,col,BDifReadOnlyClr);
end;

procedure TFhlKnl.q_SetDbGridColStyle(dt:TDataSet;col:TColumn ;BDifReadOnlyClr:boolean=false);
begin
  with dt do begin

     col.Width:=fieldbyname('F04').asInteger;
     col.Visible:=fieldbyname('F07').asBoolean;

    if BDifReadOnlyClr then
    begin
      if not dt.fieldbyname('colReadOnly').asBoolean then
       col.Color:=clwhite
      else
       col.Color:=StringToColor(fieldbyname('F09').asstring);
      end
    else
      col.Color:=StringToColor(fieldbyname('F09').asstring);


     col.PickList.CommaText:=FieldByName('F11').asString;
     col.DropDownRows:=fieldbyname('F12').asInteger;
     col.Title.Caption:=fieldbyname('F14').asstring;
     col.Title.Color:=StringToColor(trim(fieldbyname('F15').asstring));
     col.Title.Font.Name:=fieldbyname('F17').asstring;
     col.Title.Font.Size:=fieldbyname('F18').asInteger;
     col.Title.Font.Color:=StringToColor(fieldbyname('F19').asstring);
     col.Font.Name:=fieldbyname('F20').asstring;
     col.Font.Size:=fieldbyname('F21').asInteger;
     col.Font.Color:=StringToColor(fieldbyname('F22').asstring)    ;

     if   findfield('F27')<>nil then
     TChyColumn(col).DeciamlFormat := fieldbyname('F27').asstring;
    //     F28 order  ASC  DEC
     if   findfield('F29')<>nil then
     TChyColumn(col).SumType  :=  TSumType(  fieldbyname('F29').AsInteger  );
  end;
  col.Alignment:=Vl_GetAlignment(dt.FieldByName('F13').asInteger);
  
end;
function TFhlKnl.SetColFormat(ADbGrid: TDbGrid): boolean;
var i:integer; 
var StrSort,SortFldName:string;
var GridColsFileName:string;
begin
   if not ADbGrid.DataSource.DataSet.IsEmpty  then
   begin
        GridColsFileName:= CacheFileName('Fcfg_dbgridcol');
        if not Fcfg_dbgridcol.Active   then
        begin
           if FileExists(GridColsFileName ) then
           begin
                Fcfg_dbgridcol.LoadFromFile (GridColsFileName);
           end
           else
            begin
             Ds_OpenDataSet(Fcfg_dbgridcol,   inttostr(ADbGrid.Tag ));
             Fcfg_dbgridcol.Filtered :=False;
             if GridColsFileName<>'' then
             Fcfg_dbgridcol.SaveToFile(GridColsFileName,pfXML);
            end;
        end;

        Fcfg_dbgridcol.Filtered :=False;
      Fcfg_dbgridcol.Filter :='F02='+inttostr(ADbGrid.Tag );
      Fcfg_dbgridcol.Filtered :=true;

     with Fcfg_dbgridcol do
     begin
      First;
        while not Eof do
        begin
              SortFldName:=  Fcfg_dbgridcol.FieldByName('fldname').AsString ;
              if    ADbGrid.DataSource.DataSet.FindField  ( Fcfg_dbgridcol.FieldByName('fldname').AsString  )<>nil then
              if (  ADbGrid.DataSource.DataSet.FieldByName ( Fcfg_dbgridcol.FieldByName('fldname').AsString ).FieldKind  =  fkLookup) then
              SortFldName:= ADbGrid.DataSource.DataSet.FieldByName ( Fcfg_dbgridcol.FieldByName('fldname').AsString ).LookupKeyFields ;

              if Fcfg_dbgridcol.FieldByName('F28').AsInteger =1 then
              begin
              StrSort:=StrSort+  Fcfg_dbgridcol.FieldByName('fldname').AsString +' ASC'+',' ;
              end;

              if Fcfg_dbgridcol.FieldByName('F28').AsInteger =2 then
              begin
              StrSort:=StrSort+  Fcfg_dbgridcol.FieldByName('fldname').AsString +' DESC' +',';
              end;


              if ADbGrid.DataSource.DataSet.FindField  ( Fcfg_dbgridcol.FieldByName('fldname').AsString )<>nil then
              if  (   ADbGrid.DataSource.DataSet.FieldByName ( Fcfg_dbgridcol.FieldByName('fldname').AsString )is  TNumericField)  then
              begin
                 if     (not (   ADbGrid.DataSource.DataSet.FieldByName ( Fcfg_dbgridcol.FieldByName('fldname').AsString )is  TIntegerField))
                    and (not (   ADbGrid.DataSource.DataSet.FieldByName ( Fcfg_dbgridcol.FieldByName('fldname').AsString )is  TSmallIntField)) then

//                  if   (   ADbGrid.DataSource.DataSet.FieldByName ( Fcfg_dbgridcol.FieldByName('fldname').AsString )as  TNumericField).DisplayFormat  ='' then
                    if  Fcfg_dbgridcol.FieldByName('F27').AsString<>'' then     //2010-3-1 小数位以列设置为主
                        (  ADbGrid.DataSource.DataSet.FieldByName ( Fcfg_dbgridcol.FieldByName('fldname').AsString )as  TNumericField).DisplayFormat  := Fcfg_dbgridcol.FieldByName('F27').AsString;
//                       else
//                        (   ADbGrid.DataSource.DataSet.FieldByName ( Fcfg_dbgridcol.FieldByName('fldname').AsString )as  TNumericField).DisplayFormat  :='0.00'


              end;
              next;
        end;
        if  StrSort<>'' then
        if  ADbGrid.DataSource.DataSet.Active then
          if not ADbGrid.DataSource.DataSet.IsEmpty then
          Tadodataset(ADbGrid.DataSource.DataSet).Sort :=StrSort  ;//LstSort[0];//.DelimitedText;

     end;
     
   end;
end;
function TFhlKnl.Cf_SetDbGrid_PRT(GridId: string; dbGrid: TDbGrid): string;
var Col:TChyColumn;
var  Fcfg_dbgridCoLRpt:TADODataSet ;
var cmd:string;
begin
  try
    Fcfg_dbgridCoLRpt:=TADODataSet.Create(self);
    with Fcfg_dbgridCoLRpt do
    begin
      CommandTimeOut:=600;
      LockType:=ltReadOnly;
      CommandType:=cmdText;
      cmd:='    SELECT  c.f01 as colid,c.F07 & c.F08 AS F07, c.F06 AS colreadonly, c.F02, c.F03, c.F04, c.F05, c.F09, ';
      cmd:=cmd+'      c.F10, c.F11, c.F12, c.F13, c.F14, c.F15, c.F16, c.F17, c.F18, c.F19, c.F20, c.F21, c.F22, ';
      cmd:=cmd+'     c.F23,       c.F27,    c.F28,   isnull(c.F29,0) as F29,   f.F02 AS fldname  ,f.f07 as displayValues ';
      cmd:=cmd+'   FROM '+self.UserConnection.DefaultDatabase +'.dbo.T516 c LEFT OUTER JOIN  ';
      cmd:=cmd+'   dbo.T102 f ON f.F01 = c.F03  ';
      cmd:=cmd+'   where  c.F02  ='+quotedstr(GridId)+' order by c.f23 ';
      CommandText:=cmd ;
      Connection:=FADOConnection;
    end;


    result:='-1';
   if dbGrid.Columns.Count >0 then
    dbGrid.Columns.Clear;
    if GridId='-1' then exit;

    Fcfg_dbgridCoLRpt.Open;
    with Fcfg_dbgridCoLRpt do
    begin
      while not Eof do
      begin
        Col:=TChyColumn.Create(dbGrid.Columns);
        if  Fcfg_dbgridCoLRpt.findfield ('colid')<>nil then
        Col.colid := Fcfg_dbgridCoLRpt.fieldbyname('colid').AsString ;
        q_NewDbGridCol(Fcfg_dbgridCoLRpt,TColumn(Col),false);
        next;
      end;
      Close;
    end;
  finally
    Fcfg_dbgridCoLRpt.free ;
  end;
end;


function TFhlKnl.Cf_SetDbGrid(GridId:String;dbGrid:TDbGrid;BDifReadOnlyClr:boolean=false):String;
var Col:TChyColumn;

begin
  result:='-1';
  if dbGrid.Columns.Count >0 then
  dbGrid.Columns.Clear;
  if GridId='-1' then exit;
  //  dbGrid.PopupMenu:=FDbGridPopupMenu1;
  //  dbGrid.OnEditButtonClick:=FDbGridEditBtnClickAction1Execute;
  //格式化DbGridCol

  GridColsFileName:=CacheFileName('Fcfg_dbgridcol') ;
  if not Fcfg_dbgridcol.Active   then
  begin
     if FileExists(GridColsFileName ) then
     begin
          Fcfg_dbgridcol.LoadFromFile (GridColsFileName);
     end
     else
      begin
       Ds_OpenDataSet(Fcfg_dbgridcol,  GridId);
       Fcfg_dbgridcol.Filtered :=False;
       if GridColsFileName<>'' then
       Fcfg_dbgridcol.SaveToFile(GridColsFileName,pfXML);
      end;
  end;

  if not Fcfg_dbgridcol.Active   then
     Ds_OpenDataSet(Fcfg_dbgridcol,   GridId);
  Fcfg_dbgridcol.Filtered :=False;
  Fcfg_dbgridcol.Filter :='F02='+GridId;
  Fcfg_dbgridcol.Filtered :=true;

  with Fcfg_dbgridcol do
  begin
    while not Eof do
    begin
      Col:=TChyColumn.Create(dbGrid.Columns);
      if  Fcfg_dbgridcol.findfield ('colid')<>nil then
      Col.colid := Fcfg_dbgridcol.fieldbyname('colid').AsString ;
      q_NewDbGridCol(Fcfg_dbgridcol,TColumn(Col),BDifReadOnlyClr);
      next;
    end;
  end;
  //格式化DbGrid                      DbGrid config

  if  not Fcfg_dbgrid.Active   then
  Ds_OpenDataSet(Fcfg_dbgrid,GridId);
  Fcfg_dbgrid.Filtered :=False;
  Fcfg_dbgrid.Filter :='f01='+GridId;
  Fcfg_dbgrid.Filtered :=true;

  with Fcfg_dbgrid do
  begin
      if Not IsEmpty then
      begin
          DbGrid.Font.Size :=10;      //默认10号字体  以后加入字体大小设置
          DbGrid.ReadOnly:=FieldbyName('F04').asBoolean;
          DbGrid.Tag:=strToint(GridId);

          if FieldByName('F10').AsBoolean then
             DbGrid.Options:=DbGrid.Options+[dgRowSelect]
          else
             DbGrid.Options:=DbGrid.Options-[dgRowSelect];
          //The user can edit data using the grid. dgEditing is ignored if Options includes dgRowSelect.

          if FieldByName('F05').asBoolean then
             DbGrid.Options:=DbGrid.Options+[dgEditing]
          else
             DbGrid.Options:=DbGrid.Options-[dgEditing];
          if FieldByName('F13').AsBoolean then
             DbGrid.Options:=DbGrid.Options+[dgAlwaysShowEditor]
          else
             DbGrid.Options:=DbGrid.Options-[dgAlwaysShowEditor];

          if FieldByName('F09').asBoolean then
             DbGrid.Options:=DbGrid.Options+[dgMultiSelect]
          else
             DbGrid.Options:=DbGrid.Options-[dgMultiSelect];

          Result:=FieldByName('F03').asString;
           if (DbGrid.Parent is TTabSheet) then
                (DbGrid.Parent as   TTabSheet).caption:=FieldByName('F02').asString; 
      end;
      Close;
   end;
end;

procedure TFhlKnl.q_SetLabel(BoxId:String;fParent:TWinControl);
  var l:TLabel;
begin
  DBLabelsFileName:= CacheFileName('Fcfg_label');
  if not Fcfg_label.Active   then
  begin
     if FileExists(DBLabelsFileName ) then
     begin
          Fcfg_label.LoadFromFile (DBLabelsFileName);
     end
     else
      begin
        Ds_OpenDataSet(Fcfg_label,varArrayof([BoxId]));
       Fcfg_label.Filtered :=False;
       if DBLabelsFileName<>'' then
       Fcfg_label.SaveToFile(DBLabelsFileName,pfXML);
      end;
  end;

  Fcfg_label.Filtered :=false;
  if Fcfg_label.FindField('f300')<>nil then
    Fcfg_label.Filter :='F02='+quotedstr(BoxId)+' and f300=1'
  else
    Fcfg_label.Filter :='F02='+quotedstr(BoxId) ;
  Fcfg_label.Filtered :=True;


  with Fcfg_label do
  begin
    while not Eof do
    begin
     l:=TLabel.Create(fParent);
     l.ShowHint :=false;
     l.hint :=FieldByName('F01').AsString ;
     l.parent:=fParent;
     l.Left:=FieldByName('F04').asInteger;
     l.Top:=FieldByName('F05').asInteger;
     l.Caption:=FieldByName('F03').asString;

     if FieldByName('F06').asString='clBtnFace' then
     begin
       if fParent is TScrollBox then
       l.Color:= TScrollBox(fParent).Color ;
     end
     else
     l.Color:=StringToColor(FieldByName('F06').asString);
     l.Transparent:=FieldByName('F07').asBoolean;
     l.Font.Color:=StringToColor(FieldByName('F10').asString);
     l.Font.Name:=FieldByName('F08').asString;
     l.Font.Size:=FieldByName('F09').asInteger;
     if FieldByName('F11').asBoolean then
        l.Font.Style:=l.Font.Style+[fsBold];
     if FieldByName('F12').AsBoolean then
        l.Font.Style:=l.Font.Style+[fsUnderline];
     Next;
    end;
  end;
end;

procedure TFhlKnl.q_SetDbCtrl(ABoxId:String;ADataSource:TDataSource;AParent:TWinControl;ActnLst:TActionList);
var MaxTop:integer;
var pHeight:integer;
begin
  MaxTop:=0;
  
  DBCtrlsFileName:= CacheFileName('Fcfg_dbctrl');
  if not Fcfg_dbctrl.Active   then
  begin
     if FileExists(DBCtrlsFileName ) then
     begin
          Fcfg_dbctrl.LoadFromFile (DBCtrlsFileName);
     end
     else
      begin
        Ds_OpenDataSet(Fcfg_dbctrl,varArrayof([ABoxId]));
       Fcfg_dbctrl.Filtered :=False;
       if DBCtrlsFileName<>'' then
       Fcfg_dbctrl.SaveToFile(DBCtrlsFileName,pfXML);
      end;
  end;

  Fcfg_dbctrl.Filtered :=false;
  if Fcfg_dbctrl.FindField('f300')<>nil then
    Fcfg_dbctrl.Filter :='Boxid='+quotedstr(ABoxId)+' and f300=1'
  else
    Fcfg_dbctrl.Filter :='Boxid='+quotedstr(ABoxId) ;
  Fcfg_dbctrl.Filtered :=True;


  with Fcfg_dbctrl do
  begin
      if Not IsEmpty then
      begin
        First;
        while not Eof do
        begin
          q_CreateDbCtrl(ADataSource,AParent,ActnLst);
          if FieldByName('posTop')<>nil then
          if MaxTop<FieldByName('posTop').AsInteger  then
          begin
            MaxTop:=FieldByName('posTop').AsInteger;
            pHeight:=FieldByName('Height').AsInteger;
          end;
          Next;
        end;
        AParent.Height:=pHeight+MaxTop+10;
      end;
  end;
end;

procedure TFhlKnl.Cf_SetBox(ABoxId:String;ADataSource:TDataSource;AParent:TWinControl;ActnLst:TActionList);
begin
  //AParent.Tag:=strToint(ABoxId);
  q_SetLabel(ABoxId,AParent);
  q_SetDbCtrl(ABoxId,ADataSource,AParent,ActnLst);
  //CheckCtrlFieldsUnique (AParent);   //2010-2-27与取拼音冲突
end;

procedure TFhlKnl.Cf_ListAllNode(myTreeCodeDataSet:TDataSet;TreeView:TTreeView;ImgIdx,SelIdx:Integer;CodeFld,NameFld:String;ShowCode:Boolean=True;ShowDeleted:boolean=true);
var
  Node:TTreeNode;
  ii:integer;
  s,t:String;
begin
      with myTreeCodeDataSet do
      begin
          First;
          while not eof do
          begin
              if not  ShowDeleted then                       //2010-1-30
                if  myTreeCodeDataSet.FindField('FDEL')<>nil then
                   if  myTreeCodeDataSet.Fieldbyname('FDEL').AsBoolean =true then
                    next;

              s:=FieldByName(trim(CodeFld)).asString;
              t:=FieldByName(trim(NameFld)).AsString;
              if ShowCode then t:=t+'['+s+']';
              ii:=length(s);
              while ii>0 do
              begin
                    ii:=ii-1;
                    Node:=Tv_FindNode(TreeView,copy(s,1,ii));
                    if Node<>nil then
                    begin
                          Tv_NewDataNode(TreeView,Node,s,t,ImgIdx ,SelIdx);
                          Break;
                    end;
              end;
              next;
           end;
      end;
end;
procedure TFhlKnl.Cf_SetTreeViewCrm(ATreeId: string; ATreeView: TTreeView;
  ANodeDataSet: TDataSet; AParam: variant);
var
  fDataSetId,fRootTxt,fTxtFld,fDataFld:String;
  fRootImgIdx,fWidth:integer;
begin
  //
  Kl_GetQuery2('select * from T703 where F01='+ATreeId);
  with FFre_Query do
  begin
      if RecordCount=1 then
      begin
          fDataSetId:=FieldByName('F07').asString;
          fRootTxt:=FieldByName('F05').asString;
          fRootImgIdx:=FieldByName('F06').asInteger;
          fTxtFld:=FieldByName('F08').asString;
          fDataFld:=FieldByName('F09').asString;
          fWidth:=FieldByName('F10').asInteger;
      end
      else
          Exit;
      Close;
  end;
  if ATreeView.Align=alClient then ATreeView.Parent.Width:=fWidth;
  Tv_NewDataNode(ATreeView,nil,'',fRootTxt,fRootImgIdx,fRootImgIdx);
  //
  Cf_SetDataSet(ANodeDataSet,fDataSetId,nil);
  Ds_OpenDataSet(ANodeDataSet, FhlKnl1.Vr_MergeVarArray ( varArrayof([ATreeId]) ,AParam) );

  Cf_ListAllNode(ANodeDataSet,ATreeView,20,0,fDataFld,fTxtFld,False);
  with ATreeView.Items.GetFirstNode do
  begin
       Expand(False);
       if GetFirstChild<>nil then
          GetFirstchild.Expand(False);
  end;
end;

procedure TFhlKnl.Cf_SetTreeView(ATreeId:String;ATreeView:TTreeView;ANodeDataSet:TDataSet;AParam:variant;TreeTable:string);
var
  fDataSetId,fRootTxt,fTxtFld,fDataFld:String;
  fRootImgIdx,fWidth:integer;

begin
  ATreeView.Tag :=strtoint(ATreeId);
  Kl_GetQuery2('select * from '+TreeTable+' where F01='+ATreeId );
  with FFre_Query do
  begin
      if RecordCount=1 then
      begin
          fDataSetId:=FieldByName('F07').asString;
          fRootTxt:=FieldByName('F05').asString;
          fRootImgIdx:=FieldByName('F06').asInteger;
          fTxtFld:=FieldByName('F08').asString;
          fDataFld:=FieldByName('F09').asString;
          fWidth:=FieldByName('F10').asInteger;
          ATreeView.Width:=fWidth;
      end
      else
          Exit;
      Close;
  end;
  if ATreeView.Align=alClient then ATreeView.Parent.Width:=fWidth;
  Tv_NewDataNode(ATreeView,nil,'',fRootTxt,fRootImgIdx,fRootImgIdx);
  //
  AParam:= Vr_MergeVarArray   ( FhlUser.GetSysParamsVal(  Cf_SetDataSet(ANodeDataSet,fDataSetId,nil)),AParam);

  Ds_OpenDataSet(ANodeDataSet, FhlKnl1.Vr_MergeVarArray ( varArrayof([ATreeId]) ,AParam) );



  Cf_ListAllNode(ANodeDataSet,ATreeView,20,0,fDataFld,fTxtFld,False);
  with ATreeView.Items.GetFirstNode do
  begin
       Expand(False);
       if GetFirstChild<>nil then
          GetFirstchild.Expand(False);
  end;

  ATreeView.Tag :=strtoint(ATreeId);
end;

function TFhlKnl.Cf_GetDict_ExcPrc(AId:String;var ADict:TExcPrcDict):Boolean;
begin
  Result:=False;
  ADict.Id:=AId;
  Kl_GetQuery2('select * from T402 where F01='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.ProcName:=Format( FieldByName('F02').AsString, [FAdoConnection.DefaultDataBase ]);  //2011-4-14
     // ADict.ProcName:=FieldByName('F02').AsString;
      ADict.SysParams:=FieldByName('F03').AsString;
      ADict.UsrParams:=FieldByName('F04').AsString;
      ADict.RightId:=FieldByName('F05').AsString;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function TFhlKnl.Cf_GetDict_BilOpnDlg(AFrmId:string;var ADict:TBilOpnDlgDict):Boolean;
begin
  Result:=False;
  ADict.Id:=AFrmId;
  Kl_GetQuery2('select * from T608 where F01='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.DbGridId:=FieldByName('F02').AsInteger;
      ADict.KeyFldName:=FieldByName('F03').AsString;
      ADict.BillTitle:=FieldByName('F04').AsString;
      ADict.SearchIdx:=FieldByName('F05').AsInteger;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function TFhlKnl.Cf_GetDict_afterSave(FrmId:String;var Dict:TTrAfterSave):Boolean;
begin
 Result:=False;

  Kl_GetQuery2('select * from T207 where FrmId='+FrmId);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
        Dict.ProcName := FieldByName('ProcName').asString;
        Dict.sysPrama:= FieldByName('sysPrama').asString;
        Dict.UserPrama:= FieldByName('UserPrama').asString;
        Dict.ErrHint  := FieldByName('ErrHint').asString;
        Result:=true;
    end;
    end;

end;

function TFhlKnl.Cf_GetDict_Bill(FrmId:String;var Dict:TBillDict):Boolean;
begin
  Result:=False;
  Dict.Id:=FrmId;
  Kl_GetQuery2('select * from T602 where F01='+FrmId);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
         Dict.BillCnName:=FieldByName('F04').asString;
Dict.TitleLabelFontColor:=FieldByName('F05').asString;
 Dict.TitleLabelFontSize:=FieldByName('F06').asInteger;
 Dict.TitleLabelFontName:=FieldByName('F07').asString;

           Dict.mttblid:=FieldByName('F09').asString;

           Dict.mkeyfld:=FieldByName('F11').asString;
           Dict.fkeyfld:=FieldByName('F12').asString;


          Dict.TopBoxId:=FieldByName('F15').asString;
          Dict.BtmBoxId:=FieldByName('F16').asString;
          Dict.dlGridId:=FieldByName('F17').asString;
       Dict.mtDataSetId:=FieldByName('F18').asString;
           Dict.savproc:=FieldByName('F19').AsString;
          Dict.mtGridId:=FieldByName('F20').asString;
           Dict.chkproc:=FieldByName('F21').asString;
            Dict.pickid:=FieldByName('F22').asString;

          Dict.dlSumFlds:=Vr_CommaStrToVarArray(FieldByName('F23').asString);
          Dict.mtSumFlds:=Vr_CommaStrToVarArray(FieldByName('F24').asString);
             Dict.QtyFld:=FieldByName('F25').asString;
          Dict.ReadRitId:=FieldByName('F26').asString;
         Dict.WriteRitId:=FieldByName('F27').asString;
         Dict.CheckRitId:=FieldByName('F28').asString;
         Dict.PrintRitId:=FieldByName('F29').asString;
            Dict.vldproc:=FieldByName('F30').asString;
            Dict.clsproc:=FieldByName('F31').asString;
         Dict.UnChkRitId:=FieldByName('F32').AsString;
          Dict.unchkproc:=FieldByName('F33').AsString;

          Dict.PickIDMulPage:= FieldByName('F35').AsString;

    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function TFhlKnl.Cf_GetDict_Bill_Ex(FrmId: string;
  var Dict: TBillDictEx): Boolean;
begin
      Result:=False;
      Dict.Id:=FrmId;
      Kl_GetQuery2('select * from T625 where F01='+FrmId);
      if FFre_Query.RecordCount=1 then
      begin
          with  FFre_Query do
          begin
             Dict.Maincaption :=FieldByName('F02').AsString;
             Dict.ActID       :=FieldByName('F03').AsInteger ;
             dict.MtDataSetID :=FieldByName('F04').AsString;
             dict.TopBoxID :=FieldByName('F05').AsString ;
             dict.BtmBoxID :=FieldByName('F06').AsString ;
             dict.DLGridID :=FieldByName('F07').AsString ;
             
             dict.OpenID :=FieldByName('F09').AsString;
             dict.ImportID :=FieldByName('F10').AsString;
             dict.mtSumFlds :=FieldByName('F11').AsString;
             dict.dlSumFlds :=FieldByName('F12').AsString;
             dict.QtyFld :=FieldByName('F13').AsString;
             dict.mkeyfld :=FieldByName('F14').AsString;
             dict.fkeyfld :=FieldByName('F15').AsString;

             dict.ChkProc   :=FieldByName('F16').AsString;
             dict.UnChkProc :=FieldByName('F17').AsString;
             dict.ReportID  :=FieldByName('F18').AsString;
             dict.DlPriceFld:=FieldByName('F19').AsString;
             dict.DlFundFld :=FieldByName('F20').AsString;
             dict.ChkRightId  :=FieldByName('F21').AsString;
             dict.UnChkRightId :=FieldByName('F22').AsString;
             dict.IsNeedEdit  :=FieldByName('F23').AsBoolean ;
             dict.ChkFieldName :=  FieldByName('F24').AsString  ;
             dict.IsChkValue   :=  FieldByName('F25').AsString  ;
             dict.AutoKeyID   :=  FieldByName('F26').AsString  ;
             



           //  dict. :=FieldByName('F15').AsString;

             { F16 varchar(20) not null , -   ChkProc
 F17 varchar(20) not null , -   UnChkProc
 F18 varchar(20) not null , -   ReportID

 F19 varchar(20) not null , -   DlPriceFld
 F20 varchar(20) not null , -   DlFundFld}
          end;
          Result:=True;
      end;
      FFre_Query.Close;
end;
{
function TFhlKnl.Cf_GetDict_1(ADictId:String;var ADict:TDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2();
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.mkeyfld:=FieldByName('F').asString;

    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;
}

function TFhlKnl.Cf_GetDict_AfterPost(ADictId:String;var ADict:TAfterPostDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T205 where F01='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
        ADict.fProc:=FieldByName('F03').asString;
        ADict.fSysParams:=FieldByName('F04').asString;
        ADict.fDataParamFlds:=FieldByName('F05').asString;
        ADict.fErrorHint:=FieldByName('F06').asString;
        ADict.CmdType :=FieldByName('F20').AsInteger ;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;


function TFhlKnl.Cf_GetDict_BeforePost(ADictId:String;var ADict:TBeforePostDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T204 where F01='+ADictId);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.AutoKeyId:=FieldByName('F06').asString;
      ADict.AutoKeyFld:=FieldByName('F05').asString;
      ADict.SameValFlds:=FieldByName('F09').asString;
      ADict.SameValHint:=FieldByName('F10').asString;
      ADict.EdtProc:=FieldByName('F13').asString;
      ADict.EdtSysParams:=FieldByName('F14').asString;
      ADict.EdtUsrParams:=FieldByName('F15').asString;
      ADict.PostHint:=FieldByName('F17').asString;
      ADict.PostSysParams:=FieldByName('F18').asString;
      ADict.PostUsrParams:=FieldByName('F19').asString;
      ADict.AddRitId:=FieldByName('F11').asString;
      ADict.EditRitId:=FieldByName('F12').asString;
      ADict.CmdType :=FieldByName('F20').AsInteger ;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;



function TFhlKnl.Cf_GetDict_BeforeDelete(ADictId:String;var ADict:TBeforeDeleteDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T203 where F01='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.Hint:=FieldByName('F03').asString;
      ADict.Proc:=  Format(FieldByName('F04').asString,[fhlknl1.Connection.DefaultDataBase]);
      ADict.EdtSysParams:=FieldByName('F05').asString;
      ADict.EdtUsrParams:=FieldByName('F06').asString;
      ADict.ErrorHint:=FieldByName('F07').asString;
      ADict.DelRitId:=FieldByName('F08').asString;
      ADict.CmdType :=FieldByName('F20').AsInteger ;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function TFhlKnl.Cf_GetDict_Finder(ADictId:String;var ADict:TFinderDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T614 where F01='+ADictId);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.fSelect:=FieldByName('F03').asString;
      ADict.fWhere:=FieldByName('F04').AsString;
      ADict.fGroup:=FieldByName('F05').asString;
    //    fDict.fHaving:=FieldByName('F06').asString;
      ADict.fOrder:=FieldByName('F07').asString;
      ADict.fItemIdx:=FieldByName('F09').asInteger;
      ADict.fCompareIdx:=FieldByName('F10').asInteger;
      ADict.fSysParams:=FieldByName('F11').asString;
    end;
    ADict.fDtlSql:=Format('select * from T615 where F13=1 and F02=''%s'' order by F03',[ADictId]);
    Result:=True;
  end;
  FFre_Query.Close;
end;


function TFhlKnl.Cf_GetDict_TreeMgr(ADictId:String;var ADict:TTreeMgrDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T620 where F01='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.Caption:=FieldByName('F02').asString;
      ADict.TreeId:=FieldByName('F03').asString;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;


function TFhlKnl.Cf_GetDict_TreeGrid(ADictId:String;var ADict:TTreeGridDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T612 where F01='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.Caption:=FieldByName('F02').asString;
      ADict.DbGridId:=FieldByName('F04').asString;
      ADict.EditorId:=FieldByName('F05').asString;
      ADict.Actions:=FieldByName('F09').asString;
      ADict.IsOpen:=FieldByName('F11').asBoolean;
      ADict.ClassFld:=FieldByName('F12').asString;
      ADict.WriteRitId:=FieldByName('F13').asString;
      ADict.DeleteRitId:=FieldByName('F14').asString;
      ADict.PrintRitId:=FieldByName('F15').asString;
      ADict.TreeId:=FieldByName('F16').asString;
      ADict.GridUserMenuIDs :=FieldByName('F17').AsInteger ;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;
  {
function TFhlKnl.Cf_GetDict_ImageDlg(ADictId:String;var ADict:TImageDlgDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from TImageDict where F03='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
   

    
    end;
    Result:=True;
  end;
  FFre_Query.Close;

end;   }
function TFhlKnl.Cf_GetDict_TreeDlg(ADictId:String;var ADict:TTreeDlgDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T610 where F03='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
     ADict.Id:=FieldByName('F01').asString;
     ADict.Caption:=FieldByName('F02').asString;
     ADict.ChgFldNames:=FieldByName('F04').asString;
     ADict.LkpChgFldNames:=FieldByName('F05').asString;
     ADict.RootText:=FieldByName('F06').asString;
     ADict.CodeFldName:=FieldByName('F07').asString;
     ADict.NameFldName:=FieldByName('F08').asString;
     ADict.IsExpand:=FieldByName('F09').asBoolean;
     ADict.ParentSelect:=FieldByName('F10').AsBoolean;
    end;
    Result:=True;
  end
  else
  MessageBox(0, '重复记录！', '', MB_OK + MB_ICONQUESTION);
  
  FFre_Query.Close;
end;


function TFhlKnl.Cf_GetDict_TabGrid(ADictId:String;var ADict:TTabGridDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T618 where F01='''+ADict.Id+'''');
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.Caption:=FieldByName('F02').asString;
      Adict.DbGridId:=FieldByName('F03').asString;
      ADict.Width:=FieldByName('F04').asInteger;
      ADict.Height:=FieldByName('F05').asInteger;
      ADict.CanInsert:=True;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function TFhlKnl.Cf_GetDict_TabEditor(ADictId:String;var ADict:TTabEditorDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T606 where F01='''+ADictId+'''');
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.BoxIds:=FieldByName('F04').asString;
      ADict.width:=FieldByName('F05').asInteger;
      ADict.height:=FieldByName('F06').asInteger;
      ADict.Caption:=FieldByName('F02').asString;
      ADict.DataSetId:=FieldByName('F03').asString;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function TFhlKnl.Cf_GetDict_PickUniversal(ADictId:String;var ADict:TPickDictPickMulPage):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T623 where pk='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin

      ADict.Catpion:=FieldByName('F02').asString;
      ADict.FromKeyFlds:=FieldByName('F03').asString;
      ADict.ToKeyFlds:=FieldByName('F04').asString;
      ADict.FromCpyFlds:=FieldByName('F05').asString;
      ADict.ToCpyFlds:=FieldByName('F06').asString;
      ADict.MtParams:=FieldByName('F07').asString;
      ADict.IsOpen:=FieldByName('F08').asBoolean;
      ADict.Actions:=FieldByName('F09').asString;
      ADict.IsRepeat:=FieldByName('F10').asBoolean;
      ADict.BoxID:=FieldByName('F11').asString;
      ADict.DbGridIds:=FieldByName('F12').asString;
      ADict.DbGridCaptions:=FieldByName('F13').asString;
      ADict.mtDataSetId:=FieldByName('F14').asString;//public
      ADict.DLParams := FieldByName('F15').asString;//public

 {   Catpion:String;
   FromKeyFlds:String;
   ToKeyFlds:String;
   FromCpyFlds:wideString;
   ToCpyFlds:wideString;
   MtParams:String;
   IsOpen:Boolean;
   Actions:String;
   IsRepeat:Boolean;
   BoxIDs:string;
   DbGridIds:String;
   DbGridCaptions:String;}

    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function TFhlKnl.Cf_GetDict_Pick(ADictId:String;var ADict:TPickDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T603 where F01='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.Catpion:=FieldByName('F02').asString;
      ADict.DbGridId:=FieldByName('F03').asString;
      ADict.MtParams:=FieldByName('F04').asString;
      ADict.FromKeyFlds:=FieldByName('F05').asString;
      ADict.ToKeyFlds:=FieldByName('F06').asString;
      ADict.FromCpyFlds:=FieldByName('F07').asString;
      ADict.ToCpyFlds:=FieldByName('F08').asString;
      ADict.IsOpen:=FieldByName('F09').asBoolean;
      ADict.Actions:=FieldByName('F10').asString;
      ADict.IsRepeat:=FieldByName('F11').asBoolean;

      ADict.WarePropRitId :=     FieldByName('F12').AsString ;
      ADict.slPriceInRfsRitID := FieldByName('F13').AsString ;
      ADict.slPriceOutRfsRitID:= FieldByName('F14').AsString ;
      ADict.phQuoteRitID:=       FieldByName('F15').AsString ;
      ADict.ydWarepropRitID:=    FieldByName('F16').AsString ;
      ADict.phOrderdlRitID:=     FieldByName('F17').AsString ;



    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function TFhlKnl.Cf_GetDict_More2More(ADictId:String;var ADict:TMore2MoreDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T619 where F01='''+ADictId+'''');
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.Id:=FieldByName('F01').asString;
      ADict.Caption:=FieldByName('F02').asString;
      ADict.Subject:=FieldByname('F03').asString;
      ADict.DbGridId:=FieldByName('F04').asString;
      ADict.mtFld:=FieldByname('F05').asString;
      ADict.dlFld:=FieldByName('F06').asString;
      ADict.LkpType:=FieldByName('F07').asString;
      ADict.EditRitId:=FieldByName('F08').asString;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;


function TFhlKnl.Cf_GetDict_Lookup(ADictId:String;var ADict:TLookupDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T607 where F12='+ADictId);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
           ADict.Id             :=FieldByName('F01').asString;
           ADict.DbGridId       :=FieldByName('F03').asString;
           ADict.ChgFldNames    :=FieldByName('F08').asString;
           ADict.LkpChgFldNames :=FieldByName('F09').asString;
           ADict.Caption        :=FieldByName('F13').asString;
           ADict.FilterFldName  :=FieldByName('F14').asString;
           ADict.LkpFldName     :=FieldbyName('F15').asString;
           ADict.DefIdx         :=FieldByName('F16').asInteger;

           ADict.fUserParametersFld:=FieldByName('F20').AsString ;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;



function TFhlKnl.Cf_GetDict_Analyser(ADictId:String;var ADict:TAnalyserDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select T601.*,T401.F02 as Y,T401.F03 as Z from T601 left outer join T401 on T601.F05=T401.F01 where T601.F01='+ADict.Id);
  if FFre_Query.RecordCount=1 then
  begin
      with  FFre_Query do
      begin
          ADict.Caption:=FieldByName('F02').asString;
          ADict.DbGridId:=FieldByName('F03').asString;
          ADict.mtDataSetId:=FieldByName('Y').asString;
          ADict.mtOpenParamFlds:=FieldByName('Z').asString;
          ADict.LinkT401Pk  :=FieldByName('F05').asString;
          ADict.TopBoxId    :=FieldByName('F06').asString;
          ADict.BtmBoxId    :=FieldByName('F07').asString;

          ADict.IsOpen      :=FieldByName('F08').asBoolean;
          ADict.Actions:=            FieldByName('F12').asString;
          ADict.DblActIdx:=          FieldByName('F13').asInteger;
          ADict.Tag:=                FieldByName('F14').asString;

          ADict.QryParamsFLDs    :=FieldByName('F16').asString;
        //  ADict.Modeltype      :=FieldByName('F17').asString;
        //  ADict.FrmID          :=FieldByName('F18').asString;     //移到button 上

          ADict.printID :=     FieldByName('F25').AsString ;
      end;
      Result:=True;
  end;
  result:=False;
  FFre_Query.Close;
end;


function TFhlKnl.Cf_GetDict_TreeEDitor(ADictId:String;var ADict:TTreeEditorDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T611 where F01='+ADictId);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.FrmCaption  :=FieldByName('F02').asString;
      ADict.BoxId       :=FieldByName('F03').asString;
      ADict.DbGridId    :=FieldByName('F04').asString;
      ADict.RootCaption :=FieldByName('F05').asString;
      ADict.CodeFld     :=FieldByName('F06').asString;
      ADict.NameFld     :=FieldByName('F07').asString;
      ADict.PrintRitId  :=FieldByName('F09').asString;
      ADict.MultiLevel  :=FieldByName('F10').AsBoolean;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;




function TFhlKnl.Cf_GetDict_Editor(ADictId:String;var ADict:TEditorDict):Boolean;
begin
  Result:=False;
  ADict.Id:=ADictId;
  Kl_GetQuery2('select * from T616 where F01='''+ADictId+'''');
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
      ADict.Id:=ADictId;
      ADict.Caption:=FieldByName('F02').asString;
      ADict.BoxIds:=FieldByName('F03').asString;
      ADict.DataSetId:=FieldByName('F04').asString;
      ADict.Height:=FieldByName('F05').asInteger;
      ADict.Width:=FieldByName('F06').asInteger;
      ADict.CpyFlds:=FieldByName('F07').asString;
      ADict.PrintRitId:=FieldByName('F14').asString;
      ADict.Actions :=FieldByName('F15').asString;
      if findfield('F16')<>nil then
      ADict.TabCaptins    :=FieldByName('F16').asString;

      //f17 logupdating  f18 grid
      if findfield('F19')<>nil then
         adict.BtmPrintID :=FieldByName('F19').asString;
      if findfield('F20')<>nil then
         adict.OpenParameterFields :=FieldByName('F20').asString;
      if findfield('F21')<>nil then
         adict.PKFieldName :=FieldByName('F21').asString;
      if findfield('F22')<>nil then
         adict.CheckProc :=FieldByName('F22').asString;
      if findfield('F23')<>nil then
         adict.UnCheckProc :=FieldByName('F23').asString;
      if findfield('F24')<>nil then
         adict.ChkFieldName :=FieldByName('F24').asString;
      if findfield('F25')<>nil then
         adict.IsChkValue :=FieldByName('F25').asString;

    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;


function  TFhlKnl.Cf_SetdsFinderDictInfo(FrmId:String;var Dict:TdsFinderDict):Boolean;
begin
  Result:=False;
  Dict.Id:=FrmId;
  Kl_GetQuery2('select * from T613 where F01='+FrmId);
  if FFre_Query.RecordCount=1 then
  begin
    with  FFre_Query do
    begin
       Dict.Caption:=FieldByName('F02').asString;
       Dict.BoxIds:=FieldByName('F03').asString;
       Dict.DataSetId:=FieldByName('F04').asString;
       Dict.Width:=FieldByName('F05').asInteger;
       Dict.Height:=FieldByName('F06').asInteger;
       Dict.Select:=FieldByName('F07').asString;
       Dict.Pre:=FieldByName('F08').asString;
       Close;
    end;
    Result:=True;
  end;
  FFre_Query.Close;
end;

function  TFhlKnl.Dg_GetDbGrdEdtActnId(ADbGrid:TDbGrid):integer;
begin
  KL_GetQuery2('select F24 from T505 where F02='+intTostr(ADbGrid.Tag)+' and F03='+ intTostr(ADbGrid.SelectedField.Tag));
  Result:=FFre_Query.Fields[0].AsInteger;
  FFre_Query.Close;
end;

procedure TFhlKnl.Cf_SetMainMenu(MenuId:String;MainMenu:TMainMenu;ToolBar:TToolBar;ActionList:TActionList;MenuDataSet:TDataSet );
var
  myItem,fItem:TMenuItem;
  i:integer;
  dt:TDataSet;
  PCName :string;
begin

  MainMenu.Items.Clear;
  Tb_ClearTlBtn(ToolBar);

  {
  if MenuDataSet=nil then
  begin
    Kl_GetQuery2('select * from T511 where F03='+MenuId+' order by F01');        //系统菜单
    dt:=FFre_Query;
  end
  else
  }
    dt:=MenuDataSet;

  PCName:=  Os_GetComputerName ;
  if   (uppercase(PCName)<>'CHYPC') then
  begin
      dt.Filtered :=false;
      dt.Filter :=' FisSys=0 or      FisSys = null';
      dt.Filtered :=true;
  end;
  with dt do
  begin
   while not eof do
   begin
    //Self
        myItem:=TMenuItem.Create(MainMenu);

        myItem.Caption:=  FieldByName('F04').asString;//Cf_GetUserMenuName(  FieldByName('F04').asString,FieldByName('F_ID').asString) ;

        myItem.ShortCut:=TextToShortCut(FieldByName('F07').asString);

        myItem.Tag:=FieldByName('F06').asInteger;

        myItem.ImageIndex:=FieldByName('F08').asInteger;

        myItem.Name:=FieldByName('F01').asString;
        myItem.GroupIndex:=FieldByName('F13').asInteger;

        //Parent
        i:=length(myItem.Name);
        while i>1 do
        begin
              i:=i-1;
              fItem:=Mn_FindMainMenuItem(MainMenu,copy(myItem.Name,1,i));
              if fItem<>nil then
              begin
                  fItem.Add(myItem);
                  Break;
              end;
        end;

        if fItem=nil then
           MainMenu.Items.Add(myItem);
        //Event
        i:=FieldByName('F05').asInteger;
        if (i>-1) and (i<ActionList.ActionCount) then
        begin
           myItem.OnClick:=ActionList.Actions[i].OnExecute;
           myItem.Checked :=true;
        end;

        if FieldByName('F10').asBoolean then
        begin
          with TToolButton.Create(ToolBar) do
          begin
            name:=   myItem.Name ;
            Parent:=ToolBar;
            Caption:=FieldByName('F11').asString;
            ImageIndex:=myItem.ImageIndex;
            Tag:=myItem.Tag;
            OnClick:=myItem.OnClick;
          end;
        end;
    
    next;
   end;
   //close;
  end;

  if ( ToolBar.ControlCount =0 ) and ( mainmenu.Items.Count >0 )  then        
      with TToolButton.Create(ToolBar) do
      begin
        name:= mainmenu.Items[0].Name ;
        Parent:=ToolBar;
        Caption:=mainmenu.Items[0].Name ;
        ImageIndex:=mainmenu.Items[0].ImageIndex;
      end;
     { }

end;

//----------------TFhlDbEdit---------------

procedure TFhlDbEdit.WndProc(var Message:TMessage);
const
  SC_DragMove = $F012;
begin
  if Message.Msg=Cm_Enter then
  begin
    if Assigned( OnDblClick ) then
    self.Ctl3D :=True;

    if ReadOnly then
       Color:=clYellow
    else
       Color:=Tcolor(ClCtrlEnter ) ;//clAqua;


  end
  else if Message.Msg=Cm_Exit then
  begin
    Color:=clWhite;//InitColor;
  end
  else if (Message.Msg=WM_LBUTTONDOWN) and (FDesign) then
  begin
    ReleaseCapture;
    Self.Perform(WM_SysCommand, SC_DragMove, 0);
  end;
  Inherited WndProc(Message);
end;


procedure TFhlDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (ssCtrl in Shift) and (ssAlt in Shift) and (ssShift in Shift) then
  begin
    FDesign:=Not FDesign;
    ReleaseCapture;
  end;
end;

constructor TFhlDbDatePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];// + [csFramed];;
//  Perform(DTM_SETFORMAT, 0, DWORD(PCHAR('yyyy/MM/dd')));
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TFhlDbDatePicker.Destroy;
begin

  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;

end;

procedure TFhlDbDatePicker.SetDataField(const Value: string);
begin
//  if not (csDesigning in ComponentState) then
//    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

procedure TFhlDbDatePicker.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TFhlDbDatePicker.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TFhlDbDatePicker.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TFhlDbDatePicker.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TFhlDbDatePicker.Change;
begin
  FDataLink.Edit;
  FDataLink.Modified;
  inherited Change;
end;

procedure TFhlDbDatePicker.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
//    SelectAll;
    SetFocus;
    raise;
  end;
//  SetFocused(False);
//  CheckCursor;
  DoExit;

end;

procedure TFhlDbDatePicker.wmpaint(var message: tmessage);
//var
 // dc: hdc;
 // Rec: TRect;
 // BtnFaceBrush, WindowBrush: HBRUSH;
begin
  inherited;
{
  BtnFaceBrush := CreateSolidBrush(ColorToRGB(clwhite));
  WindowBrush := CreateSolidBrush(ColorToRGB(clBlack));
  Rec.TopLeft := ClientToScreen(ClientRect.TopLeft);
  Rec.BottomRight := ClientToScreen(ClientRect.BottomRight);
  dc := getdc(0);
  InflateRect(Rec, 1, 1);
  FrameRect(dc, Rec, BtnFaceBrush);
  InflateRect(Rec, 1, 1);
  FrameRect(dc, Rec, WindowBrush);
  releasedc(0, dc);
  DeleteObject(WindowBrush);
  DeleteObject(BtnFaceBrush);
  }
end;


procedure TFhlDbDatePicker.WndProc(var Message:TMessage);
begin
  if Message.Msg=Cm_Enter then
       Color:=ClCtrlEnter
  else if Message.Msg=Cm_Exit then
    Color:=clWhite;
  Inherited WndProc(Message);
end;

procedure TFhlDbDatePicker.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #48..#57:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        Key := #0;
      end;
  end;
end;

procedure TFhlDbDatePicker.DataChange(Sender: TObject);
var
  s:string;
begin
  if (FDataLink.Field <> nil) and (FDataLink.CanModify) then
  begin
      s := FDataLink.Field.Text;
      if s='' then s:=FormatDateTime('yyyy"-"mm"-"dd',Now);
      Date :=StrToDate(s);
  end else
  begin
//    if csDesigning in ComponentState then
//      EditText := Name else
//      EditText := '';
      Date := StrToDate(FormatDateTime('yyyy"-"mm"-"dd',Now));
  end;
end;

procedure TFhlDbDatePicker.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;


procedure TFhlDbLookupComboBox.Click(sender: Tobject);
var FilterStr,FieldName:string;
var i,J:integer;
var FilterLookUpCtrl:  TControl ;

var ListDataSet:TDataSet;
var FldsLst:TStrings;
begin


    if  (F_FilterFlds<>'') and (F_FilterFlds<>'sEmpty') then
    begin
       FldsLst:=TStringlist.Create ;
       FldsLst.CommaText:=F_FilterFlds;
       for j:=0 to FldsLst.Count -1 do
       begin
             // F_FilterFlds:=  FldsLst[J];
              FieldName:='';
              for i:=0 to self.Parent.ControlCount -1 do
              begin
                  if  self.Parent.Controls[i] is TDBLookupComboBox then
                     if   uppercase(trim(TDBLookupComboBox (Parent.Controls[i]).DataField)) =uppercase(trim(FldsLst[J])) then
                     begin
                           FilterLookUpCtrl:=   TDBLookupComboBox (Parent.Controls[i]) ;
                           ListDataSet:=    TDBLookupComboBox (Parent.Controls[i]).ListSource.DataSet  ;
                           FieldName:= TDBLookupComboBox (Parent.Controls[i]).DataField  ;
                     end;
                   if  Parent.Controls[i] is TDBedit then
                    if  TDBedit (Parent.Controls[i]).Field.FieldKind  =fkLookup then
                      if   uppercase(trim(TDBedit (Parent.Controls[i]).Field .KeyFields )) =uppercase(trim(FldsLst[J])) then
                      begin
                        FieldName:=  TDBedit(Parent.Controls[i]).Field.FieldName;
                        ListDataSet:=  TDBedit(Parent.Controls[i]).Field.LookupDataSet  ;
                        FilterLookUpCtrl:=TWinControl(Parent.Controls[i]) ;
                      end;
              end;
              if FieldName='' then
              Exit;
              if FilterLookUpCtrl<>nil then
              self.DataSource.DataSet.FieldByName(FieldName ).Value :=NULL;

              if Field.Value<>null   then
                 FilterStr:=self.Field.FieldName +' like '+quotedstr(Field.Value+'%' )
              else
                 FilterStr:=self.Field.FieldName +' like '+quotedstr(''+'%' )    ;


              ListDataSet.Filter :=FilterStr;
              ListDataSet.Filtered :=true;
                                  {
              if FilterLookUpCtrl<>nil then
              if ListDataSet.IsEmpty then
                  FilterLookUpCtrl.Enabled  :=false
              else
                  FilterLookUpCtrl.Enabled  :=true ;
                  }
       end;

    end;


end;

constructor TFhlDbLookupComboBox.create(owner: TComponent);
begin
  inherited create(owner);
  self.OnClick :=self.Click;


  Self.OnEnter :=self.PonEnter;
  Flbltext:=TLabel.Create(self);
  Flbltext.Top :=self.Top -  Flbltext.Height+20 ;
 
  Flbltext.Visible :=false   ;
  Flbltext.Parent :=TWinControl(owner);

  self.OnKeyUp :=Ponkeyup;
end;

destructor TFhlDbLookupComboBox.Destroy;
begin
  self.Flbltext.Free ;
  inherited;
end;

procedure TFhlDbLookupComboBox.filter;
begin
    if (Flbltext.Caption <>'')  and (ListSource.dataset.findField ('FPhoneticize')<>nil)
    then
    begin
      self.ListSource.dataset.Filtered :=false;
      self.ListSource.dataset.Filter:= 'FPhoneticize like '+ QuotedStr('%'+self.Flbltext.Caption+'%' );
      self.ListSource.dataset.Filtered :=true;
    end
    else
      self.ListSource.dataset.Filtered :=false;

end;

procedure TFhlDbLookupComboBox.Ponenter(sender: TObject);
begin
 Flbltext.Left :=self.Left ;
     self.DropDown;
end;

procedure TFhlDbLookupComboBox.Ponkeyup(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  self.Flbltext.Visible :=true;
     Flbltext.Top := self.Top -  Flbltext.Height  ;
  if Key=8 then
    Flbltext.Caption:=leftstr(Flbltext.Caption,length(Flbltext.Caption)-1)
  else
      if ( Key>=48 ) and (Key<=57 )
           or ( Key>=65 ) and (Key<=90 )
                      or ( Key>=96 ) and (Key<=105 )
      then
      begin
        if (key>=96 )and (Key<=105 )then
        key:=Key-48 ;
        self.Flbltext.Caption :=Flbltext.Caption +Char(Key ) ;


      end;
     filter;
end;

procedure TFhlDbLookupComboBox.WndProc(var Message:TMessage);
begin
  if Message.Msg=Cm_Enter then
  begin
        Color:=ClCtrlEnter;
  end
  else if Message.Msg=Cm_Exit then
  begin
    Color:=clWhite
  end;
  Inherited WndProc(Message);
end;

//-----------------------------------------

procedure TFhlKnl.Tb_ClearTlBtn(fToolBar:TToolBar);
 var i:integer;
begin

  with fToolBar do
    for i:=ButtonCount-1 downto 0 do
    if Buttons[i]<>nil then
        Buttons[i].Free;
end;

function  TFhlKnl.Vr_CommaStrToVarArray(CommaStr:wideString;OnlyValues:Boolean=False):Variant;
 var t:TStringList;i:integer;
begin
 Result:=Null;
 if CommaStr='' then
    exit;
 T:=TStringList.Create;
 try
 //  T.CommaText:=CommaStr;
  SetDelimitedText(CommaStr,T)  ; //2-8
   Result:=VarArrayCreate([0,T.Count-1],varVariant);
   if OnlyValues then
      for i:=0 to T.Count-1 do
        Result[i]:=T.Values[T.Names[i]]
   else
      for i:=0 to T.Count-1 do
        Result[i]:=T.Strings[i];
 finally
   T.Free;
 end;
end;

procedure TFhlKnl.Tb_CreateActionBtns_Ex(fToolBar:TToolBar;fActionList:TActionList;fMainActID:string ;FempCode,FWindowsFID:string  );
 var i,Actid:integer;
 var ToolBarwidth:integer;
 var Act:TContainedAction;
 var sql:string;
begin

      if FempCode<>'' then
      begin

          sql:='select A.* from T525 A where  f01 not in (select FSpecificObjID  from '+self.UserConnection.DefaultDatabase +'.dbo.TUserToSpecificObj where FEnable=0 ';
          sql:=sql+' and FAuthorizeObjsID in (select FAuthorizeObjsID from '+logininfo.SysDBPubName +'.dbo.TAuthorizeItem where  FWindowsFID='+quotedstr(FWindowsFID)+' and   FempCode =  '+quotedstr(FempCode) +' ))' ;
        
          sql:=sql+' and  F02='+fMainActID+' and A.F18=1  order by  A.f14 desc, A.f200'  ;
      end
      else
         sql:='select A.* from T525 A where     F02='+fMainActID+' and A.F18=1  order by  A.f14 desc, A.f200' ;

      ToolBarwidth:=0;
      Tb_ClearTlBtn(fToolBar);
      Kl_GetQuery2(sql);
      if not FFre_Query.IsEmpty  then
            for i:=1 to FFre_Query.RecordCount  do
            begin
                Actid:=FFre_Query.FieldByName('F16').asinteger;

                 with TToolButton.Create(fToolBar) do
                 begin
                   Parent:=fToolBar;
                   if fActionList.ActionCount > Actid  then
                   begin
                     Action:= Taction( fActionList.Actions[Actid])  ;
                     Taction( fActionList.Actions[Actid]).Visible :=true;
                   end;

                   if  trim(FFre_Query.FieldByName('f04').AsString)<>'' then
                   caption :=FFre_Query.FieldByName('f04').AsString ;
                   Hint:=   FFre_Query.FieldByName('f05').AsString ;
                   if FFre_Query.FieldByName('f06').AsInteger =0 then
                      Style:=tbsSeparator
                   else  if  FFre_Query.FieldByName('f06').AsInteger =1 then
                      Style:=tbsButton
                   else  if  FFre_Query.FieldByName('f06').AsInteger =2 then
                      Style:=tbscheck;

                   width :=  FFre_Query.FieldByName('F07').AsInteger ;
                   tag  :=FFre_Query.FieldByName('F17').AsInteger ;//open Formid    //F19    modelid
                   //Enabled:= FFre_Query.FieldByName('F09').AsBoolean ;
                   showHint:=FFre_Query.FieldByName('F10').AsBoolean ;
                   AutoSize:=True;
                   Down:=FFre_Query.FieldByName('F12').AsBoolean ;      // F13  RightID
                   ToolBarwidth :=ToolBarwidth +width;

                end;

                FFre_Query.Next ;
            end;

   fToolBar.Width := ToolBarwidth+10;
   fToolBar.Enabled :=true;
   fToolBar.Refresh;
end;





 

procedure TFhlKnl.Tb_CreateActionBtns(fToolBar:TToolBar;fActionList:TActionList;fActions:Variant;ClearToolButton:boolean=true);
  var i:integer;
  var ToolBarwidth:integer;
begin
  ToolBarwidth:=0;

  if ClearToolButton then
  Tb_ClearTlBtn(fToolBar);
  
  if VarIsStr(fActions) then
     fActions:=Vr_CommaStrToVarArray(fActions);
  if VarIsNull(fActions) then exit;
  for i:=varArrayHighBound(fActions,1) downto 0 do
   with TToolButton.Create(fToolBar) do
   begin
     Parent:=fToolBar;
     if fActions[i]='' then
     begin
        Style:=tbsSeparator;
        Width:=8;
        ToolBarwidth:=ToolBarwidth+10;
     end else
     begin
        AutoSize:=True;
        Action:=fActionList.Actions[strToint(fActions[i])];
        ToolBarwidth:=ToolBarwidth+58;
     end;
   end;
   fToolBar.Width :=ToolBarwidth;
   fToolBar.Refresh;
end;

procedure TFhlKnl.Vl_ClearChild(fParent:TControl);
  var i:integer;
begin
  for i:=fParent.ComponentCount-1 downto 0 do
      fParent.Components[i].Free;
end;

function TFhlKnl.Tv_NewDataNode(ATreeView:TTreeView;AFatherNode:TTreeNode;AData,AText:ShortString;AImgIdx,ASlctIdx:Integer):TTreeNode;
var
  pData:TStrPointer;
begin
     New(pData);
     pData^:=AData;
     Result:=ATreeView.Items.AddChildObject(AFatherNode,AText,pData);
     with Result do
     begin
          ImageIndex:=AImgIdx;
          Selectedindex:=ASlctIdx;
     end;

end;

function  TFhlKnl.Tv_CreateNode(TreeView:TTreeView;FatherNode:TTreeNode;Text:ShortString;ImgIdx,SelIdx:Integer):TTreeNode;
begin
     Result:=TreeView.Items.AddChild(FatherNode,Text);
     with Result do begin
          ImageIndex:=ImgIdx;
          Selectedindex:=SelIdx;
     end;
end;

function TFhlKnl.Pc_CreateTabSheet(fPageControl:TPageControl;Pcaption:string=''):TTabSheet;
begin
  Result:=TTabSheet.Create(fPageControl);
  Result.PageControl:=fPageControl;
  Result.Caption :=Pcaption;

end;

function  TFhlKnl.Tv_FindNode(TreeView:TTreeView;FindData:ShortString):TTreeNode;
var
  i:integer;
begin
  Result:=nil;
  with TreeView.Items do
   for i:=0 to Count-1 do
       if (Item[i].Data<>nil) and (TStrPointer(Item[i].Data)^=FindData) then
          Result:=Item[i];
end;

procedure TFhlKnl.Vl_FocueACtrl(fParentControl:TWinControl);
 var i:integer;
begin
  for i:=0 to fParentControl.ControlCount-1 do
     if     (fParentControl.Controls[i] is TWinControl) and (TWinControl(fParentControl.Controls[i]).CanFocus)     then
      begin
             TWinControl(fParentControl.Controls[i]).SetFocus;
             Exit;
      end;

end;

procedure TFhlKnl.Vl_DoBoxEnter(AWinControl:TWinControl);
begin
  if AWinControl=nil then
    exit
  else if (AWinControl is TDbEdit) and Assigned(TDbEdit(AWinControl).OnDblClick) then
    TDbEdit(AwinControl).OnDblClick(AWinControl)
  else if (AWinControl is TDbLookupComboBox) and TDbLookupComboBox(AWinControl).Field.IsNull then begin
//PostMessage(AWinControl.Handle, CB_SHOWDROPDOWN, 1, 0);
    keybd_event(18, MapVirtualKey(18, 0 ), 0 , 0 );
    keybd_event(vk_up, MapVirtualKey(vk_up, 0 ), 0 , 0 );
    keybd_event(18, MapVirtualKey(18, 0 ), KEYEVENTF_KEYUP , 0 );
    keybd_event(vk_up, MapVirtualKey(vk_up, 0 ), KEYEVENTF_KEYUP , 0 );
    exit;
  end;
  GetParentForm(AwinControl).Perform(WM_NEXTDLGCTL, 0, 0)
end;

function TFhlKnl.Tv_GetTreePath(Node:TTreeNode):wideString;
var
  mynode:TTreeNode;
begin
  Result:='';
  myNode:=Node;
  while myNode<>nil do
  begin
    Result:=myNode.Text+'\'+Result;
    myNode:=myNode.Parent;
  end;
  Result:='\\'+Result+'  ';
end;

function  TFhlKnl.Vr_MergeVarArray(varArray1,varArray2:Variant):Variant;
 var a,b,i:integer;
begin
 Result:=Null;
 if VarIsStr(varArray1) then varArray1:=Vr_CommaStrToVarArray(varArray1);
 if VarIsStr(varArray2) then varArray2:=Vr_CommaStrToVarArray(varArray2);
 if varIsArray(varArray1) and varIsArray(varArray2) then
 begin
    a:=varArrayHighBound(varArray1,1)+1;
    b:=varArrayHighBound(varArray2,1);
    Result:=varArrayCreate([0,a+b],varVariant);
    for i:=0 to a-1 do
       Result[i]:=varArray1[i];
    for i:=a to a+b do
       Result[i]:=varArray2[i-a];
 end
 else if varIsArray(varArray1) and (Not varIsArray(varArray2)) then
     Result:=varArray1
 else if (Not varIsArray(varArray1)) and varIsArray(varArray2) then
     Result:=varArray2
end;

procedure TFhlKnl.St_Separate(s:String;Separator:Char;Terms:TStringList);
  var
  hs : string;
  p : integer;
begin
  Terms.Clear; // First remove all remaining terms
  if Length(s)=0 then   // Nothin' to separate
    Exit;
  p:=Pos(Separator,s);
  while P<>0 do
  begin
    hs:=Copy(s,1,p-1);   // Copy term
    Terms.Add(hs);       // Add to list
    Delete(s,1,p);       // Remove term and separator
    p:=Pos(Separator,s); // Search next separator
  end;
  if Length(s)>0 then
    Terms.Add(s);        // Add remaining term
end;

FUNCTION TFhlKnl.St_GetBigMoney(Aje:Currency):string;
var
  s_1,s_2:widestring;
  s_5:char;
  s_4:string;
  i:integer;
  mm:string;
  s_6,s_7:widestring;
begin
  s_5:='0';
  s_4:=format('%10d',[trunc(aje*100)]);
  s_1:='零壹贰叁肆伍陆柒捌玖';
  s_2:='仟佰拾万仟佰拾元角分';
  i:=1;
  mm:='';
  WHILE i<=10 do
  begin
    s_5:=s_4[i];
    IF s_5<>' ' then
    begin
        s_6:=s_1[ord(s_5)-ORD('0')+1];
        s_7:=s_2[i];
        IF (s_5='0') AND (i<>4) AND (i<>8)  then
          s_7:='';
        IF (copy(s_4,i,2)='00') OR ( (s_5='0') AND (i in [4,8,10])) then
          s_6:='';
        mm:=mm+s_6+s_7;
        IF (s_4[i]='0') AND ((s_4[i+1]<>'0') AND (i in [4,8])) then
          mm:=mm+s_1[1];
    END;
    inc(i);
  END ;
  IF s_5='0' then
    mm:=mm+'整';
  result:=mm;
end;
function TFhlKnl.St_encrypt_Chy(str:string):string;
var
  text,str1:string;
  i,j:integer;
begin
  if str='' then
  begin
   result:='';
   exit;
  end;
  text:='chenhuiyun';
  str1:='';
  for i:=1 to length(str) do
   begin
    j:=i mod length(text)+1;
    str1:=str1+chr(ord(str[i]) xor ord(text[j]) mod 10);
   end;
   result:=str1;
end;
function TFhlKnl.St_encrypt(str:string):string;
var
  text,str1:string;
  i,j:integer;
begin
  if str='' then
  begin
   result:='';
   exit;
  end;
  text:='fangheling'; 
  str1:='';
  for i:=1 to length(str) do
   begin
    j:=i mod length(text)+1;
    str1:=str1+chr(ord(str[i]) xor ord(text[j]) mod 10);
   end;
   result:=str1;
end;

function TFhlKnl.St_GetPrimaryKey(ARandom:integer):string;
begin
  randomize;
  Result:=FormatDateTime('yyyymmddhhnnss',now)+floattostr(random(ARandom));
end;

function  TFhlKnl.St_Repeat(ASon:string;ANum:integer):widestring;
var
  i:integer;
begin
  if ANum>0 then
  begin
   Result:=ASon;
   for i:=1 to ANum do
     Result:=Result+ASon;
  end;   
end;

function  TFhlKnl.St_GetCalcFld(AExpression:string;var ABeginPos:integer):string;
var
  s:string[1];
begin
  Result:='';
  while ABeginPos<=length(AExpression) do
  begin
    s:=AExpression[ABeginPos];
    if (s='+') or (s='-') or (s='*') or (s='/') then
      break;
    Result:=Result+s;
    ABeginPos:=ABeginPos+1;
  end;
end;

function  TFhlKnl.Vr_VarArrayToCommaStr(varArray:Variant):wideString;
 var i:integer;
begin
 if VarIsArray(varArray) then
 begin
    for i:=0 to VarArrayHighBound(varArray,1) do
        Result:=Result+','+varArray[i];
    Result:=copy(Result,2,length(Result));
 end else
   Result:=VarToStr(varArray);
end;

function  TFhlKnl.Vr_VarHaveSameVal(varArray:Variant):Boolean;
 var i,ii:integer;
begin
 Result:=False;
 for i:=0 to VarArrayHighBound(varArray,1) do
     for ii:=i+1 to VarArrayHighBound(varArray,1) do
         if varArray[i]=varArray[ii] then
         begin
           Result:=True;
           Exit;
         end;
end;

function  TFhlKnl.Vr_ReplaceByVarArray(Str:wideString;Patern:String;VarArray:Variant):wideString;
var
  i:integer;
begin
  Result:=Str;
  for i:=varArrayLowBound(VarArray,1) to VarArrayHighBound(VarArray,1) do
    Result:=StringReplace(Result,Patern,VarArray[i],[rfIgnoreCase]);
end;

function  TFhlKnl.Vl_GetAlignment(fCodeId:Integer):TAlignment;
begin
  case fCodeId of
     1:Result:=taCenter;
     2:Result:=taRightJustify;
     else
       Result:=taLeftJustify;
  end;     
end;

function  TFhlKnl.St_GetTStringValues(fStr:wideString;fSeparator:Char;fNames:String):Variant;
 var s,s2:TStringList;i:integer;
begin
 s:=TStringList.Create;
 s2:=TStringList.Create;
 St_Separate(fStr,fSeparator,s);
 St_Separate(fNames,fSeparator,s2);
 Result:=varArrayCreate([0,s2.Count-1],varVariant);
 for i:=0 to s2.Count-1 do
     Result[i]:=s.Values[s2.Strings[i]];
 s2.Free;
 s.Free;
end;

function  TFhlKnl.Os_GetComputerName:String;
begin
  SetLength(Result, 255);
  Gethostname(PChar(Result), 255);
  SetLength(Result, StrLen(PChar(Result)));
end;

function TFhlKnl.Os_GetComputerIp:String;
var
//  WSAData: TWSAData;
  HostEnt: PHostEnt;
begin
//  WSAStartup(2, WSAData);
//  SetLength(ClientName, 255);
//  Gethostname(PChar(ClientName), 255);
//  SetLength(ClientName, StrLen(PChar(ClientName)));
  HostEnt := GetHostByName(PChar(Self.Os_GetComputerName));
  with HostEnt^ do Result := Format('%d.%d.%d.%d',[Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]), Byte(h_addr^[3])]);
  WSACleanup;
end;

//----------------------Module----------------------------
function TFhlKnl.Md_ShowDateFrm(var ADate:TDateTime;var isnull :boolean ):integer;
var dateFrm:  TDateFrm;
begin
  dateFrm:=TDateFrm.Create(Application) ;
try
  with dateFrm do
  begin
    MonthCalendar1.Date:=ADate;
    TimeTPicker.Time := ADate; 

    Result:=ShowModal;
    isnull:=ChkNull.Checked ;
    ADate:=trunc(MonthCalendar1.Date) +  Frac(TimeTPicker.Time );
  end;
finally
freeandnil(  dateFrm);
end;
end;



function  TFhlKnl.Md_ShowDirSelectorFrm(var ADir:wideString):Integer;
begin
  with TDirSelectorFrm.Create(Application) do
  begin
    try
      DirectoryListBox1.Directory:=ADir;
      Result:=ShowModal;
      ADir:=DirectoryListBox1.Directory;
    finally
      Free;
    end;
  end;
end;

function TFhlKnl.Vl_FindChildFrm(const FrmName:String;ShowIt:Boolean=True):TForm;
  var i:integer;
begin
 Result:=nil;
 with Application.MainForm do
 begin
   if MDIChildCount>0 then
   begin
     for i:=0 to MDIChildCount-1 do
     begin
       if MDIChildren[i].Name=FrmName then
       begin
         Result:=MDIChildren[i];
         if ShowIt then Result.Show;
         Break;
       end;
     end;
   end;
 end;
end;

procedure TFhlKnl.Vl_SetCtrlStyle(bkColor:TColor;fFather:TwinControl;fCanEdit:Boolean);
  var i:integer;
begin
 for i:=0 to fFather.ControlCount-1 do
 begin
        if fFather.Controls[i] is TWinControl then
        begin
           with TDbEdit(fFather.Controls[i]) do
          begin
            Color:=bkColor;
            Enabled:=fCanEdit;
          end;  
        end;

        if  (fFather.Controls[i] is TDbCheckBox) then
        begin
          (TDbCheckBox(fFather.Controls[i]) as TDbCheckBox ).Enabled:=true;
          if assigned((TDbCheckBox(fFather.Controls[i]) as TDbCheckBox ).Field) then
            (TDbCheckBox(fFather.Controls[i]) as TDbCheckBox ).Field.ReadOnly :=not fCanEdit;
        end;
 end;
end;

procedure  TFhlKnl.Mn_FindMenuItem(AMenuItem:TMenuItem;AName:String;var AFindedItem:TMenuItem);
 var i:integer;
begin
  for i:=0 to AMenuItem.Count-1 do
  begin
    if AMenuItem.Items[i].Name=AName then
    begin
      AFindedItem:=AMenuItem.Items[i];
      Exit;
    end else
      Mn_FindMenuItem(AMenuItem.Items[i],AName,AFindedItem);
  end;
end;

function  TFhlKnl.Mn_FindMainMenuItem(AMainMenu:TMainMenu;AName:String):TMenuItem;
  var i:integer;
begin
  Result:=Nil;
  for i:=0 to AMainMenu.Items.Count-1 do
  begin
    if AMainMenu.Items[i].Name=AName then
       Result:=AMainMenu.Items[i]
    else
       Mn_FindMenuItem(AMainMenu.Items[i],AName,Result);
    if Result<>nil then
       Break;
  end;
end;

//------------DbGrid----------------

procedure TFhlKnl.Ds_Filter(ADataSet:TDataSet;Dbgrid:Tdbgrid=nil);
begin

    if not  assigned(ADataSet) then
      ADataSet:=Dbgrid.DataSource.DataSet ;

    if Not ADataSet.Active then Exit;
    with TFilterFrm.Create(Application) do
    begin
      InitFrm(ADataSet,False,Dbgrid);
      try
        if ShowModal=mrOk then
        begin
              with ADataSet do
              begin
                Filtered:=false;
                Filter:=GetFilterStr;
                Filtered:=true;
              end;
              if  ADataSet.Filter <>'' then
                  if ChkSqlCon.Checked  then
                  begin
                      dmfrm.GetQuery1('select top 0 * from sys_FilterOrqtyCon where SqlCon='+quotedstr(ADataSet.Filter));
                      dmfrm.FreeQuery1.Append ;
                      dmfrm.FreeQuery1.FieldByName('GridID').AsInteger :=Dbgrid.Tag ;
                      dmfrm.FreeQuery1.FieldByName('LoginID').AsString  :=logininfo.LoginId  ;
                      dmfrm.FreeQuery1.FieldByName('EmpID').AsString    :=logininfo.EmpId   ;
                      dmfrm.FreeQuery1.FieldByName('SqlCon').AsString  :=ADataSet.Filter  ;
                      dmfrm.FreeQuery1.FieldByName('AlisName').AsString:=FilterName.Text ;
                      dmfrm.FreeQuery1.FieldByName('DisPlayText').AsString  :=ListBox1.Items.CommaText   ;
                      dmfrm.FreeQuery1.FieldByName('UseCount').AsInteger :=dmfrm.FreeQuery1.FieldByName('UseCount').AsInteger+1;
                      dmfrm.FreeQuery1.FieldByName('DisPlayCount').AsInteger :=10 ;
                      dmfrm.FreeQuery1.FieldByName('Filter').AsBoolean  :=true;
                      dmfrm.FreeQuery1.Post ;
                  end;    //GridID,LoginID,EmpID,SqlCon,DisPlayText,UseCount,DisPlayCount,Filter,Visiable
        end;
      finally
        Free;
      end;
    end;
end;

procedure TFhlKnl.Dg_Sort(ADbGrid:TDbGrid;AContainInVisible:Boolean=true);
begin
  if Not ADbGrid.DataSource.DataSet.Active then Exit;
  with TSortFrm.Create(Application) do
  begin
    try
      InitFrm(ADbGrid,AContainInVisible);
      if ShowModal=mrOk then
        TCustomAdoDataSet(ADbGrid.DataSource.DataSet).Sort:=RightVals;
    finally
      Free;
    end;
  end;
end;

function TFhlKnl.Dg_GetDBGridEdit(fDBGrid: TDBGrid): TEdit;
 var I: Integer;
begin
  Result := nil;
  with fDBGrid do for I := 0 to Pred(ComponentCount) do
    if Components[I] is TCustomEdit then begin
      Result := TEdit(Components[I]);
      Break;
    end;
end;

function TFhlKnl.Dg_GetDBGridEditText(fDBGrid: TDBGrid): string;
var  vEdit: TEdit;
begin
  vEdit := Dg_GetDBGridEdit(fDBGrid);
  if Assigned(vEdit) then
    Result := vEdit.Text
  else Result := '';
end;

function  TFhlKnl.Dg_GetNextTabIndex(fDbGrid:TDbGrid;fPreIndex:Integer):Integer;
begin
  Result:=fPreIndex;
  with fDbGrid do
    while ((Not Columns[Result].Visible) or (Columns[Result].ReadOnly)) and (Result<FieldCount-1) do
      Result:=Result+1;
end;

procedure TFhlKnl.Dg_SetDbGridStyle(fDbGrid:TDbGrid;fReadOnly:Boolean;bkColor:TColor;fDbGridColsColor:Variant);
 var i:Integer;
begin
 fDbGrid.Color:=bkColor;
 fDbGrid.ReadOnly:=fReadOnly;
 if fReadOnly then begin
    fDbGrid.Options:=fDbGrid.Options-[dgEditing];
    for i:=0 to fDbGrid.Columns.Count-1 do
        fDbGrid.Columns[i].Color:=bkColor;
 end
 else begin
   
    fDbGrid.Options:=fDbGrid.Options+[dgEditing];
    for i:=0 to fDbGrid.Columns.Count-1 do
          fDbGrid.Columns[i].Color:=fDbGridColsColor[i];
 end;
end;

function TFhlKnl.Dg_SetSelectedIndex(ADbGrid:TDbGrid;AInsert:Boolean):Boolean;
begin
  Result:=False;
  with ADbGrid do
  begin
    if ReadOnly then
      exit
    else if (Columns[SelectedIndex].ButtonStyle=cbsEllipsis) and SelectedField.IsNull then
      OnEditButtonClick(ADbGrid)
    else if SelectedIndex<(fieldcount-1) then
      SelectedIndex:=Dg_GetNextTabIndex(ADbGrid,SelectedIndex+1)
    else if (DataSource.State=dsBrowse) and (DataSource.DataSet.RecNo<DataSource.DataSet.RecordCount) then begin
      DataSource.DataSet.Next;
      SelectedIndex:=Dg_GetNextTabIndex(ADbGrid,0);
    end
    else begin
      Result:=True;
      if AInsert then
        Datasource.DataSet.Append
      else
        DataSource.DataSet.First;
       SelectedIndex:=0;
    end;
  end;
end;

procedure TFhlKnl.Dg_DrawLineFont(Sender: TObject;const Rect: TRect; DataCol: Integer; Column: TColumn;State: TGridDrawState;AFont:TFont);
begin
  if Not (gdSelected in State) then
    with TDbGrid(Sender) do
    begin
      Canvas.Font.Assign(AFont);
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;
 
procedure TFhlKnl.Dg_DrawZebraBackgroud(Sender: TObject;const Rect: TRect; DataCol: Integer; Column: TColumn;State: TGridDrawState;AColor0,AColor1:TColor);
begin
  if Not (gdSelected in State) then
    with TDbGrid(Sender) do
    begin
      if DataSource.DataSet.RecNo mod 2=1 then
      begin
       Canvas.Brush.Color:=AColor0;
      // Canvas.Font.Color:=clBlack;
      end else
      begin
        Canvas.Brush.Color:=AColor1;
     // Canvas.Font.Color:=clBlack;
      end;
      DefaultDrawDataCell(Rect,Column.Field,State);
    end;
end;

procedure TFhlKnl.Ds_Locate(ADataSet:TDataSet);
begin
  if Not ADataSet.Active then Exit;
  with TFilterFrm.Create(Application) do
  begin
    InitFrm(ADataSet,True);
    Show;
  end;
end;

procedure TFhlKnl.Dg_ShowCol(ADbGrid:TDbGrid);
begin
  with TColShowerFrm.Create(Application) do
  begin
    try
      InitFrm(ADbGrid);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure  TFhlKnl.Dg_ColsProp(ADbGrid:TDbGrid);
begin
  with TColPropFrm.Create(Application) do
  begin
    try
      InitFrm(ADbGrid);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TFhlKnl.Dg_SetColVisible(ADbGrid:TDbGrid);
var
  i:integer;
begin
  Screen.Cursor:=crSqlWait;
  try
    with ADbGrid do
      for i:=0 to Columns.Count-1 do
        Kl_GetQuery2('update T505 set F07='+intTostr(ord(Columns[i].Visible))+' where F02='+intTostr(Tag)+' and F14='''+Columns[i].Title.Caption+'''',False);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFhlKnl.Dg_SetColWidth(ADbGrid:TDbGrid);
var
  i:integer;
begin
  Screen.Cursor:=crSqlWait;
  try
    with ADbGrid do
      for i:=0 to Columns.Count-1 do
        if Columns[i].Visible then
          Kl_GetQuery2('update T505 set F04='+intTostr(Columns[i].Width)+' where F02='+intTostr(Tag)+' and F14='''+Columns[i].Title.Caption+'''',False);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFhlKnl.Dg_SetColOrder(ADbGrid:TDbGrid);
var
  i:integer;
begin
  Screen.Cursor:=crSqlWait;
  try
    with ADbGrid do
      for i:=0 to Columns.Count-1 do
        Kl_GetQuery2('update T505 set F23='+intTostr(i)+' where F02='+intTostr(Tag)+' and F14='''+Columns[i].Title.Caption+'''',False);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFhlKnl.Dg_SetColStyle(ADbGrid:TDbGrid);
var
  i:integer;
  a:string[1];
  asql,OriCaption:string;
begin
  Screen.Cursor:=crSqlWait;
  try
    with ADbGrid do
      for i:=0 to Columns.Count-1 do
      begin
        case Columns[i].Alignment of
          taLeftJustify: a:='0';
          taRightJustify: a:='2';
          taCenter: a:='1';
        end;
  

        asql:='update T505 set'+
          ' F04='+intTostr(Columns[i].Width)+
          ',F07='+intTostr(ord(Columns[i].Visible))+
          ',F23='+intTostr(i)+
          ',F09='+QuotedStr(ColorToString(Columns[i].Color))+
          ',F21='+intTostr(Columns[i].Font.Size)+
          ',F22='+QuotedStr(ColorToString(Columns[i].Font.Color))+
          ',F13='+a+

          ',F14='+QuotedStr(Columns[i].Title.Caption )+

          ',F15='+QuotedStr(ColorToString(Columns[i].Title.Color))+
          ',F18='+intTostr(Columns[i].Title.Font.Size)+
          ',F19='+QuotedStr(ColorToString(Columns[i].Title.Font.Color))+
          ',F27='+QuotedStr(  TChyColumn(Columns[i]).DeciamlFormat )+
          //f28 order asc dec
          ',F29='+ inttostr(  ord(TChyColumn(Columns[i]).SumType   ))   +

          ' where F02='+intTostr(Tag)+
          //' and F14='+QuotedStr(Columns[i].Title.Caption)  ;
           ' and F03 in (select f01 From T102 where F02=  '+QuotedStr(Columns[i].FieldName  )+')'  ;

        Kl_GetQuery2(asql,False);

      end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

//-------------------DataSet---------------------------

procedure TFhlKnl.Ds_AssignNulls(DataSet:TDataSet;Fields:wideString;IsPost:Boolean=True);
 var Flds:variant;i:integer;
begin
  Flds:=Vr_CommaStrToVarArray(Fields);
     DataSet.Edit;
  for i:=0 to VarArrayHighBound(Flds,1) do
      if  DataSet.findField (Flds[i])<>nil then
      DataSet.FieldByName(Flds[i]).Value:=Null;
  if IsPost then
     DataSet.post;
end;

procedure TFhlKnl.Ds_AssignNulls(Grid:TDBGRID;DataSet:TDataSet;Fields:wideString;IsPost:Boolean=True);
 var Flds:variant;i:integer;
begin
  Flds:=Vr_CommaStrToVarArray(Fields);
     DataSet.Edit;
  for i:=0 to VarArrayHighBound(Flds,1) do
      DataSet.FieldByName(Flds[i]).Value:=Null;
  if IsPost then
     DataSet.post;
end;

procedure TFhlKnl.Ds_AssignValues(DataSet:TDataSet;Fields,Values:Variant;IsAppend:Boolean=True;IsPost:Boolean=True);
 var i:integer;
 var tmpValue,tmpFldName:string;
begin
  if VarIsStr(Fields) then
     Fields:=Vr_CommaStrToVarArray(Fields);
  if VarIsStr(Values) then
     Values:=Vr_CommaStrTovarArray(Values)
  else if VarIsNull(Values) then exit;
  if IsAppend then
     DataSet.Append
  else
     DataSet.Edit;
  for i:=0 to VarArrayHighBound(Fields,1) do
  begin
     tmpFldName := Fields[i] ;
     tmpValue:=Values[i] ;
//  tmpValue,tmpFldName
      DataSet.FieldByName(Fields[i]).Value:=Values[i];
  end;

  if IsPost then
     DataSet.Post;
end;

procedure  TFhlKnl.Ds_ClearAllData(DataSet:TDataSet);
begin
 with DataSet do begin
      while not IsEmpty do
            Delete;
 end;
end;

procedure TFhlKnl.Ds_CopyDataSet(SourceDataSet,DestDataSet:TAdoDataSet);
var
  i:integer;
begin
{
  with DestDataSet do
  begin
    Close;
    CommandText:=SourceDataSet.CommandText;
    Parameters.Assign(SourceDataSet.Parameters);
    Open;
  end;
}
  with SourceDataSet do
  begin
    First;
    while not eof do
    begin
      DestDataSet.Append;
      for i:=0 to Fields.Count-1 do
        if Fields[i].CanModify and (Fields[i].DataType<>ftAutoInc) then
          DestDataSet.FieldByName(Fields[i].FieldName).Value:=Fields[i].Value;
      DestDataSet.Post;
      Next;
    end;
  end;
end;

procedure  TFhlKnl.Ds_CopyValues(SourceDataSet,DestDataSet:TDataSet;SourceFields,DestFields:Variant;IsAppend:Boolean=True;IsPost:Boolean=True);
 var i:integer;
 var SourceFld,DestFld:string;

begin
 if VarIsStr(SourceFields) then
    SourceFields:=Vr_CommaStrToVarArray(SourceFields);
 if VarIsStr(DestFields) then
    DestFields:=Vr_CommaStrToVarArray(DestFields);
 if VarIsNull(SourceFields) or VarIsNull(DestFields) then
    Exit;
 if IsAppend then
    DestDataSet.Append
 else 
    DestDataSet.Edit;


 for i:=0 to VarArrayHighBound(SourceFields,1) do
 begin
   SourceFld:= SourceFields[i]  ;
   DestFld:=DestFields[i]         ;
   if DestDataSet.findField (DestFields[i])<> nil then
      DestDataSet.FieldByName(DestFld).Value:=SourceDataSet.FieldByName(SourceFld).Value;
 end;

 if IsPost then
    DestDataSet.Post;
end;

procedure  TFhlKnl.Ds_CopyValues(SourceGrid:TdbGrid;SourceDataSet,DestDataSet:TDataSet;SourceFields,DestFields:Variant;IsAppend:Boolean=True;IsPost:Boolean=True);
 var i,Row :integer;
   TempBookmark: TBookMark;
begin
if  dgmultiselect in  SourceGrid.Options then
begin
      if VarIsStr(SourceFields) then
        SourceFields:=Vr_CommaStrToVarArray(SourceFields);
      if VarIsStr(DestFields) then
        DestFields:=Vr_CommaStrToVarArray(DestFields);
      if VarIsNull(SourceFields) or VarIsNull(DestFields) then
        Exit;

       with SourceGrid.SelectedRows do
      if Count <> 0 then
      begin

        TempBookmark:= SourceGrid.Datasource.Dataset.GetBookmark;
        for Row:= 0 to Count - 1 do
        begin
          if IndexOf(Items[Row]) > -1 then
          begin
                if row=0 then
                    DestDataSet.edit
                else
                    DestDataSet.Append;

                SourceGrid.Datasource.Dataset.Bookmark:= Items[Row];
                for i:=0 to VarArrayHighBound(SourceFields,1) do
                begin
                    DestDataSet.FieldByName(DestFields[i]).Value:=SourceDataSet.FieldByName(SourceFields[i]).Value;
                end;
          end;
        end;
      end;

   
      if IsPost then
        DestDataSet.Post;

       SourceGrid.Datasource.Dataset.GotoBookmark(TempBookmark);
       SourceGrid.Datasource.Dataset.FreeBookmark(TempBookmark);
end
else
    Ds_CopyValues(SourceDataSet,DestDataSet,SourceFields,DestFields,false,IsPost)   ;
                         

end;

procedure TFhlKnl.Ds_FreeDataSet(DataSet:TDataSet);
 var i:integer;
begin
 with DataSet do begin
      Close;
      for i:=FieldCount-1 downto 0 do begin
           if Fields[i].FieldKind=fkLookup then
              Fields[i].LookupDataSet.Free;
           Fields[i].Free;
      end;
 end;
end;

function  TFhlKnl.Ds_GetFieldsName(DataSet:TDataSet):Variant;
 var i:integer;
begin
  Result:=varArrayCreate([0,DataSet.FieldCount-1],varVariant);
  for i:=0 to DataSet.FieldCount-1 do
      Result[i]:=DataSet.Fields[i].FieldName;
end;

function  TFhlKnl.Ds_GetFieldsValue(DataSet:TDataSet;FieldNames:Variant; bPercentSign:boolean=false):Variant;
 var i,ii:integer;
 var DefaultExpression,fldName,fldValue:string;
begin
    Result:=Null;
    if VarIsNull(FieldNames) or (FieldNames='') then
      Exit
    else if VarIsStr(FieldNames) then
      FieldNames:=Vr_CommaStrToVarArray(FieldNames);

    ii:=VarArrayHighBound(FieldNames,1);
    Result:=varArrayCreate([0,ii],varVariant);

    for i:=0 to ii do
    begin
        fldName:=trim(FieldNames[i]) ;
        if DataSet.FindField(trim(FieldNames[i]))<>nil then
        begin
           DefaultExpression:=DataSet.FieldByName(trim(FieldNames[i])).DefaultExpression  ;
           if ( DataSet.FieldByName(fldName) is Tstringfield )and bPercentSign then
           begin
              if  DataSet.FieldByName(trim(FieldNames[i])).AsVariant =null then
              Result[i]:='%'
              else
              begin
                   if  (uppercase(DefaultExpression  ) =uppercase('sLogDataBase') )
                    or ( uppercase(DefaultExpression ) =uppercase('sPubDataBase') )
                    then
                      Result[i]:=DataSet.FieldByName(trim(FieldNames[i])).AsVariant
                  else
                      Result[i]:=DataSet.FieldByName(trim(FieldNames[i])).AsVariant +'%'  ; //get .Value
              end;
           end
           else
              IF DataSet.FieldByName(trim(FieldNames[i])).AsVariant=NULL THEN
              begin
                  if ( DataSet.FieldByName(trim(FieldNames[i])) is Tstringfield ) then  Result[i]:='';
                  if ( DataSet.FieldByName(trim(FieldNames[i])) is TNumericField ) then  Result[i]:=0;
              end
              ELSE
              begin
                  Result[i]:=DataSet.FieldByName(trim(FieldNames[i])).AsVariant ;//get .Value
                  fldValue:=  Result[i] ;
              end;
        end
        else
        begin
           //showmessage(FieldNames[i]+'不存在');   //2011-5-4
           Result[i]:=FieldNames[i];
        end;
    end;
end;



function  TFhlKnl.Ds_GetFieldValues(DataSet:TDataSet;FieldName:String):Variant;
 var i:integer;
begin
  Result:=varArrayCreate([0,DataSet.RecordCount-1],varVariant);
  i:=0;
  DataSet.First;
  while not DataSet.Eof do begin
        Result[i]:=DataSet.FieldByName(FieldName).value;
        DataSet.Next;
        i:=i+1;
  end;
end;

procedure TFhlKnl.Ds_SetParams(ADataSet:TDataSet;AParams:Variant);
var
  i,ii:integer;
  strvalue:string;
begin
  if Not VarIsNull(AParams) then
  begin
      if VarIsStr(AParams) then  AParams:=Vr_CommaStrToVarArray(AParams);
      ii:=0;
      with TAdoDataSet(ADataSet) do
      begin
        if Active then
         Close;
       if (pos('in(',CommandText  )>0 )or (pos('in (',CommandText  )>0)or (pos('in  (',CommandText  )>0)then                   //2006-10-28
       begin
       //
       end
       else
       begin
          Parameters.Refresh;//会检查Sql正确性,如果Sql非法则参数可能不能正常定义
       end;
        for i:=0 to Parameters.Count-1 do
        with Parameters do
          if items[i].Direction=pdInput then
          begin
            strvalue:=AParams[ii];
            if Items[i].Size < length(strvalue) then    //Parameters.Refresh  crm 查询时参数长度不够 2010-2-9
            Items[i].Size := length(strvalue)+2;

            Items[i].Value:=AParams[ii];
            ii:=ii+1;
          end else if Items[i].Direction=pdInputOutput then
            Items[i].Direction:=pdOutput;
       end;
  end;
end;

procedure TFhlKnl.Ds_OpenDataSet(ADataSet:TDataSet;AParams:Variant);
var
  c:TCursor;
begin
  c:=Screen.Cursor;
  Screen.Cursor:=crSqlWait;
  try
  Ds_SetParams(ADataSet,AParams);
//   showmessage(  (ADataSet as TADODataSet).Connection.ConnectionString);

  ADataSet.Open;
  if ADataSet.Filter<>'' then ADataSet.Filtered:=True;
  finally
    Screen.Cursor:=c;
  end;
end;

procedure TFhlKnl.Ds_RefreshLkpFld(fDataSet:TDataSet);
  var i:integer;
begin
  for i:=0 to fDataSet.FieldCount-1 do
    with fDataSet.Fields[i] do
    begin
      if FieldKind=fkLookup then
      begin
         LookupDataSet.Close;
         LookupDataSet.Open;
         RefreshLookupList;
      end;
    end;
end;

procedure TFhlKnl.Ds_RefreshDataSet(fDataSet:TDataSet);
begin
  Screen.Cursor:=crSqlWait;
  try
    Ds_RefreshLkpFld(fDataSet);
    fDataSet.Close;
    fDataSet.Open;
  finally
   Screen.Cursor:=crDefault;
  end;
end;

procedure TFhlKnl.Ds_RequireCheck(ADataSet:TDataSet);
 var i,ii,jj:integer;s:wideString;
 var sql,FieldName,datasetID,tableName,UinonRstr:string;
 var Fld:Tfield;

begin

 ii:=0;
 jj:=0;

 with ADataSet do
 begin
       for i:=0 to FieldCount-1 do
       begin
             if (Fields[i].Required) and (Fields[i].DisplayText='') then
             begin
               if ii=0 then  s:=#13#10+'操作失败,下列项目不能为空:                 '+#13#10;
               ii:=ii+1;
               s:=s+#13#10+intTostr(ii)+'. '+Fields[i].DisplayLabel;
             end;
       end;
       //check duplicated

       for i:=0 to FieldCount-1 do
       begin
            datasetID:=inttostr(Fields[i].DataSet.Tag );
            sql:='select f10  from T202 where f02='+quotedstr(datasetid) +' and f03='+quotedstr(inttostr(Fields[i].Tag ));

            self.Kl_GetQuery2(sql);
            if not self.FreeQuery.IsEmpty then
            begin
                 if self.FreeQuery.FieldByName('F10').AsBoolean then
                 begin
                      if    self.Ds_DuplicatedCheck(Fields[i],Fields[i].Value   ) then
                      begin
                              if jj=0 then  s:=#13#10+'操作失败,下列项目不能重复:                 '+#13#10;
                              jj:=jj+1;
                              s:=s+#13#10+intTostr(jj )+'. '+Fields[i].DisplayLabel ;
                      end;
                 end;
            end;
       end;
      //uinion pk
      if Ds_DUunionpkCheck (ADataSet,UinonRstr) then
      s:=s+#13#10+'该('+UinonRstr+') 已经存在!';

  end;


 if (ii=0 ) and (jj=0 ) and (UinonRstr='') then exit;
 
 MessageDlg(s+#13#10#13#10+'请纠正后重试!',mtWarning,[mbOk],0);
  Screen.Cursor:=crDefault;
 Abort;

end;

function TFhlKnl.Ds_DUunionpkCheck(ADataSet: TDataSet;
var   Rstr: string): boolean;
var   sql,uinonPK,TableEName,CON,pk:string;
var stlist:Tstrings;
var i:integer;
begin
      result:=false;
           //Check union PK    duplicated
       sql:='select B.unionpk   ,B.TableEname,B.pk '
           +'  From T201 A '
           +'  join '+logininfo.PubDataBasePreFix+logininfo.SysDBPubName +'.dbo.Tallusertable B on A.F16=B.TableEname '
           +'  where A.f01 ='+inttostr(ADataSet.tag);

       self.Kl_GetQuery2(sql);
       if not self.FreeQuery.IsEmpty then
       begin
            if self.FreeQuery.FieldByName('unionpk').AsString <>'' then
            begin
                pk               :=self.FreeQuery.FieldByName('pk').AsString ;
                uinonPK          :=self.FreeQuery.FieldByName('unionpk').AsString ;
                TableEname       :=
                                   Format(self.FreeQuery.FieldByName('TableEname').AsString ,[FAdoConnection.DefaultDataBase]);
                stlist           :=Tstringlist.Create ;
                stlist.CommaText :=  uinonPK;

                sql:= 'select *From '+TableEname+' where  ';

                for i:=0 to stlist.Count -1 do
                begin
                     if i=0 then
                     BEGIN
                         sql:=sql+ '   isnull( '+stlist[i]+','''')  ='+quotedstr(ADataSet.FieldByName(stlist[i]).AsString);
                         CON:=CON+  QUOTEDSTR(stlist[i])     ;
                     end
                     else
                     BEGIN
                         sql:=sql+ ' and isnull('+stlist[i]+','''')  ='+quotedstr(ADataSet.FieldByName(stlist[i]).AsString);
                         CON:=CON+  ','+QUOTEDSTR(stlist[i]);
                     END;
                end;
                stlist.Free;
                if   ADataSet.State in [dsedit] then
                sql:=sql+ ' and F_ID<>'+quotedstr(ADataSet.fieldbyname('F_ID').AsString );

                self.Kl_GetUserQuery(sql);

                if not self.FUser_Query.IsEmpty then
                begin
                    sql:='SELECT * FROM ' +logininfo.PubDataBasePreFix+logininfo.SysDBPubName +'.dbo.Tallfields  WHERE ownerpk='+pk+' and  FieldEName in ('+ CON  +')';
                    SELF.Kl_GetQuery2(sql)   ;
                    if not self.FreeQuery.IsEmpty then
                    for i:=0 to self.FreeQuery.RecordCount-1 do
                    begin
                       if i=0 then
                            Rstr:=  Rstr+self.FreeQuery.fieldbyname('FieldCname').AsString
                       else
                            Rstr:=  Rstr+','+self.FreeQuery.fieldbyname('FieldCname').AsString;
                       self.FreeQuery.Next ;     
                    end;

                   Rstr:= Rstr;
                   result:=true;

                end
                else
                   result:=false;

            end;
       end;
end;

procedure  TFhlKnl.Ds_AssignDefaultVals(ADataSet:TDataSet;ACommaVals:wideString;UseEdit:boolean=true);
var
  s:TStringList;
  i:integer;

begin
      s:=TStringList.Create;
    try
      if ADataSet.Active then
      begin

  //          s.CommaText:=ACommaVals;
           SetDelimitedText(ACommaVals,s);  //7-2
          for i:=0 to s.Count-1 do
            if trim(s.Names[i])<>'' then
            //  在设置字段默认值时中间不能有空格
            if  ADataSet.FindField(trim(s.Names[i]))<>nil then
              ADataSet.FieldByName(trim(s.Names[i])).DefaultExpression:=s.Values[s.Names[i]]
            else if    ADataSet.FindField(leftstr(  trim(s.Names[i]),length(s.Names[i])-3) )<>nil then
              ADataSet.FieldByName(leftstr(  trim(s.Names[i]),length(s.Names[i])-3)   ).DefaultExpression:=s.Values[s.Names[i]]
      end;
    finally
      s.Free;
    end;
end;

function TFhlKnl.Ds_Calc(ADataSet:TDataSet;AExpression:string):Double;
var
  b:integer;
  fldname,s:string;
  f:double;
begin
  b:=1;
//  Result:=strTofloat(self.St_GetCalcFld(AExpression,b));
  Result:=ADataSet.FieldByName(self.St_GetCalcFld(AExpression,b)).AsFloat;
  while b<length(AExpression) do
  begin
    s:=AExpression[b];
    b:=b+1;
    fldname:=self.St_GetCalcFld(AExpression,b);
    //f:=strTofloat(fldname);
    f:=ADataSet.FieldByName(fldname).AsFloat;
    if s='+' then
      Result:=Result+f
    else if s='-' then
      Result:=Result-f
    else if s='*' then
      Result:=Result*f
    else
      Result:=Result/f;
  end;
end;

procedure TFhlKnl.Ds_SetDataSetStyle(fDataSet:TDataSet;fReadOnly:Boolean);
  var i:integer;
begin
 for i:=0 to fDataSet.FieldCount-1 do
     fDataSet.Fields[i].ReadOnly:=fReadOnly;
end;

function  TFhlKnl.Ds_SumFlds(DataSet:TDataSet;SumFlds:Variant):Variant;
 var bk:TBookMark;i,j:integer;
begin
 Result:=Null;
 if VarIsStr(SumFlds) then
    SumFlds:=Vr_CommaStrToVarArray(SumFlds);
 if varisNull(SumFlds) then exit;
 j:=varArrayHighBound(SumFlds,1);
 Result:=VarArrayCreate([0,j],varDouble);
//   if DataSet.FindField(SumFlds[i])<>nil then
//   begin
     bk:=DataSet.GetBookmark;
     DataSet.DisableControls;
     DataSet.First;
  while not DataSet.Eof do
  begin
     for i:=0 to j do
        Result[i]:=Result[i]+DataSet.FieldByName(SumFlds[i]).asFloat;
     DataSet.Next;
  end;
  DataSet.GotoBookmark(bk);
  DataSet.EnableControls;
// end;
end;


//-------------------Report----------------------

procedure TFhlKnl.Rp_SetRepGrid(fDBGrid:TDBGrid;fDetailBand,fColumnHeaderBand:TQrBand;fHasVerticalLine:Boolean=True);
 var i,lPos,l,t:integer;
 var lbl:TQRLabel;
 var txt:TQRDBText;
 var shp:TQRShape;

begin
  try
 
    t:=(fDetailBand.Height-12) div 2; //12 为字体的高度

    {   if fDBGrid.DataSource.DataSet.Active then
    begin
 
    lPos :=0;//fDetailBand.Left ;
       for i:=0 to fDBGrid.Columns.Count-1 do
       begin
           if Not fDbGrid.Columns[i].Visible then
              Continue;

           with TQRDBRichTextEx.Create(fDetailBand) do begin
                Parent:=fDetailBand ;
                Left:=lPos ;     // +6
                Top:=t ;
                Width:=fDBGrid.Columns[i].Width ;
                alignment:=fDbGrid.Columns[i].Alignment;
                lPos:= trunc(lPos+Width  );
                DataSet:=fDBGrid.DataSource.DataSet;
                DataField:=fDBGrid.Columns[i].Field.FieldName;
                l:=Left;
                Font.Assign(fDBGrid.Columns[i].Font );
           end;


            fDetailBand.Frame.DrawLeft  :=true;
            fDetailBand.Frame.DrawRight   :=true ;
            fColumnHeaderBand.Frame.DrawLeft  :=true;

            fColumnHeaderBand.Frame.DrawRight :=fDetailBand.Frame.DrawRight  ;

            fDetailBand.Frame.DrawTop :=true;   {}
           {if (fHasVerticalLine) and (i<fDBGrid.Columns.Count -1) then
           begin
              fDetailBand.Frame.DrawLeft  :=true;
              fDetailBand.Frame.DrawRight   :=true;
              fColumnHeaderBand.Frame.DrawLeft  :=true;
              fColumnHeaderBand.Frame.DrawRight  :=true;
              fDetailBand.Frame.DrawTop :=fHasVerticalLine;
              with TQRShape.Create(fDetailBand.ParentReport) do
              begin
                   Parent:=fDetailBand;
                   Shape:=qrsVertLine;
                   left:=lPos-3;
                   top:=0-fColumnHeaderBand.Height;
                   width:=1;
                   Height:=fDetailBand.Height+fColumnHeaderBand.Height-2;
              end;
           end;
       end;    
    end;      }

   CreateQRCaptions(fDbGrid.Columns,fColumnHeaderBand ,fDetailBand ,fHasVerticalLine ,fColumnHeaderBand.Frame.Width )  ;
    {
           for i:=0 to LstCaption.Count -1 do
           begin

           end;
               lbl:=TQRLabel.Create(fColumnHeaderBand) ;
           with lbl  do begin
                Parent:=  fColumnHeaderBand;
                Left:=l;
                Top:=6;
                AutoSize:=False;
                Width:=fDbGrid.Columns[i].Width;
                Alignment:=fDbGrid.Columns[i].Alignment;
                Caption:= StringReplace(fDBGrid.Columns[i].Title.Caption,' ','',[rfReplaceAll]);
                Font.Color:=fDbGrid.Columns[i].Title.Font.Color;
           end;
     }
   finally

   end;
end;

procedure TFhlKnl.Rp_SetRepLabel(fDictDataSet:TDataSet;fParent:TQrBand);
begin
  fDictDataSet.First;
  while not fDictDataSet.Eof do begin
   with TQRLabel.Create(fParent) do begin
        Parent:=fParent;
        Left:=fDictDataSet.FieldByName('PosLeft').asInteger;
        Top:=fDictDataSet.FieldByName('PosTop').asInteger;
        Caption:=fDictDataSet.FieldByName('Caption').asString;
        Font.Color:=StringToColor(fDictDataSet.FieldByName('FontColor').asString);
  //      Font.Size:=11;
    //    Font.Style:=Font.Style+[fsBold];
   end;
   fDictDataSet.Next;
  end;
end;

procedure TFhlKnl.Rp_SetRepCtrl(fDictDataSet,fDataSet:TDataSet;fParent:TQrBand;ABeginTop:integer=10 ; DLGrid:TDbGrid=nil);
 var l,t,w, i :Integer;Fnt:TFont;
 var lbl:TQRLabel ;
 var Txt: TQRDBtext ;
 const ConstGap:Integer=1;
begin
//txt:=TQRDBtext.Create (nil);
//txt.WordWrap

  t:=0;
  Fnt:=TFont.Create;
  Fnt.Assign(fParent.Font);

  fDictDataSet.First;
  While not fDictDataSet.Eof do
  begin
     l:=fDictDataSet.FieldByName('F12').asInteger;
     t:=fDictDataSet.FieldByName('F13').asInteger+ABeginTop;
     Fnt.Size:=fDictDataSet.FieldByName('F07').asInteger;
     Fnt.Name:=fDictDataSet.FieldByName('F08').asString;
     w:=fDictDataSet.FieldByName('F14').asInteger;
     if fDictDataSet.FieldByName('F10').asBoolean then
       Fnt.Style:=Fnt.Style+[fsUnderLine]
     else
       Fnt.Style:=Fnt.Style-[fsUnderLine];
     if fDictDataSet.FieldByName('F09').asBoolean then
       Fnt.Style:=Fnt.Style+[fsBold]
     else
       Fnt.Style:=Fnt.Style-[fsBold];

      if  (fDictDataSet.FieldByName('F23').AsBoolean) then
     begin
        with TQRLabel.Create(fParent) do
          begin
            Parent:=fParent;
            Left:=l;
            Top:=t;
              for i:=0 to DlGrid.Columns.count-1 do
              begin
                  if fDictDataSet.FieldByName('f04').asString= DlGrid.Columns[i].FieldName then
                  begin
                     Caption:= TChyColumn( DlGrid.Columns[i] ).GroupValue;
                     break;
                  end;
              end;
            Font.Assign(Fnt);
          end;
     end;

     if  (fDictDataSet.FieldByName('F17').asInteger =0) and (not fDictDataSet.FieldByName('F23').AsBoolean) then
     begin
        with TQRLabel.Create(fParent) do
          begin
            Parent:=fParent;
            Left:=l;
            Top:=t;
            Caption:=fDictDataSet.FieldByName('F04').asString;

            Font.Assign(Fnt);
          end;
     end;
     if  (fDictDataSet.FieldByName('F17').asInteger =1) and ( not fDictDataSet.FieldByName('F23').AsBoolean  ) then
         with TQRDBtext.Create(fParent) do
          begin
              //fParent.Height :=50;
              Parent:=fParent; Left:=l;         top:=t;           width:=w;
              autosize:=false; WordWrap:=true;  Font.Assign(Fnt); Autostretch:=true;
              Alignment:=Vl_GetAlignment(fDictDataSet.FieldByName('F03').asInteger);

              if fDataSet.FindField( fDictDataSet.FieldByName('f04').asString )<>nil then
              begin
                  DataSet:=fDataSet;
                  DataField:=fDictDataSet.FieldByName('f04').asString;
              end;
     end;
     if  fDictDataSet.FieldByName('F17').asInteger =2 then
     with TQRShape.Create(fParent) do
           begin
            Parent:=fParent;
            Left:=l;
            top:=t;
            Width:=w;
            Height:=fDictDataSet.FieldByName('F15').asInteger;
            if fDictDataSet.FieldByName('F19').asInteger=1 then
               Shape:=qrsHorLine
            else
               shape:=qrsVertLine;
      end;

     fDictDataSet.Next;
  end;

  l:=0;
  t:=4;
                        
  fParent.Height:=t+40;
  fDictDataSet.Close;
  Fnt.Free;
end;

procedure TFhlKnl.Rp_DbGrid(APrinterId:string;ADbGrid:TDbGrid;Title:string='');
begin
  if Not ADbGrid.DataSource.DataSet.Active then Exit;
  Screen.Cursor:=crSqlWait;
  with TRepGridFrm.Create(Application) do
  begin
    QuickRep1.DataSet:=ADbGrid.DataSource.DataSet;
    QuickRep1.DataSet.DisableControls;
    try
      Kl_GetQuery2('select * from T609 where F01='+APrinterId);
      with FFre_Query do
      begin
        if RecordCount=1 then
        begin
          QRTitle.Caption:='    '+FieldByName('F02').asString+'    ';
          QuickRep1.ReportTitle:=FieldByName('F02').asString;
          QuickRep1.Page.LeftMargin:=FieldByName('F11').asFloat;
          QuickRep1.Page.RightMargin:=FieldByName('F12').asFloat;
          QuickRep1.Page.TopMargin:=FieldByName('F13').asFloat;
          QuickRep1.Page.BottomMargin:=FieldByName('F14').asFloat;
          QuickRep1.Page.length:=FieldByName('F08').asFloat;
          QuickRep1.Page.width:=FieldByName('F09').asFloat;
          QuickRep1.Page.Columns:=FieldByName('F10').asInteger;
          DetailBand1.Height:=FieldByName('F17').asInteger;
          if FieldByName('F15').asBoolean then
             QuickRep1.Page.Orientation:=poLandscape;
        end
        else
        begin
           QuickRep1.ReportTitle:= Title;
           QRTitle.Caption :=Title;
        end;
        close;
      end;
      Rp_SetRepGrid(ADbGrid,DetailBand1,ColumnHeaderBand1);
      QuickRep1.Prepare;
      pgcount.Caption:=' 共 '+intTostr(QuickRep1.QRPrinter.PageCount)+' 页';
    finally
      QuickRep1.DataSet.EnableControls;
      Screen.Cursor:=crDefault;
    end;
    QuickRep1.PreviewModal;
    free;
  end
end;

procedure TFhlKnl.Rp_Card(ABoxId:String;ADataSet:TDataSet);
begin
  with TRepCardFrm.Create(Application) do
  begin
    Cf_SetDataSet(Ffre_Query,'471',nil);
    Ds_OpenDataSet(Ffre_Query,varArrayof([ABoxId]));
    Rp_SetRepCtrl(Ffre_Query,ADataSet,detailBand1);
    PreviewModal;
    Free;
  end;
end;

procedure TFhlKnl.Rp_RepSet(APrinterId:string);
begin
{  with TRepSetFrm.Create(Application) do
  begin
    AdoDataSet1.Connection:=FAdoConnection;
    InitFrm(APrinterId);
    if ShowModal=mrOk then
      Ds_AssignValues(AdoDataSet1,varArrayof([Title,pgSize,pgLength,pgWidth,columns,colSpace,RowHeight,LfMargin,RtMargin,TpMargin,BtMargin,Orientation]),varArrayof([titleEdit1.Text,paperComboBox1.ItemIndex,lengthEdit1.Text,widthEdit1.Text,colEdit1.Text,colSpaceEdit1.Text,rowHeightEdit1.Text,lEdit1.Text,rEdit1.Text,tEdit1.Text,bEdit1.Text,RadioButton1.Checked]),false);
    Free;
  end;}
end;

procedure TFhlKnl.CreateUpdateBatFile;
var
  MyTextFile:TextFile;
  MyDir:widestring;
  MyBat:TFileName;
  MyFileName:widestring;
begin
//不用啦,直接renamefile,deletefile就ok
    MyDir:=ExtractFileDir(Application.ExeName);
    MyFileName:=ExtractFileName(Application.ExeName);
    MyBat:=MyDir+'\update.bat';
    AssignFile(MyTextFile,MyBat);
    Rewrite(MyTextFile);
    Writeln(MyTextFile,'');
    Writeln(MyTextFile,'cd '+MyDir);
//    Writeln(MyTextFile,format('if not exist %s.new goto xEnd',[MyFileName]));
    Writeln(MyTextFile,'cls');
//    Writeln(MyTextFile,format('if exist %s.old del %s.old',[MyFileName,MyFileName]));
    Writeln(MyTextFile,'cls');
//    Writeln(MyTextFile,format('if exist %s rename %s %s.old',[MyFileName,MyFileName,MyFileName]));
    Writeln(MyTextFile,'cls');
//    Writeln(MyTextFile,'@echo ok! power by fhl');
    Writeln(MyTextFile,'pause');
    Writeln(MyTextFile,format('rename %s.new %s',[MyFileName,MyFileName]));
    Writeln(MyTextFile,format('del %s',[MyBat]));
//    Writeln(MyTextFile,'Exit');
//    Writeln(MyTextFile,MyFileName);
    Writeln(MyTextFile,':xEnd');
    Writeln(MyTextFile,'@Echo x');
    CloseFile(MyTextFile);
end;


//-----------------------------------------------------------




procedure TFhlKnl.q_SetDbCtrl_mtn(ABoxId: String; 
  AParent: TWinControl; ActnLst: TActionList;FCollector:Tstrings);
var PreviousTop:integer;
var isUserMode:Boolean;
begin
  isUserMode:=AParent.Tag <>0;

  if  Fcfg_dbctrl.Active   then   Fcfg_dbctrl.Close ;

    Ds_OpenDataSet(Fcfg_dbctrl,varArrayof([ABoxId]));

  Fcfg_dbctrl.Filtered :=false;
  if isUserMode then
    Fcfg_dbctrl.Filter :='Boxid='+quotedstr(ABoxId)+' and f300=1'
  else
    Fcfg_dbctrl.Filter :='Boxid='+quotedstr(ABoxId) ;
  Fcfg_dbctrl.Filtered :=True;
  with Fcfg_dbctrl do
  begin
      if Not IsEmpty then
      begin
        while not Eof do
        begin
          q_CreateDbCtrl_Mtn(AParent,ActnLst,ABoxId,FCollector,PreviousTop);
          PreviousTop:=  FieldByName('PosTop').asInteger ;
          Next;
        end;

      end;
         AParent.Height:=FieldByName('posTop').asInteger+30;

  end;
end;

procedure TFhlKnl.q_SetLabel_mtn(BoxId: String; fParent: TWinControl;Fcollector:Tstrings);
  var l:TLabel_Mtn;
  var po:integer;
  var PreviousTop:integer;
  var isUserMode:Boolean;
begin
  isUserMode:=fParent.Tag <>0;

  if   Fcfg_label.Active   then    Fcfg_label.Close;

     Ds_OpenDataSet(Fcfg_label,varArrayof([BoxId]));

  Fcfg_label.Filtered :=false;
  if isUserMode then
    Fcfg_label.Filter :='F02='+quotedstr(BoxId)+' and f300=1'
  else
    Fcfg_label.Filter :='F02='+quotedstr(BoxId) ;
  Fcfg_label.Filtered :=True;

  with Fcfg_label do
  begin
    while not Eof do
    begin
     l:=TLabel_Mtn.Create(fParent);
     l.isUserMode :=  isUserMode;
     l.SetCollector(Fcollector)    ;
     l.parent:=fParent;
     l.Left:=FieldByName('F04').asInteger;
     if abs(PreviousTop-FieldByName('F05').asInteger)<12 then
      l.Top:=PreviousTop
     else
      l.Top:=FieldByName('F05').asInteger;

     po:=pos('|',FieldByName('F03').asString) ;
//     l.Caption:=rightstr(FieldByName('F03').asString, length(FieldByName('F03').asString)-po -1);
     l.Caption:= FieldByName('F03').asString ;
     l.Color:=StringToColor(FieldByName('F06').asString);
     l.Transparent:=FieldByName('F07').asBoolean;
     l.Font.Color:=StringToColor(FieldByName('F10').asString);
     l.Font.Name:='宋体';
     l.Font.Size:=FieldByName('F09').asInteger;
     if FieldByName('F11').asBoolean then
        l.Font.Style:=l.Font.Style+[fsBold];
     if FieldByName('F12').AsBoolean then
        l.Font.Style:=l.Font.Style+[fsUnderline];

     l.Hint:=FieldByName('F01').AsString ;    //         // 对应记录的pk f01
     l.BoxId:=BoxId;                       //记录boxid，删除控键时用到  2006-5-8
     l.OnMouseDown:=MouseDown;
     l.OnDblClick :=DblClick_Ex;
     l.OnMouseUp  :=   MouseUp;
     l.isUserMode :=FieldByName('F300').AsBoolean ;
     l.ECaption   :=FieldByName('F50').AsString   ;
     PreviousTop  :=FieldByName('F05').asInteger;
     Next;
    end;
  end;
end;

procedure TFhlKnl.ControlDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
if   Sender is tedit then
begin
     (Sender as tedit).Hint  := Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex]   +rightstr(   (Sender as tedit).Hint    ,length((Sender as tedit).Hint)-4);
     (Sender as tedit).text  :=Tlistbox (Source).Items.Values [ leftstr((Sender as tedit).Hint ,4) ];//[Tlistbox (Source).ItemIndex] ;
end;
if sender is   TDbRadioGroup then
begin
     (Sender as TDbRadioGroup).Hint  := Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex]  +rightstr((Sender as TDbRadioGroup).Hint ,length((Sender as tedit).Hint)-4);
//     (Sender as TDbRadioGroup).ComObject   :=Tlistbox (Source).Items.Values [(Sender as tedit).Hint  ];//[Tlistbox (Source).ItemIndex] ;
end;
end;
procedure TFhlKnl.DblClick_Ex(Sender: TObject);
var  FrmUpdateProperty: TFrmUpdateProperty;

var actlst:Tstringlist;
begin
 FrmUpdateProperty:=TFrmUpdateProperty.Create (self);
 FrmUpdateProperty.Acontrol := Tcontrol(Sender);

 if Sender is tlabel then
 begin
      FrmUpdateProperty.GrpLabel.Align :=alClient;
      FrmUpdateProperty.GrpCTRL.Visible :=False ;
      FrmUpdateProperty.edtCaption.Text :=  (Sender as tlabel).Caption ;
      FrmUpdateProperty.edtECaption.Text :=  (Sender as tlabel_mtn).ECaption  ;
      FrmUpdateProperty.lbl1.Color :=(Sender as Tlabel).Color ;
      FrmUpdateProperty.lbl1.Font:=(Sender as Tlabel).Font;
 end;

 if Sender is tedit then
 begin
    FrmUpdateProperty.GrpCTRL .Align :=alClient;
    FrmUpdateProperty.GrpLabel .Visible :=False ;

    actlst:=Tstringlist.Create ;
    actlst.CommaText :=Tedit(sender).Hint ;
    FrmUpdateProperty.cmbclick.ItemIndex :=  strtoint(actlst[1]);
    FrmUpdateProperty.Editclick.Text  :=actlst[1];
    FrmUpdateProperty.cmbdbclick.ItemIndex :=  strtoint(actlst[2]);
    FrmUpdateProperty.Editdbclick.Text :=actlst[2];
    FrmUpdateProperty.cmbexit.ItemIndex :=  strtoint(actlst[3]);
    FrmUpdateProperty.Editexit.Text :=actlst[3];


 end;
 FrmUpdateProperty.rg1.ItemIndex :=  Tcontrol(Sender).Tag ;

 FrmUpdateProperty.Show ;

end;
procedure TFhlKnl.MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var sql:string;
  var hintlist:Tstringlist;
begin

try
    hintlist:= Tstringlist.Create;

    if ( Sender is Tlabel_Mtn) and (  Button=mbleft ) then
    begin

         ( Sender as tlabel).Font.Style := ( Sender as tlabel).Font.Style   +[fsBold];
         ( Sender as tlabel).Cursor  :=crsizeall;
           if    (Shift =[ ssshift ,ssleft	]	)  then
                Tlabel_Mtn(Sender).FCollector.AddObject(Tlabel_Mtn(Sender).Caption,Tlabel_Mtn(Sender));
    end;

    if ( Sender is Tedit_Mtn) and (  Button=mbleft ) then
    begin
       // ( Sender as Tedit_Mtn).Ctl3D :=true;
        ( Sender as Tedit_Mtn).Cursor  :=crsizeall;
        ( Sender as Tedit_Mtn).Font.Style  :=( Sender as Tedit_Mtn).Font.Style+[fsBold];
                   if    (Shift =[ ssshift ,ssleft	]	)  then
                Tedit_Mtn(Sender).FCollector.AddObject( Tedit_Mtn(Sender).Text  ,Tedit_Mtn(Sender));
    end;

    if      (Shift =[ ssCtrl ,ssLeft	]	)  then
    begin
        Twincontrol(Sender).TabOrder  :=Tcontrol(Sender).Parent.Tag ;
         Tcontrol(Sender).Parent.Tag  :=   Tcontrol(Sender).Parent.Tag +1;
    end;

    if     Button=mbRight then
    begin
         if MessageBox(0, '删除该控键吗?', '', MB_YESNO + MB_ICONQUESTION) = IDYES
           then
         begin
             if       Sender is tlabel then
             begin
                 if ( (Sender as Tlabel_Mtn).isUserMode ) and not logininfo.Sys  then
                    sql:='update t503  set f300=0 where f02='+quotedstr((Sender as Tlabel_Mtn).boxid)+' and f01='+quotedstr((Sender as Tlabel_Mtn).Hint)
                 else
                    sql:='delete t503 where f02='+quotedstr((Sender as Tlabel_Mtn).boxid)+' and f01='+quotedstr((Sender as Tlabel_Mtn).Hint) ;
                 (Sender as tlabel).Color :=StringToColor('0');
             end;
             if       Sender is tedit then
             begin
                hintlist.CommaText:= (sender as tedit).Hint;
                
                if ( (Sender as tedit_mtn).isUserMode ) and not logininfo.Sys  then
                   sql:='update t502 set F300=0 where f02='+quotedstr((Sender as tedit_mtn).boxid)+' and f03='+quotedstr( hintlist[0] )
                 else
                   sql:='delete t502 where f02='+quotedstr((Sender as tedit_mtn).boxid)+' and f03='+quotedstr( hintlist[0] );
                 (Sender as tedit_mtn).Color :=StringToColor('0'); ;
             end;
             if       Sender is TDbRadioGroup_Mtn then
             begin
                 sql:='delete t502 where f02='+(Sender as TDbRadioGroup_Mtn).boxid+' and f03='+(Sender as TDbRadioGroup_Mtn).Hint ;
             end;

             Kl_GetQuery2( sql,false);
                //(Sender

         end;
    end;
   finally
       hintlist.Free;
   end;
end;

procedure TFhlKnl.ControlDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin

if  Source is tlistbox then
Accept:=true;
end;

procedure TFhlKnl.q_CreateDbCtrl_Mtn(

  fParent: TWinControl; ActnLst: TActionList;ABoxId:string;FCollector:Tstrings;PreviousTop:integer );
var
  fldname,FLDID,fhint,ClickId,DblClickId,ExitId :String;
  l,t,w,h,ft:integer;   //   ,ClickId,DblClickId,ExitId
  r:boolean;
  pwchar:char;
  edit_Mtn:Tedit_Mtn;
  isUserMode:Boolean;
  fntclr:TColor;
  DbRdGp :TDbRadioGroup_mtn;
begin


   with Fcfg_dbctrl do
   begin
     fldname:=FieldByName('FldName').asString;
     pwchar:=Chr(FieldByName('PwChar').asInteger);
     l:=FieldByName('PosLeft').asInteger;
     if abs(PreviousTop-FieldByName('PosTop').asInteger)<12 then
       t:=  PreviousTop
     else
       t:=FieldByName('PosTop').asInteger;

     w:=FieldByName('Width').asInteger;
     h:=FieldByName('Height').asInteger;
     r:=FieldByName('ReadOnly').asBoolean;
     ft:=FieldByName('CtrlTypeId').asInteger;
     fhint:=FieldByName('Hint').AsString;
     FLDID:= FieldByName('fLdID').AsString ;
     fntclr:=StringToColor( FieldByName('FontColor').AsString) ;

     ClickId:=FieldByName('ClickId').AsString ;
     DblClickId:=FieldByName('DblClickId').AsString ;
     ExitId:=FieldByName('ExitId').AsString ;
     isUserMode :=FieldByName('F300').AsBoolean ;



   end;
   edit_Mtn:=Tedit_Mtn.Create(fParent);
   case ft of
   1,5,6,7,8,9,12,13,14:    begin
                          edit_Mtn.FCollector := FCollector;
                          edit_Mtn.isUserMode :=  fParent.Tag <>0;
                          edit_Mtn.Left:=l;
                          edit_Mtn.Top:=t;
                          edit_Mtn.Width:=w;
                          edit_Mtn.Font.Color :=     fntclr ;
                          edit_Mtn.ReadOnly:=r;
                          edit_Mtn.Parent:=fParent;
                          edit_Mtn.PasswordChar:=pwchar;
                          edit_Mtn.Ctl3D:=false;
                          edit_Mtn.Hint:=FLDID+','+ClickId+','+DblClickId+','+ExitId;
                          edit_Mtn.text:= FldName;
                          edit_Mtn.ShowHint :=true;
                          edit_Mtn.Tag :=ft;    //typeID
                          edit_Mtn.OnDragDrop := ControlDragDrop;
                          edit_Mtn.OnDragOver := ControlDragOver;
                          edit_Mtn.BoxId :=ABoxId;
                          edit_Mtn.OnMouseDown:=MouseDown;
                          if  not edit_Mtn.isUserMode then
                          edit_Mtn.OnDblClick :=       DblClick_Ex;
                          edit_Mtn.OnMouseUp :=       MouseUp;
                          edit_Mtn.Height :=h;
                          edit_Mtn.isUserMode :=isUserMode;
                      end;

   10: begin
            DbRdGp:=TDbRadioGroup_mtn.Create(fParent) ;
                 DbRdGp.isUserMode :=  fParent.Tag <>0;
                 DbRdGp.Parent   :=fParent;
                 DbRdGp.Columns:=2;
                 DbRdGp.Height:=31;
                 DbRdGp.Left:=l;
                 DbRdGp.Top:=t;
                 DbRdGp.Width:=w;
                 DbRdGp.Height:=h;

                 DbRdGp.Hint:=FLDID;
                 DbRdGp.Tag :=ft;    //typeID
                 DbRdGp.ShowHint :=true;
                 DbRdGp.Items.CommaText:=trim(Fcfg_dbctrl.FieldByName('PickList').asString);    //1
                 //DbRdGp.DataSource:=fDataSource;DbRdGp.DataField:=FldName;                             //2   注意先后顺序
                 DbRdGp.OnDragDrop := ControlDragDrop;
                 DbRdGp.OnDragOver := ControlDragOver;
                 DbRdGp.BoxId:=ABoxId  ;
                 TcontrolEx(DbRdGp).OnMouseDown:=MouseDown;
                 DbRdGp.isUserMode :=isUserMode;
        end;
   end;


end;






procedure TFhlKnl.SetUserDataBase(UserDataBase: string);
begin
self.FAdoUserConnection.DefaultDatabase :=UserDataBase;
end;

procedure TFhlKnl.Kl_GetUserQuery(ASql: wideString; AReturn: Boolean);
begin
  with FUser_Query do
  begin
    Close;
    Sql.Clear;
    Sql.Append(ASql);
    if AReturn then
      Open
    else
      ExecSql;
  end;

end;

function TFhlKnl.GetMaxBoxID: string;

var maxboxid:string;
var sql:string;
begin

    Kl_GetQuery2('select newid() as maxboxid from '+fhlknl1.UserConnection.DefaultDatabase +'.dbo.T503  ');
    maxboxid:= self.FFre_Query.FieldByName('maxboxid').asstring  ;

  sql:='insert into '+fhlknl1.UserConnection.DefaultDatabase +'.dbo.T503 (F02,f03,f04,f05,f06,f07,f08,f09,f10,f11,f12)values( '
+quotedstr(maxboxid)+','+quotedstr('ini boxid')+',10,20,'+quotedstr('clBtnFace')
+',0,'+quotedstr('MS Sans Serif')+',10,'+quotedstr('clWindowText')+',0,0)'   ;

   fhlknl1.Kl_GetQuery2 (sql,false);

    result:=    (maxboxid);
end;

procedure TFhlKnl.CheckUnique(Sender: TObject);
var F:Tfield;
var datasetid:string;
begin
  if   Sender is tdbedit then
  begin
        F:=(  Sender as tdbedit ).Field ;
        if F<>nil then
        begin
              datasetid:=inttostr(f.DataSet.Tag );
              self.Kl_GetQuery2('select * from T202 where f02='+quotedstr(datasetid) +' and f03='+quotedstr(inttostr(f.Tag )));
              if not self.FreeQuery.IsEmpty then
                 if self.FreeQuery.FieldByName('F10').AsBoolean then
                   (  Sender as tdbedit ).OnExit  := dmfrm.actCheckUnique.OnExecute ;
        end;
  end;
end;

procedure TFhlKnl.CheckCtrlFieldsUnique(Sender: Twincontrol);
var i:integer;
begin
     for i:=0 to sender.ComponentCount -1 do
     begin
         if (sender.Components [i] is Tdbedit) then
         self.CheckUnique(sender.Components [i]);
     end;
end;



function TFhlKnl.Cf_GetDict_CrmModel(FrmId: string;  var Dict: TCRMDict): Boolean;
var i:integer;
begin
    self.Kl_GetQuery2('select *from T700 where f01='+FrmID);
    Dict.FormCaption    :=  self.FreeQuery.FieldByName('FormCaption').AsString   ;
    Dict.CrmTreeIDs    := self.FreeQuery.FieldByName('TreeIDs').AsString   ;
    Dict.MtDatasetID    :=  self.FreeQuery.FieldByName('MtDatasetID').AsString   ;
    Dict.MtBoxID        :=  self.FreeQuery.FieldByName('MtBoxID').AsString   ;
    Dict.MainGridUserMenuIDs:=  self.FreeQuery.FieldByName('MainMenuIDs').AsInteger    ;  //UserMenu

    if (self.FreeQuery.FieldByName('MainTreeGridID').AsString <>'-1')and ( self.FreeQuery.FieldByName('MainTreeGridID').AsString <>'') then
    Dict.MainTreeGridID :=  self.FreeQuery.FieldByName('MainTreeGridID').AsString   ;
    Dict.MainEditorID   :=  self.FreeQuery.FieldByName('MainEditorID').asinteger   ;
    Dict.MtParameters   :=  self.FreeQuery.FieldByName('MtParameters').AsString   ;
    Dict.MainActions    :=self.FreeQuery.FieldByName('MainActions').AsString   ;
    Dict.SubinterFaceID := self.FreeQuery.FieldByName('SubinterFaceID').AsString   ;
    dict.IsTreeGridEditorDock :=self.FreeQuery.FieldByName('IsTreeGridEditorDock').AsBoolean    ;
    self.Kl_GetQuery2('select *from T703 where f13=1 and    f11='+quotedstr(Dict.CrmTreeIDs)+' order by f14');
    if  not self.FreeQuery.IsEmpty then
    begin
          Dict.CrmTreeCount :=self.FreeQuery.RecordCount ;
          setlength( Dict.CrmTree, Dict.CrmTreeCount);
          for i:=0 to self.FreeQuery.RecordCount -1 do
          begin
               Dict.CrmTree[i].treeID:=self.FreeQuery.fieldbyname('f01').AsInteger ;
               Dict.CrmTree[i].Name   :=self.FreeQuery.fieldbyname('f02').AsString  ;
               Dict.CrmTree[i].RootTxt :=self.FreeQuery.fieldbyname('f05').AsString ;
               Dict.CrmTree[i].RootImageIDx :=self.FreeQuery.fieldbyname('f06').AsInteger ;
               Dict.CrmTree[i].datasetID :=self.FreeQuery.fieldbyname('f07').AsString ;
               Dict.CrmTree[i].NodeTextFld :=self.FreeQuery.fieldbyname('f08').AsString ;
               Dict.CrmTree[i].NodeDataFld :=self.FreeQuery.fieldbyname('f09').AsString ;
               Dict.CrmTree[i].width :=self.FreeQuery.fieldbyname('F10').AsInteger  ;
               Dict.CrmTree[i].SubInterFaceID :=self.FreeQuery.fieldbyname('F12').AsString ;
              self.FreeQuery.Next ;
          end;
          for i:=0 to    Dict.CrmTreeCount-1  do
          begin
                self.Kl_GetQuery2('select *from T701 where SubInterFaceID='+quotedstr(Dict.CrmTree[i].SubInterFaceID));
                Dict.CrmTree[i].SubInterFace.SubInterFaceCount :=   self.FreeQuery.RecordCount ;
                Dict.CrmTree[i].SubInterFace.SubInterFaceName :=  self.FreeQuery.fieldbyname('SubInterFaceName').AsString ;
                Dict.CrmTree[i].SubInterFace.ModeltypeID :=self.FreeQuery.fieldbyname('ModeltypeID').AsInteger ;
                case Dict.CrmTree[i].SubInterFace.ModeltypeID  of
                0:  Dict.CrmTree[i].SubInterFace.TreeGridID := self.FreeQuery.fieldbyname('TreeGridID').AsString  ;
                1:  Dict.CrmTree[i].SubInterFace.EditorID   := self.FreeQuery.fieldbyname('EditorID').AsString  ;
                end;
          end;
          self.Kl_GetQuery2('select *from T701 where SubInterFaceID='+quotedstr(Dict.SubInterFaceID)  +'  and IsUse=1 order by Findex');
          if not self.FreeQuery.IsEmpty then
          begin
               dict.SubInterFaceCount :=self.FreeQuery.RecordCount ;
               setlength( dict.SubInterFace,dict.SubInterFaceCount );
               for i:=0 to dict.SubInterFaceCount -1 do
               begin
                    dict.SubInterFace[i].ID := FreeQuery.fieldbyname('f01').AsString ;
                    dict.SubInterFace[i].SubInterFaceName :=  self.FreeQuery.fieldbyname('SubInterFaceName').AsString ;
                    dict.SubInterFace[i].ModeltypeID :=self.FreeQuery.fieldbyname('ModeltypeID').AsInteger ;
                    case dict.SubInterFace[i].ModeltypeID  of
                    0:  dict.SubInterFace[i].TreeGridID := self.FreeQuery.fieldbyname('TreeGridID').AsString  ;
                    1:  dict.SubInterFace[i].EditorID   := self.FreeQuery.fieldbyname('EditorID').AsString  ;
                    end;
                    self.FreeQuery.Next ;
                 end;
         end;
    result:=true;
    end
    else
    result:=false;
end;





function TFhlKnl.Ds_DuplicatedCheck(FLD: Tfield;value :variant):boolean;
var sql,tableName,fieldname:string;

begin
   result:=false;
   if value=null then value:='null'         ;
   if trim(value)=''   then value:='null'         ;

    if   FLD.DataSet.State in [dsinsert,dsedit] then
     begin

           fieldname:=FLD.FieldName  ;

           self.Kl_GetQuery2('select F16 from T201 where F01='+inttostr(Fld.DataSet.Tag ))  ;
           if not self.FreeQuery.IsEmpty then
           begin
                Tablename:=
                           Format(self.FFre_Query.FieldByName('F16').AsString ,[FAdoConnection.DefaultDataBase]);
                if   tablename='' then
                begin
                     showmessage(  'T201  表不存在');
                     exit ;
                end
                else
                begin
                   if FLD.DataSet.fieldbyname('F_ID').AsString='' then
                           sql:='select 1 From '+tablename+' where '+fieldname+'=' +quotedstr(value)
                     else
                           sql:='select 1 From '+tablename+' where '+fieldname+'=' +quotedstr(value) +'  and F_ID<>'+quotedstr(FLD.DataSet.fieldbyname('F_ID').AsString);
                     self.Kl_GetUserQuery(sql)   ;

                     if not self.FUser_Query.IsEmpty  then
                     begin
                       // showmessage( (sender as Tdbedit).Text+'   已经存在，请更改!');
                         result:=true;
                     end;
                end;
           end;

     end
     else
     exit;
end;


function TFhlKnl.Ds_CheckReference(ADataSet: TDataSet;var RRef:string):boolean;
var sql,TableName,TableCName,FieldCname,FieldEName:string;

var ReferenceByTable,ReferenceByField:string;
var i:integer;
begin
//
   result:=false;
   sql:=' select f16  From T201 where f01='+inttostr(ADataSet.Tag );

   self.Kl_GetQuery2(sql);
   if   not self.FreeQuery.IsEmpty then
   begin
        TableName:=self.FreeQuery.FieldByName('f16').AsString;
        sql:='select *From  '+logininfo.PubDataBasePreFix+logininfo.SysDBPubName +'.dbo.VFkReferenceBy where TableEname=' +quotedstr(TableName);
        self.Kl_GetQuery2(sql)  ;

        if not self.FreeQuery.IsEmpty then
        begin
              for i:=0 to  self.FreeQuery.RecordCount -1 do
              begin
                  ReferenceByTable :=self.FreeQuery.FieldByName('ReferenceByTable').AsString;      //删除参照失效
                  ReferenceByField :=self.FreeQuery.FieldByName('ReferenceByField').AsString;
                  TableCName       :=self.FreeQuery.FieldByName('TableCName').AsString;
                  FieldCname       :=self.FreeQuery.FieldByName('FieldCname').AsString;
                  FieldEName       :=self.FreeQuery.FieldByName('FieldEName').AsString;
                 // if ADataSet.findfield (ReferenceByField)<>nil then
                  begin

                    sql:='select * from '  +ReferenceByTable +' where '+ReferenceByField +'='  +quotedstr(ADataSet.fieldbyname(FieldEName).AsString);
                    self.Kl_GetUserQuery(sql)      ;
                    if not self.FUser_Query.IsEmpty then
                    begin
                        result:=true;
                        RRef:='('+TableCName+ ')   引用了这条记录！'+#13#10#13#10+ '必须先删除('+TableCName+'记录)!';
                        exit;
                    end;
                  end;
                  self.FreeQuery.Next ;
              end;
        end;
   end;
end;

procedure TFhlKnl.Dg_ConfigRight(ADbGrid: TDbGrid; Logininfo: Tlogininfo);
var sql:string;
var i,j:integer;
begin
//
if logininfo.isAdmin then
exit;

sql:='select a.fldname,b.code from V502 A '
    +' left join '+self.FAdoUserConnection.DefaultDatabase+'.dbo.sys_right B on A.F01=B.colid '
    +' where  (f25=1 and code<>'+quotedstr('')+')and A.f02= '+inttostr(ADbGrid.Tag )
    +' and b.code not in ( '
    +' select rightid from '
            + self.FAdoUserConnection.DefaultDatabase +'.dbo.sys_groupright  C '
    +' join '+self.FAdoUserConnection.DefaultDatabase +'.dbo.sys_groupuser   D  on C.groupID=D.groupID '
    +' where  userid='+quotedstr(logininfo.LoginId)
    +')'   ;

  self.Kl_GetQuery2(sql);
  if not self.FreeQuery.IsEmpty then
  begin
     for j:=0 to self.FreeQuery.Recordset.RecordCount -1 do
     begin
       for i:=0 to     ADbGrid.Columns.Count -1 do
       begin
            if self.FreeQuery.FieldByName('fldname').AsString = ADbGrid.Columns[i].FieldName then
            begin
            ADbGrid.Columns[i].Width :=10 ;
            ADbGrid.Columns[i].Visible :=false;
            //ADbGrid.Columns[i].Font.Color := ADbGrid.Columns[i].Color ;
            end;
       end;
       self.FreeQuery.Next ;
     end;
  end;
end;

procedure TFhlKnl.Act_ConfigRight(ActLst: Tactionlist;
  LoginInfo: TLoginInfo);
var  sql:string;
var i,j:integer;
begin

if logininfo.isAdmin then
exit;

sql:=
    'select f20  from '+logininfo.PubDataBasePreFix+logininfo.SysDBPubName  +'.dbo.T508 where isnull(f20,'+quotedstr('')+')<>'+quotedstr('')+' and  f01 in '
    +'(select left(code,len(code)-2) From '+self.UserConnection.DefaultDatabase +'.dbo.sys_right '
    +' where code not in '
    +'( select rightid from '
    +self.UserConnection.DefaultDatabase+'.dbo.sys_groupright  C '
    +'join '+self.UserConnection.DefaultDatabase+'.dbo.sys_groupuser  D  on C.groupID=D.groupID '
    +' where  userid='+quotedstr(logininfo.LoginId )+'))'         ;

    self.Kl_GetQuery2(sql);
    if not self.FreeQuery.IsEmpty then
    begin
        for i:=  0 to self.FreeQuery.RecordCount -1 do
        begin
             TAction(ActLst.Actions [FreeQuery.FieldByName('F20').AsInteger]).Enabled  :=false;
             self.FreeQuery.Next;
        end;
    end;


end;

function TFhlKnl.GetMaxCode(Tablename, FieldName:string;wheresql: string='';leftLen:integer=3): string;
var sql,value:string;
begin
     sql:='select max('+FieldName+')as '+FieldName+'  from '+TableName+' '+wheresql   ;
     self.Kl_GetQuery2(sql);
     if not self.FreeQuery.IsEmpty then
     begin
     value:=self.FreeQuery.fieldbyname(FieldName).AsString ;
     result:=  leftstr(value,length(value) -leftLen )+ inttostr( strtoint(rightstr(value,leftLen))        +1)           ;
     end;
end;


function TFhlKnl.Ds_Query(ADataSet: TDataSet; Dbgrid: Tdbgrid):string;
var ConSql,sql:string;
begin


     ConSql:=Ds_GetQuerySql (ADataSet, Dbgrid);
     result:=ConSql;
     Ds_QuickQuery(ADataSet,ConSql)  ;

end;

function TFhlKnl.Ds_GetQuerySql(ADataSet: TDataSet;
  Dbgrid: Tdbgrid): string;
  var sql:string;
begin
    result:='';
    with TFilterFrm.Create(Application) do
    begin
      InitFrm(ADataSet,False,Dbgrid);
      try
        caption:='查询'  ;
        ChkSqlCon.Visible :=false;
        FilterName.Visible :=false;
        if ShowModal=mrOk then
          with ADataSet do
          begin
              result:=GetFilterStr;
              if result<>'' then
              if ChkSqlCon.Checked  then
              begin
              dmfrm.GetQuery1('select top 0 * from sys_FilterOrqtyCon where SqlCon='+quotedstr(result));
              dmfrm.FreeQuery1.Append ;
              dmfrm.FreeQuery1.FieldByName('GridID').AsInteger :=Dbgrid.Tag ;
              dmfrm.FreeQuery1.FieldByName('LoginID').AsString  :=logininfo.LoginId  ;
              dmfrm.FreeQuery1.FieldByName('EmpID').AsString    :=logininfo.EmpId   ;
              dmfrm.FreeQuery1.FieldByName('SqlCon').AsString  :=result ;
              dmfrm.FreeQuery1.FieldByName('DisPlayText').AsString  :=ListBox1.Items.CommaText   ;
              dmfrm.FreeQuery1.FieldByName('UseCount').AsInteger :=dmfrm.FreeQuery1.FieldByName('UseCount').AsInteger+1;
              dmfrm.FreeQuery1.FieldByName('DisPlayCount').AsInteger :=10 ;
              dmfrm.FreeQuery1.FieldByName('Filter').AsBoolean  :=false;
              dmfrm.FreeQuery1.Post ;
              end;    //GridID,LoginID,EmpID,SqlCon,DisPlayText,UseCount,DisPlayCount,Filter,Visiable
          end;
      finally
        Free;
      end;
    end;
end;

{ TFhlDbComboBox }

procedure TFhlDbComboBox.WndProc(var Message: TMessage);
begin
  if Message.Msg=Cm_Enter then
  begin
    Color:=ClCtrlEnter;
  end
  else if Message.Msg=Cm_Exit then
  begin
    Color:=clWhite
  end;
  Inherited WndProc(Message);
end;

{ TFhlComboBox }

procedure TFhlComboBox.WndProc(var Message: TMessage);
begin

  if Message.Msg=Cm_Enter then
  begin
      Color:=ClCtrlEnter ; 
  end
  else if Message.Msg=Cm_Exit then
  begin
    Color:=clWhite
  end;
  Inherited WndProc(Message);
end;

{ TfhlEdit }

procedure TfhlEdit.WndProc(var Message: TMessage);
begin
  if Message.Msg=Cm_Enter then
  begin
        Color:=clAqua ;
  end
  else if Message.Msg=Cm_Exit then
  begin
    Color:=clWhite
  end;
  Inherited WndProc(Message);
end;

function TFhlKnl.Ds_QuickQuery(ADataSet:TDataSet;ConSql:string): string;
var sql, TableCommandText:string;
begin

     sql:='select *from T201 where F01='+ inttostr(ADataSet.Tag );
     fhlknl1.Kl_GetQuery2(sql);
     if not fhlknl1.FreeQuery.IsEmpty then
     begin
           TableCommandText:=  fhlknl1.FreeQuery.fieldbyname('F16').AsString;

           if fhlknl1.FreeQuery.fieldbyname('F16').AsString <>'' then
           begin
                 if pos('SELECT',UPPERCASE(TableCommandText))>0 THEN
                 begin
                      if   ConSql<>'' then
                      ConSql:=   '  and   '  + ConSql;
                      sql:=TableCommandText+ ConSql;
                 end
                 else
                 begin
                      sql:= 'select * from '+TableCommandText ;
                      if   ConSql<>'' then
                      sql:=sql+'  where  '  + ConSql;
                 end;



                ADataSet.Close ;             //query
                Tadodataset(ADataSet).CommandText :=sql;
                ADataSet.Open ;
           end
           else
           begin
                 showmessage('查询备件出错!')   ;
                 exit;
           end;
      end
      else
           showmessage('查询备件出错!')   ;


      result:=TableCommandText;
end;

procedure TFhlKnl.AddColorTOCommandtext(var CommandText: wideString;
  ColorID: integer);
  var sql,TmpCtext:string;
  var refsql:string;
  var colorsql:string;
  var FieldEname,FieldValue,FieldCname,VColor:string;
  VAR Sublen:integer;
begin
sql:='select *from T208 where f01='+inttostr(ColorID);
self.Kl_GetQuery2(sql);

   colorsql:='';
   if not self.FreeQuery.IsEmpty then
   begin
        refsql:=self.FFre_Query.fieldbyname('F02').AsString ;


        self.Kl_GetUserQuery(refsql) ;
        if not self.FUser_Query.IsEmpty then
        begin
              FieldEname:=FUser_Query.fields[0].FieldName  ;
              colorsql:='case ' +FieldEname        ;
              while (not self.FUser_Query.Eof ) do
              begin
                  FieldValue :=FUser_Query.fields[0].AsString ;
                  VColor    :=FUser_Query.fields[2].AsString ;
                  if VColor<>'' then
                  colorsql:=colorsql+' when '+quotedstr(FieldValue) +'  then '+quotedstr(VColor)   ;
                  self.FUser_Query.Next ;
              end;
              if   colorsql= 'case ' +FieldEname      then exit;
              colorsql:=colorsql+'else '+quotedstr('clblack')+' end as FntClr'+'  ,'        ;

              CommandText:=trim(CommandText);
              Sublen:=pos('*',UPPERCASE(CommandText))-1 ;

              TmpCtext:=leftstr(CommandText,Sublen)+' '+colorsql+rightstr(CommandText,length(CommandText)-Sublen);

              CommandText:=  TmpCtext;
        end;
   end;
end;


procedure TFhlKnl.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var i:integer;
begin
    if ( Sender is tlabel) then
    begin

         if    (Shift <>[ ssshift 	]	)  then
         begin
                 (  Sender as tlabel_mtn).Cursor  :=crdefault;
                 (  Sender as tlabel_mtn).Font.Style :=  (  Sender as tlabel_mtn).Font.Style  -[fsBold];

              for i:=0 to   ( Sender as tlabel_mtn).FCollector.Count -1 do
              begin
                  if ( Sender as tlabel_mtn).FCollector.Objects [i] is tlabel_mtn then
                  begin
                    tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Cursor   :=crdefault;
                    tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Font.Style := tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Font.Style  -[fsBold];
                  end;
              end;
              ( Sender as tlabel_mtn).FCollector.Clear ;
         end;

    end;

    if ( Sender is Tedit_Mtn) then
    begin
         if    (Shift <>[ ssshift 	]	)  then
         begin
              ( Sender as Tedit_Mtn).Ctl3D :=false;
              ( Sender as Tedit_Mtn).Cursor  :=crdefault;
              ( Sender as Tedit_Mtn).Font.Style  :=( Sender as Tedit_Mtn).Font.Style-[fsBold];

                 for i:=0 to   ( Sender as Tedit_Mtn).FCollector.Count -1 do
                begin
                    if ( Sender as Tedit_Mtn).FCollector.Objects [i] is Tedit_Mtn then
                    begin
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Cursor   :=crdefault;
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Font.Style := Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Font.Style  -[fsBold];
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Ctl3D := false;
                    end;
                end;
                ( Sender as Tedit_Mtn).FCollector.Clear ;
         end;       
    end;

end;



//TSerialNoDict

function TFhlKnl.Cf_GetDict_LkpImport(FrmId: String;
  var Dict: TLkpImportDict): Boolean;
begin

  Result:=False;

  Kl_GetQuery2('select * from T627 where F01='+FrmId);
  if FFre_Query.RecordCount=1 then
  begin
      Dict.id := FFre_Query.fieldbyname('F01').AsInteger ;
      dict.caption :=FFre_Query.fieldbyname('F02').AsString  ;
      dict.Boxid :=  FFre_Query.fieldbyname('F03').AsString     ;
      dict.TreeID :=  FFre_Query.fieldbyname('F04').AsInteger   ;
      dict.GridID :=  FFre_Query.fieldbyname('F05').AsString ;
      dict.Filters := FFre_Query.fieldbyname('F06').AsString ;
      dict.UseDefaultFilter  := FFre_Query.fieldbyname('F07').AsBoolean  ;
      dict.EditorID:=FFre_Query.fieldbyname('F08').AsString ;
      dict.IsOpen:=FFre_Query.fieldbyname('F09').AsBoolean ;
      dict.DblClick :=FFre_Query.fieldbyname('F10').AsInteger ;
      dict.ToolBtnsID :=FFre_Query.fieldbyname('F11').AsString ;
      dict.mtdatasetid  :=FFre_Query.fieldbyname('F12').AsString ;
      dict.IniPramFields :=FFre_Query.fieldbyname('F13').AsString ;
      dict.UseDefaultqry :=FFre_Query.fieldbyname('F14').AsBoolean  ;
      dict.OpenProcFlds :=FFre_Query.fieldbyname('F15').AsString   ;
      
      dict.ImportSourceFlds:=FFre_Query.fieldbyname('F16').AsString   ;
      dict.ImportDectFlds:=FFre_Query.fieldbyname('F17').AsString   ;
      dict.ImportPK:=FFre_Query.fieldbyname('F18').AsString   ;
      dict.MainGridID:=FFre_Query.fieldbyname('F19').AsString   ;

      dict.MImportSourceFlds :=FFre_Query.fieldbyname('F20').AsString   ;
      dict.MImportDectFlds :=FFre_Query.fieldbyname('F21').AsString   ;
      dict.MGridParameterFlds:=FFre_Query.fieldbyname('F22').AsString   ;


     // dict.Formalgin :=FFre_Query.fieldbyname('F15').AsBoolean  ;
      Result:= true;
  end;

end;

function TFhlKnl.Cf_GetDict_SerialNO(FrmId: String;
  var Dict: TSerialNoDict): Boolean;
begin
//
  Result:=False;

  Kl_GetQuery2('select * from T628 where F01='+FrmId);
  if FFre_Query.RecordCount=1 then
  begin
      //Dict.id := FFre_Query.fieldbyname('F01').AsInteger ;
      dict.actsID  :=  FFre_Query.fieldbyname('F02').AsString ;
      dict.caption :=FFre_Query.fieldbyname('F03').AsString  ;
      dict.Boxid  :=  FFre_Query.fieldbyname('F04').AsString ;
      dict.CandidateGridID  :=  FFre_Query.fieldbyname('F05').AsString ;
      dict.SerialGridID  := FFre_Query.fieldbyname('F06').AsString ;
      dict.serialNolenghtparams   := FFre_Query.fieldbyname('F07').AsString   ;
      dict.Chkproc :=FFre_Query.fieldbyname('F08').AsString ;
      dict.UnchkProc :=FFre_Query.fieldbyname('F09').AsString ;
      dict.chkCaption  :=FFre_Query.fieldbyname('F10').AsString ;
      dict.Unchkcaption  :=FFre_Query.fieldbyname('F11').AsString ;
      dict.chkrightID   :=FFre_Query.fieldbyname('F12').AsString ;
      dict.UnchkrightID  :=FFre_Query.fieldbyname('F13').AsString ;
      dict.MtdatasetID   :=FFre_Query.fieldbyname('F14').AsString ;
      dict.CandidateFldName:=FFre_Query.fieldbyname('F15').AsString ;
      dict.WriteSerialRitID :=FFre_Query.fieldbyname('F16').AsString ;
      dict.ChkFieldName  :=FFre_Query.fieldbyname('F17').AsString ;
      dict.IsChkValue    :=FFre_Query.fieldbyname('F18').AsString ;

      Result:= true;
  end;

end;

function  TFhlKnl.GetPostSQL(Adodataset:Tdataset;binsert:boolean;TableName:string):string;
var
    i:integer;
    sql1   :string;
    flds,values,updateItem:Tstrings;

    LOGDataSet:Tadodataset;
    Cnn:Tadoconnection;
begin
    //if  Adodataset.findfield('F_ID') =nil then exit;
    flds:=TstringLIST.Create ;
    values:=TstringLIST.Create ;
    values.QuoteChar :=' ';
    updateItem:=TstringLIST.Create ;
    updateItem.QuoteChar :=' ';
    
    LOGDataSet:=Tadodataset.Create (nil);
    Cnn:=Tadoconnection.Create (nil);
    Cnn.ConnectionString :=self.FADOConnection.ConnectionString;
    Cnn.DefaultDatabase:=  logininfo.SysDBPubName ;
    Cnn.LoginPrompt :=false;

    LOGDataSet.Connection := Cnn ;
    LOGDataSet.CommandText :='select top 0  * from TUpdateSQLLog' ;
    LOGDataSet.Open ;
    LOGDataSet.Append ;

    for i:=0 to   Adodataset.FieldCount -1 do
    begin
      if   Adodataset.Fields[i].FieldKind = fkData then
      begin
          if  (Adodataset.Fields[i]is  TAutoIncField ) then
              continue;
          if  Adodataset.Fields[i] is  TBCDField then
              continue;
          if  Adodataset.Fields[i] is  TBinaryField then
              continue;
          if  Adodataset.Fields[i] is  TBlobField then
              continue;

          flds.Add( Adodataset.Fields[i].FieldName  ) ;

          if Adodataset.Fields[i].Value =null then
              values.Add('null')
          else
          begin
              if Adodataset.Fields[i] is TBooleanField	then
              begin
                if Adodataset.Fields[i].AsBoolean then
                    values.Add('1')
                else
                    values.Add('0');
              end
              else
                values.Add(quotedstr( Adodataset.Fields[i].AsString ) );
          end;

      end;
    end;

    if  binsert  then
    begin
    sql1:='set IDENTITY_INSERT T511   on     ' ;
        sql1:=sql1    +'insert into '+TableName+' (';
        sql1:=sql1+flds.CommaText +')values( '   +values.CommaText +')' ;

        LOGDataSet.FieldByName('F_OperateType').AsString :='insert';

    end
    else
    begin

        sql1:=sql1     +' update '+TableName+' set ';
        for i:=0 to flds.Count-1 do
        begin
        if flds[i]<>'F_ID' then
           updateItem.Add(  flds[i]+'='+values[i]  )
        end;

        sql1:=sql1+  updateItem.CommaText;


        if (Adodataset.FindField('F_ID')<>nil) then
          sql1:=sql1         +' where F_ID='+ Adodataset.Fieldbyname('F_ID').AsString   
        else
          sql1:=sql1         +' where f01='+ Adodataset.Fieldbyname('f01').AsString  ;
        LOGDataSet.FieldByName('F_OperateType').AsString :='update';

    end;

    LOGDataSet.FieldByName('F_Table').AsString :=  TableName;
    LOGDataSet.FieldByName('F_SQL').AsString :=  sql1 ;
    LOGDataSet.Post ;

    result:=  sql1 ;

    flds.Free ;
    values.Free ;
    updateItem.Free ;
    LOGDataSet.free;
end;

function  TFhlKnl.GetDeleteSQL(Adodataset:Tdataset;TableName:string):string;
var sql1:string;
    LOGDataSet:Tadodataset;
    Cnn:Tadoconnection;
begin

    LOGDataSet:=Tadodataset.Create (nil);
    Cnn:=Tadoconnection.Create (nil);
    Cnn.ConnectionString :=self.FADOConnection.ConnectionString;
    Cnn.DefaultDatabase:=  logininfo.SysDBPubName ;
    Cnn.LoginPrompt :=false;

    LOGDataSet.Connection := Cnn ;
    LOGDataSet.CommandText :='select top 0  * from TUpdateSQLLog' ;
    LOGDataSet.Open ;
    LOGDataSet.Append ;

    if Adodataset.findField ('F_ID')<>nil then
    begin
        sql1:= 'delete '+TableName+' where F_ID='+ Adodataset.Fieldbyname('F_ID').AsString  ;     // ???????????
        LOGDataSet.FieldByName('F_Table').AsString :=  TableName;
        LOGDataSet.FieldByName('F_SQL').AsString := sql1 ;
        LOGDataSet.FieldByName('F_OperateType').AsString :='delete';
        LOGDataSet.FieldByName('F_Note').AsString := GetPostSQL(Adodataset,true,TableName ) ;
        LOGDataSet.Post ;
    end;

    result:=sql1;
end;
function TFhlDbEdit.GetTableName: string;
begin
 result:=self.FTableName ;
end;

procedure TFhlDbEdit.SetTableName(const Value: string);
begin
     self.FTableName :=  Value;
end;


function TFhlKnl.SaveDeleteDataLog(Adodataset: Tdataset;
  TableName: string): string;
var sql1:string;
    LOGDataSet:Tadodataset;
    Cnn:Tadoconnection;
begin

    LOGDataSet:=Tadodataset.Create (nil);
    Cnn:=Tadoconnection.Create (nil);
    Cnn.ConnectionString :=self.FADOConnection.ConnectionString;
    Cnn.DefaultDatabase:=  logininfo.SysDBPubName ;
    Cnn.LoginPrompt :=false;

    LOGDataSet.Connection := Cnn ;
    LOGDataSet.CommandText :='select top 0  * from T_DataDeLLog' ;
    LOGDataSet.Open ;
    LOGDataSet.Append ;

    if Adodataset.findField ('F_ID')<>nil then
    begin
        sql1:= 'delete '+TableName+' where F_ID='+ Adodataset.Fieldbyname('F_ID').AsString  ;    
        LOGDataSet.FieldByName('FTableEName').AsString :=  TableName;
        LOGDataSet.FieldByName('FSQL').AsString := sql1 ;

        LOGDataSet.FieldByName('FNote').AsString := GetPostSQL(Adodataset,true,TableName ) ;
        LOGDataSet.Post ;
    end;

    result:=sql1;
end;



function TFhlKnl.SaveUserDataPostLog(Adodataset: Tdataset;
  binsert: boolean; TableName: string): string;
begin
//
end;

function TFhlKnl.CreateQRLabel(left, Top, width, height : integer;pCaption:string;  pCol:TColumn;
  FParent: TWinControl): TQRLabel;
var Memo:TQRLabel;
begin

  Memo:=TQRLabel.Create(FParent);
  memo.Alignment:=taCenter ;
  memo.AutoSize :=false;
  Memo.Caption :=pCaption;
  Memo.Parent :=        FParent.Parent  ;
  Memo.Left :=left;
  Memo.Top :=top;
  Memo.Width :=width   ;
  Memo.Height :=height;
  Memo.Parent:=fParent;
  Memo.Font :=pCol.Title.Font   ;
  //Memo.AlignToBand:=false;
  memo.AutoStretch :=false;


  Memo.Frame.DrawTop :=pCol.Visible ;
       Memo.Frame.DrawLeft :=pCol.Visible ;
  //Memo.Frame.DrawBottom  :=True;

  //Memo.Frame.DrawRight  :=True;
  Memo.Transparent := pCol.Visible ;
  Memo.Frame.Width :=1;
  {}
  result:= Memo ;
end;


procedure TFhlKnl.CreateQRCaptions(pCols:TDBGridColumns;   FParent,fDetail: TWinControl;pHasVerticalLine:boolean ;PframeWidth:integer );
var i,j,k,LayCount,p,q,fleft,ftop:integer;
var Titles:array   of   array   of   string;
var Memo:array   of   array   of   TQRLabel;
var str:string;
var Lst:TStringList;
var   ConstHeight:integer;
var FirstVisableIndex:integer;

const ConstGap=1;
begin
  FirstVisableIndex:=-1;
  ConstHeight:=20;//strtoint(self.edtHeight.Text );
  Lst:=TStringList.Create ;
  Lst.Delimiter :='|';

  fleft:=0;// 6;      // FParent.Left -


  for i:=0 to pCols.Count-1 do
  begin
    Lst.DelimitedText := pCols[i].Title.Caption ;
    if Lst.Count > LayCount then
    LayCount:= Lst.Count;
  end;

  FParent.Height :=  ConstHeight*  LayCount;
  setlength(Titles,pCols.Count,LayCount);
  setlength(Memo,pCols.Count,LayCount);

  for i:=0 to pCols.Count-1 do
  begin
      if (pcols[i].Visible )and (FirstVisableIndex<0   ) then
      FirstVisableIndex:=i;

     Lst.DelimitedText :=  pCols[i].Title.Caption ;
     for j:=  0 to Lst.Count- 1  do
     begin
       //Titles[i,Lst.Count- 1-j]:=Lst[j];
       Titles[i, j]:=Lst[j];
     end;
  end;
  for i:=0 to pCols.Count-1 do
  begin
     for j:=  0 to  LayCount- 1 do
     begin
     if  (Titles[i,j]='') then
       if (    (Titles[i,j-1]<>''))then
        Titles[i,j]:=Titles[i,j-1]
       else
       begin
        Titles[i,j]:=Titles[i ,j-2];
        Titles[i ,j-1]:=Titles[i,j-2];
       end;
     end;
  end;
  for i:=0 to pCols.Count -1 do
  begin
      ftop    :=0  ;//FParent.top ;
      for j:=0  to  LayCount- 1  do
      begin
            Memo[i,j] :=    CreateQRLabel( fleft,ftop  , pCols[i].Width  ,  ConstHeight , pCols[i].Title.Caption ,pCols[i]  ,  FParent) ;
            Memo[i,j].Caption  :=Titles [i,j];
            ftop :=ftop +ConstHeight+ConstGap ;

            if i=FirstVisableIndex then Memo[FirstVisableIndex,j].Frame.DrawLeft :=false;
      end;
      if pHasVerticalLine then
      if pCols[i].Visible then
      if i>FirstVisableIndex then
      with TQRShape.Create(fDetail) do
      begin
          Parent:=fDetail;
          Shape:=qrsVertLine;
          left:=fleft;
          top:=0 ;
          width:=0;
          Height:=fDetail.height ;
      end;

      IF pCols[i].Visible THEN
      IF pCols[i].Field<>NIL THEN
      begin
        if pCols[i].Field.DataType in [ftSmallint,ftInteger,ftFloat,ftCurrency,ftLargeint,ftBCD] then //, ftTime, ftDateTime
        begin
          //with TQRDBRichTextEx.Create(fDetail) do
          with TQRDBtext.Create(fDetail) do
          begin
            AutoSize :=false;
            Parent:=fDetail ;
            Left:=fleft+1 ;     // +6  -6
            Top:=2 ;
            Width:=pCols[i].Width-4 ;
            alignment:=pCols[i].Alignment;
            if pCols[i].Alignment= taLeftJustify then Left:=Left+1;    //2010-7-15 单价不能右对齐
           // if pCols[i].Alignment= tarightJustify then Left:=Left-1;
            DataSet:=pCols.Grid.DataSource.DataSet;
            DataField:=pCols[i].Field.FieldName;
            Font.Assign(pCols[i].Font );
            TQRBand(fDetail).Frame.DrawLeft  :=true;
            TQRBand(fDetail).Frame.DrawRight   :=true ;
            TQRBand(FParent).Frame.DrawLeft  :=true;
            TQRBand(FParent).Frame.DrawRight :=TQRBand(fDetail).Frame.DrawRight  ;
            TQRBand(fDetail).Frame.DrawTop :=true;
            //TQRBand(fDetail).Frame.DrawBottom :=true;

          end;
        end
        else
        with TQRDBRichTextEx.Create(fDetail) do
        begin

          AutoStretch :=True;
          Parent:=fDetail ;
          Left:=fleft+1 ;     // +6  -6
          Top:=2 ;
          Width:=pCols[i].Width-4;
          alignment:=pCols[i].Alignment;
          if pCols[i].Alignment= taLeftJustify then
          Left:=Left+1;    //2010-7-15 单价不能右对齐

          DataSet:=pCols.Grid.DataSource.DataSet;
          DataField:=pCols[i].Field.FieldName;
          Font.Assign(pCols[i].Font );
          TQRBand(fDetail).Frame.DrawLeft  :=true;
          TQRBand(fDetail).Frame.DrawRight   :=true ;
          TQRBand(FParent).Frame.DrawLeft  :=true;
          TQRBand(FParent).Frame.DrawRight :=TQRBand(fDetail).Frame.DrawRight  ;
          TQRBand(fDetail).Frame.DrawTop :=true;
          //TQRBand(fDetail).Frame.DrawBottom :=true;
        END;
        fleft :=fleft +pCols[i].Width+ConstGap ;
      end;
  end;

  
    //merger left
    // if text=left then merger
    for j:=0 to      LayCount- 1 do
    begin
        for i:=0 to pCols.Count-1 do
        begin
            k:=i+1;
            if k<= pCols.Count-1 then
            begin
                while (Memo[i,j].Caption  =Memo[k ,j].Caption )  do
                begin
                     (Memo[k,j].Visible  :=false);
                     Inc(k);
                     if k=  pCols.Count-1  then break;
                end;
                 Memo[i ,j].Width := (Memo[i ,j].Width)*( k-i)+ConstGap*( k-i-1);
               //  Memo[i ,j].Alignment := taCenter;
            end;
        end;
    end;  {}

   //merger beanth
    for i:=pCols.Count-1 downto 0  do
    begin
       for j:=0 to LayCount- 1 do
       begin
         if Memo[i ,j].Visible =false then Continue ;
          k:=j+1;
          if (k<=  LayCount- 1) then
          begin
               while  (k<= LayCount- 1 )and (Memo[i,j].Caption  =Memo[i ,k].Caption ) do
               begin
                   Memo[i ,k].Visible :=False;
                   Inc(k);
               end;
               Memo[i ,j].Height := (Memo[i ,j].Height )*( k-j)+ConstGap*( k-j-1);;
          end;
       end;
    end;    { }


end;
procedure TFhlKnl.Cf_ListAllNodeForMain(myTreeCodeDataSet: TDataSet;
  TreeView: TTreeView; ImgIdx, SelIdx: Integer; CodeFld, NameFld: String;
  ShowCode: Boolean);
var
  Node:TTreeNode;
  ii:integer;
  s,t:String;
begin
      with myTreeCodeDataSet do
      begin
          First;
          while not eof do
          begin
              s:=FieldByName(trim(CodeFld)).asString;
              t:=FieldByName(trim(NameFld)).AsString;
              if ShowCode then t:=t+'['+s+']';
              ii:=length(s);
              while ii>0 do
              begin
                    ii:=ii-1;
                    Node:=Tv_FindNode(TreeView,copy(s,1,ii));
                    if Node<>nil then
                    begin
                          if  (FieldByName('f05').AsInteger =-1) or  (FieldByName('f06').AsString  ='') then
                            Tv_NewDataNode(TreeView,Node,s,t,20 ,SelIdx)
                          else
                            Tv_NewDataNode(TreeView,Node,s,t,ImgIdx ,SelIdx);
                          Break;
                    end;
              end;
              next;
           end;
      end;
end;

function TFhlKnl.GetSysParametersName(PdataSet: Tdataset): string;
var sql:string;
begin
    result:='';
    self.Kl_GetQuery2('select * from T201 where f01 ='+inttostr(pdataset.Tag ),true );

    if not self.FreeQuery.IsEmpty then
    result:=self.FreeQuery.fieldbyname('f13').AsString ;


end;



function TFhlKnl.GetCalculateFldsForLogSys(PdataSet: Tdataset): string;
var flds:string;
begin
  self.Kl_GetQuery2('select * from T202 where f02='+inttostr(pdataset.Tag ) ,true);

  if not self.FreeQuery.IsEmpty then
  while(not self.FreeQuery.Eof ) do
  begin
      if (trim(flds+self.FreeQuery.fieldbyname('f08').AsString) <>'')and (trim(flds+self.FreeQuery.fieldbyname('f09').AsString) ='') then
      flds:=','+flds+self.FreeQuery.fieldbyname('f08').AsString ;
      FreeQuery.Next;
  end;
  result:=flds ;

end;

function TFhlKnl.CheckIfIsTheLastestVersion(PdataSet: Tdataset): boolean;
var sql:string;
i:byte;
begin
  result:=true ;
  
self.Kl_GetQuery2('select * From T202 where f02='+inttostr(Pdataset.Tag )) ;
if self.FreeQuery.IsEmpty then
exit;

if    PdataSet.FindField('F_ID')<>nil then
  if    PdataSet.FindField('FUPDFLAG')<>nil then
  begin
     self.Kl_GetQuery2('select *from T201 where F01='+inttostr(PdataSet.Tag ));
     if not FreeQuery.IsEmpty then
     begin
//     i:=  PdataSet.FieldByName('FUPDFLAG').Value ;
       sql:='select *from '+self.FreeQuery.FieldByName('F16').AsString+' where F_ID=:F_ID  ';

        sql:=sql+' and FUPDFLAG=:FUPDFLAG'  ;

       self.User_Query.close;
       self.User_Query.SQL.Clear;
       self.User_Query.sql.Add(sql);
        self.User_Query.Parameters.Refresh;

       User_Query.Parameters[0].Value := PdataSet.FieldByName('F_ID').AsString;
      User_Query.Parameters[1].Value:=PdataSet.FieldByName('FUPDFLAG').Value  ;

       User_Query.Open ;
       if   User_Query.IsEmpty then
         result:=false
       else
         result:=true;

     end;
  end;
end;


function TFhlKnl.Cf_DeleteDbGridUnAuthorizeCol(GridId: string;
  dbGrid: TDbGrid; FempCOde, FWindowsID, BasicDataBase: string): string;
var fsql:string;
    i:integer;
begin
    fsql:= 'select FSpecificObjName,FSpecificObjid  , A.FWindowsFID ,B.FWindowsFID  ,B.FGridid  From  TUserToSpecificObj  A ';
    fsql:=fsql+ ' join  '+logininfo.SysDBPubName  +'.dbo.TAuthorizeObject B on A.FAuthorizeObjsID=B.FAuthorizeObjsID   and A.FWindowsFID=B.FWindowsFID ';
    fsql:=fsql+ ' where  B.FGridid = '+GridId+'  and A.FempCode='+quotedstr(FempCOde)+' and A.FEnable=0 ';
    fsql:=fsql+ ' and   A.FwindowsFID='+quotedstr(FWindowsID)+' ' ;
 
    self.Kl_GetUserQuery(fsql ) ;
    if not self.FUser_Query.IsEmpty then
    begin
       while (not   FUser_Query.Eof ) do
       begin
          for i:= dbGrid.Columns.Count -1 downto  0 do
          begin
              if dbGrid.Columns[i].Field<>nil then
              begin                  { }
                if  ( dbGrid.Columns[i].Field is  TFloatField ) or
                    ( dbGrid.Columns[i].Field is  TBCDField ) or
                    ( dbGrid.Columns[i].Field is  TIntegerField ) or
                    ( dbGrid.Columns[i].Field is  TCurrencyField ) or
                    ( dbGrid.Columns[i].Field is  TLargeintField )  then
                  if   FUser_Query.FieldByName('FSpecificObjid').AsString   = TChyColumn(dbGrid.Columns[i]).colid then
                  
                  dbGrid.Columns[i].Free;
              end
              else
                  if   FUser_Query.FieldByName('FSpecificObjid').AsString   = TChyColumn(dbGrid.Columns[i]).colid then
                  dbGrid.Columns[i].Free;
          end;
          FUser_Query.Next;
       end;
    end;

end;

function TFhlKnl.Cf_GetUnAuthorizedCrmTabs(FsubInterfaceID: string; FempCOde, FWindowsID, BasicDataBase: string): TstringList;
var fsql:string;
    i:integer;
begin
    result:=TstringList.Create;

    fsql:= 'select FSpecificObjName,FSpecificObjid  , A.FWindowsFID ,B.FWindowsFID    From  TUserToSpecificObj  A ';
    fsql:=fsql+ ' join  '+logininfo.SysDBPubName  +'.dbo.TAuthorizeObject B on A.FAuthorizeObjsID=B.FAuthorizeObjsID   and A.FWindowsFID=B.FWindowsFID ';
    fsql:=fsql+ ' where A.FempCode='+quotedstr(FempCOde)+' and A.FEnable=0 ';
    fsql:=fsql+ ' and   A.FwindowsFID='+quotedstr(FWindowsID)+' ' ;
    fsql:=fsql+ ' and   A.FAuthorizeObjsID ='+quotedstr(FsubInterfaceID)+' ' ;

    self.Kl_GetUserQuery(fsql ) ;
    if not self.FUser_Query.IsEmpty then
    begin
       while (not   FUser_Query.Eof ) do
       begin
          result.Add(FUser_Query.Fields[1].asstring);
          FUser_Query.Next;
       end;
    end;

end;

{ TFhlImage

procedure TFhlImage.Change;
begin
  inherited;

end;     }

procedure TFhlImage.CMEnter(var Message: TCMEnter);
begin
  Invalidate; { Draw the focus marker }
  inherited;      {}
end;

procedure TFhlImage.CMExit(var Message: TCMExit);
begin
  try
    if Assigned(DataSource) and Assigned(DataSource.DataSet) and
       (DataSource.DataSet.State in [dsInsert, dsEdit]) then
      FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  Invalidate; { Erase the focus marker }
  inherited;
end;

constructor TFhlImage.Create(AOwner: TComponent);
begin
  inherited;
  ControlState:=ControlState+ [csPaintCopy]  ;

  Picture:=TPicture.Create;
  FPicture.OnChange := PictureChanged;

  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  
end;

procedure TFhlImage.DataChange(Sender: TObject);
var
  s:string;
  JPG: TJPEGImage;
  strm: TADOBlobStream;
begin
    Picture.Graphic := nil;
    FPictureLoaded := False;

    if  (not Assigned(FDataLink.Field) or    FDataLink.Field.IsBlob) then
    begin   
      try
        JPG:= TJPEGImage.Create ;
        strm := tadoblobstream.Create(tblobfield(self.FDataLink.DataSet.fieldbyname(self.FDataLink.FieldName )),bmread);
        strm.position :=0;
        if strm.Size >0 then
        begin
          JPG.LoadFromStream(  strm );
          Picture.Assign(JPG);
        end;
      finally
        JPG.Free ;
        strm.Free ;
      end;
    end;
end;

destructor TFhlImage.Destroy;
begin
  Picture.Free ;
  FDataLink.Free;
  FDataLink := nil;

  inherited;
end;

function TFhlImage.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TFhlImage.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TFhlImage.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TFhlImage.Paint;
var
  Size: TSize;
  R: TRect;
  S: string;
  DrawPict: TPicture;
  Form: TCustomForm;
  Pal: HPalette;
  JPG: TJPEGImage;
  strm: TADOBlobStream;
begin
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;
    if   (csPaintCopy in ControlState) then
    begin
      DrawPict := TPicture.Create;
      Pal := 0;
      try
//          if not ( FDataLink.DataSet.State in [dsinsert] ) then
            if FPictureLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
            begin
              try
                strm := tadoblobstream.Create(tblobfield(self.FDataLink.DataSet.fieldbyname(self.FDataLink.FieldName )),bmread);
                strm.position :=0;
                JPG:= TJPEGImage.Create ;
                if strm.Size >0 then
                begin
                  JPG.LoadFromStream(  strm );
                  DrawPict.Assign(JPG);
                end;
              finally
                strm.Free ;
                JPG.Free ;
              end;
            end ;
//         else  DrawPict.Assign(self.Picture );



         if Stretch then
          if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
            FillRect(ClientRect)
          else
            StretchDraw(ClientRect, DrawPict.Graphic)
        else
        begin
          SetRect(R, 0, 0, DrawPict.Width, DrawPict.Height);
          OffsetRect(R, (ClientWidth - DrawPict.Width) div 2,(ClientHeight - DrawPict.Height) div 2);
          StretchDraw(R, DrawPict.Graphic);
          ExcludeClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
          FillRect(ClientRect);
          SelectClipRgn(Handle, 0);
        end;
      finally
        if Pal <> 0 then SelectPalette(Handle, Pal, True);
        DrawPict.Free;
      end;
    end
    else
    begin
      Font := Self.Font;
      if FDataLink.Field <> nil then
        S := FDataLink.Field.DisplayLabel
      else S := Name;
      S := '(' + S + ')';
      Size := TextExtent(S);
      R := ClientRect;
      TextRect(R, (R.Right - Size.cx) div 2, (R.Bottom - Size.cy) div 2, S);
    end;
    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.ActiveControl = Self) and
      not (csDesigning in ComponentState) and
      not (csPaintCopy in ControlState) then
    begin
      Brush.Color := clWindowFrame;
      FrameRect(ClientRect);
    end;
  end;
end;

procedure TFhlImage.PictureChanged(Sender: TObject);
begin
  if FPictureLoaded then
  FDataLink.Modified;
  FPictureLoaded := True;
  Invalidate;


  if Assigned(DataSource) and Assigned(DataSource.DataSet) and
    (DataSource.DataSet.State in [dsInsert, dsEdit]) then
  FDataLink.UpdateRecord;

end;

procedure TFhlImage.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TFhlImage.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TFhlImage.UpdateData(Sender: TObject);
var
  strm: TMemoryStream;
  jpe:TJPEGImage;
  //MemAfterCompress: TMemoryStream;
begin

  try
    jpe:=TJPEGImage.Create ;
    strm := tmemorystream.Create ;
    strm.Position :=0;

    if (Picture.Graphic is TBitmap )or (Picture.Graphic is TJPEGImage ) then
    begin
      jpe.Assign( Picture.Graphic  ) ;
      jpe.SaveToStream(strm ) ;
      tblobfield(self.FDataLink.DataSet.FieldByName(self.FDataLink.FieldName)).LoadFromStream  (strm);
    end;
//    else        FDataLink.Field.Clear;
  finally
    jpe.Free ;
    strm.Free  ;
  end;
  
end;

procedure TFhlImage.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if TabStop and CanFocus then SetFocus;
  inherited;
end;

procedure TFhlImage.WndProc(var Message: TMessage);
begin
  inherited;

end;


 


constructor TFhlDbEdit.Create(AOwner: TComponent);
begin
  inherited;


end;

function TFhlKnl.Cf_GetUserMenuName(FOldCaption,FWindowsFID: string): string;
var fsql:string;
begin
        Fsql :='if exists(select 1 from '+LoginInfo.MainUserDBName +'.dbo.sysobjects where name= ''TSysUMenuConfig '')';
        Fsql :=Fsql+' select FCaption from '+LoginInfo.MainUserDBName +'.dbo.TSysUMenuConfig where FWindowsFID ='+quotedstr(FWindowsFID) +' and FCaption <>'+quotedstr(FOldCaption) ;
        Fsql :=Fsql+' else   select top 0   1 ';
        FhlKnl1.Kl_GetQuery2(Fsql);
        if not FhlKnl1.FreeQuery.IsEmpty then
          Result := FhlKnl1.FreeQuery.FieldByName('FCaption').AsString
        else
          Result := FOldCaption;

end;

function TFhlKnl.TColorToHex(Color: TColor): string;
begin
   Result := IntToHex( colortorgb( Color),8);
end;

function TFhlKnl.HexToTColor(sColor: string): TColor;
begin
  try
   Result :=StringToColor (  '$'+sColor );
  except
   Result :=StringToColor (   sColor );
  end;
end;


function TFhlKnl.Os_GetComputerMac: String;
var   ncb   : TNCB;
   status   : TAdapterStatus;
   lanenum : TLanaEnum;
     procedure ResetAdapter (num : char);
     begin
       fillchar(ncb,sizeof(ncb),0);
       ncb.ncb_command:=char(NCBRESET);
       ncb.ncb_lana_num:=num;
       Netbios(@ncb);
     end;
var
   i:integer;
   lanNum   : char;
   address : record
              part1 : Longint;
              part2 : Word;
             end absolute status;
begin
   Result:='';
   fillchar(ncb,sizeof(ncb),0);
     ncb.ncb_command:=char(NCBENUM);
     ncb.ncb_buffer:=@lanenum;
     ncb.ncb_length:=sizeof(lanenum);
   Netbios(@ncb);
   if lanenum.length=#0 then exit;
   lanNum:=lanenum.lana[0];
   ResetAdapter(lanNum);
   fillchar(ncb,sizeof(ncb),0);
     ncb.ncb_command:=char(NCBASTAT);
     ncb.ncb_lana_num:=lanNum;
     ncb.ncb_callname[0]:='*';
     ncb.ncb_buffer:=@status;
     ncb.ncb_length:=sizeof(status);
   Netbios(@ncb);
   ResetAdapter(lanNum);
   for i:=0 to 5 do
   begin
     result:=result+inttoHex(integer(Status.adapter_address[i]),2);
     if (i<5) then
     result:=result+'-';
   end;
end;
     {
function TFhlKnl.Os_GetComputerMac: String;
var
  myip: ulong;
  mymac: array[0..5] of byte;
  mymaclength: ulong;
  r: integer;
begin

//result:=  GetAdapterInformation;
end;
    }

 
function TFhlDbEdit.GetLookupFrm: Tform;
begin
  result:=FLookupFrm;
end;

procedure TFhlDbEdit.SetLookupFrm(const Value: Tform);
begin
   FLookupFrm:=Value;
end;

procedure TFhlKnl.CloseSysDataSet;
begin
    Fcfg_dataset.Close;
    Fcfg_datasetfld.Close;
    Fcfg_label.Close;
    Fcfg_dbctrl.Close;
    Fcfg_dbgridcol.Close;
    Fcfg_dbgrid.Close;
end;

function TFhlKnl.CacheFileName(DataSetName: string): string;
begin
    if not DirectoryExists('Cache') then
      createdir('Cache');

    if logininfo.IsDev then
      result:=''
    else
      result:= ExtractFilePath(application.exename)+ 'Cache\'+DataSetName+self.FADOConnection.DefaultDatabase +GetSysVersion+'.inf';
end;
procedure TFhlKnl.Rp_SetRepCtrlWithSumRow(fDictDataSet, fDataSet: TDataSet;
  fParent: TQrBand; ABeginTop: integer; DLGrid: TDbGrid);
 var l,t,w, i :Integer;Fnt:TFont;
 var lbl:TQRLabel ;
 var Txt: TQRDBtext ;
 const ConstGap:Integer=1   ;

begin
  Rp_SetRepCtrl(fDictDataSet,fDataSet,fParent,ABeginTop,DLGrid);

  l:=0;
  t:=4;
  if DLGrid<>nil then
  if TModelDbGrid(DLGrid).NeedSumRow then
  begin
     for i:=0 to DLGrid.Columns.Count -1 do
     begin
        if  DLGrid.Columns[i].Visible then
        begin
          lbl:=TQRLabel.Create(fParent) ;
          //Txt:=TQRDBtext.Create(fParent) ;
          with lbl do
          begin
           Parent:=fParent; Left:=l; top:=t;
           Caption :=TChyColumn(DLGrid.Columns[i]).GroupValue  ;
           // Font.Assign(Fnt);
            Frame.DrawLeft:=True;
            AutoSize :=False;
            AutoStretch :=false;
            Alignment:= DLGrid.Columns[i].Alignment  ;//Vl_GetAlignment(fDictDataSet.FieldByName('F03').asInteger);
            width:=DLGrid.Columns[i].Width ;
            Frame.Width :=1;

            l :=left +DLGrid.Columns[i].Width +ConstGap ;
          end;
        end;
     end;
  end;

end;

procedure TFhlKnl.RefreshCfgData;
begin
  Fcfg_dataset.Close;
  Fcfg_dataset.Open;

  Fcfg_datasetfld.Close;
  Fcfg_datasetfld.Open;

  Fcfg_label.Close;
  Fcfg_label.Open;

  Fcfg_dbctrl.Close;
  Fcfg_dbctrl.Open;

  Fcfg_dbgridcol.Close;
  Fcfg_dbgridcol.Open;

  Fcfg_dbgrid.Close;
  Fcfg_dbgrid.Open;
end;

end.
