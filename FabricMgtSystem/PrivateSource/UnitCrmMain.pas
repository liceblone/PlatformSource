unit UnitCrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, Grids, DBGrids, Buttons, DB, ADODB,
  StdCtrls,FhlKnl, ActnList,UnitGrid,Editor, Menus,StrUtils,UnitAdoDataset,
  XPMenu, OleCtrls, SHDocVw, Mask,UnitModelFrm,UPublicFunction;

type TdbgridEx=class(Tdbgrid)
end;

type
  TFrmCrm = class(TFrmModel)
    splTreeLeft: TSplitter;
    pgcTree: TPageControl;
    actlstCRM: TActionList;
    ctrlbr1: TControlBar;
    toolbar: TToolBar;
    btnexit: TToolButton;
    btnReflash: TToolButton;
    btnTreeVisiable: TToolButton;
    tlbMain: TToolBar;
    actEditMain: TAction;
    btnQryScrollVisiable: TToolButton;
    btnSubVisiable: TToolButton;
    Filter: TAction;
    FavoriteM: TAction;
    FavoriteMgr: TAction;
    FavoriteContentMgr: TAction;
    PnlRight: TPanel;
    MtPnl: TPanel;
    MtScrollBox: TScrollBox;
    btnOpen: TSpeedButton;
    Label1: TLabel;
    pnlMainGrid: TPanel;
    pgcSubInterface: TPageControl;
    ScrollBoxDbCtrl: TScrollBox;
    pgcMainGrid: TPageControl;
    PnlItem: TPanel;
    BatchUpdate: TAction;
    Splitter1: TSplitter;
    XPMenu1: TXPMenu;
    PnLLeft: TPanel;
    Panel1: TPanel;
    ActHelp: TAction;
    ToolButton1: TToolButton;
    Action1: TAction;
    DeleteAction1: TAction;
    ActLinkBill: TAction;
    LblTitle: TLabel;
    ToolButton2: TToolButton;
    ActExportExcel: TAction;
    ActProperty: TAction;
    actSum: TAction;
    BtnSum: TToolButton;
    actprint: TAction;
    btnCtrl: TToolButton;
    actChk: TAction;
    procedure InitFrm(formid:string);
    procedure IniMain;
    procedure IniTree(Pdict:TCRMDict)  ;
    procedure IniSubInterface;
    procedure IniTreePgcPopupMenu;
    procedure IniSubInterfacePgcPopupMenu;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TreeClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);

    procedure MainDataSetAfterScroll(dataset:Tdataset);//maindataset AfterScroll
    procedure MainDataSetAfterOpen(dataset:Tdataset);//maindataset AfterScroll
    procedure MtScrollBoxDblClick(Sender: TObject);
    procedure btnTreeVisiableClick(Sender: TObject);
    procedure btnexitClick(Sender: TObject);
    procedure actEditMainExecute(Sender: TObject);
    procedure btnReflashClick(Sender: TObject);
    procedure btnQryScrollVisiableClick(Sender: TObject);
    procedure btnSubVisiableClick(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure FilterExecute(Sender: TObject);
    procedure FavoriteMExecute(Sender: TObject);
    procedure FavoriteMgrExecute(Sender: TObject);
    procedure FavoriteContentMgrExecute(Sender: TObject);
    procedure BatchUpdateExecute(Sender: TObject);
    procedure pgcTreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pgcTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure pgcSubInterfaceDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure pgcSubInterfaceDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure ActProjTeamExecute(Sender: TObject);
    procedure ActChkExecute(Sender: TObject);
    procedure ActUpdateProductCostExecute(Sender: TObject);
    procedure ActLinkBillExecute(Sender: TObject);
    procedure pgcSubInterfaceChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure ActExportExcelExecute(Sender: TObject);
    procedure ActPropertyExecute(Sender: TObject);
    procedure actSumExecute(Sender: TObject);
    procedure actprintExecute(Sender: TObject);
    procedure btnCtrlClick(Sender: TObject);

  private

    { Private declarations }
  public
    { Public declarations }
    PAuthoriseTmpTable:string;
    CurrentMainGridID:string;

    Mtdataset   :TAdoDataset;
    Mtdatasource:TdataSource;

    MainDBGrid:TModelDbGrid;
    MainGridPopupMenu:TPopupMenu;
    MainTreeGridEditorFrm:   TEditorFrm;
    MainDataSource:Tdatasource;
    Maindataset:TAdoDatasetColor;

    MainTreeGridDict:TTreeGridDict;
    fDict: TCRMDict;    //crmMainDict

    MainEditor:Tform;//服务
//   SubInterFaceTab: array of TModelAbstractSheet;
  end;

var
  FrmCrm: TFrmCrm;

implementation

{$R *.dfm}
uses datamodule,UnitCreateComponent,UPublicCtrl,TreeEditor,
     TreeDlg,   UnitActionsGrid,TreeGrid,UnitBillEx,UnitFrmAnalyserEx,UnitMulPrintModule ,UnitCtrlConfig ;

procedure TFrmCrm.InitFrm(formid: string);
begin
//iniTree();
//iniMainGrid or MainEditor
//iniSubInterface

  if not   fhlknl1.Cf_GetDict_CrmModel (Formid,fDict)     then
  exit;
  LblTitle.Caption :=self.Caption ;
 // self.Caption :=fDict.FormCaption ;
  if (fDict.MainActions  <>'' ) and (fDict.MainActions <>'-1' )  then           //initoolbar
  begin 
      FhlKnl1.Tb_CreateActionBtns_Ex(self.tlbMain,self.actlstCRM,fDict.MainActions ,logininfo.EmpId ,self.FWindowsFID );  //buttons   like billex
     // FhlKnl1.Act_ConfigRight (actlstCRM,logininfo);                //config
  end;

  IniMain;
  IniTree (fDict)  ;
  IniSubInterface;
  IniTreePgcPopupMenu;
  IniSubInterfacePgcPopupMenu;

  //  self.mt.Open;
if     MainTreeGridDict.IsOpen then 
  btnOpenClick(self.btnOpen );
end;

procedure TFrmCrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (PAuthoriseTmpTable<>'') and (PAuthoriseTmpTable<>'-1') then
  fhlknl1.Kl_GetQuery2('drop table '+ PAuthoriseTmpTable  ,false );
  Action:=caFree;
end;

procedure TFrmCrm.FormCreate(Sender: TObject);
begin
  btnCtrl.Visible     :=logininfo.Sys ;
 //if treeids <>'' then   ini  Trees
//if mainGridid <>'' then  Create DbCtrl   and    ini dsParam   (ParamDatasetId)
//
end;

procedure TFrmCrm.TreeClick(Sender: TObject);
begin
//if currentGrid<>sender.tag then  Gridid=sender.tag
//ini MainGrid (currentGrid)  and open

end;

procedure TFrmCrm.btnOpenClick(Sender: TObject);
var fParams:variant;
     i:integer;
begin
  if Mtdataset<>nil then
  begin
      with self.Mtdataset  do
      begin
          if (State=dsInsert) or (State=dsEdit) then  //update parameter getvalue
          begin
            UpdateRecord;
            Post;
          end;
      end;                                  

      fParams:=FhlKnl1.Ds_GetFieldsValue(self.Mtdataset ,fDict.MtParameters ,true);

     if self.MainDBGrid <>nil then
      begin
           if Not VarIsNull(fParams) then    //主界面打界面先运行。 FhlUser.SetDbGridAndDataSet (self.MainDBGrid,self.MainTreeGridDict.DbGridId ,fParams, true,dmfrm.DbGridEditBtnClickAction1 );
           begin
                 FhlUser.SetDbGridAndDataSet (self.MainDBGrid,self.MainTreeGridDict.DbGridId ,fParams, true,dmfrm.DbGridEditBtnClickAction1 );
                 fhlknl1.Cf_DeleteDbGridUnAuthorizeCol(MainTreeGridDict.DbGridId,MainDBGrid,logininfo.EmpId ,self.FWindowsFID,logininfo.SysDBPubName) ;
                 FhlKnl1.SetColFormat(MainDBGrid );
           end;
     end
     else
     FhlUser.SetDataSet(self.Maindataset,inttostr(self.Maindataset.Tag ),fParams)    ;

     if Maindataset.IsEmpty then
     for i:=0 to self.pgcSubInterface.PageCount -1 do
     begin
         // ModelTreeGridsheet(self.pgcSubInterface.Pages [i]).
     end;

 end;


end;

procedure TFrmCrm.IniTree(Pdict: TCRMDict);
var i:integer;
var TreeTab:array of TmodelTreeSheet;

var treeview:array of  ModelTreeView;


var treeNodeDataset :array of Tadodataset;
begin
      setlength(TreeTab,pdict.CrmTreeCount );
      setlength(treeview,pdict.CrmTreeCount );

      self.pgcTree.Tag := strtoint(Pdict.CrmTreeIDs);
      for i:=0 to     Pdict.CrmTreeCount- 1 do
      begin
          TreeTab[i]:=TmodelTreeSheet.Create(self);
          TreeTab[i].ToolID :='59';
          TreeTab[i].LoginInfo :=LoginInfo;
          TreeTab[i].PageControl:=self.pgcTree;
          TreeTab[i].Caption :=pdict.CrmTree[i].Name ;
          TreeTab[i].SetFhlknl(fhlknl1);
          TreeTab[i].SetTreeID(  inttostr( pdict.CrmTree[i].treeID ));

          TreeTab[i].SetEditorParent(self.MtScrollBox);

          TreeTab[i].SetFDBGrid(self.MainDBGrid );
          TreeTab[i].setTreeGridIdField('TreeGridID');
          TreeTab[i].setEditorIDField('EditorID');
          TreeTab[i].SetFSubInterFaceID(pdict.CrmTree[i].SubInterFaceID );
          TreeTab[i].SetFhlUser(FhlUser)    ;
          TreeTab[i].SetActionList(dmfrm.DataSetActionList1 ) ;
          TreeTab[i].SetUserConnection(dmfrm.ADOConnection1 );
          TreeTab[i].SetGridEditBtnClick(dmfrm.DbGridEditBtnClickAction1 );

          TreeTab[i].TreeView.Images  :=dmfrm.ImageList1 ;
          TreeTab[i].TreeView.IniTree ;
          if TreeTab[i].TreeView.tag=0 then
             TreeTab[i].Free ;

      end;
end;

procedure TFrmCrm.IniMain;
var MainEditTab:TTAbsheet;

var i,j,UserMenuCont:integer;
var GridMenuItem: array of TMenuItem;
var sql:string;

var ModelDbGridPopupMenu  :TPopupMenu;
begin
      UserMenuCont:=0;
 //ini Main tree grid    ini MainGridPopupMenu
 // ini main editor
 //  ini mt dataset    mtparams   ini mtctrl
 //MainTreeGridID id valid

      if (fdict.MainTreeGridID <>'' ) and (fdict.MainTreeGridID<>'-1') then
      begin
    //      lblFormName.Caption :=fdict.FormCaption  ;
          MainDataSource:=Tdatasource.Create (self);
          Maindataset:=TadodatasetColor.Create (self);
          MainDataSource.DataSet := Maindataset;
          Maindataset.Connection :=dmfrm.ADOConnection1 ;        //ini maindataset
              
          self.MainDBGrid :=TModelDbGrid.Create(self);
          
          MainDBGrid.setfhlknl(fhlknl1);
          MainDBGrid.OnDblClick:=self.actEditMain.OnExecute ;    //dbclick
          MainDBGrid.Color1 :=clwhite;
          MainDBGrid.Color2 :=clCream;
          MainDBGrid.SetLoginInfo(logininfo);
                                                              //ini GridMenu
          ModelDbGridPopupMenu  :=TPopupMenu.Create ( self);
          ModelDbGridPopupMenu.OnPopup :=dmfrm.DbGridPopupMenu1Popup ;
          fhluser.MergeGridUserMenuAndSysCongfigMenu(ModelDbGridPopupMenu,dmfrm.DbGridPopupMenu1,self.fDict.MainGridUserMenuIDs ,self.actlstCRM  );
          MainDBGrid.SetPopupMenu ( ModelDbGridPopupMenu);

          MainDBGrid.Parent :=self.pgcMainGrid ;
          MainDBGrid.Align :=alClient;

          MainDBGrid.DataSource := MainDataSource;
          fhlknl1.Kl_GetQuery2('select * from T612 where f01='+quotedstr(self.fDict.MainTreeGridID ));
          MainTreeGridDict.DbGridId :=fhlknl1.FreeQuery.fieldbyname('f04').AsString ;
          MainTreeGridDict.EditorId :=fhlknl1.FreeQuery.fieldbyname('f05').AsString ;
          fhlknl1.Kl_GetQuery2('select * from T504 where f01='+quotedstr(MainTreeGridDict.DbGridId  ));
          MainTreeGridDict.ParamFLDs :=fhlknl1.FreeQuery.fieldbyname('f16').AsString ;

          FhlUser.SetDbGridAndDataSet (self.MainDBGrid,MainTreeGridDict.DbGridId,null, false );//
          fhlknl1.Cf_DeleteDbGridUnAuthorizeCol(MainTreeGridDict.DbGridId,MainDBGrid,logininfo.EmpId ,self.FWindowsFID,logininfo.SysDBPubName) ;
          FhlKnl1.SetColFormat(MainDBGrid );
      end;

         // Maindataset.AfterOpen   :=self.MainDataSetAfterScroll ;

      //editorid  id valid
       if (fdict.MainEditorID  <>-1 )  then
      begin
           MainEditTab:=TTAbsheet.Create (pgcMainGrid);
           MainEditTab.PageControl :=pgcMainGrid;
           pgcTree.Visible :=false;
           self.MainEditor := FhlUser.ShowEditorFrm(  inttostr(FDict.MainEditorID ) ,null,nil,MainEditTab)   ;
           MainDataSource:= TEditorFrm( MainEditor).DataSource1 ;
           TADODataSet (Maindataset)   := TEditorFrm( MainEditor).ADODataSet1 ;

           MainEditTab.Font.Size :=8;
           TEditorFrm( MainEditor).ExtBtn.Visible :=false;
           pgcMainGrid.Height :=MainEditor.Height ;
           self.btnTreeVisiable.Visible :=false;
           MainEditor.Align :=alClient;
           MainEditor.Dock (  MainEditTab,MainEditor.ClientRect );
           MainEditor.Show;
           FhlUser.SetDataSet(self.Maindataset,inttostr(self.Maindataset.Tag ),null)    ;
      end;
      Maindataset.AfterScroll :=self.MainDataSetAfterScroll ;       //link main and item
      Maindataset.AfterOpen :=  self.MainDataSetAfterOpen;
      if (fdict.MtDatasetID  <>'' ) and (fdict.MtDatasetID  <>'-1') then
      begin
          Mtdataset   :=TAdoDataset.Create (self);
          Mtdatasource:=TdataSource.Create (self);
          Mtdataset.Connection :=dmfrm.ADOConnection1 ;
          Mtdatasource.DataSet :=Mtdataset;
          FhlUser.SetDataSet(Mtdataset,fDict.MtDatasetID ,null );

          if Mtdataset.Active then
          begin
              FhlUser.AssignDefault(Mtdataset);
              if Mtdataset.IsEmpty then
              begin
                  Mtdataset.Append;
              end;
          end;

          if (fdict.MtBoxID  <>'' ) and (fdict.MtBoxID <>'-1') then
          begin
                FhlKnl1.Cf_SetBox(fDict.MtBoxID,Mtdatasource,MtScrollBox,dmFrm.UserDbCtrlActLst);
          end;
      end
      else
      begin
          btnOpen.Visible :=false;
          btnQryScrollVisiable.Visible :=false;
      end;
end;

procedure TFrmCrm.MtScrollBoxDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;

  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;


    if assigned(Mtdataset) then
    begin
    CrtCom.mtDataSet1:= self.Mtdataset ;
    CrtCom.mtDataSetId :=inttostr(self.Mtdataset.tag);
    end;
    CrtCom.TopOrBtm :=true;
    CrtCom.TOPBoxId  :=self.fDict.MtBoxID ;
    if self.MainDBGrid <>nil then
    CrtCom.DlGridId :=inttostr(self.MainDBGrid .Tag );

        try
    CrtCom.Show;
finally

end;
  end;


end;
procedure TFrmCrm.btnTreeVisiableClick(Sender: TObject);
begin
PnLLeft.Visible :=btnTreeVisiable.Down ;
end;

procedure TFrmCrm.btnexitClick(Sender: TObject);
begin
 close;
end;

procedure TFrmCrm.actEditMainExecute(Sender: TObject);
begin
        if not MainDBGrid.DataSource.DataSet.Active then
        begin
          showmessage('请先点查询，或点左边树节点!');
          Exit;
        end;

        if self.Maindataset.IsEmpty then
        begin
          //  showmessage('请选择记录再编辑');
          //  exit;
        end;
        if MainTreeGridEditorFrm=nil then
        begin
           if self.MainTreeGridDict.EditorId <>'' then
           MainTreeGridEditorFrm:=TEditorFrm(FhlUser.ShowEditorFrm(self.MainTreeGridDict.EditorId ,null,self.Maindataset,self,self.MainDBGrid  ))
           else
           showmessage ('self.MainTreeGridDict.EditorId ');
        end ;
        MainTreeGridEditorFrm.MainEditor:=true;

        if self.fDict.IsTreeGridEditorDock then
        begin
            MainTreeGridEditorFrm.Align  :=altop;
            if PnlItem.Visible then
            MainTreeGridEditorFrm.Dock (  ScrollBoxDbCtrl,MainTreeGridEditorFrm.ClientRect );
            MainTreeGridEditorFrm.Show;
        end
        else
        begin
           if PnlItem.Visible then
           begin
               self.pgcSubInterface.Dock(MainTreeGridEditorFrm.PnlItem ,pgcSubInterface.ClientRect );
               MainTreeGridEditorFrm.BorderStyle :=    bsSizeable;
               MainTreeGridEditorFrm.Height :=MainTreeGridEditorFrm.fDict.Height  +200;
               MainTreeGridEditorFrm.PnlItem.Height  := 200 ;
               MainTreeGridEditorFrm.Splitter1.Enabled :=true;
           end;
           if MainTreeGridEditorFrm.fDict.BoxIds<>'' then
             if MainTreeGridEditorFrm.fDict.BoxIds<>'-1' then
             begin
                MainTreeGridEditorFrm.ShowModal ;
             end;

             pgcSubInterface.Dock(self.PnlItem  ,pgcSubInterface.ClientRect );
             FreeAndNil(MainTreeGridEditorFrm);
        end;


end;

procedure TFrmCrm.btnReflashClick(Sender: TObject);
var i:integer;
begin
    for i:=0 to pgcTree.PageCount  -1 do
    begin
        pgcTree.Pages[i].Free ;
    end;
    IniTree(self.fDict )  ;
    self.Refresh ;
end;

procedure TFrmCrm.IniSubInterface;
var i:integer;
var   TreeGridDict:  TTreeGridDict;
var   EditorDict  :TEditorDict;
var   SubInterFaceTab: array of TModelAbstractSheet ;
var   LstInvalidSubTabs:Tstrings;
begin
// create tabs
//open dataset
      LstInvalidSubTabs:=fhlknl1.Cf_GetUnAuthorizedCrmTabs(self.fDict.SubinterFaceID,logininfo.EmpId ,self.FWindowsFID ,logininfo.SysDBPubName) ;

      setlength(SubInterFaceTab,self.fDict.SubInterFaceCount )  ;
      self.pgcSubInterface.Tag  :=strtoint(self.fDict.SubinterFaceID );

      if  self.fDict.SubInterFaceCount=0 then
      begin
          self.btnTreeVisiable.Visible :=false;
          PnlItem.Visible :=false;
      end;
      for i:=0 to self.fDict.SubInterFaceCount  -1 do
      begin
            if LstInvalidSubTabs.IndexOf( fDict.SubInterFace [i].id )>-1 then continue;
             case    self.fDict.SubInterFace [i].ModeltypeID of
               0:
               begin
                     if Not FhlKnl1.Cf_GetDict_TreeGrid(self.fDict.SubInterFace [i].TreeGridID ,TreeGridDict) then
                     begin
                      showmessage('SubInterFace treegrid'+inttostr(i)+'treeGridID 无效');
                      exit;
                     end
                     else
                     begin
                       SubInterFaceTab[i]:= ModelTreeGridsheet.Create(self  );
                       SubInterFaceTab[i].PageControl :=self.pgcSubInterface ;
                       SubInterFaceTab[i].setUserConnection(dmfrm.ADOConnection1 );
                       SubInterFaceTab[i].SetGridEditBtnClick(dmfrm.DbGridEditBtnClickAction1 );
                       SubInterFaceTab[i].SetFhlknl(fhlknl1);
                       SubInterFaceTab[i].SetFhlUser(Fhluser);
                       SubInterFaceTab[i].setActionLst(self.actlstCRM );
                       ModelTreeGridsheet(SubInterFaceTab[i]).SetDict(TreeGridDict);
                       SubInterFaceTab[i].SetLoginInfo(logininfo);
                       SubInterFaceTab[i].IniSheet ;
                       SubInterFaceTab[i].setFMainDataset(self.Maindataset );
                       SubInterFaceTab[i].SetPopupMenu (dmfrm.DbGridPopupMenu1 );
                       SubInterFaceTab[i].SetImageList(dmfrm.ImageList1 );
                       SubInterFaceTab[i].WindowsFID :=self.FWindowsFID  ;

                       SubInterFaceTab[i].OpenDataSet ;

                     end;
               end;
               1:
               begin
                      if Not FhlKnl1.Cf_GetDict_Editor(self.fDict.SubInterFace [i].EditorID ,EditorDict)  then
                     begin
                      showmessage('SubInterFace Ediotr '+inttostr(i)+'EditorId 无效');
                      exit;
                     end
                     else
                     begin
                          SubInterFaceTab[i] :=ModelEditorsheet.Create (self.pgcSubInterface );
                          SubInterFaceTab[i].PageControl :=self.pgcSubInterface ;
                          SubInterFaceTab[i].SetFhlknl(fhlknl1);
                          SubInterFaceTab[i].SetFhlUser(fhluser);
                          SubInterFaceTab[i].SetFmainDataset(self.Maindataset );
                          ModelEditorsheet(SubInterFaceTab[i]).SetDict(EditorDict);
                          SubInterFaceTab[i].OpenDataSet ;
                     end;

               end;

             end;
      end;

end;


procedure TFrmCrm.MainDataSetAfterOpen(dataset: Tdataset);
var i:integer;
begin
    if dataset.IsEmpty then
    begin
        for i:=0 to self.pgcSubInterface.PageCount -1 do
        begin
             TModelAbstractSheet(pgcSubInterface.Pages [i]).CloseDataSet  ;
        end;
    end;

end;

procedure TFrmCrm.MainDataSetAfterScroll(dataset:Tdataset);
var i:integer;
begin
        Label1.Caption  :='   '+intTostr(MainDataSet.RecNo)+'/'+intTostr(MainDataSet.RecordCount);
    //    for i:=0 to self.pgcSubInterface.PageCount -1 do
    //    begin
             if pgcSubInterface.ActivePage<>nil then
             TModelAbstractSheet(pgcSubInterface.ActivePage  ).OpenDataSet ;
     //   end;
end;

procedure TFrmCrm.btnQryScrollVisiableClick(Sender: TObject);
begin
MtPnl.Visible :=btnQryScrollVisiable.Down ;
if  (not  pgcSubInterface.Visible )then
begin
  if    (  not MtScrollBox.Visible)  then
  pgcMainGrid.Height :=self.ClientHeight -self.tlbMain.Height -12
  else
  pgcMainGrid.Height :=self.ClientHeight -self.MtScrollBox.Height -  tlbMain.Height -16;
end;

end;

procedure TFrmCrm.btnSubVisiableClick(Sender: TObject);
begin
PnlItem.Visible :=  btnSubVisiable.Down ;
//if not  pgcSubInterface.Visible then   pgcMainGrid.Height :=self.ClientHeight -self.tlbMain.Height -self.MtScrollBox.Height -10 else  pgcMainGrid.Height :=220;
end;

procedure TFrmCrm.actFilterExecute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(self.Maindataset );
end;

procedure TFrmCrm.IniTreePgcPopupMenu;
var     fieldname,sql:string;

var TreePgcMenu:Tpopupmenu;
var ConfigTrees:Tmenuitem;
begin
    if  (logininfo.Sys ) then
    begin
        TreePgcMenu:=Tpopupmenu.Create (self);
        ConfigTrees:=Tmenuitem.Create (TreePgcMenu)  ;
        ConfigTrees.Caption :='ConfigTrees';
        ConfigTrees.OnClick :=dmfrm.actCRMTreeIDSGrid.OnExecute     ;//(Sender);
        TreePgcMenu.Items.Add(ConfigTrees);
        self.pgcTree.PopupMenu := TreePgcMenu;
    end;

end;

procedure TFrmCrm.IniSubInterfacePgcPopupMenu;
var SubInterfacePgc:Tpopupmenu;
var ConfigSubInterface:Tmenuitem;
begin
    if  (logininfo.Sys ) then
    begin
        SubInterfacePgc:=Tpopupmenu.Create (self);
        ConfigSubInterface:=Tmenuitem.Create (SubInterfacePgc)  ;
        ConfigSubInterface.Caption :='ConfigSubInterface';
        ConfigSubInterface.OnClick :=dmfrm.actCRMSubInterFace.OnExecute     ;//(Sender);
        SubInterfacePgc.Items.Add(ConfigSubInterface);
        self.pgcSubInterface.PopupMenu := SubInterfacePgc;
    end;

end;

procedure TFrmCrm.FilterExecute(Sender: TObject);
var PopDbgrid:Tdbgrid;

begin
   
        FhlKnl1.Ds_Filter(self.Maindataset,self.MainDBGrid);       //-

      if sender is Tmenuitem then
      begin
        PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
        FhlKnl1.Ds_Filter(PopDbgrid.DataSource.DataSet );       //-
      end;
end;

procedure TFrmCrm.FavoriteMExecute(Sender: TObject);
var
  TreeDlgFrm: TTreeDlgFrm;
var
  i,F_MID: integer;
  TempBookmark: TBookMark;
begin

         if not self.Maindataset.IsEmpty then
         begin
               TreeDlgFrm:= TTreeDlgFrm.Create (nil);
               TreeDlgFrm.InitFrm('931',null,true,'F_code','F_Name',false);
               TreeDlgFrm.Caption :='添加到收藏夹';
               if TreeDlgFrm.ShowModal =mrok then
               begin
                    F_MID:=TreeDlgFrm.ADODataSet1.fieldbyname('F_ID').AsInteger ;
                    dmfrm.GetQuery1('select top 0 * from T_favoriteDL');

                    if   dgMultiselect in self.MainDBGrid.Options then      //2006-7-26加入多先功能
                    begin
                             MainDBGrid.SelectedRows.CurrentRowSelected:=true;
                              if Maindataset.Active then
                              with MainDBGrid.SelectedRows do
                                  if Count <> 0 then
                                  begin
                                      TempBookmark:= Maindataset.GetBookmark;
                                      for i:= 0 to Count - 1 do
                                      begin
                                        if IndexOf(Items[i]) > -1 then
                                        begin
                                          Maindataset.Bookmark:= Items[i];

                                          dmfrm.FreeQuery1.Append ;
                                          dmfrm.FreeQuery1.FieldByName('F_MID').AsInteger :=F_MID;
                                          dmfrm.FreeQuery1.FieldByName('F_Code').AsString :=Maindataset.FieldByName ('F_CltCode').AsString ;
                                          dmfrm.FreeQuery1.Post ;
//                                               Amt:=Amt+self.dlAdoDataSet1.fieldbyname('Amt').AsCurrency;
                                        end;
                                      end;
                                  end;
                              Maindataset.GotoBookmark(TempBookmark);
                              Maindataset.FreeBookmark(TempBookmark);
                    end;

               end;
               TreeDlgFrm.Free ;
         end
         else
         showmessage('请选择客户再收藏 ');

end;

procedure TFrmCrm.FavoriteMgrExecute(Sender: TObject);
var FrmFavorite:Tform;
var i:integer;
var BtnConFirm,BtnCanCel:Tbutton;
begin

         FrmFavorite:= FhlUser.ShowModelTreeEditorFrm('26',null,true);
         FrmFavorite.Position :=poScreenCenter;
         FrmFavorite.BorderStyle :=  bsDialog;
         TTreeEditorFrm(FrmFavorite).prtBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).preBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).expBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).btnSubAdd.Visible :=false;
         TTreeEditorFrm(FrmFavorite).hlpBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).TreeView1.Width:= 160;
         FrmFavorite.Width :=440;
         FrmFavorite.Caption :='收藏管理';
         FrmFavorite.ShowModal  ;
         begin
             for i:=0 to self.pgcTree.PageCount -1 do
                self.pgcTree.Pages[0].Free ;
             self.IniTree(self.fDict );
         end;
         FrmFavorite.Free;


