unit TreeGridSystool;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ComCtrls, ToolWin, Db, DBTables, stdctrls, ADODB, ImgList, 
  Menus, ActnList, ExtCtrls,     UnitGrid, UPublicCtrl,  UPublicFunction,

  variants,EditorSystool,   FhlKnl,UnitCreateComponent, DBCtrls;

type  TModelDbGridEx=class(TModelDbGrid)

      procedure WMMmouseMove(var Message: Tmessage);
end;
type
  TTreeGridFrmSystool = class(TForm)
    DataSource1: TDataSource;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    ADODataSet1: TADODataSet;
    ControlBar1: TControlBar;
    myBar1: TToolBar;
    ToolBar2: TToolBar;
    prtBtn: TToolButton;
    refreshBtn: TToolButton;
    upBtn: TToolButton;
    TreeBtn: TToolButton;
    setBtn: TToolButton;
    expbtn: TToolButton;
    ActionList1: TActionList;
    WarePropAction1: TAction;
    ExtBtn: TToolButton;
    EditorAction1: TAction;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    MainMenu1: TMainMenu;
    DBGrid1: TDBGrid;
    ToolButtonQtyOrFilter: TToolButton;
    statLabel1: TLabel;
    lblPnl: TLabel;
    ControlBarSel: TControlBar;
    act1: TAction;
    act2: TAction;
    act3: TAction;
    act4: TAction;
    act5: TAction;
    act6: TAction;
    actChk1: TAction;
    procedure InitFrm(FrmId:String;AParam:variant;Modal:boolean=false);
    procedure rfsBtnClick(Sender: TObject);
    procedure ExtBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdoDataSet1PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeBtnClick(Sender: TObject);
    procedure upBtnClick(Sender: TObject);
    procedure refreshBtnClick(Sender: TObject);
    procedure expbtnClick(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure EditorAction1Execute(Sender: TObject);
    procedure SortAction1Execute(Sender: TObject);
    procedure prtBtnClick(Sender: TObject);
    procedure ClientEmpAction1Execute(Sender: TObject);
    procedure LocateAction1Execute(Sender: TObject);

    procedure FilterAction1Execute(Sender: TObject);

 
    procedure myBar1DblClick(Sender: TObject);
    procedure ControlBar1DblClick(Sender: TObject);
    procedure actUpdateImageExecute(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    constructor Create(AOwner: TComponent);override;
    procedure ActQueryExecute(Sender: TObject);
    procedure ToolButtonQtyOrFilterClick(Sender: TObject);
    procedure IniShortCutFilter(Pdbgird:Tdbgrid);
    procedure IniQuickQuery(Pdbgird:Tdbgrid);
    procedure ADODataSet1AfterScroll(DataSet: TDataSet);
    procedure actChk1Execute(Sender: TObject);

  private
   // DBGRID1:TModelDbGridEx;
    fDict:TTreeGridDict;
    fEditorFrm:TEditorFrmSystool;
    fSortFrm,fFilterFrm,fLocateFrm:TForm;

    FGridPrivorSel:integer;
    FBackupCommandtext:string;
    GrpBox:TGrpSelRecord  ;//过滤条件
    GrpQueryRecord:TGrpQueryRecord;//查询
  public

  end;

var
  TreeGridFrmSystool: TTreeGridFrmSystool;

implementation
uses datamodule,RepGrid;
{$R *.DFM}

procedure TTreeGridFrmSystool.InitFrm(FrmId:String;AParam:variant;Modal:boolean=false);
begin
  if Modal then
  begin
  self.FormStyle :=fsnormal;
//  self.Visible :=false;
  end;
    fDict.Id:=FrmId;
  if Not FhlKnl1.Cf_GetDict_TreeGrid(FrmId,fdict) then Close;
   Caption:=fDict.Caption+'系统配置';

   FhlKnl1.Cf_SetTreeView(fDict.TreeId,TreeView1,dmFrm.FreeDataSet1,AParam);

   FhlUser.SetDbGridAndDataSet(dbGrid1,fDict.DbGridId,null,False);

   FBackupCommandtext:=self.ADODataSet1.commandtext; //backupCommandtext
   FhlKnl1.Dg_ConfigRight(dbGrid1, LoginInfo);

   if (fDict.Actions <>'' ) and (fDict.Actions <>'-1' )  then
   begin
       FhlKnl1.Tb_CreateActionBtns(myBar1,ActionList1,fDict.Actions);
       FhlKnl1.Act_ConfigRight (ActionList1,logininfo);
   end;
   if  myBar1.ButtonCount >0 then
   begin
        if  myBar1.Buttons[0].Enabled then
        DbGrid1.OnDblClick:=myBar1.Buttons[0].OnClick;
   end;

   TreeView1.Items.GetFirstNode.Selected:=fDict.IsOpen;

  if not logininfo.IsTool then
   begin
   IniShortCutFilter(self.DBGrid1 );
   IniQuickQuery(self.DBGrid1 );
   end;
end;

procedure TTreeGridFrmSystool.rfsBtnClick(Sender: TObject);
begin
  DataSource1.DataSet.Close;
  DataSource1.DataSet.Open;
end;

procedure TTreeGridFrmSystool.ExtBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TTreeGridFrmSystool.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if fEditorFrm<>nil then
       fEditorFrm.Free;
    if fLocateFrm<>nil then
       fLocateFrm.Free;
    if fFilterFrm<>nil then
       fFilterFrm.Free;
    if fSortFrm<>nil then
       fSortFrm.Free;
    Action:=caFree;
end;

procedure TTreeGridFrmSystool.AdoDataSet1PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  Beep;
 Action:=daAbort;
end;

procedure TTreeGridFrmSystool.TreeView1Change(Sender: TObject; Node: TTreeNode);
  var p:string;
begin
  Screen.Cursor:=crSqlWait;
  try
    p:=TStrPointer(Node.Data)^;
    if AdoDataSet1.FindField(fDict.ClassFld)<>Nil then
    begin
      sDefaultVals:=fDict.ClassFld+'='+p;
      FhlUser.AssignDefault(AdoDataSet1);
    end;
    p:=p+'%';

   if   FBackupCommandtext<>'' then
    begin
        self.ADODataSet1.Close ;
        self.ADODataSet1.CommandText  := FBackupCommandtext;           //
    end;
    
    FhlKnl1.Ds_OpenDataSet(AdoDataSet1,varArrayof([p,LoginInfo.LoginId]));
    lblPnl.Caption:=FhlKnl1.Tv_GetTreePath(Node);//+inttostr(AdoDataSet1.recordCount)+' 个项目';
    statLabel1.Left :=lblPnl.Left +lblPnl.Width ;//
    expBtn.Enabled:=Node.HasChildren;

  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TTreeGridFrmSystool.TreeBtnClick(Sender: TObject);
begin
 GroupBox1.Visible:=TreeBtn.Down;
end;

procedure TTreeGridFrmSystool.upBtnClick(Sender: TObject);
begin
 if TreeView1.Selected<>nil then
   with TreeView1.Selected do
        if Level>0 then
           Parent.Selected:=true;
end;

procedure TTreeGridFrmSystool.refreshBtnClick(Sender: TObject);
 
begin


 TreeView1Change(TreeView1,TreeView1.Selected);

end;

procedure TTreeGridFrmSystool.expbtnClick(Sender: TObject);
 var Node:TTreeNode;
begin
 Node:=TreeView1.Selected;
 if Node=nil then 
    Node:=FhlKnl1.Tv_FindNode(Treeview1,'');
 with Node do
    if Expanded then
       Collapse(True)
    else 
       Expand(True);
end;


procedure TTreeGridFrmSystool.DeleteAction1Execute(Sender: TObject);
var
  i,F_MID: integer;
  TempBookmark: TBookMark;

var
  fDict:TBeforeDeleteDict;
begin



end;

procedure TTreeGridFrmSystool.EditorAction1Execute(Sender: TObject);
  var i:integer;
begin
if (fDict.EditorId<>'' )and (fDict.EditorId<>'-1' )   then
begin
  if fEditorFrm=nil then
  begin
        fEditorFrm:=TEditorFrmSystool(FhlUser.ShowEditorFrmSystool(fDict.EditorId,null,self.AdoDataSet1));
  end;
  fEditorFrm.ShowModal;


     for i:=0 to self.ADODataSet1.FieldCount -1 do
     begin
         if ADODataSet1.Fields[i].FieldKind    =fkLookup then
         ADODataSet1.Fields[i].LookupDataSet.Filtered :=false;
     end;

end;
  
end;

procedure TTreeGridFrmSystool.SortAction1Execute(Sender: TObject);
begin
  FhlKnl1.Dg_Sort(DbGrid1);
end;



procedure TTreeGridFrmSystool.prtBtnClick(Sender: TObject);
begin
 FhlUser.CheckRight(fdict.PrintRitId);
 FhlKnl1.Rp_DbGrid(intTostr(DbGrid1.Tag),DbGrid1,self.fDict.Caption );
end;

procedure TTreeGridFrmSystool.ClientEmpAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('3',varArrayof([AdoDataSet1.FieldByName('Code').asString]));
end;

procedure TTreeGridFrmSystool.LocateAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(DbGrid1.DataSource.DataSet);
end;



procedure TTreeGridFrmSystool.FilterAction1Execute(Sender: TObject);
begin

  FhlKnl1.Ds_Filter(nil,self.DBGrid1 );
  GrpBox.IniGrpBox(self.DBGrid1 );
end;




procedure TTreeGridFrmSystool.myBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.FTreeGridDict :=  fdict;
    CrtCom.ModelType :=ModelFrmTreeGrid;
    CrtCom.mtDataSet1 :=self.ADODataSet1 ;
    CrtCom.DLGrid :=self.DBGrid1 ;
     try
    CrtCom.Show;
finally

end;
  end;



end;

procedure TTreeGridFrmSystool.ControlBar1DblClick(Sender: TObject);
begin
mybar1.OnDblClick   (sender);
end;

procedure TTreeGridFrmSystool.actUpdateImageExecute(Sender: TObject);
begin

       if fEditorFrm=nil then
    fEditorFrm:=TEditorFrmSystool(FhlUser.ShowEditorFrmSystool('28',null,self.AdoDataSet1));
  fEditorFrm.ShowModal;
end;

procedure TTreeGridFrmSystool.DBGrid1CellClick(Column: TColumn);
  var i,LastRow,StRow,edRow:integer;
begin

{
    //   if  (Button =mbLeft) and (ssShift in Shift) then
       begin
            LastRow:=         DBGrid1.DataSource.DataSet.RecNo ;
            if LastRow  <FGridPrivorSel  then
            begin
                 StRow :=LastRow ;
                 edRow:= FGridPrivorSel;
            end
            else
            begin
                StRow  :=FGridPrivorSel;
                edRow:= StRow;
            end;

            for i:= 0 to   abs(FGridPrivorSel-LastRow)-1  do
            begin
                if LastRow>FGridPrivorSel then
                    DBGrid1.DataSource.DataSet.Next
                else
                    DBGrid1.DataSource.DataSet.Prior ;

                DBGrid1.SelectedRows.CurrentRowSelected :=true;

            end;
       end;

       FGridPrivorSel:=         DBGrid1.DataSource.DataSet.RecNo ;
       }
end;

procedure TTreeGridFrmSystool.DBGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  var i :integer;
  var Cell: TGridCoord;
begin

{}if  ssLeft  in Shift then
begin
      Cell:= DBGrid1.MouseCoord(x,y);
      if  Cell.y >0 then
      begin
          {
          if FGridPrivorSel>  DBGrid1.DataSource.DataSet.RecNo then
          self.Caption :=inttostr(1);
          if FGridPrivorSel<  DBGrid1.DataSource.DataSet.RecNo then
          self.Caption :=inttostr(-1);
          }
          DBGrid1.DataSource.DataSet.MoveBy(Cell.Y-DBGrid1.DataSource.DataSet.RecNo );

          if FGridPrivorSel<>  DBGrid1.DataSource.DataSet.RecNo then
          DBGrid1.SelectedRows.CurrentRowSelected:=not DBGrid1.SelectedRows.CurrentRowSelected ;

          if FGridPrivorSel=DBGrid1.DataSource.DataSet.RecNo then
          DBGrid1.SelectedRows.CurrentRowSelected:=true;

          FGridPrivorSel:=  DBGrid1.DataSource.DataSet.RecNo;
      end;

end;
end;

constructor TTreeGridFrmSystool.Create(AOwner: TComponent);
begin
  inherited;
{
  DBGRID1:=TModelDbGridEx.create(owner);
  DBGRID1.Parent :=self.Panel1;
  DBGRID1.Align :=alclient;
  DBGRID1.DataSource :=self.DataSource1 ;
    }
end;


procedure TModelDbGridEx.WMMmouseMove(var Message: Tmessage)   ;
  var i ,j:integer;
  var Cell: TGridCoord;
begin

  showmessage('');

      if TWMMOUSEMOVE (Message).Keys =MK_LBUTTON  then
      begin
           Cell:= self.MouseCoord(TWMMOUSEMOVE (Message).XPos ,TWMMOUSEMOVE (Message).YPos );
     //       self.Caption :=inttostr(Cell.x)+'  '+inttostr(Cell.Y );

           self.DataSource.DataSet.MoveBy(abs(row-Cell.Y ));
           self.SelectedRows.CurrentRowSelected :=true;
      end;

end;


procedure TTreeGridFrmSystool.ActQueryExecute(Sender: TObject);
var ConSql,sql:string;


begin



ConSql:=fhlknl1.Ds_Query(self.ADODataSet1,self.DBGrid1 );

end;

procedure TTreeGridFrmSystool.ToolButtonQtyOrFilterClick(Sender: TObject);
begin

ControlBarSel.Visible :=ToolButtonQtyOrFilter.Down ;
GrpQueryRecord.Visible :=ToolButtonQtyOrFilter.Down ;
  
GrpBox.Visible :=ToolButtonQtyOrFilter.Down ;
    GrpQueryRecord.width:=GrpQueryRecord.Btnqry.Left +GrpQueryRecord.Btnqry.Width +10;
    self.GrpBox.Left := GrpQueryRecord.width+20;
    GrpBox.Height :=  GrpQueryRecord.Height ;

end;

procedure TTreeGridFrmSystool.IniShortCutFilter(Pdbgird: Tdbgrid);

begin
//
    GrpBox:=TGrpSelRecord.create(self);
    GrpBox.Parent :=self.ControlBarSel;
    GrpBox.Height :=GrpBox.Parent.Height -2 ;
    GrpBox.IniGrpBox(Pdbgird)    ;

end;

procedure TTreeGridFrmSystool.ADODataSet1AfterScroll(DataSet: TDataSet);
begin
 statLabel1.Left :=lblPnl.Left +lblPnl.Width ;
 statLabel1.Caption:=intTostr(self.ADODataSet1.RecordCount)+'\'+intTostr(self.ADODataSet1.RecNo);
end;

procedure TTreeGridFrmSystool.IniQuickQuery(Pdbgird: Tdbgrid);
begin
    GrpQueryRecord:=TGrpQueryRecord.create(self);
    GrpQueryRecord.Parent :=ControlBarSel;
    GrpQueryRecord.Height :=GrpQueryRecord.Parent.Height -2  ;
    GrpQueryRecord.Width :=  GrpQueryRecord.Parent.Width -self.GrpBox.Width ;
    GrpQueryRecord.Align :=alleft;
    self.GrpBox.Left := GrpQueryRecord.width ;
    GrpBox.Height :=  GrpQueryRecord.Height ;
    GrpQueryRecord.IniQuickQuery(Pdbgird) ;
end;


procedure TTreeGridFrmSystool.actChk1Execute(Sender: TObject);
var
  fbk:TBookmark;
begin
  try
    Screen.Cursor:=crHourGlass;

    fbk:=ADODataSet1.GetBookmark;
    FhlUser.DoExecProc(ADODataSet1 ,null);
    FhlKnl1.Ds_RefreshDataSet(ADODataSet1 );
    ADODataSet1.GotoBookmark(fbk);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

end.
