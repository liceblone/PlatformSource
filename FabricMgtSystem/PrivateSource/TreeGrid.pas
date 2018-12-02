unit TreeGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ComCtrls, ToolWin, Db, DBTables, stdctrls, ADODB, ImgList, 
  Menus, ActnList, ExtCtrls,     UnitGrid, UPublicCtrl,  UPublicFunction,StrUtils,

  variants,Editor,   FhlKnl,UnitCreateComponent, DBCtrls,UnitModelFrm;

type  TModelDbGridEx=class(TModelDbGrid)

      procedure WMMmouseMove(var Message: Tmessage);
end;
type
  TTreeGridFrm = class(TFrmModel)
    DataSource1: TDataSource;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    ADODataSet1: TADODataSet;
    ControlBar1: TControlBar;
    myBar1: TToolBar;
    ToolBar2: TToolBar;
    refreshBtn: TToolButton;
    upBtn: TToolButton;
    TreeBtn: TToolButton;
    expbtn: TToolButton;
    ActionList1: TActionList;
    ExtBtn: TToolButton;
    EditorAction1: TAction;
    DeleteAction1: TAction;
    SortAction1: TAction;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    MainMenu1: TMainMenu;
    LocateAction1: TAction;
    FilterAction1: TAction;

    ToolButtonQtyOrFilter: TToolButton;
    statLabel1: TLabel;
    lblPnl: TLabel;
    ControlBarSel: TControlBar;
    Action1: TAction;
    ActHelp: TAction;
    ToolButton1: TToolButton;
    ActClearALL: TAction;
    ToolButton2: TToolButton;
    actChk1: TAction;
    actExecProc: TAction;
    actBatchUpdate: TAction;
    procedure InitFrm(FrmId:String;AParam:variant;Modal:boolean=false);
    procedure rfsBtnClick(Sender: TObject);
    procedure ExtBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdoDataSet1PostError(DataSet: TDataSet; E: EDatabaseError;      var Action: TDataAction);
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
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,       Y: Integer);
    constructor Create(AOwner: TComponent);override;
    procedure ActQueryExecute(Sender: TObject);
    procedure ToolButtonQtyOrFilterClick(Sender: TObject);
    procedure IniShortCutFilter(Pdbgird:Tdbgrid);
    procedure IniQuickQuery(Pdbgird:Tdbgrid);
    procedure ADODataSet1AfterScroll(DataSet: TDataSet);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActClearALLExecute(Sender: TObject);
    procedure actChk1Execute(Sender: TObject);
    procedure actExecProcExecute(Sender: TObject);
    procedure actBatchUpdateExecute(Sender: TObject);

  private
    DBGRID1:TModelDbGrid;
    fDict:TTreeGridDict;
    fEditorFrm:TEditorFrm;
    fSortFrm,fFilterFrm,fLocateFrm:TForm;

    FGridPrivorSel:integer;
    FBackupCommandtext:string;
    GrpBox:TGrpSelRecord  ;//过滤条件
    GrpQueryRecord:TGrpQueryRecord;//查询
  public


  end;

var
  TreeGridFrm: TTreeGridFrm;

implementation
uses datamodule,RepGrid , TabEditor;
{$R *.DFM}

procedure TTreeGridFrm.InitFrm(FrmId:String;AParam:variant;Modal:boolean=false);
begin
  if Modal then
  begin
  self.FormStyle :=fsnormal;