end;

procedure TFrmCrm.FavoriteContentMgrExecute(Sender: TObject);
var FrmFavConMgr: Tform;
begin
   FrmFavConMgr:=  fhluser.ShowModalTreeGridFrm('54',null,true);
   FrmFavConMgr.Caption :='收藏夹清理';
   TTreeGridFrm(FrmFavConMgr).myBar1.Buttons[0].Caption :='移出';
   TTreeGridFrm(FrmFavConMgr).DeleteAction1.Caption  :='移出';
   FrmFavConMgr.ShowModal ;
end;

procedure TFrmCrm.BatchUpdateExecute(Sender: TObject);
var
  i: integer;
  TempBookmark: TBookMark;          //multiselect

var GrpBatchUpdate:TGrpQueryRecord   ;
var labelV:TLabel;
begin
{
    if self.Maindataset.IsEmpty then
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
    GrpBatchUpdate.IniQuickQuery(self.MainDBGrid ,true) ;
    GrpBatchUpdate.LabelName.Caption  :='字段名:';
    GrpBatchUpdate.OptCombobox.Visible :=false;
    GrpBatchUpdate.ValGroupBox.Left :=GrpBatchUpdate.ComBoxFieldCname.Left ;

    GrpBatchUpdate.ValGroupBox.Top := GrpBatchUpdate.ComBoxFieldCname.Top +GrpBatchUpdate.ComBoxFieldCname.Height   +30;
    labelV.Left := GrpBatchUpdate.LabelName.Left ;
    labelV.Top :=  GrpBatchUpdate.ValGroupBox.Top+10;
    if  TabEditorFrm.ShowModal =mrok then
    begin
         GrpBatchUpdate.GetSqlCon ;

          MainDBGrid.SelectedRows.CurrentRowSelected:=true;

          if self.MainDBGrid.DataSource.DataSet.Active then
          with MainDBGrid.SelectedRows do
              if Count <> 0 then
              begin
                  TempBookmark:= MainDBGrid.Datasource.Dataset.GetBookmark;
                  if GrpBatchUpdate.fldName='' then
                  begin
                     showmessage('字段名不能为空！');
                      exit;

                  end;
                  for i:= 0 to Count - 1 do
                  begin
                    if IndexOf(Items[i]) > -1 then
                    begin
                       MainDBGrid.Datasource.Dataset.Bookmark:= Items[i];



                       MainDBGrid.DataSource.DataSet.Edit ;

                       if GrpBatchUpdate.fldval='' then
                          MainDBGrid.DataSource.DataSet.FieldByName(GrpBatchUpdate.fldName ).Value :=null
                       else
                          MainDBGrid.DataSource.DataSet.FieldByName(GrpBatchUpdate.fldName ).Value :=GrpBatchUpdate.fldval ;
                       MainDBGrid.DataSource.DataSet.Post ;
                    end;
                  end;
             end;

          MainDBGrid.Datasource.Dataset.GotoBookmark(TempBookmark);
          MainDBGrid.Datasource.Dataset.FreeBookmark(TempBookmark);

    end;
    TabEditorFrm.Free;
        }
