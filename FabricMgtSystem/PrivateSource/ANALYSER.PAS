unit analyser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, ToolWin, DB, ADODB, ExtCtrls, StdCtrls,
  Menus, ActnList, TabEditor, Buttons , jpeg,  FhlKnl,billOpenDlg,UnitCreateComponent, DateUtils,
   Editor,IniFiles,Shellapi;

type
  TanalyserFrm = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    DBGrid1: TDBGrid;
    dlAdoDataSet1: TADODataSet;
    dlDataSource1: TDataSource;
    BtmPanel1: TPanel;
    Label1: TLabel;
    statLabel1: TLabel;
    ActionList1: TActionList;
    printAction0: TAction;
    refreshAction1: TAction;
    SortAction2: TAction;
    exportAction3: TAction;
    importAction4: TAction;
    closeAction5: TAction;
    finderAction6: TAction;
    dsfinderAction7: TAction;
    WarePropAction8: TAction;
    DeleteAction9: TAction;
    TopPanel1: TPanel;
    ChkBillAction10: TAction;
    dlFilterAction11: TAction;
    mtADODataSet1: TADODataSet;
    mtDataSource1: TDataSource;
    OpnDlDsBtn1: TSpeedButton;
    Print2Action12: TAction;
    mtADODataSet1IntegerField111: TIntegerField;
    ActOriBill13: TAction;
    ActUnChk: TAction;
    ActConfigStatus: TAction;
    ActSerialNo: TAction;
    ActInstallBillDetial: TAction;
    ActSpareOut: TAction;
    ActInstallBill: TAction;
    ActRepaireBill: TAction;
    ActEdit: TAction;
    ActChkPkMt: TAction;
    ActSalerOrderItem: TAction;
    ActSalerPayItem: TAction;
    ActFreeDeliveItem: TAction;
    ActViewMachOutBill: TAction;
    ActInstallItem: TAction;
    ActInstallSalaryItem: TAction;
    ActFreeDeliveSum: TAction;
    ActInstallOriBill: TAction;
    ActPlaySound: TAction;
    Action1: TAction;
    ActSprInOutItem: TAction;
    AcRprReturnAmt: TAction;
    ActRprOrderAmt: TAction;
    ActRprPayAmt: TAction;
    ActSpMachFetch: TAction;
    ActInstallDL: TAction;
    ActDisasembleMach: TAction;
    ActChkdldata: TAction;
    ActQcDL: TAction;
    ActRpSprWhin: TAction;
    Actscrap: TAction;
    ActUnDoApply: TAction;
    ActRprApplyID: TAction;
    ActSvInstall: TAction;
    ActBrInstall: TAction;
    ActRpFeeDL: TAction;
    ActRpItem: TAction;
    ActInnerCavityQc: TAction;
    Action2: TAction;
    ActSaleAfterOrder: TAction;
    ActUnSerialNoQc: TAction;
    ActCreateSerialNo: TAction;
    ActSprInOut: TAction;
    ActUserPrintPrt: TAction;
    ActNewOriBill: TAction;
    ActComplainDL: TAction;
    ActRemMachDL: TAction;
    ActRemSprDL: TAction;
    ActCltCriticalDL: TAction;
    ActCltRetVisiteDL: TAction;
    ActRtnSvCntDL: TAction;
    ActSLAftReplace: TAction;
    actOriData: TAction;
    ActChkMt: TAction;
    ActInstallFeeUnChk: TAction;
    ActSLAftUnchk: TAction;
    ActFnUnChk: TAction;
    ActRpFeeUnChk: TAction;
    ActSprReturnUnchk: TAction;
    ActRemMchReturnUnchk: TAction;
    Action3: TAction;
    ActInstallFeePrint: TAction;
    ActRpFeePrint: TAction;
    ActFeeBalance: TAction;
    ActMchSerialNoPrt: TAction;
    ActInsOrRpBill: TAction;
    ActInsDetail: TAction;
    ActRepairDetail: TAction;
    ActBillExInput: TAction;
    ActSerialDetail: TAction;
    ActVisitDetail: TAction;
    ActInstBill: TAction;
    procedure InitFrm(AFrmId:String;AmtParams:Variant);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dlAdoDataSet1AfterScroll(DataSet: TDataSet);
    procedure printAction0Execute(Sender: TObject);
    procedure refreshAction1Execute(Sender: TObject);
    procedure exportAction3Execute(Sender: TObject);
    procedure importAction1Execute(Sender: TObject);
    procedure closeAction1Execute(Sender: TObject);
    procedure finderAction1Execute(Sender: TObject);
    procedure dsfinderAction1Execute(Sender: TObject);
    procedure WarePropAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure ChkBillAction1Execute(Sender: TObject);
    procedure VldBillAction1Execute(Sender: TObject);
    procedure CloseBillAction1Execute(Sender: TObject);
    procedure dlBillAction1Execute(Sender: TObject);
    procedure dlFilterAction1Execute(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DrawColumnCellFntClr(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Print2Action1Execute(Sender: TObject);
    procedure SortAction2Execute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpnDlDsBtn1Click(Sender: TObject);
    procedure ActOriBill13Execute(Sender: TObject);
    procedure TopPanel1DblClick(Sender: TObject);
    procedure ActUnChkExecute(Sender: TObject);
    procedure ActConfigStatusExecute(Sender: TObject);
    procedure ActInstallBillDetialExecute(Sender: TObject);
    procedure ActSpareOutExecute(Sender: TObject);
    procedure ActInstallBillExecute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure ActChkPkMtExecute(Sender: TObject);
    procedure ActSalerOrderItemExecute(Sender: TObject);
    procedure ActSalerPayItemExecute(Sender: TObject);
    procedure ActFreeDeliveItemExecute(Sender: TObject);
    procedure ActInstallItemExecute(Sender: TObject);
    procedure ActInstallSalaryItemExecute(Sender: TObject);
    procedure ActFreeDeliveSumExecute(Sender: TObject);
    procedure ActInstallOriBillExecute(Sender: TObject);
    procedure ActPlaySoundExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure svPayChkExecute(Sender: TObject);
    procedure ActSprInOutItemExecute(Sender: TObject);
    procedure AcRprReturnAmtExecute(Sender: TObject);
    procedure ActRprOrderAmtExecute(Sender: TObject);
    procedure ActRprPayAmtExecute(Sender: TObject);
    procedure ActSpMachFetchExecute(Sender: TObject);
    procedure ActInstallDLExecute(Sender: TObject);
    procedure ActDisasembleMachExecute(Sender: TObject);
    procedure ActChkdldataExecute(Sender: TObject);
    procedure ActQcDLExecute(Sender: TObject);
    procedure ActRpSprWhinExecute(Sender: TObject);
    procedure ActscrapExecute(Sender: TObject);
    procedure ActUnDoApplyExecute(Sender: TObject);
    procedure ActRprApplyIDExecute(Sender: TObject);
    procedure ActSvInstallExecute(Sender: TObject);
    procedure ActBrInstallExecute(Sender: TObject);
    procedure ActRpFeeDLExecute(Sender: TObject);
    procedure ActRpItemExecute(Sender: TObject);
    procedure ActInnerCavityQcExecute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure ActSaleAfterOrderExecute(Sender: TObject);
    procedure ActUnSerialNoQcExecute(Sender: TObject);
    procedure ActCreateSerialNoExecute(Sender: TObject);
    procedure ActSprInOutExecute(Sender: TObject);
    procedure ActUserPrintPrtExecute(Sender: TObject);
    procedure ActNewOriBillExecute(Sender: TObject);
    procedure ActComplainDLExecute(Sender: TObject);
    procedure ActCltRetVisiteDLExecute(Sender: TObject);
    procedure ActCltCriticalDLExecute(Sender: TObject);
    procedure ActRemMachDLExecute(Sender: TObject);
    procedure ActRemSprDLExecute(Sender: TObject);
    procedure ActRtnSvCntDLExecute(Sender: TObject);
    procedure ActSLAftReplaceExecute(Sender: TObject);
    procedure ActChkMtExecute(Sender: TObject);
    procedure ActInstallFeeUnChkExecute(Sender: TObject);
    procedure ActSLAftUnchkExecute(Sender: TObject);
    procedure ActFnUnChkExecute(Sender: TObject);
    procedure ActRpFeeUnChkExecute(Sender: TObject);
    procedure ActSprReturnUnchkExecute(Sender: TObject);
    procedure ActRemMchReturnUnchkExecute(Sender: TObject);
    procedure actOriDataExecute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure ActInstallBalanceExecute(Sender: TObject);
    procedure ActRpFeeBalanceExecute(Sender: TObject);
    procedure ActInsOrRpBillExecute(Sender: TObject);
    procedure ActInsDetailExecute(Sender: TObject);
    procedure ActRepairDetailExecute(Sender: TObject);
    procedure ActBillExInputExecute(Sender: TObject);
    procedure ActSerialDetailExecute(Sender: TObject);
    procedure ActVisitDetailExecute(Sender: TObject);
    procedure ActInstBillExecute(Sender: TObject);
  private
    fFinderFrm,fdsFinderFrm:TForm;
    fTabEditorFrm:TTabEditorFrm;
    fDict:TAnalyserDict;
    fBillOpenDlgFrm:TBillOpenDlgFrm;
  public
    { Public declarations }
  end;

var
  analyserFrm: TanalyserFrm;
  const MulSelMessage:string='需要多选时请按Ctrl并点选择记录';
implementation
uses datamodule,repgrid,colProp,bill, RepBill, Inv,UnitBillConfigStatus,   UnitUserReport , UnitUserDefineRpt,
     UnitSerialNos,UnitBillEx;
{$R *.dfm}

procedure TanalyserFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);

begin
 mtADODataSet1.Cancel;

 fFinderFrm.Free;
 fdsFinderFrm.Free;
 fTabEditorFrm.Free;
 Action:=caFree;

end;

procedure TanalyserFrm.InitFrm(AFrmId:String;AmtParams:Variant);
var i:integer;
begin
  if Not FhlKnl1.Cf_GetDict_Analyser(AFrmId,fdict) then Close;
  Caption:=fDict.Caption;

  if  (fDict.Actions<>'' ) and (fDict.Actions<>'-1' ) then
  FhlKnl1.Tb_CreateActionBtns(ToolBar1,ActionList1,fDict.Actions);

  FhlUser.SetDataSet(mtAdoDataSet1,fDict.mtDataSetId,AmtParams);
  if mtAdoDataSet1.Active then
  begin
      FhlUser.AssignDefault(mtAdoDataSet1);
      if mtAdoDataSet1.IsEmpty then
      begin
          mtAdoDataSet1.Append;
      end;
  end;
  
  if (fDict.TopBoxId<>'-1') and (fDict.TopBoxId<>'' ) then      //top or buttom      create label and dbcontrol
    FhlKnl1.Cf_SetBox(fDict.TopBoxId,mtDataSource1,TopPanel1,dmFrm.dbCtrlActionList1);
  if (fDict.BtmBoxId<>'-1') and (fDict.BtmBoxId<> '') then
    FhlKnl1.Cf_SetBox(fDict.BtmBoxId,mtDataSource1,BtmPanel1,dmFrm.dbCtrlActionList1);
  if fDict.DblActIdx>-1 then
    DbGrid1.OnDblClick:=ActionList1.Actions[fDict.DblActIdx].OnExecute;


  FhlUser.SetDbGridAndDataSet(DbGrid1,fDict.DbGridId,null,false);
  if dlAdoDataSet1.FindField('FntClr')<>nil then
     DbGrid1.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr
  else
  begin
      for i:=0 to self.DBGrid1.Columns.Count -1 do
      begin
          if uppercase(self.DBGrid1.Columns[i].FieldName) = uppercase( 'FntClr' )then
          begin
               DbGrid1.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
               break;
          end;
      end;

  end;


  if fDict.IsOpen then
  begin
    if mtAdoDataSet1.Active then
      OpnDlDsBtn1.Click         //查询
    else
      dlAdoDataSet1.Open;
  end;
  if fDict.DlgIdx>-1 then
    ActionList1.Actions[fDict.DlgIdx].Execute;

   if   dgMultiselect in dbgrid1.Options then      //2006-7-26加入多先功能
     DBGrid1.Hint :=MulSelMessage;
end;

procedure TanalyserFrm.dlAdoDataSet1AfterScroll(DataSet: TDataSet);
begin
     statLabel1.Caption:=intTostr(dlAdoDataSet1.RecNo)+'/'+intTostr(dlAdoDataSet1.RecordCount);

     if dlAdoDataSet1.FindField('F_IsChk')<>nil then
     if dlAdoDataSet1.FieldByName('F_IsChk').AsBoolean =true then
     begin
        ActUnChk.Enabled :=true;
        ChkBillAction10.Enabled :=false;
     end
     else
     begin
        ActUnChk.Enabled :=false    ;
        ChkBillAction10.Enabled :=true;
     end;

end;

procedure TanalyserFrm.printAction0Execute(Sender: TObject);
begin
 FhlKnl1.Rp_DbGrid(intTostr(DbGrid1.Tag),DbGrid1,self.fDict.Caption );
end;

procedure TanalyserFrm.refreshAction1Execute(Sender: TObject);
begin
  if dlAdoDataSet1.Active then
    FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);