//  self.Visible :=false;
  end;
    fDict.Id:=FrmId;
  if Not FhlKnl1.Cf_GetDict_TreeGrid(FrmId,fdict) then Close;
 //  Caption:=fDict.Caption;

   if fDict.TreeId<>'' then
   FhlKnl1.Cf_SetTreeView(fDict.TreeId,TreeView1,dmFrm.FreeDataSet1,AParam);
                   
   FhlUser.SetDbGridAndDataSet(dbGrid1,fDict.DbGridId,null,False);

   FBackupCommandtext:=self.ADODataSet1.commandtext; //backupCommandtext
  // FhlKnl1.Dg_ConfigRight(dbGrid1, LoginInfo);   //列权限控制

   if (fDict.Actions <>'' ) and (fDict.Actions <>'-1' )  then
   begin
       FhlKnl1.Tb_CreateActionBtns_ex(myBar1,ActionList1,fDict.Actions,logininfo.EmpId,FWindowsFID);
        FhlKnl1.Act_ConfigRight (ActionList1,logininfo);
   end
   else
   myBar1.Visible :=false;


   if  myBar1.ButtonCount >0 then
   begin
        if  myBar1.Buttons[0].Enabled then
        DbGrid1.OnDblClick:=myBar1.Buttons[0].OnClick;
   end;
   if  TreeView1.Items.GetFirstNode<>nil then
     TreeView1.Items.GetFirstNode.Selected:=fDict.IsOpen;

  if not logininfo.IsTool then
   begin
   IniShortCutFilter(self.DBGrid1 );
   IniQuickQuery(self.DBGrid1 );
   end;
end;

procedure TTreeGridFrm.rfsBtnClick(Sender: TObject);
begin
  DataSource1.DataSet.Close;
  DataSource1.DataSet.Open;
end;

procedure TTreeGridFrm.ExtBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TTreeGridFrm.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TTreeGridFrm.AdoDataSet1PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  Beep;
 Action:=daAbort;
end;

procedure TTreeGridFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
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
     if  pos(')',ADODataSet1.CommandText)>-1 then
     begin
          (AdoDataSet1).Prepared :=true;
          (AdoDataSet1).Parameters[0].Value := p;
          AdoDataSet1.Open ;
     end
     else
     begin
        FhlKnl1.Ds_OpenDataSet(AdoDataSet1,varArrayof([p,LoginInfo.LoginId]));
     end;
     FhlKnl1.SetColFormat(DBGrid1 );

    lblPnl.Caption:=FhlKnl1.Tv_GetTreePath(Node);//+inttostr(AdoDataSet1.recordCount)+' 个项目';
    statLabel1.Left :=lblPnl.Left +lblPnl.Width ;//
    expBtn.Enabled:=Node.HasChildren;

  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TTreeGridFrm.TreeBtnClick(Sender: TObject);
begin
 GroupBox1.Visible:=TreeBtn.Down;
end;

procedure TTreeGridFrm.upBtnClick(Sender: TObject);
begin
 if TreeView1.Selected<>nil then
   with TreeView1.Selected do
        if Level>0 then
           Parent.Selected:=true;
end;

procedure TTreeGridFrm.refreshBtnClick(Sender: TObject);
begin
 TreeView1Change(TreeView1,TreeView1.Selected);
end;

procedure TTreeGridFrm.expbtnClick(Sender: TObject);
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



procedure TTreeGridFrm.DeleteAction1Execute(Sender: TObject);
var
  i,F_MID: integer;
  TempBookmark: TBookMark;

var
  fDict:TBeforeDeleteDict;
begin


 if Not FhlKnl1.Cf_GetDict_BeforeDelete(intTostr(ADODataSet1.Tag),fdict) then exit;



 if (not AdoDataSet1.IsEmpty)  then
 begin

   if (not assigned(ADODataSet1.BeforeDelete ) ) or  (fdict.Hint ='' )then
   begin
      if    messagedlg('确定'+self.DeleteAction1.Caption+'?'  ,mtinformation,[mbOk, mbCancel],0)=mrOK then
          DBGrid1.SelectedRows.Delete     ;
   end
   else
          DBGrid1.SelectedRows.Delete;
  end
  else
     showmessage('请先选择记录!');

end;

procedure TTreeGridFrm.EditorAction1Execute(Sender: TObject);
  var i:integer;
