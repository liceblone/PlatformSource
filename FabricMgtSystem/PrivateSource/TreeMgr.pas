unit TreeMgr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, ToolWin, Db, ADODB, ImgList, Grids, DBGrids,  UPublicFunction,
  Menus, variants,ActnList, FhlKnl,UnitCreateComponent,DBCtrls;


type
  TTreeMgrFrm = class(TForm)
    DataSource1: TDataSource;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    ADODataSet1: TADODataSet;
    ControlBar1: TControlBar;
    myBar1: TToolBar;
    ToolBar1: TToolBar;
    printBtn: TToolButton;
    refreshbtn: TToolButton;
    ToolButton2: TToolButton;
    TreeBtn: TToolButton;
    exitBtn: TToolButton;
    ActionList1: TActionList;
    NodeDataSet1: TADODataSet;
    AddAction1: TAction;
    EditAction1: TAction;
    SaveAction1: TAction;
    UserPropAction1: TAction;
    GroupPropAction1: TAction;
    UsersAction1: TAction;
    uGroupAction1: TAction;
    RightAction1: TAction;
    rGroupAction1: TAction;
    actDeleteAction9: TAction;
    LoginAction1: TAction;
    PwAction1: TAction;
    uBankAction1: TAction;
    BakAction1: TAction;
    CarryAction1: TAction;
    EmpClientAction1: TAction;
    BosEmpAction16: TAction;
    MacPermit17: TAction;
    act1: TAction;
    actsys: TAction;
    actTabEdit20: TAction;
    actAdd21: TAction;
    actGroup22: TAction;
    actlogin: TAction;
    actFilter: TAction;
    actADD25: TAction;
    ActAddEmp26: TAction;
    ActClearDefaultWin27: TAction;
    procedure InitFrm(FrmId:String);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure exitBtnClick(Sender: TObject);
    procedure TreeBtnClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure SaveAction1Execute(Sender: TObject);

    function  GetParams(Params:String):Variant;
    procedure UsersAction1Execute(Sender: TObject);
    procedure uGroupAction1Execute(Sender: TObject);
    procedure RightAction1Execute(Sender: TObject);
    procedure rGroupAction1Execute(Sender: TObject);
    procedure actDeleteAction9Execute(Sender: TObject);
    procedure LoginAction1Execute(Sender: TObject);
    procedure uBankAction1Execute(Sender: TObject); 
    procedure BakAction1Execute(Sender: TObject);
    procedure EmpClientAction1Execute(Sender: TObject);
    procedure BosEmpAction16Execute(Sender: TObject);
    procedure MacPermit17Execute(Sender: TObject);
    procedure myBar1DblClick(Sender: TObject);
    procedure MenuItemT508(Sender: TObject);
    procedure actsysExecute(Sender: TObject); 
    procedure actGroup22Execute(Sender: TObject);
    procedure actloginExecute(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure actADD25Execute(Sender: TObject);
    procedure ActAddEmp26Execute(Sender: TObject);
    procedure ActClearDefaultWin27Execute(Sender: TObject);
  private
    fDict:TTreeMgrDict;
  public
    { Public declarations }
  end;

const
  fCode='F01';
  fTreeId='F02';
  fName='F03';
  fHint='F04';
  fActions='F05';
  fDbGridId='F06';
  fBoxId='F07';
  fDataSetId='F08';
  fOpenParams='F11';
  fNodeFld='F12';

var
  TreeMgrFrm: TTreeMgrFrm;

implementation
uses datamodule,  MacPermit;
{$R *.DFM}

procedure TTreeMgrFrm.InitFrm(FrmId:String);
var MenuItemT508: TMenuItem;

begin
  if Not FhlKnl1.Cf_GetDict_TreeMgr(FrmId,fdict) then Close;
  Self.Caption:=fDict.Caption;
  NodeDataSet1.Connection:=FhlKnl1.Connection;
 FhlKnl1.Cf_SetTreeView(fDict.TreeId,TreeView1,NodeDataSet1,null);

    if logininfo.Sys then
    begin
     self.TreeView1.PopupMenu :=fhluser.TreePopUpMenu( fDict.TreeId) ;
      MenuItemT508:= TMenuItem.Create (self);
      self.TreeView1.PopupMenu.Items.Add(MenuItemT508)   ;
      MenuItemT508.Caption :='T508';
      MenuItemT508.OnClick := self.MenuItemT508;

    end;
end;

procedure TTreeMgrFrm.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TTreeMgrFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TTreeMgrFrm.exitBtnClick(Sender: TObject);
begin
 close;
end;

procedure TTreeMgrFrm.TreeBtnClick(Sender: TObject);
begin
 GroupBox1.Visible:=TreeBtn.Down;
end;

procedure TTreeMgrFrm.ToolButton2Click(Sender: TObject);
begin
 if TreeView1.Selected.Level>0 then
    TreeView1.Selected.Parent.Selected:=true;
//    TreeView1.Selected.GetNext.Selected :=true;

end;

function TTreeMgrFrm.GetParams(Params:String):Variant;
  var i:integer;
begin
  Result:=FhlKnl1.Vr_CommaStrToVarArray(Params);
  if Not VarIsNull(Result) then
     for i:=0 to VarArrayHighBound(Result,1) do
         if Result[i]='sParent' then
            Result[i]:=TStrPointer(TreeView1.Selected.Data)^+'_%'
         else
            Result[i]:=FhlUser.GetSysParamVal(Result[i]);

end;

procedure TTreeMgrFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
var i:integer;
begin

 FhlKnl1.Vl_ClearChild(ScrollBox1);
  Screen.Cursor:=crSqlWait;
 try
  if NodeDataSet1.Locate(fCode,TStrPointer(Node.Data)^,[]) then     //locate the record
  begin
    sDefaultVals:='';

    if  NodeDataSet1.FindField('F19')<>nil then
    if (self.NodeDataSet1.FieldByName('F19').AsString <>'') then
    begin
    sDefaultVals:='ColID='+self.NodeDataSet1.FieldByName('F19').AsString+',';
    end;


    if  ( trim(NodeDataSet1.FieldByName(fActions).asString)<>'' ) and  (trim(NodeDataSet1.FieldByName(fActions).asString)<>'-1') then
    begin
          FhlKnl1.Tb_CreateActionBtns(myBar1,ActionList1,NodeDataSet1.FieldByName(fActions).asString);     // create toolbutton
          mybar1.Visible:=mybar1.ButtonCount>0;
    end
    else
        for i:=0 to  myBar1.ButtonCount-1 do
        begin
             myBar1.Buttons [0].Free ;
        end;


    FhlUser.SetDataSet(AdoDataSet1,NodeDataSet1.FieldByName(fDataSetId).asString,GetParams(NodeDataSet1.FieldByName(fOpenParams).asString));//set AdoDataSet1
    DbGrid1.Visible:=NodeDataSet1.FieldByName(fDbGridId).asString<>'-1';
    if DbGrid1.Visible then
    begin
       FhlUser.SetDbGrid(NodeDataSet1.FieldByName(fDbGridId).AsString,DbGrid1);  // if have grid then initial the grid

       if (ADODataSet1.FindField ('RightModelName')<>nil) and (ADODataSet1.FindField ('ColID')<>nil)    then
       begin
       sDefaultVals:=sDefaultVals+'RightModelName='+Node.Text ;
       FhlUser.AssignDefault(self.ADODataSet1 );
       end;
    end
    else
    begin
        if ( NodeDataSet1.FieldByName(fBoxId).asString<>'' ) and (NodeDataSet1.FieldByName(fBoxId).asString<>'-1') then
           FhlKnl1.Cf_SetBox(NodeDataSet1.FieldByName(fBoxId).asString,DataSource1,ScrollBox1,dmFrm.UserDbCtrlActLst); //  if have not grid then initial the boxes
    end;


  end;
 finally
  Screen.Cursor:=crDefault;
 end;
 Panel1.Caption:=FhlKnl1.Tv_GetTreePath(Node);


end;

procedure TTreeMgrFrm.SaveAction1Execute(Sender: TObject);
begin
  AdoDataset1.Post;
  AdoDataSet1.UpdateBatch;
end;




procedure TTreeMgrFrm.UsersAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('203',AdoDataSet1.Fields[0].asString);
end;

procedure TTreeMgrFrm.uGroupAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('2',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.RightAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('4',AdoDataSet1.FieldByName('Code').asString);
end;

procedure TTreeMgrFrm.rGroupAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('5',AdoDataSet1.FieldByName('Code').asString);
end;

procedure TTreeMgrFrm.LoginAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('6',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.actDeleteAction9Execute(Sender: TObject);
begin
    if logininfo.isAdmin then
    begin
        if   assigned(AdoDataSet1.BeforeDelete) then
        begin
           AdoDataSet1.Delete;
        end
        else
            if MessageBox(0, '确定删除？', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
               AdoDataSet1.Delete;
    end
    else
      MessageBox(0, '只有管理员才可以删除登录用户', '',  MB_ICONQUESTION) ;
end;

procedure TTreeMgrFrm.uBankAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('8',AdoDataSet1.FieldByName('LoginId').asString);
end;



procedure TTreeMgrFrm.BakAction1Execute(Sender: TObject);
var
  fto:widestring;
begin
  if dmFrm.SaveDialog1.Execute then
  begin
    fto:=dmFrm.SaveDialog1.FileName;
//  fto:='D:\Program Files\FhlSoft\JingBei\bak\%s.bak';
    Screen.Cursor:=crHourGlass;
    try
    dmFrm.GetQuery1(format('backup database %s to disk=''%s''',[dmFrm.ADOConnection1.DefaultDatabase,format(fto,[dmFrm.ADOConnection1.DefaultDatabase])]),False);
    FhlKnl1.Kl_GetQuery2(format('backup database %s to disk=''%s''',[FhlKnl1.Connection.DefaultDatabase,format(fto,[FhlKnl1.Connection.DefaultDatabase])]),False);
    finally
    Screen.Cursor:=crDefault;
    end;
    MessageDlg(#13#10'备份成功.',mtInformation,[mbOk],0);
  end;
end;

procedure TTreeMgrFrm.EmpClientAction1Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('9',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.BosEmpAction16Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('10',AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.MacPermit17Execute(Sender: TObject);
begin
  with TMacPermitFrm.Create(Self) do
  try
    CheckBox1.Checked:=ADODataSet1.FieldByName('Permit').AsBoolean;
    Edit1.Text:=ADODataSet1.fieldbyname('note').asstring;
    if ShowModal=mrOk then
    begin
    ADODataSet1.Edit;
    ADODataSet1.FieldByName('Permit').AsBoolean:=CheckBox1.Checked;
    ADODataSet1.fieldbyname('note').asstring:=Edit1.Text;
    ADODataSet1.Post;
    end;
  finally
    Release;
  end;
end;

procedure TTreeMgrFrm.myBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;

    CrtCom.mtDataSet1:= AdoDataSet1;
    CrtCom.ModelType :=ModelTreeMgrDict;
    CrtCom.TopOrBtm :=true;
    CrtCom.mtDataSetId  :=  NodeDataSet1.FieldByName(fDataSetId).asString;
    CrtCom.DlGridId :=  NodeDataSet1.FieldByName(fDbGridId).AsString;
    CrtCom.TOPBoxId :=  NodeDataSet1.FieldByName(fboxId).AsString;
    CrtCom.DLGrid  := self.DBGrid1 ;      try
          CrtCom.Show;
      finally

      end;
  end;
  
end;


procedure TTreeMgrFrm.MenuItemT508(Sender: TObject);
var FrmEditor:Tform;
begin
      FrmEditor:=FhlUser.ShowModelTreeEditorFrm('25',TStrPointer(self.TreeView1.Selected.Data)^ ,true);
      FrmEditor.ShowModal ;
end;

procedure TTreeMgrFrm.actsysExecute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm('200',AdoDataSet1.FieldByName('Code').asString);
end;





procedure TTreeMgrFrm.actGroup22Execute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm(NodeDataSet1.fieldbyname('F202').AsString ,AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.actloginExecute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm(NodeDataSet1.fieldbyname('F202').AsString,AdoDataSet1.FieldByName('LoginId').asString);
end;

procedure TTreeMgrFrm.actFilterExecute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(DbGrid1.DataSource.DataSet);
end;

procedure TTreeMgrFrm.actADD25Execute(Sender: TObject);
begin
     ADODataSet1.Insert;
end;

procedure TTreeMgrFrm.ActAddEmp26Execute(Sender: TObject);
begin
//76
FhlUser.ShowEditorFrm(intTostr(76),null).ShowModal;
end;

procedure TTreeMgrFrm.ActClearDefaultWin27Execute(Sender: TObject);
begin
    if messagedlg('去除默认窗体?',mtConfirmation,[mbNo, mbYes],0)=mryes then
    begin
        self.ADODataSet1.Edit ;
        self.ADODataSet1.FieldByName('F_DefaultActID').Value :=null;
        self.ADODataSet1.FieldByName('F_Tag').Value :=null;
        self.ADODataSet1.FieldByName('MenuName').Value :=null;
        self.ADODataSet1.Post ;
    end;
end;

end.
