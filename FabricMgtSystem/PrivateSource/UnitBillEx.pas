unit UnitBillEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ActnList, DB, ADODB, ToolWin, Grids, DBGrids,FhlKnl, StrUtils,
  UnitLookUpImport, datamodule,  StdCtrls, ExtCtrls,UnitGrid,UnitModelFrm,DBCtrls, UnitMulPrintModule ,
  UnitIBillEx, XPMenu;

type
  TFrmBillEx = class(TFrmModel,IBillEx)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    ScrollTop: TScrollBox;
    Label3: TLabel;
    ScrollBtm: TScrollBox;
    ToolBar1: TToolBar;
    mtDataSource1: TDataSource;
    DlDataSource1: TDataSource;
    dlDataSet1: TADODataSet;
    mtDataSet1: TADODataSet;
    ActionList1: TActionList;
    MailAction1: TAction;
    PrintAction1: TAction;
    OpenAction1: TAction;
    NewAction1: TAction;
    RemoveAction1: TAction;
    CancelAction1: TAction;
    SaveAction1: TAction;
    CheckAction1: TAction;
    ImportAction1: TAction;
    AppendAction1: TAction;
    DeleteAction1: TAction;
    RefreshAction1: TAction;
    LocateAction1: TAction;
    CloseAction1: TAction;
    HelpAction1: TAction;
    FirstAction1: TAction;
    PriorAction1: TAction;
    NextAction1: TAction;
    LastAction1: TAction;
    FaxAction1: TAction;
    MainMenu1: TMainMenu;
    ToolButton2: TToolButton;
    LblState: TLabel;
    PnlRight: TPanel;
    PnlLeft: TPanel;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    tlbtnimport: TToolButton;
    ActInfo: TAction;
    PnlFunction: TPanel;
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    BtnShowHead: TToolButton;
    ActShowHead: TAction;
    BtnRecLocate: TToolButton;
    ActLocate: TAction;
    GroupBox1: TGroupBox;
    CmbFlds: TComboBox;
    EdtValues: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    LblTitle: TLabel;
    PnlGrid: TPanel;
    ActEdit: TAction;
    ToolButton8: TToolButton;
    PnlBtm: TPanel;
    ActSetBit: TAction;
    ActSaveExecDLProc: TAction;
    UserLog: TAction;
    ToolButton9: TToolButton;
    ActUncheck: TAction;
    PgBarSave: TProgressBar;
    ActSaveHaveTextFomula: TAction;
    ActChkChg: TAction;
    ActProperty: TAction;
    actMainLog: TAction;
    statLabel1: TLabel;
    btnCtrl: TToolButton;
    InActiveBill: TAction;
    ActiveBill: TAction;
    actMDLookup: TAction;
    ActSaveHaveTextFomulaZeroQty: TAction;
    ActApportion: TAction;
    PnlContent: TPanel;
    PnlBtmControls: TPanel;
    ActOri: TAction;
    procedure OpenCloseAfter(IsOpened:Boolean);
    procedure SetCtrlStyle(fEnabled:Boolean);
    procedure SetRitBtn;
    procedure SetCheckStyle(IsChecked:Boolean);
    procedure SetBillStyle(fReadOnly:Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBill;
    procedure EditPostAfter(IsEnabled:Boolean);
    procedure ScrollTopDblClick(Sender: TObject);
    procedure ScrollBtmDblClick(Sender: TObject);
    procedure DBGridDLDblClick(Sender: TObject);
    procedure dlDataSet1CalcFields(DataSet: TDataSet);
    procedure dlDataSet1AfterPost(DataSet: TDataSet);
    procedure DlDataSource1StateChange(Sender: TObject);
    procedure mtDataSource1StateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridDLExit(Sender: TObject);
    procedure OpenAction1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure CancelAction1Execute(Sender: TObject);
    procedure UpdateSysFieldsAndCalValue;
    procedure Ds_UpdateAllRecs(fGrid:Tdbgrid;fFields,fValues:Variant;PPgBarSave:Tprogressbar ;DelOnCalEvent:boolean=true);
    procedure SaveAction1Execute(Sender: TObject);
    procedure ImportAction1Execute(Sender: TObject);
    procedure CheckAction1Execute(Sender: TObject);
    procedure ActInfoExecute(Sender: TObject);
    procedure FirstAction1Execute(Sender: TObject);
    procedure PriorAction1Execute(Sender: TObject);
    procedure NextAction1Execute(Sender: TObject);
    procedure LastAction1Execute(Sender: TObject);
    procedure AppendAction1Execute(Sender: TObject);
    procedure NewAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure dlDataSet1AfterScroll(DataSet: TDataSet);
    procedure ActSaveWithOutDLExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure ActRemMchSvPayExecute(Sender: TObject);
    procedure ActlocateExecute(Sender: TObject);
    procedure CmbFldsChange(Sender: TObject);
    procedure EdtValuesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActSlAftMchOrderExecute(Sender: TObject);
    procedure BtnRecLocateClick(Sender: TObject);
    procedure ActShowHeadExecute(Sender: TObject);
    procedure PnlBtmDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure RemoveAction1Execute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure ActSetBitExecute(Sender: TObject);
    procedure PrintAction1Execute(Sender: TObject);
    procedure ActSaveExecDLProcExecute(Sender: TObject);
    procedure ActUncheckExecute(Sender: TObject);
    procedure RefreshAction1Execute(Sender: TObject);
    procedure ActSaveHaveTextFomulaExecute(Sender: TObject);
    procedure ActChkChgExecute(Sender: TObject);
    procedure UserLogExecute(Sender: TObject);
    procedure ActPropertyExecute(Sender: TObject);
    procedure btnCtrlClick(Sender: TObject);
    procedure InActiveBillExecute(Sender: TObject);
    procedure ActiveBillExecute(Sender: TObject);
    procedure actMDLookupExecute(Sender: TObject);
    procedure ActSaveHaveTextFomulaZeroQtyExecute(Sender: TObject);
    procedure ActApportionExecute(Sender: TObject);
    procedure ResetPnlContentSize( importMode: boolean );
    procedure ActOriExecute(Sender: TObject);
  private
    { Private declarations }
    F_ParamData:TDataset;
    fBillex:TBillDictEx;
    fOpenBillDict:TLkpImportDict;
    fOpenImportDict:TLkpImportDict;
    fDbGridColsColor:Variant;
    FrmLoopUpImPortEx:TFrmLoopUpImPortEx      ;//相关
    FrmImPort:TFrmLoopUpImPortEx      ;              //录入
    F_FlagFldName,F_FlagCompeleteState:string;

    DBGridDL:TModelDbGrid;
  public

    Procedure InitFrm(frmid :string );
    Procedure OpenBill(BillCode :string );
    procedure SetParamDataset(PDataset:Tdataset);
    procedure DBLClick(sender :Tobject);
    function  FirstCommarSection(Pstr:string):string;

    { Public declarations }
  end;

const
  cBillManId='F_BillManId';
  cIsChk='F_IsChk';
  cChkTime='F_ChkTime';

var
  FrmBillEx: TFrmBillEx;

implementation
        uses   Editor,   UnitCreateComponent,UnitUserDefineRpt,UnitUserReport,UPublicFunction,UnitFrmAnalyserEx ,UnitCtrlConfig ,UnitMDLookupImport;
{$R *.dfm}

procedure TFrmBillEx.InitFrm(frmid: string);
var i:integer;
begin
//ini toolbtns
//ini mtdataset
//ini ctrl
//ini grid
      if Not FhlKnl1.Cf_GetDict_Bill_Ex(FrmId,fBillex) then Close;     //etDict_Bill
    //  self.Caption:=fBillex.Maincaption ;
      self.LblTitle.Caption  := self.caption ;
       if fBillex.ActID<>-1 then
       FhlKnl1.Tb_CreateActionBtns_Ex(self.ToolBar1,self.ActionList1,inttostr(fBillex.ActID),logininfo.EmpId,SELF.FWindowsFID );

       FhlUser.SetDataSet(mtDataSet1,fBillex.mtDataSetId,Null,false);
       if (fBillex.TopBoxID <>'-1')and (fBillex.TopBoxID <>'') then      //top or buttom      create label and dbcontrol
      FhlKnl1.Cf_SetBox( (fBillex.TopBoxId),MtDataSource1,selF.ScrollTop ,dmFrm.UserDbCtrlActLst);

      if (fBillex.BtmBoxID<>'-1')and (fBillex.BtmBoxID<>'')   then
      FhlKnl1.Cf_SetBox( (fBillex.BtmBoxId),MtDataSource1,SELF.PnlBtmControls  ,dmFrm.UserDbCtrlActLst);

      FhlUser.SetDbGridAndDataSet(self.DBGridDL ,fBillex.dlGridId,Null,true,true);
      fhlknl1.Cf_DeleteDbGridUnAuthorizeCol(fBillex.dlGridId,DBGridDL,logininfo.EmpId ,self.FWindowsFID,logininfo.SysDBPubName) ;
        fDbGridColsColor:=VarArrayCreate([0,self.DBGridDL.Columns.Count-1],varVariant);
     for i:=0 to DBGridDL.Columns.Count-1 do
     fDbGridColsColor[i]:=DBGridDL.Columns[i].Color;

     OpenCloseAfter(false);
     if (self.fBillex.ImportID ='-1') or (self.fBillex.ImportID ='') then
     ImportAction1.Visible :=false;

     if trim(self.fBillex.ChkProc) =''  then
        CheckAction1.Visible :=false ;
     if (self.fBillex.ChkFieldName ='' )  then
         LblState.Visible :=false;
     ResetPnlContentSize(false);
end;

procedure TFrmBillEx.OpenBill(BillCode: string);
var  i:Integer;
begin
   self.fBillex.BillCode := BillCode;
   FhlKnl1.Ds_OpenDataSet(mtDataSet1,varArrayof([BillCode]));

   if (mtDataSet1.RecordCount<1) and (BillCode<>'0000') then
   begin
     self.fBillex.BillCode:='0000';
     //MessageDlg(#13#10+'没有找到编号为"'+BillCode+'"的单据记录.',mtInformation,[MbYes],0);
     CloseBill;
     Exit;
   end;
   FhlKnl1.Ds_OpenDataSet(dlDataSet1,varArrayof([BillCode]));
   FhlKnl1.SetColFormat(self.DBGridDL  );

   if (not  mtDataSet1.IsEmpty) and (dlDataSet1.IsEmpty )then
   NewAction1.Visible :=false;

   OpenCloseAfter(true);
 
end;

procedure TFrmBillEx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    CommonFormClose(sender, action);
end;

procedure TFrmBillEx.OpenAction1Execute(Sender: TObject);
var FrmLoopUpImPortEx:TFrmLoopUpImPortEx      ;
begin
FrmLoopUpImPortEx:=TFrmLoopUpImPortEx.Create(nil);
FrmLoopUpImPortEx.iniFrm(self.fBillex.OpenID );
FrmLoopUpImPortEx.ShowModal ;

if FrmLoopUpImPortEx.ModalResult =mrok then
begin
    self.OpenBill(FrmLoopUpImPortEx.dlDataSet1.fieldbyname(self.fBillex.mkeyfld ).AsString );
end;




end;
procedure TFrmBillEx.OpenCloseAfter(IsOpened:Boolean);
var i:integer;
begin
  if (self.mtDataSet1.LockType = ltReadOnly ) and (self.dlDataSet1.locktype=ltReadOnly)   then
  begin
    NewAction1.Enabled:=false;
    CloseAction1.Enabled:=true;
    exit;
  end;

  if IsOpened then
     SetRitBtn
  else
  begin
    for i:=0 to ToolBar1.ButtonCount -1 do
    begin
       if ToolBar1.Buttons[i].Action<>nil then
       Taction(ToolBar1.Buttons[i].Action).Enabled :=false;
    end;
    NewAction1.Enabled:=true;

    FirstAction1.Enabled:=((F_ParamData<>nil) and ( F_ParamData.Active ));
    PriorAction1.Enabled:=FirstAction1.Enabled;
    LastAction1 .Enabled:=FirstAction1.Enabled;
    NextAction1 .Enabled:=FirstAction1.Enabled;
  end;

  if   self.mtDataSet1.State in  [dsEdit,dsinsert] then
    CloseAction1.Enabled :=false
  else
    CloseAction1.Enabled :=true ;

  if not IsOpened then
       SetCtrlStyle(IsOpened);
end;
procedure TFrmBillEx.SetCtrlStyle(fEnabled:Boolean);
 var bkColor:TColor;
begin
  // dmFrm.SetDataSetStyle(mtDataSet1,fReadOnly);
  if fEnabled then
    bkColor:=clWhite
  else
    bkColor:=clCream;
  // bkColor:=clWhite;

  FhlKnl1.Vl_SetCtrlStyle(bkColor,self.ScrollTop ,fEnabled);
  FhlKnl1.Vl_SetCtrlStyle(bkColor,self.PnlBtm ,fEnabled);
  FhlKnl1.Dg_SetDbGridStyle(self.DBGridDL ,not  fEnabled,bkColor,fDbGridColsColor);
end;
procedure TFrmBillEx.SetRitBtn;
var LstChkState:Tstrings;
begin
    PrintAction1.Enabled:= ( mtDataSet1.Active ) and ( not mtDataSet1.IsEmpty  ) ;
    MailAction1.Enabled:=true;
    FaxAction1.Enabled:=true;
    NewAction1.Enabled:=true;
    RemoveAction1.Enabled:= (not mtDataSet1.IsEmpty );
    ActInfo.Enabled :=true;
    ActProperty.Enabled :=true;
    
    if mtDataSet1.FindField(fBillex.ChkFieldName)<>nil then
    begin
          self.LblState.Visible :=false;
          LstChkState:=Tstringlist.Create ;
          LstChkState.CommaText :=fbillex.IsChkValue;
           if LstChkState.IndexOf( mtDataSet1.FieldByName (fBillex.ChkFieldName).AsString )>-1 then
             SetCheckStyle(true)
          else
             SetCheckStyle(false);
          LstChkState.Free ;
    end  ;

    if fBillex.IsNeedEdit then  //2007-7-16
    begin
        SetCheckStyle(FALSE);
    end
    else 
    begin
        if trim(fbillex.IsChkValue)='' then
        if mtDataSet1.findfield(cIsChk)<>nil then
           SetCheckStyle(mtDataSet1.FieldByName(cIsChk).AsBoolean);
    end;       
end;
procedure TFrmBillEx.SetCheckStyle(IsChecked:Boolean);
begin
  if (trim(self.fBillex.ChkFieldName) <>'' ) then
  LblState.Visible :=true;
  if IsChecked then begin
     SetBillStyle(IsChecked);
     RemoveAction1.Enabled:=false and (not mtDataSet1.IsEmpty );
     LblState.caption :='已审';
  end
  else begin
     SetBillStyle(false);
     RemoveAction1.Enabled:= (not mtDataSet1.IsEmpty );
     LblState.caption :='未审';
  end;

  CheckAction1.Enabled :=  (not IsChecked ) and (not mtDataSet1.IsEmpty );
  ActUncheck.Enabled :=IsChecked ;
  ActChkChg.Enabled :=IsChecked ;

  if (( self.mtDataSet1.FindField ('FisCls')<>nil)and (IsChecked )) then
  begin
     //( TToolButton(actClose.ActionComponent))   .Visible:=not mtDataSet1.FieldByName('FisCls').AsBoolean ;
     //( TToolButton(actBillOpen.ActionComponent)).Visible:=    mtDataSet1.FieldByName('FisCls').AsBoolean ;
    InActiveBill.Enabled  :=not mtDataSet1.FieldByName('FisCls').AsBoolean ;
    ActiveBill.Enabled :=not InActiveBill.Enabled  ;
  end
  else
  begin
    InActiveBill.Enabled  :=false;
    ActiveBill.Enabled :=false;
  end;
  
end;
procedure TFrmBillEx.SetBillStyle(fReadOnly:Boolean);
begin
 //set btn.enabled to false
// LinkAction1.Enabled:=Not fReadOnly;
 ImportAction1.Enabled:=Not fReadOnly;
 actMDLookup.Enabled:=Not fReadOnly;

 AppendAction1.Enabled:=( Not fReadOnly ) ;
 DeleteAction1.Enabled:= ( Not fReadOnly )  ;
 SetCtrlStyle(Not fReadOnly);
end;
procedure TFrmBillEx.CloseAction1Execute(Sender: TObject);
begin
self.Close;
end;


procedure TFrmBillEx.ScrollTopDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ; 
begin


// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
//    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=self.fBillex.mtDataSetId ;
     CrtCom.TOPBoxId := (self.fBillex.TopBoxID );
   CrtCom.DLGrid :=self.DBGridDL  ;
   CrtCom.DlGridId :=self.fBillex.dlGridId ;
    CrtCom.TopOrBtm :=true;
       try
    CrtCom.Show;
    finally

    end;
  end;



end;

procedure TFrmBillEx.ScrollBtmDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
//    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=self.fBillex.mtDataSetId ;
     CrtCom.TOPBoxId := (self.fBillex.BtmBoxID  );
   CrtCom.DLGrid :=self.DBGridDL  ;
   CrtCom.DlGridId :=self.fBillex.dlGridId ;
    CrtCom.TopOrBtm :=false;
 

try
    CrtCom.Show;
finally

end;
 end;
end;

procedure TFrmBillEx.DBGridDLDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
      CrtCom:=TfrmCreateComponent.Create(self);
      CrtCom.Hide;
      //    CrtCom.fbilldict:=  fbilldict;
      CrtCom.mtDataSet1:= self.dlDataSet1  ;
      CrtCom.mtDataSetId :=inttostr(self.dlDataSet1.tag) ;
      CrtCom.TOPBoxId := (self.fBillex.TopBoxID );
      CrtCom.DLGrid :=self.DBGridDL  ;
      CrtCom.DlGridId :=self.fBillex.dlGridId ;
      CrtCom.TopOrBtm :=true;
try
    CrtCom.Show;
finally

end;
 end;
end;

procedure TFrmBillEx.dlDataSet1CalcFields(DataSet: TDataSet);
begin
      if dataset.FindField('MyIndex')<>nil then
      begin
            with DataSet do begin
                   FieldByName('MyIndex').asInteger:=Abs(RecNo);//Is fkCalculated
                   if FindField(fBillex.DlPriceFld )<>nil then

                      FieldByName(fBillex.DlFundFld ).asCurrency:=FieldByName(fBillex.QtyFld ).asFloat*FieldByName(fBillex.DlPriceFld).asFloat;

            end;
      end;
end;

procedure TFrmBillEx.CancelAction1Execute(Sender: TObject);
begin 

  if MessageDlg(fsDbCancel,mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
      if self.dlDataSet1.State in [dsinsert,dsedit] then
      self.dlDataSet1.Cancel;

      if self.mtDataSet1.State in [dsinsert,dsedit] then
      self.mtDataSet1.Cancel;
      CloseBill ;
      OpenBill(fBillex.BillCode);
   end;

end;

procedure TFrmBillEx.CloseBill;
begin
   mtDataSet1.Close;
   dlDataSet1.Close;
   OpenCloseAfter(false);
end;
procedure TFrmBillEx.UpdateSysFieldsAndCalValue;
var  sql:string;
var i:integer;
begin

  //  update  FLstEditEmp  FlstEditTime  FPhoneticize

   sql:='select B.NameField   ,B.TableEname  '
       +'  From T201 A '
       +'  join ' +logininfo.SysDBPubName+'.dbo.Tallusertable B on A.F16=B.TableEname '
       +'  where B.FisBasicTable=1 and  A.f01 ='+inttostr(mtDataSet1.Tag );
   fhlknl1.Kl_GetQuery2(sql);
   if not fhlknl1.FreeQuery.IsEmpty then
   begin
        if mtDataSet1.FindField (fhlknl1.FreeQuery.FieldByName('NameField').AsString )<>nil then
          if mtDataSet1.FindField ('FPhoneticize')<>nil then
            if mtDataSet1.FieldByName (fhlknl1.FreeQuery.FieldByName('NameField').AsString).Value<>null then
              mtDataSet1.FieldByName ('FPhoneticize').Value := GetHZPY(mtDataSet1.FieldByName (fhlknl1.FreeQuery.FieldByName('NameField').AsString).Value );
   end;


   if  mtDataSet1.FindField  ('FLstEditEmp') <>nil then
       mtDataSet1.FieldByName ('FLstEditEmp').Value :=  logininfo.EmpId ;
   if  mtDataSet1.FindField  ('FlstEditTime') <>nil then
       mtDataSet1.FieldByName ('FlstEditTime').Value :=now;


end;

procedure TFrmBillEx.Ds_UpdateAllRecs(fGrid:TDBgrid;fFields,fValues:Variant;PPgBarSave:Tprogressbar;DelOnCalEvent:boolean=true);
var bk:Pointer;
var i:integer;
var BackOnCalcFields: TDataSetNotifyEvent ;
var fDataSet:TDataSet;

function isFieldVisiable(pFieldName:string)  :Boolean ;
var rlt:Boolean;
var i:integer;
begin
    rlt:=false;
    for i:=0 to fGrid.Columns.Count -1 do
    if  (fGrid.Columns[i].FieldName = pFieldName ) and (fGrid.Columns[i].Visible ) then
    begin
      rlt:=True;
      Break;
    end;
    result:= rlt;
end;

begin
     fDataSet:= fGrid.DataSource.DataSet ;

     PPgBarSave.Visible :=true;
     PPgBarSave.Max :=fDataSet.RecordCount ;
      
     with fDataSet do
     begin
       bk:=GetBookmark;
     //  DisableControls;
       First;
       while not Eof do
       begin
          application.ProcessMessages ;
          PPgBarSave.Position := fDataSet.RecNo ;
          if trim(fBillex.DlPriceFld)<>'' then
            if  dlDataSet1.FindField(fBillex.DlPriceFld)<>nil then
              if  dlDataSet1.FieldByName(fBillex.DlPriceFld  ).Value = null  then
              begin
                 showmessage('请填写单价!');
                 abort;
              end   ;

          for i:=0 to fDataSet.Fields.Count -1 do
          begin
            if  (fDataSet.Fields[i].FieldKind  <> fkCalculated ) then
            if fDataSet.Fields[i] is TFloatFieldEx then
              if TFloatFieldEx (fDataSet.Fields[i]).CalField <>'' then
              begin
                fDataSet.Edit;
                if fDataSet.findfield(   TFloatFieldEx (fDataSet.Fields[i]).CalField)<>nil then
                  if fDataSet.fieldbyname(   TFloatFieldEx (fDataSet.Fields[i]).CalField).Value =null then
                    fDataSet.Fields[i].Value :=0
                  else
                    if fDataSet.Fields[i].Value=null then
                      fDataSet.Fields[i].Value := fDataSet.fieldbyname(   TFloatFieldEx (fDataSet.Fields[i]).CalField).Value
                    else
                      if not isFieldVisiable(fDataSet.Fields[i].FieldName ) then
                         fDataSet.Fields[i].Value := fDataSet.fieldbyname(   TFloatFieldEx (fDataSet.Fields[i]).CalField).Value
                      else
                         fDataSet.Fields[i].Value:=fDataSet.Fields[i].Value;
                fDataSet.Post;
              end;
          end;

         BackOnCalcFields:= fDataSet.OnCalcFields ;
         if DelOnCalEvent then
         fDataSet.OnCalcFields :=nil ;
         FHLKNL1.Ds_AssignValues(fDataSet,fFields,fValues,False);
         fDataSet.OnCalcFields :=BackOnCalcFields ;
         Next;
       end;
         
       //     EnableControls;
       GotoBookmark(bk);
     end;
     PPgBarSave.Visible :=false;
end;

procedure TFrmBillEx.SaveAction1Execute(Sender: TObject);
var  s,ss,f:widestring;
//var  fDict:TBeforePostDict;
var  pKeys,DLKeyFLDs:Tstrings;
var i:integer;
var MtValues:variant;
var BackOnCalcFields ,BackUpDLBeforePost: TDataSetNotifyEvent ;
begin
 try
    if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
    begin
       dlDataSet1.Post;
    end;
    if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;
    try
       FhlUser.Validation  (self.dlDataSet1  ,true,false,false,false,false,false);
       FhlUser.Validation  (self.mtDataSet1   ,true,false,false,false,false,false);
    except
      on err :exception do
      begin
       showmessage(err.Message );
       exit;
      end;
    end;
    Screen.Cursor:=CrSqlWait;
    if dlDataSet1.findField(fBillex.QtyFld  )<>nil then
     if dlDataSet1.FieldByName(fBillex.QtyFld  ).AsFloat    = 0    then
        begin
           showmessage('请填写数量!');
           abort;
        end ;

      //AutoKey
      if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
      begin
         fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
         pKeys:=Tstringlist.Create ;
         pKeys.CommaText :=   fBillex.mkeyfld;
         for i:=0 to pKeys.Count -1 do
         begin
            mtDataSet1.FieldByName(pKeys[i]).AsString:=fBillex.BillCode;
         end;
         pKeys.Free ;
      end;

      BackUpDLBeforePost:= dlDataSet1.BeforePost ;
      dlDataSet1.BeforePost:=nil;
      if  mtDataSet1.State in [dsedit,dsInsert]  then
      begin
        UpdateSysFieldsAndCalValue;
      end;
      DLKeyFLDs:=Tstringlist.Create ;
      DLKeyFLDs.CommaText :=fBillex.fkeyfld;
      MtValues :=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fBillex.fkeyfld);
      BackOnCalcFields:= dlDataSet1.OnCalcFields ;
     // dlDataSet1.OnCalcFields :=nil;                //加快保存速度
      Ds_UpdateAllRecs(Self.DBGridDL , fBillex.fkeyfld ,  MtValues  ,self.PgBarSave ,false  );
      freeandnil(DLKeyFLDs) ;
      dlDataSet1.BeforePost :=BackUpDLBeforePost ;
      try
           mtDataSet1.UpdateBatch;
           dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板
       //   dlDataSet1.OnCalcFields:=BackOnCalcFields ;
      except
          on err:exception do
          begin
            //  EditPostAfter(True);
            Screen.Cursor:=crDefault;
            showmessage(err.Message );
            exit;
          end;
      end;
     EditPostAfter(True);
   //  self.OpenBill(self.fBillex.BillCode ) ;    2010-7-11
  finally
     Screen.Cursor:=crDefault;
  end;
end;
procedure TFrmBillEx.EditPostAfter(IsEnabled:Boolean);
begin
    if IsEnabled then
       SetRitBtn
    else
    begin
     NewAction1.Enabled:=IsEnabled;
     RemoveAction1.Enabled:=IsEnabled and (not mtDataSet1.IsEmpty );
     CheckAction1.Enabled:=IsEnabled and (not mtDataSet1.IsEmpty );
    end;
    OpenAction1.Enabled:=IsEnabled;
    ActOri.Enabled:=IsEnabled;
    RefreshAction1.Enabled:=IsEnabled;
    FirstAction1.Enabled:=((F_ParamData<>nil) and ( F_ParamData.Active ));
    PriorAction1.Enabled:=FirstAction1.Enabled;
    NextAction1.Enabled:=FirstAction1.Enabled;
    LastAction1.Enabled:=FirstAction1.Enabled;
    CloseAction1.Enabled:=IsEnabled;
    PrintAction1.Enabled:=IsEnabled;
    MailAction1.Enabled:=IsEnabled;
    FaxAction1.Enabled:=IsEnabled;
    SaveAction1.Enabled:=Not IsEnabled;
    ActSaveExecDLProc.Enabled  :=SaveAction1.Enabled;
    self.ActSaveHaveTextFomula.Enabled :=SaveAction1.Enabled;
    ActSaveHaveTextFomulaZeroQty.Enabled :=SaveAction1.Enabled;
    CancelAction1.Enabled:=Not IsEnabled;
    ActApportion.Enabled := SaveAction1.Enabled;
    ActEdit.Enabled  :=not SaveAction1.Enabled;
end;

procedure TFrmBillEx.ImportAction1Execute(Sender: TObject);
begin
    if FrmImPort=nil then
    begin
        FrmImPort:=TFrmLoopUpImPortEx.Create(nil);
        FrmImPort.iniFrm(self.fBillex.ImportID,'',self.dlDataSet1 ,self.mtDataSet1   );
        FrmImPort.AutoSize :=true;

        FrmImPort.Visible:=true;
        FrmImPort.Dock(self.ScrollBtm,FrmImPort.ClientRect    );
        FrmImPort.Align :=alclient  ;
    end
    else
    begin
        ScrollBtm.Visible :=TToolbutton(Taction(Sender).ActionComponent ).Down ;
        if ScrollBtm.Visible then
        begin
            if FrmImPort.ActiveControl<>nil then
            FrmImPort.ActiveControl.SetFocus ;
            self.WindowState  := wsMaximized;
        end;
        if FrmImPort.mtDataSet1.Active then
        FrmImPort.RefreshAction1.Execute;
   end;
   self.PnlBtmControls.Visible :=not TToolbutton(Taction(Sender).ActionComponent ).Down ;
   self.ResetPnlContentSize ( TToolbutton(Taction(Sender).ActionComponent ).Down);
end;
procedure TFrmBillEx.dlDataSet1AfterPost(DataSet: TDataSet);
begin
    FhlKnl1.Ds_AssignValues(mtDataSet1,self.fBillex.mtSumFlds ,FhlKnl1.Ds_SumFlds(DataSet,self.fBillex.dlSumFlds),false,false);
    fhluser.LogUserRecord(self.dlDataSet1 ,'update');
end;

procedure TFrmBillEx.DlDataSource1StateChange(Sender: TObject);
begin
  if (DlDataSource1.State=dsEdit) or (DlDataSource1.State=dsInsert) then begin
     DBGridDL.Options:=DBGridDL.Options-[dgColumnResize];
     EditPostAfter(false);
  end
  else
     DBGridDL.Options:=DBGridDL.Options+[dgColumnResize];
end;

procedure TFrmBillEx.mtDataSource1StateChange(Sender: TObject);
begin
  if (MtDataSource1.State=dsEdit) or (MtDataSource1.State=dsInsert) then
     EditPostAfter(false);
end;

procedure TFrmBillEx.CheckAction1Execute(Sender: TObject);
begin
  if self.mtDataSet1.IsEmpty then exit;
  Screen.Cursor:=CrSqlWait;
  try
    FhlUser.CheckRight(fBillex.ChkRightId );
    if   dmFrm.ExecStoredProc(fBillex.chkproc,varArrayof([fBillex.billcode,LoginInfo.EmpId,LoginInfo.LoginId])) then
    begin
         if ((ImportAction1.ActionComponent as TToolbutton)<>nil) and (ImportAction1.ActionComponent as TToolbutton).Down then
         begin
            (ImportAction1.ActionComponent as TToolbutton).Down :=false;
            (ImportAction1.ActionComponent as TToolbutton).Click;
         end;

          OpenBill(fBillex.BillCode);
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.ActInfoExecute(Sender: TObject);
begin
    if   (self.mtDataSet1.Active ) and (not self.mtDataSet1.IsEmpty )then
    begin
          if FrmLoopUpImPortEx=nil then
          begin
          FrmLoopUpImPortEx:=TFrmLoopUpImPortEx.Create(self);
          FrmLoopUpImPortEx.AutoSize :=true;
          FrmLoopUpImPortEx.Align :=altop ;
          FrmLoopUpImPortEx.Dock(self.ScrollBtm,FrmLoopUpImPortEx.ClientRect    );
          FrmLoopUpImPortEx.iniFrm(inttostr(Taction(Sender).ActionComponent.Tag  ),'',self.mtDataSet1 );
          FrmLoopUpImPortEx.Visible:=true;
          end
          else
          FrmLoopUpImPortEx.Visible :=TToolbutton(Taction(Sender).ActionComponent ).Down ;
    
    end
    else
    begin
        TToolbutton(Taction(Sender).ActionComponent ).Down:=false ;
        showmessage('请先选择订购单');
    end;

end;

procedure TFrmBillEx.FirstAction1Execute(Sender: TObject);
begin
  if (F_ParamData<>nil) and ( F_ParamData.Active )then
  begin
      F_ParamData.First ;
      self.OpenBill(F_ParamData.FieldValues [  FirstCommarSection(fBillex.mkeyfld)] ) ;
  end;
end;

procedure TFrmBillEx.PriorAction1Execute(Sender: TObject);
begin
  if (F_ParamData<>nil) and ( F_ParamData.Active )then
  begin
      F_ParamData.Prior ;
          while (F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] =self.fBillex.BillCode )and   (not F_ParamData.Bof)do
      F_ParamData.Prior ;
      self.OpenBill(F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] ) ;
  end;
