unit datamodule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DateUtils,
  Db, ADODB, ImgList, dbgrids, ComCtrls, DbCtrls,StdCtrls,  Variants, Menus, StrUtils,upublicfunction,UnitDBFile,
   FhlKnl, Sockets, ActiveX, Registry, ActnList, ExtDlgs,ComObj,UnitCrmMain,UnitActionsGrid,UnitMainMenu;

type  TFormType =  (ModelFrmBill,ModelFrmTreeEditor,ModelFrmTreeGrid,
ModelFrmAnalyser,ModelFrmTabEditor,ModelFrmTreeMgr,ModelTabGrid,ModelEditor,
ModelLookup,ModelFrmYdWareProp  ,ModelPickDict ,ModelBilOpnDlgDict,
ModelTreeMgrDict ,ModelMore2MoreDict   ,modelFrmPickMulPage

);//模板类型
//ModelFrmYdWareProp 异地库参




type
  TFhlUser = class(TObject)
    procedure SetDataSet(ADataSet:TDataSet;ADataSetId:ShortString;AParams:Variant;AIsOpen:Boolean=True);overload;

    function  SetDbGrid(ADbGridId:String;ADbGrid:TDbGrid ;BDifReadOnlyClr :boolean=false):String; overload;
    function  SetDbGrid(ADbGridId:String;ADbGrid:TDbGrid;EditBtnClick:Taction):String;overload;

    procedure SetDbGridAndDataSet(ADbGrid:TDbGrid;ADbGridId:String;AParams:Variant;AIsOpen:Boolean=True;BDifReadOnlyClr :boolean=false);overload;
    procedure SetDbGridAndDataSet(ADbGrid:TDbGrid;ADbGridId:String;AParams:Variant;AIsOpen:Boolean;EditBtnClick:Taction);overload;

    function  ShowFinderFrm(fAdoDataSet:TAdoDataSet;Var fFinderFrm:TForm;fFinderId:String):wideString;

    procedure ShowCRMFrm(FromId:string ; OpenParam:string ='';  AuthoriseTmpTable:string='');
    procedure ShowMainMenuFrm(FromId:string ;OpenParam:string ='');

    procedure ShowBillFrm_Ex(fFrmId:String;fCode:String='';pTmpTableName:string ='');
    procedure ShowVoucher(fFrmId:String;fCode:String='';pTmpTableName:string ='');

    procedure ShowBillOpenDlgFrm(AFrmId:string);

    procedure ShowTreeEditorFrm(fFrmId:String);
    Function  ShowModelTreeEditorFrm(fFrmId:String;AParams:variant;Model:boolean):Tform;

    procedure ShowTreeGridFrm(fFrmId:String);
    function  ShowModalTreeGridFrm(fFrmId:String;AParams:variant;Modal:boolean=false):Tform;
    function  ShowModalTreeGridFrmSystool(fFrmId: String; AParams: variant;  Modal: boolean=false):Tform;

    procedure ShowTreeMgrFrm(fFrmId:String);
    function  ShowAnalyserFrm(AFrmId:String;AmtParams:Variant; AuthoriseTmpTable:string='' ;pFormStyle:TFormStyle=fsMDIChild):Tform;
    procedure ShowProgress(AProgress, AMaxProgress: Integer);

    procedure ShowMore2MoreFrm(fFrmId:String;fParams:Variant);
    function  ShowEditorFrm      (fFrmId:String;fOpenParams:Variant;fDataSet:TDataSet=nil;owner:Twincontrol=nil;PparentGrid:Tdbgrid=nil):TForm;
    function  ShowEditorFrmSystool(fFrmId:String;fOpenParams:Variant;fDataSet:TDataSet=nil;owner:Twincontrol=nil):TForm;

    procedure ShowSpecialFrm(fFrmId:integer;fOpenParams:Variant );
    procedure CheckRight(RightId:String;MyFrm:TForm=nil);
    function  CheckRight2(RightId:String;MyFrm:TForm=nil):boolean;

//    function  GetSysParamVal(AParamName:String):Variant;                 //2007-8-3
    function  GetSysParamVal(AParamName:String):Variant; //默认参数
    function  GetSysParamsVal(AParamsName:Variant):Variant;
    procedure AssignDefault(fDataSet:TDataSet;UseEdit:boolean=true);
    procedure Logout(Note:String='');
    procedure DoExecProc( AUsrDataSet:TDataSet;Aparams:Variant;AProcId:String='');

    procedure ShowDemoFrm(FormID:integer;FormName:string='');
    Function  TreePopUpMenu(TreeID:string):TPopUpMenu;
    procedure TreeConfig(sender:Tobject);
    procedure changeUserDataBase(UserDbName:string);
    Procedure MergeGridUserMenuAndSysCongfigMenu(UserPopMenu,SysConfigMenu:tpopupMenu;GridUserMenuIDs:integer;UserMenuAction:TactionList);
    function  GetTableName(datasetID: string): string;
    function  GetFieldCaption(FieldID: string): string;

    function AddDataSet(Name,TAbleName,CommandText:string; NeedAppend:boolean=false;NeedDefault:boolean=false): string;
    function AddGrid(name,datasetID:string): string;
    function AddTreeGrid(name, GridID,EditorID,Actions: string;TreeID:integer):string;
    function AddSubInterFace(name, SubInterFaceID,ModelTypeID,TreeGridID,EditorID:string): string;

    procedure FmClose(Sender: TObject; var Action: TCloseAction); //zxh 08.2.27
    Procedure LogUserRecord(pdataset:Tdataset); overload;
    Procedure LogUserRecord(pdataset:Tdataset;  OperateType: string);  overload;
    function  GetUserTableName(pdataset: Tdataset):string;
    function  GetUserTableNameSelectClause(pdataset: Tdataset):string;
    function  GetMonthClsDate:Tdatetime;
    procedure showLogwindow(pdbgrid:Tdbgrid ) ;overload;
    procedure showLogwindow(PdataSet: Tdataset;BoxTop,BoxBtm:string );overload;
    function IsFieldShowed (FieldID, Boxid:string ):boolean;


    function  Validation (PdataSet: Tdataset;isBFP,isAFP,isBFD,isAFD,isBFChk,isBFUNchk:boolean): boolean;
  private



  end;



{ if fbilldict.pickid='' then exit;
  if fPickFrm=nil then
  begin
    Screen.Cursor:=crSqlwait;
    try
      fPickFrm:=TPickFrm.Create(Application);
      fPickFrm.InitFrm(fbilldict.pickid,dbGrid1,mtDataSet1);
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
  fPickFrm.Show;}

type
  TdmFrm = class(TDataModule)
    ADOConnection1: TADOConnection;
    ImageList1: TImageList;
    FreeStoredProc1: TADOStoredProc;
    OpenDialog1: TOpenDialog;
    DbGridPopupMenu1: TPopupMenu;
    dgPupSort: TMenuItem;
    N7: TMenuItem;
    dgPupRefresh: TMenuItem;
    dgPupDfWidth: TMenuItem;
    dgPupDfVis: TMenuItem;
    dgPupDfIdx: TMenuItem;
    N4: TMenuItem;
    dgPupProp: TMenuItem;
    dgPupVis: TMenuItem;
    N9: TMenuItem;
    dgPupPrtSet: TMenuItem;
    dgPupPreview: TMenuItem;
    dbCtrlActionList1: TActionList;
    DbGridEditBtnClickAction1: TAction;
    LookupFrmShowAction1: TAction;
    DateFrmShowAction1: TAction;
    TreeDlgFrmShowAction1: TAction;
    MessageShowAction1: TAction;
    FreeQuery1: TADOQuery;
    MemoFrmShowAction1: TAction;
    BoxPopupMenu1: TPopupMenu;
    N1: TMenuItem;
    FilteredPickerAction1: TAction;
    PickFrmShowAction1: TAction;
    DataSetActionList1: TActionList;
    RequireCheckAction1: TAction;
    AssignDefaultAction1: TAction;
    TestAction1: TAction;
    BeforeDeleteAction1: TAction;
    BeforePostAction1: TAction;
    AfterPostAction1: TAction;
    FreeDataSet1: TADODataSet;
    AOLastAction1: TAction;
    slInvGetFundAction1: TAction;
    NSave: TMenuItem;
    TabEditorShowAction1: TAction;
    TabGridShowAction1: TAction;
    ADOConnection2: TADOConnection;
    SaveDialog1: TSaveDialog;
    actUpdatePic: TAction;
    actLoadPic: TAction;
    dlgOpenPic1: TOpenPictureDialog;
    conSys: TADOConnection;
    qryFree_Sys: TADOQuery;
    actCheckRang: TAction;
    actCalc: TAction;
    actCaCul: TAction;
    actGetMaxBoxId: TAction;
    actlstsys: TActionList;
    actCheckUnique: TAction;
    actBatchCreateFields: TAction;
    actCreateCtrl: TAction;
    actCreateCols: TAction;
    actBatchDeleteFields: TAction;
    actClearCtrls: TAction;
    actGetMaxCode: TAction;
    actadddataset: TAction;
    actTreeGrid: TAction;
    TreeIDT507: TAction;
    actTreeIDS: TAction;
    actCRMTreeIDSGrid: TAction;
    actEditorT616: TAction;
    actCRMSubInterFace: TAction;
    actGridID: TAction;
    actTreeGridOpenParams: TAction;
    actEditorOpenParams: TAction;
    actT202: TAction;
    actBoxs: TAction;
    GridCols: TAction;
    actT102: TAction;
    actTabEdit: TAction;
    actMoreTOmoreT619: TAction;
    actCheckReference: TAction;
    actFieldOFsysTable: TAction;
    actFieldLKP: TAction;
    actGetFrmGridID: TAction;
    actGetSubSysGridColID: TAction;
    actListFrmActs: TAction;
    actListFrmModel: TAction;
    ActImages: TAction;
    NSelPrintFields: TMenuItem;
    ActUpdateBool: TAction;
    ActGetBoxCrmTreeIDs: TAction;
    ActGetMaxSubinterfaceID: TAction;
    ADOStoredProc2: TADOStoredProc;
    LstModelActtions: TAction;
    ActGridUserMenuID: TAction;
    ActLstDataActions: TAction;
    ActGridFontColor: TAction;
    ActGetPingYin: TAction;
    ActGetDocument: TAction;
    ActParamsT401: TAction;
    ActToolBtns: TAction;
    ActLkpImport: TAction;
    ActBillExActs: TAction;
    ExportExcel: TMenuItem;
    Qtemp: TADOQuery;
    UserDbCtrlActLst: TActionList;
    Action2: TAction;
    uLookupFrmShowAction1: TAction;
    uTreeDlgFrmShowAction1: TAction;
    uDateFrmShowAction1: TAction;
    uDbGridEditBtnClickAction1: TAction;
    uactCheckRang: TAction;
    uactCaCul: TAction;
    uActGetPingYin: TAction;
    actUloadpic: TAction;
    ActGetGUID: TAction;
    MPopupGridCoLRPT: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    //--------------dataset-----------------------
    function  ConnectServer(ConnStr:wideString):Boolean;
    procedure GetQuery1(fSql:wideString;fReturn:Boolean=True);
    function  ExecStoredProc(AProcName:String;AParams:Variant):Boolean;
    function  ExecStoredProc2(AProcName:String;AParams:Variant):Boolean;
    function  ExecSQL(pSQL:String;AParams:Variant):Boolean;    
    function  GetMyId(fTblId:String):String;
    //--------------[Db]Ctrl Actions--------------
    procedure qDoLkpBoxCloseUp(Sender:TObject);
    procedure LookupFrmShowAction1Execute(Sender: TObject);
    procedure DateFrmShowAction1Execute(Sender: TObject);
    procedure MessageShowAction1Execute(Sender: TObject);
    procedure TreeDlgFrmShowAction1Execute(Sender: TObject);

    //--------------DbGrid PorpupMenu-------------
    procedure dgPupDfWidthClick(Sender: TObject);
    procedure dgPupDfVisClick(Sender: TObject);
    procedure dgPupDfIdxClick(Sender: TObject);
    procedure dgPupPropClick(Sender: TObject);
    procedure dgPupVisClick(Sender: TObject);
    procedure dgPupPrtSetClick(Sender: TObject);
    procedure dgPupPreviewClick(Sender: TObject);
    procedure dgPupSortClick(Sender: TObject);
    procedure dgPupRefreshClick(Sender: TObject);
    procedure DbGridEditBtnClickAction1Execute(Sender: TObject);
    
    procedure FilteredPickerAction1Execute(Sender: TObject);

    procedure RequireCheckAction1Execute(Sender: TObject);
    procedure AssignDefaultAction1Execute(Sender: TObject);
    procedure BeforeDeleteAction1Execute(Sender: TObject);
    procedure BeforePostAction1Execute(Sender: TObject);
    procedure AfterPostAction1Execute(Sender: TObject);
    procedure SlInvCalcAction1Execute(Sender: TObject);
    procedure fnRecCalcAction1Execute(Sender: TObject);
    procedure fncaOpenAction1Execute(Sender: TObject);
    procedure AOLastAction1Execute(Sender: TObject);
    procedure slInvGetFundAction1Execute(Sender: TObject);
    procedure NSaveClick(Sender: TObject);


    procedure PhArvCalcAction1Execute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure  GetQry_Sys(ASql:wideString;AReturn:Boolean=True);

    procedure ConfigMenu;

    procedure actLoadPicExecute(Sender: TObject);
    procedure actInvoiceCalcExecute12(Sender: TObject);
    procedure actCheckRangExecute(Sender: TObject);
    procedure actCalcExecute(Sender: TObject);
    procedure actCaCulExecute(Sender: TObject);
    procedure actGetMaxBoxIdExecute(Sender: TObject);
    procedure actCheckUniqueExecute(Sender: TObject);
    procedure actBatchCreateFieldsExecute(Sender: TObject);
    procedure actBatchDeleteFieldsExecute(Sender: TObject);
    procedure actClearCtrlsExecute(Sender: TObject);
    procedure actGetMaxCodeExecute(Sender: TObject);
//    procedure actDataSetIDT201Execute(Sender: TObject);
    procedure actadddatasetExecute(Sender: TObject);
    procedure actTreeGridExecute(Sender: TObject);
    procedure TreeIDT507Execute(Sender: TObject);
    procedure actTreeIDSExecute(Sender: TObject);
    procedure actCRMTreeIDSGridExecute(Sender: TObject);
    procedure actEditorT616Execute(Sender: TObject);
    procedure actCRMSubInterFaceExecute(Sender: TObject);
    procedure actGridIDExecute(Sender: TObject);
    procedure actTreeGridOpenParamsExecute(Sender: TObject);
    procedure actEditorOpenParamsExecute(Sender: TObject);
    procedure actT202Execute(Sender: TObject);
    procedure actBoxsExecute(Sender: TObject);
    procedure GridColsExecute(Sender: TObject);
    procedure actT102Execute(Sender: TObject);
    procedure actTabEditExecute(Sender: TObject);
    procedure actMoreTOmoreT619Execute(Sender: TObject);
    procedure actCheckReferenceExecute(Sender: TObject);
    procedure actFieldOFsysTableExecute(Sender: TObject);
    procedure actFieldLKPExecute(Sender: TObject);

    procedure ConfigGrid(sender:Tobject);
    procedure ConfigGridRpt(sender:Tobject);
    procedure ConfigDatasetID(sender:Tobject);
    procedure ConfigBeforePost(sender:Tobject);
    procedure ConfigBeforeDelete(sender:Tobject);
    procedure ConfigAfterPost(sender:Tobject);
    procedure LstDataProcs(sender:Tobject);
    procedure ConfigFldGridLkp(sender:Tobject);
    procedure ConfigFldTreeDlgLkp(sender:Tobject);

    procedure ConfigCtrl(sender:Tobject);
    procedure ConfigLabel(sender:Tobject);
    procedure ConfigGetMaxBoxid(sender:Tobject);

    procedure actGetFrmGridIDExecute(Sender: TObject);
    procedure actGetSubSysGridColIDExecute(Sender: TObject);
    procedure actListFrmActsExecute(Sender: TObject);
    procedure actListFrmModelExecute(Sender: TObject);
    procedure ActImagesExecute(Sender: TObject);
    procedure NSelPrintFieldsClick(Sender: TObject);
    procedure ActUpdateBoolExecute(Sender: TObject);
    procedure ActGetBoxCrmTreeIDsExecute(Sender: TObject);
    procedure ActGetMaxSubinterfaceIDExecute(Sender: TObject);
    procedure LstModelActtionsExecute(Sender: TObject);
    procedure ActGridUserMenuIDExecute(Sender: TObject);

    Procedure PushGlobelContext(var PSysDb,PUserDB:string);
    Procedure PopGlobelContext(var PSysDb,PUserDB:string);
    procedure ActLstDataActionsExecute(Sender: TObject);
    procedure ActGridFontColorExecute(Sender: TObject);
    procedure ActGetPingYinExecute(Sender: TObject);
    procedure ActGetDocumentExecute(Sender: TObject);
    procedure ActParamsT401Execute(Sender: TObject);

    Procedure IniMainStateBar(PStatusbar:TStatusBar)  ;
    procedure ActToolBtnsExecute(Sender: TObject);
    procedure ActLkpImportExecute(Sender: TObject);
    procedure ActBillExActsExecute(Sender: TObject);
    procedure ActGetSprCodeExecute(Sender: TObject);
    procedure ExportExcelClick(Sender: TObject);
    procedure uLookupFrmShowAction1Execute(Sender: TObject);
    procedure uTreeDlgFrmShowAction1Execute(Sender: TObject);
    procedure uDateFrmShowAction1Execute(Sender: TObject);
    procedure uDbGridEditBtnClickAction1Execute(Sender: TObject);
    procedure uactCheckRangExecute(Sender: TObject);
    procedure uactCaCulExecute(Sender: TObject);
    procedure uActGetPingYinExecute(Sender: TObject);
    procedure actUloadpicExecute(Sender: TObject);
    procedure LocateCurrentMenu(MenuID:string);
    procedure ActGetGUIDExecute(Sender: TObject);
    procedure DbGridPopupMenu1Popup(Sender: TObject);
    procedure DbGridPopupMenu1Change(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);
    procedure ClearFilter(sender :Tobject);
 


  private

  public
      FMenuRitDict:TMenuRightDict;
    Procedure InstallBillDetial(ADODataset: TADODataset);overload;
    Procedure InstallBillDetial(F_InstallID:string );overload;

    Procedure RepaireBillDetial(F_RprApplyid:string );
  end;