end;

procedure TFrmCrm.pgcTreeDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
if source is Tdbgrid then
   Accept:=true;

end;

procedure TFrmCrm.pgcTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var MainTable,ForeignTable,foreignTableCname:string;
Var MainField ,ForeignField:string;
var ForeignNameField:string;

var TreeDataserID,GridID,TreeGridID,SubInterFaceID:string;
begin
       if not logininfo.Sys then exit;

        self.Caption :=inttostr(pgcTree.Tag );
        MainField:= TdbgridEx(Source).Columns [TdbgridEx(  Source).col-1].FieldName;

        
        MainTable:=fhluser.GetTableName(inttostr(self.Maindataset.Tag ));

        if  MainTable<>'' then
        begin
              fhlknl1.Kl_GetQuery2('select *From '  +logininfo.SysDBPubName+'.dbo.TFkReference  where  TableEname='+quotedstr(MainTable)+' and FieldEName='+quotedstr(MainField));
              if not fhlknl1.FreeQuery.IsEmpty then
                 ForeignTable:=fhlknl1.FreeQuery.fieldbyname('ReferenceOnTable').AsString ;
                 ForeignField:=fhlknl1.FreeQuery.fieldbyname('ReferenceOnField').AsString ;

              if  ForeignTable<>'' then
              begin
                  fhlknl1.Kl_GetQuery2('select CodeField,NameField,TableCname From ' +logininfo.SysDBPubName+'.dbo.Tallusertable where TableEName='+quotedstr(ForeignTable));
                  if not fhlknl1.FreeQuery.IsEmpty then
                     ForeignNameField:=fhlknl1.FreeQuery.fieldbyname('NameField').AsString ;
                     foreignTableCname:=fhlknl1.FreeQuery.fieldbyname('TableCname').AsString ;
              end
              else
              exit;


              TreeDataserID:=fhlUser.AddDataSet('Crm '+foreignTableCname+'选择',ForeignTable,'select *from '+ForeignTable);
              SubInterFaceID:=fhlknl1.GetMaxCode ('T701','SubInterfaceID');//sub inter fave id

              fhlknl1.Kl_GetQuery2('select top 0 * from T703 ',true,true);
              fhlknl1.FreeQuery.Append ;
              fhlknl1.FreeQuery.FieldByName('f02').Value :='CRM '+ foreignTableCname+' 选择';

              fhlknl1.FreeQuery.FieldByName('f05').Value :='全部';
              fhlknl1.FreeQuery.FieldByName('f06').Value :=6;
              fhlknl1.FreeQuery.FieldByName('f07').Value :=TreeDataserID;

              fhlknl1.FreeQuery.FieldByName('f08').Value :=ForeignNameField;
              fhlknl1.FreeQuery.FieldByName('f09').Value :=ForeignField ;

              fhlknl1.FreeQuery.FieldByName('f10').Value :=200;
              fhlknl1.FreeQuery.FieldByName('f11').Value :=self.pgcTree.Tag ;

                           fhlknl1.FreeQuery.FieldByName('f12').Value := SubInterFaceID;
              fhlknl1.FreeQuery.FieldByName('f13').Value :=true;
              fhlknl1.FreeQuery.FieldByName('f14').Value :=10;
              fhlknl1.FreeQuery.Post ;

              TreeDataserID:=fhlUser.AddDataSet('Crm '+foreignTableCname+'选择',MainTable,'select *from '+MainTable+' where '+ForeignField+' like :'+ForeignField);
              GridID       :=fhlUser.AddGrid  ('Crm '+foreignTableCname+'选择',TreeDataserID);
              TreeGridID   :=fhlUser.AddTreeGrid('Crm '+foreignTableCname+'选择',GridID,'-1','-1',-1);
              fhlUser.AddSubInterFace('Crm '+foreignTableCname+'选择',SubInterFaceID,'0',TreeGridID,'');

              showmessage( MainField+' '+MainTable+' '+ForeignTable+' '+ForeignField+' '+ForeignNameField+' '+foreignTableCname);
        end
        else
        exit;