begin
    if not  AdoDataSet1.Active then
    begin
      showmessage('请先点左边树节点!');
      Exit;
    end;

    if (fDict.EditorId<>'' )and (fDict.EditorId<>'-1' )   then
    begin
      if fEditorFrm=nil then
      begin
            fEditorFrm:=TEditorFrm(FhlUser.ShowEditorFrm(fDict.EditorId,null,self.AdoDataSet1,nil,self.DBGrid1 ));
         
          //  fEditorFrm.btnShowLog.Visible :=false;
      end;
      fEditorFrm.ShowModal;

       for i:=0 to self.ADODataSet1.FieldCount -1 do
       begin
           if ADODataSet1.Fields[i].FieldKind    =fkLookup then
           ADODataSet1.Fields[i].LookupDataSet.Filtered :=false;
       end;
    end;
end;

procedure TTreeGridFrm.SortAction1Execute(Sender: TObject);
begin
  FhlKnl1.Dg_Sort(DbGrid1);
end;



procedure TTreeGridFrm.prtBtnClick(Sender: TObject);
begin
 FhlUser.CheckRight(fdict.PrintRitId);
 FhlKnl1.Rp_DbGrid(intTostr(DbGrid1.Tag),DbGrid1,self.fDict.Caption );
end;

procedure TTreeGridFrm.ClientEmpAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('3',varArrayof([AdoDataSet1.FieldByName('Code').asString]));
end;

procedure TTreeGridFrm.LocateAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(DbGrid1.DataSource.DataSet);
end;



procedure TTreeGridFrm.FilterAction1Execute(Sender: TObject);
begin

  FhlKnl1.Ds_Filter(nil,self.DBGrid1 );
  GrpBox.IniGrpBox(self.DBGrid1 );
end;



procedure TTreeGridFrm.myBar1DblClick(Sender: TObject);
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

procedure TTreeGridFrm.ControlBar1DblClick(Sender: TObject);
begin
mybar1.OnDblClick   (sender);
end;

procedure TTreeGridFrm.actUpdateImageExecute(Sender: TObject);
begin
 if fEditorFrm=nil then
    fEditorFrm:=TEditorFrm(FhlUser.ShowEditorFrm('28',null,self.AdoDataSet1));
  fEditorFrm.ShowModal;
end;

procedure TTreeGridFrm.DBGrid1CellClick(Column: TColumn);
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