end;

procedure TanalyserFrm.exportAction3Execute(Sender: TObject);
begin
 with dmFrm.OpenDialog1 do
 begin
   Filter:='FHL数据包(*.fhl)|*.fhl';
   if Execute then
   begin
     Screen.Cursor:=crHourGlass;
     try
       dlAdoDataSet1.SaveToFile(ChangeFileExt(FileName,'.fhl'));
     finally
       Screen.Cursor:=crDefault;
     end;
   end;
 end;
end;

procedure TanalyserFrm.importAction1Execute(Sender: TObject);
begin
 with dmFrm.OpenDialog1 do
 begin
   Filter:='FHL数据文件(*.fhl)|*.fhl';
   if Execute then
      dlAdoDataSet1.LoadFromFile(FileName);
 end;
end;

procedure TanalyserFrm.closeAction1Execute(Sender: TObject);
begin
close;
end;

procedure TanalyserFrm.finderAction1Execute(Sender: TObject);
begin
   FhlUser.ShowFinderFrm(dlAdoDataSet1,fFinderFrm,fDict.FinderId);
end;

procedure TanalyserFrm.dsfinderAction1Execute(Sender: TObject);
  var fParams:variant;
begin
  fParams:=FhlUser.ShowdsFinderFrm(fdsFinderFrm,fDict.dsFinderId);
  if Not VarIsNull(fParams) then
     FhlKnl1.Ds_OpenDataSet(dlAdoDataSet1,fParams);
end;

procedure TanalyserFrm.WarePropAction1Execute(Sender: TObject);
begin
  FhlUser.CheckRight(fDict.WarePropRitId);
  FhlUser.ShowWarePropFrm(dlAdoDataSet1.FieldByName('Id').asString,dlDataSource1);
end;

procedure TanalyserFrm.DeleteAction1Execute(Sender: TObject);
begin
  if Not Assigned(dlAdoDataSet1.BeforeDelete) and (MessageDlg(fsDbDelete,mtConfirmation,[mbYes,mbNo],0)<>mrYes) then
     Abort;
  dlAdoDataSet1.Delete;
end;

procedure TanalyserFrm.ChkBillAction1Execute(Sender: TObject);
  var fBillDict:TBillDict;
begin
if self.dlAdoDataSet1.IsEmpty then exit;
  FhlKnl1.Cf_GetDict_Bill(fDict.Tag,fBillDict);
  fbilldict.BillCode:=self.dlAdoDataSet1.FieldByName(fbilldict.mkeyfld).asString;

  FhlUser.CheckRight( fBillDict.CheckRitId );

  dmFrm.ExecStoredProc(fbilldict.chkproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
  FhlKnl1.Ds_RefreshDataSet(self.dlAdoDataSet1);
  self.dlAdoDataSet1.Locate(fbilldict.mkeyfld,fbilldict.BillCode,[]);

  ActUnChk.Enabled :=true;
  ChkBillAction10.Enabled :=false;
end;

procedure TanalyserFrm.VldBillAction1Execute(Sender: TObject);
  var fBillDict:TBillDict;
begin

end;

procedure TanalyserFrm.CloseBillAction1Execute(Sender: TObject);
  var fBillDict:TBillDict;
begin

end;

procedure TanalyserFrm.dlBillAction1Execute(Sender: TObject);
var
  fBillId:String;
begin
  fBillId:=dlAdoDataSet1.FieldByName('BillId').AsString;
  if fBillId='-1' then exit;
  FhlUser.ShowBillFrm(fBillId,dlAdoDataSet1.FieldByName('BillCode').asString);
//    FhlUser.ShowEditorFrm('Analyser.'+fDict.Id,null,dlAdoDataSet1).ShowModal;
end;

procedure TanalyserFrm.dlFilterAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(dlAdoDataSet1);
end;

procedure TanalyserFrm.DBGrid1DrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DbGrid1.DataSource.DataSet.IsEmpty then exit;

  if   dlAdoDataSet1.FindField('FntClr') <>nil then
  begin
      DbGrid1.Canvas.Font.Color:=StringToColor(dlAdoDataSet1.FieldByName('FntClr').AsString);
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,DbGrid1.Canvas.Font);
  end;
end;

procedure TanalyserFrm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

if NOT  ( dgMultiselect in dbgrid1.Options) then
  FhlKnl1.Dg_DrawZebraBackgroud(Sender,Rect,DataCol,Column,State,clWhite,clCream);




end;

procedure TanalyserFrm.Print2Action1Execute(Sender: TObject);
begin
  Screen.Cursor:=crSqlWait;
  RepBillFrm:=TRepBillFrm.Create(Application);
  dlAdoDataSet1.DisableControls;
  try
    RepBillFrm.SetBillRep(fdict.TopBoxId,fdict.BtmBoxId,mtAdoDataSet1,DbGrid1);
    RepBillFrm.PreviewModal;
  finally
    dlAdoDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
    RepBillFrm.Free;
  end;
end;

procedure TanalyserFrm.SortAction2Execute(Sender: TObject);
begin
  FhlKnl1.Dg_Sort(DbGrid1);
end;

procedure TanalyserFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

     case key of
       vk_Escape:Close;
       vk_Return:begin
                      OpnDlDsBtn1.Click ;
                 end;
     end;
     
end;

procedure TanalyserFrm.OpnDlDsBtn1Click(Sender: TObject);
var fParams:variant;
//  var i:integer;
var  abortstr,WarningStr:string;
begin


  with mtAdoDataSet1 do
  begin
      if (State=dsInsert) or (State=dsEdit) then  //update parameter getvalue
      begin
        UpdateRecord;
        Post;
      end;
  end;

    fParams:=FhlKnl1.Ds_GetFieldsValue(mtAdoDataSet1,fDict.mtOpenParamFlds);
 

    if Not VarIsNull(fParams) then
    begin
         FhlKnl1.Ds_OpenDataSet(dlAdoDataSet1,fParams);
    end;



 if assigned(  dlAdoDataSet1.FindField('fntclr')) then
    DbGrid1.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
end;

