unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids,inifiles, ComCtrls, ExtCtrls,  ComObj,StrUtils,
  VCLUnZip, VCLZip, FileCtrl  ,WinSvc, shellapi,WinSock ,unitpub;


type
  TFrmMain = class(TForm)
    DsFlds: TDataSource;
    AdoDsFlds: TADODataSet;
    PageControl2: TPageControl;
    tsTabCreateScript: TTabSheet;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    MmScript: TMemo;
    BtnCreateProcScript: TButton;
    TabSheet2: TTabSheet;
    BtnLstFields: TButton;
    BtnFldsTablesScript: TButton;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    GridFlds: TDBGrid;
    MmTablesAndFields: TMemo;
    TabSheet3: TTabSheet;
    mmDeletedFlds: TMemo;
    BtnAllDeletedFields: TButton;
    ADOObj: TADOQuery;
    DataSource1: TDataSource;
    DBGridObj: TDBGrid;
    BtnLstAllChgedObj: TButton;
    BtnCreateFile: TButton;
    edtVersion: TEdit;
    Label2: TLabel;
    tsDettachFiles: TTabSheet;
    BtnDetattach: TButton;
    edtSysDbPath: TEdit;
    Label1: TLabel;
    VCLZip1: TVCLZip;
    VCLUnZip1: TVCLUnZip;
    FlstPackage: TFileListBox;
    edtPassword: TEdit;
    Label3: TLabel;
    BtnAttach: TButton;
    chkCompress: TCheckBox;
    BtnCompressExe: TButton;
    TabSheet6: TTabSheet;
    edtInstallPath: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtUserDBPath: TEdit;
    TabSheet7: TTabSheet;
    MmSysID: TMemo;
    BtnGetSysIDScript: TButton;
    GroupBox2: TGroupBox;
    BtnBackUpUserConfig: TButton;
    BtnUsersysDBDetattach: TButton;
    BtnRenameDir: TButton;
    BtnCopyFile: TButton;
    BtnAttachSYSDataBase: TButton;
    BtnAttachOldSys: TButton;
    BtnRunInitialScript: TButton;
    BtnRunScript: TButton;
    BtnRestoreSysConfig: TButton;
    BtnUnCompress: TButton;
    ChkBrandNewInstall: TCheckBox;
    GroupBox3: TGroupBox;
    BtnCreateVirtual: TButton;
    BtnAttachUserAndSysDataBase: TButton;
    btnCreateWebErp: TButton;
    TabSheet4: TTabSheet;
    MmAuthForms: TMemo;
    Panel1: TPanel;
    BtnAuthForms: TButton;
    procedure BtnLstAllChgedObjClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCreateProcScriptClick(Sender: TObject);
    procedure BtnLstFieldsClick(Sender: TObject);
    procedure BtnFldsTablesScriptClick(Sender: TObject);
    procedure btnCopyProcScrptClick(Sender: TObject);
    procedure BtnAllDeletedFieldsClick(Sender: TObject);
    procedure BtnCreateFileClick(Sender: TObject);
    procedure BtnDetattachClick(Sender: TObject);
    procedure BtnAttachClick(Sender: TObject);
    procedure BtnCompressExeClick(Sender: TObject);
    procedure BtnUnCompressClick(Sender: TObject);
    procedure BtnUsersysDBDetattachClick(Sender: TObject);
    Procedure ChangeTimeStamp;
    procedure BtnAttachSYSDataBaseClick(Sender: TObject);
    procedure BtnRunScriptClick(Sender: TObject);
    procedure BtnRestoreSysConfigClick(Sender: TObject);
    procedure BtnRunInitialScriptClick(Sender: TObject);

    procedure BtnRenameDirClick(Sender: TObject);
    procedure BtnCopyFileClick(Sender: TObject);
    procedure BtnRestoreScriptClick(Sender: TObject);
    procedure writeReleaselog;
    procedure BtnGetSysIDScriptClick(Sender: TObject);
    procedure BtnAttachOldSysClick(Sender: TObject); 
    procedure BtnCreateVirtualClick(Sender: TObject);
    procedure BtnAttachUserAndSysDataBaseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCreateWebErpClick(Sender: TObject);
    procedure BtnAuthFormsClick(Sender: TObject);

  private
    { Private declarations }
  public
    PackagePath:string;
    PackName:string;
    function  RunScript(FileName:string):Boolean;
    procedure ClearLogDataBase;
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  Logger:TTxtLogger;
  Function   CreateWebServer(WRoot,WComment,WPort,ServerRun:Variant):Variant;
  
implementation
  uses uDataModule,ULogininfo  ;
{$R *.dfm}





procedure TFrmMain.BtnLstAllChgedObjClick(Sender: TObject);
begin
    self.ADOObj.close;
    self.ADOObj.SQL.Clear ;
    self.ADOObj.SQL.Add( ' select xtype,name From sysobjects  where category=0  ') ;

    self.ADOObj.SQL.Add( ' and  name in (select FobjName from '+LoginInfo.SysDBPubName +'.dbo.TSysObjUpdateLog where FVersion ='+quotedstr(self.edtVersion.Text )+') ') ;
    self.ADOObj.SQL.Add( '  or (name in (select TableEname from '+LoginInfo.SysDBPubName +'.dbo.TallUserTable where pk  in ( select  ownerpk   from '+LoginInfo.SysDBPubName +'.dbo.TAllFields where FVersion ='+quotedstr(self.edtVersion.Text )+' )) )') ;
    self.ADOObj.SQL.Add( ' order by Crdate desc ');


     ADOObj.Open;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
var inif,inif2: TIniFile ;
var ServerName,User, password,PCName:string;
var FrmDataBaseInfo:TFrmInstall;
var i:integer;
begin
    PCName:=Os_GetComputerName ;
    if UpperCase(PCName)<>'CHYPC' then
    begin
     self.tsTabCreateScript.Visible :=false ;
     self.tsDettachFiles.Visible :=false ;
    end;

    edtInstallPath.Text := dmfrm.InstallPath ;//  copy(edtInstallPath.Text ,1,length(edtInstallPath.Text )   -1);

    edtUserDBPath.Text :=edtInstallPath.Text+'\DataBase\UserData';
    edtSysDbPath.Text :=edtInstallPath.Text+'\DataBase\SysData';

    if GetSysVersion<>'' then
    self.edtVersion.Text :=GetSysVersion;

    Logger:=TTxtLogger.Create;

end;

