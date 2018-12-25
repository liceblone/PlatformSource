unit UnitLookUpImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, DBGrids, StdCtrls, ToolWin, DB,DBCtrls, ADODB, ActnList,FhlKnl,UPublicCtrl,  UPublicFunction,Menus,
  Buttons,UnitGrid, ExtCtrls;

type
  TFrmLoopUpImPortEx = class(TForm)
    ScrollTop: TScrollBox;
    TreeView1: TTreeView;
    ActionList1: TActionList;
    mtDataSource1: TDataSource;
    mtDataSet1: TADODataSet;
    DlDataSource1: TDataSource;
    dlDataSet1: TADODataSet;
    TreeDataSet: TADODataSet;
    OpnDlDsBtn1: TSpeedButton;
    ActClose: TAction;
    ActFreeDeliveFee: TAction;
    ActPick: TAction;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    lblTitle: TLabel;
    pnlGd: TPanel;
    actPickALL: TAction;
    tmrQry: TTimer;
    RefreshAction1: TAction;
    procedure ScrollTopDblClick(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure DBGridDLDblClick(Sender: TObject);
    procedure OpnDlDsBtn1Click(Sender: TObject);

   procedure DBGrid1DrawColumnCellFntClr(Sender: TObject;
     const Rect: TRect; DataCol: Integer; Column: TColumn;
     State: TGridDrawState);
    procedure ActPickExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPickALLExecute(Sender: TObject);
    procedure tmrQryTimer(Sender: TObject);
    procedure RefreshAction1Execute(Sender: TObject);
    procedure lblTitleClick(Sender: TObject);
  private
    { Private declarations }
    fDict: TLkpImportDict    ;
    GrpBox:TGrpSelRecord  ;//过滤条件
    GrpQueryRecord:TGrpQueryRecord;//查询
    DBGridDL:TModelDbGrid ;
    FImportToDataSet: TdataSet;
    MainPramDataSet : TdataSet;
    SecondCnt       : integer;
    procedure  IniQuickQuery(Pdbgird: Tdbgrid);
    procedure  IniShortCutFilter(Pdbgird: Tdbgrid);
    procedure  OnEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    procedure iniFrm(FrmId:string ;OpenPrams:string ='';DLPramDataSet:TdataSet=nil;PMainPramDataSet:TdataSet=nil);
    procedure getFocuse;
    { Public declarations }
  end;

var
  FrmLoopUpImPortEx: TFrmLoopUpImPortEx;

implementation
       uses datamodule,UnitCreateComponent;
{$R *.dfm}

{ TFrmLoopUpImPortEx }

procedure TFrmLoopUpImPortEx.iniFrm(FrmId: string;OpenPrams:string ='';DLPramDataSet:TdataSet=nil;PMainPramDataSet:TdataSet=nil);
var fParams:variant;
var i:integer ;
var  DbGridPopupMenu  :TPopupMenu;
begin
     if not     fhlknl1.Cf_GetDict_LkpImport(FrmId,fDict) then exit;
       self.lblTitle.Caption :=  fDict.caption ;
     self.Caption :=   fDict.caption ;

      FhlUser.SetDataSet(mtDataSet1,fDict.mtdatasetid,Null);
      if mtDataSet1.Active   then
      begin
          FhlUser.AssignDefault(mtDataSet1);
          if    mtDataSet1.IsEmpty then
          mtDataSet1.Append;
      end;

      if (fDict.ToolBtnsID  <>'-1') and (fDict.ToolBtnsID  <>'') then
        FhlKnl1.Tb_CreateActionBtns_ex(self.ToolBar1,self.ActionList1,fDict.ToolBtnsID )
      else
        CoolBar1.Visible :=false;


      if   (fDict.Boxid <>'-1') and (fDict.Boxid <>'') then
         FhlKnl1.Cf_SetBox( fDict.Boxid ,MtDataSource1,ScrollTop ,dmFrm.UserDbCtrlActLst)
      else
         self.ScrollTop.Visible :=false;
      

      FImportToDataSet:=DLPramDataSet;
      // fParams:=FhlKnl1.Ds_GetFieldsValue(DLPramDataSet,fDict.IniPramFields );


      MainPramDataSet:=PMainPramDataSet;
      //    fParams:=FhlKnl1.Ds_GetFieldsValue(MainPramDataSet,fDict.IniPramFields );
       

     // fparams:=   FhlKnl1.Vr_MergeVarArray(     OpenPrams,     fParams    );
      
      FhlUser.SetDbGridAndDataSet(self.DBGridDL  ,fDict.GridID ,fParams,false);

      if  fDict.TreeID <>-1 then
        self.TreeView1.Visible :=true
      else
        self.TreeView1.Visible :=false;


     if fDict.UseDefaultFilter  then
     IniShortCutFilter(self.DBGridDL  );
     if fDict.UseDefaultqry      then
     IniQuickQuery(self.DBGridDL  );


     if fDict.DblClick>-1 then
     self.DBGridDL.OnDblClick :=self.ActionList1.Actions [fDict.DblClick].OnExecute    ;


       for i:=0 to self.DBGridDL.Columns.Count -1 do
      begin
          if uppercase(self.DBGridDL.Columns[i].FieldName) = uppercase( 'FntClr' )then
          begin
               DBGridDL.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
               break;
          end;
      end;

      for i:=0 to self.ScrollTop.ControlCount -1 do
      begin
             if  ScrollTop.Controls[i] is Tdbedit     then (ScrollTop.Controls[i] as Tdbedit).OnKeyUp  :=OnEditorKeyUp;
          //   if (ScrollTop.Controls[i] is TdbCombobox)    then
          //   if (ScrollTop.Controls[i] is TDBLookupComboBox)    then

      end;
      DbGridPopupMenu  :=TPopupMenu.create(self);
      fhluser.MergeGridUserMenuAndSysCongfigMenu(DbGridPopupMenu , dmfrm.DbGridPopupMenu1 ,-1,self.ActionList1 ) ;

      if fDict.IsOpen then
      begin
         OpnDlDsBtn1Click(nil);
      end;

end;
 
procedure TFrmLoopUpImPortEx.IniQuickQuery(Pdbgird: Tdbgrid);
begin
    GrpQueryRecord:=TGrpQueryRecord.create(self);
    GrpQueryRecord.Parent :=ScrollTop;
    GrpQueryRecord.Height :=GrpQueryRecord.Parent.Height -2  ;
    GrpQueryRecord.Left :=20;
    if GrpBox<>nil then
    begin
        GrpQueryRecord.Width :=  GrpQueryRecord.Parent.Width -self.GrpBox.Width;
        self.GrpBox.Left := GrpQueryRecord.width ;
        GrpBox.Height :=  GrpQueryRecord.Height ;
    end
    else
        GrpQueryRecord.Width :=  GrpQueryRecord.Parent.Width +30 ;

    GrpQueryRecord.Align :=alleft;

    GrpQueryRecord.IniQuickQuery(Pdbgird) ;
    self.Width := GrpQueryRecord.Width +100;
end;
procedure TFrmLoopUpImPortEx.IniShortCutFilter(Pdbgird: Tdbgrid);
begin
    GrpBox:=TGrpSelRecord.create(self);
    GrpBox.Parent :=self.ScrollTop;
    GrpBox.Height :=GrpBox.Parent.Height -2 ;
    GrpBox.IniGrpBox(Pdbgird)    ;

end;
procedure TFrmLoopUpImPortEx.ScrollTopDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);

      if messagedlg('mtDataSet1?',   mtConfirmation ,[mbyes,mbno],0)=mryes then
      begin
         CrtCom.mtDataSetId :=inttostr(self.mtDataSet1.tag) ;
         CrtCom.mtDataSet1 :=  mtDataSet1 ;
         CrtCom.TopOrBtm :=true;
         CrtCom.TOPBoxId  := (self.fDict.Boxid );
      end
      else
      begin
         CrtCom.mtDataSetId :=inttostr(self.dlDataSet1.tag);
         CrtCom.mtDataSet1 :=self.dlDataSet1 ;
         CrtCom.TOPBoxId  := (self.fDict.Boxid );
      end;

        CrtCom.DLGrid :=self.DBGridDL  ;
        CrtCom.DlGridId :=inttostr(self.DBGridDL.tag) ;
  