procedure TanalyserFrm.ActOriBill13Execute(Sender: TObject);
var
frmid:string;
fBillType:string;
BillFrm:TBillFrm;
EditorFrm:TEditorFrm ;
Code:string;
FrmBillEx:TFrmBillEx ;
begin

  if dlAdoDataSet1.FindField('code')<>nil then
  Code:=self.dlAdoDataSet1.fieldbyname('code').AsString ;


  if dlAdoDataSet1.FindField('frmid')=nil then   exit;
  if dlAdoDataSet1.fieldbyname('frmid').Value =null then exit;
  frmid:=dlAdoDataSet1.fieldbyname('frmid').Value ;


  if dlAdoDataSet1.FindField('BillType')<>nil then
  fBillType:=self.dlAdoDataSet1.fieldbyname('BillType').AsString ;

  if uppercase(fBillType)=uppercase('Bill') then
  begin
      if Code<>'' then
      begin
      BillFrm:=TBillFrm.Create(nil);

      BillFrm.FormStyle :=fsnormal;
      BillFrm.InitFrm(frmid)      ;
      BillFrm.Hide;
      BillFrm.OpenBill(Code);
      BillFrm.DownBtn.Visible  :=false;

      BillFrm.MailBtn.Visible :=false;
      BillFrm.FaxBtn.Visible :=false;
      BillFrm.RemoveBtn.Visible  :=false;
      BillFrm.linkBtn.Visible  :=false;

      BillFrm.importBtn.Visible  :=false;
      BillFrm.AddBtn.Visible  :=false;
      BillFrm.DelBtn.Visible  :=false;
      BillFrm.ScrollBox1.Visible  :=true;
      
     // BillFrm.DBGrid1.ReadOnly :=true;
      BillFrm.CheckAction1.Enabled:=true;

      BillFrm.OpenBtn.Visible  :=false;
      BillFrm.NewBtn.Visible  :=false;

      BillFrm.ShowModal ;
      BillFrm.Free ;
     // self.refreshAction1.Execute;
      end;
  end;


  if uppercase(fBillType)=uppercase('AnA') then
  begin
      if dlAdoDataSet1.FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.dlAdoDataSet1.fieldbyname('sDefaultVals').AsString;
      FhlUser.ShowAnalyserFrm(frmid,null);
  end;

  if uppercase(fBillType)=uppercase('Editor') then
  begin
      if dlAdoDataSet1.FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.dlAdoDataSet1.fieldbyname('sDefaultVals').AsString;
      FhlUser.ShowEditorFrm(FrmId,Code).ShowModal ;
  end;
  if uppercase(fBillType)=uppercase('Tsb') then
  begin
      if dlAdoDataSet1.FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.dlAdoDataSet1.fieldbyname('sDefaultVals').AsString;
      FhlUser.ShowTabEditorFrm(FrmId  ,code);
  end;

  if uppercase(fBillType)=uppercase('BillEx') then
  begin
      if Code<>'' then
      begin
       FrmBillEx:=TFrmBillEx.Create(nil);
       FrmBillEx.InitFrm(FrmId);
       FrmBillEx.OpenBill( code  );
       FrmBillEx.FormStyle :=fsnormal;
       FrmBillEx.Hide;
     //  FrmBillEx.AutoSize:=true;
      FrmBillEx.Position :=poDesktopCenter;
       FrmBillEx.ScrollBtm.Visible :=true;
       FrmBillEx.SetParamDataset(self.dlAdoDataSet1 );

       FrmBillEx.ShowModal ;


      end;

  end;

end;

procedure TanalyserFrm.TopPanel1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
        FrmUserDefineReport1: TFrmUserDefineReport;
begin
  if GetKeyState(vk_control) <0  then
  begin
      FrmUserDefineReport1:= TFrmUserDefineReport.Create (self);
      FrmUserDefineReport1.IniDefinePrt(self.mtADODataSet1 , self.fDict.mtDataSetId ,self.fDict.TopBoxId ,self.fDict.BtmBoxId,self.DBGrid1 );
      FrmUserDefineReport1.ShowModal ;
      FrmUserDefineReport1.Free ;
      exit;
  end;
  if LoginInfo.Sys  then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.TOPBoxId :=self.fDict.TopBoxId ;
    CrtCom.TopOrBtm:=true;
    CrtCom.mtDataSet1:=self.mtADODataSet1 ;
    CrtCom.mtDataSetId :=inttostr(mtADODataSet1.tag);
    CrtCom.DlGridId :=inttostr(self.DBGrid1.Tag ) ;
    CrtCom.DLGrid :=self.DBGrid1 ;

    CrtCom.ShowModal ;
    CrtCom.Free ;
  end;

try
  
finally

end;
end;
procedure TanalyserFrm.ActUnChkExecute(Sender: TObject);
  var fBillDict:TBillDict;