end;

procedure TFrmCrm.pgcSubInterfaceDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var MainField,MainTable:string;
var SubTableEName,SubFieldEName,SubTableCName:string;
var SubDataSetID,SubGridID,SubTreeGridID:string;
var FrmActions:TFrmActions;

var sql:string;
begin
     if not logininfo.Sys then exit;

      MainField:= TdbgridEx(Source).Columns [TdbgridEx(  Source).col-1].FieldName;
      MainTable:=fhluser.GetTableName(inttostr(self.Maindataset.Tag ));

      if  MainTable<>'' then
      begin
            sql:='select A.TableEname,A.FieldEname,B.TableCname      '
                +'From ' +logininfo.SysDBPubName+'.dbo.TFkReference  A    '
                +'join ' +logininfo.SysDBPubName+'.dbo.Tallusertable B on A.TableEname=B.TableEname  '
                +'where ReferenceOnTable='+quotedstr(trim(MainTable))+' and ReferenceOnField='+quotedstr(trim(MainField));

            fhlknl1.Kl_GetQuery2(sql);
            
            if not fhlknl1.FreeQuery.IsEmpty then
            begin
                 FrmActions:=TFrmActions.Create(self);
                 FrmActions.ActionGrid.RowCount:= fhlknl1.FreeQuery.RecordCount ;
                 while(not fhlknl1.FreeQuery.Eof ) do
                 begin
                      FrmActions.ActionGrid.Cols[0].Append (fhlknl1.FreeQuery.fieldbyname('TableEname').AsString);
                      FrmActions.ActionGrid.Cols[1].Append(fhlknl1.FreeQuery.fieldbyname('TableCname').AsString);
                      FrmActions.ActionGrid.Cols[4].Append(fhlknl1.FreeQuery.fieldbyname('FieldEname').AsString);

                      fhlknl1.FreeQuery.Next ;
                 end;   {}
                 fhlknl1.FreeQuery.Close ;

                 if FrmActions.ShowModal =mrok then
                 begin
                       SubTableEName:=FrmActions.ActionGrid.Cells [0,FrmActions.ActionGrid.row];
                       SubTableCName:=FrmActions.ActionGrid.Cells [1,FrmActions.ActionGrid.row];

                       SubFieldEName:=FrmActions.ActionGrid.Cells [4,FrmActions.ActionGrid.row];

                 end;
                 FrmActions.Free ;



                 if SubTableEName<>'' then
                  begin
                      SubDataSetID :=fhlUser.AddDataSet(self.caption+  SubTableCName+'子层',SubTableEName,'select *from '+SubTableEName+' where '+SubFieldEName+' =:'+SubFieldEName,true,true);
                      SubGridID    :=fhlUser.AddGrid  (self.caption+SubTableCName+'子层',SubDataSetID);
                      SubTreeGridID:=fhlUser.AddTreeGrid(self.caption+SubTableCName+'子层',SubGridID,'-1','-1',-1);
                      fhlUser.AddSubInterFace(self.caption+SubTableCName+'子层',inttostr(pgcSubInterface.Tag ),'0',SubTreeGridID,'');
                  end;
            end
            else
               exit;

           showmessage(MainField+inttostr(pgcSubInterface.Tag )+' '+SubTableEName +' '+SubFieldEName+' '+SubTableCName);
      end;
