unit ULogininfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ComObj,  IniFiles,
  Dialogs, StdCtrls, DB, ADODB;

type
  TFrmInstall = class(TForm)
    edtPubDB: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtPubDBUserName: TEdit;
    edtPubDbPassword: TEdit;
    btnTest: TButton;
    GrpInstall: TGroupBox;
    BtnCreateVirtual: TButton;
    BtnAttachUserAndSysDataBase: TButton;
    lblInstallPath: TLabel;
    Qry1: TADOQuery;
    lblMsg: TLabel;
    btnExit: TButton;
    procedure btnTestClick(Sender: TObject);
    procedure BtnCreateVirtualClick(Sender: TObject);
    procedure BtnAttachUserAndSysDataBaseClick(Sender: TObject);
    procedure AttachDB(ABFileName,DBName:string);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInstall: TFrmInstall;

implementation

uses uDataModule;

{$R *.dfm}

procedure TFrmInstall.btnTestClick(Sender: TObject);
var cnn,PubDBFileName:string;
var inif2: TIniFile;
begin
  cnn:=format('Provider=SQLOLEDB.1;'+
  'Persist Security Info=true;'+
  'User ID=%s;'+
  'Password=%s;'+
  'Initial Catalog=%s;'+
  'Data Source=%s;'+
  'Use Procedure for Prepare=1;'+
  'Auto Translate=True;'+
  'Packet Size=4096;'+
  'Workstation ID=xts4;'+
  'Use Encryption for Data=False;'+
  'Tag with column collation when possible=False',
  [self.edtPubDBUserName.Text ,self.edtPubDbPassword.Text , 'master' ,'.' ]);

  PubDBFileName:= dmfrm.installPath  +'\database\sysdata\'+self.edtPubDB.Text +'.mdf' ;
  //Self.Caption :=PubDBFileName ;
   if not FileExists( PubDBFileName )  then
   begin
     ShowMessage('主数据库名不存在!');
     Exit;
   end;

  try
    logininfo.SysDBPubName:=Self.edtPubDB.Text ;
    dmfrm.CnnMaster.ConnectionString:=cnn;
    dmfrm.CnnMaster.Open ;

    self.qry1.ConnectionString :=cnn;
    qry1.SQL.Clear;
    qry1.SQL.Add('select 1');
    qry1.Open;

    lblMsg.Caption :='数据库连接成功！';

    self.BtnCreateVirtual.Enabled :=True;
    BtnAttachUserAndSysDataBase.Enabled :=True;

    inif2:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
    inif2.WriteString ('DBConn','DataBase',SavePass( self.edtPubDB.Text  )  ) ;
    inif2.WriteString ('DBConn','User',SavePass( 'sa'  )) ;
    inif2.WriteString ('DBConn','Password',SavePass( self.edtPubDbPassword.Text  )  ) ;
    inif2.WriteString ('DBConn','Server',SavePass('.')  ) ;

    inif2.Free;

  except
     on err:Exception do
      ShowMessage(err.Message );
  end;
end;

procedure TFrmInstall.BtnCreateVirtualClick(Sender: TObject);
var
      WebSite,   WebServer,   WebRoot,   VDir:   Variant;