begin
 if self.dlAdoDataSet1.IsEmpty then exit;

  FhlKnl1.Cf_GetDict_Bill(fDict.Tag,fBillDict);
  fbilldict.BillCode:=self.dlAdoDataSet1.FieldByName(fbilldict.mkeyfld).asString;
  FhlUser.CheckRight( fBillDict.UnChkRitId );

  dmFrm.ExecStoredProc(fbilldict.unchkproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
  FhlKnl1.Ds_RefreshDataSet(self.dlAdoDataSet1);
  self.dlAdoDataSet1.Locate(fbilldict.mkeyfld,fbilldict.BillCode,[])    ;

  ActUnChk.Enabled :=false;
  ChkBillAction10.Enabled :=true;

end;

procedure TanalyserFrm.ActConfigStatusExecute(Sender: TObject);
var BillConfigStatusFrm:TBillConfigStatusFrm;
var
frmid:string;
fBillType:string;
BillFrm:TBillFrm;
EditorFrm:TEditorFrm ;
Code:string;
begin

  if dlAdoDataSet1.FindField('code')<>nil then
  Code:=self.dlAdoDataSet1.fieldbyname('code').AsString ;


  if dlAdoDataSet1.FindField('frmid')=nil then   exit;
  if dlAdoDataSet1.fieldbyname('frmid').Value =null then exit;
  frmid:=dlAdoDataSet1.fieldbyname('frmid').Value ;


  if dlAdoDataSet1.FindField('BillType')<>nil then
  fBillType:=self.dlAdoDataSet1.fieldbyname('BillType').AsString ;



  if uppercase(fBillType)=uppercase('Bill') then
  begin
      if Code<>'' then
      begin
            BillConfigStatusFrm:=TBillConfigStatusFrm.create (nil);
            BillConfigStatusFrm.Position :=poscreencenter;

            BillConfigStatusFrm.FormStyle :=fsnormal;
            BillConfigStatusFrm.InitFrm(frmid)      ;
            BillConfigStatusFrm.Hide;
            BillConfigStatusFrm.OpenBill(Code);
            BillConfigStatusFrm.ConfigBillStatusButtons   ;
            BillConfigStatusFrm.ShowModal ;
            BillConfigStatusFrm.Free ;

            self.refreshAction1.Execute;
      end;
  end;


end;

procedure TanalyserFrm.ActInstallBillDetialExecute(Sender: TObject);
begin
dmfrm.InstallBillDetial(self.dlAdoDataSet1 );
end;

procedure TanalyserFrm.ActSpareOutExecute(Sender: TObject);
var FrmSerialNos:TFrmSerialNos   ;
begin
      if not  self.dlAdoDataSet1.IsEmpty then
      begin
          FrmSerialNos:=TFrmSerialNos.Create(nil);
          FrmSerialNos.SetStateAndFlagFld('F_Flag','2,10,20,30,40,50,60');
          FrmSerialNos.FrmIni ('1000', self.dlAdoDataSet1.fieldbyname('F_RprApplyID').AsString, 'F_RprApplyID');
         FrmSerialNos.SetGridOutBill (self.DBGrid1 );
         
          FrmSerialNos.ShowModal ;
          FrmSerialNos.free;
      end;

end;

procedure TanalyserFrm.ActInstallBillExecute(Sender: TObject);
begin
dmfrm.InstallBillDetial(self.dlAdoDataSet1 );  //安装单
end;

procedure TanalyserFrm.ActEditExecute(Sender: TObject);
begin
   TEditorFrm(FhlUser.ShowEditorFrm('106',null,self.dlAdoDataSet1)).ShowModal;
end;

procedure TanalyserFrm.ActChkPkMtExecute(Sender: TObject);
var MsgStr:string;
begin  //54204267 breeze

    if   (dlAdoDataSet1.Active )  and (not dlAdoDataSet1.IsEmpty) then
    begin
        if    dlAdoDataSet1.FindField('F_IsChk')<>nil then
         if   dlAdoDataSet1.FieldByName('F_ISChk').AsBoolean  then
             MsgStr:=    '您确定要弃审吗?'
         else
             MsgStr:=    '您确定要审核吗?';

          if MessageDlg(#13#10+MsgStr,mtWarning,mbOkCancel,0)=mrOk then
          begin
             Screen.Cursor:=CrSqlWait;
            try
              FhlUser.DoExecProc(dlAdoDataSet1,null);
               dlAdoDataSet1.Close;
               dlAdoDataSet1.Open;
            finally
             Screen.Cursor:=crDefault;
            end;
        end;

    end;

end;
procedure TanalyserFrm.ActSalerPayItemExecute(Sender: TObject);
begin
if dlAdoDataSet1.Active then
begin
    sDefaultVals:='';
    sDefaultVals:='F_BranchCode='+self.dlAdoDataSet1.fieldbyname('F_BranchCode').AsString +','   ;
    sDefaultVals:=sDefaultVals+'F_BeginDate='+self.DLADODataSet1.fieldbyname('F_BeginDate').AsString +','    ;
    sDefaultVals:=sDefaultVals+'F_EndDate='+self.DLADODataSet1.fieldbyname('F_EndDate').AsString  ;

    FhlUser.ShowAnalyserFrm('129',null);
end;

end;
procedure TanalyserFrm.ActSalerOrderItemExecute(Sender: TObject);
begin
if dlAdoDataSet1.Active then
begin
    sDefaultVals:='';
    sDefaultVals:='F_BranchCode='+self.dlAdoDataSet1.fieldbyname('F_BranchCode').AsString +','   ;
    sDefaultVals:=sDefaultVals+'F_BeginDate='+self.DLADODataSet1.fieldbyname('F_BeginDate').AsString +','    ;
    sDefaultVals:=sDefaultVals+'F_EndDate='+self.DLADODataSet1.fieldbyname('F_EndDate').AsString  ;

    FhlUser.ShowAnalyserFrm('132',null);
end;
end;



procedure TanalyserFrm.ActFreeDeliveItemExecute(Sender: TObject);
begin
if dlAdoDataSet1.Active then
begin
    sDefaultVals:='';
    sDefaultVals:='F_BranchCode='+self.dlAdoDataSet1.fieldbyname('F_BranchCode').AsString +','   ;
    sDefaultVals:=sDefaultVals+'F_BeginDate='+self.mtADODataSet1.fieldbyname('F_BeginDate').AsString +','    ;
    sDefaultVals:=sDefaultVals+'F_EndDate='+self.mtADODataSet1.fieldbyname('F_EndDate').AsString  +',';
    if mtADODataSet1.FieldByName('F_IsGroupBySlCenter').AsBoolean then
       sDefaultVals:=sDefaultVals+'F_SlCenterCode='+self.mtADODataSet1.fieldbyname('F_SlCenterCode').AsString  +',';
    sDefaultVals:=sDefaultVals+'F_MchTypeCode='+self.dlAdoDataSet1.fieldbyname('F_MchTypeCode').AsString    ;


      Screen.Cursor:=crAppStart;
      try
      with TAnalyserFrm.Create(Application) do
      begin
            formstyle:=fsNormal;
            hide;
            InitFrm('131',null);
            Showmodal;
      end;
      finally
      Screen.Cursor:=crDefault;
      end;
    {   }
end;

end;

procedure TanalyserFrm.ActInstallItemExecute(Sender: TObject);
begin
if dlAdoDataSet1.Active then
begin
    sDefaultVals:='';
    sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString +','   ;
    sDefaultVals:=sDefaultVals+'startTime='+self.dlAdoDataSet1.fieldbyname('F_BeginDate').AsString +','    ;
    sDefaultVals:=sDefaultVals+'Endtime='+self.dlAdoDataSet1.fieldbyname('F_EndDate').AsString  ;

    FhlUser.ShowAnalyserFrm('123',null);
end;
end;

procedure TanalyserFrm.ActInstallSalaryItemExecute(Sender: TObject);
begin
if dlAdoDataSet1.Active then
begin
    sDefaultVals:='';
    sDefaultVals:='F_EmpCode='+self.dlAdoDataSet1.fieldbyname('F_EmpCode').AsString +','   ;
    sDefaultVals:=sDefaultVals+'startTime='+self.mtADODataSet1.fieldbyname('startTime').AsString +','    ;
    sDefaultVals:=sDefaultVals+'Endtime='+self.mtADODataSet1.fieldbyname('Endtime').AsString  ;

    FhlUser.ShowAnalyserFrm('135',null);
end;

end;

procedure TanalyserFrm.ActFreeDeliveSumExecute(Sender: TObject);
begin
if dlAdoDataSet1.Active then
begin
    sDefaultVals:='';
    sDefaultVals:='F_BranchCode='+self.dlAdoDataSet1.fieldbyname('F_BranchCode').AsString +','   ;
    sDefaultVals:=sDefaultVals+'F_BeginDate='+self.DLADODataSet1.fieldbyname('F_BeginDate').AsString +','    ;
    sDefaultVals:=sDefaultVals+'F_EndDate='+self.DLADODataSet1.fieldbyname('F_EndDate').AsString  ;

    FhlUser.ShowAnalyserFrm('137',null);
end;    
end;

procedure TanalyserFrm.ActInstallOriBillExecute(Sender: TObject);
begin
if (dlAdoDataSet1.Active ) and ( not dlAdoDataSet1.IsEmpty ) then

    dmfrm.InstallBillDetial(self.dlAdoDataSet1.fieldbyname('F_Code').AsString );
end;

procedure TanalyserFrm.ActPlaySoundExecute(Sender: TObject);
var
  IPstr,Dirpath,Filename: string;
  IPURLINI: TIniFile;
begin

if (dlAdoDataSet1.Active ) and (not dlAdoDataSet1.IsEmpty ) then
begin

  Filename:=ExtractFilePath(Paramstr(0))+'Config.ini';
  IPURLINI:=Tinifile.Create(Filename);
  IPstr:=IPURLINI.ReadString('URL','IPURL','');
  Dirpath:=self.dlAdoDataSet1.fieldbyname('F_LeaveMessage').AsString ;
  Shellexecute(handle,'open',pchar(IPstr+Dirpath),'','',sw_show);
  IPURLINI.free;    { }
end;
end;

procedure TanalyserFrm.Action1Execute(Sender: TObject);
begin
   TEditorFrm(FhlUser.ShowEditorFrm('115',null,self.dlAdoDataSet1)).ShowModal;
end;

procedure TanalyserFrm.svPayChkExecute(Sender: TObject);

begin  //54204267 breeze


end;

procedure TanalyserFrm.ActSprInOutItemExecute(Sender: TObject);
begin
    if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString +','   ;

        sDefaultVals:=sDefaultVals+'F_SpareCode='+self.dlAdoDataSet1.fieldbyname('F_SpareCode').AsString     ;

        FhlUser.ShowAnalyserFrm('155',null);
    end;
end;

procedure TanalyserFrm.AcRprReturnAmtExecute(Sender: TObject);

begin
          if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString +','   ;
        sDefaultVals:=sDefaultVals+'starttime='+self.dlAdoDataSet1.fieldbyname('F_datetime').AsString +','   ;
        sDefaultVals:=sDefaultVals+'endtime='+self.dlAdoDataSet1.fieldbyname('F_endDate').AsString    ;

        FhlUser.ShowAnalyserFrm('147',null);
    end;
end;

procedure TanalyserFrm.ActRprOrderAmtExecute(Sender: TObject);
begin
     if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString +','   ;
        sDefaultVals:=sDefaultVals+'starttime='+self.dlAdoDataSet1.fieldbyname('F_datetime').AsString  +',' ;
        sDefaultVals:=sDefaultVals+'endtime='+self.dlAdoDataSet1.fieldbyname('F_endDate').AsString     ;

        FhlUser.ShowAnalyserFrm('148',null);
    end;
end;

procedure TanalyserFrm.ActRprPayAmtExecute(Sender: TObject);
begin
       if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString +','   ;
        sDefaultVals:=sDefaultVals+'F_BeginDate='+self.dlAdoDataSet1.fieldbyname('F_datetime').AsString    +',' ;
        sDefaultVals:=sDefaultVals+'F_EndDate='+self.dlAdoDataSet1.fieldbyname('F_EndDate').AsString    ;

        FhlUser.ShowAnalyserFrm('152',null);
    end;
end;

procedure TanalyserFrm.ActSpMachFetchExecute(Sender: TObject);
begin
       if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString +','   ;
        sDefaultVals:='F_WhCode='+self.dlAdoDataSet1.fieldbyname('F_SPMachWh').AsString    ;
     //   sDefaultVals:='F_MchTypeCode='+self.dlAdoDataSet1.fieldbyname('F_MchTypeCode').AsString  ;//+','   ;
//        sDefaultVals:=sDefaultVals+'F_BeginDate='+self.dlAdoDataSet1.fieldbyname('F_datetime').AsString    +',' ;
 //      sDefaultVals:=sDefaultVals+'F_EndDate='+self.dlAdoDataSet1.fieldbyname('F_EndDate').AsString    ;

        FhlUser.ShowAnalyserFrm('176',null);
    end;
end;

procedure TanalyserFrm.ActInstallDLExecute(Sender: TObject);
var
  s,d:string;
begin
  case DbGrid1.SelectedIndex of                //安装明细
    3:
    with dlAdoDataSet1 do
    begin
      s:=FieldByName('InItmId').AsString;
      d:=FieldByName('InDblId').AsString;
    end;
    7:
    with dlAdoDataSet1 do
    begin
      s:=FieldByName('OutItmId').AsString;
      d:=FieldByName('OutDblId').AsString;
    end;
    1:begin
        ShowMessage(#13#10+dlAdoDataSet1.FieldByName('InExplain').AsString);
        exit;
      end;
    5:begin
        ShowMessage(#13#10+dlAdoDataSet1.FieldByName('OutExplain').AsString);
        exit;
      end
  else
    exit;
  end;
  sDefaultVals:='ItemId='+s+',WhId='+mtAdoDataSet1.FieldByName('WhId').AsString+',BeginDate='+mtAdoDataSet1.FieldByName('BeginDate').asString+',EndDate='+mtAdoDataSet1.FieldByName('EndDate').asString;
  FhlUser.ShowAnalyserFrm(d,null);
  

end;


procedure TanalyserFrm.ActDisasembleMachExecute(Sender: TObject);
var
frmid:string;
fBillType:string;
BillFrm:TBillFrm;
EditorFrm:TEditorFrm ;
Code:string;

i,Sum:integer;


begin



end;


procedure TanalyserFrm.ActChkdldataExecute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.DoExecProc(dlAdoDataSet1,null);
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  try
   dlAdoDataSet1.GotoBookmark(fbk);
   except

   end;
end;

procedure TanalyserFrm.ActQcDLExecute(Sender: TObject);
begin
             if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:='F_TypeName='+self.dlAdoDataSet1.fieldbyname('F_Name').AsString ;//+','   ;
 //      sDefaultVals:='F_WhCode='+self.dlAdoDataSet1.fieldbyname('F_SPMachWh').AsString    ;
     //   sDefaultVals:='F_MchTypeCode='+self.dlAdoDataSet1.fieldbyname('F_MchTypeCode').AsString  ;//+','   ;
//        sDefaultVals:=sDefaultVals+'F_BeginDate='+self.dlAdoDataSet1.fieldbyname('F_datetime').AsString    +',' ;
 //      sDefaultVals:=sDefaultVals+'F_EndDate='+self.dlAdoDataSet1.fieldbyname('F_EndDate').AsString    ;

         FhlUser.ShowAnalyserFrm('188',null);

    end;


end;

procedure TanalyserFrm.ActRpSprWhinExecute(Sender: TObject);

var
  fbk:TBookmark;
begin
  FhlUser.DoExecProc(dlAdoDataSet1,null);
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

     try
        if dlAdoDataSet1.BookmarkValid(fbk)  then
        dlAdoDataSet1.GotoBookmark(fbk);
     except
     end
end;

procedure TanalyserFrm.ActscrapExecute(Sender: TObject);
var ReturnBool:boolean;
var      ResultHint:STRING;
var Aparams:Variant                 ;
var fbk:TBookmark;
begin
 // FhlUser.DoExecProc(dlAdoDataSet1,null);


        Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(self.dlAdoDataSet1 ,'F_MchReturnID,F_SpareCode,F_SprSerialNo,F_RemMchSprResCode,F_BillType,F_RprApplyid'),Aparams);

      ReturnBool:=dmFrm.ExecStoredProc('SP_RemSprScrapApply1',FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal('sEmpid'),Aparams ));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          ResultHint:=Parameters.Items[1].Value;
      end;
      if ResultHint<>'' then MessageDlg(#13#10+ResultHint,mtError,[mbOk],0);
      if Not ReturnBool then Abort;

    fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

     try
        if dlAdoDataSet1.BookmarkValid(fbk)  then
        dlAdoDataSet1.GotoBookmark(fbk);
     except
     end
end;

procedure TanalyserFrm.ActUnDoApplyExecute(Sender: TObject);
var ReturnBool:boolean;
var      ResultHint:STRING;
var Aparams:Variant    ;
var fbk:TBookmark;
begin
 // FhlUser.DoExecProc(dlAdoDataSet1,null);


        Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(self.dlAdoDataSet1 ,'F_MchReturnID,F_SpareCode,F_SprSerialNo,F_RemMchSprResCode,F_BillType,F_RprApplyid'),Aparams);

      ReturnBool:=dmFrm.ExecStoredProc('SP_RemSprScrapWhInChk0',FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal('sEmpid'),Aparams ));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          ResultHint:=Parameters.Items[1].Value;
      end;
      if ResultHint<>'' then MessageDlg(#13#10+ResultHint,mtError,[mbOk],0);
      if Not ReturnBool then Abort;

    fbk:=dlAdoDataSet1.GetBookmark;
    FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

     try
        if dlAdoDataSet1.BookmarkValid(fbk)  then
        dlAdoDataSet1.GotoBookmark(fbk);
     except
     end



end;

procedure TanalyserFrm.ActRprApplyIDExecute(Sender: TObject);
begin
//TdmFrm.RepaireBillDetial(F_RprApplyid:string );
if self.dlAdoDataSet1.Active then
dmfrm.RepaireBillDetial( dlAdoDataSet1.FieldByName('F_RprApplyID').AsString );

end;

procedure TanalyserFrm.ActSvInstallExecute(Sender: TObject);
var FldName:string;
var F_BeginDate    ,F_EndDate,F_SvCenterCode,F_MchTypeCode,F_Flag,F_InstallWay :string;
Var params:string;
begin

      FldName:=self.DBGrid1.SelectedField.FieldName ;

      F_BeginDate:=self.dlAdoDataSet1.fieldbyname('F_BillTime').AsString+'-1'  ;
      F_EndDate:=datetostr( IncDay( incmonth( strtodate( dlAdoDataSet1.fieldbyname('F_BillTime').AsString+'-1')) ,-1));

      F_SvCenterCode:=dlAdoDataSet1.fieldbyname('F_ServeCntCode').AsString;
      F_MchTypeCode:=dlAdoDataSet1.fieldbyname('F_MchTypeCode').AsString;

      //F_Qty,F_FreeQty,F_CltSelfQty,F_FreeWaitCompQty,F_CltWaitCompQty,F_WaitGetQty,F_WaitAssignQty,F_BackQty,F_ChangeQty,F_AbolishQty



      if  FldName='F_FreeQty' then
      begin
           F_Flag:='完工';
           F_InstallWay:='1';
      end
      else//                  if  FldName='F_Qty' then
      begin
           F_Flag:='全部';
           F_InstallWay:='';
      end;

      if  FldName='F_CltSelfQty' then
      begin
           F_Flag:='完工';
           F_InstallWay:='2';
      end ;
      if  FldName='F_FreeWaitCompQty' then
      begin
           F_Flag:='待完工';
           F_InstallWay:='1';
      end ;
      if  FldName='F_CltWaitCompQty' then
      begin
           F_Flag:='待完工';
           F_InstallWay:='2';
      end ;
      if  FldName='F_WaitGetQty' then
      begin
              F_Flag:='待提取';
           F_InstallWay:='';
      end ;
      if  FldName='F_WaitAssignQty' then
      begin
              F_Flag:='待调配';
           F_InstallWay:='';
      end ;
      if  FldName='F_BackQty' then
      begin
              F_Flag:='退货';
           F_InstallWay:='';
      end ;
      if  FldName='F_ChangeQty' then
      begin
              F_Flag:='换货';
           F_InstallWay:='';
      end ;
      if  FldName='F_AbolishQty' then
      begin
              F_Flag:='做废';
           F_InstallWay:='';
      end  ;

 // F_BeginDate    ,F_EndDate,F_SvCenterCode,F_MchTypeCode,F_Flag,F_InstallWay :string;
    if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_BeginDate='+F_BeginDate+','   ;
        sDefaultVals:=sDefaultVals+'F_EndDate='+F_EndDate+','   ;
        sDefaultVals:=sDefaultVals+'F_SvCenterCode='+F_SvCenterCode+','   ;
        sDefaultVals:=sDefaultVals+'F_MchTypeCode='+F_MchTypeCode  +',' ;
        sDefaultVals:=sDefaultVals+'F_Flag='+F_Flag+','    ;
        sDefaultVals:=sDefaultVals+'F_InstallWay='+F_InstallWay    ;


         FhlUser.ShowAnalyserFrm('161',null);

    end;
end;

procedure TanalyserFrm.ActBrInstallExecute(Sender: TObject);
var FldName:string;
var F_BeginDate    ,F_EndDate,F_BranchCode,F_MchTypeCode,F_Flag,F_InstallWay ,F_SlCenterCode:string;

begin

      FldName:=self.DBGrid1.SelectedField.FieldName ;

      F_BeginDate:= dlAdoDataSet1.fieldbyname('F_BeginDate').AsString  ;
      F_EndDate:=   dlAdoDataSet1.fieldbyname('F_EndDate').AsString;
      F_BranchCode:=dlAdoDataSet1.fieldbyname('F_BranchCode').AsString;
      F_SlCenterCode:=dlAdoDataSet1.fieldbyname('F_SlCenterCode').AsString;
      F_MchTypeCode:=dlAdoDataSet1.fieldbyname('F_MchTypeCode').AsString;

      //F_Qty,F_FreeQty,F_CltSelfQty,F_FreeWaitCompQty,F_CltWaitCompQty,F_WaitGetQty,F_WaitAssignQty,F_BackQty,F_ChangeQty,F_AbolishQty

      if  FldName='F_FreeQty' then
      begin
           F_Flag:='完工';
           F_InstallWay:='1';
      end
      else  //       if  FldName='F_Qty' then
      begin
           F_Flag:='全部';
           F_InstallWay:='';
      end;
      if  FldName='F_CltSelfQty' then
      begin
           F_Flag:='完工';
           F_InstallWay:='2';
      end ;
      if  FldName='F_FreeWaitCompQty' then
      begin
           F_Flag:='待完工';
           F_InstallWay:='1';
      end ;
      if  FldName='F_CltWaitCompQty' then
      begin
           F_Flag:='待完工';
           F_InstallWay:='2';
      end ;
      if  FldName='F_WaitGetQty' then
      begin
              F_Flag:='待提取';
           F_InstallWay:='';
      end ;
      if  FldName='F_WaitAssignQty' then
      begin
              F_Flag:='待调配';
           F_InstallWay:='';
      end ;
      if  FldName='F_BackQty' then
      begin
              F_Flag:='退货';
           F_InstallWay:='';
      end ;
      if  FldName='F_ChangeQty' then
      begin
              F_Flag:='换货';
           F_InstallWay:='';
      end ;
      if  FldName='F_AbolishQty' then
      begin
              F_Flag:='做废';
           F_InstallWay:='';
      end;

 // F_BeginDate    ,F_EndDate,F_SvCenterCode,F_MchTypeCode,F_Flag,F_InstallWay :string;
    if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_BeginDate='+F_BeginDate+','   ;
        sDefaultVals:=sDefaultVals+'F_EndDate='+F_EndDate+','   ;
        sDefaultVals:=sDefaultVals+'F_BranchCode='+F_BranchCode+','   ;
        sDefaultVals:=sDefaultVals+'F_SalesCntCode='+F_SlCenterCode+','   ;

        sDefaultVals:=sDefaultVals+'F_MchTypeCode='+F_MchTypeCode  +',' ;
        sDefaultVals:=sDefaultVals+'F_Flag='+F_Flag+','    ;
        sDefaultVals:=sDefaultVals+'F_InstallWay='+F_InstallWay    ;


         FhlUser.ShowAnalyserFrm('161',null);

    end;
end;
procedure TanalyserFrm.ActRpFeeDLExecute(Sender: TObject);
var F_BeginDate    ,F_EndDate,F_BranchCode,F_MchTypeCode,F_Flag,F_InstallWay :string;

begin
    if dlAdoDataSet1.Active then
    begin
    
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_StartTime='+mtADODataSet1.fieldbyname('F_StartTime').AsString +','   ;
        sDefaultVals:=sDefaultVals+'F_EndTime='+mtADODataSet1.fieldbyname('F_EndTime').AsString +','   ;
        sDefaultVals:=sDefaultVals+'F_repairMan='+self.dlAdoDataSet1.fieldbyname('F_repairMan').AsString;
        {}

         FhlUser.ShowAnalyserFrm('163',null);

    end;
end;

procedure TanalyserFrm.ActRpItemExecute(Sender: TObject);
var FldName:string;
var F_BeginDate    ,F_EndDate,F_SvCenterCode,F_MchTypeCode,F_Flag,F_InstallWay :string;

begin

      FldName:=self.DBGrid1.SelectedField.FieldName ;

      F_BeginDate:=self.mtADODataSet1.fieldbyname('F_BeginDate').AsString  ;
      F_EndDate:=   mtADODataSet1.fieldbyname('F_EndDate').AsString;
      F_SvCenterCode:= dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString;

      //
//F_RepairApplySum ,F_RubbishQty ,F_BillQty,F_TelQty,F_WaitQty,F_AssignQty,F_SpQty,F_GetQty,
//F_CompleteQty,F_ChkQty,F_BalanceQty,F_DisQty

//全部,报修,电话解决,待上门,已调配,专用机申请,已提取,完工,审核,结算,作废,垃圾数据


      if  FldName='F_RubbishQty' then
      begin
           F_Flag:='垃圾数据';
      end;
      if  FldName='F_BillQty' then
      begin
           F_Flag:='报修';
      end ;
      if  FldName='F_TelQty' then
      begin
           F_Flag:='电话解决';
      end ;
      if  FldName='F_WaitQty' then
      begin
           F_Flag:='待上门';
      end ;
      if  FldName='F_AssignQty' then
      begin
              F_Flag:='待上门';
      end ;
      if  FldName='F_SpQty' then
      begin
              F_Flag:='专用机申请';
      end ;
      if  FldName='F_GetQty' then
      begin
              F_Flag:='已提取';
      end ;
      if  FldName='F_CompleteQty' then
      begin
              F_Flag:='完工';
      end ;
      if  FldName='F_ChkQty' then
      begin
              F_Flag:='审核';
      end ;

      if  FldName='F_BalanceQty' then
      begin
              F_Flag:='结算';
      end ;
      if  FldName='F_DisQty' then
      begin
              F_Flag:='作废';
      end;
      if FldName='F_RepairApplySum' then
      begin
           F_Flag:='全部';
      end;
 // F_BeginDate    ,F_EndDate,F_SvCenterCode,F_MchTypeCode,F_Flag,F_InstallWay :string;
    if dlAdoDataSet1.Active then
    begin

        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_BeginDate='+F_BeginDate+','   ;
        sDefaultVals:=sDefaultVals+'F_EndDate='+F_EndDate+','   ;
        sDefaultVals:=sDefaultVals+'F_SvCenterCode='+F_SvCenterCode+','   ;
        sDefaultVals:=sDefaultVals+'F_Flag='+F_Flag   ;


         FhlUser.ShowAnalyserFrm('117',null);

    end;
end;

procedure TanalyserFrm.ActInnerCavityQcExecute(Sender: TObject);
var
frmid:string;
fBillType:string;
BillFrm:TBillFrm;
EditorFrm:TEditorFrm ;
Code:string;

i,Sum:integer;


begin



end;

procedure TanalyserFrm.Action2Execute(Sender: TObject);
begin
        if dlAdoDataSet1.Active then
    begin

        sDefaultVals:='';
        //F_MchReturnID,F_SpareName
        sDefaultVals:=sDefaultVals+'F_MchReturnID='+dlAdoDataSet1.fieldbyname('F_MchReturnID').AsString   ;


         FhlUser.ShowAnalyserFrm('197',null);

    end;
end;

procedure TanalyserFrm.ActSaleAfterOrderExecute(Sender: TObject);
begin
        if dlAdoDataSet1.Active then
    begin

        sDefaultVals:='';
        //F_MchReturnID,F_SpareName

        sDefaultVals:=sDefaultVals+'F_WHCOde='+dlAdoDataSet1.fieldbyname('F_WHCOde').AsString  ;
        sDefaultVals:=sDefaultVals+',F_BeginDate='+self.mtADODataSet1.fieldbyname('F_BeginDate').AsString  ;//'售后还机' ;        //

        sDefaultVals:=sDefaultVals+',F_EndDate='+mtADODataSet1 .fieldbyname('F_EndDate').AsString   ;//'售后还机' ;        //
        sDefaultVals:=sDefaultVals+',fliters='+'售后还机' ;


         FhlUser.ShowAnalyserFrm('132',null);

    end;

end;

procedure TanalyserFrm.ActUnSerialNoQcExecute(Sender: TObject);
var
frmid:string;
Code:string;
begin

  end;



procedure TanalyserFrm.ActCreateSerialNoExecute(Sender: TObject);
var FrmBillEx:TFrmBillEx;
var code :string;
begin
FrmBillEx:=TFrmBillEx.Create(nil);
       FrmBillEx.InitFrm('1022');//create serialNo bill

       code :=  dlAdoDataSet1.fieldbyname('Code').AsString ;
       if code<>'' then
       FrmBillEx.OpenBill( code  );
       FrmBillEx.FormStyle :=fsnormal;
       FrmBillEx.Hide;
     //  FrmBillEx.AutoSize:=true;
      FrmBillEx.Position :=poDesktopCenter;
       FrmBillEx.ScrollBtm.Visible :=true;
       FrmBillEx.SetParamDataset(self.dlAdoDataSet1 );

       FrmBillEx.ShowModal ;
end;

procedure TanalyserFrm.ActSprInOutExecute(Sender: TObject);
var FrmBillEx:TFrmBillEx;
var code :string;
begin
FrmBillEx:=TFrmBillEx.Create(nil);
       FrmBillEx.InitFrm('1021');//create serialNo bill

       code :=  dlAdoDataSet1.fieldbyname('F_WhSPrInID').AsString ;
       if code<>'' then
       FrmBillEx.OpenBill( code  );
       FrmBillEx.FormStyle :=fsnormal;
       FrmBillEx.Hide;
     //  FrmBillEx.AutoSize:=true;
      FrmBillEx.Position :=poDesktopCenter;
       FrmBillEx.ScrollBtm.Visible :=true;
       FrmBillEx.SetParamDataset(self.dlAdoDataSet1 );

       FrmBillEx.ShowModal ;
end;

procedure TanalyserFrm.ActUserPrintPrtExecute(Sender: TObject);
var UserQkRpt1 :TUserQkRpt;
var
  bk:TBookmark;
begin

  Screen.Cursor:=crSqlWait;
  bk:=dlAdoDataSet1.GetBookmark;
  dlAdoDataSet1.DisableControls;
  UserQkRpt1:=TUserQkRpt.Create(Application);
  try
    UserQkRpt1.SetBillRep(fDict.TopBoxId,fDict.BtmBoxId,mtADODataSet1,DbGrid1,fDict.Caption );
    UserQkRpt1.PreviewModal;//Preview;
  finally
    FreeAndNil(UserQkRpt1);
    dlAdoDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  dlAdoDataSet1.GotoBookmark(bk);
end;


procedure TanalyserFrm.ActNewOriBillExecute(Sender: TObject);
var
frmid:string;
fBillType:string;
BillFrm:TBillFrm;
EditorFrm:TEditorFrm ;
Code:string;
FrmBillEx:TFrmBillEx ;
begin

  if dlAdoDataSet1.FindField('frmid')=nil then   exit;
  if dlAdoDataSet1.fieldbyname('frmid').Value =null then exit;
  frmid:=dlAdoDataSet1.fieldbyname('frmid').Value ;


 
FrmBillEx:=TFrmBillEx.Create(nil);
       FrmBillEx.InitFrm(frmid);//create serialNo bill

       code :=  dlAdoDataSet1.fieldbyname('Code').AsString ;
       if code<>'' then
       FrmBillEx.OpenBill( code  );
       FrmBillEx.FormStyle :=fsnormal;
       FrmBillEx.Hide;
     //  FrmBillEx.AutoSize:=true;
      FrmBillEx.Position :=poDesktopCenter;
       FrmBillEx.ScrollBtm.Visible :=true;
       FrmBillEx.SetParamDataset(self.dlAdoDataSet1 );

       FrmBillEx.ShowModal ;

end;

procedure TanalyserFrm.ActComplainDLExecute(Sender: TObject);
begin

      if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_SvCenterCode='+dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString  ;
        sDefaultVals:=sDefaultVals+',F_CompType='+dlAdoDataSet1.fieldbyname('F_ComplainCode').AsString  ;
         FhlUser.ShowAnalyserFrm('200',null);

    end;

end;

procedure TanalyserFrm.ActCltRetVisiteDLExecute(Sender: TObject);
begin
      if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_SvCenterCode='+dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString  ;

        FhlUser.ShowAnalyserFrm('216',null);

    end;

end;

procedure TanalyserFrm.ActCltCriticalDLExecute(Sender: TObject);
begin

      if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_EmpName='+dlAdoDataSet1.fieldbyname('F_EmpName').AsString  ;
        FhlUser.ShowAnalyserFrm('214',null);

    end;

end;

procedure TanalyserFrm.ActRemMachDLExecute(Sender: TObject);
var FldName:string;
var F_BeginDate    ,F_EndDate, F_MchTypeCode,F_Flag,F_InstallWay ,F_SvCenterCode:string;

begin

      FldName:=self.DBGrid1.SelectedField.FieldName ;
 
      F_BeginDate:= mtADODataSet1.fieldbyname('F_BeginDate').AsString  ;
      F_EndDate:=   mtADODataSet1.fieldbyname('F_EndDate').AsString;
      F_SvCenterCode:=dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString;
      F_MchTypeCode:=dlAdoDataSet1.fieldbyname('F_MchTypeCode').AsString;



//F_SvCenterName,F_Qty,F_ApplyQty,F_ApproveQty,F_WuLiuQty,F_WareHouseQty,F_SellQty,F_DealQty,F_ChaiJiQty,F_QCQty,F_JieSuanlQty,F_HeSuanQty
       F_Flag:='';
      if  FldName='F_ApplyQty' then
      begin
           F_Flag:='0';
      end else if   FldName='F_ApproveQty' then
      begin
           F_Flag:='20';

      end else if   FldName='F_WuLiuQty' then
      begin
           F_Flag:='30';

      end else if   FldName='F_WareHouseQty' then
      begin
         F_Flag:='40';
      end else if   FldName='F_SellQty' then
      begin
              F_Flag:='50';
      end else if   FldName='F_DealQty' then
      begin
              F_Flag:='60';
      end else if FldName='F_ChaiJiQty' then
      begin
              F_Flag:='70';
      end else if   FldName='F_JieSuanlQty' then
      begin
            F_Flag:='80';
      end else if   FldName='F_HeSuanQty' then
      begin
            F_Flag:='90';
      end;


 // F_BeginDate    ,F_EndDate,F_SvCenterCode,F_MchTypeCode,F_Flag,F_InstallWay :string;
    if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_BeginDate='+F_BeginDate+','   ;
        sDefaultVals:=sDefaultVals+'F_EndDate='+F_EndDate+','   ;

        sDefaultVals:=sDefaultVals+'F_SvCenterCode='+F_SvCenterCode+','   ;
        sDefaultVals:=sDefaultVals+'F_MchTypeCode='+F_MchTypeCode  +',' ;
        sDefaultVals:=sDefaultVals+'F_Flag='+F_Flag+','    ;

         FhlUser.ShowAnalyserFrm('208',null);

    end;
end;

procedure TanalyserFrm.ActRemSprDLExecute(Sender: TObject);
var FldName:string;
var F_BeginDate    ,F_EndDate, F_SpareName,F_Flag,F_InstallWay ,F_SvCenterCode:string;

begin

      FldName:=self.DBGrid1.SelectedField.FieldName ;
 
      F_BeginDate:= mtADODataSet1.fieldbyname('F_BeginDate').AsString  ;
      F_EndDate:=   mtADODataSet1.fieldbyname('F_EndDate').AsString;
      F_SvCenterCode:=dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString;
      F_SpareName:=dlAdoDataSet1.fieldbyname('F_SpareName').AsString;



//F_SvCenterName,F_Qty,F_ApplyQty,F_ApproveQty,F_WuLiuQty,F_WareHouseQty,F_SellQty,F_DealQty,F_ChaiJiQty,F_QCQty,F_JieSuanlQty,F_HeSuanQty
       F_Flag:='';
      if  FldName='F_ApplyQty' then
      begin
           F_Flag:='0';
      end else if   FldName='F_ApproveQty' then
      begin
           F_Flag:='20';

      end else if   FldName='F_WuLiuQty' then
      begin
           F_Flag:='30';

      end else if   FldName='F_WareHouseQty' then
      begin
         F_Flag:='40';
      end else if   FldName='F_SellQty' then
      begin
              F_Flag:='50';
      end else if   FldName='F_DealQty' then
      begin
              F_Flag:='60';
      end else if FldName='F_ChaiJiQty' then
      begin
              F_Flag:='70';
      end else if   FldName='F_JieSuanlQty' then
      begin
            F_Flag:='80';
      end else if   FldName='F_HeSuanQty' then
      begin
            F_Flag:='90';
      end;


 // F_BeginDate    ,F_EndDate,F_SvCenterCode,F_MchTypeCode,F_Flag,F_InstallWay :string;
    if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_BeginDate='+F_BeginDate+','   ;
        sDefaultVals:=sDefaultVals+'F_EndDate='+F_EndDate+','   ;

        sDefaultVals:=sDefaultVals+'F_SvCenterCode='+F_SvCenterCode+','   ;
        sDefaultVals:=sDefaultVals+'F_SpareCode='+F_SpareName  +',' ;
        sDefaultVals:=sDefaultVals+'F_Flag='+F_Flag+','    ;

         FhlUser.ShowAnalyserFrm('210',null);

    end;
end;

procedure TanalyserFrm.ActRtnSvCntDLExecute(Sender: TObject);
begin

 if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_BeginDate='+self.mtADODataSet1.fieldbyname('F_BeginDate').AsString   +','   ;
        sDefaultVals:=sDefaultVals+'F_EndDate=' +self.mtADODataSet1.fieldbyname('F_EndDate').AsString   +','   ;
        sDefaultVals:=sDefaultVals+'F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString   +','   ;
        sDefaultVals:=sDefaultVals+'F_WhCode='+self.dlAdoDataSet1.fieldbyname('F_oriWhCode').AsString   +','   ;

         FhlUser.ShowAnalyserFrm('202',null);
     end;
end;

procedure TanalyserFrm.ActSLAftReplaceExecute(Sender: TObject);
begin
           if dlAdoDataSet1.Active then
    begin
        sDefaultVals:='';
        sDefaultVals:=sDefaultVals+'F_BeginDate='+self.mtADODataSet1.fieldbyname('F_BeginDate').AsString   +','   ;
        sDefaultVals:=sDefaultVals+'F_EndDate=' +self.mtADODataSet1.fieldbyname('F_EndDate').AsString   +','   ;
        sDefaultVals:=sDefaultVals+'F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_ServeCntCode').AsString   +','   ;
        sDefaultVals:=sDefaultVals+'F_WhCode='+self.dlAdoDataSet1.fieldbyname('F_BeReplaceWh').AsString   +','   ;

         FhlUser.ShowAnalyserFrm('204',null);
     end;
end;

procedure TanalyserFrm.ActChkMtExecute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.DoExecProc(dlAdoDataSet1,null);
  fbk:=dlAdoDataSet1.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  try
   dlAdoDataSet1.GotoBookmark(fbk);
   except

   end;
end;


procedure TanalyserFrm.ActInstallFeeUnChkExecute(Sender: TObject);
var
  fDict:TExcPrcDict;    Aparams:Variant;  AUsrDataSet:TDataSet;
var TestStr,AProcId:String;
begin                              //安装费弃审
    AProcId:='1517';

  AUsrDataSet:=self.dlAdoDataSet1 ;

  FhlKnl1.Cf_GetDict_ExcPrc(AProcId,fDict);
  if fDict.ProcName<>'' then
  begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(AUsrDataSet,fDict.UsrParams),Aparams);
     
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.SysParams),Aparams));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool then Abort
      else
      FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  end;
