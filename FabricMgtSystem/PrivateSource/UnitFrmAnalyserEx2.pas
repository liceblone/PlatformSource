unit UnitFrmAnalyserEx2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ActnList, ADODB, Buttons, StdCtrls, ExtCtrls, Grids,
  DBGrids, ComCtrls, FhlKnl,ToolWin, jpeg,UnitGrid,UnitModelFrm;

type
  TAnalyseEx2 = class(TFrmModel)
    BtmPanel1: TPanel;
    Label1: TLabel;
    TopPanel1: TPanel;
    statLabel1: TLabel;
    OpnDlDsBtn1: TSpeedButton;
    mtADODataSet1: TADODataSet;
    mtADODataSet1IntegerField111: TIntegerField;
    mtDataSource1: TDataSource;
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    TLBtnShowQry: TToolButton;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    PrintAction1: TAction;
    RefreshAction1: TAction;
    CloseAction1: TAction;
    HelpAction1: TAction;
    Splitter1: TSplitter;
    PgGrids: TPageControl;
    ActOriBill: TAction;
    LblTitle: TLabel;

    procedure OpnDlDsBtn1Click(Sender: TObject);
    procedure printAction0Execute(Sender: TObject);
    procedure refreshAction1Execute(Sender: TObject);
    procedure TopPanel1DblClick(Sender: TObject);
    procedure TLBtnShowQryClick(Sender: TObject);

    procedure ToolButton5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Action1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure HelpAction1Execute(Sender: TObject);
    procedure PgGridsChange(Sender: TObject);
    procedure ActOriBillExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    fDict:TAnalyserDict;
    { Private declarations }
  public
    DBGdCurrent: TDBGrid;
    PAuthoriseTmpTable:string ;
    { Public declarations }
    procedure InitFrm(AFrmId:String;AmtParams:Variant);
    procedure DBGrid1DrawColumnCellFntClr(Sender: TObject;const Rect: TRect; DataCol: Integer;
              Column: TColumn; State: TGridDrawState);
    procedure IniCurrentGrid(PGrid:TDBGrid;GridID:string);
    procedure DsAfterScroll(Sender: TDataSet);
  end;

var
  AnalyseEx: TAnalyseEx2;

implementation

uses datamodule,UnitCreateComponent,UnitUserDefineRpt,UnitBillEx,Editor;

{$R *.dfm}
procedure TAnalyseEx2.InitFrm(AFrmId:String;AmtParams:Variant);
var i:integer;
var GdRep:Tdbgrid;
var DsSource:TDataSource;
var DsSet :TadodataSet;
var GridLst:TstringList;
begin

try
  GridLst:=TstringList.Create ;
  if Not FhlKnl1.Cf_GetDict_Analyser(AFrmId,fdict) then Close;

  GridLst.CommaText :=  fdict.DbGridId;
  Caption:=fDict.Caption;
  LblTitle.Caption :=fDict.Caption;
  FhlUser.SetDataSet(mtAdoDataSet1,fDict.mtDataSetId,AmtParams);
  if mtAdoDataSet1.Active then
  begin
      FhlUser.AssignDefault(mtAdoDataSet1);
      if mtAdoDataSet1.IsEmpty then
      begin
          mtAdoDataSet1.Append;
      end;
  end;
   if  fDict.Actions <>'' then
      FhlKnl1.Tb_CreateActionBtns_Ex(self.ToolBar1,self.ActionList1,fDict.Actions )
   else
      ToolBar1.Visible :=false;


  if (fDict.TopBoxId<>'-1') and (fDict.TopBoxId<>'' ) then      //top or buttom      create label and dbcontrol
    FhlKnl1.Cf_SetBox(fDict.TopBoxId,mtDataSource1,TopPanel1,dmFrm.UserDbCtrlActLst);
  if (fDict.BtmBoxId<>'-1') and (fDict.BtmBoxId<> '') then
    FhlKnl1.Cf_SetBox(fDict.BtmBoxId,mtDataSource1,BtmPanel1,dmFrm.UserDbCtrlActLst);

          
  for i:=0 to  GridLst.Count -1 do
  begin
     DsSet :=TadodataSet.Create (self);
     DsSet.connection:=dmFrm.ADOConnection1;
     DsSet.AfterScroll :=  DsAfterScroll  ;
     DsSource:=TDataSource.Create (self);
     DsSource.DataSet := DsSet;
   
    GdRep:=TModelDbGrid.Create(self);

     GdRep.PopupMenu :=dmFrm.DbGridPopupMenu1 ;
     GdRep.DataSource :=  DsSource;

     if GridLst.Count =1 then
        GdRep.Parent :=self.PgGrids
    else
     begin
        GdRep.Parent := fhlknl1.Pc_CreateTabSheet (PgGrids) ;
     end;
     GdRep.Align :=alclient;
     IniCurrentGrid(GdRep, GridLst[i]);
     if i=0 then    DBGdCurrent:=  GdRep ;

  end;

  if fDict.DblActIdx>-1 then
    if ActionList1.ActionCount > fDict.DblActIdx then
       DBGdCurrent.OnDblClick:=ActionList1.Actions[fDict.DblActIdx].OnExecute  ;


  if fDict.IsOpen then
  begin
    if mtAdoDataSet1.Active then
      OpnDlDsBtn1.Click         //≤È—Ø
    else
      DBGdCurrent.DataSource.DataSet.Open;
  end;