end;

procedure TFrmBillEx.NextAction1Execute(Sender: TObject);
begin
  if (F_ParamData<>nil) and ( F_ParamData.Active )then
  begin
      F_ParamData.Next ;
      while (F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] =self.fBillex.BillCode )and   (not F_ParamData.Eof)do
        F_ParamData.Next;

      self.OpenBill(F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] ) ;
  end;
end;

procedure TFrmBillEx.LastAction1Execute(Sender: TObject);
begin
  if (F_ParamData<>nil) and ( F_ParamData.Active )then
  begin
      F_ParamData.Last  ;
      self.OpenBill(F_ParamData.FieldValues [FirstCommarSection(fBillex.mkeyfld)] ) ;
  end;
end;

procedure TFrmBillEx.SetParamDataset(PDataset: Tdataset);
begin
self.F_ParamData :=PDataset;
end;
{
procedure TFrmBillEx.mtDataSet1AfterOpen(DataSet: TDataSet);
begin

    if (MtDataSet1.FieldByName(F_FlagFldName).AsString <>self.F_FlagCompeleteState) then
        self.CheckAction1.Enabled :=true
    else
       self.CheckAction1.Enabled :=false ;

end;

procedure TFrmBillEx.ConfigComplete(P_FlagFldName,
  P_FlagCompeleteState: string);
begin
    self.F_FlagFldName :=    P_FlagFldName ;
    self.F_FlagCompeleteState :=  P_FlagCompeleteState ;
end;
}
procedure TFrmBillEx.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if SaveAction1.Enabled then
 begin
   case Key of
     vk_Return:begin
                 if ssCtrl in Shift then
                 begin
                    if  SaveAction1.Visible  then
                    SaveAction1.Execute    ;//.Click
                    if  ActSaveHaveTextFomula.Visible then
                    ActSaveHaveTextFomula.Execute    ;//.Click

                 end  ;

                 if Not (ActiveControl is TDbGrid) then
                   FhlKnl1.Vl_DoBoxEnter(ActiveControl)
                 else
                    with TDBGrid(ActiveControl) do
                    begin
                        FhlKnl1.Dg_SetSelectedIndex(TDbGrid(ActiveControl),False) 
                    end;
               end;
     vk_Escape:begin
              CancelAction1.Execute;
             end;
     vk_Delete:begin
                 if DeleteAction1.Visible or logininfo.Sys then
                 DeleteAction1.Execute;
             end;    
             
   end;
 end else
 begin
   case Key of
     vk_Escape:begin
             CloseAction1.Execute;
             end;
             {  }
     vk_Insert:begin
              if ssCtrl in Shift then
              begin
                 if self.ActEdit.Visible or logininfo.sys then
                 ActEdit.Execute  ;
              end
              else
                 if self.NewAction1.Visible or logininfo.Sys then
                 NewAction1.Execute ;
             end;

     vk_Delete:begin
                 if DeleteAction1.Visible or logininfo.Sys then
                 DeleteAction1.Execute;
             end;    

     vk_Home:FirstAction1.Execute;//.Click;
     vk_End:LastAction1.Execute;//.Click;
     vk_Prior:priorAction1.Execute;
     vk_Next:nextAction1.Execute;
     vk_Print:printAction1.Execute;

      vk_Return:begin
                     if self.FrmImPort <>nil then
                      FrmImPort.OpnDlDsBtn1.Click ;
                 end;

   end;
 end;