end;

procedure TanalyserFrm.ActSLAftUnchkExecute(Sender: TObject);
var
  fDict:TExcPrcDict;    Aparams:Variant;  AUsrDataSet:TDataSet;
var TestStr,AProcId:String;
begin                              //安装费 ,维修费 ，保内配件 ，残机   售后 弃审
    AProcId:='1514';

  AUsrDataSet:=self.dlAdoDataSet1 ;

  FhlKnl1.Cf_GetDict_ExcPrc(AProcId,fDict);
  if fDict.ProcName<>'' then
  begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(AUsrDataSet,fDict.UsrParams),Aparams);
     
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.SysParams),Aparams));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool then Abort
      else
      FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  end;
end;

procedure TanalyserFrm.ActFnUnChkExecute(Sender: TObject);
var
  fDict:TExcPrcDict;    Aparams:Variant;  AUsrDataSet:TDataSet;
var TestStr,AProcId:String;
begin                              //安装费 ,维修费 ，保内配件 ，残机  弃审     财务 弃审
    AProcId:='1526';

  AUsrDataSet:=self.dlAdoDataSet1 ;

  FhlKnl1.Cf_GetDict_ExcPrc(AProcId,fDict);
  if fDict.ProcName<>'' then
  begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(AUsrDataSet,fDict.UsrParams),Aparams);
     
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.SysParams),Aparams));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool then Abort
      else
      FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  end;