procedure TFrmMain.BtnCreateProcScriptClick(Sender: TObject);
var qry:Tadoquery;
var typename:string;
begin
self.BtnLstAllChgedObj.Click;
    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.UserCnn ;


    self.MmScript.Lines.Clear;
        self.MmScript.Lines.Add(char(10)+char(13));
    if not self.ADOObj.Eof then
    self.MmScript.Lines.Add(' --#####存储过程脚本###########################################################-'  ) ;
    self.MmScript.Lines.Add('go');
    while(not self.ADOObj.Eof ) do
    begin
       if (trim(ADOObj.fieldbyname('xtype').AsString) ='P')
           or ( trim(ADOObj.fieldbyname('xtype').AsString) ='FN')
           or ( trim(ADOObj.fieldbyname('xtype').AsString) ='V'  )
           or ( trim(ADOObj.fieldbyname('xtype').AsString) ='TR' ) then
       begin


            if trim(ADOObj.fieldbyname('xtype').AsString) ='P' then
            typename:='proc';
            if trim(ADOObj.fieldbyname('xtype').AsString) ='FN' then
            typename:='function';
            if trim(ADOObj.fieldbyname('xtype').AsString) ='V' then
            typename:='view';
            if trim(ADOObj.fieldbyname('xtype').AsString) ='TR' then
            typename:='TRIGGER';


            qry.Close;
            qry.SQL.clear;
            qry.SQL.Add(' select *From syscomments where id=object_id('+  quotedstr( ADOObj.fieldbyname('name').AsString ) +')') ;
            qry.Open;

            self.MmScript.Lines.Add (' if exists(select *From sysobjects where name='+  quotedstr( ADOObj.fieldbyname('name').AsString ) +') drop    '+typename+ '   '+  ADOObj.fieldbyname('name').AsString    );
            self.MmScript.Lines.Add('go') ;
            self.MmScript.Lines.Add('') ;
            while(not  qry.Eof ) do
            begin
                self.MmScript.Text :=MmScript.Text + (   qry.fieldbyname('text').AsString );
                 qry.Next ;

            end;
            self.MmScript.Lines.Add(' ------------------------------------------------------------------------------------') ;
            self.MmScript.Lines.Add('go')  ;


        end;

       ADOObj.Next ;
    end;
    qry.Free ;
         self.MmScript.Lines.Add(#13#10);
    self.MmScript.SelectAll;
MmScript.CopyToClipboard;
end;

procedure TFrmMain.BtnLstFieldsClick(Sender: TObject);
begin
  AdoDsFlds.Close;
  AdoDsFlds.CommandText :='select A.TableEName ,';
  AdoDsFlds.CommandText := AdoDsFlds.CommandText +'B.FieldEName,B.FieldCName,B.IsPrimaryKey,B.NullAble,B.IsUnique,B.FieldTypeID,B.FieldTypeInSql,B.FieldLength,B.FPrecision,B.Note,B.UpdateTime,B.DefaultValue,B.FCheck,';
  AdoDsFlds.CommandText := AdoDsFlds.CommandText +'B.FKContent,B.ForeignKey,B.OrderID,B.DefaultValueInSys,B.InputStyle,B.ToInterface,B.FisLookUpFld,B.KeyFld,B.FiscalculateFld,B.FVersion  ,B.FCalFormular ,  A.FisBasicTable ' ;
  AdoDsFlds.CommandText := AdoDsFlds.CommandText +'From TAllUserTable A  join   Tallfields B  on A.pk=B.Ownerpk where B.FVersion='+quotedstr(self.edtVersion.Text ) ;
  AdoDsFlds.open;
  BtnFldsTablesScript.Click;
end;

procedure TFrmMain.BtnFldsTablesScriptClick(Sender: TObject);
var qry:Tadoquery;
begin

    //self.MmTablesAndFields.Clear;
  try
    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.SysConnection1 ;
    qry.SQL.Add('select * from TAllUserTable where Fversion='+quotedstr(self.edtVersion.Text ) );
    qry.Open;
    self.mmDeletedFlds.Lines.Add(#13#10);
    if not qry.Eof  then
    self.MmTablesAndFields.Lines.Add(' --#####表变动程脚本###########################################################-') ;
    self.MmTablesAndFields.Lines.Add('go');

    while(not qry.Eof ) do
    begin
       if qry.fieldbyname('FisBasicTable').AsBoolean  then
         self.MmTablesAndFields.Lines.Add( 'exec Sp_CreateTable '+quotedstr(qry.fieldbyname('TableEname').AsString )+' ,''F_ID'',1' )
        else
         self.MmTablesAndFields.Lines.Add( 'exec Sp_CreateTable '+quotedstr(qry.fieldbyname('TableEname').AsString )+' ,''F_ID'',1'  )     ;

         self.MmTablesAndFields.Lines.Add( 'if not exists(select *From sysobjects where name='+quotedstr(qry.fieldbyname('TableEname').AsString )+' ) raiserror(''error'',1,16) ' );
         self.MmTablesAndFields.Lines.Add( 'go');

        qry.Next;
    end;
    self.MmTablesAndFields.Lines.Add( '--------------------');
    self.MmTablesAndFields.Lines.Add(' ');
    self.mmDeletedFlds.Lines.Add(#13#10);
    if not self.AdoDsFlds.Eof then
    self.MmTablesAndFields.Lines.Add(' --#####字段变动程脚本###########################################################-'+#13#10) ;
    self.MmTablesAndFields.Lines.Add('go');
    while(not self.AdoDsFlds.Eof)do
    begin
        MmTablesAndFields.Lines.Add( 'declare @P1 varchar(100)');
        MmTablesAndFields.Lines.Add( 'exec SP_CreateField @P1 output  ');
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('TableEName').AsString );
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('FieldEName').AsString );
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('FieldCName').AsString) ;
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('FieldTypeInSql').AsString );
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('fieldlength').AsString );
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('Fprecision').AsString );
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('defaultValue').AsString );
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('FCheck').AsString );
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('ForeignKey').AsString );
        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('FkContent').AsString );

        if AdoDsFlds.fieldbyname('IsPrimaryKey').AsBoolean then
        MmTablesAndFields.Text :=MmTablesAndFields.Text +',1' else MmTablesAndFields.Text :=MmTablesAndFields.Text +',0' ;
        if AdoDsFlds.fieldbyname('NullAble').AsBoolean then
        MmTablesAndFields.Text :=MmTablesAndFields.Text +',1' else MmTablesAndFields.Text :=MmTablesAndFields.Text +',0' ;
        if AdoDsFlds.fieldbyname('IsUnique').AsBoolean then
        MmTablesAndFields.Text :=MmTablesAndFields.Text +',1' else MmTablesAndFields.Text :=MmTablesAndFields.Text +',0' ;

        if AdoDsFlds.fieldbyname('FiscalculateFld').AsBoolean then
        MmTablesAndFields.Text :=MmTablesAndFields.Text +',1' else MmTablesAndFields.Text :=MmTablesAndFields.Text +',0' ;

        MmTablesAndFields.Text :=MmTablesAndFields.Text +','+quotedstr(AdoDsFlds.fieldbyname('FCalFormular').AsString );



        MmTablesAndFields.Lines.Add( 'go');