end;

procedure TFrmBillEx.AppendAction1Execute(Sender: TObject);
begin
if    not (dlDataSet1.LockType = ltReadOnly) then
 dlDataSet1.Append;
end;

procedure TFrmBillEx.DBGridDLExit(Sender: TObject);
begin
    if self.dlDataSet1.State in [dsinsert,dsedit] then
    begin
        self.dlDataSet1.Post;
    end;

end;

procedure TFrmBillEx.NewAction1Execute(Sender: TObject);
begin
    if    not (mtDataSet1.LockType = ltReadOnly) then
    begin
      OpenBill('0000');
      FhlUser.AssignDefault(mtDataSet1,false);
      mtDataSet1.Append;
      FhlKnl1.Vl_FocueACtrl(ScrollTop);

    end;
end;

procedure TFrmBillEx.DeleteAction1Execute(Sender: TObject);
begin
    if    not (dlDataSet1.LockType = ltReadOnly) then
    begin
       if not dlDataSet1.IsEmpty then
       begin
          fhluser.LogUserRecord(self.dlDataSet1 );
          dlDataSet1.Delete;
          EditPostAfter(false);
          //  dlDataSet1.Refresh;
       end;
    end;
end;


procedure TFrmBillEx.dlDataSet1AfterScroll(DataSet: TDataSet);
begin
     statLabel1.Caption:=intTostr(dlDataSet1.RecNo)+'/'+intTostr(dlDataSet1.RecordCount);