end;

procedure TFrmCrm.pgcSubInterfaceDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   if source is Tdbgrid then
      Accept:=true;
end;

procedure TFrmCrm.FormShow(Sender: TObject);
begin
XPMenu1.Active :=true;
end;

procedure TFrmCrm.ActProjTeamExecute(Sender: TObject);
begin
    FhlUser.ShowCRMFrm('1010');
end;

procedure TFrmCrm.ActChkExecute(Sender: TObject);
var
  fbk:TBookmark;
begin
  try
    fbk:=Maindataset.GetBookmark;
    FhlUser.DoExecProc(Maindataset,null);
    FhlKnl1.Ds_RefreshDataSet(Maindataset);
    Maindataset.GotoBookmark(fbk);
   except

   end;
end;

procedure TFrmCrm.ActUpdateProductCostExecute(Sender: TObject);
var
  fbk:TBookmark;
begin
  FhlUser.DoExecProc(Maindataset,null);
  fbk:=Maindataset.GetBookmark;
  FhlKnl1.Ds_RefreshDataSet(Maindataset);

  try
   Maindataset.GotoBookmark(fbk);
   except

   end;
end;

procedure TFrmCrm.ActLinkBillExecute(Sender: TObject);
var sql:string;
var
  frmid:string;
  fBillType:string;
  BillFrm:TFrmBillEx;
  EditorFrm:TEditorFrm ;
  Code,tmpWindowsFID:string;
  FrmBillEx:TFrmBillEx ;
  LstParameterFLDs,LstDefValues:Tstrings;
  i:integer;