finally
    GridLst.Free;
end;
    
end;

procedure TAnalyseEx2.DBGrid1DrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
var GridDraw:Tdbgrid;
begin
  GridDraw:=     (Sender as Tdbgrid);

  if GridDraw.DataSource.DataSet.IsEmpty then exit;

  if  GridDraw.DataSource.DataSet.FindField ('FntClr') <>nil then
  begin
      GridDraw.Canvas.Font.Color:=StringToColor(GridDraw.DataSource.DataSet.FieldByName('FntClr').AsString);
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,GridDraw.Canvas.Font);
  end;
end;

procedure TAnalyseEx2.IniCurrentGrid(PGrid:TDBGrid;GridID:string);
var i:integer;
begin
  FhlUser.SetDbGridAndDataSet(PGrid,GridID,null,false);

  if PGrid.DataSource.DataSet.FindField('FntClr')<>nil then
     PGrid.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr
  else
  begin
      for i:=0 to PGrid.Columns.Count -1 do
      begin
          if uppercase(PGrid.Columns[i].FieldName) = uppercase( 'FntClr' )then
          begin
               PGrid.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
               break;
          end;
      end;

  end;
  
end;
procedure TAnalyseEx2.OpnDlDsBtn1Click(Sender: TObject);
var fParams:variant;
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

    fParams:=FhlKnl1.Ds_GetFieldsValue(mtAdoDataSet1,fDict.mtOpenParamFlds,true);

    if Not VarIsNull(fParams) then
    begin
         FhlKnl1.Ds_OpenDataSet(DBGdCurrent.DataSource.DataSet  ,fParams);
         FhlKnl1.SetColFormat(DBGdCurrent );
    end;

    if assigned(  DBGdCurrent.DataSource.DataSet.FindField('fntclr')) then
       DBGdCurrent.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
end;

procedure TAnalyseEx2.printAction0Execute(Sender: TObject);
begin
showmessage('');
end;

procedure TAnalyseEx2.refreshAction1Execute(Sender: TObject);
begin
showmessage('relash');
end;

procedure TAnalyseEx2.TopPanel1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ; 
begin

  if LoginInfo.Sys  then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.TOPBoxId :=self.fDict.TopBoxId ;
    CrtCom.TopOrBtm:=true;
    CrtCom.mtDataSet1:=self.mtADODataSet1 ;
    CrtCom.mtDataSetId :=inttostr(mtADODataSet1.tag);
    if DBGdCurrent<>nil then
    begin
    CrtCom.DlGridId :=inttostr(self.DBGdCurrent.Tag ) ;
    CrtCom.DLGrid :=self.DBGdCurrent ;
    end;
    CrtCom.ShowModal ;
    CrtCom.Free ;
  end;

try
  
finally

end;
end;

procedure TAnalyseEx2.TLBtnShowQryClick(Sender: TObject);
begin 
self.TopPanel1.Visible :=self.TLBtnShowQry.Down ;
end;



procedure TAnalyseEx2.ToolButton5Click(Sender: TObject);
begin
     self.Close;