end;

procedure TFrmBillEx.ActSaveWithOutDLExecute(Sender: TObject);
var  s,ss,f:widestring;
//var  fDict:TBeforePostDict;
//var  pKeys:Tstrings;
var i:integer;


begin

 { if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;  }

    if trim(fBillex.DlPriceFld)<>'' then
    if  dlDataSet1.FieldByName(fBillex.DlPriceFld  ).Value = null  then
    begin
       showmessage('请填写单价!');
       abort;
    end   ;

    Screen.Cursor:=CrSqlWait;
    if dlDataSet1.findField(fBillex.QtyFld  )<>nil then
     if dlDataSet1.FieldByName(fBillex.QtyFld  ).AsFloat    = 0    then
        begin
           showmessage('请填写数量!');
           abort;
        end ;

        //AutoKey
        if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
        begin
                 fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
                 mtDataSet1.FieldByName(fBillex.mkeyfld).AsString:=fBillex.BillCode;
        end;


       Ds_UpdateAllRecs(self.DBGridDL ,varArrayof([fBillex.fkeyfld ]),varArrayof([fBillex.BillCode]),self.PgBarSave );
       if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
       begin
            dlDataSet1.Post;
       end;

       //if mtDataSet1.State in [dsinsert ,dsEdit	] then
                 begin
                          try

                               mtDataSet1.UpdateBatch;
                               dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板
                          except
                                  on err:exception do
                                  begin
                                    //  EditPostAfter(True);
                                    Screen.Cursor:=crDefault;
                                    showmessage(err.Message );
                                      exit;
                                  end;
                          end;
          end;
        {   }
        EditPostAfter(True);
     Screen.Cursor:=crDefault;