end;
//   1519
procedure TanalyserFrm.ActRpFeeUnChkExecute(Sender: TObject);
var
  fDict:TExcPrcDict;    Aparams:Variant;  AUsrDataSet:TDataSet;
var TestStr,AProcId:String;
begin                              //安装费 ,维修费 ，保内配件 ，残机  弃审
    AProcId:='1519';

  AUsrDataSet:=self.dlAdoDataSet1 ;

  FhlKnl1.Cf_GetDict_ExcPrc(AProcId,fDict);
  if fDict.ProcName<>'' then
  begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(AUsrDataSet,fDict.UsrParams),Aparams);
     
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.SysParams),Aparams));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool then Abort
      else
      FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  end;
end;
     // 1521
procedure TanalyserFrm.ActSprReturnUnchkExecute(Sender: TObject);
var
  fDict:TExcPrcDict;    Aparams:Variant;  AUsrDataSet:TDataSet;
var TestStr,AProcId:String;
begin                              //安装费 ,维修费 ，保内配件 ，残机  弃审
    AProcId:='1521';

  AUsrDataSet:=self.dlAdoDataSet1 ;

  FhlKnl1.Cf_GetDict_ExcPrc(AProcId,fDict);
  if fDict.ProcName<>'' then
  begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(AUsrDataSet,fDict.UsrParams),Aparams);
     
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.SysParams),Aparams));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool then Abort
      else
      FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  end;