begin
 sql:='select  A.F19,A.F17,A.F20 ,B.F_ID From T525 A  join '+ logininfo.SysDBPubName +'.dbo.T511 B  on A.F17=B.F06 where A.F02='+fDict.MainActions +' and A.f16=' +inttostr(Taction(Sender).Index )
        +' and A.f17=' +inttostr(Taction(Sender).ActionComponent.Tag  )+' and A.f04='+quotedstr( Ttoolbutton( Taction(Sender).ActionComponent).Caption   );
    fhlknl1.Kl_GetQuery2 (sql  );
    fBillType:=fhlknl1.FreeQuery.FieldByName('F19').AsString  ;
    frmid:=fhlknl1.FreeQuery.FieldByName('F17').AsString      ;
    tmpWindowsFID:=fhlknl1.FreeQuery.FieldByName('F_ID').AsString      ;


  if uppercase(fBillType)=uppercase('Analyser') then
  begin
      if MainDBGrid.DataSource.DataSet .FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.MainDBGrid.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;
      FhlUser.ShowAnalyserFrm(frmid,null);
  end;

  if uppercase(fBillType)=uppercase('Editor') then
  begin
      if MainDBGrid.DataSource.DataSet .FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.MainDBGrid.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;
      FhlUser.ShowEditorFrm(FrmId,Code).ShowModal ;
  end;
  if uppercase(fBillType)=uppercase('CRM') then
  begin

      if MainDBGrid.DataSource.DataSet.FindField('sDefaultVals')<>nil then
      sDefaultVals:=self.MainDBGrid.DataSource.DataSet .fieldbyname('sDefaultVals').AsString;


      if not self.MainDBGrid.DataSource.DataSet.IsEmpty then
      begin
        LstParameterFLDs:=Tstringlist.Create ;
        LstDefValues:=Tstringlist.Create ;
        LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
        for i:=0 to  LstParameterFLDs.Count -1 do
        begin
          if   self.MainDBGrid.DataSource.DataSet.FindField (LstParameterFLDs[i])<>nil then
          begin
             if self.MainDBGrid.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString <>'' then
             begin
                 LstDefValues.Add( LstParameterFLDs[i]+'=' +  self.MainDBGrid.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString  );
                 break;
             end;
          end;
        end;
        sDefaultVals:= LstDefValues.CommaText ;
        LstParameterFLDs.Free;
        LstDefValues.Free;
      end;


      FhlUser.ShowCRMFrm(frmid);
  end;
  if uppercase(fBillType)=uppercase('BillEx') then
  begin
    if not self.MainDBGrid.DataSource.DataSet.IsEmpty then
    begin
      LstDefValues:=Tstringlist.Create ;
      LstParameterFLDs:=Tstringlist.Create ;
      LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
      for i:=0 to  LstParameterFLDs.Count -1 do
      begin

        if   self.MainDBGrid.DataSource.DataSet.FindField (LstParameterFLDs[i])<>nil then
        begin
           if self.MainDBGrid.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString <>'' then
           begin
               LstDefValues.Add( LstParameterFLDs[i]+'=' +  self.MainDBGrid.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString  );
               Code:=self.MainDBGrid.DataSource.DataSet.FieldByName (LstParameterFLDs[i]).AsString  ;
               //break;
           end;
        end;
      end;
      sDefaultVals:= LstDefValues.CommaText ;
      LstParameterFLDs.Free;
      LstDefValues.Free;
    end;
    FrmBillEx:=TFrmBillEx.Create(nil);
    FrmBillEx.SetParamDataset(self.MainDBGrid.DataSource.DataSet  );
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
end;