end;

procedure TFrmBillEx.Action1Execute(Sender: TObject);
var UserQkRpt1 :TUserQkRpt;
var
  bk:TBookmark;
begin

  Screen.Cursor:=crSqlWait;


  UserQkRpt1:=TUserQkRpt.Create(Application);
  try
    UserQkRpt1.SetBillRep( (self.fBillex.TopBoxId), (fBillex.BtmBoxId),self.mtDataSet1 ,self.DBGridDL ,fBillex.Maincaption );
    UserQkRpt1.PreviewModal;//Preview;
  finally
    FreeAndNil(UserQkRpt1);

    Screen.Cursor:=crDefault;
  end;
 
end;

procedure TFrmBillEx.ActRemMchSvPayExecute(Sender: TObject);
begin

 sDefaultVals:='';
 sDefaultVals:='F_SourceBillCode='+self.mtDataSet1.fieldbyname('F_MchReturnID').AsString  +','  ;
  sDefaultVals:=sDefaultVals+'F_note='+'残机扣款：'+self.mtDataSet1.fieldbyname('F_MchReturnID').AsString +','  ;
  sDefaultVals:=sDefaultVals+'F_PayerSvCode='+ self.mtDataSet1.fieldbyname('F_SvCenterCode').AsString  ;


 TEditorFrm(FhlUser.ShowEditorFrm('125',self.mtDataSet1.fieldbyname('F_MchReturnID').AsString ,nil)).ShowModal;
end;

procedure TFrmBillEx.ActlocateExecute(Sender: TObject);
var i:integer;
begin
  PnlFunction.Visible :=TToolbutton(Taction(Sender).ActionComponent ).Down ;



      if CmbFlds.Items.Count =0 then
      begin
          for i:=0 to DBGridDL.Columns.Count-1 do
          begin
              if DBGridDL.Columns[i].Visible  then
              CmbFlds.Items.Add(DBGridDL.Columns[i].Title.Caption  );
          end;
          CmbFlds.ItemIndex :=0;
          CmbFlds.Hint :=DBGridDL.Columns[0].FieldName  ;
      end ;

end;

procedure TFrmBillEx.CmbFldsChange(Sender: TObject);
var i:integer;
begin

      for i:=0 to self.DBGridDL.Columns.Count -1 do
      begin
             if  DBGridDL.Columns[i].Title.Caption =   CmbFlds.Text  then
                   if self.dlDataSet1.FieldByName(DBGridDL.Columns[i].FieldName).FieldKind in [fkData]   then
                     CmbFlds.Hint:=DBGridDL.Columns[i].FieldName ;
      end ;

end;

procedure TFrmBillEx.EdtValuesKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var LstChkState:Tstrings;
begin
  inherited; 
    if EdtValues.Text <>'' then
    begin
      if  self.dlDataSet1.Locate(CmbFlds.Hint,EdtValues.Text ,[]) then
         if dlDataSet1.FindField('IsLocated')<>nil then
         begin
            if mtDataSet1.FindField(fBillex.ChkFieldName)<>nil then
            begin
                  LstChkState:=Tstringlist.Create ;
                  LstChkState.CommaText :=fbillex.IsChkValue;
                   if not LstChkState.IndexOf( mtDataSet1.FieldByName (fBillex.ChkFieldName).AsString )>-1 then
                   begin
                      dlDataSet1.Edit ;
                      dlDataSet1.Fieldbyname('IsLocated').AsBoolean :=true;
                      dlDataSet1.Post ;
                   end;


                  LstChkState.Free ;
            end;


         end;

       self.DBGridDL.SelectedIndex :=dlDataSet1.RecNo ;
    end;
end;