end;

procedure TAnalyseEx2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if PAuthoriseTmpTable<>'' then
  fhlknl1.Kl_GetQuery2('drop table '+ PAuthoriseTmpTable  ,false );
  Action:=caFree;
end;

procedure TAnalyseEx2.Action1Execute(Sender: TObject);
begin
showmessage('');
end;

procedure TAnalyseEx2.CloseAction1Execute(Sender: TObject);
begin
    self.Close;
end;

procedure TAnalyseEx2.HelpAction1Execute(Sender: TObject);
begin
showMessage('help');
end;

procedure TAnalyseEx2.PgGridsChange(Sender: TObject);
var i:integer;
begin

if  self.PgGrids.ActivePage.controlcount >0 then
   for i:=0 to  self.PgGrids.ActivePage.controlcount-1 do
   begin
       if  self.PgGrids.ActivePage.controls[i] is Tdbgrid then
       DBGdCurrent:=Tdbgrid(self.PgGrids.ActivePage.controls[i])
   end;

end;

procedure TAnalyseEx2.ActOriBillExecute(Sender: TObject);
var sql:string;
var
  frmid:string;
  fBillType:string;
  BillFrm:TFrmBillEx;
  EditorFrm:TEditorFrm ;
  Code:string;
  FrmBillEx:TFrmBillEx ;
  LstParameterFLDs:Tstrings;
  i:integer;
begin
  sql:='select  F19,F17,F20 From T525 where F02='+fDict.Actions+' and f16=' +inttostr(Taction(Sender).Index )+' and f17=' +inttostr(Taction(Sender).ActionComponent.Tag  );
  fhlknl1.Kl_GetQuery2 (sql  );
  fBillType:=fhlknl1.FreeQuery.FieldByName('F19').AsString  ;
  frmid:=fhlknl1.FreeQuery.FieldByName('F17').AsString      ;
 
  if uppercase(fBillType)=uppercase('Analyser') then
  begin

      if DBGdCurrent.DataSource.DataSet .FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.DBGdCurrent.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;
      FhlUser.ShowAnalyserFrm(frmid,null);
  end;

  if uppercase(fBillType)=uppercase('Editor') then
  begin
      if DBGdCurrent.DataSource.DataSet .FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.DBGdCurrent.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;
      FhlUser.ShowEditorFrm(FrmId,Code).ShowModal ;
  end;
  if uppercase(fBillType)=uppercase('CRM') then
  begin

      if DBGdCurrent.DataSource.DataSet.FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.DBGdCurrent.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;
      FhlUser.ShowCRMFrm(frmid);
  end;
  if uppercase(fBillType)=uppercase('BillEx') then
  begin
    if not self.DBGdCurrent.DataSource.DataSet.IsEmpty then
    begin
    LstParameterFLDs:=Tstringlist.Create ;
    LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
    for i:=0 to  LstParameterFLDs.Count -1 do
    begin
      if   self.DBGdCurrent.DataSource.DataSet.FindField (LstParameterFLDs[i])<>nil then
      begin
         if self.DBGdCurrent.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString <>'' then
         begin
             Code:=self.DBGdCurrent.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString  ;
             break;
         end;
      end;
    end;
    end;
    FrmBillEx:=TFrmBillEx.Create(nil);
    FrmBillEx.InitFrm(FrmId);
    if Code<>'' then
    begin
       FrmBillEx.OpenBill( code  );
    end;
    FrmBillEx.FormStyle :=fsnormal;
    FrmBillEx.Hide;
    FrmBillEx.Position :=poDesktopCenter;
    FrmBillEx.ScrollBtm.Visible :=true;
    FrmBillEx.SetParamDataset(self.DBGdCurrent.DataSource.DataSet  );
    FrmBillEx.ShowModal ;
  end;
end;

procedure TAnalyseEx2.DsAfterScroll(Sender: TDataSet);
begin
     statLabel1.Caption:=intTostr(Tadodataset(Sender).RecNo)+'/'+intTostr(Tadodataset(Sender).RecordCount);
end;

procedure TAnalyseEx2.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if  Key=13 then
  begin
    self.OpnDlDsBtn1.Click;
  end;

end;

end.