resourceString

  fsDeleteObj = #13#10+'确定要删除"%s"吗?';
  fsDbDelete = #13#10+'确定要删除该记录吗?';
  fsDbChanged = #13#10+'部份数据可能已经被更改,是否需要保存?  ';
  fsDbCancel = #13#10+'确定要放弃所做的修改吗?      ';

const
       cversion = 2.04;

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

       cDsId01 = '538';
       cDsId02 = '539';
       cDsId03 = '492';
       cDsId04 = '463';

       cDgId01 = '355';
       cDgId02 = '352';
       cDgId03 = '421';

       PZero=0.000000001;      //浮点零

var
  sOpenParamsVar:Variant;
  sDefaultVals:wideString;
  dmFrm: TdmFrm;
  FhlKnl1: TFhlKnl;
  LoginInfo:TLoginInfo;        //全局登录信息
  FhlUser:TFhlUser;

implementation
uses sort,Lookup,finder,    repgrid,colshower,colProp,TreeDlg, UnitBillEx,   EditorSystool ,
  More2More,Editor,TreeEditor,TreeGrid,TreeMgr  ,Desktop, TreeGridSystool,
  UnitDemo,         UnitFrmAnalyserEx ,  main,UnitLookUpImport, UnitBillVoucher    ;

{$R *.DFM}
procedure TdmFrm.GetQuery1(fSql:wideString;fReturn:Boolean=True);
begin
 with FreeQuery1 do begin
      Close;
      Sql.Clear;
      Sql.Append(fSql);
      if fReturn then
         Open
      else
         ExecSql;

 end;
end;

procedure TdmFrm.DbGridEditBtnClickAction1Execute(Sender: TObject);
begin

  with DbCtrlActionList1.Actions[FhlKnl1.Dg_GetDbGrdEdtActnId(TDbGrid(Sender))] do
  begin
      ActionComponent:=TComponent(Sender);
      Execute;
  end;

end;

function TdmFrm.ExecSQL(pSQL:String;AParams:Variant):Boolean;
var i,Cnt:integer;
begin
  Result:=pSQL='';
  if Result then exit;
  with qryFree_Sys do
  begin
    Close;
    Parameters.Clear ;
    sql.Text :=pSQL;
    qryFree_Sys.Prepared :=true;

    Cnt:= 2;//  varArrayHighBound( AParams,1)-1 ;

    for i:=0 to Cnt-1  do
    begin
      //  qryFree_Sys.Parameters.AddParameter ;
    end;

    FhlKnl1.Ds_SetParams(qryFree_Sys,AParams);
    qryFree_Sys.ExecSQL ;
  end;
end;

function TdmFrm.ExecStoredProc(AProcName:String;AParams:Variant):Boolean;
var worningstr:string;
begin
  try
      Result:=AProcName='';
      if Result then exit;
      with FreeStoredProc1 do
      begin
        Close;
        ProcedureName:=AProcName;
        FhlKnl1.Ds_SetParams(FreeStoredProc1,AParams);
        ExecProc;

        if   Parameters.Items[0].Value<>null then
        Result:=boolean(Parameters.Items[0].Value);

        if   not Result then
          if Parameters.count>1 then
            if (Parameters.Items[1].Value<>null)and  (trim(Parameters.Items[1].Value)<>'')  then
              if  (Parameters.Items[1].Direction= pdOutput )   then
               showmessage( Parameters.Items[1].Value);

        if Parameters.count>2 then    //2010-8-8 单据审核加揭示信息
          if (Parameters.Items[2].Value<>null)and  (trim(Parameters.Items[2].Value)<>'')  then
            if  (Parameters.Items[2].Direction= pdOutput )   then
            begin
             worningstr  := Parameters.Items[2].Value ;
             showmessage( worningstr);
            end;
      end;
  except
     on err :exception do
      begin
          showmessage(err.Message );
          exit;
      end  ;
  end

end;
function TdmFrm.ExecStoredProc2(AProcName:String;AParams:Variant):Boolean;
var adoDast :Tadodataset;
begin
  try
      Result:=AProcName='';
      if Result then exit;
      with ADOStoredProc2 do
      begin
        Close;
        ProcedureName:=AProcName;
        FhlKnl1.Ds_SetParams(ADOStoredProc2,AParams);
        ExecProc;
        if   Parameters.Items[0].Value<>null then
        Result:=boolean(Parameters.Items[0].Value);
      end;
  except
     on err :exception do
      begin
          showmessage(err.Message );
          exit;
      end  ;
  end
end;


function  TdmFrm.ConnectServer(ConnStr:wideString):Boolean;
begin
//initialization
//  CoInitialize(nil);
   Result:=False;
 //  FhlKnl1.Kl_SetReg4Mssql(ConnStr);        //   改  数据     库端口

   if FhlKnl1.Kl_Connect(ConnStr) then
     with ADOConnection1 do
     begin
       Connected:=False;
       ConnectionString:=ConnStr;
       try
         Connected:=true;
         Result:=Connected;
       except
       begin
         Result:=False;
       end;
       end;
     end;
end;      

function TdmFrm.GetMyId(fTblid:String):String;
var sql:string;
var pre:string;
begin
  Result:='';
//  FreeQuery1.Connection.BeginTrans;
  try
   sql:='select pre+replace(space(xlen-len(pos)),'' '',0)+cast(pos as varchar) ,pre,pos from  sys_id where tblid='+ftblid;
   GetQuery1(sql);
   pre:= FreeQuery1.Fieldbyname('pre').asString ;
   if uppercase(pre)<>'EMPTY' THEN
   Result:=FreeQuery1.Fields[0].asString
   ELSE
   Result:=FreeQuery1.Fieldbyname('pos').asString  ;

   GetQuery1('update  sys_id set pos=pos+1 where tblid='+ftblid,False);
  // FreeQuery1.Connection.CommitTrans;
  except
 //  FreeQuery1.Connection.RollbackTrans;
  end;
end;



procedure TdmFrm.qDoLkpBoxCloseUp(Sender:TObject);
begin
  //showmessage('c');
end;
//---------------DbGrid PopupMenu---------------
procedure TdmFrm.dgPupDfWidthClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
  FhlKnl1.Dg_SetColWidth(PopDbgrid);
  //FhlKnl1.Dg_SetColWidth(TDbGrid(DbGridPopupMenu1.PopupComponent));
end;

procedure TdmFrm.dgPupDfVisClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
  FhlKnl1.Dg_SetColVisible(PopDbgrid);
  //  FhlKnl1.Dg_SetColVisible(TDbGrid(DbGridPopupMenu1.PopupComponent));
end;

procedure TdmFrm.dgPupDfIdxClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
  FhlKnl1.Dg_SetColOrder(PopDbgrid);
  //FhlKnl1.Dg_SetColOrder(TDbGrid(DbGridPopupMenu1.PopupComponent));
end;

procedure TdmFrm.dgPupPropClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
  FhlKnl1.Dg_ColsProp(PopDbgrid);
//intTostr(TDbGrid(DbGridPopupMenu1.PopupComponent).Tag)
end;

procedure TdmFrm.dgPupVisClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  with TColShowerFrm.Create(Application) do begin
       InitFrm( PopDbgrid)   ;
       ShowModal;
       Free;
  end;
end;

procedure TdmFrm.dgPupPrtSetClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
{
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;


  with TRepSetFrm.Create(Application) do
  begin
    AdoDataSet1.Connection:=FhlKnl1.Connection;
    InitFrm(intTostr(PopDbgrid.Tag));
    ShowModal;
    Free;
  end;       }
end;

procedure TdmFrm.dgPupPreviewClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
 PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
 
  if not PopDbgrid.DataSource.DataSet.IsEmpty then
  begin
      PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
      FhlKnl1.Rp_DbGrid(intTostr(PopDbgrid.Tag),PopDbgrid);
  end;

end;

procedure TdmFrm.DgPupSortClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  FhlKnl1.Dg_Sort(PopDbgrid,true);
end;

procedure TdmFrm.DgPupRefreshClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
var Dataset1:TDataset;
var i:integer;
begin
    
    if Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent  is    Tdbgrid     then
    begin
      PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
      if PopDbgrid.DataSource=nil then exit;
      Dataset1  :=PopDbgrid.DataSource.DataSet
    end;

    if Sender  is    Tdataset   then
       Dataset1:=Tdataset( Sender )   ;

      for i:=0 to Dataset1.FieldCount -1 do
      if (Dataset1.Fields[i].FieldKind  = fkLookup ) then
      begin
          Dataset1.Fields[i].LookupDataSet.Close;
          Dataset1.Fields[i].LookupDataSet.Open ;
      end;
      with Dataset1 do begin
           Close;
           Open;
      end;

end;
//-----------------Interface----------------------


procedure TdmFrm.LookupFrmShowAction1Execute(Sender: TObject);
var fld:TField;
    TmpLookupFrm:TLookupFrm;
begin
  TmpLookupFrm:=nil;
  Screen.Cursor:=crSqlwait;
 try
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;
  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
     if (Sender is TFhlDbEdit) then
     TmpLookupFrm:=  ((Sender as TFhlDbEdit).LookupFrm as TLookupFrm) ;

     if TmpLookupFrm=nil then
     begin
       TmpLookupFrm:= TLookupFrm.Create(sender as TComponent)  ;
       TmpLookupFrm.InitFrm(fld);
       if (Sender is TFhlDbEdit) then
          (Sender as TFhlDbEdit).LookupFrm:=TmpLookupFrm;
     end  ;
     if Sender is tdbedit  then
        TmpLookupFrm.Edit1.Text:=(Sender as tdbedit   ).Text ;
     TmpLookupFrm.ShowModal;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;

 if Sender is Tedit then
 TEdit(Sender).Modified:=False;
end;

procedure TdmFrm.DateFrmShowAction1Execute(Sender: TObject);
var
  fld:TField;
  dt:TDateTime;
  isNull:boolean;
begin
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;
  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
    if fld.asString<>'' then
      dt:=fld.asDateTime
    else
      dt:=Now;
        if FhlKnl1.Md_ShowDateFrm(dt,isNull)=mrOk then
        begin
          if not (fld.DataSet.State=dsInsert) and Not (fld.DataSet.State=dsEdit) then
             fld.DataSet.Edit;
          if  isNull then
          begin
              fld.Value :=null;
          end
          else
          begin
              if fld.DataType=ftDate then
                 fld.asString:=formatdatetime('yyyy"-"mm"-"dd',dt)
              else if fld.DataType=ftDateTime then
                 fld.AsString:=formatdatetime('yyyy"-"mm"-"dd',dt)+' '+formatdatetime('hh":"nn":"ss',Now);
          end;
        end;
  end;
end;

procedure TdmFrm.MessageShowAction1Execute(Sender: TObject);
begin
  showmessage(':0)');
end;

procedure TdmFrm.TreeDlgFrmShowAction1Execute(Sender: TObject);
 var fld:TField; 
begin
 Screen.Cursor:=crSqlwait;
 try
       if Sender is TAction then
          fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
       else
          fld:=TDbEdit(Sender).Field;


       if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
       begin
           with TTreeDlgFrm.Create(Application) do
           begin
             InitFrm(fld);
             ShowModal;
             free;
           end;
       end;
 finally
      Screen.Cursor:=crDefault;
 end;
end;





procedure TdmFrm.FilteredPickerAction1Execute(Sender: TObject);
begin
  if TEdit(Sender).Modified then
  begin
    TEdit(Sender).Modified:=False;
    dmFrm.LookupFrmShowAction1Execute(Sender);
  end;
end;



procedure TdmFrm.RequireCheckAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_RequireCheck(TDataSet(Sender));
end;


procedure TdmFrm.AssignDefaultAction1Execute(Sender: TObject);
 var i:integer;r:variant;
begin

  with TDataSet(Sender) do
      for i:=0 to FieldCount-1 do
      begin
        r:=FhlUser.GetSysParamVal(Fields[i].DefaultExpression);
        if Not VarIsNull(r) then
          Fields[i].Value:=trim(string(r));
      end;
end;


procedure TdmFrm.BeforeDeleteAction1Execute(Sender: TObject);
var
  fDict:TBeforeDeleteDict;
  fDataSet:TDataSet;
//  AbortStr:string;

begin
      fDataSet:=TDataSet(Sender);
      self.actCheckReference.OnExecute (fDataSet);

      if fDict.Hint<>'' then
      begin
        if MessageDlg(fdict.Hint ,mtConfirmation,[mbYes,mbNo ],0)  <>mrYes then
        Abort;
      end
      else
        if MessageDlg('确定删除？' ,mtConfirmation,[mbYes,mbNo ],0)  <>mrYes then
           Abort;

      if (TADODataSet(fdataset).LockType=ltOptimistic )then  //2010-6-18
         FhlUser.LogUserRecord(fDataSet );

      if Not FhlKnl1.Cf_GetDict_BeforeDelete(intTostr(fDataSet.Tag),fdict) then
      begin
        exit;
      end;

      FhlUser.CheckRight(fDict.DelRitId);

      if fDict.Proc<>'' then
      begin
          if Not dmFrm.ExecStoredProc(fDict.Proc,FhlKnl1.Vr_MergeVarArray(  FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.EdtUsrParams) ,FhlUser.GetSysParamsVal(fDict.EdtSysParams) )) then
          begin
              with dmFrm.FreeStoredProc1 do
              begin
                if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) then
                  fDict.ErrorHint:=Parameters.Items[1].Value;
              end;
              if  fDict.ErrorHint<>'' then
              begin
                  MessageDlg(#13#10+fDict.ErrorHint,mtError,[mbOk],0);
                  Abort;
              end;
          end;
       end;
       FhlUser.LogUserRecord(fDataSet );



end;

procedure TdmFrm.BeforePostAction1Execute(Sender: TObject);
var
  fDict:TBeforePostDict;
  fDataSet:TDataSet;
begin
  fDataSet:=TDataSet(Sender);
  //Require
  RequireCheckAction1Execute(fDataSet);

    if (fdataset.State =dsedit ) and (TADODataSet(fdataset).LockType=ltOptimistic )  then  //2010-6-18   2010-8-12 单据日志无法记录
       FhlUser.LogUserRecord(fDataSet );

    if Not FhlKnl1.Cf_GetDict_BeforePost(intTostr(fDataSet.Tag),fdict) then
    begin 
       exit;
    end;
    if (fDataSet.State=dsInsert) and (fDict.AutoKeyId<>'') then
       fDataSet.FieldByName(fDict.AutoKeyFld).AsString:=dmFrm.GetMyId(fDict.AutoKeyId);

    if fDataSet.State=dsInsert then
      FhlUser.CheckRight(fDict.AddRitId)
    else
      FhlUser.CheckRight(fDict.EditRitId);
    if fDict.EdtProc<>'' then
    if fDict.CmdType =1 then
    begin
        //Proc
        dmFrm.FreeStoredProc1.Parameters.Items[1].Size :=200;
        if Not dmFrm.ExecStoredProc(fDict.EdtProc,FhlKnl1.Vr_MergeVarArray( FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.EdtUsrParams) ,FhlUser.GetSysParamsVal(fDict.EdtSysParams) )) then
        begin
            with dmFrm.FreeStoredProc1 do
            begin
                fDict.AbortStr:=Parameters.Items[1].Value;
                if  Parameters.Items[2].Value<>null then
                fDict.WarningStr:=Parameters.Items[2].Value;
            end;
            if fDict.AbortStr<>'' then
            begin
              MessageDlg(#13#10+fDict.AbortStr,mtError,[mbOk],0);
              Abort;
            end   ;
            if  fDict.WarningStr<>'' then
              if MessageDlg(#13#10+fDict.WarningStr,mtWarning,[mbOk,mbCancel],0)<>mrOk then
               Abort;
        end;
        if (fDict.SameValFlds<>'') and (Not FhlKnl1.Vr_VarHaveSameVal(FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.SameValFlds))) then
        begin
            MessageDlg(#13#10+fDict.SameValHint,mtWarning,[mbOk],0);
            Abort;
        end;

        if (fDict.PostHint<>'') and (MessageDlg(#13#10+FhlKnl1.Vr_ReplaceByVarArray(fDict.PostHint,'%s',FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.PostSysParams),FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.PostUsrParams))),mtInformation,[mbOk,mbCancel],0)<>mrOk) then
          Abort;

    end
    else
    begin
         dmFrm.ExecSQL(fDict.EdtProc ,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.EdtSysParams),FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.EdtUsrParams)))

    end;



end;

procedure TdmFrm.AfterPostAction1Execute(Sender: TObject);
var
  fDataSet:TDataSet;
  fDict:TAfterPostDict;

    AbortStr,WarningStr:string;
begin
    fDataSet:=TDataSet(Sender);
  if Not FhlKnl1.Cf_GetDict_AfterPost(intTostr(fDataSet.Tag),fdict) then exit;
     if not   dmFrm.ExecStoredProc(fDict.fProc,FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.fDataParamFlds) ,FhlUser.GetSysParamsVal(fDict.fSysParams) )) then
      begin

        if dmFrm.FreeStoredProc1.Parameters.Items[1].Value<>null then
              AbortStr:=dmFrm.FreeStoredProc1.Parameters.Items[1].Value
          else
              AbortStr:='';
          if dmFrm.FreeStoredProc1.Parameters.Items[2].Value<>null then
              WarningStr:=dmFrm.FreeStoredProc1.Parameters.Items[2].Value
          else
              WarningStr:='';    {   }
              
        MessageDlg(#13#10+fDict.fErrorHint+AbortStr+WarningStr,mtError,[mbOk],0);
        abort;
      end;
       
end;


procedure TdmFrm.SlInvCalcAction1Execute(Sender: TObject);
begin




  with TDataSet(Sender) do
  begin

    FieldByName('TotalFund').AsCurrency:=FieldByName('WareFund').AsCurrency+FieldByName('OtherFund').AsCurrency;
    FieldByName('RemainFund').AsCurrency:=FieldByName('GetFund').asCurrency-FieldByName('PayFund').asCurrency;
    FieldByName('RemainBig').AsString:=FhlKnl1.St_GetBigMoney(FieldByName('RemainFund').AsCurrency);
  end;
end;

procedure TdmFrm.fnRecCalcAction1Execute(Sender: TObject);
begin
  with TDataSet(Sender) do
  begin
    FieldByName('xBigFund').AsString:=FhlKnl1.St_GetBigMoney(FieldByName('PayFund').asCurrency);
  end;
end;

procedure TdmFrm.fncaOpenAction1Execute(Sender: TObject);
var
  fRemain,fInQty,fOutQty:Double;
begin
  with TDataSet(Sender) do
  begin
    DisableControls;
    Last;
    fRemain:=FieldByName('RmnQty').asFloat;
    Prior;
      if FieldByName('IsCalc').AsInteger=1 then
      begin
        Edit;
        FieldByName('RmnQty').asFloat:=fRemain;
        Post;
      end;
    fInQty:=FieldByName('InQty').asFloat;
    fOutQty:=FieldByName('OutQty').asFloat;
    Prior;
    while not bof do
    begin
      fRemain:=fRemain-fInQty+fOutQty;
      fInQty:=FieldByName('InQty').asFloat;
      fOutQty:=FieldByName('OutQty').asFloat;
      if FieldByName('IsCalc').AsInteger=1 then
      begin
        Edit;
        FieldByName('RmnQty').asFloat:=fRemain;
        Post;
      end;
      Prior;
    end;
    EnableControls;
  end;
end;

procedure TdmFrm.AOLastAction1Execute(Sender: TObject);
begin
  TDataSet(Sender).Last;
end;

procedure TdmFrm.slInvGetFundAction1Execute(Sender: TObject);
begin
  with TDbEdit(Sender) do
  begin
    DataSource.DataSet.Edit;
    DataSource.DataSet.FieldByName(DataField).AsCurrency:=FhlKnl1.Ds_Calc(DataSource.DataSet,'WareFund+OtherFund');
  end;
end;

procedure TdmFrm.NSaveClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  if not logininfo.isAdmin then
  begin
      showmessage('只有管理员才可以保存设置');
      exit;
  end;
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
  FhlKnl1.Dg_SetColStyle(PopDbgrid);

  //FhlKnl1.Dg_SetColStyle(TDbGrid(DbGridPopupMenu1.PopupComponent));
end;





procedure TdmFrm.PhArvCalcAction1Execute(Sender: TObject);
begin
  with TDataSet(Sender) do
  begin
    FieldByName('TaxFund').AsCurrency:=FieldByName('WareFund').AsCurrency*FieldByName('TaxRate').AsFloat;
  end;
end;



procedure TdmFrm.DataModuleCreate(Sender: TObject);
begin
  FhlKnl1:=TFhlKnl.Create(dmFrm);
  qryFree_Sys.Connection :=fhlknl1.Connection ;
  conSys.ConnectionString :=self.ADOConnection1.ConnectionString ;


end;
procedure  TdmFrm.GetQry_Sys(ASql:wideString;AReturn:Boolean=True);
begin
  with qryFree_Sys do
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
procedure TdmFrm.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FhlKnl1);
end;