procedure TFrmBillEx.ActDeleteExecute(Sender: TObject);
begin
    if MessageDlg(#13#10+'确定要删除吗？',mtInformation,[mbOk,mbCancel],0)=mrOk then
         if not dlDataSet1.IsEmpty then
         begin
         dlDataSet1.Delete;
         if  (  dlDataSet1.LockType in [ltBatchOptimistic]) then
         begin
             EditPostAfter(false);
             dlDataSet1.Refresh;
         end;
         end;
 
end;

procedure TFrmBillEx.ActSlAftMchOrderExecute(Sender: TObject);
var  FrmBillEx:TFrmBillEx;
begin
  FrmBillEx:=TFrmBillEx.Create(nil);
       FrmBillEx.InitFrm('1027');
       if mtDataSet1.fieldbyname('F_MchApplyID').AsString  <>'' then 
        FrmBillEx.OpenBill( mtDataSet1.fieldbyname('F_MchApplyID').AsString  );
       FrmBillEx.FormStyle :=fsnormal;
       FrmBillEx.Hide;
     //  FrmBillEx.AutoSize:=true;
      FrmBillEx.Position :=poDesktopCenter;
       FrmBillEx.ScrollBtm.Visible :=true;
    //   FrmBillEx.SetParamDataset(self.dlAdoDataSet1 );
      
  sDefaultVals:='';
  sDefaultVals:='F_OrderType=1,'  ;
  sDefaultVals:=sDefaultVals+'F_MchReturnID='+ self.mtDataSet1.fieldbyname('F_MchReturnID').AsString  +','  ;
  sDefaultVals:=sDefaultVals+'F_note='+'售后还机：'+self.mtDataSet1.fieldbyname('F_MchReturnID').AsString ;


   FrmBillEx.ShowModal ;
end;

procedure TFrmBillEx.BtnRecLocateClick(Sender: TObject);
begin
PnlFunction.Visible := BtnRecLocate.Down;
end;

procedure TFrmBillEx.ActShowHeadExecute(Sender: TObject);
begin
self.ScrollTop.Visible :=self.BtnShowHead.Down;
end;

procedure TFrmBillEx.PnlBtmDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
        FrmUserDefineReport1: TFrmUserDefineReport;
begin
  if LoginInfo.Sys  then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=self.fBillex.mtDataSetId ;
    CrtCom.TOPBoxId := (self.fBillex.BtmBoxID );
    CrtCom.DLGrid :=self.DBGridDL  ;
    CrtCom.DlGridId :=self.fBillex.dlGridId ;
    CrtCom.TopOrBtm :=true;
    try
    CrtCom.Show;
    finally

    end;
  end;
end;

procedure TFrmBillEx.FormCreate(Sender: TObject);
begin
    DBGridDL:=TModelDbGrid.create (self);
    DBGridDL.DataSource :=self.DlDataSource1 ;
    DBGridDL.Align :=alclient;
    DBGridDL.Parent :=PnlGrid;
    DBGridDL.OnDblClick := DBLClick;
    DBGridDL.PopupMenu :=dmFrm.DbGridPopupMenu1 ;

    btnCtrl.Visible     :=logininfo.Sys ;
end;



procedure TFrmBillEx.DBLClick(sender: Tobject);
var CrtCom:TfrmCreateComponent    ;
begin
    // modeltpe:=Bill;
    if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    //    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.dlDataSet1  ;
    CrtCom.mtDataSetId :=inttostr(self.dlDataSet1.tag) ;
    CrtCom.TOPBoxId := (self.fBillex.TopBoxID );
    CrtCom.DLGrid :=self.DBGridDL  ;
    CrtCom.DlGridId :=self.fBillex.dlGridId ;
    CrtCom.TopOrBtm :=true;


    try
    CrtCom.Show;
    finally

    end;

end;
end;
procedure TFrmBillEx.RemoveAction1Execute(Sender: TObject);
var MainTable,DLTable:String;
var qry:Tadoquery;
var MKeyField,DLKeyField:string;
begin

if self.mtDataSet1.FindField('FisSys')<>nil then
  if mtDataSet1.FieldByName ('FisSys').AsBoolean then
  begin
    showmessage('系统生成的单据不能删除！');
    exit;
  end;


 if MessageDlg(#13#10+'确实要删除这张单据?',mtInformation,[mbYes,mbNo],0)=mrNo then
 exit;

  fhlknl1.Kl_GetQuery2('select * From T201 where f01='+inttostr( mtDataSet1.tag));
  MainTable:=fhlknl1.FreeQuery.fieldbyname('F16').AsString;

  fhlknl1.Kl_GetQuery2('select * From T201 where f01='+inttostr( dlDataSet1.tag));
  DLTable:=fhlknl1.FreeQuery.fieldbyname('F16').AsString;

  if (MainTable<>'') and (DLTable<>'') then
  begin
    try
      qry:=Tadoquery.Create (nil);
      qry.Connection :=dmfrm.ADOConnection1 ;

      dmfrm.ADOConnection1.BeginTrans;

      fhluser.LogUserRecord(self.mtDataSet1 );

      while (not dlDataSet1.Eof )do
      begin
        fhluser.LogUserRecord(self.dlDataSet1 );
        dlDataSet1.Next ;
      end;

      MKeyField:=fBillex.mkeyfld ;
      DLKeyField:= fBillex.fkeyfld;
      if Pos(',',MKeyField  )<>0 then
      MKeyField  :=LeftStr(MKeyField , Pos(',',MKeyField  )-1 );
      if Pos(',',DLKeyField )<>0 then
      DLKeyField  :=LeftStr(DLKeyField, Pos(',',DLKeyField  )-1 );

      qry.SQL.Add( 'delete '+DLTable+' where '+DLKeyField  +'='+quotedstr( fBillex.BillCode ) )  ;
      qry.ExecSQL;
      qry.SQL.Clear;
      qry.SQL.Add('delete '+MainTable+' where '+  MKeyField  +'='+quotedstr( fBillex.BillCode ) )  ;
      qry.ExecSQL;

      dmfrm.ADOConnection1.CommitTrans ;
      self.mtDataSet1.Close;
      self.dlDataSet1.Close;
      qry.Free ;
      OpenBill(fBillex.BillCode);
    except
      on E:Exception do
      begin
        dmfrm.ADOConnection1.RollbackTrans ;
        showmessage(e.Message);
      end;
    end;
  end;

end;

procedure TFrmBillEx.ActEditExecute(Sender: TObject);
begin
  self.mtDataSet1.Edit ;

  // EditPostAfter(false);
end;

procedure TFrmBillEx.ActSetBitExecute(Sender: TObject);
begin
  inherited;

if not dlDataSet1.IsEmpty then
begin
  if self.dlDataSet1.FindField('FisBit')<>nil then
  begin
     dlDataSet1.Edit;
     dlDataSet1.FieldByName('FisBit').AsBoolean:=not dlDataSet1.FieldByName('FisBit').AsBoolean ;
     dlDataSet1.Open ;
  end;
end;
end;

procedure TFrmBillEx.PrintAction1Execute(Sender: TObject);
 var
    printID:string;
    FrmMulModulePrint: TFrmMulModulePrint;
begin
  inherited;
  try
    printID:=self.fBillex.ID;
    FrmMulModulePrint:= TFrmMulModulePrint.Create (nil);
    FrmMulModulePrint.FrmIni(printID  ,self.mtDataSet1   ,inttostr(mtDataSet1.Tag ), self.fBillex.TopBoxId ,     fBillex.BtmBoxID ,DBGridDL  );
    FrmMulModulePrint.MaxPrintModule :=20;
    FrmMulModulePrint.ShowModal ;
  finally
    FrmMulModulePrint.Free ;
  end;
end;

procedure TFrmBillEx.ActSaveExecDLProcExecute(Sender: TObject);
var
  fbk:TBookmark;
  i:integer;
begin
if dlDataSet1.State in [dsedit] then
   dlDataSet1.Post ;

   dlDataSet1.First;
   while (not self.dlDataSet1.Eof )  do
  begin
     FhlUser.DoExecProc(dlDataSet1,null);
     dlDataSet1.Next;
   end;
  EditPostAfter(True);
  Screen.Cursor:=crDefault;
  self.OpenBill(self.fBillex.BillCode ) ; {  }
end;

procedure TFrmBillEx.ActUncheckExecute(Sender: TObject);
begin
  inherited;
    if self.mtDataSet1.IsEmpty then exit;
    Screen.Cursor:=CrSqlWait;
    try
    FhlUser.CheckRight(self.fBillex.UnChkRightId );
    if  dmFrm.ExecStoredProc(fBillex.UnChkProc ,varArrayof([fBillex.BillCode ,LoginInfo.EmpId,LoginInfo.LoginId])) then
    begin
        OpenBill(fBillex.BillCode);
    end;
    finally
    Screen.Cursor:=crDefault;
    end;
end;

procedure TFrmBillEx.RefreshAction1Execute(Sender: TObject);
begin
  inherited;
 mtDataSet1.Close;
 mtDataSet1.Open;

 dlDataSet1.Close;
 dlDataSet1.Open;

end;

procedure TFrmBillEx.ActSaveHaveTextFomulaExecute(Sender: TObject);
var  s,ss,f:widestring;
//var  fDict:TBeforePostDict;
var  pKeys,DLKeyFLDs:Tstrings;
var i:integer;
var MtValues:variant;
var BackOnCalcFields,BackUpDLBeforePost: TDataSetNotifyEvent ;
begin
 try
    self.dlDataSet1.AfterPost :=nil;
    if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
    begin
       dlDataSet1.Post;
    end;
    if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;
    try
       FhlUser.Validation  (self.dlDataSet1  ,true,false,false,false,false,false);
       FhlUser.Validation  (self.mtDataSet1   ,true,false,false,false,false,false);
    except
      on err :exception do
      begin
       showmessage(err.Message );
       exit;
      end;
    end;    
    Screen.Cursor:=CrSqlWait;
      //AutoKey
      if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
      begin
         fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
         pKeys:=Tstringlist.Create ;
         pKeys.CommaText :=   fBillex.mkeyfld;
         for i:=0 to pKeys.Count -1 do
         begin
            mtDataSet1.FieldByName(pKeys[i]).AsString:=fBillex.BillCode;
         end;
         pKeys.Free ;
      end;

      BackUpDLBeforePost:= dlDataSet1.BeforePost ;
      dlDataSet1.BeforePost:=nil;
      if  mtDataSet1.State in [dsedit,dsInsert]  then
      begin
        UpdateSysFieldsAndCalValue;
      end;
      DLKeyFLDs:=Tstringlist.Create ;
      DLKeyFLDs.CommaText :=fBillex.fkeyfld;
      MtValues :=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fBillex.fkeyfld);
      BackOnCalcFields:= dlDataSet1.OnCalcFields ;
     // dlDataSet1.OnCalcFields :=nil;                //加快保存速度
      Ds_UpdateAllRecs(self.DBGridDL , fBillex.fkeyfld ,  MtValues  ,self.PgBarSave   );
      freeandnil(DLKeyFLDs) ;
      //2010-1-30  无法计算总金额
      FhlKnl1.Ds_AssignValues(mtDataSet1,self.fBillex.mtSumFlds ,FhlKnl1.Ds_SumFlds(self.dlDataSet1 ,self.fBillex.dlSumFlds),false,false);

      dlDataSet1.BeforePost:=BackUpDLBeforePost   ;
      if dlDataSet1.findField(fBillex.QtyFld  )<>nil then
      if dlDataSet1.FieldByName(fBillex.QtyFld  ).AsFloat    = 0    then
         begin
            showmessage('请填写数量!');
            abort;
         end ;

      try
           mtDataSet1.UpdateBatch;
           dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板
         //  dlDataSet1.OnCalcFields:=BackOnCalcFields ;
      except  ////
          on err:exception do
          begin
            //  EditPostAfter(True);
            Screen.Cursor:=crDefault;
            showmessage(err.Message );
            exit;
          end;
      end;
     EditPostAfter(True);
     self.OpenBill(self.fBillex.BillCode ) ;
  finally
     Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmBillEx.ActChkChgExecute(Sender: TObject);
begin
  inherited;
     EditPostAfter(false);
     self.DBGridDL.Enabled :=true;
     self.DBGridDL.ReadOnly :=false;
     DBGridDL.Options:=DBGridDL.Options+[dgEditing];
end;

procedure TFrmBillEx.UserLogExecute(Sender: TObject);
begin
    if MessageDlg('选择yes查看表头日志,NO查看明细日志 ',mtInformation,[mbYes,mbNo],0)=mrYes then
      FhlUser.showLogwindow(self.mtDataSet1 ,fBillex.TopBoxID ,fBillex.BtmBoxID)
    else
      fhluser.showLogwindow (self.DBGridDL  );

end;

procedure TFrmBillEx.ActPropertyExecute(Sender: TObject);
var sql:string;
var
  frmid:string;
  fBillType:string;
  BillFrm:TFrmBillEx;
  EditorFrm:TEditorFrm ;
  Code ,tmpWindowsFID:string;
  FrmBillEx:TFrmBillEx ;
  LstParameterFLDs:Tstrings;
  i:integer;
  form:TAnalyseEx;
begin
   try
    sql:='select  A.F19,A.F17,A.F20 ,B.F_ID From T525 A  join '+ logininfo.SysDBPubName +'.dbo.T511 B  on A.F17=B.F06 where A.F02='+inttostr(fBillex.ActID )+' and A.f16=' +inttostr(Taction(Sender).Index )
        +' and A.f17=' +inttostr(Taction(Sender).ActionComponent.Tag  )+' and A.f04='+quotedstr( Ttoolbutton( Taction(Sender).ActionComponent).Caption   );
    fhlknl1.Kl_GetQuery2 (sql  );
    fBillType:=fhlknl1.FreeQuery.FieldByName('F19').AsString  ;
    frmid:=fhlknl1.FreeQuery.FieldByName('F17').AsString      ;
    tmpWindowsFID:=fhlknl1.FreeQuery.FieldByName('F_ID').AsString      ;
    if uppercase(fBillType)=uppercase('Analyser') then
    begin
        if self.dlDataSet1.FindField('sDefaultVals')<>nil then
        sDefaultVals:=self.dlDataSet1.fieldbyname('sDefaultVals').AsString;
        form:=TAnalyseEx.Create(Application)  ;

        form.hide;
        form.FWindowsFID :=tmpWindowsFID;
        form.InitFrm(frmid,null);
        //formstyle:=fsMDIChild;

        form.Showmodal;

    end;

    if uppercase(fBillType)=uppercase('Editor') then
    begin
        if self.dlDataSet1.FindField('sDefaultVals')<>nil then
          sDefaultVals:=self.dlDataSet1.fieldbyname('sDefaultVals').AsString;
        EditorFrm:=TEditorFrm.Create(self);
        EditorFrm.InitFrm(FrmId,self.dlDataSet1.fieldbyname(fhlknl1.FreeQuery.FieldByName('F20').AsString).AsString,dlDataSet1 ,DBGridDL ,fhlknl1.FreeQuery.FieldByName('F20').AsString  ) ;
        EditorFrm.ShowModal ;
        EditorFrm.Free ;
    end;
    if uppercase(fBillType)=uppercase('CRM') then
    begin

        if self.dlDataSet1.FindField('sDefaultVals')<>nil then
        sDefaultVals:=self.dlDataSet1.fieldbyname('sDefaultVals').AsString;
        FhlUser.ShowCRMFrm(frmid);
    end;
    if uppercase(fBillType)=uppercase('BillEx') then
    begin
      if not self.dlDataSet1.IsEmpty then
      begin
      LstParameterFLDs:=Tstringlist.Create ;
      LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
      for i:=0 to  LstParameterFLDs.Count -1 do
      begin
        if   self.dlDataSet1.FindField (LstParameterFLDs[i])<>nil then
        begin
           if self.dlDataSet1.FieldByName (LstParameterFLDs[i]).AsString <>'' then
           begin
               Code:=self.dlDataSet1.FieldByName (LstParameterFLDs[i]).AsString  ;
               break;
           end;
        end;
      end;
      end;

      FrmBillEx:=TFrmBillEx.Create(nil);
      FrmBillEx.SetParamDataset(self.dlDataSet1);
      FrmBillEx.FWindowsFID :=  tmpWindowsFID ;
      FrmBillEx.InitFrm(FrmId);
      if Code<>'' then
      begin
         FrmBillEx.OpenBill( code  );
      end;
      FrmBillEx.FormStyle :=fsnormal;
      FrmBillEx.Hide;
      FrmBillEx.Position :=poDesktopCenter;
      FrmBillEx.ScrollBtm.Visible :=true;
	  
      FrmBillEx.ShowModal ;
    end;
except
  on err:exception do
  showmessage(err.Message );
end;
end;

procedure TFrmBillEx.btnCtrlClick(Sender: TObject);
var  FrmCtrlConfig:TFrmCtrlConfig ;
begin
  try
    FrmCtrlConfig:=TFrmCtrlConfig.Create(nil) ;

    if  ( self.PnlBtmControls.ControlCount =0 )
     or ( messagedlg('设置表头控键?',  mtWarning,[mbyes,mbno],0)=mryes ) then
      FrmCtrlConfig.boxid :=self.fBillex.TopBoxID

    else
      FrmCtrlConfig.boxid :=self.fBillex.BtmBoxID  ;

    FrmCtrlConfig.ShowModal ;
  finally
    FrmCtrlConfig.Free;

  end;

end;

function TFrmBillEx.FirstCommarSection(Pstr: string): string;
begin
  if Pos(',',Pstr)<>0 then
    Result:=LeftStr(  Pstr, pos(',',Pstr)-1)
  else
    Result :=Pstr;
end;
 

procedure TFrmBillEx.InActiveBillExecute(Sender: TObject);
begin
  inherited;

  if (self.dlDataSet1.FindField('FIsCls')<>nil) then
  begin
    while not dlDataSet1.Eof do
    begin
      dlDataSet1.Edit;
      dlDataSet1.FieldByName ('FIsCls').AsBoolean :=true;
      dlDataSet1.Next;
    end;
//    dlDataSet1.Post;
  end;

  if (self.mtDataSet1.FindField('FIsCls')<>nil) then
  begin
      mtDataSet1.Edit;
      mtDataSet1.FieldByName ('FIsCls').AsBoolean :=true;
     // mtDataSet1.Post;
  end;
end;

procedure TFrmBillEx.ActiveBillExecute(Sender: TObject);
begin
   inherited;
  if (self.dlDataSet1.FindField('FIsCls')<>nil) then
  begin 
    while not dlDataSet1.Eof do
    begin
      dlDataSet1.Edit;
      dlDataSet1.FieldByName ('FIsCls').AsBoolean :=true;
      dlDataSet1.Next;
    end;
  end;

  if (self.mtDataSet1.FindField('FIsCls')<>nil) then
  begin
      mtDataSet1.Edit;
      mtDataSet1.FieldByName ('FIsCls').AsBoolean :=false;
  end;
end;

procedure TFrmBillEx.actMDLookupExecute(Sender: TObject);
var FrmMDImport:TFrmMDLookupImport          ;
begin
    FrmMDImport:=TFrmMDLookupImport.Create(nil);
    FrmMDImport.iniFrm(self.fBillex.OpenID,'',self.dlDataSet1 ,self.mtDataSet1   );
    FrmMDImport.ShowModal ;
    FrmMDImport.Free ;
end;

procedure TFrmBillEx.ActSaveHaveTextFomulaZeroQtyExecute(Sender: TObject);
var  s,ss,f:widestring;
//var  fDict:TBeforePostDict;
var  pKeys,DLKeyFLDs:Tstrings;
var i:integer;
var MtValues:variant;
var BackOnCalcFields,BackUpDLBeforePost: TDataSetNotifyEvent ;
begin
 try
    self.dlDataSet1.AfterPost :=nil;
    if self.dlDataSet1.State in [dsinsert ,dsEdit	] then
    begin
       dlDataSet1.Post;
    end;
    if    dlDataSet1.RecordCount <1 then
    begin
       showmessage('请加明细记录!');
       abort;
    end;
    try
       FhlUser.Validation  (self.dlDataSet1  ,true,false,false,false,false,false);
       FhlUser.Validation  (self.mtDataSet1   ,true,false,false,false,false,false);
    except
      on err :exception do
      begin
       showmessage(err.Message );
       exit;
      end;
    end;    
    Screen.Cursor:=CrSqlWait;

      //AutoKey
      if (mtDataSet1.State=dsInsert) and (fBillex.AutoKeyId<>'') then
      begin
         fBillex.BillCode:=dmFrm.GetMyId(fBillex.AutoKeyID );
         pKeys:=Tstringlist.Create ;
         pKeys.CommaText :=   fBillex.mkeyfld;
         for i:=0 to pKeys.Count -1 do
         begin
            mtDataSet1.FieldByName(pKeys[i]).AsString:=fBillex.BillCode;
         end;
         pKeys.Free ;
      end;

      BackUpDLBeforePost:= dlDataSet1.BeforePost ;
      dlDataSet1.BeforePost:=nil;
      if  mtDataSet1.State in [dsedit,dsInsert]  then
      begin
        UpdateSysFieldsAndCalValue;
      end;
      DLKeyFLDs:=Tstringlist.Create ;
      DLKeyFLDs.CommaText :=fBillex.fkeyfld;
      MtValues :=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fBillex.fkeyfld);
      BackOnCalcFields:= dlDataSet1.OnCalcFields ;
     // dlDataSet1.OnCalcFields :=nil;                //加快保存速度
      Ds_UpdateAllRecs(self.DBGridDL , fBillex.fkeyfld ,  MtValues  ,self.PgBarSave   );
      freeandnil(DLKeyFLDs) ;
      //2010-1-30  无法计算总金额
      FhlKnl1.Ds_AssignValues(mtDataSet1,self.fBillex.mtSumFlds ,FhlKnl1.Ds_SumFlds(self.dlDataSet1 ,self.fBillex.dlSumFlds),false,false);

      dlDataSet1.BeforePost:=BackUpDLBeforePost   ;
      try
           mtDataSet1.UpdateBatch;
           dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板
         //  dlDataSet1.OnCalcFields:=BackOnCalcFields ;
      except  ////
          on err:exception do
          begin
            //  EditPostAfter(True);
            Screen.Cursor:=crDefault;
            showmessage(err.Message );
            exit;
          end;
      end;
     EditPostAfter(True);
     self.OpenBill(self.fBillex.BillCode ) ;
  finally
     Screen.Cursor:=crDefault;
  end;