try
    CrtCom.Show;
finally

end; end;
end;

procedure TFrmLoopUpImPortEx.ActCloseExecute(Sender: TObject);
begin

self.Close;
 self.ModalResult :=mrok;
end;

procedure TFrmLoopUpImPortEx.DBGridDLDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
//    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.dlDataSet1  ;
    CrtCom.mtDataSetId :=inttostr(self.dlDataSet1.tag) ;

   CrtCom.DLGrid :=self.DBGridDL  ;
   CrtCom.DlGridId :=inttostr(self.DBGridDL.Tag) ;

try
    CrtCom.Show;
finally

end;
end;    { }
end;

procedure TFrmLoopUpImPortEx.OpnDlDsBtn1Click(Sender: TObject);
var fParams:variant;
var  strparm:string;
var  abortstr,WarningStr:string;
begin
    if not mtDataSet1.Active then exit;

    with mtDataSet1 do
    begin
        if (State=dsInsert) or (State=dsEdit) then  //update parameter getvalue
        begin
          UpdateRecord;
         // Post;
        end;
    end;
    fParams:=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fDict.OpenProcFlds,true );
    if MainPramDataSet<>nil then
    begin
          if fDict.IniPramFields<>'' then
          fParams:=  FhlKnl1.Vr_MergeVarArray( fParams ,FhlKnl1.Ds_GetFieldsValue(MainPramDataSet,fDict.IniPramFields ,true));
    end; 
    if Not VarIsNull(fParams) then
    begin
         FhlKnl1.Ds_OpenDataSet(dlDataSet1,fParams);
         FhlKnl1.SetColFormat(self.DBGridDL  );
    end;

 {  if assigned(  dlDataSet1.FindField('fntclr')) then
      DbGrid1.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
      }