procedure TFrmCrm.pgcSubInterfaceChange(Sender: TObject);
begin
  inherited;
  TModelAbstractSheet(pgcSubInterface.ActivePage  ).OpenDataSet ;
end;

procedure TFrmCrm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   case Key of
     vk_Return:
     begin
          btnOpen.Click ;
     end;
   end;
end;

procedure TFrmCrm.ActExportExcelExecute(Sender: TObject);
var
  PopDbgrid:Tdbgrid;
  RepeatCnt:string;
  ClickedOK: Boolean;
  NewString: string;

begin
//  RepeatCnt:=   InputBox('设置列重复次数', '请输入列重复次数', '3')  ;
  RepeatCnt := '3';
  ClickedOK := InputQuery('设置列重复次数', '请输入列重复次数', RepeatCnt);
  if ClickedOK then
  begin
    PopDbgrid:=self.MainDBGrid ;
    QExportExcel(PopDbgrid,TForm(PopDbgrid.Parent).Caption+formatdatetime('yyyymmdd',now), true,strtoint(RepeatCnt));
  end;
end;




procedure TFrmCrm.ActPropertyExecute(Sender: TObject);
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

    sql:='select  A.F19,A.F17,A.F20 ,B.F_ID From T525 A  join '+ logininfo.SysDBPubName +'.dbo.T511 B  on A.F17=B.F06 where A.F02='+fDict.MainActions+' and A.f16=' +inttostr(Taction(Sender).Index )
        +' and A.f17=' +inttostr(Taction(Sender).ActionComponent.Tag  )+' and A.f04='+quotedstr( Ttoolbutton( Taction(Sender).ActionComponent).Caption   );
    fhlknl1.Kl_GetQuery2 (sql  );
    fBillType:=fhlknl1.FreeQuery.FieldByName('F19').AsString  ;
    frmid:=fhlknl1.FreeQuery.FieldByName('F17').AsString      ;
    tmpWindowsFID:=fhlknl1.FreeQuery.FieldByName('F_ID').AsString      ;
    if uppercase(fBillType)=uppercase('Analyser') then
    begin
        if self.Maindataset .FindField('sDefaultVals')<>nil then
        sDefaultVals:=self.Maindataset .fieldbyname('sDefaultVals').AsString;
        form:=TAnalyseEx.Create(Application)  ;

        form.hide;
        form.FWindowsFID :=tmpWindowsFID;
        form.InitFrm(frmid,null);
        //formstyle:=fsMDIChild;

        form.Showmodal;

    end;

    if uppercase(fBillType)=uppercase('Editor') then
    begin
        if self.Maindataset .FindField('sDefaultVals')<>nil then
          sDefaultVals:=self.Maindataset .fieldbyname('sDefaultVals').AsString;
        EditorFrm:=TEditorFrm.Create(self);
        EditorFrm.InitFrm(FrmId,Maindataset .fieldbyname(fhlknl1.FreeQuery.FieldByName('F20').AsString).AsString,Maindataset ,self.MainDBGrid  ,fhlknl1.FreeQuery.FieldByName('F20').AsString  ) ;
        EditorFrm.ShowModal ;
        EditorFrm.Free ;
    end;
    if uppercase(fBillType)=uppercase('CRM') then
    begin

        if Maindataset.FindField('sDefaultVals')<>nil then
        sDefaultVals:=Maindataset .fieldbyname('sDefaultVals').AsString;
        FhlUser.ShowCRMFrm(frmid);
    end;
    if uppercase(fBillType)=uppercase('BillEx') then
    begin
      if not Maindataset .IsEmpty then
      begin
      LstParameterFLDs:=Tstringlist.Create ;
      LstParameterFLDs.CommaText :=fhlknl1.FreeQuery.FieldByName('F20').AsString      ;//  fDict.QryParamsFLDs ;
      for i:=0 to  LstParameterFLDs.Count -1 do
      begin
        if   Maindataset .FindField (LstParameterFLDs[i])<>nil then
        begin
           if Maindataset .FieldByName (LstParameterFLDs[i]).AsString <>'' then
           begin
               Code:=Maindataset .FieldByName (LstParameterFLDs[i]).AsString  ;
               break;
           end;
        end;
      end;
      end;

      FrmBillEx:=TFrmBillEx.Create(nil);
      FrmBillEx.SetParamDataset(Maindataset );
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