end;
procedure TFrmBillEx.ActApportionExecute(Sender: TObject);
var i:integer;
var PRAmount, SumDLAmount:double;
begin
  PRAmount:=self.mtDataSet1.fieldbyname('FAmt').AsFloat;
  SumDLAmount:=0;

  dlDataSet1.First;
  for i:=0 to dlDataSet1.RecordCount -1 do
  begin
      SumDLAmount:=SumDLAmount+ dldataset1.FieldByName(fBillex.DlFundFld ).asFloat;//*dldataset1.FieldByName(fBillex.DlPriceFld).asFloat;
      dlDataSet1.Next;
  end;
  
  dlDataSet1.First;
  for i:=0 to dlDataSet1.RecordCount -1 do
  begin
      if SumDLAmount<>0 then
      begin
        dlDataSet1.Edit;
        dldataset1.fieldbyname('FApportionAmt').Value := Round(PRAmount*dldataset1.fieldbyname(fBillex.DlFundFld).AsFloat/SumDLAmount);
        dlDataSet1.Post;
      end;
      dlDataSet1.Next;
  end;
end;

procedure TFrmBillEx.ResetPnlContentSize( importMode: boolean );
var i,MaxHeight:integer;
begin
    if importMode then
    begin 
        self.PnlBtm.Height:=150;
    end
    else
    begin
        MaxHeight:=0;
        for i:= 0 to PnlBtmControls.ControlCount -1 do
        begin
            if PnlBtmControls.Controls[i].Height> maxHeight then
               maxHeight := PnlBtmControls.Controls[i].Height +PnlBtmControls.Controls[i].Top;

        end;
        self.PnlBtm.Height:=maxHeight+20;
    end;