procedure TdmFrm.ConfigMenu;
begin
                {
     self.GetQry_Sys  ('select * from TMenuRits');

    with  self.qryFree_Sys  do
    begin
      FMenuRitDict.ColVisiableRitID:=FieldByName('ColVisiableRitID').asString;
      FMenuRitDict.ColOrderRitID :=  FieldByName('ColOrderRitID').asString;
    end;

   self.qryFree_Sys.Close;
   if logininfo.Sys then
       self.dgPupVis.Visible:=true
   else
       self.dgPupVis.Visible  := FhlUser.CheckRight2(FMenuRitDict.ColVisiableRitID );

                 }
   if logininfo.isAdmin then
     begin
        NSelPrintFields.Visible :=true;
        ExportExcel.Visible:=true;   //zxh 08.2.18
     end
   else
       ExportExcel.Visible:=false;   //zxh 08.2.18

 
end;



procedure TdmFrm.actLoadPicExecute(Sender: TObject);
begin
if dlgOpenPic1.Execute then
    if     dlgOpenPic1.FileName <>'' then
    BEGIN
      if (Sender is TdbImage )  then
         (Sender as TdbImage).Picture.LoadFromFile(dlgOpenPic1.FileName );
    END;
end;

procedure TdmFrm.actInvoiceCalcExecute12(Sender: TObject);
begin
//2006-7-26 以后将这东西放数据库去
  with TDataSet(Sender) do
  begin
    FieldByName('DiffAmt').AsCurrency :=FieldByName('InvFund').asCurrency-FieldByName('WareFund').asCurrency;
  end;
end;

procedure TdmFrm.actCheckRangExecute(Sender: TObject);
var fld:   TField;
   msg:string;
begin
    if (sender is TDbEdit) then
    begin
          fld:=TDbEdit(Sender).Field;
          if (fld is TfloatField) or (fld is TCurrencyField) then
          begin
              if  strtofloat ((sender as TDbEdit).Text)<TfloatField(fld  ).MinValue then
              begin
                   msg:=fld.FieldName +'不能小于'  +floattostr(TfloatField(fld  ).MinValue);
              end;
              if  strtofloat ((sender as TDbEdit).Text)>TfloatField(fld  ).MaxValue then
              begin
                  msg:=fld.FieldName +'不能大于'  +floattostr(TfloatField(fld  ).MaxValue);
              end;
          end;
          if (fld is TintegerField) then
          begin
              if  strtoint ((sender as TDbEdit).Text)<TintegerField(fld  ).MinValue then
              begin
                   msg:=fld.FieldName +'不能小于'  +inttostr(TintegerField(fld  ).MinValue);
              end;
              if  strtoint ((sender as TDbEdit).Text)>TintegerField(fld  ).MaxValue then
              begin
                  msg:=fld.FieldName +'不能大于'  +inttostr(TintegerField(fld  ).MaxValue);
              end;
          end;

    end;


end;

procedure TdmFrm.actCalcExecute(Sender: TObject);
var Fields,formula:Tstringlist;
var ResultField,Calc,fieldValue:string;
var I,J:integer;
var  vScript: Variant;
var Presult:double;
begin
//a:=(b+c)*d/f+g*h

  Fields:=Tstringlist.Create ;
  formula:=Tstringlist.Create ;
  formula.NameValueSeparator :='=';
  vScript := CreateOleObject('ScriptControl');
  vScript.Language := 'JavaScript';


 // fhlknl1.Kl_GetQuery2('select* from T202 where  f02='+ inttostr(Tadodataset(sender).Tag )+'   and f08<>'+ quotedstr('') +'  and f09<>'+quotedstr('')   );

 // if    not fhlknl1.FreeQuery.IsEmpty then
  for i:=0 to Tadodataset(sender).FieldCount -1 do
  begin

        if (Tadodataset(sender).Fields[i] is Tfloatfield ) or (Tadodataset(sender).Fields[i] is Tintegerfield)or (Tadodataset(sender).Fields[i] is Tstringfield ) then
        begin
                  Fields.Clear ;
                  formula.Clear;
                  formula.NameValueSeparator :='=';
                  if  Tadodataset(sender).Fields[i] is Tfloatfield then
                  begin
                    Fields.CommaText :=TFloatFieldEx(Tadodataset(sender).Fields[i]).CalField;// fhlknl1.FreeQuery.FieldByName('F09').asString;
                    formula.CommaText :=TFloatFieldEx(Tadodataset(sender).Fields[i]).formula ;// string(fhlknl1.FreeQuery.FieldByName('F08').asString);
                  end;
                  if Tadodataset(sender).Fields[i] is TIntegerField    then
                  begin
                    Fields.CommaText :=TIntegerFieldEx(Tadodataset(sender).Fields[i]).CalField;// fhlknl1.FreeQuery.FieldByName('F09').asString;
                    formula.CommaText :=TIntegerFieldEx(Tadodataset(sender).Fields[i]).formula ;// string(fhlknl1.FreeQuery.FieldByName('F08').asString);
                  end;
                  if Tadodataset(sender).Fields[i] is TstringFieldEx    then
                  begin
                    Fields.CommaText :=TstringFieldEx(Tadodataset(sender).Fields[i]).CalField;// fhlknl1.FreeQuery.FieldByName('F09').asString;
                    formula.CommaText :=TstringFieldEx(Tadodataset(sender).Fields[i]).formula ;// string(fhlknl1.FreeQuery.FieldByName('F08').asString);
                  end;

                  if (Fields.CommaText='' ) or (formula.CommaText='' ) then continue;
                  ResultField:=   formula.Names [0] ;
                  Calc:=formula.values[ResultField] ;

                  if (Tadodataset(sender).Fieldbyname(ResultField) is Tfloatfield ) or (Tadodataset(sender).Fieldbyname(ResultField) is Tintegerfield) then
                  begin
                      for J:=0 to   Fields.Count -1 do
                      begin
                             if Tadodataset(sender).Fieldbyname(Fields[j]).AsString <>'' then
                             begin
                                 if (Tadodataset(sender).Fieldbyname(Fields[j])  is Tfloatfield) or (Tadodataset(sender).Fieldbyname(Fields[j])  is Tintegerfield) then
                                 begin
                                     if Tadodataset(sender).Fieldbyname(Fields[j]).AsFloat <0 then        //2010-3-27 去掉负数加括号
                                       if pos('?', Calc)<>-1 then                                         //不能加负号 FPAmt=(("FAmt".match("-"))?0:Math.abs(FAmt))
                                         FieldValue:='('+ Tadodataset(sender).Fieldbyname(Fields[j]).AsString +')'
                                       else
                                         FieldValue:=Tadodataset(sender).Fieldbyname(Fields[j]).AsString
                                     else
                                        FieldValue:= Tadodataset(sender).Fieldbyname(Fields[j]).AsString ;
                                 end
                                 else
                                    FieldValue:= Tadodataset(sender).Fieldbyname(Fields[j]).AsString ;
                             end
                             else
                                FieldValue:='' ;

                           if   FieldValue='' then FieldValue:='0';
                          Calc:= stringreplace(trim(Calc),trim(Fields[j]),trim(FieldValue ),[rfIgnoreCase ]);
                      end;
                      Presult   := vScript.Eval(Calc); 
                      Tadodataset(sender).FieldByName(ResultField).AsCurrency := Presult;
                 end ;
                 if (Tadodataset(sender).Fieldbyname(ResultField) is Tstringfield ) then
                 begin
                    Calc:= stringreplace(trim(Calc),trim(Fields[j]),trim(Tadodataset(sender).FieldByName(Fields[j]).AsString    ),[rfIgnoreCase ]);
                    Tadodataset(sender).FieldByName(ResultField).AsString  := Calc;
                 end;

                 
        end;
  end;



end;

procedure TdmFrm.actCaCulExecute(Sender: TObject);
Var fld:Tfield;

//=============
var Fields,formula:Tstringlist;
var ResultField,Calc,fieldValue:string;
var I,J:integer;
var  vScript: Variant;
var Presult:double;

begin


  fld:=TDbEdit(Sender).Field ;
if     fld.Text='' then
exit;
//a:=(b+c)*d/f+g*h

  Fields:=Tstringlist.Create ;
  formula:=Tstringlist.Create ;
  formula.NameValueSeparator :='=';
  vScript := CreateOleObject('ScriptControl');
  vScript.Language := 'JavaScript';


   fhlknl1.Kl_GetQuery2('select * From T202 where f08<>'' and f09<>'' and  f02 ='+inttostr(fld.DataSet.Tag ));

  if    not fhlknl1.FreeQuery.IsEmpty then
  begin
        for i:=0 to fhlknl1.FreeQuery.RecordCount -1 do
        begin
                Fields.Clear ;
                formula.Clear;
                formula.NameValueSeparator :='=';
                Fields.CommaText := fhlknl1.FreeQuery.FieldByName('F09').asString;
                formula.CommaText := string(fhlknl1.FreeQuery.FieldByName('F08').asString);
                ResultField:=   formula.Names [0] ;
                Calc:=formula.values[ResultField] ;

                for J:=0 to   Fields.Count -1 do
                begin
                     if fld.DataSet.Fieldbyname(Fields[j]).AsFloat <0 then
                        FieldValue:='('+ Tadodataset(fld.DataSet).Fieldbyname(Fields[j]).AsString +')'
                     else
                        FieldValue:= Tadodataset(fld.DataSet).Fieldbyname(Fields[j]).AsString ;
                     if   FieldValue='' then FieldValue:='0';
                    Calc:= stringreplace(trim(Calc),trim(Fields[j]),trim(FieldValue ),[rfIgnoreCase ]);
                end;
                Presult   := vScript.Eval(Calc);
               Tadodataset(fld.DataSet).FieldByName(ResultField).AsCurrency := Presult;
               fhlknl1.FreeQuery.Next ;
        end;
  end;



end;




procedure TdmFrm.actGetMaxBoxIdExecute(Sender: TObject);
//var     fieldname:string;

var BoxPopMenu:Tpopupmenu;
var CtrlMenu,LabelMenu,GetMaxBoxIDMenu:Tmenuitem;

begin
    BoxPopMenu:=Tpopupmenu.Create (self);

    CtrlMenu:=Tmenuitem.Create (BoxPopMenu)  ;
    CtrlMenu.Caption :='CtrlMenu';
    CtrlMenu.OnClick :=self.ConfigCtrl  ;//(Sender);

    LabelMenu:=Tmenuitem.Create (BoxPopMenu)  ;
    LabelMenu.Caption :='LabelMenu';
    LabelMenu.OnClick :=self.ConfigLabel  ;//(Sender);

    GetMaxBoxIDMenu:=Tmenuitem.Create (BoxPopMenu)  ;
    GetMaxBoxIDMenu.Caption :='boxidMenu';
    GetMaxBoxIDMenu.OnClick :=self.ConfigGetMaxBoxid ;//(Sender);

    BoxPopMenu.Items.Add(CtrlMenu);
    BoxPopMenu.Items.Add(LabelMenu);
    BoxPopMenu.Items.Add(GetMaxBoxIDMenu);

    if (Sender is tdbedit) then
    Tdbedit(Sender).PopupMenu := BoxPopMenu;

    if(Sender is tdbmemo) then
    tdbmemo(Sender).PopupMenu := BoxPopMenu;


    if Sender is Taction then
    Tdbedit(Taction (sender).ActionComponent).PopupMenu := BoxPopMenu;

    if Sender is Taction then
    tdbmemo(Taction (sender).ActionComponent).PopupMenu := BoxPopMenu;





end;

procedure TdmFrm.actCheckUniqueExecute(Sender: TObject);
//var sql,tableName,fieldname:string;

begin

//if fhlknl1.Ds_DuplicatedCheck ((sender As Tdbedit).Field, (sender as Tdbedit).Text)  then
begin
//      showmessage( (sender as Tdbedit).Text+'   已经存在，请更改!');
end;
   { if   (sender As Tdbedit).Field.DataSet.State in [dsinsert,dsedit] then
     begin
              fieldname:=(sender As Tdbedit).Field.FieldName  ;
              if (sender is Tdbedit) then
              begin
                   fhlknl1.Kl_GetQuery2 ('select F16 from T201 where F01='+inttostr((sender As Tdbedit).Field.DataSet.Tag  ));

                   if not fhlknl1.FreeQuery.IsEmpty then
                   begin
                     tablename:= fhlknl1.FreeQuery.FieldByName('F16').AsString ;

                      if   tablename='' then
                      begin
                           showmessage(  'T201  表不存在');
                           exit ;
                      end
                      else
                      begin
                           sql:='select 1 From '+tablename+' where '+fieldname+'=' +quotedstr((sender as Tdbedit).Text) +'  and F_ID<>'+inttostr((sender As Tdbedit).Field.DataSet.fieldbyname('F_ID').AsInteger );
                           dmfrm.GetQuery1(sql);
                           if not dmfrm.FreeQuery1.IsEmpty then
                           begin
                              showmessage( (sender as Tdbedit).Text+'   已经存在，请更改!');
                           end;
                      end;
                   end;
              end;
     end
     else
     exit;
     }
end;


procedure TdmFrm.actBatchCreateFieldsExecute(Sender: TObject);
var I:integer;
sql,  FieldCname,FieldTypeID ,FieldEname ,fieldlength ,DefaultValueInSys :string;

nullable,Isunique:boolean;

var qryT102,qryT202:Tadoquery;

begin

    qryT102:=Tadoquery.Create (nil);
    qryT202:=Tadoquery.Create (nil);
    qryT102.Connection :=fhlknl1.Connection ;
    qryT202.Connection:=fhlknl1.Connection ;

    qryT102.SQL.Add('select * from T102 where 1<>1');
    qryT202.SQL.Add('select * from T202 where 1<>1');


    qryT102.Open ;
    qryT202.Open ;

    sql:='select * From V_AllTablesAndFields A join  T201 B on A.TableEname=B.f16 where B.f01='+inttostr(Tdataset(sender).Tag );


      for i:=0 to fhlknl1.FreeQuery.RecordCount-1 do
      begin
          FieldEname  := fhlknl1.FreeQuery.fieldbyname ('FieldEname').AsString ;
          FieldCname  := fhlknl1.FreeQuery.fieldbyname ('FieldCname').AsString   ;
          FieldTypeID := fhlknl1.FreeQuery.fieldbyname ('FieldTypeID').AsString   ;
          fieldlength := fhlknl1.FreeQuery.fieldbyname ('fieldlength').AsString   ;
          DefaultValueInSys:= fhlknl1.FreeQuery.fieldbyname ('DefaultValueInSys').AsString   ;
          nullable:= fhlknl1.FreeQuery.fieldbyname ('nullable').AsBoolean    ;
          Isunique:= fhlknl1.FreeQuery.fieldbyname ('Isunique').AsBoolean    ;

          qryT102.Append ;
          qryT102.FieldByName('f02').AsString :=   trim(FieldEname )  ;
          qryT102.FieldByName('f04').AsString :=   trim(FieldTypeID )  ;
          qryT102.FieldByName('f09').AsString :=   trim(FieldCname )    ;
          if  fieldlength<>'' then
          qryT102.FieldByName('f06').AsString :=fieldlength;


          qryT102.post;

          qryT202.Append ;
          qryT202.FieldByName('f02').AsString  :=inttostr(Tdataset(sender).Tag );
          qryT202.FieldByName('f03').AsString  :=qryT102.FieldByName('f01').AsString;
          qryT202.FieldByName('f04').AsString  :=DefaultValueInSys;
          qryT202.FieldByName('f05').AsBoolean :=not nullable;
          qryT202.FieldByName('f10').AsBoolean   :=Isunique;
          qryT202.Post ;


          fhlknl1.FreeQuery.Next ;
      end;



end;


procedure TdmFrm.actBatchDeleteFieldsExecute(Sender: TObject);
begin
if MessageBox(0, '确定删除所有字段以及引用吗？', '', MB_YESNO + 
  MB_ICONQUESTION) = IDYES then
begin
    fhlknl1.Kl_GetQuery2('delete T201 where f01='+inttostr(Tadodataset(sender).Tag ),false);
    fhlknl1.Kl_GetQuery2('delete T202 where f02='+inttostr(Tadodataset(sender).Tag ),false);
end;


end;

procedure TdmFrm.actClearCtrlsExecute(Sender: TObject);
var i:integer;
begin
if   Sender is TwinControl then
     for i:=0 to   ( Sender as TwinControl ).ComponentCount -1 do
     begin
         ( Sender as TwinControl ).Free ;
     end;