procedure TTreeGridFrm.DBGrid1MouseMove(Sender: TObject;
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

constructor TTreeGridFrm.Create(AOwner: TComponent);
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


procedure TTreeGridFrm.ActQueryExecute(Sender: TObject);
var ConSql,sql:string;


begin



ConSql:=fhlknl1.Ds_Query(self.ADODataSet1,self.DBGrid1 );

end;

procedure TTreeGridFrm.ToolButtonQtyOrFilterClick(Sender: TObject);
begin

ControlBarSel.Visible :=ToolButtonQtyOrFilter.Down ;
GrpQueryRecord.Visible :=ToolButtonQtyOrFilter.Down ;
  
GrpBox.Visible :=ToolButtonQtyOrFilter.Down ;
    GrpQueryRecord.width:=GrpQueryRecord.Btnqry.Left +GrpQueryRecord.Btnqry.Width +10;
    self.GrpBox.Left := GrpQueryRecord.width+20;
    GrpBox.Height :=  GrpQueryRecord.Height ;

end;

procedure TTreeGridFrm.IniShortCutFilter(Pdbgird: Tdbgrid);

begin
//
    GrpBox:=TGrpSelRecord.create(self);
    GrpBox.Parent :=self.ControlBarSel;
    GrpBox.Height :=GrpBox.Parent.Height -2 ;
    GrpBox.IniGrpBox(Pdbgird)    ;

end;

procedure TTreeGridFrm.ADODataSet1AfterScroll(DataSet: TDataSet);
begin
 statLabel1.Left :=lblPnl.Left +lblPnl.Width ;
 statLabel1.Caption:=intTostr(self.ADODataSet1.RecordCount)+'\'+intTostr(self.ADODataSet1.RecNo);
end;

procedure TTreeGridFrm.IniQuickQuery(Pdbgird: Tdbgrid);
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


procedure TTreeGridFrm.DBGrid1TitleClick(Column: TColumn);
var fieldname,strtmp,OriCaption:string;
    i:integer;
begin
  inherited;
  strtmp:=Column.Title.Caption;

  if not self.ADODataSet1.Active then exit;
  fieldname:= Column.FieldName;
  if (Column.Field.FieldKind  =  fkLookup ) then
   fieldname:= Column.Field.LookupKeyFields  ;

 

  if  TChyColumn(Column ).isAsc     then
  begin
    self.ADODataSet1.Sort :=fieldname +' ASC';
  end
  else
  begin
    self.ADODataSet1.Sort :=fieldname+' DESC';
  end   ;
     TChyColumn(Column ).isAsc  :=not   TChyColumn(Column ).isAsc     ;
end;

procedure TTreeGridFrm.ToolButton1Click(Sender: TObject);
begin
  inherited;
  if self.DBGrid1.DataSource.DataSet.Active then
  fhluser.showLogwindow(self.DBGrid1 ); 
end;

procedure TTreeGridFrm.FormCreate(Sender: TObject);
begin 
      ActClearALL.Visible :=logininfo.Sys;
      DBGRID1:=TModelDbGrid.create (self);
      DBGRID1.DataSource :=self.DataSource1;
      DBGRID1.Parent := self.Panel1;
      DBGRID1.Align :=alClient;
      DBGRID1.PopupMenu :=dmFrm.DbGridPopupMenu1 ;



end;

procedure TTreeGridFrm.ActClearALLExecute(Sender: TObject);
var MainTable:String;
var qry:Tadoquery;
begin
 if MessageDlg(#13#10+'确实要清空基础资料?'+char(10)+'删除的资料不能恢复。' ,mtInformation,[mbYes,mbNo],0)=mrNo then
    exit;

  fhlknl1.Kl_GetQuery2('select * From T201 where f01='+inttostr( ADODataSet1.tag));
  MainTable:=fhlknl1.FreeQuery.fieldbyname('F16').AsString;

  if (MainTable<>'')  then
  begin
    try
      qry:=Tadoquery.Create (nil);
      qry.Connection :=dmfrm.ADOConnection1 ;

      {
      qry.SQL.Clear;
      qry.SQL.Add( ' if exists(select *from '+logininfo.LogDataBaseName+'.dbo.sysobjects where name='+quotedstr(MainTable )+' )');
      qry.SQL.Add( ' delete '+logininfo.LogDataBaseName+'.dbo.'+MainTable );
      qry.ExecSQL;

      qry.SQL.Clear;
      qry.SQL.Add(' insert into  '+logininfo.LogDataBaseName +'.dbo.'+MainTable +' select * from  '+MainTable);
      qry.ExecSQL;
                  }
      qry.SQL.Clear;
      qry.SQL.Add('delete '+MainTable );
      qry.ExecSQL;
      
      ADODataSet1.Close;
      ADODataSet1.Open ;
      qry.Free ;
    except
      on E:Exception do
      begin
        showmessage(e.Message);
      end;
    end;
  end;

end;

procedure TTreeGridFrm.actChk1Execute(Sender: TObject);
var
  fbk:TBookmark;
  fsql,updatesql,MainUserDB,sqlLicenseProducts,sqlSysProductDefine:string ;
  qry:TADOQuery;
begin
 
  MainUserDB:= LoginInfo.MainUserDBName ;
  if MainUserDB='' then MainUserDB:=FhlKnl1.UserConnection.DefaultDatabase ;

  updatesql:=Format(Concat(
            ' update %s.dbo.TSysUMenuConfig ',
            ' set FCode=tmp.f01 ,FCaption =tmp.f04     ',
            ' from %s.dbo.TSysUMenuConfig  A           ',
            ' join                                     ',
            '   ( select F01,F04 ,F_ID                 ',
            '    from  %s.dbo.T511 A                   ',
            '     where isnull(A.F17,0)=0              ',
            '     and  isnull(A.FisSys,0)=0            ',
            '     and (A.F02=1 or A.F20=1)             ',
            '     and A.F03=1                          ',
            '     and A.F_ID  in (select FWindowsFID from  %s.dbo.TSysUMenuConfig)   ',
            '    )tmp  on A.FWindowsFID =tmp.F_ID  and A.FCode <> tmp.f01  ') , [MainUserDB,MainUserDB,logininfo.SysDBPubName ,MainUserDB]);

  fsql:=' insert into '+ MainUserDB +'.dbo.TSysUMenuConfig (FCode,FCaption,FWindowsFID,FDEL) ';
  fsql:=fsql+ '  select F01,F04,F_ID ,0 from '+logininfo.SysDBPubName +'.dbo.T511 A';
  fsql:=fsql+ '  where isnull(A.F17,0)=0 and  isnull(A.FisSys,0)=0  and (A.F02=1 or A.F20=1) and A.F03=1  and A.F_ID not in (select FWindowsFID from '+ MainUserDB +'.dbo.TSysUMenuConfig) order by f01';

  sqlLicenseProducts:=' insert into '+ MainUserDB +'.dbo.Sys_ProductForms ( FWindowsCode,FWindowsTitle,FWindowsFID,FDel,FVersion ) ';
  sqlLicenseProducts:=sqlLicenseProducts+ '  select F01,F04,F_ID ,0, '+quotedstr(GetSysVersion)+'from '+logininfo.SysDBPubName +'.dbo.T511 A';
  sqlLicenseProducts:=sqlLicenseProducts+ '  where isnull(A.F17,0)=0 and  isnull(A.FisSys,0)=0  and (A.F02=1 or A.F20=1) and A.F03=1  and A.F_ID not in (select FWindowsFID from '+ MainUserDB +'.dbo.Sys_ProductForms) order by f01';


  sqlSysProductDefine:='  insert into Sys_ProductForms ( FWindowsCode,FWindowsTitle,FWindowsFID,FDel,FVersion ,[FSystemProductCode])';
  sqlSysProductDefine:=sqlSysProductDefine+ '  select A.F01,A.F04,A.F_ID ,0,  '+quotedstr(GetSysVersion)+'  ,Prd.[FSystemProductCode] ';
  sqlSysProductDefine:=sqlSysProductDefine+ ' from '+logininfo.SysDBPubName +'.dbo.T511 A  ,[TSystemProduct] Prd            ';
  sqlSysProductDefine:=sqlSysProductDefine+ '   where Prd.FisLeaf=1 and isnull(A.F17,0)=0 and            ';
  sqlSysProductDefine:=sqlSysProductDefine+ '  isnull(A.FisSys,0)=0  and (A.F02=1 or A.F20=1) and A.F03=1  and A.F_ID not in (select FWindowsFID from Sys_ProductForms)   order by Prd.[FSystemProductCode],A.f01  ';

  try
    Screen.Cursor:=crHourGlass;
    qry:=TADOQuery.Create(nil);
    qry.Connection :=FhlKnl1.Connection ;
    qry.SQL.Add('--password');
    qry.SQL.Add(updatesql );
    qry.ExecSQL ;
    qry.SQL.Clear ;
    qry.SQL.Add(fsql );
    qry.ExecSQL ;

  

        qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add(sqlSysProductDefine);
    qry.ExecSQL ;



    qry.Close;
    qry.SQL.Clear;
    fsql:='update '+MainUserDB+'.dbo.TSysUMenuConfig set';
    fsql:= fsql+'	FParentCode	=((select top 1 Fcode from '+MainUserDB+'.dbo.TSysUMenuConfig   where Fcode <>M.FCode and  M.FCode like Fcode +''%'' order by Fcode desc )) ';
    fsql:= fsql+'	,FIsLeaf	=isnull( (select top 1 0            from '+MainUserDB+'.dbo.TSysUMenuConfig   where Fcode <>M.FCode and  Fcode  like M.FCode +''%'' order by Fcode desc ),1) ';
    fsql:= fsql+'  from '+MainUserDB+'.dbo.TSysUMenuConfig M '  ;
   qry.SQL.Add(fsql);
    qry.ExecSQL ;

  finally
    qry.Free ;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TTreeGridFrm.actExecProcExecute(Sender: TObject);
var
  fbk:TBookmark;
  i:integer;
begin
  try
    Screen.Cursor:=crHourGlass;

    fbk:=DBGRID1.DataSource.DataSet .GetBookmark;
    FhlUser.DoExecProc( DBGRID1.DataSource.DataSet , (AdoDataSet1).Parameters[0].Value );
    FhlKnl1.Ds_RefreshDataSet(DBGRID1.DataSource.DataSet );
    DBGRID1.DataSource.DataSet .GotoBookmark(fbk);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TTreeGridFrm.actBatchUpdateExecute(Sender: TObject);
var
  i: integer;  TempBookmark: TBookMark;          //multiselect
var GrpBatchUpdate:TGrpQueryRecord   ;
var labelV:TLabel;
begin

    if DBGRID1.DataSource.DataSet.IsEmpty then
    begin
        showmessage('请先选择记录');
        exit;
    end;
    labelV:=TLabel.Create(self);
    labelV.Caption :='字段值:';
    TabEditorFrm:=TTabEditorFrm.Create (nil);
    FhlKnl1.Pc_CreateTabSheet(TabEditorFrm.PageControl1);
    TabEditorFrm.CheckBox1.Visible :=false;
    TabEditorFrm.Caption :='批量修改';
    GrpBatchUpdate:=TGrpQueryRecord.create(self);
    labelV.Parent  := GrpBatchUpdate;
    GrpBatchUpdate.LabelName.Left :=30;

    GrpBatchUpdate.DragMode :=   dmManual;
    GrpBatchUpdate.Parent :=TabEditorFrm.PageControl1.ActivePage ;
    GrpBatchUpdate.Align :=alClient;
    GrpBatchUpdate.IniQuickQuery(DBGRID1,true) ;
    GrpBatchUpdate.LabelName.Caption  :='字段名:';
    GrpBatchUpdate.OptCombobox.Visible :=false;
    GrpBatchUpdate.ValGroupBox.Left :=GrpBatchUpdate.ComBoxFieldCname.Left ;

    GrpBatchUpdate.ValGroupBox.Top := GrpBatchUpdate.ComBoxFieldCname.Top +GrpBatchUpdate.ComBoxFieldCname.Height   +30;
    labelV.Left := GrpBatchUpdate.LabelName.Left ;
    labelV.Top :=  GrpBatchUpdate.ValGroupBox.Top+10;
    if  TabEditorFrm.ShowModal =mrok then
    begin
          GrpBatchUpdate.GetSqlCon ;

          DBGRID1.SelectedRows.CurrentRowSelected:=true;

          if self.DBGRID1.DataSource.DataSet.Active then
          with DBGRID1.SelectedRows do
              if Count <> 0 then
              begin
                  TempBookmark:= DBGRID1.Datasource.Dataset.GetBookmark;
                  if GrpBatchUpdate.fldName='' then
                  begin
                     showmessage('字段名不能为空！');
                      exit;

                  end;
                  for i:= 0 to Count - 1 do
                  begin
                    if IndexOf(Items[i]) > -1 then
                    begin
                       DBGRID1.Datasource.Dataset.Bookmark:= Items[i];

                       DBGRID1.DataSource.DataSet.Edit ;

                       if GrpBatchUpdate.fldval='' then
                          DBGRID1.DataSource.DataSet.FieldByName(GrpBatchUpdate.fldName ).Value :=null
                       else
                          DBGRID1.DataSource.DataSet.FieldByName(GrpBatchUpdate.fldName ).Value :=GrpBatchUpdate.fldval ;
                       DBGRID1.DataSource.DataSet.Post ;
                    end;
                  end;
             end;
          DBGRID1.Datasource.Dataset.GotoBookmark(TempBookmark);
          DBGRID1.Datasource.Dataset.FreeBookmark(TempBookmark);
    end;
    TabEditorFrm.Free;

end;


end.
