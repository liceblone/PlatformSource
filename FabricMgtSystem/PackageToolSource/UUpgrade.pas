unit UUpgrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,IniFiles,
  Dialogs, StdCtrls, VCLUnZip, VCLZip, DB, ADODB ,UnitPub ;

type
  TFUpgrade = class(TForm)
    GroupBox2: TGroupBox;
    BtnBackUpUserConfig: TButton;
    BtnUsersysDBDetattach: TButton;
    BtnRenameDir: TButton;
    BtnAttachSYSDataBase: TButton;
    BtnRunInitialScript: TButton;
    BtnRunScript: TButton;
    BtnRestoreSysConfig: TButton;
    BtnUnCompress: TButton;
    mmoLogs: TMemo;
    VCLUnZip1: TVCLUnZip;
    VCLUnZip2: TVCLUnZip;
    VCLUnZip3: TVCLUnZip;
    VCLZip1: TVCLZip;
    GroupBox1: TGroupBox;
    cbbUserDB: TComboBox;
    lbl: TLabel;
    btnAuthorization: TButton;
    procedure BtnUnCompressClick(Sender: TObject);
    procedure BtnBackUpUserConfigClick(Sender: TObject);
    procedure BtnUsersysDBDetattachClick(Sender: TObject);
    procedure  ChangeTimeStamp;
    procedure BtnRenameDirClick(Sender: TObject);
    procedure BtnAttachSYSDataBaseClick(Sender: TObject);
    procedure BtnRunInitialScriptClick(Sender: TObject);
    procedure BtnRunScriptClick(Sender: TObject);
    procedure BtnRestoreSysConfigClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAuthorizationClick(Sender: TObject);
  private
    { Private declarations }
    LstUserDataInPub:TStrings;
  public
    { Public declarations }
  end;

var
  FUpgrade: TFUpgrade;
  Logger:TTxtLogger;
  const PackName='package.zip';
  const PackagePath='package';
  
implementation

uses uDataModule;

{$R *.dfm}