end;

procedure TdmFrm.actGetMaxCodeExecute(Sender: TObject);
var sql,tableName,fieldname:string;

begin
if MessageDlg('获取最大 ID?',mtInformation,[mbOk,mbCancel],0)=mrOk then
begin
    if   (sender As Tdbedit).Field.DataSet.State in [dsinsert,dsedit] then
      begin
              fieldname:=(sender As Tdbedit).Field.FieldName  ;
              if (sender is Tdbedit) then
              begin
                   fhlknl1.Kl_GetQuery2 ('select F16 from T201 where F01='+inttostr((sender As Tdbedit).Field.DataSet.Tag  ));

                   if not fhlknl1.FreeQuery.IsEmpty then
                   begin
                     tablename:= fhlknl1.FreeQuery.FieldByName('F16').AsString ;

                      if   tablename='' then
                      begin
                           showmessage(  'T201表不存在');
                           exit ;
                      end
                      else
                      begin
                           tablename:=Format(tablename,[fhlknl1.Connection.DefaultDataBase]);

                           sql:='select isnull(max(convert(int,'+fieldname+'))+1,'+quotedstr('')+') as MaxCode From '+tablename+' where isnumeric(' +fieldname+ ')=1';

                           dmfrm.GetQuery1(sql);
                           if not dmfrm.FreeQuery1.IsEmpty then
                           begin
                               (sender As Tdbedit).Field.DataSet.FieldByName(fieldname).Value := dmfrm.FreeQuery1.FieldByName('MaxCode').Value ;
                           end   ;

                      end;
                   end;
              end;
      end;
end;
end;




procedure TdmFrm.actadddatasetExecute(Sender: TObject);

var DataSetPopMenu:Tpopupmenu;
var DataSetIDMenu,BeforePostMenu,BeforeDeleteMenu,AfterPostMenu,LstProcsMenu:Tmenuitem;

begin
    DataSetPopMenu:=Tpopupmenu.Create (self);

    DataSetIDMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    DataSetIDMenu.Caption :='DataSetIDMenu';
    DataSetIDMenu.OnClick :=self.ConfigDatasetID ;//(Sender);


    BeforePostMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    BeforePostMenu.Caption :='BeforePostMenu';
    BeforePostMenu.OnClick :=self.  ConfigBeforePost;//(sender);

    BeforeDeleteMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    BeforeDeleteMenu.Caption :='BeforeDeleteMenu';
    BeforeDeleteMenu.OnClick :=self.ConfigBeforeDelete  ;//(sender);

    AfterPostMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    AfterPostMenu.Caption :='AfterPostMenu';
    AfterPostMenu.OnClick :=self.ConfigAfterPost  ;//(sender);

    LstProcsMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    LstProcsMenu.Caption :='LstProcsMenu';
    LstProcsMenu.OnClick :=self.LstDataProcs  ;//(sender);


    DataSetPopMenu.Items.Add(DataSetIDMenu);
    DataSetPopMenu.Items.Add(BeforePostMenu);
    DataSetPopMenu.Items.Add(BeforeDeleteMenu);
    DataSetPopMenu.Items.Add(AfterPostMenu);
    DataSetPopMenu.Items.Add(LstProcsMenu);


    Tdbedit(Sender).PopupMenu :=DataSetPopMenu;

end;