end;
procedure TFrmLoopUpImPortEx.DBGrid1DrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DBGridDL.DataSource.DataSet.IsEmpty then exit;

  if   dlDataSet1.FindField('FntClr') <>nil then
  begin
      DBGridDL.Canvas.Font.Color:=StringToColor(dlDataSet1.FieldByName('FntClr').AsString);
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,DBGridDL.Canvas.Font);
  end;
end;



procedure TFrmLoopUpImPortEx.ActPickExecute(Sender: TObject);
var fParams:Variant;
    Values,unionpk:string;
    i,x:integer;
    BackOnCalcFields: TDataSetNotifyEvent ;
    RecordExists:Boolean;
begin
      //dataset1.Locate( 'Company;Contact;Phone ',   VarArrayOf([ 'Sight   Diver ',   'P ',   '408-431-1000 ']),   [loPartialKey]);

       // fDict.ImportSourceFlds                            //  fDict.ImportDectFlds
      if not dlDataSet1.Active then exit;
      if   dlDataSet1.IsEmpty  then exit;

      BackOnCalcFields:=FImportToDataSet.OnCalcFields;
      //  FImportToDataSet.OnCalcFields:=nil;         //2010-2-12 if get rid of cal event ,after import record ,it cannot cal qty.
      fParams:=FhlKnl1.Ds_GetFieldsValue(dlDataSet1,fDict.ImportPK );

      unionpk:=  fDict.ImportPK ;
      IF  POS(',',fDict.ImportPK)>0   THEN
      begin
          for i:=0 to 10 do
              unionpk:=StringReplace(  unionpk ,',',';',[])     ;
          RecordExists:=  FImportToDataSet.Locate( unionpk,  fParams,[]);
      end
      else
          RecordExists:=  FImportToDataSet.Locate( unionpk,  dlDataSet1.fieldbyname(unionpk).asstring,[]);

      if not RecordExists then
          FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds)
      else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
          FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds,false);
end;

procedure TFrmLoopUpImPortEx.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

     case key of
       vk_Escape:Close;
       vk_Return:begin
                      OpnDlDsBtn1.Click ;
                 end;
     end;
end;

procedure TFrmLoopUpImPortEx.FormCreate(Sender: TObject);
begin
DBGridDL:=TModelDbGrid.create(self) ;
DBGridDL.Parent :=pnlGd;
DBGridDL.Align :=alclient;
DBGridDL.DataSource:=self.DlDataSource1;
DBGridDL.PopupMenu :=dmfrm.DbGridPopupMenu1;
end;

procedure TFrmLoopUpImPortEx.FormDestroy(Sender: TObject);
begin
freeandnil(DBGridDL);
end;

procedure TFrmLoopUpImPortEx.getFocuse;
begin

end;

procedure TFrmLoopUpImPortEx.actPickALLExecute(Sender: TObject);
var fParams:Variant;
    Values,unionpk:string;
    i,x, j :integer;
    BackOnCalcFields: TDataSetNotifyEvent ;
    RecordExists:Boolean;
begin
  try
      Screen.Cursor:=crHourGlass;
      if not dlDataSet1.Active then exit;
      if   dlDataSet1.IsEmpty  then exit;

      BackOnCalcFields:=FImportToDataSet.OnCalcFields;
      fParams:=FhlKnl1.Ds_GetFieldsValue(dlDataSet1,fDict.ImportPK );
      unionpk:=  fDict.ImportPK ;


      for j:=0 to dlDataSet1.RecordCount -1 do
      begin
        IF  POS(',',fDict.ImportPK)>0   THEN
        begin
            for i:=0 to 10 do
                unionpk:=StringReplace(  unionpk ,',',';',[])     ;
            RecordExists:=  FImportToDataSet.Locate( unionpk,  fParams,[]);
        end
        else
            RecordExists:=  FImportToDataSet.Locate( unionpk,  dlDataSet1.fieldbyname(unionpk).asstring,[]);

        if not RecordExists then
            FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds)
        else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
            FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds,false);

        dlDataSet1.Next ;
      end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmLoopUpImPortEx.OnEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SecondCnt:=0;
  tmrQry.Enabled :=true;
end;

procedure TFrmLoopUpImPortEx.tmrQryTimer(Sender: TObject);
begin
  Inc(SecondCnt)   ;
  if SecondCnt>40  then
  begin
    tmrQry.Enabled :=False;
    self.OpnDlDsBtn1.Click   ;
  end ;
end;

procedure TFrmLoopUpImPortEx.RefreshAction1Execute(Sender: TObject);
begin
 dlDataSet1.Close;

 OpnDlDsBtn1Click(sender);
end;

procedure TFrmLoopUpImPortEx.lblTitleClick(Sender: TObject);
begin
ScrollTopDblClick(sender);
end;

end.