end;

procedure TanalyserFrm.ActRemMchReturnUnchkExecute(Sender: TObject);
var
  fDict:TExcPrcDict;    Aparams:Variant;  AUsrDataSet:TDataSet;
var TestStr,AProcId:String;
begin                              //安装费 ,维修费 ，保内配件 ，残机  弃审
    AProcId:='1523';

  AUsrDataSet:=self.dlAdoDataSet1 ;

  FhlKnl1.Cf_GetDict_ExcPrc(AProcId,fDict);
  if fDict.ProcName<>'' then
  begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(AUsrDataSet,fDict.UsrParams),Aparams);
     
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.SysParams),Aparams));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool then Abort
      else
      FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  end;
end;

procedure TanalyserFrm.actOriDataExecute(Sender: TObject);
var
frmid,F_Paytype:string;
fBillType:string;

EditorFrm:TEditorFrm ;
Code:string;
FrmBillEx:TFrmBillEx ;

      F_SvCenterCode:string;
     F_BalanceStdate,F_BalanceEdDate:tdatetime;
begin

if self.dlAdoDataSet1.IsEmpty then exit;

  F_Paytype:=  self.dlAdoDataSet1.fieldbyname('F_Paytype').AsString ;


  F_BalanceStdate:= self.dlAdoDataSet1.fieldbyname('F_BalanceStdate').AsDateTime  ;
  F_BalanceEdDate:= self.dlAdoDataSet1.fieldbyname('F_BalanceEdDate').AsDateTime  ;
  F_SvCenterCode:= self.dlAdoDataSet1.fieldbyname('F_PayerSvCode').AsString ;



  if F_Paytype='20' then
  begin
           frmid:=  '221';
           fBillType:=  'AnA';
           sDefaultVals:='F_SvCenterCode='+F_SvCenterCode+',StartYear='+inttostr(YearOf(F_BalanceStdate))+',StartMonth=' +inttostr(monthof(F_BalanceStdate))+',=EndYear='+inttostr(YearOf(F_BalanceEdDate))+',=EndMonth' +inttostr(monthof(F_BalanceEdDate));
  end else if   F_Paytype='30' then
  begin
          frmid:=   '222';
           fBillType:=  'AnA';
           sDefaultVals:='F_SvCenterCode='+F_SvCenterCode+',StartYear='+inttostr(YearOf(F_BalanceStdate))+',StartMonth=' +inttostr(monthof(F_BalanceStdate))+',=EndYear='+inttostr(YearOf(F_BalanceEdDate))+',=EndMonth' +inttostr(monthof(F_BalanceEdDate));
  end else if    F_Paytype='41' then
  begin
          Code:=  self.dlAdoDataSet1.fieldbyname('F_SourceBillCode').AsString ;
          frmid:=    '1020'; 
           fBillType:=  'BillEx';
  end else if      F_Paytype='50' then
  begin
           Code:=  self.dlAdoDataSet1.fieldbyname('F_SourceBillCode').AsString ;
           frmid:=    '1019';
           fBillType:=  'BillEx';
  end else  exit;




  if uppercase(fBillType)=uppercase('AnA') then
  begin

      FhlUser.ShowAnalyserFrm(frmid,null);
  end;


  if uppercase(fBillType)=uppercase('BillEx') then
  begin
      if Code<>'' then
      begin
       FrmBillEx:=TFrmBillEx.Create(nil);
       FrmBillEx.InitFrm(FrmId);
       FrmBillEx.OpenBill( code  );
       FrmBillEx.FormStyle :=fsnormal;
       FrmBillEx.Hide;
     //  FrmBillEx.AutoSize:=true;
      FrmBillEx.Position :=poDesktopCenter;
       FrmBillEx.ScrollBtm.Visible :=true;
       FrmBillEx.SetParamDataset(self.dlAdoDataSet1 );

       FrmBillEx.ShowModal ;


      end;

  end;