procedure TdmFrm.actTreeGridExecute(Sender: TObject);
var   frmeditor:Tform;
begin
if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrmSystool('46', Tdbedit(sender).Text );

    frmeditor.ShowModal ;

    if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrmSystool(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrmSystool(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);

end;

procedure TdmFrm.TreeIDT507Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrmSystool('47', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrmSystool(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrmSystool(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.actTreeIDSExecute(Sender: TObject);
begin
   if Sender is Tdbedit then
  FhlUser.ShowEditorFrmSystool('24',Tdbedit(sender).Text );

end;


procedure TdmFrm.actCRMTreeIDSGridExecute(Sender: TObject);
var TreeGridFrm :Tform    ;
var i:integer;
var TreeIDS,ID:string;
begin
    if Sender is Tdbedit then
    begin
       if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
    end;
    if Sender is Tmenuitem then
    begin
       id:=inttostr(Tpagecontrol (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Tag );//
    end;

   TreeGridFrm:=FhlUser.ShowModalTreeGridFrmSystool('28',id,true );
   TTreeGridFrm(TreeGridFrm ).ShowModal ;


   if Sender is Tdbedit then
   begin
    for i:=0 to TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
    begin
        if i=0 then
            TreeIDS:=    TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F11').AsString
        else
        begin
            if TreeIDS<>   TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F11').AsString then
            begin
                  Tdbedit(sender).Text :=Tdbedit(sender).Text +'TreeIDS 不一致！' ;
                  freeandnil(TreeGridFrm );
                  exit;
            end;
        end;
        TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.next;
    end;
    Tdbedit(sender).Text :=TreeIDS;
  end;

  freeandnil(TreeGridFrm );

end;

procedure TdmFrm.actEditorT616Execute(Sender: TObject);
var frmeditor:Tform;
begin
if sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrmSystool('49',Tdbedit(sender).Text );
    frmeditor.ShowModal ;


    if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrmSystool(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrmSystool(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.actCRMSubInterFaceExecute(Sender: TObject);
var  TreeGridFrm:Tform;
var i:integer;
var TreeIDS,ID:string;

begin
    if Sender is Tdbedit then
    begin
          if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
    end;

    if Sender is Tmenuitem then
    begin
       id:=inttostr(Tpagecontrol (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Tag );//
    end;
    
    TreeGridFrm:=FhlUser.ShowModalTreeGridFrmSystool('29', ID,true );
    TreeGridFrm.ShowModal ;


    if Sender is Tdbedit then
    begin
        for i:=0 to TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
        begin
            if i=0 then
                TreeIDS:=    TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('subinterfaceid').AsString
            else
            begin
                if TreeIDS<>   TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('subinterfaceid').AsString then
                begin
                      Tdbedit(sender).Text :=Tdbedit(sender).Text +'TreeIDS 不一致！' ;
                      freeandnil(TreeGridFrm );
                      exit;
                end;
            end;
            TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.next;
        end;
        Tdbedit(sender).Text :=TreeIDS;
    end;
    freeandnil(TreeGridFrm );

end;

procedure TdmFrm.actGridIDExecute(Sender: TObject);
var GridPopMenu:Tpopupmenu;
var GridMenu,GridRptMenu:Tmenuitem;

begin
    GridPopMenu:=Tpopupmenu.Create (self);
    GridMenu:=Tmenuitem.Create (GridPopMenu)  ;
    GridMenu.Caption :='GridMenu';
    GridMenu.OnClick :=self.ConfigGrid;//(Sender);

    GridRptMenu:=Tmenuitem.Create (GridPopMenu)  ;
    GridRptMenu.Caption :='GridRptMenu';
    GridRptMenu.OnClick :=self.ConfigGridRpt;//(sender);

    GridPopMenu.Items.Add(GridMenu);
    GridPopMenu.Items.Add(GridRptMenu);

    Tdbedit(Sender).PopupMenu :=GridPopMenu;

end;



                              //mtAdoDataSet1
procedure TFhlUser.SetDataSet(ADataSet:TDataSet;ADataSetId:ShortString;AParams:variant;AIsOpen:Boolean=True);
var
  i:integer;
begin
  if (ADataSetId='-1') or (ADataSetId='') then exit;

  FhlKnl1.Ds_SetParams(ADataSet,
    FhlKnl1.Vr_MergeVarArray(
      GetSysParamsVal(
         FhlKnl1.Cf_SetDataSet(ADataSet,ADataSetId,dmFrm.DataSetActionList1)
      ),
      AParams
    )
  );


  for i:=0 to ADataSet.FieldCount-1 do
    if ADataSet.Fields[i].FieldKind=fkLookup then
     FhlKnl1.Ds_OpenDataSet(ADataSet.Fields[i].LookupDataSet,  GetSysParamsVal(FhlKnl1.Cf_SetDataSet(ADataSet.Fields[i].LookupDataSet,intTostr(ADataSet.Fields[i].LookupDataSet.Tag),nil)  ));



  if AIsOpen then
  begin
    ADataSet.Open;
    if ADataSet.Filter<>'' then
          ADataSet.Filtered:=True;
  end;
  

end;

procedure TFhlUser.SetDbGridAndDataSet(ADbGrid:TDbGrid;ADbGridId:String;AParams:Variant;AIsOpen:Boolean=True;BDifReadOnlyClr :boolean=false);
begin
  if (ADbGridId='-1') or (ADbGridId='') then exit;
  SetDataSet(ADbGrid.DataSource.DataSet,SetDbGrid(ADbGridId,ADbGrid,BDifReadOnlyClr),AParams,AIsOpen);

end;

function  TFhlUser.SetDbGrid(ADbGridId:String;ADbGrid:TDbGrid;BDifReadOnlyClr :boolean=false):String;
begin
   ADbGrid.OnEditButtonClick:=dmFrm.DbGridEditBtnClickAction1Execute;


  Result:=FhlKnl1.Cf_SetDbGrid(ADbGridId,ADbGrid,BDifReadOnlyClr);
end;


function  TFhlUser.ShowFinderFrm(fAdoDataSet:TAdoDataSet;Var fFinderFrm:TForm;fFinderId:String):wideString;
begin
  result:='-1';
  if fFinderFrm=nil then
  begin
     fFinderFrm:=TFinderFrm.Create(Application);
     TFinderFrm(fFinderFrm).InitFrm(fFinderId);
  end;
  if fFinderFrm.ShowModal=mrOk then
  begin
    Result:=TFinderFrm(fFinderFrm).GetAllSql;
    if fAdoDataSet<>nil then
       with fAdoDataSet do
       begin
         Close;
         CommandText:=Result;
         FhlKnl1.Ds_OpenDataSet(fAdoDataSet,FhlUser.GetSysParamsVal(TFinderFrm(fFinderFrm).SysParams));
       end;
  end;
end;








procedure TFhlUser.ShowMore2MoreFrm(fFrmId:String;fParams:Variant);
begin
  More2MoreFrm:=TMore2MoreFrm.Create(Application);
  More2MoreFrm.InitFrm(fFrmId,fParams);
  More2MoreFrm.ShowModal;
  More2MoreFrm.Free;
end;



function  TFhlUser.ShowEditorFrmSystool(fFrmId:String;fOpenParams:Variant;fDataSet:TDataSet=nil;owner:Twincontrol=nil):TForm;
begin
  Screen.Cursor:=crHourGlass;
  try
       if   owner=nil then
           Result:=TEditorFrmSystool.Create(Application)
       else
           Result:=TEditorFrmSystool.Create(owner);
  TEditorFrmSystool(Result).InitFrm(fFrmId,fOpenParams,fDataSet);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

function  TFhlUser.ShowEditorFrm(fFrmId:String;fOpenParams:Variant;fDataSet:TDataSet=nil;owner:Twincontrol=nil;PparentGrid:Tdbgrid=nil):TForm;
begin
  Screen.Cursor:=crHourGlass;
  try
       if   owner=nil then
           Result:=TEditorFrm.Create(Application)
       else
           Result:=TEditorFrm.Create(owner);
  TEditorFrm(Result).InitFrm(fFrmId,fOpenParams,fDataSet,PparentGrid);
  finally
    Screen.Cursor:=crDefault;
  end;
end;
procedure TFhlUser.ShowBillFrm_Ex(fFrmId:String;fCode:String='';pTmpTableName:string ='');
begin
  Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('BillFrm'+fFrmId)=nil then   // if find then form then show the form
  begin
    with TFrmBillEx.Create(Application) do
    begin
      FWindowsFID:=DesktopFrm.dsMainMenu.FieldByName('F_ID').AsString ;
      PAuthoriseTmpTable:=pTmpTableName;
      InitFrm(fFrmId);
      SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
      Name:='BillFrm'+fFrmId;
   
      Show  ;
   if fCode<>'' then
        OpenBill(fCode);
//      else
//        NewBtn.Click
    end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;


procedure TFhlUser.ShowBillOpenDlgFrm(AFrmId:string);
begin
//
end;

procedure TFhlUser.ShowTreeEditorFrm(fFrmId:String);
begin
  Screen.Cursor:=crAppStart;
  try
    if FhlKnl1.Vl_FindChildFrm('TreeEditor'+fFrmId)=nil then
    begin
      with TTreeEditorFrm.Create(Application) do
      begin
        FWindowsFID:=DesktopFrm.dsMainMenu.FieldByName('F_ID').AsString ;
        formstyle:=  fsMDIChild;
        Name:='TreeEditor'+fFrmId;
        SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
        InitFrm(fFrmId,null);

        Show;
      end;
    end;
 finally
   Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.ShowTreeGridFrm(fFrmId:String);
begin
 Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('TreeGrid'+fFrmId)=nil then
  begin
    with TTreeGridFrm.Create(Application) do
    begin
          FWindowsFID:=DesktopFrm.dsMainMenu.FieldByName('F_ID').AsString ;
      Name:='TreeGrid'+fFrmId;
      InitFrm(fFrmId,null);
      SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
      Show;
    end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.ShowTreeMgrFrm(fFrmId:String);
begin
  Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('TreeMgr'+fFrmId)=nil then
  begin
    with TTreeMgrFrm.Create(Application) do
    begin
      Name:='TreeMgr'+fFrmId;
      InitFrm(fFrmId);
      Show;
    end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;


 {
begin
  with TYdWarePropFrm.Create(Application) do
  begin
    InitFrm(ADgId,AModelNo);
    ShowModal;
    Free;
  end;
end;
}

function TFhlUser.ShowAnalyserFrm(AFrmId:String;AmtParams:Variant; AuthoriseTmpTable:string='' ;pFormStyle:TFormStyle=fsMDIChild):Tform;
var form:TAnalyseEx ;
begin
 Screen.Cursor:=crAppStart;
 try
  form:=TAnalyseEx.Create(Application)  ;
  with form  do
  begin
    FWindowsFID:=DesktopFrm.dsMainMenu.FieldByName('F_ID').AsString ;
    hide;
    PAuthoriseTmpTable:= AuthoriseTmpTable;
    InitFrm(AFrmId,AmtParams);
    SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
    formstyle:=pFormStyle;
    if pFormStyle=fsMDIChild then
    Show;
  end;
  result:=form;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure  TFhlUser.ShowProgress(AProgress, AMaxProgress: Integer);
begin
end;




function  TFhlUser.GetSysParamVal(AParamName:String):Variant; //默认参数
var Pnow :Tdatetime;
var OriginValue:string;
var str:string;
begin
         Result:=Null;

         if ( uppercase(AParamName) =uppercase('sNow' )) or ( uppercase(Copy(AParamName,1,6))=uppercase('sToday')) then
         begin
            fhlknl1.Kl_GetQuery2('select getdate() as  Pnow');
            Pnow:= fhlknl1.FreeQuery.fields[0].AsDateTime        ;
         end;

         OriginValue:= AParamName ;  //3-8
         AParamName:=uppercase(AParamName);

         if AParamName=uppercase('sEmpId') then
            Result:=LoginInfo.EmpId
         else if AParamName=uppercase('sChainStoreId') then
            Result:=LoginInfo.ChainStoreId
         else if AParamName=uppercase('DataBaseID') then
            Result:=LoginInfo.DataBaseID
         else if AParamName=uppercase('sTabId') then
            Result:=LoginInfo.TabId
         else if AParamName=uppercase('sLoginId') then
            Result:=LoginInfo.LoginId
         else if AParamName=uppercase('sNow') then
            Result:=Pnow
         else if AParamName=uppercase('sToday') then
            Result:=formatdatetime('yyyy"-"mm"-"dd',Pnow)
         else if Copy(AParamName,1,6)=uppercase('sToday') then
            Result:=formatdatetime('yyyy"-"mm"-"dd',Pnow+StrToInt(Copy(AParamName,7,length(AParamName))))
         else if AParamName=uppercase('sClientKey') then
            Result:=FhlKnl1.St_GetPrimaryKey(9999)
         else if AParamName=uppercase('sEmpty') then
            Result:=''
         else if  AParamName=uppercase('sNull') then
            Result:=null
         else if  AParamName=uppercase('syear') then
            Result:= yearof(today)
         else if  AParamName=uppercase('sGUID') then
            Result:= GetGUID
         else if  AParamName=uppercase('sLogDataBase') then
            Result:= logininfo.LogDataBaseName
         else if  AParamName=uppercase('sPubDataBase') then
            Result:= logininfo.SysDBPubName
         else if  AParamName=uppercase('sCurUserDBName') then
            Result:= dmfrm.ADOConnection1.DefaultDatabase 
         else if  AParamName=uppercase('sVersion') then
            Result:= GetSysVersion
         else if  AParamName=uppercase('sChainStoreCode') then
            Result:= LoginInfo.ChainStoreCode
         else if  AParamName=uppercase('sLastClsAccMonth') then
           Result:=datetimetostr( GetMonthClsDate)
         else if  AParamName=uppercase('sFirstAboutClsAccMonth') then
           Result:=datetimetostr (IncMonth( GetMonthClsDate))
         else if Copy(AParamName,1,2)=uppercase('sFirstMonthClsDate') then
           Result:=datetimetostr ( GetMonthClsDate )
          else if  Copy(AParamName,1,6)=uppercase('smonth') then
            begin
            // str:=inttostr(monthof(strtodate(formatdatetime('yyyy"-"mm"-"dd',Pnow+StrToInt(Copy(AParamName,7,length(AParamName)))))));
            str:=inttostr(monthof(today));
            if length(str)=1 then str:='0'+str;
            Result:=str;//monthof(today);
            end
            { }
            else if UpperCase(LeftStr(AParamName,4))=UpperCase('SysP') then
            begin
               FhlKnl1.Kl_GetQuery2('  select Fparamvalue ,FparamCode From '+logininfo.MainUserDBName +'.dbo.TParamsAndValues where ''SysP''+FparamCode='+quotedstr(AParamName));
               if not FhlKnl1.FreeQuery.IsEmpty then
               result:= FhlKnl1.FreeQuery.Fields[0].Value ;
            end
            else if  AParamName =uppercase('sOperationDate') then
                Result:=formatdatetime('yyyy"-"mm"-"dd',logininfo.OperationDate)
            else if Copy(AParamName,1,14)=uppercase('sOperationDate') then
                Result:=formatdatetime('yyyy"-"mm"-"dd',logininfo.OperationDate+StrToInt(Copy(AParamName,15,length(AParamName))))
         else if AParamName<>'' then
            Result:=OriginValue       ;

end;

function  TFhlUser.GetSysParamsVal(AParamsName:Variant):Variant;
  var i:integer;
begin
  Result:=AParamsName;
  if VarIsStr(Result) then
     Result:=FhlKnl1.Vr_CommaStrToVarArray(Result);
  if VarIsArray(Result) then
     for i:=0 to VarArrayHighBound(Result,1) do
         Result[i]:=GetSysParamVal(Result[i]);
end;

procedure  TFhlUser.AssignDefault(fDataSet:TDataSet;UseEdit:boolean=true);
// var i:integer;r:variant;
begin
FhlKnl1.Ds_AssignDefaultVals(fDataSet,sDefaultVals,UseEdit);

  sDefaultVals:='';
end;



procedure  TFhlUser.CheckRight(RightId:String;MyFrm:TForm=nil);
begin
  if RightId='' then
  begin
   exit;
  end;
  if Not dmFrm.ExecStoredProc('sys_CheckRight',varArrayof([LoginInfo.LoginId, RightId])) then
  begin
     MyFrm.Free;
     MessageDlg(#13#10'对不起,您没有权限使用该功能,请向管理员询问.',mtWarning,[mbOk],0);
     Abort;
  end;
end;

function   TFhlUser.CheckRight2(RightId:String;MyFrm:TForm=nil):boolean;
begin

  if RightId='' then
  begin
    result:=false;
    Exit;
  end;

  if Not dmFrm.ExecStoredProc('sys_CheckRight',varArrayof([LoginInfo.LoginId,RightId])) then
  begin
    result:=false;
    Exit;
  end
  else
    result:=true;

end;


procedure TFhlUser.Logout(Note:String='');
begin
  if (LoginInfo.LoginTime<>'') and (not logininfo.IsTool)  then
    try
      dmFrm.ADOConnection1.DefaultDatabase :=logininfo.PrivorUserDataBase ;
      dmFrm.ExecStoredProc('sys_Logout',varArrayof([LoginInfo.LoginTime,Note]));
    except
       MessageDlg(#13#10'不能写入登出日志!',mtError,[mbOk],0);
    end;
end;


procedure TFhlUser.DoExecProc(AUsrDataSet:TDataSet;Aparams:Variant;AProcId:String='');
var
  fDict:TExcPrcDict;

var TestStr:String;
begin
  if AProcId='' then
    AProcId:=IntToStr(AUsrDataSet.Tag);
  FhlKnl1.Cf_GetDict_ExcPrc(AProcId,fDict);
  if fDict.ProcName<>'' then
  begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(AUsrDataSet,fDict.UsrParams),Aparams);
    //  TestStr:=Aparams;
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(Aparams,FhlUser.GetSysParamsVal(fDict.SysParams)));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool then Abort;
  end;
end;


procedure TFhlUser.ShowCRMFrm(FromId, OpenParam: string;AuthoriseTmpTable:string );
var
  FrmCrm:TFrmCrm;
begin
  Screen.Cursor:=crAppStart;
  try
  //  if FhlKnl1.Vl_FindChildFrm('BillFrm'+fFrmId)=nil then   // if find then form then show the form
  begin
      FrmCrm:=TFrmCrm(  application.FindComponent('FrmCrm'+FromId));
      if FrmCrm=nil then
      begin
          with TFrmCrm.Create(Application) do
          begin
                FWindowsFID:=DesktopFrm.dsMainMenu.FieldByName('F_ID').AsString ;
            PAuthoriseTmpTable:=AuthoriseTmpTable;
            InitFrm(FromId);
            SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
            Name:='FrmCrm'+FromId;
            Show;
          end;
      end
      else
      begin
      FrmCrm.BringToFront ;
      ShowWindow(FrmCrm.Handle , SW_MAXIMIZE);
      end;
  end;
  finally
  Screen.Cursor:=crDefault;
  end;
end;


procedure TFhlUser.ShowDemoFrm(FormID: integer;FormName:string='');
var     FrmDemo: Tform        ;
begin
  Screen.Cursor:=crAppStart;
 try
  FrmDemo :=FhlKnl1.Vl_FindChildFrm('FrmDemo'+inttostr(FormID));

  if FrmDemo=nil then   // if find then form then show the form
  begin
    with TFrmDemo.Create(Application) do
    begin
      InitFrm(FormID);
      name:='FrmDemo'+inttostr(FormID);
      caption:=  FormName;
     // Showmodal;
      Show;
    end;
  end;
  
 finally
  Screen.Cursor:=crDefault;
 end;
end;


function TFhlUser.ShowModelTreeEditorFrm(fFrmId: String;
  AParams: variant;Model:boolean): Tform;
begin
  Screen.Cursor:=crAppStart;
  try
    if FhlKnl1.Vl_FindChildFrm('TreeEditor'+fFrmId)=nil then
    begin
      Result:=TTreeEditorFrm.Create(Application);
      with TTreeEditorFrm(Result) do
      begin
        Name:='TreeEditor'+fFrmId;
        InitFrm(fFrmId,AParams,Model);
      end;
    end
    else
    Result:=nil;
 finally
   Screen.Cursor:=crDefault;
 end;

end;
function TFhlUser.ShowModalTreeGridFrmSystool(fFrmId: String; AParams: variant;
  Modal: boolean=false):Tform;
begin
 Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('TreeGridSystool'+fFrmId)=nil then
  begin
      Result:=TTreeGridFrmSystool.Create(Application);
      with TTreeGridFrmSystool(Result) do
      begin
          Name:='TreeGridSystool'+fFrmId;
          caption:=name;
          InitFrm(fFrmId,AParams,Modal);
          if Modal then
          hide;
      end;
  end
  else
     Result:=nil;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

function TFhlUser.ShowModalTreeGridFrm(fFrmId: String; AParams: variant;
  Modal: boolean):Tform;
begin
 Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('TreeGrid'+fFrmId)=nil then
  begin
      Result:=TTreeGridFrm.Create(Application);
      with TTreeGridFrm(Result) do
      begin
          Name:='TreeGrid'+fFrmId;
          InitFrm(fFrmId,AParams,Modal);
          if Modal then
          hide;
      end;
  end
  else
     Result:=nil;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.SetDbGridAndDataSet(ADbGrid: TDbGrid; ADbGridId: String;
  AParams: Variant; AIsOpen: Boolean; EditBtnClick: Taction);
begin
  if (ADbGridId='-1') or (ADbGridId='') then exit;
  SetDataSet(ADbGrid.DataSource.DataSet,SetDbGrid(ADbGridId,ADbGrid,EditBtnClick),AParams,AIsOpen);
end;

function TFhlUser.SetDbGrid(ADbGridId: String; ADbGrid: TDbGrid;
  EditBtnClick: Taction): String;
begin
  ADbGrid.OnEditButtonClick:=EditBtnClick.OnExecute ;
  Result:=FhlKnl1.Cf_SetDbGrid(ADbGridId,ADbGrid);
end;

procedure TdmFrm.actTreeGridOpenParamsExecute(Sender: TObject);
VAR frmeditor:Tform;
begin
      if Sender is Tdbtext then
      begin

          frmeditor:=FhlUser.ShowEditorFrmSystool('56', Tdbtext(sender).Caption  );//.Showmodal;
          sDefaultVals:='';
          sDefaultVals:='f01='+Tdbtext(sender).Caption ;
          frmeditor.ShowmodAl ;

          freeandnil(frmeditor);
      end;

end;

procedure TdmFrm.actEditorOpenParamsExecute(Sender: TObject);
VAR frmeditor:Tform;
begin
    if Sender is Tdbtext then
    begin
        frmeditor:=FhlUser.ShowEditorFrmSystool('57', Tdbtext(sender).Caption  );//.Showmodal;
        sDefaultVals:='';
        sDefaultVals:='f01='+Tdbtext(sender).Caption ;

        frmeditor.ShowmodAl ;
        freeandnil(frmeditor);
    end;

end;

procedure TdmFrm.actT202Execute(Sender: TObject);
    var TreeGridFrm :Tform    ;
begin
   if Sender is Tdbtext then
   begin
   TreeGridFrm:=FhlUser.ShowModalTreeGridFrmSystool('50', Tdbtext(sender).Caption,true );
   TTreeGridFrm(TreeGridFrm ).ShowModal ;
   end;
end;

procedure TdmFrm.actBoxsExecute(Sender: TObject);
begin
   if Sender is Tdbedit then
    FhlUser.ShowModalTreeGridFrmSystool('34', Tdbedit(sender).Text,true ).ShowModal ;
end;

procedure TdmFrm.GridColsExecute(Sender: TObject);
var FrmTreeGridCols:Tform;
begin
  if Sender is Tdbtext then
  begin
      FrmTreeGridCols:=FhlUser.ShowModalTreeGridFrmSystool('35', Tdbtext(sender).Caption ,true );
      FrmTreeGridCols.ShowModal ;
  end;

end;

procedure TFhlUser.TreeConfig(sender: Tobject);
begin
self.ShowEditorFrmSystool('47' ,inttostr(Tcontrol(sender).Tag  )).ShowModal ;
end;

function TFhlUser.TreePopUpMenu(TreeID: string): TPopUpMenu;
var MenuItem:TMenuItem;
begin
      result:= TPopUpMenu.Create(nil);

      MenuItem:=TMenuItem.Create (nil);
      MenuItem.Caption :='ConfigTree';
      MenuItem.Tag :=  strtoint(TreeID);

      MenuItem.OnClick := self.TreeConfig;
      result.Items.Add(MenuItem) ;
end;

procedure TdmFrm.actT102Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrmSystool('64', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrmSystool(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrmSystool(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.actTabEditExecute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrmSystool('66', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrmSystool(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrmSystool(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.actMoreTOmoreT619Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrmSystool('36', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrmSystool(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrmSystool(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.actCheckReferenceExecute(Sender: TObject);
var RRef:String;
begin
if   FhlKnl1.Ds_CheckReference(TDataSet(Sender),RRef) then
begin
    MessageDlg(' 删除失败!'+#13#10#13#10+'原因：'+ RRef ,mtWarning,[mbOk],0);
    abort;
end;

end;

procedure TdmFrm.actFieldOFsysTableExecute(Sender: TObject);
begin

   if Sender is Tdbedit then
FhlUser.ShowModalTreeGridFrmSystool('43', Tdbedit(sender).Text,true ).ShowModal ;

end;

procedure TFhlUser.changeUserDataBase(UserDbName: string);
begin

    dmfrm.ADOConnection1.DefaultDatabase :=   UserDbName;
    fhlknl1.SetUserDataBase(UserDbName);


end;

procedure TdmFrm.ConfigGrid(sender: Tobject);
VAR frmeditor:Tform;
begin
    if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

        frmeditor:=FhlUser.ShowEditorFrmSystool('34', Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Text );//.Showmodal;
        frmeditor.ShowmodAl ;

        if   Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrmSystool(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Text :=TEditorFrmSystool(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

        freeandnil(frmeditor);


end;

procedure TdmFrm.ConfigGridRpt(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('44', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;




procedure TdmFrm.ConfigDatasetID(sender: Tobject);
VAR frmeditor:Tform;
begin

    if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then
    begin

      frmeditor:=FhlUser.ShowEditorFrmSystool('35', Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent).Text );//.Showmodal;
      frmeditor.ShowmodAl ;

      if  Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent).Field.DataSet.State in [dsinsert,dsedit] then
       if TEditorFrmSystool(frmeditor).DataSource1.DataSet.findfield('F01')<>nil then
       Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent).Text :=TEditorFrmSystool(frmeditor).DataSource1.DataSet.FieldByName('F01').AsString ;

      freeandnil(frmeditor);
    end;

end;

procedure TdmFrm.ConfigAfterPost(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('47', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;


procedure TdmFrm.ConfigBeforeDelete(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('46', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;


procedure TdmFrm.ConfigBeforePost(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('45', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;


procedure TdmFrm.actFieldLKPExecute(Sender: TObject);
var FieldLKPMenu:Tpopupmenu;
var FldGridDlgMenu,FldTreeDlgMenu:Tmenuitem;

begin
    FieldLKPMenu:=Tpopupmenu.Create (self);

    FldGridDlgMenu:=Tmenuitem.Create (FieldLKPMenu)  ;
    FldGridDlgMenu.Caption :='FldGridDlgMenu';
    FldGridDlgMenu.OnClick :=self.ConfigFldGridLkp ;//(Sender);

    FldTreeDlgMenu:=Tmenuitem.Create (FieldLKPMenu)  ;
    FldTreeDlgMenu.Caption :='FldTreeDlgMenu';
    FldTreeDlgMenu.OnClick :=self.ConfigFldTreeDlgLkp ;//(sender);

    FieldLKPMenu.Items.Add(FldGridDlgMenu);
    FieldLKPMenu.Items.Add(FldTreeDlgMenu);

    Tdbedit(Sender).PopupMenu :=FieldLKPMenu;

end;

procedure TdmFrm.ConfigFldGridLkp(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('48', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;


procedure TdmFrm.ConfigFldTreeDlgLkp(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('49', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;


procedure TdmFrm.actGetFrmGridIDExecute(Sender: TObject);
var ModelID,sql,table,GridIDField,actsField, CommActsField:string;

begin

    if ( Tdbedit(sender).Field.DataSet.FieldByName('F15')<>nil) and (Tdbedit(sender).Field.DataSet.FieldByName('F18')<>nil) then
    begin
         ModelID:=Tdbedit(sender).Field.DataSet.FieldByName('F15').AsString;
         sql:=' select note,GridIDFieldName ,isnull(actsFieldName,'+quotedstr('')+')actsFieldName '
              +' from T702 where isnull(Note,'+quotedstr('')+')<>'+quotedstr('')
              +' and modelId='+tdbedit(Sender).Text  ;
         fhlknl1.Kl_GetQuery2(sql);

         if fhlknl1.FreeQuery.IsEmpty then
         begin
             showmessage('table,GridIDField,actsField   Error!');
             exit;
         end;
         table:=fhlknl1.FreeQuery.FieldByName('note').AsString   ;
         GridIDField:=fhlknl1.FreeQuery.FieldByName('GridIDFieldName').AsString   ;
         actsField  :=fhlknl1.FreeQuery.FieldByName('actsFieldName').AsString   ;
         if actsField<>'' then
         CommActsField:=','+actsField;

         sql:='select '+GridIDField +CommActsField+ ' From '+table  +' where f01='+Tdbedit(sender).Field.DataSet.FieldByName('F18').AsString ;
         fhlknl1.Kl_GetQuery2(sql);
         if fhlknl1.FreeQuery.IsEmpty then
         begin
             showmessage(sql+'  Error!');
             exit;
         end;

          Tdbedit(sender).Field.DataSet.FieldByName('F16').value:= fhlknl1.FreeQuery.FieldByName(GridIDField).Value ;
          Tdbedit(sender).Field.DataSet.FieldByName('F17').Value  := fhlknl1.FreeQuery.FieldByName(actsField).Value  ;

    end;

end;

procedure TdmFrm.actGetSubSysGridColIDExecute(Sender: TObject);
var ORIsysdb ,sysdb:string;
var FrmTreeGridCols:Tform;
begin
if   tdbedit(Sender).Field.DataSet.FieldByName('SubSystemNameLKP')<>nil then
begin
    sysdb:=tdbedit(Sender).Field.DataSet.FieldByName('SubSystemNameLKP').AsString ;
    if   sysdb<>'' then
    begin
    ORIsysdb:=fhlknl1.Connection.DefaultDatabase ;
    fhlknl1.Connection.DefaultDatabase :=sysdb;
    if Sender is Tdbedit then
    begin
        FrmTreeGridCols:=FhlUser.ShowModalTreeGridFrmSystool('35', Tdbedit(sender).Text  ,true );
        FrmTreeGridCols.ShowModal ;
        if    TTreeGridFrmSystool(FrmTreeGridCols).ADODataSet1.Recordset.RecordCount =1 then
        begin
            TTreeGridFrmSystool(FrmTreeGridCols).ADODataSet1.Edit ;
            TTreeGridFrmSystool(FrmTreeGridCols).ADODataSet1.FieldByName('F25').AsBoolean :=true;
            TTreeGridFrmSystool(FrmTreeGridCols).ADODataSet1.Post ;
            tdbedit(Sender).Field.DataSet.FieldByName('f19').Value  :=TTreeGridFrmSystool(FrmTreeGridCols).ADODataSet1.fieldbyname('F01').Value ;
        end;
    end;

    fhlknl1.Connection.DefaultDatabase :=ORIsysdb;

    end;

end;

end;

procedure TdmFrm.actListFrmActsExecute(Sender: TObject);
var FrmActions:TFrmActions;
var modelID:integer;
var form:Tform;
begin
     if tdbedit(sender).Field.DataSet.fieldbyname('f15').AsString='' then exit;

     modelID:=tdbedit(sender).Field.DataSet.fieldbyname('f15').AsInteger ;

     FrmActions:=TFrmActions.Create (nil);

     
     case modelID of
     7: begin
             form:=TAnalyseEx.Create(nil);
             FrmActions.InitFrm(TAnalyseEx(form).ActionList1 ,tdbedit(sender).Field.DataSet.fieldbyname('f17').AsString );
             form.free;
        end;
     2: begin
             form:=TTreeGridfrm.Create(nil);
             FrmActions.InitFrm(TTreeGridfrm(form).ActionList1 ,tdbedit(sender).Field.DataSet.fieldbyname('f17').AsString  );
             form.free;
        end;
     end  ;

     if FrmActions.ShowModal=mrOk then
     begin
          tdbedit(sender).Text:=inttostr( FrmActions.SelectedIndex);
     end ;
     { }

     FrmActions.Free;
end;

procedure TFhlUser.ShowMainMenuFrm(FromId, OpenParam: string);
var FrmMainMenu:TFrmMainMenu;
begin
   Screen.Cursor:=crAppStart;
 try
//  if FhlKnl1.Vl_FindChildFrm('BillFrm'+fFrmId)=nil then   // if find then form then show the form
  begin

      FrmMainMenu:=TFrmMainMenu(  application.FindComponent('FrmMainMenu'+FromId));

      if FrmMainMenu=nil then
      begin
          FrmMainMenu:= TFrmMainMenu.Create(Application)  ;
           FrmMainMenu.InitFrm(FromId,null,nil);
          FrmMainMenu.Name:='FrmMainMenu'+FromId;
          FrmMainMenu.ShowModal ;
      end
      else
       ShowWindow(FrmMainMenu.Handle , SW_RESTORE);

  end;
 finally
  Screen.Cursor:=crDefault;
     FrmMainMenu.free;
 end;
end;


procedure TdmFrm.actListFrmModelExecute(Sender: TObject);
var FrmActions:TFrmActions;
var ActionList1:TActionList;
begin
     FrmActions:=TFrmActions.Create (self);

     ActionList1:=TActionList.Create (self);

     FrmActions.InitFrm(DesktopFrm.ActionList1,'','FRM' );
     ActionList1.Free ;

     if FrmActions.ShowModal=mrOk then
     begin
          if  tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
          tdbedit(sender).Text:=inttostr( FrmActions.SelectedIndex);
     end ;

     FrmActions.Free;
end;


procedure TdmFrm.ActImagesExecute(Sender: TObject);
var FrmActions:TFrmActions;

begin

      FrmActions:=TFrmActions.Create (nil);
      FrmActions.InitFrmImageLst(self.ImageList1 );
      FrmActions.ShowModal;
      if  Tdbedit(Sender).Field.DataSet.State in [dsinsert,dsedit] then
      Tdbedit(Sender).Text :=trim(FrmActions.ImageSelIndex );

      FrmActions.Free ;
end;

procedure TdmFrm.NSelPrintFieldsClick(Sender: TObject);
var

  Gridtag:string;
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;




end;

procedure TdmFrm.ActUpdateBoolExecute(Sender: TObject);
begin
//
if sender is tdbgrid then
begin
   Tdbgrid(sender).DataSource.DataSet.Edit ;
   Tdbgrid(sender).DataSource.DataSet.FieldByName('f26').AsBoolean := not Tdbgrid(sender).DataSource.DataSet.FieldByName('f26').AsBoolean;
      Tdbgrid(sender).DataSource.DataSet.Post ; ;
end;
end;

procedure TdmFrm.ConfigCtrl(sender: Tobject);

VAR frmeditor:Tform;
var boxid:string;
begin
// 34

//       UserdefaultDB:=dmfrm.ADOConnection1.DefaultDatabase ;
//       dmfrm.ADOConnection1.DefaultDatabase :=fhlknl1.Connection.DefaultDatabase ;

    if   (  (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit)
       or  (  (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbmemo)    then
    begin                           //         PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
        //boxid:= Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Text;
         boxid:=  Tdbedit( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ).Text ;
        frmeditor:=FhlUser.ShowModalTreeGridFrm( '34', boxid ,true);//.Showmodal;
        frmeditor.ShowmodAl ;
   end;



end;

procedure TdmFrm.ConfigGetMaxBoxid(sender: Tobject);

begin


  if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) as Tdbedit).Text ='' then

    begin
       ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) as Tdbedit).Text:=fhlknl1.GetMaxBoxID;

    end   ;
   { }
end;

procedure TdmFrm.ConfigLabel(sender: Tobject);

VAR frmeditor:Tform;
begin
// 53

    if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then
    begin
        frmeditor:=FhlUser.ShowModalTreeGridFrm('53', Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Text ,true);//.Showmodal;
        frmeditor.ShowmodAl ;
    end;

end;

procedure TdmFrm.ActGetBoxCrmTreeIDsExecute(Sender: TObject);
begin
if    Sender is Tdbedit then
     Tdbedit (Sender ).Text :=fhlknl1.GetMaxCode('T703','F01');
end;







procedure TdmFrm.ActGetMaxSubinterfaceIDExecute(Sender: TObject);
begin
if    Sender is Tdbedit then
     Tdbedit (Sender ).Text :=fhlknl1.GetMaxCode('T701','F01');
end;

procedure TdmFrm.LstDataProcs(sender: Tobject);
var frmLstProc:Tform;
var ProcsMemo:Tmemo;
var ID,values:string;
var i,j:integer;
begin
//
    ID:=  Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Text ;
    frmLstProc:=Tform.Create(nil);
    ProcsMemo:=Tmemo.Create (frmLstProc);
    ProcsMemo.Parent :=frmLstProc;
    ProcsMemo.Align :=alclient;
    frmLstProc.Caption :='prcos';

    dmfrm.GetQuery1('select * from V_LstProcs where f01='+ID);
    if not dmfrm.FreeQuery1.IsEmpty then
    begin
         for j:=0 to dmfrm.FreeQuery1.RecordCount -1  do
         begin
               values:='';
               for i:=0 to dmfrm.FreeQuery1.FieldCount -1 do
               begin
                   values:=values+'   '+ dmfrm.FreeQuery1.Fields[i].AsString
               end;
               ProcsMemo.Lines.Add(values);
               dmfrm.FreeQuery1.Next ;
         end;
    end;
    frmLstProc.ShowModal ;
    frmLstProc.Free ;
end;

procedure TdmFrm.LstModelActtionsExecute(Sender: TObject);
var FrmActions:TFrmActions;
var i:integer;
var values:string;
var ModelTable:string;
var strlst:Tstrings;
begin

     fhlknl1.Kl_GetQuery2 (' select F16 from T201 where f01='+inttostr(Tdbedit(Sender).Field.DataSet.tag ));
     if  fhlknl1.FreeQuery.IsEmpty then
     begin
         showmessage('error the dataset is empty');
         exit;
     end;
     ModelTable:=rightStr(trim(fhlknl1.FreeQuery.fieldbyname('F16').AsString) ,4);
     {
T602	cfg_Bill
T612	cfg_TreeGrid
T616	cfg_editor
T611	cfg_TreeEditor
T606	cfg_TabEditor
T601	cfg_analyser
T617	cfg_TabBoxGrid
T618	cfg_TabGrid
T619	cfg_More2More
T620	cfg_TreeMgr
T700	cfg_CRm

T625
BillEx 模板
  }

        FrmActions:=TFrmActions.Create (nil);
        FrmActions.PnlLeft.Visible :=true;

        with FrmActions do
        begin
          CombSelectMolde.Items.Add('T602=cfg_Bill')  ;
          CombSelectMolde.Items.Add('T612=cfg_TreeGrid')  ;
          CombSelectMolde.Items.Add('T616=cfg_editor')  ;
          CombSelectMolde.Items.Add('T611=cfg_TreeEditor')  ;
          CombSelectMolde.Items.Add('T606=cfg_TabEditor')  ;
          CombSelectMolde.Items.Add('T601=cfg_analyser')  ;
          CombSelectMolde.Items.Add('T617=cfg_TabBoxGrid')  ;
          CombSelectMolde.Items.Add('T618=cfg_TabGrid')  ;
          CombSelectMolde.Items.Add('T619=cfg_More2More')  ;
          CombSelectMolde.Items.Add('T620=cfg_TreeMgr')  ;
          CombSelectMolde.Items.Add('T700=cfg_CRm')  ;
          CombSelectMolde.Items.Add('T625=cfg_BillEx')  ;
          CombSelectMolde.Items.Add('T627=cfg_FrmImportOpen')  ;
          CombSelectMolde.Items.Add('T628=cfg_SerialNos')  ; 
        end;

     FrmActions.ShowModal ;
     begin
        strlst:= Tstringlist.Create ;
        strlst:=FrmActions.ActionGrid.Rows[FrmActions.SelectedIndex];
        tdbedit(sender).Field.DataSet.FieldByName('F03').Value:=strlst[0];
        tdbedit(sender).Field.DataSet.FieldByName('F04').Value:=strlst[1];
        tdbedit(sender).Field.DataSet.FieldByName('F14').Value:=strlst[4];
        tdbedit(sender).Field.DataSet.FieldByName('F16').Value:=strlst[3];
        if  ( strtoint(strlst[4]) >=0) and ( strtoint(strlst[4])<10000) then
             tdbedit(sender).Field.DataSet.FieldByName('F21').AsBoolean :=true
        else
             tdbedit(sender).Field.DataSet.FieldByName('F21').AsBoolean :=false;
     end ;

     FrmActions.Free;
end;


procedure TdmFrm.ActGridUserMenuIDExecute(Sender: TObject);
var  TreeGridFrm:Tform;
var i:integer;
var GridUserMenuID,ID:string;

  BackupsysDb,BackUpUserDB:string;
begin
  self.PushGlobelContext( BackupsysDb,BackUpUserDB)   ;

  if not  logininfo.IsTool then
  dmfrm.ADOConnection1.DefaultDatabase:=DesktopFrm.dsMainMenu.FieldByName('subSysDBName').AsString;
  fhlknl1.Connection.DefaultDatabase :=logininfo.SysDBToolName ;

  if Sender is Tdbedit then
  begin
        if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
  end;

    
    TreeGridFrm:=FhlUser.ShowModalTreeGridFrmSystool('56', ID,true );
    TreeGridFrm.ShowModal ;


    if Sender is Tdbedit then
    begin
        for i:=0 to TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
        begin
            if i=0 then
                GridUserMenuID:=    TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F02').AsString
            else
            begin
                if GridUserMenuID<>   TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F02').AsString then
                begin
                      Tdbedit(sender).Text :='-1' ;
                      freeandnil(TreeGridFrm );
                      exit;
                end;
            end;
            TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.next;
        end;
        Tdbedit(sender).Text :=GridUserMenuID;
    end;
    freeandnil(TreeGridFrm );

self.PopGlobelContext(BackupsysDb,BackUpUserDB)  ;
end;

procedure TdmFrm.PopGlobelContext(var PSysDb, PUserDB: string);
begin
   dmfrm.ADOConnection1.DefaultDatabase :=PSysDb;
  fhlknl1.Connection.DefaultDatabase :=PUserDB;
  logininfo.IsTool :=false;
end;

procedure TdmFrm.PushGlobelContext(var PSysDb, PUserDB: string);
begin
  PSysDb:=dmfrm.ADOConnection1.DefaultDatabase ;
  PUserDB:=fhlknl1.Connection.DefaultDatabase ;
  logininfo.IsTool :=true;
end;

procedure TFhlUser.MergeGridUserMenuAndSysCongfigMenu(UserPopMenu,  SysConfigMenu: tpopupMenu; GridUserMenuIDs: integer;
  UserMenuAction: TactionList);
var i,j,UserMenuCont:integer;
var GridMenuItem: array of TMenuItem;
var sql:string;
begin
      UserPopMenu.Items.Clear ;
      UserMenuCont:=0;

    UserPopMenu.Images := UserMenuAction.Images ;
  if not LoginInfo.isAdmin then
    begin
          sql:='select * from T624 A '
        +' left join '+FhlKnl1.UserConnection.DefaultDatabase +'.dbo.sys_right B on A.F13=B.code '
        +' where   A.f02= '+inttostr(GridUserMenuIDs )+' and ('
        +' A.f13  in ( '
        +' select rightid from '
                + FhlKnl1.UserConnection.DefaultDatabase  +'.dbo.sys_groupright  C '
        +' join '+FhlKnl1.UserConnection.DefaultDatabase +'.dbo.sys_groupuser   D  on C.groupID=D.groupID '
        +' where  userid='+quotedstr(LoginInfo.LoginId)
        +') '
        +' or (    isnull(f13,0)=0 )) '
        +'  order by F07'   ;
    end
    else  { }
       sql:='select * From T624 where f02='+inttostr(GridUserMenuIDs )+'  order by F07';

      FhlKnl1.Kl_GetQuery2(sql)     ;

      if not FhlKnl1.FreeQuery.IsEmpty then
      begin
          UserMenuCont:=FhlKnl1.FreeQuery.RecordCount ;
          setlength(GridMenuItem,UserMenuCont+SysConfigMenu.Items.Count+1);
          for i:=0 to UserMenuCont-1 do
          begin                                                                //user menu
             if FhlKnl1.FreeQuery.fieldbyname('F11').asinteger>-1 then
             begin
                  GridMenuItem[i]           :=TMenuItem.Create (UserPopMenu);
                  GridMenuItem[i].Caption   :=FhlKnl1.FreeQuery.fieldbyname('f04').AsString ;
                  GridMenuItem[i].Checked   :=FhlKnl1.FreeQuery.fieldbyname('F05').AsBoolean ;
                  GridMenuItem[i].Visible   :=FhlKnl1.FreeQuery.fieldbyname('f06').Visible ;
                  GridMenuItem[i].hint      :=FhlKnl1.FreeQuery.fieldbyname('F08').AsString ;
                  GridMenuItem[i].ShortCut  :=Texttoshortcut (FhlKnl1.FreeQuery.fieldbyname('f09').AsString );
                  GridMenuItem[i].ImageIndex:=Taction(UserMenuAction[FhlKnl1.FreeQuery.fieldbyname('F11').asinteger]).ImageIndex  ;
                  GridMenuItem[i].OnClick   := UserMenuAction[FhlKnl1.FreeQuery.fieldbyname('F11').asinteger].OnExecute  ;
                  GridMenuItem[i].Tag       :=0;
                  UserPopMenu.Items.Add(GridMenuItem[i]);
              end;
              FhlKnl1.FreeQuery.Next ;
          end;

          GridMenuItem[UserMenuCont]         :=TMenuItem.Create (UserPopMenu); //control conifg menu visable
          GridMenuItem[UserMenuCont].Caption :='-';
//          GridMenuItem[UserMenuCont].OnClick :=self.ShowConfigMenu;
          UserPopMenu.Items.Add(GridMenuItem[UserMenuCont]);   //
      end
      else
           setlength(GridMenuItem,SysConfigMenu.Items.Count);

      j:=UserMenuCont ;

      for i:=UserMenuCont to    SysConfigMenu.Items.Count -1 +j do
      begin
        if not SysConfigMenu.Items[i].Visible then continue;
          GridMenuItem[i]         :=TMenuItem.Create (UserPopMenu);                     //sys config menu
          GridMenuItem[i].OnClick :=SysConfigMenu.Items [i-j].OnClick ;
          GridMenuItem[i].Name    :=  SysConfigMenu.Items [i-j].Name ;
          GridMenuItem[i].Caption :=SysConfigMenu.Items [i-j].Caption;
          //GridMenuItem[i].Visible :=false;
          GridMenuItem[i].Tag :=1;
          UserPopMenu.Items.Add(GridMenuItem[i]);
      end;
end;

procedure TdmFrm.ActLstDataActionsExecute(Sender: TObject);
var FrmActions:TFrmActions;

begin
     FrmActions:=TFrmActions.Create (self);


     FrmActions.InitFrm(dmfrm.DataSetActionList1  );


     if FrmActions.ShowModal=mrOk then
     begin
          if  tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
          tdbedit(sender).Text:=inttostr( FrmActions.SelectedIndex);
     end ;

     FrmActions.Free;
end;


procedure TdmFrm.ActGridFontColorExecute(Sender: TObject);
var TreeGridFrm :Tform    ;
var i:integer;
var TreeIDS,ID:string;
begin

    if Sender is Tdbedit then
    begin
       if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
    end;
    if Sender is Tmenuitem then
    begin
       id:=inttostr(Tpagecontrol (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Tag );//
    end;

   TreeGridFrm:=FhlUser.ShowModalTreeGridFrmSystool('57',id,true );
   TTreeGridFrm(TreeGridFrm ).ShowModal ;


   
   if Sender is Tdbedit then
   begin
    for i:=0 to TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
    begin
        if i=0 then
            TreeIDS:=    TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F01').AsString
        else
        begin
            if TreeIDS<>   TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F01').AsString then
            begin
                  Tdbedit(sender).Text :=Tdbedit(sender).Text +'TreeIDS 不一致！' ;
                  freeandnil(TreeGridFrm );
                  exit;
            end;
        end;
        TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.next;
    end;
    Tdbedit(sender).Text :=TreeIDS;
  end;

  freeandnil(TreeGridFrm );

end;

function TFhlUser.AddDataSet(Name,TAbleName,CommandText:string; NeedAppend:boolean=false;NeedDefault:boolean=false): string;
begin

      fhlknl1.Kl_GetQuery2('select top 0 * from T201 ',true,true);
      fhlknl1.FreeQuery.Append ;
      fhlknl1.FreeQuery.FieldByName('f02').Value :=name;        //Name
      fhlknl1.FreeQuery.FieldByName('f16').Value :=TAbleName;        //table
      fhlknl1.FreeQuery.FieldByName('f03').Value :=CommandText;

      fhlknl1.FreeQuery.FieldByName('f04').Value :=0;
      if NeedAppend then
         fhlknl1.FreeQuery.FieldByName('f05').Value :=1
      else
         fhlknl1.FreeQuery.FieldByName('f05').Value :=0;

      if NeedDefault then
      begin
          fhlknl1.FreeQuery.FieldByName('f09').Value :=4;
          fhlknl1.FreeQuery.FieldByName('f10').Value :=2;
      end
      else
      begin
          fhlknl1.FreeQuery.FieldByName('f09').Value :=-1;
          fhlknl1.FreeQuery.FieldByName('f10').Value :=-1;
      end;

      fhlknl1.FreeQuery.FieldByName('f11').Value :=-1;
      fhlknl1.FreeQuery.FieldByName('f12').Value :=-1;
      fhlknl1.FreeQuery.FieldByName('f14').Value :=-1;
      fhlknl1.FreeQuery.FieldByName('f15').Value :=-1;
      fhlknl1.FreeQuery.Post ;
      result:=fhlknl1.FreeQuery.FieldByName('f01').Value; //tree data set Id

end;

function TFhlUser.AddGrid(name, datasetID: string): string;
begin

      fhlknl1.Kl_GetQuery2('select top 0 * from T504 ',true,true);
      fhlknl1.FreeQuery.Append ;
      fhlknl1.FreeQuery.FieldByName('F02').Value :=name;
      fhlknl1.FreeQuery.FieldByName('F03').Value :=datasetID;
      fhlknl1.FreeQuery.Post ;
      result:=fhlknl1.FreeQuery.FieldByName('f01').Value; //tree data set Id
end;

function TFhlUser.AddTreeGrid(name, GridID,EditorID,Actions: string;TreeID:integer): string;
begin
      fhlknl1.Kl_GetQuery2('select top 0 * from T612 ',true,true);
      fhlknl1.FreeQuery.Append ;
      fhlknl1.FreeQuery.FieldByName('F02').Value :=name;
      fhlknl1.FreeQuery.FieldByName('F04').Value :=GridID;
      fhlknl1.FreeQuery.FieldByName('F05').Value :=EditorID;
      fhlknl1.FreeQuery.FieldByName('F11').Value :=true;
      fhlknl1.FreeQuery.FieldByName('F09').Value :=Actions;
      if TreeID<>null then
      fhlknl1.FreeQuery.FieldByName('F16').Value :=TreeID;
      fhlknl1.FreeQuery.Post ;
      result:=fhlknl1.FreeQuery.FieldByName('f01').Value; //tree data set Id
end;

function TFhlUser.AddSubInterFace(name, SubInterFaceID,ModelTypeID,TreeGridID,EditorID:string): string;
begin
      fhlknl1.Kl_GetQuery2('select top 0 * from T701 ',true,true);
      fhlknl1.FreeQuery.Append ;
      fhlknl1.FreeQuery.FieldByName('SubInterFaceID').Value :=SubInterFaceID;
      fhlknl1.FreeQuery.FieldByName('SubInterFaceName').Value :=Name;
      fhlknl1.FreeQuery.FieldByName('ModelTypeID').Value :=ModelTypeID;
      fhlknl1.FreeQuery.FieldByName('TreeGridID').Value :=TreeGridID;
      fhlknl1.FreeQuery.FieldByName('EditorID').Value :=EditorID;
      fhlknl1.FreeQuery.FieldByName('IsUse').Value :=true;
      fhlknl1.FreeQuery.FieldByName('Findex').Value :=10;
      fhlknl1.FreeQuery.Post ;
      result:=SubInterFaceID; //tree data set Id
end;



function TFhlUser.GetTableName(datasetID: string): string;
begin
             fhlknl1.Kl_GetQuery2('select * from T201 where f01='+datasetID);
        if not fhlknl1.FreeQuery.IsEmpty then
           result:=fhlknl1.FreeQuery.fieldbyname('F16').AsString ;
end;

procedure TdmFrm.ActGetPingYinExecute(Sender: TObject);
begin
    if  Sender is Tdbedit then
    begin
      if Tdbedit(Sender).Field.DataSet.FindField('F_PingYin')<>nil then
           if  Tdbedit(Sender).Field.DataSet.State in[dsEdit, dsInsert] then
           Tdbedit(Sender).Field.DataSet.FindField('F_PingYin').AsString  := GetHZPY( Tdbedit(Sender).text)
      else
         showmessage('这个表里没有拼音字段.');

    end;

end;

procedure TdmFrm.ActGetDocumentExecute(Sender: TObject);
var fEditorFrm    :TEditorFrmSystool;
var docName:string;
var  strm: TADOBlobStream;
var TmpMemStream:TmemoryStream;
var sql:string;
//var dbfile:TDBFile;
var msword:Variant ;
begin



  if Sender is tdbedit then
  begin
     if  tdbedit(Sender).Text ='' then
     begin
          if messagedlg('点击是选已有文档，点否新增文档？',mtInformation,[mbYes,mbNo],0)=mryes then
          begin
             LookupFrmShowAction1.OnExecute (sender);
          end
          else
          begin
              fEditorFrm:=TEditorFrmSystool(FhlUser.ShowEditorFrmSystool('93',null,nil));
               fEditorFrm.ShowModal;
              begin
                  tdbedit(Sender).Field.Value :=fEditorFrm.DataSource1.DataSet.fieldbyname('F_atuoID').Value ;
                  tdbedit(Sender).Field.DataSet.FieldByName ('F_ContractCodeLKP').value  :=fEditorFrm.DataSource1.DataSet.fieldbyname('F_documentName').Value ;
              end;
          end;
     end
     else
     begin
          if messagedlg('点击是打开合同文档，点否更改文档？',mtInformation,[mbYes,mbNo],0)=mryes then
          begin
                sql:='select * from T_Document where F_AtuoID='+QUOTEDSTR(tdbedit(Sender).Text);
                self.GetQuery1(SQL);

                if not self.FreeQuery1.IsEmpty then
                begin
                      docName:=self.FreeQuery1.FieldByName ('f_documentName').AsString ;
                      TmpMemStream:= TmemoryStream.Create ;
                
                      strm := tadoblobstream.Create(tblobfield(self.FreeQuery1.FindField ('F_File') ),bmread);

                      strm.position :=0;

                      TmpMemStream.LoadFromStream(strm) ;
                      TmpMemStream.Position :=0;

                    try
                        DeCompressStream(TmpMemStream); //     解压数据
                       if  TmpMemStream.Size >0 then
                       begin
                           TmpMemStream.SaveToFile (extractfilepath(application.ExeName )+'tmpdata\'+docName +'.'+self.FreeQuery1.FieldByName('F_attribute').AsString);
                            msword := CreateOleObject( 'word.application' ) ;
                            msword.visible := true ;
                            msword.Documents.open(extractfilepath(application.ExeName )+'tmpdata\'+docName +'.'+self.FreeQuery1.FieldByName('F_attribute').AsString);
                       end;
                    finally
                        msword:=null  ;
                        TmpMemStream.Free ;
                        strm.Free ;
                    end;
               end
               else
               begin
                   showmessage('文档不存在!');
               end;
          end
          else
          begin
              fEditorFrm:=TEditorFrmSystool(FhlUser.ShowEditorFrmSystool('93', tdbedit(Sender).Text,nil));
               fEditorFrm.ShowModal;
              begin
                  tdbedit(Sender).Field.Value :=fEditorFrm.DataSource1.DataSet.fieldbyname('F_atuoID').Value ;
                  tdbedit(Sender).Field.DataSet.FieldByName ('F_ContractCodeLKP').value :=fEditorFrm.DataSource1.DataSet.fieldbyname('F_documentName').Value ;
              end;
          end;
     end;
  end;

end;

procedure TdmFrm.ActParamsT401Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrmSystool('88', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrmSystool(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrmSystool(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);


end;

procedure TFhlUser.ShowSpecialFrm(fFrmId: integer; fOpenParams: Variant);


begin

end;

procedure TdmFrm.IniMainStateBar(PStatusbar: TStatusBar);
var Strvalues :Tstringlist;
var i:integer;
begin
   Strvalues :=Tstringlist.Create ;
    PStatusbar.Panels.Clear;
   FhlKnl1.Kl_GetQuery2('select * from T509 order by F04',true,false);

    with FhlKnl1.FreeQuery do
    begin
      while not eof do
      begin
            with PStatusbar.Panels.Add do
            begin
              Width:=FieldByName('F05').asInteger;
              //Text:=FieldByName('F02').asString;//+FhlUser.GetSysParamVal(FieldByName('F03').asString);
            end;
            Next;
      end;
      Close;
    end;




     Strvalues.Add('[㊣欢迎使用] '+logininfo.SystemCaption ) ;
     Strvalues.Add('登陆名:'+logininfo.LoginId+'   工号:'+logininfo.EmpId  ) ;
     //     getnetcode

 {    dmfrm.GetQuery1('select F_CltName From T_client where  F_type=1 and F_CltCode in (select F_NetCode from T_employee where F_EmpCode='+quotedstr(logininfo.EmpId )+')');
     if not dmfrm.FreeQuery1.IsEmpty then
         Strvalues.Add('所属网点：'+dmfrm.FreeQuery1.fieldbyname('F_CltName').AsString )
     else
         Strvalues.Add('');
}
     Strvalues.Add('') ;

     for i:=0 to Strvalues.Count -1  do
     begin
       PStatusbar.Panels[i].Text :=mainFrm.Statusbar1.Panels[i].Text + Strvalues[i];//FhlUser.GetSysParamVal( Strvalues[i]);
     end;

    Strvalues.Free;

end;

procedure TdmFrm.ActToolBtnsExecute(Sender: TObject);
var TreeGridFrm :Tform    ;
var i:integer;
var ToolBtnsID,ID:string;
begin
    if Sender is Tdbedit then
    begin
       if Tdbedit(sender).Text ='' then
            id:='1'
       else ID:=Tdbedit(sender).Text;
    end;
    if Sender is Tmenuitem then
    begin
       id:=inttostr(Tpagecontrol (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Tag );//
    end;

   TreeGridFrm:=FhlUser.ShowModalTreeGridFrmSystool('59',id,true );
   TTreeGridFrm(TreeGridFrm ).ShowModal ;


   if Sender is Tdbedit then
   begin
    for i:=0 to TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
    begin
        if i=0 then
            ToolBtnsID:=    TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F02').AsString
        else
        begin
            if ToolBtnsID<>   TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F02').AsString then
            begin
                  Tdbedit(sender).Text :=Tdbedit(sender).Text +'ToolBtns iD 不一致！' ;
                  freeandnil(TreeGridFrm );
                  exit;
            end;
        end;
        TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.next;
    end;
    Tdbedit(sender).Text :=ToolBtnsID;
  end;

  freeandnil(TreeGridFrm );

end;

procedure TdmFrm.ActLkpImportExecute(Sender: TObject);
var TreeGridFrm :Tform    ;
var i:integer;
var LkpImportID,ID:string;
begin
    if Sender is Tdbedit then
    begin
       if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
    end;
    if Sender is Tmenuitem then
    begin
       id:=inttostr(Tpagecontrol (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Tag );//
    end;

   TreeGridFrm:=FhlUser.ShowModalTreeGridFrmSystool('60',id,true );
   TTreeGridFrmSystool(TreeGridFrm ).ShowModal ;

   if Sender is Tdbedit then
   begin
        LkpImportID:=    TTreeGridFrmSystool(TreeGridFrm ).ADODataSet1.fieldbyname('F01').AsString
   end;
   Tdbedit(sender).Text :=LkpImportID;

   freeandnil(TreeGridFrm );

end;

procedure TdmFrm.ActBillExActsExecute(Sender: TObject);
var FrmActions:TFrmActions;
var modelID:integer;
var form:Tform;
var strlst:Tstrings;
begin
     FrmActions:=TFrmActions.Create (nil);

     form:=TFrmBillEx.Create(nil);
     FrmActions.InitFrm(TFrmBillEx(form).ActionList1 );
     form.free;

    if FrmActions.ShowModal=mrOk then
    begin
        strlst:=FrmActions.ActionGrid.Rows[FrmActions.SelectedIndex];
        tdbedit(sender).Text:=strlst[0];
        tdbedit(sender).Field.DataSet.FieldByName('F16').Value:=FrmActions.SelectedIndex;//
        tdbedit(sender).Field.DataSet.FieldByName('F04').Value:=strlst[1];
    end ;
    FrmActions.Free;
end;


procedure TdmFrm.InstallBillDetial(ADODataset: TADODataset);

begin

end;
procedure TdmFrm.InstallBillDetial(F_InstallID: string);

begin




end;

{ procedure TdmFrm.InstallBillDetial(ADODataset: TADODataset);
var QFrame_Installs:TQFrame_Installs;
var Form:Tform;
begin
      Form:=Tform.Create(nil);
       Form.AutoSize :=true;
      Form.Caption :='安装单';
      QFrame_Installs:=TQFrame_Installs.Create (Form);
      QFrame_Installs.Parent := Form ;
      //QFrame_Installs.Align :=alclient;
      QFrame_Installs.AutoSize :=true;
      DM.QInitFrameConnection(QFrame_Installs,dmfrm.ADOConnection1,logininfo.EmpId  );
      QFrame_Installs.QShowInstallInfoP(ADODataset);

      Form.Position :=poScreenCenter ;
      Form.ShowModal ;
end;
QU_FEditInstallinfo   }


Procedure TdmFrm.RepaireBillDetial(F_RprApplyid:string );
 begin


end;


procedure TdmFrm.ActGetSprCodeExecute(Sender: TObject);
    var fld:TField;
    var value,filters:string;
    var LkpDataSet:TDataSet;
    var SQL:String;
begin
  Screen.Cursor:=crSqlwait;

 try
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField ;

      if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
      begin

         with TLookupFrm.Create(Application) do
         begin
             InitFrm(fld);

             if Sender is TAction then
              begin
                 fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField;
                 value:=fld.DataSet.fieldbyname('F_SpareCode').AsString ;
                 if fld.DataSet.FindField ('F_SprAbortCodeLkp')<>nil then
                    LkpDataSet:= fld.DataSet.FieldByName('F_SprAbortCodeLkp').LookupDataSet;

                 if fld.DataSet.FindField ('F_ScrapRsnLkp')<>nil then
                    LkpDataSet:= fld.DataSet.FieldByName('F_ScrapRsnLkp').LookupDataSet;

                 if fld.DataSet.FindField ('F_ReturnVenderRsnLkp')<>nil then
                    LkpDataSet:= fld.DataSet.FieldByName('F_ReturnVenderRsnLkp').LookupDataSet;
                    
                 if fld.DataSet.FindField ('F_RtnWorkShopRsnLkp')<>nil then
                    LkpDataSet:= fld.DataSet.FieldByName('F_RtnWorkShopRsnLkp').LookupDataSet;


                 LkpDataSet.Filtered  :=false;
                 filters:='  A join T_Spare B on A.F_SpType=B.F_Type where B.F_SpareCode='+quotedstr(value);
                 //LkpDataSet.Filter :=filters;
                 //LkpDataSet.Filtered :=true;
              end;

             ADODataSet1.Close ;
             SQL :=ADODataSet1.CommandText  +filters+' order by F_SpareCode';
             ADODataSet1.CommandText :=   SQL ;
             ADODataSet1.Open ;

             ShowModal;
             free;
         end;
      end;
 finally
  Screen.Cursor:=crDefault;
 end;

end;

procedure TdmFrm.ExportExcelClick(Sender: TObject);  //zxh 08.2.18
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
  QExportExcel(PopDbgrid,TForm(PopDbgrid.Parent).Caption+formatdatetime('yyyymmdd',now), true);
end;

procedure TFhlUser.FmClose(Sender: TObject; var Action: TCloseAction);
begin 
Action:=caFree;
end;

procedure TdmFrm.uLookupFrmShowAction1Execute(Sender: TObject);
 var fld:TField;
begin
  Screen.Cursor:=crSqlwait;
 try
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;

  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
 
     with TLookupFrm.Create(Application) do
     begin
       InitFrm(fld);
       if Sender is tdbedit  then
       Edit1.Text:=(Sender as tdbedit   ).Text ;
       ShowModal;
       free;
     end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;

 if Sender is Tedit then
 TEdit(Sender).Modified:=False;
end;

procedure TdmFrm.uTreeDlgFrmShowAction1Execute(Sender: TObject);
 var fld:TField;
 form  : TAnalyseEx;
begin
 Screen.Cursor:=crSqlwait;
 try
       if Sender is TAction then
          fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
       else
          fld:=TDbEdit(Sender).Field;

       //form  :=TDbEdit(Sender).parent.parent as TAnalyseEx;
       if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
       begin
           with TTreeDlgFrm.Create(Application) do
           begin
             InitFrm(fld);
             AllowPickParentNode:= form<>nil;
             ShowModal;
             free;
           end;
       end;
 finally
      Screen.Cursor:=crDefault;
 end;
end;

procedure TdmFrm.uDateFrmShowAction1Execute(Sender: TObject);
var
  fld:TField;
  dt:TDateTime;
  isNull:boolean;
begin
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;
  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
    if fld.asString<>'' then
      dt:=fld.asDateTime
    else
      dt:=Now;
    if FhlKnl1.Md_ShowDateFrm(dt,isNull)=mrOk then
    begin
      if not (fld.DataSet.State=dsInsert) and Not (fld.DataSet.State=dsEdit) then
         fld.DataSet.Edit;
      if  isNull then
      begin
          fld.Value :=null;
      end
      else
      begin
          if fld.DataType=ftDate then
             fld.asString:=formatdatetime('yyyy"-"mm"-"dd',dt)
          else if fld.DataType=ftDateTime then
             fld.AsString:=formatdatetime('yyyy"-"mm"-"dd hh":"nn":"ss',dt);//+' '+formatdatetime('hh":"nn":"ss',dt);
      end;
    end;
  end;
end;

procedure TdmFrm.uDbGridEditBtnClickAction1Execute(Sender: TObject);
begin

  with DbCtrlActionList1.Actions[FhlKnl1.Dg_GetDbGrdEdtActnId(TDbGrid(Sender))] do
  begin
      ActionComponent:=TComponent(Sender);
      Execute;
  end;
end;

procedure TdmFrm.uactCheckRangExecute(Sender: TObject);
var fld:   TField;
   msg:string;
begin
    if (sender is TDbEdit) then
    begin
          fld:=TDbEdit(Sender).Field;
          if (fld is TfloatField) or (fld is TCurrencyField) then
          begin
              if  strtofloat ((sender as TDbEdit).Text)<TfloatField(fld  ).MinValue then
              begin
                   msg:=fld.FieldName +'不能小于'  +floattostr(TfloatField(fld  ).MinValue);
              end;
              if  strtofloat ((sender as TDbEdit).Text)>TfloatField(fld  ).MaxValue then
              begin
                  msg:=fld.FieldName +'不能大于'  +floattostr(TfloatField(fld  ).MaxValue);
              end;
          end;
          if (fld is TintegerField) then
          begin
              if  strtoint ((sender as TDbEdit).Text)<TintegerField(fld  ).MinValue then
              begin
                   msg:=fld.FieldName +'不能小于'  +inttostr(TintegerField(fld  ).MinValue);
              end;
              if  strtoint ((sender as TDbEdit).Text)>TintegerField(fld  ).MaxValue then
              begin
                  msg:=fld.FieldName +'不能大于'  +inttostr(TintegerField(fld  ).MaxValue);
              end;
          end;

    end;


end;
 

procedure TdmFrm.uactCaCulExecute(Sender: TObject);
Var fld:Tfield;

//=============
var Fields,formula:Tstringlist;
var ResultField,Calc,fieldValue:string;
var I,J:integer;
var  vScript: Variant;
var Presult:double;

begin


  fld:=TDbEdit(Sender).Field ;
if     fld.Text='' then
exit;
//a:=(b+c)*d/f+g*h

  Fields:=Tstringlist.Create ;
  formula:=Tstringlist.Create ;
  formula.NameValueSeparator :='=';
  vScript := CreateOleObject('ScriptControl');
  vScript.Language := 'JavaScript';


   fhlknl1.Kl_GetQuery2('select * From T202 where f08<>'' and f09<>'' and  f02 ='+inttostr(fld.DataSet.Tag ));

  if    not fhlknl1.FreeQuery.IsEmpty then
  begin
        for i:=0 to fhlknl1.FreeQuery.RecordCount -1 do
        begin
                Fields.Clear ;
                formula.Clear;
                formula.NameValueSeparator :='=';
                Fields.CommaText := fhlknl1.FreeQuery.FieldByName('F09').asString;
                formula.CommaText := string(fhlknl1.FreeQuery.FieldByName('F08').asString);
                ResultField:=   formula.Names [0] ;
                Calc:=formula.values[ResultField] ;

                for J:=0 to   Fields.Count -1 do
                begin
                     if fld.DataSet.Fieldbyname(Fields[j]).AsFloat <0 then
                        FieldValue:='('+ Tadodataset(fld.DataSet).Fieldbyname(Fields[j]).AsString +')'
                     else
                        FieldValue:= Tadodataset(fld.DataSet).Fieldbyname(Fields[j]).AsString ;
                     if   FieldValue='' then FieldValue:='0';
                    Calc:= stringreplace(trim(Calc),trim(Fields[j]),trim(FieldValue ),[rfIgnoreCase ]);
                end;
                Presult   := vScript.Eval(Calc);
               Tadodataset(fld.DataSet).FieldByName(ResultField).AsCurrency := Presult;
               fhlknl1.FreeQuery.Next ;
        end;
  end;



end;


procedure TdmFrm.uActGetPingYinExecute(Sender: TObject);
begin
    if  Sender is Tdbedit then
    begin
        if Tdbedit(Sender).Field.DataSet.FindField('FPhoneticize')<>nil then
             if  Tdbedit(Sender).Field.DataSet.State in[dsEdit, dsInsert] then
             begin
                Tdbedit(Sender).Field.DataSet.FindField('FPhoneticize').AsString  := GetHZPY( Tdbedit(Sender).text);
                if Tdbedit(Sender).Field.DataSet.FindField('FPhoneticize').AsString  ='' then
                begin
                    fhlknl1.Kl_GetUserQuery(' select dbo.FN_GetPhoneticize (' + quotedstr(Tdbedit(Sender).text) +')') ;
                    Tdbedit(Sender).Field.DataSet.FindField('FPhoneticize').AsString:=fhlknl1.User_Query.Fields[0].AsString ;
                end;

             end;
    //    else           showmessage('这个表里没有拼音字段.');

    end;

end;

procedure TdmFrm.actUloadpicExecute(Sender: TObject);
begin
//dlgOpenPic1.Filter :='Bitmaps (*.bmp)|(*.jpg)';
  if dlgOpenPic1.Execute then
    if     dlgOpenPic1.FileName <>'' then
    begin
      if Sender is TdbImage then
         (Sender as TdbImage).Picture.LoadFromFile(dlgOpenPic1.FileName );

      if (Sender is TFhlImage )  then
      begin
         (Sender as TFhlImage).Picture.LoadFromFile(dlgOpenPic1.FileName );
         (Sender as TFhlImage).Picture.LoadFromFile(dlgOpenPic1.FileName );
      end;
    end;
end;

procedure TFhlUser.LogUserRecord(pdataset: Tdataset;OperateType :string);
var fTableName:string; 
begin
    // merger log table fields
    //insert into value
    fhlknl1.Kl_GetQuery2('select F16 from T201 where f01='+inttostr(pdataset.Tag ) ) ;
    fTableName:=fhlknl1.FreeQuery.Fields[0].AsString ;

    if (fTableName='' ) or (pdataset.Fields.FindField('F_ID')=nil  ) or (pos('%',fTableName)>0 ) then
    begin
     exit;
    end;

    dmFrm.FreeStoredProc1.ProcedureName :='Pr_MergerUandLogTableFlds';
    dmFrm.FreeStoredProc1.Parameters.Clear;
    dmFrm.FreeStoredProc1.Parameters.Refresh ;
    if dmFrm.FreeStoredProc1.Parameters.FindParam  ('@MainTable')=nil then exit;
    
    dmFrm.FreeStoredProc1.Parameters.ParamByName ('@MainTable').Value :=  fTableName;
    dmFrm.FreeStoredProc1.Parameters.ParamByName('@Empid').Value :=  logininfo.EmpId ;
    dmFrm.FreeStoredProc1.Parameters.ParamByName('@OperateType').Value :=  OperateType ;
    dmFrm.FreeStoredProc1.Parameters.ParamByName('@F_ID').Value :=  pdataset.Fields.fieldbyname('F_ID').AsString ;

        dmFrm.FreeStoredProc1.Parameters.ParamByName('@PubDataBase').Value :=logininfo.SysDBPubName  ;
        dmFrm.FreeStoredProc1.Parameters.ParamByName('@LogDataBase').Value :=  logininfo.LogDataBaseName  ;
    dmFrm.FreeStoredProc1.Parameters.ParamByName('@FCurUserDBName').Value :=  dmfrm.ADOConnection1.DefaultDatabase ;

    dmFrm.FreeStoredProc1.ExecProc;
end;

procedure TdmFrm.LocateCurrentMenu(MenuID: string);
var menuitem:TMenuitem;
begin
    try
      menuitem:=TMenuitem.Create (nil);
      menuitem.Name :=  MenuID ;;
      DesktopFrm.FrmActExecute(menuitem);
    finally
       menuitem.Free ;
    end

end;

function TFhlUser.GetUserTableName(pdataset: Tdataset):string;
var fTableName:string;
begin
     fhlknl1.Kl_GetQuery2('select F16 from T201 where f01='+inttostr(pdataset.Tag ) ) ;
     fTableName:=fhlknl1.FreeQuery.Fields[0].AsString ;
     result:=fTableName ;
end;

procedure TFhlUser.showLogwindow(pdbgrid:Tdbgrid )overload;
var form: TAnalyseEx;
var col:Tcolumn;
var I,j:integer;
var fld:Tfield;
begin
    inherited;
    sDefaultVals:='';
    sDefaultVals:=sDefaultVals+'fuserTableEname='+fhluser.GetUserTableName  (pdbgrid.DataSource.DataSet )+',';
  //  sDefaultVals:=sDefaultVals+'FCalculateFlds='+fhlknl1.GetCalculateFldsForLogSys (pdbgrid.DataSource.DataSet )+',';
    sDefaultVals:=sDefaultVals+'F_ID='+ pdbgrid.DataSource.DataSet.fieldbyname('F_ID').AsString ;



    form:= TAnalyseEx( fhluser.ShowAnalyserFrm  ('258',null,'' ,fsNormal));
    form.DBGdCurrent.PopupMenu:=nil;
    form.mtADODataSet1.FieldByName('FCalculateFlds').AsString := fhlknl1.GetCalculateFldsForLogSys (pdbgrid.DataSource.DataSet ) ;

    FhlUser.SetDbGridAndDataSet(form.DBGdCurrent ,inttostr(pdbgrid.tag ),null,false   );



   // FhlUser.SetDbGrid (inttostr(pdbgrid.tag ),form.DBGdCurrent    );

    tadodataset(form.DBGdCurrent.DataSource.DataSet ).CommandText :='Pr_LstUserDataLog';
    tadodataset(form.DBGdCurrent.DataSource.DataSet ).CommandType  :=cmdStoredProc;

    fld:=TStringField.Create(form.DBGdCurrent.DataSource.DataSet );
    fld.FieldName :='SysOperateName'     ;
    fld.DataSet:=  form.DBGdCurrent.DataSource.DataSet ;
    col:= form.DBGdCurrent.Columns.Add;
    col.FieldName :='SysOperateName'     ;
    col.Width :=100;
    col.Title.Caption  :='操作人';

    fld:=TDateTimeField	.Create(form.DBGdCurrent.DataSource.DataSet );
    fld.FieldName := 'FSYSLOGoperateDate';
    fld.DataSet:=  form.DBGdCurrent.DataSource.DataSet ;
    col:=form.DBGdCurrent.Columns.Add;
    col.Width :=150;
    col.FieldName :='FSYSLOGoperateDate';
    col.Title.Caption  :='操作时间';

    fld:=TStringField.Create(form.DBGdCurrent.DataSource.DataSet );
    fld.FieldName :='FSYSLOGperateTypeName';
    fld.DataSet:=  form.DBGdCurrent.DataSource.DataSet ;
    col:=form.DBGdCurrent.Columns.Add;
    col.Width :=100;
    col.FieldName :='FSYSLOGperateTypeName';
    col.Title.Caption  :='操作类型';  { }
    form.FormStyle  :=fsNormal;
    form.hide;
    form.ShowModal   ;
    form.free;
end;

procedure TdmFrm.ActGetGUIDExecute(Sender: TObject);
begin
    if  Sender is Tdbedit then
    begin
             Tdbedit(Sender).Field.AsString   := GetGUID;
    end;
end;

function TFhlUser.Validation(PdataSet: Tdataset;isBFP,isAFP,isBFD,isAFD,isBFChk,isBFUNchk:boolean): boolean;
var tableEname,fsql,fields,fsqlVd,fsqlCon:widestring;
var FldLst:Tstringlist;
var I,j,k:integer;
begin
    fhlknl1.Kl_GetQuery2( 'select F16 From T201 where f01='+inttostr(PdataSet.Tag ));
    if  fhlknl1.FreeQuery.IsEmpty then exit;
    tableEname:= fhlknl1.FreeQuery.FieldByName('F16').AsString ;
    if tableEname='' then exit;

    fsqlVd:='select * from '+logininfo.SysDBPubName +'.dbo.TValidation where benable=1 and fTableName= '+quotedstr(tableEname ) ;
    if isBFP then fsqlCon:='and bBeforePost=1'    ;
    if isBFD then fsqlCon:='and bBeforeDelete=1'  ;
    if isBFChk then fsqlCon:='and bBeforeChk=1'   ;
    if isBFUNchk then fsqlCon:='and bBeforeUnChk=1' ;
    fhlknl1.Kl_GetQuery2(fsqlVd+ fsqlCon);


    if  fhlknl1.FreeQuery.IsEmpty then exit;


    try
      FldLst:=Tstringlist.Create ;
      while (not fhlknl1.FreeQuery.Eof )do
      begin
          fsql:= fhlknl1.FreeQuery.FieldByName('fsql').AsString ;
          fields:=fhlknl1.FreeQuery.FieldByName('FFieldsUsed').AsString ;
          FldLst.Clear ;
          FldLst.CommaText:=fields ;
          for i:=0 to FldLst.Count -1 do
          begin
              if  FldLst[i] <>'' then
              begin
                FldLst[i]:=trim(FldLst[i]);
                if PdataSet.findfield (FldLst[i])<>nil then
                   if    (  PdataSet.fieldbyname(FldLst[i]) is Tstringfield )
                      or (  PdataSet.fieldbyname(FldLst[i]) is TDateField	 )
                      or (  PdataSet.fieldbyname(FldLst[i]) is TDateTimeField		 )                  then
                      fsql:=stringreplace(fsql,'@'+FldLst[i] ,quotedstr( PdataSet.fieldbyname(FldLst[i]).AsString) ,[])
                    else
                      fsql:=stringreplace(fsql,'@'+FldLst[i] ,PdataSet.fieldbyname(FldLst[i]).Value  ,[])  ;

                if uppercase(leftstr(FldLst[i],1))='S' then
                   fsql:=stringreplace(fsql,'@'+FldLst[i] ,quotedstr( FhlUser.GetSysParamVal(FldLst[i])) ,[])  ;
              end;
          end;
          fhlknl1.Kl_GetUserQuery(fsql  ,false);
          fhlknl1.FreeQuery.Next;
      end;
    finally
      FldLst.Free ;
    end;
end;

function TFhlUser.GetMonthClsDate: Tdatetime;
var sql:string;
begin
    sql:='select isnull( ';
    sql:=sql+'(select Fmonth From TInvCostAcctMonthEndClose where FisClosed=1 and Fmonth=(select max(Fmonth)From TInvCostAcctMonthEndClose where FisClosed=1) )   ';
    sql:=sql+', (select convert(smalldatetime,FParamValue) From TParamsAndValues where FParamCode=''01050202''))' ;

    fhlknl1.Kl_GetUserQuery( sql);
    if not fhlknl1.User_Query .IsEmpty then
        result:= fhlknl1.User_Query.Fields[0].AsDateTime
    else
        result:= strtodatetime('2011-01-01') ;
end;

procedure TdmFrm.DbGridPopupMenu1Popup(Sender: TObject);
var MClearFilter:Tmenuitem;
begin
  if tdbgrid( (Tpopupmenu(  sender ).PopupComponent )).DataSource=nil then Exit;
  if  tdbgrid( (Tpopupmenu(  sender ).PopupComponent )).DataSource.DataSet.Active then 
      if  tdbgrid( (Tpopupmenu(  sender ).PopupComponent )).DataSource.DataSet.Filter <>'' then
      begin
        if (Tpopupmenu( sender )).Items.Find('取消过滤')=nil then
        begin
          MClearFilter:=Tmenuitem.Create (Tpopupmenu( sender ));
          MClearFilter.Name :='MClearFilter';
          MClearFilter.Caption :='取消过滤';
          MClearFilter.OnClick := ClearFilter;
           Tpopupmenu(  sender ).Items.Insert(0, MClearFilter) ;
        end;
      end;
//ExportExcel.Visible  := logininfo.isAdmin or logininfo.Sys  ;
end;

procedure TdmFrm.DbGridPopupMenu1Change(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
var MClearFilter:Tmenuitem;
begin
  if Sender is Tdbgrid then
  begin
    if  tdbgrid(Sender).DataSource.DataSet.Filter <>'' then
    begin
      MClearFilter:=Tmenuitem.Create (DbGridPopupMenu1);
      DbGridPopupMenu1.Items.Add( MClearFilter) ;

    end;
  end;

end;

procedure TdmFrm.ClearFilter(sender: Tobject);
var MClearFilter:Tmenuitem;
begin
  Tdbgrid((Tpopupmenu(Tmenuitem(sender).Owner )).PopupComponent ).DataSource.DataSet.Filter :='';
  Tdbgrid((Tpopupmenu(Tmenuitem(sender).Owner )).PopupComponent ).DataSource.DataSet.Filtered  :=true;

  MClearFilter:=Tpopupmenu(Tmenuitem(sender).Owner ).Items[0];
//  if MClearFilter.Caption :=''
  MClearFilter.Free ;
end;



procedure TFhlUser.showLogwindow(PdataSet: Tdataset ;BoxTop,BoxBtm:string ) overload;
var form: TAnalyseEx;
var col:Tcolumn;
var I,j:integer;
var fld:Tfield;
begin
    inherited;
    sDefaultVals:='';
    sDefaultVals:=sDefaultVals+'fuserTableEname='+fhluser.GetUserTableName  ( PdataSet  )+',';
    sDefaultVals:=sDefaultVals+'F_ID='+ PdataSet.fieldbyname('F_ID').AsString ;



    form:= TAnalyseEx( fhluser.ShowAnalyserFrm  ('258',null,'' ,fsNormal));
    form.DBGdCurrent.PopupMenu:=nil;
    form.mtADODataSet1.FieldByName('FCalculateFlds').AsString := fhlknl1.GetCalculateFldsForLogSys (PdataSet ) ;

    form.mtADODataSet1.FieldByName('FSelectClause').AsString := GetUserTableNameSelectClause   (PdataSet ) ;

   // FhlUser.SetDbGridAndDataSet(form.DBGdCurrent ,inttostr(pdbgrid.tag ),null,false   );


    for i:=0 to   PdataSet.FieldCount-1 do
    begin
      if not ( IsFieldShowed ( IntToStr( PdataSet.Fields[i].tag  ),BoxTop)  or IsFieldShowed ( IntToStr( PdataSet.Fields[i].tag  ),BoxBtm)  )then Continue;

      col:= form.DBGdCurrent.Columns.Add;
      col.FieldName :=PdataSet.Fields[i].FieldName  ;
      col.Width :=100;
      col.Title.Caption  :=GetFieldCaption (IntToStr( PdataSet.Fields[i].Tag ));

      // form.DBGdCurrent.DataSource.DataSet.Fields.Add(  PdataSet.Fields[i]);
    end;

    tadodataset(form.DBGdCurrent.DataSource.DataSet ).CommandText :='Pr_LstUserDataLog';
    tadodataset(form.DBGdCurrent.DataSource.DataSet ).CommandType  :=cmdStoredProc;


{    fld:=TStringField.Create(form.DBGdCurrent.DataSource.DataSet );
    fld.FieldName :='SysOperateName'     ;
    fld.DataSet:=  form.DBGdCurrent.DataSource.DataSet ;
    }
    col:= form.DBGdCurrent.Columns.Add;
    col.FieldName :='SysOperateName'     ;
    col.Width :=100;
    col.Title.Caption  :='操作人';

   { fld:=TDateTimeField	.Create(form.DBGdCurrent.DataSource.DataSet );
    fld.FieldName := 'FSYSLOGoperateDate';
    fld.DataSet:=  form.DBGdCurrent.DataSource.DataSet ;}
    col:=form.DBGdCurrent.Columns.Add;
    col.Width :=150;
    col.FieldName :='FSYSLOGoperateDate';
    col.Title.Caption  :='操作时间';

    {
    fld:=TStringField.Create(form.DBGdCurrent.DataSource.DataSet );
    fld.FieldName :='FSYSLOGperateTypeName';
    fld.DataSet:=  form.DBGdCurrent.DataSource.DataSet ;}
    col:=form.DBGdCurrent.Columns.Add;
    col.Width :=100;
    col.FieldName :='FSYSLOGperateTypeName';
    col.Title.Caption  :='操作类型';  { }
                    {}
    form.FormStyle  :=fsNormal;
    form.hide;
    form.ShowModal   ;
    form.free;
end;

function TFhlUser.GetUserTableNameSelectClause(pdataset: Tdataset): string;
var fTableName:string;
var cmd :string;
begin
     fhlknl1.Kl_GetQuery2('select F03,F16 from T201 where f01='+inttostr(pdataset.Tag ) ) ;
     cmd :=       fhlknl1.FreeQuery.Fields[0].AsString ;
     fTableName:=fhlknl1.FreeQuery.Fields[1].AsString ;

     result:=Copy(cmd,0,Pos('From' ,cmd)-1 ) ;

end;

function TFhlUser.GetFieldCaption(FieldID: string): string;

begin
             fhlknl1.Kl_GetQuery2('select f09 from T102 where f01='+FieldID);
        if not fhlknl1.FreeQuery.IsEmpty then
           result:=fhlknl1.FreeQuery.fieldbyname('f09').AsString ;

end;

function TFhlUser.IsFieldShowed(fieldid,Boxid:string    ): boolean;
  var i:integer;
begin
//
FhlKnl1.Kl_GetQuery2('select *From T502 where f02='+quotedstr(Boxid)+' and F03='+fieldid)   ;
 if  not FhlKnl1.FreeQuery.IsEmpty then
   Result :=True
   else
   Result:=False;
end;
procedure TFhlUser.LogUserRecord(pdataset: Tdataset );
var OperateType: string;
begin
   if pdataset.State =dsBrowse then
      OperateType :=  'delete'
    else
      OperateType :=  'update' ;

  LogUserRecord(pdataset,OperateType);
end;

procedure TFhlUser.ShowVoucher(fFrmId, fCode, pTmpTableName: string);
begin
  Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('Voucher'+fFrmId)=nil then   // if find then form then show the form
  begin
    with TFrmBillVoucher.Create(Application) do
    begin
      FWindowsFID:=DesktopFrm.dsMainMenu.FieldByName('F_ID').AsString ;
      PAuthoriseTmpTable:=pTmpTableName;
      InitFrm(fFrmId);
      SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
      Name:='Voucher'+fFrmId;
   
      Show  ;
   if fCode<>'' then
        OpenBill(fCode);
//      else
//        NewBtn.Click
    end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

end.


