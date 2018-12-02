unit desktop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, OleCtrls, SHDocVw, Menus,
  StdActns, ActnList, Buttons, DB, ADODB, FhlKnl, Sockets, AppEvnts,UnitDesignMainMenu,UnitLockSys, UPublicFunction , DBClient ,
  XPMenu, Provider;

type
  TDesktopFrm = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    Image1: TImage;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    OpenBill: TAction;
    OpenTreeEditor: TAction;
    OpenTreeGrid: TAction;
    OpenTabEditor: TAction;
    OpenTreeMgr: TAction;
    OpenMore2More: TAction;
    Navigate: TAction;
    OpenAnalyser: TAction;
    OpenEditor: TAction;
    LoginSystem: TAction;
    WindowCloseAll1: TAction;
    WindowClose1: TWindowClose;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowMaxmizeAll1: TAction;
    WindowSwitch1: TAction;
    Panel1: TPanel;
    NodeDataSet1: TADODataSet;
    actxx: TAction;
    TcpClient1: TTcpClient;
    TcpServer1: TTcpServer;
    Action1: TAction;
    ToolButton1: TToolButton;
    actOpenPickWindow: TAction;
    actLockSys: TAction;
    tmrLockSys: TTimer;
    tmr1: TTimer;
    OpenCRMForm: TAction;
    actRunExe: TAction;
    actDemo: TAction;
    c1: TMenuItem;
    OpenMainMenu: TAction;
    gf1: TMenuItem;
    XPMenu1: TXPMenu;
    OpenActSpecial: TAction;
    OpenBillEx: TAction;
    OpenSysTreeGrid: TAction;
    ApplicationEvents1: TApplicationEvents;
    OpenSendMsg: TAction;
    dsMainMenu: TADOQuery;
    OpenVoucher: TAction;
    procedure InitMenu;
    procedure OpenTreeEditorExecute(Sender:Tobject);
    procedure OpenTreeGridExecute(Sender:Tobject);
    procedure OpenAnalyserExecute(Sender:TObject); 
    procedure OpenTreeMgrExecute(Sender: TObject);
    procedure OpenActSpecialExecute(Sender: TObject);

    procedure LoginSystemExecute(Sender: TObject);
    procedure CloseMainFrmExecute(Sender: TObject);
    function  Reg:Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WindowCloseAll1Execute(Sender: TObject);
    procedure WindowMaxmizeAll1Execute(Sender: TObject);
    procedure WindowSwitch1Execute(Sender: TObject);
    function  DoMenuAction(MenuName:String):Boolean;
    procedure OpenMore2MoreExecute(Sender: TObject);
    procedure OpenEditorExecute(Sender: TObject);
    procedure TcpServer1Accept(Sender: TObject;
      ClientSocket: TCustomIpClient);
    procedure Button3Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChangSubSysName(SubSysName:string);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure actLockSysExecute(Sender: TObject);
    procedure tmrLockSysTimer(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure OpenCRMFormExecute(Sender: TObject);
    procedure actRunExeExecute(Sender: TObject);
    procedure actDemoExecute(Sender: TObject);
    Function  FrmActExecute(sender:Tobject):string;
    procedure OpenMainMenuExecute(Sender: TObject);
    procedure OpenDefaultWindow;
    procedure OpenBillExExecute(Sender: TObject);
    procedure OpenSysTreeGridExecute(Sender: TObject);
    procedure OpenSendMsgExecute(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure OpenVoucherExecute(Sender: TObject);
  private
  public
    { Public declarations }
    lockP1,lockp2,lockp3:Tpoint;
    time:integer;
    frmLockSys:TfrmLockSys;
  end;

type
  TMgrThrd = class (TThread)
  protected
    procedure Execute; override;
  end;

var
  DesktopFrm: TDesktopFrm;

implementation
uses datamodule,Login,about, main,UnitSendMsg;
{$R *.dfm}

procedure TMgrThrd.Execute;
begin
 if dmFrm.ConnectServer(desktopFrm.Caption) then DeskTopFrm.Reg;
end;

procedure TDesktopFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=canone;
end;

procedure TDesktopFrm.InitMenu;
var fParams:variant;
var qry:Tadoquery;
begin
    XPMenu1.Active :=false;

    fParams:=FhlKnl1.Vr_CommaStrToVarArray(  LoginInfo.LoginId +','+ LoginInfo.SysDBPubName+','+  BooleanToString(LoginInfo.sys) );
    dsMainMenu.Close;
    dsMainMenu.SQL.Add(  '--password'  );
    dsMainMenu.SQL.Add( ' exec  Sys_GetMainMenu  ');
    dsMainMenu.SQL.Add( quotedstr(LoginInfo.LoginId) +','+ quotedstr(LoginInfo.SysDBPubName)+','+  quotedstr(BooleanToString(LoginInfo.sys))+','+  quotedstr(LoginInfo.MainUserDBName )   );
    dsMainMenu.Open;
    FhlKnl1.Cf_SetMainMenu('1',MainMenu1,ToolBar1,ActionList1, dsMainMenu );

    if MainMenu1.Items.Count >0 then
      XPMenu1.Active :=true ;
    mainFrm.StatusBar1.Panels[2].Text :='当前登录用户:'+logininfo.LoginId ;
end;

function TDesktopFrm.DoMenuAction(MenuName:String):Boolean;
  var fItem:TMenuItem;
begin
  fItem:=FhlKnl1.Mn_FindMainMenuItem(MainMenu1,MenuName);
  if fItem<>nil then
     fItem.Click;
  Result:=fItem<>nil;
end;

procedure TDesktopFrm.OpenTreeEditorExecute(Sender:TObject);
begin
   FrmActExecute(Sender)  ;
   FhlUser.ShowTreeEditorFrm(intTostr((Sender As TComponent).Tag));

end;
procedure TDesktopFrm.OpenSysTreeGridExecute(Sender: TObject);
begin
      FrmActExecute(Sender)  ;
   FhlUser.ShowModalTreeGridFrmSystool(intTostr((Sender As TComponent).Tag),null);
end;
procedure TDesktopFrm.OpenTreeGridExecute(Sender:TObject);
begin
   FrmActExecute(Sender)  ;
   FhlUser.ShowTreeGridFrm(intTostr((Sender As TComponent).Tag));
 //  self.ChangeUserDataBase(self.PrivorDataBase );

end;

procedure TDesktopFrm.OpenAnalyserExecute(Sender:TObject);
var
   TmpTableName:string;
begin
   TmpTableName:=FrmActExecute(Sender)  ;
   if TmpTableName<>'' then
   FhlUser.ShowAnalyserFrm(intTostr((Sender As TComponent).Tag),null, TmpTableName,fsMDIChild);
end;

procedure TDesktopFrm.OpenTreeMgrExecute(Sender: TObject);
begin
  FrmActExecute(Sender)  ;
  FhlUser.ShowTreeMgrFrm(intTostr((Sender As TComponent).Tag));
end;
procedure TDesktopFrm.OpenActSpecialExecute(Sender: TObject);
begin
//      户
   DesktopFrm.FrmActExecute(Sender)  ;
   FhlUser.ShowSpecialFrm ((Sender As TComponent).Tag,null);

end;
procedure TDesktopFrm.LoginSystemExecute(Sender: TObject);
begin
 WindowCloseAll1Execute(Sender);
 try
     Reg;
 except

 end;

 
end;

function TDesktopFrm.Reg:Boolean;
begin
 Result:=false;
 LoginFrm:=TLoginFrm.Create(self);     //4-21
 if LoginFrm.ShowModal=mrOk then
 begin
    mainFrm.StatusBar1.Panels[0].Text :='    ['+LoginInfo.FirmCnName +']';
    mainFrm.StatusBar1.Panels[1].Text :='    ['+LoginInfo.ChainStoreName +']';
    LoginInfo.LastReceiveStr:=stringreplace( LoginInfo.LastReceiveStr,'XX_XX' , logininfo.LoginId ,[]);
    dmFrm.ConnectServer(LoginInfo.LastReceiveStr);

    InitMenu;
    dmfrm.ConfigMenu;  //设置系统菜单可用性

    Result:=true;
 end;
 FreeAndNil(LoginFrm);
end;

procedure TDesktopFrm.CloseMainFrmExecute(Sender: TObject);
begin
  Application.MainForm.Close;
  Application.Terminate;
end;

procedure TDesktopFrm.WindowCloseAll1Execute(Sender: TObject);
 var i:integer;
begin
  with Application.MainForm do
    for i:=MDIChildCount-1 downto 0 do
      MDIChildren[i].Close;
end;

procedure TDesktopFrm.WindowMaxmizeAll1Execute(Sender: TObject);
 var i:integer;
begin
  with Application.MainForm do
    for i:=0 to MDIChildCount-1 do
      MDIChildren[i].WindowState:=wsMaximized;
end;

procedure TDesktopFrm.WindowSwitch1Execute(Sender: TObject);
begin
  with Application.MainForm do
   if MDIChildCount>1 then
      MDIChildren[MDIChildCount-1].show;
end;

procedure TDesktopFrm.OpenMore2MoreExecute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm(intTostr((Sender As TComponent).Tag),null);
end;

procedure TDesktopFrm.OpenEditorExecute(Sender: TObject);
begin
  FrmActExecute(Sender)  ;
  FhlUser.ShowEditorFrm(intTostr((Sender As TComponent).Tag),null).ShowModal;
end;

procedure TDesktopFrm.TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
begin
LoginInfo.LastReceiveStr:=FhlKnl1.St_Encrypt(ClientSocket.Receiveln());
//showmessage(caption);
{
 with TLoginFrm.Create(Application) do
 begin
   if ShowModal=mrOk then
   begin
  //  InitMenu;
    InitStatusbar;
  end;
  Free;
 end;
 }
end;

procedure TDesktopFrm.Button3Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TDesktopFrm.Action1Execute(Sender: TObject);
begin
  dmFrm.ADOConnection1.Connected:=False;
  MainMenu1.Items.Clear;
end;

procedure TDesktopFrm.FormCreate(Sender: TObject);
begin
   dsMainMenu.Connection :=fhlknl1.UserConnection ;
 end;
procedure TDesktopFrm.ChangSubSysName(SubSysName: string);
begin
  logininfo.IsTool :=false;
  if fhlknl1<>nil then
     if fhlknl1.Connection.DefaultDatabase <> SubSysName then
     begin
         fhlknl1.Connection.DefaultDatabase:=SubSysName   ;
         fhlknl1.CloseSysDataSet;
     end;

end;

procedure TDesktopFrm.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  if E.Message='连接失败' then //) and (MessageDlg(#13#10'连接已中断,是否尝试新的连接?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
  begin
    with dmFrm.ADOConnection1 do
    begin
//      ShowMessage(ConnectionString);
      Connected:=False;
      Connected:=True;
    end;
    with FhlKnl1.Connection do
    begin
      Connected:=False;
      Connected:=True;
    end;
  end
  else
    MessageDlg(#13#10+E.Message,mtError,[mbOk],0);

end;

procedure TDesktopFrm.ToolBar1DblClick(Sender: TObject);
var frmDesignMainMenu:TfrmDesignMainMenu;
begin
   if LoginInfo.Sys  then  begin


       fhlknl1.Connection.DefaultDatabase :=      LoginInfo.SysDBPubName;
       frmDesignMainMenu:=TfrmDesignMainMenu.Create (nil);

       frmDesignMainMenu.ShowModal ;
       freeandnil(frmDesignMainMenu);
  end;
end;

procedure TDesktopFrm.actLockSysExecute(Sender: TObject);
begin

    self.WindowMinimizeAll1.Execute ;
    self.tmrLockSys.Enabled :=false;
    frmLockSys:= TfrmLockSys.Create (self);
     frmLockSys.ShowModal;
    begin
        self.tmrLockSys.Enabled :=true;
    end;
    
end;

procedure TDesktopFrm.tmrLockSysTimer(Sender: TObject);
begin

if (not assigned(LoginFrm) ) and (LoginInfo.LoginId <>'' )then
begin
     lockP3.X :=lockP1.X;
     lockP3.Y :=lockP1.Y;


      GetCursorPos(lockP1);
   if time=LoginInfo.LockTime  then
      GetCursorPos(lockP2);

      time:=time+1;
      //self.Caption :=' : '+inttostr(time);

   if (time>=LoginInfo.LockTime +1  ) or ( lockP3.X <>lockP1.X)  then
       time:=0;

   if (lockP1.X =lockP2.X) and (lockp1.Y =lockp2.Y ) then
   begin
             self.actLockSys.Execute ;
   end;

end;

end;

procedure TDesktopFrm.tmr1Timer(Sender: TObject);
begin
  if LoginInfo.LoginTime<>'' then
  if not logininfo.IsTool then
         dmFrm.GetQuery1('update sys_loginlog set  onlineflag='+quotedstr('')+' where  intime='+quotedstr(LoginInfo.LoginTime  ),false );
end;

procedure TDesktopFrm.OpenCRMFormExecute(Sender: TObject);
var
   TmpTableName:string;
begin
   TmpTableName:=FrmActExecute(Sender)  ;
  // if TmpTableName<>'' then
   FhlUser.ShowCRMFrm(intTostr((Sender As TComponent).Tag),'',TmpTableName);
end;

procedure TDesktopFrm.actRunExeExecute(Sender: TObject);
var filename:string;
var parameters:string;
begin
    case (Sender As TComponent).Tag of
      1:
      begin
        filename:= 'Service.exe '+logininfo.LoginId;
      end;
      2:
      filename:= 'SendManage.exe '+logininfo.LoginId;
    end;
    parameters:= filename+' '+string(dmfrm.ADOConnection1.DefaultDatabase);

    winexec(pchar(parameters ),0)  ;
end;

procedure TDesktopFrm.actDemoExecute(Sender: TObject);
begin
  FhlUser.ShowDemoFrm((Sender As TComponent).Tag,TmenuItem(Sender).Caption  );
end;

Function  TDesktopFrm.FrmActExecute(sender:Tobject):string;
var
    FEName,Fsql,Rdmint:string;
    MaxAuthorise,CurrentAuthorise:integer;
begin
    dsMainMenu.Locate('f01',Tcomponent(Sender).name ,[]);
    Randomize;
    Rdmint:= inttostr(Random(1000000));

    if  dsMainMenu.FieldByName('F15').AsBoolean  then
    begin
        result:='-1';

        logininfo.IsTool :=true;
        if logininfo.PrivorUserDataBase =''  then
        logininfo.PrivorUserDataBase :=dmfrm.ADOConnection1.DefaultDatabase ;

        if fhlknl1.Connection.DefaultDatabase <> dsMainMenu.FieldByName('ToolSysDBName').AsString then
           fhlknl1.Connection.DefaultDatabase:=dsMainMenu.FieldByName('ToolSysDBName').AsString ;  ;

        if 'SysMaintain40'=Tcomponent(Sender).name then
           fhluser.changeUserDataBase (logininfo.SysDBPubName )
        else
           fhluser.changeUserDataBase (dsMainMenu.FieldByName('subSysDBName').AsString)   ;
    end
    else
    begin
       logininfo.IsTool :=false;
       if  logininfo.PrivorUserDataBase <>'' then
         fhluser.changeUserDataBase ( logininfo.PrivorUserDataBase )   ;

       if fhlknl1.Connection.DefaultDatabase <> dsMainMenu.FieldByName('SubSysDBName').AsString then
       begin
          fhlknl1.Connection.DefaultDatabase:=dsMainMenu.FieldByName('SubSysDBName').AsString   ;
          fhlknl1.CloseSysDataSet;
       end;
       FEName:=dsMainMenu.FieldByName('F18').AsString   ;

       Fsql:='  select * from '+logininfo.SysDBPubName +'.dbo.SysAuthoriseClient where FEName='+quotedstr(FEName);
       fhlknl1.Kl_GetQuery2(Fsql);
       MaxAuthorise:=0;
       if not fhlknl1.FreeQuery.IsEmpty then
       MaxAuthorise:=fhlknl1.FreeQuery.fieldbyname('FAuthiruseCnt').AsInteger ;

       FEName:=FEName;

       Fsql:='select count(*)as CurrentAuthorise from  tempdb.dbo.sysobjects where name like '+quotedstr('##'+FEName+'%') ;
       fhlknl1.Kl_GetQuery2(Fsql);
       CurrentAuthorise:=0;
       if not fhlknl1.FreeQuery.IsEmpty then
          CurrentAuthorise:=fhlknl1.FreeQuery.fieldbyname('CurrentAuthorise').AsInteger ;

       if FEName<>'' then
       if (CurrentAuthorise>=MaxAuthorise ) and (CurrentAuthorise<>0)then
       begin
           showmessage('最大客户端数量：'+inttostr(MaxAuthorise )+char(13)+ '当在线的客户端数：'+inttostr(CurrentAuthorise)
                       +char(13)+char(13)+'授权客户端数量已经超过最大值');
           exit;
       end
       else
       begin
           Fsql:=' select  '+quotedstr(logininfo.LoginId)+' as LoginID,'
                  +quotedstr(logininfo.EmpId )+' as EmpID ,'
                  //+quotedstr(Tmenuitem(Sender).Caption )+' as MenuName ,'
                  +quotedstr(dsMainMenu.FieldByName('F04').AsString  )+' as MenuName ,'

                  +'getdate() as LoginTime into '+'##'+ FEName +Rdmint +'  ';
           result:= ( '##'+FEName +Rdmint);
           fhlknl1.Kl_GetQuery2(Fsql,false);
       end;
    end;
end;

procedure TDesktopFrm.OpenMainMenuExecute(Sender: TObject);
begin
   FrmActExecute(Sender)  ;
   FhlUser.ShowMainMenuFrm(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.OpenDefaultWindow;
var sql:string;
var actID,tag:integer;
var DefaultMenu:Tmenuitem;
begin
    DefaultMenu:=Tmenuitem.Create(nil);

    sql:='select   B.name ,B.F_DefaultActID,B.F_Tag ,C.f01      '
        +'from sys_groupuser A  '
        +'join sys_group     B on A.GroupID=B.Code '
        +'join '+logininfo.PubDataBasePreFix+logininfo.SysDBPubName +'.dbo.T511 C on B.F_DefaultActID = C.f05         and B.F_Tag=C.f06 '
        +'where A.UserID='+quotedstr(logininfo.LoginId )+'  order by F.f01, GroupID';

        dmfrm.GetQuery1(sql);
        if not dmfrm.FreeQuery1.IsEmpty then
        begin
           while (not dmfrm.FreeQuery1.Eof ) do
           begin
                 actID:=  dmfrm.FreeQuery1.fieldbyname('F_DefaultActID').AsInteger ;
                 tag  :=dmfrm.FreeQuery1.fieldbyname('F_Tag').AsInteger ;
                 DefaultMenu.Name :=dmfrm.FreeQuery1.fieldbyname('f01').AsString  ;
                 DefaultMenu.Tag := tag;
                 if  (actID>-1 ) and (Tag>-1) then
                 begin
                     DesktopFrm.ActionList1.Actions [actID].OnExecute (DefaultMenu);
                 end;
                 dmfrm.FreeQuery1.Next;
           end;
        end;
    DefaultMenu.Free ;
end;

procedure TDesktopFrm.OpenBillExExecute(Sender: TObject);
var
   TmpTableName:string;
begin
   TmpTableName:=FrmActExecute(Sender)  ;
   if TmpTableName <>'' then
  FhlUser.ShowBillFrm_Ex(intTostr((Sender As TComponent).Tag),'',TmpTableName);
end;



procedure TDesktopFrm.OpenSendMsgExecute(Sender: TObject);
var frm:TFrmSendMsg;
begin
  try
    frm:=TFrmSendMsg.Create(nil);
    frm.ShowModal;
  finally
    frm.Free;
  end;
end;

procedure TDesktopFrm.btn1Click(Sender: TObject);
var  clientdataset1 :TClientDataSet;
var  DataSetProvider1:TDataSetProvider;
var  str:string;
begin
    try
         clientdataset1:=TClientDataSet.Create(self);
         DataSetProvider1:=TDataSetProvider.Create(self);

         FhlKnl1.Kl_GetQuery2('select top 10  * from T201 ' );
         DataSetProvider1.DataSet :=FhlKnl1.FreeQuery;

         dmFrm.ADOConnection1.Close;
         dmFrm.ADOConnection2.Close;

         FhlKnl1.FreeQuery.Close;

         clientdataset1.Data:=  DataSetProvider1.Data;
         clientdataset1.Close;
         str:='sdf';

    except

    end;

end;

procedure TDesktopFrm.OpenVoucherExecute(Sender: TObject);
var
   TmpTableName:string;
begin
   TmpTableName:=FrmActExecute(Sender)  ;
   if TmpTableName <>'' then
  FhlUser.ShowVoucher(intTostr((Sender As TComponent).Tag),'',TmpTableName);
end;
end.