procedure TFrmCrm.actSumExecute(Sender: TObject);
var i,j:Integer;
var SumValue:Double;
var MaxValue:Double;
var pdbgrid:Tdbgrid;
begin
      MainDBGrid .NeedSumRow:=  BtnSum.Down ;
      if    BtnSum.Down then
      begin
         MainDBGrid .ReflashSumValues ;
      end;
end;


procedure TFrmCrm.actprintExecute(Sender: TObject);
 var
    printID:string;
    FrmMulModulePrint: TFrmMulModulePrint;
begin

    if not Maindataset.Active then exit;

  try
    printID:=IntToStr(fDict.FrmID ) ;
    FrmMulModulePrint:= TFrmMulModulePrint.Create (nil);
    FrmMulModulePrint.FrmIni(printID  ,self.Mtdataset    ,inttostr(Mtdataset.Tag ), self.fDict.MtBoxID  ,     '' , self.MainDBGrid    );
    FrmMulModulePrint.MaxPrintModule :=1;
    FrmMulModulePrint.ShowModal ;
  finally
    if assigned(FrmMulModulePrint) then
    FrmMulModulePrint.Free ;
  end;
 
end;

procedure TFrmCrm.btnCtrlClick(Sender: TObject);
var  FrmCtrlConfig:TFrmCtrlConfig ;
begin
  try
    FrmCtrlConfig:=TFrmCtrlConfig.Create(nil) ;
    FrmCtrlConfig.boxid :=self.fDict.MtBoxID ;
    FrmCtrlConfig.ShowModal ;
  finally
    FrmCtrlConfig.Free;

  end;

end;

end.