end;
procedure TanalyserFrm.Action3Execute(Sender: TObject);
var F_SvCenterCode:string;
begin

       F_SvCenterCode:= self.dlAdoDataSet1.fieldbyname('F_PayerSvCode').AsString ;
           sDefaultVals:='F_SvCenterCode='+F_SvCenterCode;
       FhlUser.ShowAnalyserFrm('225',null);
end;

procedure TanalyserFrm.ActInstallBalanceExecute(Sender: TObject);
var
  fbk:TBookmark;
begin
   fbk:=dlAdoDataSet1.GetBookmark;
  FhlUser.DoExecProc(dlAdoDataSet1,null);
 
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  try
   dlAdoDataSet1.GotoBookmark(fbk);
   except

   end;
end;
procedure TanalyserFrm.ActRpFeeBalanceExecute(Sender: TObject);
var
  fbk:TBookmark;
begin
   fbk:=dlAdoDataSet1.GetBookmark;
  FhlUser.DoExecProc(dlAdoDataSet1,null);
 
  FhlKnl1.Ds_RefreshDataSet(dlAdoDataSet1);

  try
   dlAdoDataSet1.GotoBookmark(fbk);
   except

   end;
end;
procedure TanalyserFrm.ActInsOrRpBillExecute(Sender: TObject);
begin
//   zxh 08.01.07   短信界面的安装OR维修 原单
if (dlAdoDataSet1.Active ) and ( not dlAdoDataSet1.IsEmpty ) then
  begin
      if      dlAdoDataSet1.FieldByName('F_Code').AsString='Ins'  then
            dmfrm.InstallBillDetial(self.dlAdoDataSet1.fieldbyname('F_BillCode').AsString )

      else if dlAdoDataSet1.FieldByName('F_Code').AsString='Rp'   then
             dmfrm.RepaireBillDetial( dlAdoDataSet1.FieldByName('F_BillCode').AsString );

  end;

end;

procedure TanalyserFrm.ActInsDetailExecute(Sender: TObject);
begin     //zxh 08.01.10
if dlAdoDataSet1.Active then
  begin
      sDefaultVals:='';
      sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString +','   ;
      sDefaultVals:=sDefaultVals+'F_Flag=7'+','   ;    
      sDefaultVals:=sDefaultVals+'startTime='+self.dlAdoDataSet1.fieldbyname('F_BeginDate').AsString +','    ;
      sDefaultVals:=sDefaultVals+'Endtime='+self.dlAdoDataSet1.fieldbyname('F_EndDate').AsString  ;

      FhlUser.ShowAnalyserFrm('135',null);
  end;
end;
procedure TanalyserFrm.ActRepairDetailExecute(Sender: TObject);
begin  //zxh 08.01.10 162
if dlAdoDataSet1.Active then
  begin
      sDefaultVals:='';
      sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString +','   ;
      sDefaultVals:=sDefaultVals+'F_StartTime='+self.dlAdoDataSet1.fieldbyname('F_BeginDate').AsString +','    ;
      sDefaultVals:=sDefaultVals+'F_EndTime='+self.dlAdoDataSet1.fieldbyname('F_EndDate').AsString  ;

      FhlUser.ShowAnalyserFrm('162',null);
  end;
end;

procedure TanalyserFrm.ActBillExInputExecute(Sender: TObject);
var
frmid:string;
fBillType:string;
BillFrm:TBillFrm;
EditorFrm:TEditorFrm ;
Code:string;
FrmBillEx:TFrmBillEx ;
begin



FrmBillEx:=TFrmBillEx.Create(nil);
       FrmBillEx.InitFrm('1025');//create serialNo bill

       code :=  dlAdoDataSet1.fieldbyname('Code').AsString ;
       if code<>'' then
       FrmBillEx.OpenBill( code  );
       FrmBillEx.FormStyle :=fsnormal;
       FrmBillEx.Hide;
     //  FrmBillEx.AutoSize:=true;
      FrmBillEx.Position :=poDesktopCenter;
       FrmBillEx.ScrollBtm.Visible :=true;
       FrmBillEx.SetParamDataset(self.dlAdoDataSet1 );

       FrmBillEx.ShowModal ;

end;

procedure TanalyserFrm.ActSerialDetailExecute(Sender: TObject);
begin  //zxh 08.01.17
if dlAdoDataSet1.Active and
  (dlAdoDataSet1.FieldByName('F_MchApplyID').AsString<>'') and
  (dlAdoDataSet1.FieldByName('F_IsUseQty').AsInteger>0) then
  begin
      sDefaultVals:='';
      sDefaultVals:='F_MchApplyID='+self.dlAdoDataSet1.fieldbyname('F_MchApplyID').AsString    ;
      FhlUser.ShowAnalyserFrm('228',null);
  end;
end;

procedure TanalyserFrm.ActVisitDetailExecute(Sender: TObject);
begin   //zxh 08.2.28
 if dlAdoDataSet1.IsEmpty=false then
    begin
      sDefaultVals:='';
      sDefaultVals:='F_SvCenterCode='+self.dlAdoDataSet1.fieldbyname('F_SvCenterCode').AsString+',';
      sDefaultVals:=sDefaultVals+'F_Flag='+self.dlAdoDataSet1.fieldbyname('F_Type').AsString+',';
      sDefaultVals:=sDefaultVals+'F_begindate='+self.mtADODataSet1.fieldbyname('F_begindate').AsString+',';
      sDefaultVals:=sDefaultVals+'F_EndDate='+self.mtADODataSet1.fieldbyname('F_EndDate').AsString;
      FhlUser.ShowAnalyserFrm('231',null);
    end;
end;

procedure TanalyserFrm.ActInstBillExecute(Sender: TObject);
var FldName:string;
begin // zxh 08.2.29
 if  dlAdoDataSet1.IsEmpty then exit;
 
 FldName:=self.DBGrid1.SelectedField.FieldName ;
// if (FldName<>'F_InstallID') and (FldName<>'F_OldInstallID')  then exit;
 
 if dlAdoDataSet1.fieldbyname('F_InstallID').AsString<>'' then
    begin
      if FldName<>'F_OldInstallID' then
          dmfrm.InstallBillDetial(self.dlAdoDataSet1.fieldbyname('F_InstallID').AsString )
      else
        begin
         if dlAdoDataSet1.fieldbyname('F_OldInstallID').AsString<>'' then
          dmfrm.InstallBillDetial(self.dlAdoDataSet1.fieldbyname('F_OldInstallID').AsString );
        end;
    end;
end;

end.