begin

  try
    screen.Cursor :=    crSQLWait ;
    if ServiceUninstalled('127.0.0.1','IISADMIN') then
    begin
      showmessage('iis 未安装！');
      WinExec('RunDLL32.exe Shell32.dll,Control_RunDLL AppWiz.cpl,,2', SW_SHOWNORMAL);
      exit;
    end;
    if   ServiceStopped('127.0.0.1','IISADMIN') then
    begin
      showmessage('iis 未启动');
      exit;
    end;

    WebSite   :=   CreateOleObject('IISNamespace');
    WebSite   :=   WebSite.GetObject('IIsWebService',   'localhost/w3svc');
    WebServer   :=   WebSite.GetObject('IIsWebServer',   '1');
    WebRoot   :=   WebServer.GetObject('IIsWebVirtualDir',   'Root');
    try
      WebRoot.delete('IIsWebVirtualDir',   'UpdateWeb');
    except
    end;

    VDir   :=   WebRoot.Create('IIsWebVirtualDir',   'UpdateWeb');
    VDir.AccessRead   :=   True;
    VDir.AccessExecute:=True;//可运行执行文件
    VDir.EnableDirBrowsing:=true;//允许浏览目录
    VDir.DefaultDoc:='1.htm';
    VDir.EnableDefaultDoc:=true;
    //VDir.ip:='127.0.0.1';
    VDir.AppCreate(1);

    VDir.AppFriendlyName:='UpdateWeb';
    VDir.Path   :=  dmfrm.InstallPath  +'\UpdateWeb';

    VDir.SetInfo;
    RenameFile( dmfrm.InstallPath  +'\UpdateWeb\'+dmfrm.MainExeFileName,  dmfrm.InstallPath  +'\UpdateWeb\'+StringReplace(dmfrm.MainExeFileName ,'.exe','',[])+'.inf' );
    lblMsg.Caption :='更新网站建立成功！';
  finally
      screen.Cursor :=    crdefault;
  end;
end;

procedure TFrmInstall.BtnAttachUserAndSysDataBaseClick(Sender: TObject);
var qry:Tadoquery;
var param,sql:string;

begin
  try
    try
      //SELF.Caption :=dmfrm.InstallPath +'\DataBase\UserData' +'\'+ logininfo.UserDB +'.MDF';
      screen.Cursor :=    crSQLWait ;
      self.AttachDB( dmfrm.InstallPath  +'\DataBase\SysData\'+ logininfo.SysDBPubName,logininfo.SysDBPubName   );

      qry:=Tadoquery.Create(nil);
      qry.Connection :=dmfrm.CnnMaster ;
      qry.Connection.DefaultDatabase  :=logininfo.SysDBPubName ;

      qry.SQL.Add(' select ''DataBase\SysData\''+f02 ,f02 from T800 where f05<>1 and f04<>1 union all   select ''DataBase\UserData\''+db,db From sys_DataBase ');
      qry.SQL.Add(' union all select ''DataBase\UserData\''+db+''Log'' ,db+''Log'' From sys_DataBase where IsMainUserData=1 ');

      qry.Open ;

      while(not qry.Eof ) do
      begin
             self.AttachDB( dmfrm.InstallPath   +'\'+ qry.Fields[0].AsString ,qry.Fields[1].AsString   )    ;

         qry.Next ;
      end;


      qry.Close;
      qry.SQL.Clear;
      sql:=sql+ 'insert into '+logininfo.SysDBPubName + '.dbo.Sys_AllowdBranch(FBranchCode,FIsUse,FMac,FIP,FMachineName)'  ;
      sql:=sql+ 'select Code,1,'''+ logininfo.FMac   +''','''+logininfo.FIP +''','''+ logininfo.FMachineName   +''' from ' ;
      sql:=sql+  logininfo.SysDBPubName + '.dbo.sys_branch' ;
      qry.SQL.Add(sql);

      qry.ExecSQL ;


      self.btnExit.Enabled:=true;
     // Application.Terminate;
      // showmessage('所有数据库附加成功！');
    except
      on err:exception do
      begin
        showmessage(err.Message);
      end;
    end;
  finally
    qry.Free ;
    screen.Cursor :=    crDefault;
  end;
end;

procedure TFrmInstall.FormActivate(Sender: TObject);
var scriptLst:Tstrings;
var i:integer;
begin
         scriptLst :=MakeFileList('..\DataBase\sysdata','.MDF');
   //      self.Caption :=  scriptLst.CommaText;
    if  scriptLst.Count >0 then
    begin
       for i:=0 to scriptLst.Count -1 do
       begin
        //ShowMessage ( scriptLst[i]+' - '+inttostr(  Pos(UpperCase('Basicinfo'),UpperCase(scriptLst[i]) ) ) );
          if    Pos(UpperCase('Basicinfo'),UpperCase(scriptLst[i]) )>0    then
          begin
            //ShowMessage(StringReplace( ExtractFileName(scriptLst[i]),'.MDF','',[])) ;
            self.edtPubDB.Text:=StringReplace( ExtractFileName(scriptLst[i]),'.MDF','',[]);
          end;
       end
      // self.edtPubDB.Text:=  ExtractFileName (scriptLst[i]) ;
    end;
      if self.edtPubDB.Text='' then
       edtPubDB.Enabled :=True
       else
        edtPubDB.Enabled :=False;
    scriptLst.Free ;
end;

procedure TFrmInstall.FormCreate(Sender: TObject);
begin
self.lblInstallPath.Caption :=dmfrm.InstallPath ;
end;

procedure TFrmInstall.AttachDB(ABFileName,DBName: string);
var qry:Tadoquery;
begin
  try

    //SELF.Caption :=dmfrm.InstallPath +'\DataBase\UserData' +'\'+ logininfo.UserDB +'.MDF';
    screen.Cursor :=    crSQLWait ;

    qry:=Tadoquery.Create(nil);


    

    qry.Connection :=dmfrm.CnnMaster ;

    qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(DBName)+',   ');
    qry.SQL.Add('   @filename1 = N'+ quotedstr(ABFileName+'.MDF')+',' );
    qry.SQL.Add('   @filename2 = N'+ quotedstr(ABFileName+'_Log.LDF') );
    if  fileexists(ABFileName+'.MDF') then
    begin
       qry.ExecSQL ;
       lblMsg.Caption :=DBName+'附加成功';
    end
    else
    begin
       lblMsg.Caption :=DBName+'不存在！';
        // showmessage(ABFileName+'.MDF');
    end;

  finally
    qry.Free ;
    screen.Cursor :=    crDefault;
  end;
end;


procedure TFrmInstall.btnExitClick(Sender: TObject);
var param:string;
begin
  param:=dmfrm.MainExeFileName  ;
  winexec(pchar(param), SW_MAXIMIZE	) ;
  application.Terminate;
end;

end.