procedure TFUpgrade.ChangeTimeStamp;
var inif: TIniFile ;
var ServerName,User, password:string;
begin

  inif:=TIniFile.Create(dmfrm.InstallPath +'\updateweb\'+ 'Update.inf' );     //update   file update.ini timestamp
   inif.WriteString ('version','Version',datetimetostr(now));
   inif.free ;

end;
procedure TFUpgrade.BtnUnCompressClick(Sender: TObject);
begin
  try
        screen.Cursor :=    crSQLWait ;
     try
        vclzip1.ZipName :='package\'+ PackName ;
        self.Caption :=vclzip1.ZipName ;
        vclzip1.DoAll :=True ;
        vclzip1.DestDir :=  PackagePath  ;
        vclzip1.RootDir := '';
        vclzip1.OverwriteMode :=Always;
        vclzip1.RecreateDirs := False ;
        vclzip1.RetainAttributes := true;
        vclzip1.Password := '1' ;//Password.Text;
        vclzip1.UnZip  ;
        mmoLogs.Lines.Add ('解压成功！')  ;
    except
    on Err :Exception do
       mmoLogs.Lines.Add (Err.Message )  ;
    end;
  finally
       screen.Cursor :=    crdefault ;
  end;
end;

procedure TFUpgrade.BtnBackUpUserConfigClick(Sender: TObject);
var qry:Tadoquery;
tablelist:Tstrings;
i:integer;
begin
    try
       screen.Cursor :=    crSQLWait ;
       try
        Logger.Save('--backup user config '+#9);
        tablelist:=Tstringlist.Create ;

       

        tablelist.Add('T505');  //col
        tablelist.Add('T503');  //label
        tablelist.Add('T502');  //control

        tablelist.Add('T506'); //print
        tablelist.Add('T516'); //print  gird col
        tablelist.Add('T102');  //field name

        for i:=0 to LstUserDataInPub.Count -1 do
            tablelist.Add(LstUserDataInPub[i]);

        qry:=Tadoquery.Create(nil);
        qry.Connection :=dmfrm.UserCnn  ;
        qry.Connection.DefaultDatabase :=logininfo.LogDataBaseName  ;
        for i:=0 to tablelist.Count -1 do
        begin
            qry.SQL.Clear;
            qry.SQL.Add('if exists(select *From sysobjects where name='+quotedstr(tablelist[i]+logininfo.SysDBPubName)+')');
            qry.SQL.Add('exec sp_rename ' +quotedstr(tablelist[i]+logininfo.SysDBPubName)+ ',' +quotedstr(tablelist[i]+logininfo.SysDBPubName+'_'+FormatDateTime('mmddhhmmss', Now ))+ ',''OBJECT''');
            qry.ExecSQL ;

            qry.SQL.Clear;
            qry.SQL.Add('if exists(select *From sysobjects where name='+quotedstr(tablelist[i]+logininfo.SysDBase)+')');
            qry.SQL.Add('exec sp_rename ' +quotedstr(tablelist[i]+logininfo.SysDBase)+ ',' +quotedstr(tablelist[i]+logininfo.SysDBase+'_'+FormatDateTime('mmddhhmmss', Now ))+ ',''OBJECT''');
            qry.ExecSQL ;

            qry.SQL.Clear;
            qry.SQL.Add(' if exists(select *from '+logininfo.SysDBPubName +'.dbo.sysobjects where name= '+quotedstr( tablelist[i] ) +'   )');
            qry.SQL.Add(' select * into '+logininfo.LogDataBaseName +'.dbo.'+tablelist[i]+logininfo.SysDBPubName+' from  '+logininfo.SysDBPubName +'.dbo.'+ tablelist[i] );
            qry.ExecSQL ;

            qry.SQL.Clear;
            qry.SQL.Add(' if exists(select *from '+logininfo.SysDBase +'.dbo.sysobjects where name= '+quotedstr( tablelist[i] ) +'   )');
            qry.SQL.Add(' select * into '+logininfo.LogDataBaseName +'.dbo.'+ tablelist[i]+logininfo.SysDBase +'  from  '+logininfo.SysDBase  +'.dbo.'+ tablelist[i] );

            Logger.Save(qry.SQL.Text);
            qry.ExecSQL ;

        end;

        //showmessage('ok');

      mmoLogs.Lines.Add ('备份用户设置成功！')  ;
      except
      on Err :Exception do
         mmoLogs.Lines.Add (Err.Message )  ;
      end;
    finally
      tablelist.Free ;
      qry.Free ;
       screen.Cursor :=    crdefault ;
    end;



end;

procedure TFUpgrade.BtnUsersysDBDetattachClick(Sender: TObject);

  var qry:Tadoquery;
begin
  try
    screen.Cursor :=    crSQLWait ;
    try

      qry:=Tadoquery.Create(nil);
      qry.Connection :=dmfrm.SysConnection1;
      dmfrm.SysConnection1.DefaultDatabase := 'master' ;

      qry.SQL.Add('Select       DB_Name(DBID) ,hostname,*  from   master..sysprocesses ');
      qry.SQL.Add('    where DB_Name(DBID) in (');
      qry.SQL.Add(    quotedstr(logininfo.SysDBPubName)+','+quotedstr(logininfo.SysDBase )+',' );
      qry.SQL.Add(    quotedstr('OLD'+logininfo.SysDBPubName)+','+quotedstr('OLD'+logininfo.SysDBase )  );
      qry.SQL.Add(')')  ;
      qry.Open ;

      if not qry.IsEmpty then
      begin
        showmessage('数据库在使用');
        exit;
      end;
      if    not fileexists( PackagePath+'\'+  logininfo.SysDBPubName+'.MDF' )   then
       begin
           mmoLogs.Lines.Add (PackagePath+'\'+  logininfo.SysDBPubName+'.MDF'+'数据库文件不存在,请检查路径!');
           exit;
       end;
       if   not fileexists( PackagePath+'\'+logininfo.SysDBase+'.MDF' )   then
       begin
           mmoLogs.Lines.Add (PackagePath+'\'+logininfo.SysDBase+'.MDF' +'数据库文件不存在,请检查路径!');
           exit;
       end;

      Logger.Save('--dettach database'+#9);
      qry.SQL.Add('EXEC sp_detach_db '+quotedstr(logininfo.SysDBPubName)+', true'     +#13#10 );
      qry.SQL.Add('EXEC sp_detach_db '+quotedstr(logininfo.SysDBase)+'     , true '+#13#10   );

      Logger.Save(qry.SQL.Text);
      qry.ExecSQL ;
      qry.Close;


      BtnRenameDirClick(Sender); //重命名 老的数据库

      copyfile(pchar(PackagePath+'\'+  logininfo.SysDBPubName+'.MDF' )  ,pchar(dmfrm. InstallPath  +'\DataBase\SysData'+'\'+logininfo.SysDBPubName+'.MDF')    ,false );
      copyfile(pchar(PackagePath+'\'+logininfo.SysDBPubName+'_LOG.LDF')   ,pchar(dmfrm.InstallPath +'\DataBase\SysData'+'\'+logininfo.SysDBPubName+'_LOG.LDF')    ,false  );
      copyfile(pchar( PackagePath+'\'+logininfo.SysDBase+'.MDF'  ) ,pchar(dmfrm.InstallPath +'\DataBase\SysData'+'\'+logininfo.SysDBase+'.MDF')    ,false );
      copyfile(pchar(PackagePath+'\'+logininfo.SysDBase+'_LOG.LDF') ,pchar(dmfrm.InstallPath +'\DataBase\SysData'+'\'+logininfo.SysDBase+'_LOG.LDF')    ,false );

      copyfile(pchar(PackagePath+'\'+ dmfrm.MainExeFileName) ,pchar(dmfrm.InstallPath +'\updateweb\'+ StringReplace(dmfrm.MainExeFileName ,'.exe','',[])+'.inf')    ,false );
      copyfile(pchar( PackagePath+'\'+ 'Config.ini') ,pchar(dmfrm.InstallPath +'\updateweb\'+ 'Config.inf')    ,false );

      ChangeTimeStamp ;
      copyfile(pchar( PackagePath+'\'+ 'Update.inf') ,pchar(dmfrm.InstallPath +'\UpdateWeb\'+ 'Update.inf')    ,false );
      copyfile(pchar( PackagePath+'\'+ 'PrjMetaData.exe') ,pchar(dmfrm.InstallPath +'\client\'+  'PrjMetaData.exe')    ,false );

      mmoLogs.Lines.Add ('覆盖文件成功！');
      except
      on err:exception    do
      begin
          showmessage(err.Message );
      end;
    end;

    finally
      qry.Free ;

       screen.Cursor :=    crdefault ;
    end;
end;

procedure TFUpgrade.BtnRenameDirClick(Sender: TObject);
var strnow:string;
begin
  try
  strnow:=FormatDateTime('yyyy-mm-dd hhh.mm.ss', Now );;

    RenDirectory( dmfrm.InstallPath +'\DataBase\OldSysData',dmfrm.InstallPath +'\DataBase\OldSysData'+strnow);
   //  DeleteDir(edtInstallPath.Text +'\DataBase\OldSysData');
    RenDirectory( dmfrm.InstallPath  +'\DataBase\SysData', dmfrm.InstallPath+'\DataBase\OldSysData');
    CreateDirectory(pchar( dmfrm.InstallPath+'\DataBase\SysData'), nil);
     mmoLogs.Lines.Add ('重命名老的系统配置库ok' )  ;
  except
    on err:exception do
    begin
         mmoLogs.Lines.Add (Err.Message )  ;
    end;

  end;

end;

procedure TFUpgrade.BtnAttachSYSDataBaseClick(Sender: TObject);
var qry:Tadoquery;
begin
  try
       screen.Cursor :=    crSQLWait ;
      try
        Logger.Save('--attach database '+#9);
        qry:=Tadoquery.Create(nil);
        qry.Connection :=dmfrm.CnnMaster ;

        qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.SysDBPubName)+',   ');
        qry.SQL.Add('   @filename1 = N'+ quotedstr( dmfrm.InstallPath  +'\DataBase\SysData\'+ logininfo.SysDBPubName+'.MDF')+',' );
        qry.SQL.Add('   @filename2 = N'+ quotedstr( dmfrm.InstallPath  +'\DataBase\SysData\'+ logininfo.SysDBPubName+'_Log.LDF') );

        qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.SysDBase)+',   ');
        qry.SQL.Add('   @filename1 = N'+ quotedstr( dmfrm.InstallPath  +'\DataBase\SysData\'+ logininfo.SysDBase+'.MDF')+',' );
        qry.SQL.Add('   @filename2 = N'+ quotedstr( dmfrm.InstallPath  +'\DataBase\SysData\'+ logininfo.SysDBase+'_Log.LDF') );

        Logger.Save(qry.SQL.Text);
        qry.ExecSQL ;

        mmoLogs.Lines.Add (' 附加新配置数据库ok' )  ;
     except
        on err:exception    do
        begin
              mmoLogs.Lines.Add (Err.Message )  ;
        end;
     end;
  finally
    qry.Free ;

       screen.Cursor :=    crdefault;
  end;
end;
procedure TFUpgrade.BtnRunInitialScriptClick(Sender: TObject);
var qry:Tadoquery;
var scriptLst:TStrings;
var filename,sqlFileName:string;
var i:integer;
begin
  try
    screen.Cursor :=    crSQLWait ;
    try

       scriptLst :=MakeFileList('Package','.sql');
      filename  :='initial_'+dmfrm.Version  +'.sql' ;

      for i:=0 to scriptLst.Count -1  do
      begin
        sqlFileName:=ExtractFileName(scriptLst[i]) ;

        if Pos('initial_', sqlFileName )>0 then
        begin
          sqlFileName:=ExtractFileDir( Application.ExeName)+'\Package\'+sqlFileName;
          if FileExists(sqlFileName) then
          begin
               mmoLogs.Lines.Add ('准备运行...'+ scriptLst[i] ) ;
               mmoLogs.Lines.Add ('...'  ) ;
               mmoLogs.Lines.Add (dmfrm.RunScript( sqlFileName,cbbUserDB.Items[ cbbUserDB.itemindex]  )   ) ;
               self.mmoLogs.Lines.Add(sqlFileName +' 运行成功！'  );
          end
          else
            self.mmoLogs.Lines.Add(sqlFileName+' 不存在！'  );
        end;
       
      end;
  except
    on err:Exception do
    begin
      self.mmoLogs.Lines.Add(err.Message  );
    end;
  end;
  finally
      screen.Cursor :=    crdefault;
  end;
end;

procedure TFUpgrade.BtnRunScriptClick(Sender: TObject);
var i:integer;
var filename,sqlFileName:string;
var scriptLst:TStrings;
begin
  try
    screen.Cursor :=    crSQLWait ;
    try
      scriptLst :=MakeFileList('Package','.sql');
      filename  :='UpgradeScript'+dmfrm.Version  +'.sql' ;

      for i:=0 to scriptLst.Count -1  do
      begin
         sqlFileName:=ExtractFileName(scriptLst[i]) ;
        
          if Pos('UpgradeScript', sqlFileName )>0 then
          begin
             sqlFileName:=ExtractFileDir( Application.ExeName)+'\Package\'+sqlFileName;
             if FileExists(sqlFileName) then
             begin
               mmoLogs.Lines.Add ('准备运行...'+ scriptLst[i] ) ;
               mmoLogs.Lines.Add ('...'  ) ;

               mmoLogs.Lines.Add (dmfrm.RunScript(sqlFileName ,cbbUserDB.Items[cbbUserDB.itemindex] )) ;
               self.mmoLogs.Lines.Add(sqlFileName +' 运行成功！'  );
             end
             else
             self.mmoLogs.Lines.Add(sqlFileName +' 不存在！'  );
          end;
      end;
  except
    on err:Exception do
    begin
            self.mmoLogs.Lines.Add(err.Message  );
    end;
  end;
  finally
      screen.Cursor :=    crdefault;
  end;
end;


procedure TFUpgrade.BtnRestoreSysConfigClick(Sender: TObject);
var qry:Tadoquery;
var i:Integer;
begin
  try
    Logger.Save('--restore config'+#9);
    screen.Cursor :=    crSQLWait ;
    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.UserCnn;
    qry.Connection.DefaultDatabase :=LoginInfo.UserDB;
    qry.SQL.Clear;
    qry.SQL.Add( 'exec Pr_RestoreSysData '+quotedstr(LoginInfo.LogDataBaseName )+ ','+quotedstr(LoginInfo.SysDBPubName  )   ) ;
    Logger.Save(qry.SQL.Text);
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add( 'exec Pr_RestoreSysData '+quotedstr(LoginInfo.LogDataBaseName )+ ','+quotedstr(LoginInfo.SysDBase   )   ) ;
    Logger.Save(qry.SQL.Text);
    qry.ExecSQL;

    qry.Connection.DefaultDatabase :=LoginInfo.SysDBPubName;

    for i:=0 to LstUserDataInPub.Count -1 do
    begin
      qry.SQL.Clear;
      qry.SQL.Add( format('if exists(select * from sysobjects where id=object_id(%s) ) drop table %s' , [ quotedstr(LstUserDataInPub[i]) ,LstUserDataInPub[i]] )) ;
    //  qry.SQL.Add( ' drop table  '+LstUserDataInPub[i] );
      qry.SQL.Add( ' select * into  '+LstUserDataInPub[i]+' from '+logininfo.LogDataBaseName +'.dbo.'+LstUserDataInPub[i]+LoginInfo.SysDBPubName);
      Logger.Save(qry.SQL.Text);
      qry.ExecSQL;

    end;



    self.mmoLogs.Lines.Add ('恢复用户配置ok');
  finally
    qry.Free ;
    screen.Cursor :=    crdefault;
  end;
end;
procedure TFUpgrade.FormCreate(Sender: TObject);
var qry:TADOQuery;
begin
  Self.mmoLogs.Clear;
  self.mmoLogs.Lines.Add( dmfrm.Version );

  try
    qry:=TADOQuery.Create(nil);
    qry.Connection :=dmfrm.SysConnection1;
    qry.SQL.Add('  select *From sys_DataBase') ;
    qry.Open;

    while (not qry.Eof ) do
    begin
       self.cbbUserDB.Items.Add(  qry.fieldbyname('db').AsString ) ;
       qry.Next;
    end;
    cbbUserDB.ItemIndex:=0;

    LstUserDataInPub:=Tstringlist.Create ;

     LstUserDataInPub.Clear;
        LstUserDataInPub.Add('TAuthorizeObject');
        LstUserDataInPub.Add('TAuthorizeItem');
        LstUserDataInPub.Add('Sys_AllowdBranch');  //机器授权信息
        LstUserDataInPub.Add('sys_branch');
  finally
    qry.Free ;
  end;
  Logger:=TTxtLogger.Create;
end;

procedure TFUpgrade.FormDestroy(Sender: TObject);
var dir:string;
begin
  LstUserDataInPub.Free;

  dir :=ExtractFilePath(Application.ExeName )+  'UpgradeLog\' ;

  if DirectoryExists(dir) then
  self.mmoLogs.Lines.SaveToFile(dir+formatdatetime('yyyy-MM-dd-HHmmss',now)+'.log');

  Logger.Free;
end;

procedure TFUpgrade.btnAuthorizationClick(Sender: TObject);
var
  fComputerName:string ;
  fIpAddr:string;
  fMac:string;
  qry:TADOQuery;
begin
    fComputerName:=Os_GetComputerName;
    fIpAddr:= Os_GetComputerIp;
    fMac:= Os_GetComputerMac ;
    Logger.Save('--Authorize'+#9);
    try
      qry:=TADOQuery.Create(nil);
      qry.Connection :=dmfrm.SysConnection1 ;
      qry.SQL.Add(' update '+LoginInfo.SysDBPubName+'..Sys_AllowdBranch set FisUse=1  ' ) ;
      qry.SQL.add(' where FMachineName ='''+fComputerName+'''')  ;
      qry.SQL.add(' and     FMac ='''+fMac+'''')          ;

      Logger.Save(qry.SQL.Text);
      qry.ExecSQL ;
    finally
       qry.Free ;
    end;
end;

end.