end;

procedure TFrmBillEx.ActOriExecute(Sender: TObject);
var sql:string;
var
  frmid,keyValue:string;
  fBillType:string;
  BillFrm:TFrmBillEx;
  EditorFrm:TEditorFrm ;
  Code ,tmpWindowsFID:string;
  FrmBillEx:TFrmBillEx ;
  LstParameterFLDs:Tstrings;
  i:integer;
  form:TAnalyseEx;
begin
  try
      //FhlUser.CheckToolButtonRight( inttostr( fBillex.actid)  , (sender as Taction).Name );

      try
        LstParameterFLDs:=Tstringlist.Create ;

        sql:='select  A.F19,A.F17,A.F20 ,B.F_ID From T525 A  join '+ logininfo.SysDBPubName +'.dbo.T511 B  on A.F17=B.F06 where A.F02='+ inttostr( fBillex.actid) +' and A.f16=' +inttostr(Taction(Sender).Index )
            +' and A.f17=' +inttostr(Taction(Sender).ActionComponent.Tag  )+' and A.f04='+quotedstr( Ttoolbutton( Taction(Sender).ActionComponent).Caption   );
        fhlknl1.Kl_GetQuery2 (sql  );
        fBillType:=fhlknl1.FreeQuery.FieldByName('F19').AsString  ;
        frmid:=fhlknl1.FreeQuery.FieldByName('F17').AsString      ;
        tmpWindowsFID:=fhlknl1.FreeQuery.FieldByName('F_ID').AsString      ;

        if uppercase(fBillType)=uppercase('Analyser') then
        begin
            if dlDataSet1.FindField('sDefaultVals')<>nil then
            sDefaultVals:= dlDataSet1.fieldbyname('sDefaultVals').AsString;

            LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
            for i:=0 to  LstParameterFLDs.Count -1 do
            begin
                if ( dlDataSet1.FindField (LstParameterFLDs[i])<>nil ) then
                LstParameterFLDs[i]:=LstParameterFLDs[i]+'='+ dlDataSet1.fieldbyname(LstParameterFLDs[i]).AsString;
            end;
            if LstParameterFLDs.Count>0 then
            sDefaultVals:=LstParameterFLDs.CommaText ;

            form:=TAnalyseEx.Create(Application)  ;
            form.FormStyle :=fsnormal;
            form.hide;
            form.FWindowsFID :=tmpWindowsFID;
            form.InitFrm(frmid,null);
            form.ShowModal;
        end;

        if uppercase(fBillType)=uppercase('BillEx') then
        begin
          if not self.dlDataSet1.IsEmpty then
          begin
            LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
            for i:=0 to  LstParameterFLDs.Count -1 do
            begin
              if   dlDataSet1.FindField (LstParameterFLDs[i])<>nil then
              begin
                 if dlDataSet1.FieldByName (LstParameterFLDs[i]).AsString <>'' then
                 begin
                     Code:=dlDataSet1.FieldByName (LstParameterFLDs[i]).AsString  ;
                     break;
                 end;
              end;
            end;
          end;

          FrmBillEx:=TFrmBillEx.Create(nil);
          FrmBillEx.SetParamDataset(dlDataSet1  );
          FrmBillEx.FWindowsFID :=  tmpWindowsFID ;
          FrmBillEx.InitFrm(FrmId);
          if Code<>'' then
          begin
             FrmBillEx.OpenBill( code  );
          end;
          FrmBillEx.FormStyle :=fsnormal;
          FrmBillEx.Hide;
          FrmBillEx.Position :=poDesktopCenter;
          FrmBillEx.ScrollBtm.Visible :=true;

          FrmBillEx.ShowModal ;
        end;
      finally
        sDefaultVals:='';
        LstParameterFLDs.Free;
      end;
  except
    on err:exception do
    showmessage(err.Message );
  end;
end;

end.