//        'ff', 'gg', '是', 'varchar', '50', '', '', '', '', '', 0, 1, 1


      AdoDsFlds.Next ;
    end;

  finally
    qry.Free ;
  end;
  self.MmTablesAndFields.SelectAll;
  self.MmTablesAndFields.CopyToClipboard ;
end;


procedure TFrmMain.btnCopyProcScrptClick(Sender: TObject);
begin
self.MmScript.SelectAll;
MmScript.CopyToClipboard;
end;

procedure TFrmMain.BtnAllDeletedFieldsClick(Sender: TObject);
var qry:Tadoquery;
begin
  self.mmDeletedFlds.Clear;
    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.SysConnection1 ;
    qry.SQL.Add('select   * from T_DataUpdateLog where FoperateType=''DELETE'' and isnull(FUserTableEName ,'''')<>'''' and  FNote='+quotedstr(self.edtVersion.Text )) ;
    qry.Open;
    self.mmDeletedFlds.Lines.Add(#13#10);
    if not qry.Eof  then
    self.mmDeletedFlds.Lines.Add(' --#####字段删除程脚本###########################################################-' ) ;

    self.mmDeletedFlds.Lines.Add('go');
    while (not qry.Eof ) do
    begin
      if (qry.fieldbyname('FdeleteObjName').AsString<>'' ) and (qry.fieldbyname('FUserTableEName').AsString<>'') then
      begin
          mmDeletedFlds.Lines.Add(  'delete '+qry.fieldbyname('FUserTableEName').AsString );
          mmDeletedFlds.Lines.Add(  'go ');
          mmDeletedFlds.Lines.Add( ' declare @P1 varchar(200) ') ;
          mmDeletedFlds.Lines.Add( ' exec SP_DropField @P1 output, '+quotedstr(qry.fieldbyname('FUserTableEName').AsString) +', '+quotedstr(qry.fieldbyname('FdeleteObjName').AsString)+', ''''' );
          mmDeletedFlds.Lines.Add( ' go');
      end;
      qry.Next;
    end;

    qry.Free;

    self.mmDeletedFlds.SelectAll;
    self.mmDeletedFlds.CopyToClipboard;
end;

procedure TFrmMain.BtnCreateFileClick(Sender: TObject);
var flst:Tmemorystream;
begin
  try
      flst:=Tmemorystream.Create ;

      BtnCreateProcScript.Click;
      BtnLstFields.Click;
      BtnAllDeletedFields.Click;
      BtnGetSysIDScript.Click;
      self.BtnAuthForms.Click;

      self.MmTablesAndFields.Lines.SaveToStream(flst);
      self.MmScript.Lines.SaveToStream(flst);
      self.mmDeletedFlds.Lines.SaveToStream(flst);
      self.MmSysID.Lines.SaveToStream( flst ) ;
      flst.SaveToFile(  'UpgradePackage\UpgradeScript'+self.edtVersion.Text+'.sql') ;

      copyfile(pchar( '..\SQLScript\'+ 'initial_'+self.edtVersion.Text+'.sql') ,pchar('UpgradePackage\'+ 'initial_'+self.edtVersion.Text+'.sql')    ,false );
      dmfrm.UserCnn.Close;
      dmfrm.SysConnection1.Close;
  finally
      flst.Free;
  end;

end;

procedure TFrmMain.BtnDetattachClick(Sender: TObject);
var
  qry:Tadoquery;
  userDBName , SysDataDir,UserDataDir ,UpdateWebDir ,ClientDir:string;
begin
    try 
      screen.Cursor :=    crSQLWait ;
      if self.ChkBrandNewInstall.Checked  then
        PackagePath:='InstallPackage'
      else
        PackagePath:='UpgradePackage';

      PackName:='Package.zip';


      qry:=Tadoquery.Create(nil);
      qry.Connection :=dmfrm.CnnMaster;
      dmfrm.SysConnection1.DefaultDatabase := 'master' ;
      qry.SQL.Add('Select       DB_Name(DBID) ,hostname,*  from   master..sysprocesses ');
      qry.SQL.Add('    where DB_Name(DBID) in (');
      qry.SQL.Add(    quotedstr(logininfo.SysDBPubName)+','+quotedstr(logininfo.SysDBase )+',' );
      qry.SQL.Add(    quotedstr(dmfrm.UserCnn.DefaultDatabase)+','+quotedstr(logininfo.LogDataBaseName )  );
      qry.SQL.Add(')')  ;
      qry.Open ;

      if not qry.IsEmpty then
      begin
        showmessage('数据库在使用');
        exit;
      end;
      if    not fileexists(self.edtSysDbPath.text  +'\'+logininfo.SysDBPubName+'.MDF')
         or not fileexists(self.edtSysDbPath.text  +'\'+logininfo.SysDBase+'.MDF' )   then
       begin
           showmessage('数据库文件不存在,请检查路径!');
           exit;
       end;
      self.Caption :='ClearLogDataBase'  ;
      ClearLogDataBase;

       self.Caption :='writeReleaselog'  ;
      writeReleaselog;

      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('update '+ LoginInfo.SysDBPubName+'.dbo.sys_version set FLstEditTime =Getdate(), FCsVersion =' +quotedstr(edtVersion.Text ) +#13#10 );
      qry.ExecSQL ;
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('update '+ LoginInfo.SysDBase +'.dbo.sys_version set FLstEditTime =Getdate(), FCsVersion =' +quotedstr(edtVersion.Text ) +#13#10 );
      qry.ExecSQL ;

      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('EXEC sp_detach_db '+quotedstr(logininfo.SysDBPubName)+', true'     +#13#10 );

      qry.SQL.Add('EXEC sp_detach_db '+quotedstr(logininfo.SysDBase)+'     , true '+#13#10   );


      if self.ChkBrandNewInstall.Checked then
      begin
        qry.SQL.Add('EXEC sp_detach_db '+quotedstr(dmfrm.UserCnn.DefaultDatabase )+'     , true '+#13#10  );
        qry.SQL.Add('EXEC sp_detach_db '+quotedstr(logininfo.LogDataBaseName   )+'     , true '+#13#10  );

      end;
      self.Caption :='detach db'  ;
      qry.ExecSQL ;

      { }
      self.Caption :='copy sys db file '  ;
      copyfile(pchar(  self.edtSysDbPath.text  +'\'+logininfo.SysDBPubName+'.MDF' )  ,pchar(PackagePath+'\'+logininfo.SysDBPubName+'.MDF')    ,false );
      copyfile(pchar(self.edtSysDbPath.text  +'\'+logininfo.SysDBPubName+'_LOG.LDF')   ,pchar(PackagePath+'\'+logininfo.SysDBPubName+'_LOG.LDF')    ,false  );
      copyfile(pchar(self.edtSysDbPath.text  +'\'+logininfo.SysDBase+'.MDF'  ) ,pchar(PackagePath+'\'+logininfo.SysDBase+'.MDF' )    ,false );
      copyfile(pchar(self.edtSysDbPath.text  +'\'+logininfo.SysDBase+'_LOG.LDF') ,pchar(PackagePath+'\'+logininfo.SysDBase+'_LOG.LDF')    ,false );
       
      userDBName := dmfrm.UserCnn.DefaultDatabase ;
      if self.ChkBrandNewInstall.Checked then
      begin
        self.Caption :='copy user db file '  ;
        copyfile( pchar( edtUserDBPath.text  +'\'+userDBName+'.MDF'  )   ,pchar(PackagePath+'\'+ userDBName +'.MDF' )    ,false );
        copyfile( pchar( edtUserDBPath.text  +'\'+userDBName+'_LOG.LDF') ,pchar(PackagePath+'\'+ userDBName +'_LOG.LDF') ,false );


        copyfile(pchar(self.edtUserDBPath.text  +'\'+logininfo.LogDataBaseName +'.MDF'  ) ,pchar(PackagePath+'\'+logininfo.LogDataBaseName +'.MDF' )    ,false );
        copyfile(pchar(self.edtUserDBPath.text  +'\'+logininfo.LogDataBaseName +'_LOG.LDF') ,pchar(PackagePath+'\'+logininfo.LogDataBaseName +'_LOG.LDF')    ,false );

        copyfile(pchar(  'DBLinker.exe') ,pchar(PackagePath+'\'+ 'DBLinker.exe')    ,false );
        copyfile(pchar(  'PrjMetaData.exe') ,pchar(PackagePath+'\'+ 'PrjMetaData.exe')    ,false );
        copyfile(pchar(  'qtintf70.dll') ,pchar(PackagePath+'\'+ 'qtintf70.dll')    ,false );
        copyfile(pchar(  'qtintf.dll') ,pchar(PackagePath+'\'+ 'qtintf.dll')    ,false );
        copyfile(pchar(  'ServerCfg.ini') ,pchar(PackagePath+'\'+ 'ServerCfg.ini')    ,false );
        copyfile(pchar(  'Config.ini') ,pchar(PackagePath+'\'+ 'Config.ini')    ,false );
      
      end;
      self.Caption :='copy user exe file '  ;

      copyfile(pchar(  dmfrm.MainExeFileName ) ,pchar(PackagePath+'\'+ dmfrm.MainExeFileName )    ,false );

      copyfile(pchar( '..\SQLScript\'+ 'initial_'+dmfrm.Version+'.sql') ,pchar(PackagePath+'\'+ 'initial_'+dmfrm.Version+'.sql')    ,false );


     {
      BtnRestoreScript.Click; 
      self.MmRestoreScript.Lines.SaveToFile(  PackagePath+'\'+ 'RestoreCfg.sql') ;
       }
      if self.chkCompress.Checked then
      begin
        self.FlstPackage.Directory :=  ExtractFilePath(application.ExeName)  +'\'+PackagePath   ;
        vclzip1.FilesList :=  self.FlstPackage.Items  ;
        vclzip1.ZipName := PackName;
        vclzip1.Password :=self.edtPassword.Text ;
        self.vclzip1.Zip ;

        
      end;

       self.Caption :='attach db '  ; 
      BtnAttach.Click;


       self.Caption :='ok '  ; 

      showmessage(' 成功!');
    finally
      screen.Cursor :=crDefault ;
      // qry.Free ;
    end;
end;

procedure TFrmMain.BtnAttachClick(Sender: TObject);
var qry:Tadoquery;
begin
    try
screen.Cursor :=    crSQLWait ;

    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.CnnMaster ;

    if    not fileexists(self.edtSysDbPath.text  +'\'+logininfo.SysDBPubName+'.MDF')
       or not fileexists(self.edtSysDbPath.text  +'\'+logininfo.SysDBase+'.MDF' )   then
     begin
         showmessage('数据库文件不存在,请检查路径!');
         exit;
     end;

    qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.SysDBPubName)+',   ');

   qry.SQL.Add('   @filename1 = N'+ quotedstr(self.edtSysDbPath.Text +'\'+ logininfo.SysDBPubName+'.MDF')+',' );
   qry.SQL.Add('   @filename2 = N'+ quotedstr(self.edtSysDbPath.Text +'\'+ logininfo.SysDBPubName+'_Log.LDF') );


   qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.SysDBase)+',   ');

   qry.SQL.Add('   @filename1 = N'+ quotedstr(self.edtSysDbPath.Text +'\'+ logininfo.SysDBase+'.MDF')+',' );
   qry.SQL.Add('   @filename2 = N'+ quotedstr(self.edtSysDbPath.Text +'\'+ logininfo.SysDBase+'_Log.LDF') );


   if self.ChkBrandNewInstall.Checked then
   begin
     qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(dmfrm.UserCnn.DefaultDatabase)+',   ');
     qry.SQL.Add('   @filename1 = N'+ quotedstr(edtUserDBPath.text +'\'+ dmfrm.UserCnn.DefaultDatabase+'.MDF')+',' );
     qry.SQL.Add('   @filename2 = N'+ quotedstr(edtUserDBPath.text +'\'+ dmfrm.UserCnn.DefaultDatabase+'_Log.LDF') );

     qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.LogDataBaseName )+',   ');
     qry.SQL.Add('   @filename1 = N'+ quotedstr(edtUserDBPath.text +'\'+ logininfo.LogDataBaseName +'.MDF')+',' );
     qry.SQL.Add('   @filename2 = N'+ quotedstr(edtUserDBPath.text +'\'+ logininfo.LogDataBaseName +'_Log.LDF') );
   end;
    qry.ExecSQL ;
finally
    qry.Free ;
          screen.Cursor :=crDefault ;
    end;

end;

procedure TFrmMain.BtnCompressExeClick(Sender: TObject);
var packexePath:string;
begin
   packexePath:='ASPACK.EXE';
   winexec(pchar( packexePath), SW_MAXIMIZE	);
end;

procedure TFrmMain.BtnUnCompressClick(Sender: TObject);
begin
    vclzip1.ZipName :='package\'+ PackName ;
    self.Caption :=vclzip1.ZipName ;
    vclzip1.DoAll :=True ;
    vclzip1.DestDir :=  PackagePath  ;
    vclzip1.RootDir := '';
    vclzip1.OverwriteMode :=Always;
    vclzip1.RecreateDirs := False ;
    vclzip1.RetainAttributes := true;
    vclzip1.Password := self.edtPassword.Text ;;//Password.Text;
    vclzip1.UnZip  ;
    showmessage('ok');

end;

procedure TFrmMain.BtnUsersysDBDetattachClick(Sender: TObject);

  var qry:Tadoquery;
begin
  try
    try

      qry:=Tadoquery.Create(nil);
      qry.Connection :=dmfrm.SysConnection1;
      dmfrm.SysConnection1.DefaultDatabase := 'master' ;

      qry.SQL.Add('Select       DB_Name(DBID) ,hostname,*  from   master..sysprocesses ');
      qry.SQL.Add('    where DB_Name(DBID) in (');
      qry.SQL.Add(    quotedstr(logininfo.SysDBPubName)+','+quotedstr(logininfo.SysDBase )+',' );
      qry.SQL.Add(    quotedstr('OLD'+logininfo.SysDBPubName)+','+quotedstr('OLD'+logininfo.SysDBase )  );
      qry.SQL.Add(')')  ;
      Logger.Save(qry.SQL.Text);
      qry.Open ;

      if not qry.IsEmpty then
      begin
        showmessage('数据库在使用');
        exit;
      end;
      if    not fileexists( PackagePath+'\'+  logininfo.SysDBPubName+'.MDF' )
         or not fileexists( PackagePath+'\'+logininfo.SysDBase+'.MDF' )   then
       begin
           showmessage('数据库文件不存在,请检查路径!');
           exit;
       end;



      qry.SQL.Add('EXEC sp_detach_db '+quotedstr(logininfo.SysDBPubName)+', true'     +#13#10 );
      qry.SQL.Add('EXEC sp_detach_db '+quotedstr(logininfo.SysDBase)+'     , true '+#13#10   );
      Logger.Save(qry.SQL.Text);
      qry.ExecSQL ;

      qry.Close;

      {qry.SQL.Clear;
      qry.SQL.Add('EXEC sp_detach_db '+quotedstr('OLD'+logininfo.SysDBPubName)+', true'     +#13#10);
      qry.SQL.Add('EXEC sp_detach_db '+quotedstr('OLD'+logininfo.SysDBase)+'     , true '+#13#10   );
      qry.ExecSQL ;

      }
     // DeleteDir(edtInstallPath.Text +'\DataBase\OldSysData');



      copyfile(pchar(PackagePath+'\'+  logininfo.SysDBPubName+'.MDF' )  ,pchar(edtInstallPath.Text +'\DataBase\SysData'+'\'+logininfo.SysDBPubName+'.MDF')    ,false );
      copyfile(pchar(PackagePath+'\'+logininfo.SysDBPubName+'_LOG.LDF')   ,pchar(edtInstallPath.Text +'\DataBase\SysData'+'\'+logininfo.SysDBPubName+'_LOG.LDF')    ,false  );
      copyfile(pchar( PackagePath+'\'+logininfo.SysDBase+'.MDF'  ) ,pchar(edtInstallPath.Text +'\DataBase\SysData'+'\'+logininfo.SysDBase+'.MDF')    ,false );
      copyfile(pchar(PackagePath+'\'+logininfo.SysDBase+'_LOG.LDF') ,pchar(edtInstallPath.Text +'\DataBase\SysData'+'\'+logininfo.SysDBase+'_LOG.LDF')    ,false );


      copyfile(pchar(PackagePath+'\'+ dmfrm.MainExeFileName ) ,pchar(edtInstallPath.Text +'\updateweb\'+ StringReplace(dmfrm.MainExeFileName ,'.exe','',[])+'.inf')    ,false );
      //copyfile(pchar( PackagePath+'\'+ 'Config.ini') ,pchar(edtInstallPath.Text +'\updateweb\'+ 'Config.inf')    ,false );
      ChangeTimeStamp ;



      if self.ChkBrandNewInstall.Checked then
      begin
        copyfile(pchar( PackagePath+'\'+ 'DBLinker.exe') ,pchar(edtInstallPath.Text +'\client\'+  'DBLinker.exe')    ,false );
        copyfile(pchar( PackagePath+'\'+ 'PrjMetaData.exe') ,pchar(edtInstallPath.Text +'\client\'+  'PrjMetaData.exe')    ,false );
        copyfile(pchar( PackagePath+'\'+ 'qtintf70.dll') ,pchar(edtInstallPath.Text +'\client\'+  'qtintf70.dll')    ,false );
        copyfile(pchar( PackagePath+'\'+ 'qtintf.dll') ,pchar(edtInstallPath.Text +'\client\'+  'qtintf.dll')    ,false );
        copyfile(pchar( PackagePath+'\'+ 'ServerCfg.ini') ,pchar(edtInstallPath.Text +'\client\'+  'ServerCfg.ini')    ,false );
        copyfile(pchar( PackagePath+'\'+ dmfrm.MainExeFileName) ,pchar(edtInstallPath.Text +'\client\'+  StringReplace(dmfrm.MainExeFileName ,'.exe','',[])+'.inf')    ,false );
        copyfile(pchar( PackagePath+'\'+ 'Config.ini') ,pchar(edtInstallPath.Text +'\client\'+  'Config.ini')    ,false );
      end;
      showmessage('ok');
      except
      on err:exception    do
      begin
          showmessage(err.Message );
      end;
    end;
    BtnRenameDirClick(Sender); //重命名 老的数据库
    finally
      qry.Free ;
    end;
end;

procedure TFrmMain.ChangeTimeStamp;
var inif: TIniFile ;
var ServerName,User, password:string;
begin

  inif:=TIniFile.Create(edtInstallPath.Text +'\updateweb\'+ 'Update.inf' );     //update   file update.ini timestamp
   inif.WriteString ('version','Version',datetimetostr(now));
   inif.free ;

end;

procedure TFrmMain.BtnAttachSYSDataBaseClick(Sender: TObject);
var qry:Tadoquery;
begin
  try
    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.CnnMaster ;

    qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.SysDBPubName)+',   ');
    qry.SQL.Add('   @filename1 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\SysData\'+ logininfo.SysDBPubName+'.MDF')+',' );
    qry.SQL.Add('   @filename2 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\SysData\'+ logininfo.SysDBPubName+'_Log.LDF') );

    qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.SysDBase)+',   ');
    qry.SQL.Add('   @filename1 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\SysData\'+ logininfo.SysDBase+'.MDF')+',' );
    qry.SQL.Add('   @filename2 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\SysData\'+ logininfo.SysDBase+'_Log.LDF') );

   // showmessage(quotedstr(Self.edtSysDbPath .Text  +'\'+ logininfo.SysDBPubName+'.MDF' ));
   Logger.Save(qry.SQL.Text);
    qry.ExecSQL ;
    showmessage('ok');
  finally
    qry.Free ;

  end;


end;

function MakeFileList(Path,FileExt:string):TStringList ;
var
sch:TSearchrec;
begin
Result:=TStringlist.Create;

if rightStr(trim(Path), 1) <> '\' then
    Path := trim(Path) + '\'
else
    Path := trim(Path);

if not DirectoryExists(Path) then
begin
    Result.Clear;
    exit;
end;

if FindFirst(Path + '*', faAnyfile, sch) = 0 then
begin
    repeat
       Application.ProcessMessages;
       if ((sch.Name = '.') or (sch.Name = '..')) then Continue;
       if DirectoryExists(Path+sch.Name) then
       begin
         Result.AddStrings(MakeFileList(Path+sch.Name,FileExt));
       end
       else
       begin
         if (UpperCase(extractfileext(Path+sch.Name)) = UpperCase(FileExt)) or (FileExt='.*') then
         Result.Add(Path+sch.Name);
       end;
    until FindNext(sch) <> 0;
    SysUtils.FindClose(sch);
end;
end;

procedure TFrmMain.BtnRunScriptClick(Sender: TObject);
var i:integer;
var filename,sqlFileName:string;
var scriptLst:TStrings;
begin
  try
    scriptLst :=MakeFileList('Package','.sql');
    filename  :='UpgradeScript'+self.edtVersion.Text +'.sql' ;

    for i:=0 to scriptLst.Count -1  do
    begin
      sqlFileName:=ExtractFileName(scriptLst[i]) ;
      if Pos('UpgradeScript', sqlFileName )>0 then
      if sqlFileName>=  filename then
         //ShowMessage( scriptLst[i] )
           RunScript( scriptLst[i]);
    end;

  except
    on err:Exception do
    begin
      raise exception.Create(err.Message );
    end;
  end;
end;


procedure TFrmMain.BtnRestoreSysConfigClick(Sender: TObject);
var qry:Tadoquery;
begin
  try
    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.UserCnn;
    qry.Connection.DefaultDatabase :=LoginInfo.UserDB;
    qry.SQL.Clear;
    qry.SQL.Add( 'exec Pr_RestoreSysData '+quotedstr(LoginInfo.LogDataBaseName )+ ','+quotedstr(LoginInfo.SysDBPubName  )   ) ;
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add( 'exec Pr_RestoreSysData '+quotedstr(LoginInfo.LogDataBaseName )+ ','+quotedstr(LoginInfo.SysDBase   )   ) ;
    qry.ExecSQL;

    qry.Connection.DefaultDatabase :=LoginInfo.SysDBPubName;
    qry.SQL.Clear;
    qry.SQL.Add( ' drop table TAuthorizeObject ');
    qry.SQL.Add( ' select * into  TAuthorizeObject from '+logininfo.LogDataBaseName +'.dbo.TAuthorizeObject'+LoginInfo.SysDBPubName);
    qry.ExecSQL;

    qry.SQL.Clear;
    qry.SQL.Add( ' drop table TAuthorizeItem ');
    qry.SQL.Add( ' select * into  TAuthorizeItem  from '+logininfo.LogDataBaseName +'.dbo.TAuthorizeItem'+LoginInfo.SysDBPubName);
    qry.ExecSQL;


    showmessage('ok');
  finally
    qry.Free ;
  end;
end;

procedure TFrmMain.BtnRunInitialScriptClick(Sender: TObject);
var qry:Tadoquery;
begin
  try
    RunScript(PackagePath+'\initial.sql'  );
  except
    on err:Exception do
    begin
      raise exception.Create(err.Message );
    end;
  end;
end;

procedure TFrmMain.BtnRenameDirClick(Sender: TObject);
var strnow:string;
begin
  try
  strnow:=FormatDateTime('yyyy-mm-dd hhh.mm.ss', Now );;

    RenDirectory(self.edtInstallPath.Text +'\DataBase\OldSysData',edtInstallPath.Text +'\DataBase\OldSysData'+strnow);
   //  DeleteDir(edtInstallPath.Text +'\DataBase\OldSysData');
    RenDirectory(self.edtInstallPath.Text +'\DataBase\SysData',edtInstallPath.Text +'\DataBase\OldSysData');
    CreateDirectory(pchar( edtInstallPath.Text +'\DataBase\SysData'), nil);
    showmessage('ok');
  except
    on err:exception do
    begin
        showmessage(err.Message);
    end;

  end;

end;

procedure TFrmMain.BtnCopyFileClick(Sender: TObject);
begin
   try
    copyfile(pchar(PackagePath+'\'+  logininfo.SysDBPubName+'.MDF' )  ,pchar(edtInstallPath.Text +'\DataBase\SysData'+'\'+logininfo.SysDBPubName+'.MDF')    ,false );
    copyfile(pchar(PackagePath+'\'+logininfo.SysDBPubName+'_LOG.LDF')   ,pchar(edtInstallPath.Text +'\DataBase\SysData'+'\'+logininfo.SysDBPubName+'_LOG.LDF')    ,false  );
    copyfile(pchar( PackagePath+'\'+logininfo.SysDBase+'.MDF'  ) ,pchar(edtInstallPath.Text +'\DataBase\SysData'+'\'+logininfo.SysDBase+'.MDF')    ,false );
    copyfile(pchar(PackagePath+'\'+logininfo.SysDBase+'_LOG.LDF') ,pchar(edtInstallPath.Text +'\DataBase\SysData'+'\'+logininfo.SysDBase+'_LOG.LDF')    ,false );


    copyfile(pchar(PackagePath+'\'+ dmfrm.MainExeFileName) ,pchar(edtInstallPath.Text +'\UpdateWeb\'+ StringReplace(dmfrm.MainExeFileName ,'.exe','',[])+'.inf')    ,false );
    copyfile(pchar( PackagePath+'\'+ 'Config.ini') ,pchar(edtInstallPath.Text +'\UpdateWeb\'+ 'Config.inf')    ,false );
    ChangeTimeStamp ;
    copyfile(pchar( PackagePath+'\'+ 'Update.inf') ,pchar(edtInstallPath.Text +'\UpdateWeb\'+ 'Update.inf')    ,false );


    if self.ChkBrandNewInstall.Checked then
    begin
      copyfile(pchar( PackagePath+'\'+ 'DBLinker.exe') ,pchar(edtInstallPath.Text +'\client\'+  'DBLinker.exe')    ,false );
      copyfile(pchar( PackagePath+'\'+ 'PrjMetaData.exe') ,pchar(edtInstallPath.Text +'\client\'+  'PrjMetaData.exe')    ,false );
      copyfile(pchar( PackagePath+'\'+ 'qtintf70.dll') ,pchar(edtInstallPath.Text +'\client\'+  'qtintf70.dll')    ,false );
      copyfile(pchar( PackagePath+'\'+ 'qtintf.dll') ,pchar(edtInstallPath.Text +'\client\'+  'qtintf.dll')    ,false );
      copyfile(pchar( PackagePath+'\'+ 'ServerCfg.ini') ,pchar(edtInstallPath.Text +'\client\'+  'ServerCfg.ini')    ,false );
      copyfile(pchar( PackagePath+'\'+ dmfrm.MainExeFileName) ,pchar(edtInstallPath.Text +'\client\'+ StringReplace(dmfrm.MainExeFileName ,'.exe','',[])+'.inf')    ,false );
      copyfile(pchar( PackagePath+'\'+ 'Config.ini') ,pchar(edtInstallPath.Text +'\client\'+  'Config.ini')    ,false );
    end;
    showmessage('ok');
    except
      on err:exception    do
      begin
          showmessage(err.Message );
      end;
    end;
end;

procedure TFrmMain.BtnRestoreScriptClick(Sender: TObject);
begin
{MmRestoreScript.Clear;
 MmRestoreScript.Lines.Add( ' use '+logininfo.UserDB );
 MmRestoreScript.Lines.Add(' exec Pr_RestoreSysData  ' +quotedstr('OLD'+logininfo.SysDBPubName)+  ','+  quotedstr( logininfo.SysDBPubName)  +'   ');
 MmRestoreScript.Lines.Add(' exec Pr_RestoreSysData  ' +quotedstr('OLD'+logininfo.SysDBase )+  ','+  quotedstr( logininfo.SysDBase)  +'   ');

 MmRestoreScript.Lines.Add( ' go ' );
 MmRestoreScript.Lines.Add( ' use '+logininfo.SysDBPubName);
 MmRestoreScript.Lines.Add( ' drop table TAuthorizeObject ');
 MmRestoreScript.Lines.Add( ' select * into '+logininfo.SysDBPubName+'.dbo.TAuthorizeObject from OLD'+logininfo.SysDBPubName+'.dbo.TAuthorizeObject ');
 MmRestoreScript.Lines.Add( ' go ' );
 MmRestoreScript.Lines.Add( ' drop table TAuthorizeItem ');
 MmRestoreScript.Lines.Add( ' select * into '+logininfo.SysDBPubName+'.dbo.TAuthorizeItem from OLD'+logininfo.SysDBPubName+'.dbo.TAuthorizeItem ');

 }

end;

procedure TFrmMain.writeReleaselog;
var
LogFile: TextFile;
logfieldName:string;
begin

       logfieldName := 'ReleaseLog\ReleaseLog.txt' ;
    if not FileExists(logfieldName) then
    begin
      AssignFile(LogFile, logfieldName);
        Rewrite(LogFile);

      CloseFile(LogFile); //关闭时自动保存文件
    end;

    AssignFile(LogFile, logfieldName);
    Append(LogFile);

    Write(LogFile, datetimetostr(now) +#9 );
    Write(LogFile,  edtVersion.text +#9);
    Write(LogFile, edtUserDBPath.text );
    writeln(LogFile, '                ');

    CloseFile(LogFile);
end;

procedure TFrmMain.BtnGetSysIDScriptClick(Sender: TObject);
var qry:Tadoquery;
begin

    self.MmSysID.Clear;
    try
      self.MmSysID.Lines.Clear;
      qry:=Tadoquery.Create(nil);
      qry.Connection :=dmfrm.UserCnn  ;
      qry.SQL.Add(' select  * from sys_id   where Fversion='+quotedstr(self.edtVersion.Text ) );
      qry.Open;
      self.MmSysID.Lines.Add('go');
      while(not qry.Eof) do
      begin
         self.MmSysID.Lines.Add ( dmfrm.GetPostSQL (qry,true,'Sys_id') );
         qry.Next;
      end;

      qry.SQL.Clear;
      qry.SQL.Add('select  * from T_Code    where Fversion='+quotedstr(self.edtVersion.Text )  );
      qry.Open;
      self.MmSysID.Lines.Add('go');
      while(not qry.Eof) do
      begin
         self.MmSysID.Lines.Add ( dmfrm.GetPostSQL (qry,true,'T_Code') );
         qry.Next;
      end;
      qry.SQL.Clear;
      qry.SQL.Add('select  * from T_item where Fversion='+quotedstr(self.edtVersion.Text )   );
      qry.Open;
      self.MmSysID.Lines.Add('go');
      while(not qry.Eof) do
      begin
         self.MmSysID.Lines.Add ( dmfrm.GetPostSQL (qry,true,'T_item') );
         qry.Next;
      end;
      qry.SQL.Clear;
      qry.SQL.Add('select  * from TParamsAndValues where Fversion='+quotedstr(self.edtVersion.Text )   );
      qry.Open;
      self.MmSysID.Lines.Add('go');
      while(not qry.Eof) do
      begin
         self.MmSysID.Lines.Add ( dmfrm.GetPostSQL (qry,true,'TParamsAndValues') );
         qry.Next;
      end;
    finally
      qry.Free;
    end;
end;

procedure TFrmMain.BtnAttachOldSysClick(Sender: TObject);
var qry:Tadoquery;
begin
    try

    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.CnnMaster ;

 

    qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr('OLD'+logininfo.SysDBPubName)+',   ');
   qry.SQL.Add('   @filename1 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\oldSysData' +'\'+ logininfo.SysDBPubName+'.MDF')+',' );
   qry.SQL.Add('   @filename2 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\oldSysData' +'\'+ logininfo.SysDBPubName+'_Log.LDF') );


   qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr('OLD'+logininfo.SysDBase)+',   ');
   qry.SQL.Add('   @filename1 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\oldSysData'  +'\'+ logininfo.SysDBase+'.MDF')+',' );
   qry.SQL.Add('   @filename2 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\oldSysData'+'\'+ logininfo.SysDBase+'_Log.LDF') );

    qry.ExecSQL ;
    showmessage('ok');
finally
    qry.Free ;

    end;


end;




procedure TFrmMain.BtnCreateVirtualClick(Sender: TObject);
var
      WebSite,   WebServer,   WebRoot,   VDir:   Variant;

begin
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

      VDir   :=   WebRoot.Create('IIsWebVirtualDir',   'WebUpdate');
      VDir.AccessRead   :=   True;
      VDir.AccessExecute:=True;//可运行执行文件
      VDir.EnableDirBrowsing:=true;//允许浏览目录
      VDir.DefaultDoc:='1.htm';
      VDir.EnableDefaultDoc:=true;
      VDir.AppCreate(1);
      VDir.AppFriendlyName:='UpdateWeb';
      VDir.Path   :=  self.edtInstallPath.Text  +'\UpdateWeb';
    
      VDir.SetInfo;   

      screen.Cursor :=    crdefault;
  end;   

Function   CreateWebServer(WRoot,WComment,WPort,ServerRun:Variant):Variant;
  var
      WebServer,   WebRoot,   VDir:   Variant;
      WNumber,Each:Integer;
      WWWServer:Variant;
  begin
  result:=0;
      WebServer:=CreateOleObject('IISNamespace');
      WebServer:=WebServer.GetObject('IIsWebService',   'localhost/w3svc');

      //在IIS中查找每一个WEB站点

      WNumber:=4;
          try
          WebServer.Delete('IIsWebServer',   WNumBer);
          except
          end;
          WebServer:=WebServer.Create('IIsWebServer',   WNumBer);//   然后创建一个WEB服务器

          WebServer.ServerSize:=1;//   中型大小
          WebServer.ServerComment:=WComment;//说明
          WebServer.ServerBindings:=WPort;//端口
          WebServer.EnableDefaultDoc:=True;
          WebServer.SetInfo;
          result:=1;
          VDir:=   WebServer.Create('IIsWebVirtualDir',   'Root');
          VDir.AccessRead   :=   True;
          VDir.AccessExecute:=True;//可运行执行文件
          VDir.EnableDirBrowsing:=true;//允许浏览目录
          VDir.DefaultDoc:='default.asp,index.asp,default.htm,index.htm';
          VDir.EnableDefaultDoc:=true;
          VDir.AppCreate(1);
          VDir.AppFriendlyName:='MyIIS';
          VDir.Path   :=WRoot;
          VDir.SetInfo;

          result:=1;
          try
          WebServer.Start;
          except
            result:=2;
          end;
  end;
procedure TFrmMain.BtnAttachUserAndSysDataBaseClick(Sender: TObject);
var qry:Tadoquery;
begin
    try
      SELF.Caption :=edtInstallPath.Text +'\DataBase\UserData' +'\'+ logininfo.UserDB +'.MDF';
      screen.Cursor :=    crSQLWait ;
      BtnAttachSYSDataBase.Click;
      qry:=Tadoquery.Create(nil);
      qry.Connection :=dmfrm.CnnMaster ;

      qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.UserDB)+',   ');
      qry.SQL.Add('   @filename1 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\UserData' +'\'+ logininfo.UserDB +'.MDF')+',' );
      qry.SQL.Add('   @filename2 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\UserData' +'\'+ logininfo.UserDB+'_Log.LDF') );

      qry.SQL.Add(' EXEC sp_attach_db @dbname = N' + quotedstr(logininfo.LogDataBaseName)+',   ');
      qry.SQL.Add('   @filename1 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\UserData' +'\'+ logininfo.LogDataBaseName +'.MDF')+',' );
      qry.SQL.Add('   @filename2 = N'+ quotedstr(edtInstallPath.Text +'\DataBase\UserData'+'\'+ logininfo.LogDataBaseName +'_Log.LDF') );

     // showmessage(qry.SQL.Text );
      qry.ExecSQL ;
      showmessage('ok');
    finally
      qry.Free ;
      screen.Cursor :=    crDefault;
    end;
end;





procedure TFrmMain.ClearLogDataBase;
var
  qry,QryExeSQL:Tadoquery;
  userDBName,sql:string;
begin
  try
    screen.Cursor :=    crSQLWait ;

    qry:=Tadoquery.Create(nil);
    qry.Connection :=dmfrm.SysConnection1;

    QryExeSQL:=Tadoquery.Create(nil);
    QryExeSQL.Connection :=dmfrm.SysConnection1;

    qry.SQL.Clear;
    qry.SQL.Add(' select name From '+logininfo.LogDataBaseName +'.dbo.sysobjects where xtype=''u''');
    qry.Open;

    while(not qry.Eof )do
    begin
      sql:='truncate table '+logininfo.LogDataBaseName +'.dbo.'+qry.Fields[0].AsString ;

      QryExeSQL.SQL.Clear;
      QryExeSQL.SQL.Add(sql);
      QryExeSQL.ExecSQL;

      qry.Next;
    end;

  finally
    QryExeSQL.Free ;
    qry.Free ;
  end;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
begin
    PackagePath:='Package';

    PackName:='Package.zip';
  

    {  if ParamCount> 1 then
    begin
    edtInstallPath.Text :=ParamStr(2) ;
    BtnCreateVirtual.Click;
    BtnAttachUserAndSysDataBase.Click;
    Application.Terminate;
    end;}

end;

function TFrmMain.RunScript(FileName: string): Boolean;
var adoquery1:Tadoquery;
var
  s:string;
  sqltext : string;
  sqlfile : TextFile;
begin
    try
        adoquery1:=Tadoquery.Create(nil);
        adoquery1.Connection :=dmfrm.UserCnn;
        adoquery1.Connection.DefaultDatabase :=LoginInfo.UserDB ;

        AssignFile(sqlfile, FileName );
        FileMode := 0;
        Reset(sqlfile);
        try
          dmfrm.UserCnn.Open;
          dmfrm.UserCnn.BeginTrans;
          while not eof(sqlfile) do
          begin
            Readln(sqlfile, s);
            sqltext:=s;
            while (not eof(sqlfile)) and
            (uppercase(trim(s))<>'GO') do
            begin
              Readln(sqlfile, s);
              if (uppercase(trim(s))<>'GO') then
                sqltext:=sqltext+' '+s;
            end;
            adoquery1.Close;
            adoquery1.SQL.Clear;
            adoquery1.SQL.Add(sqltext);
            adoquery1.ExecSQL;
          end;
          CloseFile(sqlfile);
          dmfrm.UserCnn.CommitTrans;
          application.MessageBox('SQL脚本完成！',
            '提示',MB_OK+MB_ICONINFORMATION);
        except
          on err:Exception do
          begin
            raise exception.Create(err.Message );
            dmfrm.UserCnn.RollbackTrans;
          end;
        end;
    finally
        adoquery1.Free ;
    end;
end;

procedure TFrmMain.btnCreateWebErpClick(Sender: TObject);
begin
//
        self.FlstPackage.Directory :=  ExtractFilePath(application.ExeName)  +'\WebErp'     ;
       // vclzip1.FilesList :=  self.FlstPackage.Items  ;
      // vclzip1.  :=  ExtractFilePath(application.ExeName)  +'\WebErp'     ;
        vclzip1.ZipName := 'WebErp.zip';
        vclzip1.Password :=self.edtPassword.Text ;
        self.vclzip1.Zip ;
end;

procedure TFrmMain.BtnAuthFormsClick(Sender: TObject);
var qry:Tadoquery;
begin

    self.MmAuthForms.Clear;
    try
      self.MmAuthForms.Lines.Clear;
      qry:=Tadoquery.Create(nil);
      qry.Connection :=dmfrm.UserCnn  ;
      qry.SQL.Add(' select  * from Sys_ProductForms     where Fversion='+quotedstr(self.edtVersion.Text ) );
      qry.Open;
      self.MmAuthForms.Lines.Add('go');
      while(not qry.Eof) do
      begin
         self.MmAuthForms.Lines.Add ( dmfrm.GetPostSQL (qry,true,'Sys_ProductForms') );
         qry.Next;
      end;
    finally
      qry.Free;
    end;
end;

end.

