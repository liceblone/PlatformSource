unit TreeEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, ExtCtrls, Db, dbctrls, Mask, ImgList, ADODB,UPublicFunction,
  Grids, DBGrids, Variants, FhlKnl,UnitCreateComponent,StrUtils,UnitModelFrm;

type
  TTreeEditorFrm = class(TFrmModel)
    ToolBar1: TToolBar;
    PrtBtn: TToolButton;
    PreBtn: TToolButton;
    ToolButton5: TToolButton;
    Addbtn: TToolButton;
    ChgBtn: TToolButton;
    DelBtn: TToolButton;
    ToolButton9: TToolButton;
    CleBtn: TToolButton;
    SavBtn: TToolButton;
    ToolButton12: TToolButton;
    rfsBtn: TToolButton;
    hlpBtn: TToolButton;
    ExtBtn: TToolButton;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    DataSource1: TDataSource;
    ScrollBox1: TScrollBox;
    DBGrid1: TDBGrid;
    Splitter2: TSplitter;
    ADODataSet1: TADODataSet;
    expBtn: TToolButton;
    btnSubAdd: TToolButton;
    ControlBar1: TControlBar;
    ToolButton1: TToolButton;
    BtnClearALL: TToolButton;
    btnCtrl: TToolButton;
    procedure InitFrm(FrmId:String;AParams:Variant;Model:boolean=false);

    procedure SavBtnClick(Sender: TObject);
    procedure UpdateSysFields;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure rfsBtnClick(Sender: TObject);
    procedure AddbtnClick(Sender: TObject);
    procedure ExtBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CleBtnClick(Sender: TObject);
    procedure ChgBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    function  CheckIsSaved:Boolean;
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure PreBtnClick(Sender: TObject);
    procedure SetCtrlCanEdit(CanEdit:Boolean;bkColor:TColor);
    procedure expBtnClick(Sender: TObject);
    procedure ExpAllNodes(Sender: TObject;ShowCode:boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrtBtnClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure btnSubAddClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure BtnClearALLClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCtrlClick(Sender: TObject);
    function  GetFullParentCode:string;
  private
    fDict:TTreeEditorDict;
  public

  end;

var
  TreeEditorFrm: TTreeEditorFrm;

implementation

uses datamodule,RepGrid ,UnitCtrlConfig;

{$R *.DFM}

procedure TTreeEditorFrm.InitFrm(FrmId:String;AParams:Variant;Model:boolean=false);
begin
  if Not FhlKnl1.Cf_GetDict_TreeEditor(FrmId,fdict) then Close;
//  self.Caption:=fDict.FrmCaption;
  FhlUser.SetDbGridAndDataSet(dbGrid1,fDict.DbGridId,AParams,true);
  self.DataSource1.Tag :=self.ADODataSet1.Tag ;
  FhlKnl1.Cf_SetBox(fDict.BoxId,DataSource1,ScrollBox1,dmFrm.UserDbCtrlActLst);

  FhlKnl1.Tv_NewDataNode(Treeview1,nil,'',fDict.RootCaption,12,12);

  ExpAllNodes(expBtn,not Model);
  SetCtrlCanEdit(False,clCream);
  TreeView1.Items.GetFirstNode.Selected:=True;

  self.btnSubAdd.Visible :=not ((not  fdict.MultiLevel) and (self.TreeView1.Items.Count <>1));
end;
procedure TTreeEditorFrm.UpdateSysFields;
var       sql:string;
begin

  //  update  FLstEditEmp  FlstEditTime  FPhoneticize

   sql:='select B.NameField   ,B.TableEname  '
       +'  From T201 A '
       +'  join ' +logininfo.SysDBPubName+'.dbo.Tallusertable B on A.F16=B.TableEname '
       +'  where B.FisBasicTable=1 and  A.f01 ='+inttostr(DataSource1.DataSet.Tag );
   fhlknl1.Kl_GetQuery2(sql);
   if not fhlknl1.FreeQuery.IsEmpty then
   begin
        if DataSource1.DataSet.FindField (fhlknl1.FreeQuery.FieldByName('NameField').AsString )<>nil then
          if DataSource1.DataSet.FindField ('FPhoneticize')<>nil then
          if (DataSource1.DataSet.Fieldbyname ('FPhoneticize').Value =null) or (DataSource1.DataSet.Fieldbyname ('FPhoneticize').AsString  ='' ) then          
            if DataSource1.DataSet.FieldByName (fhlknl1.FreeQuery.FieldByName('NameField').AsString).Value<>null then
              DataSource1.DataSet.FieldByName ('FPhoneticize').Value := GetHZPY(DataSource1.DataSet.FieldByName (fhlknl1.FreeQuery.FieldByName('NameField').AsString).Value );
   end;


   if  DataSource1.DataSet.FindField  ('FLstEditEmp') <>nil then
       DataSource1.DataSet.FieldByName ('FLstEditEmp').Value :=  logininfo.EmpId ;
   if  DataSource1.DataSet.FindField  ('FlstEditTime') <>nil then
       DataSource1.DataSet.FieldByName ('FlstEditTime').Value :=now;
end;
procedure TTreeEditorFrm.SavBtnClick(Sender: TObject);
 var c,s:String;
     bk:Tbookmark;
begin
  with AdoDataSet1 do
  begin

    if  AdoDataSet1.FindField('FIsLeaf')<>nil then
        if self.TreeView1.Selected.getFirstChild <>nil then
          AdoDataSet1.FieldByName ('FIsLeaf').Value :=False
        else
          AdoDataSet1.FieldByName ('FIsLeaf').Value :=True;

    if  AdoDataSet1.FindField('FParentCode')<>nil then
        if self.TreeView1.Selected.Parent  <>nil then
          AdoDataSet1.FieldByName ('FParentCode').Value :=TStrPointer(TreeView1.Selected.Parent.Data)^ ;

    if  AdoDataSet1.FindField('FNodeFullParentCode')<>nil then
        if self.TreeView1.Selected.Parent  <>nil then
          AdoDataSet1.FieldByName ('FNodeFullParentCode').Value :=GetFullParentCode ;

    UpdateSysFields ;
    Post;
    c:=fieldbyname(fDict.CodeFld).asString;
    if  assigned(TreeView1.Selected.Parent) then
        s:=TStrPointer(TreeView1.Selected.Parent.Data)^
    else
    begin
       SetCtrlCanEdit(False,clCream);
       exit;
    end;

  end;
  if (c<>s) and (copy(c,1,length(s))=s) then
  begin
    AdoDataSet1.UpdateBatch;
    TreeView1.Selected.Text:=AdoDataSet1.FieldByName(fDict.NameFld).asString+'['+AdoDataSet1.FieldByName(fDict.CodeFld).asString+']';
    TStrPointer(TreeView1.Selected.Data)^:=AdoDataSet1.FieldByName(fDict.CodeFld).asString;
    SetCtrlCanEdit(False,clCream);

    bk:=AdoDataSet1.GetBookmark ;
    AdoDataSet1.Close;
    AdoDataSet1.Open ;
    AdoDataSet1.GotoBookmark(bk) ; 
  end
  else
  begin
    AdoDataSet1.Edit;
    MessageDlg(#13#10+'该编码与其父项编码在规则编排上不一致,请重试!',mtWarning,[MbOK],0)
  end;
  
  self.btnSubAdd.Visible :=not ((not  fdict.MultiLevel) and (self.TreeView1.Items.Count <>1));
end;


procedure TTreeEditorFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
    if  AdoDataset1.FindField(fDict.CodeFld)     <>nil then
    begin
     if TStrPointer(Node.Data)^<>'' then
     AdoDataset1.Locate(fDict.CodeFld,TStrPointer(Node.Data)^,[]);
     ChgBtn.Enabled:=Node.Level<>0;
     DelBtn.Enabled:=ChgBtn.Enabled and Not Node.HasChildren;
     Addbtn.Enabled := Node.Level<>0;
    end;

end;

procedure TTreeEditorFrm.rfsBtnClick(Sender: TObject);
var bk:pointer;
begin
    bk:=AdoDataSet1.GetBookmark ;
  AdoDataSet1.Close;
  AdoDataSet1.Open;
 
  AdoDataSet1.GotoBookmark (bk);
  ExpBtnClick(ExpBtn);
end;

procedure TTreeEditorFrm.AddbtnClick(Sender: TObject);
var s,n:String;
    i:integer;
begin
      if not ( ADODataSet1.State  in [ dsEdit, dsInsert]) then
      begin

           n:='新建名称';
           s:=TStrPointer(TreeView1.Selected.Parent.GetLastChild.Data  )^   ;
           i:=pos('Sys',s);

           if I>0 then
           s:=rightstr(s,length(s)- 3);

           if length(s)>1 then
             if  isinteger( rightstr(s,2)) then
               if length(inttostr(strtoint(rightstr(s,2))+1))=1   then
                  s:= leftstr(s,length(s)-2) + format('0%s',[inttostr(strtoint(rightstr(s,2))+1)])
               else
                  s:= leftstr(s,length(s)-2) + inttostr(strtoint(rightstr(s,2))+1);


           FhlKnl1.Tv_NewDataNode(TreeView1,TreeView1.Selected.Parent    ,'',n,35,34).Selected:=True;
           SetCtrlCanEdit(True,clWhite);
           FhlKnl1.Ds_AssignValues(AdoDataSet1,varArrayof([fDict.CodeFld,fDict.NameFld]),varArrayof([s,n]),True,False);
           FhlKnl1.Vl_FocueACtrl(ScrollBox1);
     end;



   //      FhlKnl1.Tv_NewDataNode(TreeView1,TreeView1.Selected  ,'',n,35,34).Selected:=True;

end;

procedure TTreeEditorFrm.ExtBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TTreeEditorFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CheckIsSaved then
    Action:=caFree
 else
    Action:=caNone;
end;

function  TTreeEditorFrm.CheckIsSaved:Boolean;
  var i:integer;
begin
 Result:=true;
 if SavBtn.Enabled then
 begin
    i:=MessageDlg(fsDbChanged,mtConfirmation,mbYesNoCancel,0);
    if i=mrYes then
       SavBtnClick(SavBtn)
    else if i=mrNo then
       CleBtnClick(CleBtn)
    else
       Result:=false;
 end;
end;

procedure TTreeEditorFrm.CleBtnClick(Sender: TObject);

begin
    if AdoDataSet1.Active then
    begin
       AdoDataSet1.CancelUpdates;
       SetCtrlCanEdit(False,clCream);

       if Not AdoDataSet1.Locate(fDict.CodeFld,TStrPointer(TreeView1.Selected.Data)^,[]) then
          TreeView1.Items.Delete(TreeView1.Selected);
    end;

end;

procedure TTreeEditorFrm.ChgBtnClick(Sender: TObject);
begin
  if self.ADODataSet1.FindField('FisSys')<>nil then
  if self.ADODataSet1.Fieldbyname('FisSys').AsBoolean then
  begin
      showmessage('系统数据 不能修改!');
      if not LoginInfo.Sys then
      exit;
  end;
  SetCtrlCanEdit(True,clWhite);
  DataSource1.DataSet.Edit;
  FhlKnl1.Vl_FocueACtrl(ScrollBox1);
end;

procedure TTreeEditorFrm.DelBtnClick(Sender: TObject);
begin

 if TreeView1.Selected.HasChildren or (TreeView1.Selected.Level=0) then
 begin
    MessageDlg(#13#10+'  非未级编码记录不能删除!          '+#13#10,mtWarning,[mbyes],0);
    Exit;
 end;
  if self.ADODataSet1.FindField('FisSys')<>nil then
  if self.ADODataSet1.Fieldbyname('FisSys').AsBoolean then
  begin
      showmessage('系统数据 不能修改!');
      if not LoginInfo.Sys then
      exit;
  end;

    try

      if not assigned(  Tadodataset(DataSource1.DataSet).BeforeDelete ) then
      begin
          if MessageBox(0, '确定删除？', '', MB_YESNO + MB_ICONQUESTION) = IDYES
            then
          begin
               AdoDataSet1.Delete;
               AdoDataSet1.UpdateBatch;
               Treeview1.Selected.Delete;
          end;
      end
      else
      begin
         AdoDataSet1.Delete;
         AdoDataSet1.UpdateBatch;
         Treeview1.Selected.Delete;
      end;

    except
     AdoDataSet1.Close;
     AdoDataSet1.Open;
     expBtnClick(expBtn);
    end;


  self.btnSubAdd.Visible :=not ((not  fdict.MultiLevel) and (self.TreeView1.Items.Count <>1));
   
end;

procedure TTreeEditorFrm.TreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
 AllowChange:=CheckIsSaved;
end;

procedure TTreeEditorFrm.PreBtnClick(Sender: TObject);
begin
 DbGrid1.Visible:=Not DbGrid1.Visible;
 Splitter2.Visible:=Not Splitter2.Visible;
end;

procedure TTreeEditorFrm.SetCtrlCanEdit(CanEdit:Boolean;bkColor:TColor);
begin
  SavBtn.Enabled:=CanEdit;
  CleBtn.Enabled:=CanEdit;
  
  AddBtn.Enabled:=Not CanEdit;
  btnSubAdd.Enabled :=Not CanEdit;

  ChgBtn.Enabled:=Not CanEdit;
  DelBtn.Enabled:=Not CanEdit;
  FhlKnl1.Vl_SetCtrlStyle(bkColor,ScrollBox1,CanEdit);
end;

procedure TTreeEditorFrm.expBtnClick(Sender: TObject);
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

procedure TTreeEditorFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
   vk_Return:begin
               if ssCtrl in Shift then
                  SavBtn.Click
               else
                  Perform(WM_NEXTDLGCTL, 0, 0);
             end;
   vk_Insert:begin
               if ssCtrl in Shift then
                  ChgBtn.Click
               else
                  AddBtn.Click;
             end;
   vk_Delete:begin
               if Not ((DataSource1.State=dsEdit) or (DataSource1.State=dsInsert)) then
                  DelBtn.Click;
             end;
 end;
end;

procedure TTreeEditorFrm.PrtBtnClick(Sender: TObject);
begin
 FhlUser.CheckRight(fdict.PrintRitId);
 FhlKnl1.Rp_DbGrid(intTostr(DbGrid1.Tag),DbGrid1,self.fDict.FrmCaption );
end;

procedure TTreeEditorFrm.DBGrid1CellClick(Column: TColumn);
begin
 FhlKnl1.Tv_FindNode(TreeView1,AdoDataSet1.FieldByName(fDict.CodeFld).asString).Selected:=True;
end;

procedure TTreeEditorFrm.ToolBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
      CrtCom:=TfrmCreateComponent.Create(self);
      CrtCom.mtDataSet1 :=self.ADODataSet1 ;
      CrtCom.fTreeEditorDict :=self.fDict ;
      CrtCom.ModelType :=ModelFrmTreeEditor;
      CrtCom.TopOrBtm :=true;
      CrtCom.DLGrid  := self.DBGrid1     ;
      try
          CrtCom.Show;
      finally

      end;

  end;


 { }

end;

procedure TTreeEditorFrm.btnSubAddClick(Sender: TObject);
 var s,n:String;
begin

      if not (ADODataSet1.State in  [dsinsert,dsedit]) then
      begin
         n:='新建名称';

         if  TreeView1.Selected.Level <>0 then
         begin
           if not TreeView1.Selected.HasChildren then
             begin
                 s:=TStrPointer(TreeView1.Selected.Data)^ ;
                 s:=s+'01';
             end
             else     {  }
             begin
                 s:=TStrPointer(TreeView1.Selected.GetLastChild.Data)^;
                 if length(s)>1 then
                   if  isinteger( rightstr(s,2)) then
                      if length(inttostr(strtoint(rightstr(s,2))+1))=1   then
                          s:= leftstr(s,length(s)-2) + format('0%s',[inttostr(strtoint(rightstr(s,2))+1)])
                       else
                          s:= leftstr(s,length(s)-2) + inttostr(strtoint(rightstr(s,2))+1);

              end;        
         end
         else
         begin
              s:=s+'01';

             if TreeView1.Selected.GetLastChild <>nil then
             begin
             s:=TStrPointer(TreeView1.Selected.GetLastChild.Data  )^   ;
             if length(s)>1 then
               if  isinteger( rightstr(s,2)) then
                 if length(inttostr(strtoint(rightstr(s,2))+1))=1   then
                    s:= leftstr(s,length(s)-2) + format('0%s',[inttostr(strtoint(rightstr(s,2))+1)])
                 else
                    s:= leftstr(s,length(s)-2) + inttostr(strtoint(rightstr(s,2))+1);

             end;
         end;

         FhlKnl1.Tv_NewDataNode(TreeView1,TreeView1.Selected  ,'',n,35,34).Selected:=True;
         SetCtrlCanEdit(True,clWhite);
         FhlKnl1.Ds_AssignValues(AdoDataSet1,varArrayof([fDict.CodeFld,fDict.NameFld]),varArrayof([s,n]),True,False);
         FhlKnl1.Vl_FocueACtrl(ScrollBox1);
      end;

end;
procedure TTreeEditorFrm.ExpAllNodes(Sender: TObject; ShowCode: boolean);
begin
  Treeview1.Items.GetFirstNode.DeleteChildren;
  FhlKnl1.Cf_ListAllNode(AdoDataSet1,TreeView1,20,0,fDict.CodeFld,fDict.NameFld,ShowCode);
  with TreeView1.Items.GetFirstNode do begin
      Expand(False);
      if GetFirstChild<>nil then GetFirstChild.Expand(False);
  end;
end;

procedure TTreeEditorFrm.ToolButton1Click(Sender: TObject);
begin
   inherited;
   fhluser.showLogwindow (self.DBGrid1 );

end;

procedure TTreeEditorFrm.BtnClearALLClick(Sender: TObject);
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

procedure TTreeEditorFrm.FormActivate(Sender: TObject);
begin
  inherited;
  BtnClearALL.Visible :=logininfo.Sys ;
  btnCtrl.Visible     :=logininfo.Sys ;
end;

procedure TTreeEditorFrm.btnCtrlClick(Sender: TObject);
var  FrmCtrlConfig:TFrmCtrlConfig ;
begin
  try
    FrmCtrlConfig:=TFrmCtrlConfig.Create(nil) ;
    FrmCtrlConfig.boxid :=self.fDict.BoxId ;
    FrmCtrlConfig.ShowModal ;
  finally
    FrmCtrlConfig.Free;

  end;
end;


function TTreeEditorFrm.GetFullParentCode: string;
var node :TTreeNode;
var fullCodes:string;
begin
 node:= TreeView1.Selected;
 fullCodes:= ADODataSet1.fieldbyname(fDict.CodeFld).asString ;
 while (node.Parent <>nil) do
 begin
   if (TStrPointer(node.Parent.Data)^<>'') then
      fullCodes:= TStrPointer(node.Parent.Data)^   +','+fullCodes;
   node:=node.Parent;
 end;
 result:= fullCodes;
end;
 

end.
