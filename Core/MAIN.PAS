unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ToolWin, ComCtrls, ExtCtrls, StdCtrls,ShellApi,inifiles,Registry, UPublicFunction,
  DB, ADODB, XPMenu;

type
  TmainFrm = class(TForm)
    MainMenu1: TMainMenu;
    H1: TMenuItem;
    WindowMenu: TMenuItem;
    MaxAllBtn: TMenuItem;
    N37: TMenuItem;
    ExchangeBtn: TMenuItem;
    CloseAllBtn: TMenuItem;
    TlMenu: TMenuItem;
    N3: TMenuItem;
    bgBtn: TMenuItem;
    DefbgBtn: TMenuItem;
    WinBgBtn: TMenuItem;
    MybgBtn: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    StatusBar1: TStatusBar;
    N7: TMenuItem;
    NReflashMainMenu: TMenuItem;
    PopupMenu1: TPopupMenu;
    N8: TMenuItem;
    p1: TMenuItem;
    io1: TMenuItem;
    XPMenu1: TXPMenu;
    gpTree: TGroupBox;
    Splitter1: TSplitter;
    TreeViewMenu: TTreeView;
    MenuShowTree: TMenuItem;
    dsMainMenu: TADODataSet;
    NMetaData: TMenuItem;
    NClearBUserData: TMenuItem;
    N9: TMenuItem;
    menuRefreshCfgData: TMenuItem;
    procedure ShowHint(Sender: TObject);
    //---扩展菜单
    procedure InitExMenu;
    procedure OpenExFile(Sender:TObject);
    procedure WindowMenuClick(Sender: TObject);
    procedure WindowMenuItemClick(Sender: TObject);
    //---桌面图像
    procedure InitDesktop;
    procedure WriteDesktop(fuse:Integer;fimgpath:wideString);
    procedure DefbgBtnClick(Sender: TObject);
    procedure WinBgBtnClick(Sender: TObject);
    procedure MybgBtnClick(Sender: TObject);
    //---
    procedure N3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject); 
    procedure NReflashMainMenuClick(Sender: TObject);
    procedure MenuShowTreeClick(Sender: TObject);
    procedure TreeViewMenuDblClick(Sender: TObject);
    procedure NMetaDataClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NClearBUserDataClick(Sender: TObject);
    procedure menuRefreshCfgDataClick(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  mainFrm: TmainFrm;

implementation

uses datamodule, Login, about, desktop;
{$R *.DFM}

procedure Tmainfrm.ShowHint(Sender: TObject);
begin
  //Statusbar1.Panels[0].Text:=Application.Hint;
//  if Application.Hint='' then
//  Statusbar1.Panels[0].Text:='[企业管理软件]';
end;

//windows
procedure TmainFrm.WindowMenuClick(Sender: TObject);
var
  i:integer;
  myItem:TMenuItem;
begin
  for i:=WindowMenu.Count-1 Downto 9 do
   WindowMenu.Delete(i);
  //Add line
  myItem:=TMenuItem.Create(WindowMenu);
  myItem.Caption:='-';
  WindowMenu.Add(myItem);
  //Add MdiChildFrm to menu
  for i:=0 to self.MDIChildCount-1 do
  begin
    myItem:=TMenuItem.Create(WindowMenu);
    myItem.Caption:=' &'+intTostr(i)+' '+self.MDIChildren[i].Caption;
    myItem.Tag:=i;
    myitem.OnClick:=WindowMenuItemClick;
    //Give Check mark for active mdichildfrm
    if self.ActiveMDIChild.Name=self.MDIChildren[i].Name then
      myItem.Checked:=true;
    WindowMenu.Add(myItem);
  end;
end;

procedure TmainFrm.WindowMenuItemClick(Sender: TObject);
begin
  MDIChildren[TMenuItem(Sender).Tag].Show;
end;

//ExMenu
procedure TmainFrm.InitExMenu;
 var f:Tinifile;t:TStringList;i:integer;m:TMenuItem;
begin
  T:=TStringList.Create;
  f:=Tinifile.Create(ExtractFileDir(Application.exeName)+'\cfg.ini');
  T.CommaText:='-,'+f.ReadString('menu','items','计算器,记事本');
  for i:=0 to T.Count-1 do begin
    m:=TMenuItem.Create(TlMenu);
    m.Caption:=T.Strings[i];
    TlMenu.Add(m);
    m.Tag:=2002+i;
    m.OnClick:=OpenExFile;
  end;
  f.Free;
  T.Free;
end;

procedure TmainFrm.OpenExFile(Sender:TObject);
 var f:Tinifile;e:ansistring;m:string;
begin
 f:=Tinifile.Create(ExtractFileDir(Application.ExeName)+'\cfg.ini');
 m:='file'+intTostr((Sender As TComponent).Tag);
 e:=f.ReadString('menu',m,'');
 if Not FileExists(e) then begin
    ShowMessage(#13#10'文件('+e+')没找到,'+#13#10+'请重新指定文件名.');
    if Not dmFrm.OpenDialog1.Execute then begin
       f.Free;
       Exit;
    end;
    e:=dmFrm.OpenDialog1.FileName;
    f.WriteString('menu',m,e);
 end;
 f.Free;
 ShellExecute(Handle, 'open',PChar(e), '', '', sw_ShowNormal);
end;

//Desktop
procedure TmainFrm.DefbgBtnClick(Sender: TObject);
 var p:widestring;
begin
  p:=ExtractFileDir(Application.exeName)+'\bg.jpg';
  if fileexists(p) then
     WriteDesktop(0,p)
  else
    MessageDlg(#13#10'默认桌面图像不存在,路径如下:'+p,mtError,[mbYes],0);
end;

procedure TmainFrm.WinBgBtnClick(Sender: TObject);
 var f:TRegIniFile;p:widestring;
begin
  f:=TRegIniFile.Create;
  f.RootKey:=HKEY_USERS;
  f.OpenKey('.DEFAULT\Control Panel',false);
  p:=f.ReadString('desktop','Wallpaper','');
  f.CloseKey;
  f.Free;
  WriteDesktop(1,p);
end;

procedure TmainFrm.MybgBtnClick(Sender: TObject);
begin
 with dmFrm.OpenDialog1 do begin
  filter:='全部文件(*.*)|*.*|JPEG图像文件(*.jpg)|*.jpg|JPEG图像文件(*.jpeg)|*.jpeg|BMP图像文件(*.bmp)|*.bmp|WMF图像文件(*.wmf)|*.wmf';
  if Execute then
     WriteDesktop(2,FileName);
 end;
end;

procedure TmainFrm.WriteDesktop(fuse:Integer;fimgpath:wideString);
var
  f:Tinifile;
begin
     f:=Tinifile.Create(ExtractFileDir(Application.exeName)+'\cfg.ini');
     f.WriteInteger('desktop','use',fuse);
     f.WriteString('desktop','path',fimgpath);
     f.Free;
     InitDeskTop;
{     if MessageDlg(#13#10+'桌面图像设置成功,是否现在就应用该桌面?',mtInformation,[mbYes,mbNo],0)=mrYes then
     begin
       Application.Terminate;
       ShellExecute(Handle,'open',pChar(Application.exeName),'',pChar(ExtractFileDir(Application.ExeName)),0);
     end;}
end;

procedure TmainFrm.InitDesktop;
var
  f:Tinifile;
  p:widestring;
begin
  f:=Tinifile.Create(ExtractFileDir(Application.exeName)+'\cfg.ini');
  bgbtn.Items[f.ReadInteger('desktop','use',0)].Checked:=true;
  p:=f.ReadString('desktop','path','');
  if (p='') or (FileExists(p)) then
      DeskTopFrm.Image1.Picture.LoadFromFile(p)
    else if MessageDlg(#13#10'桌面图像文件('+p+')不存在,'+#13#10#13#10+'是否使用默认桌面?  ',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      DefbgBtnClick(DefbgBtn);
  FreeAndNil(f);    
end;

procedure TmainFrm.N3Click(Sender: TObject);
begin
with TaboutFrm.Create(Application) do begin
 showmodal;
end;
end;



procedure TmainFrm.FormShow(Sender: TObject);
var i:integer;
begin

  FhlKnl1.Tv_NewDataNode(TreeViewMenu,nil,'','根结点',12,12);
  FhlKnl1.Cf_ListAllNodeForMain(DesktopFrm.dsMainMenu,TreeViewMenu,34,0,'f01','f04',false);
  with TreeViewMenu.Items.GetFirstNode do
  begin
    Expand(False);
  end;
  Application.OnHint:=ShowHint;
  InitExMenu;
  InitDesktop;
  XPMenu1.Active :=false;
  XPMenu1.Active :=true;

  for i:= TreeViewMenu.Items.Count -1 downto 0 do      //2010-8-15
  begin
    DesktopFrm.dsMainMenu.Locate('f01',TStrPointer(TreeViewMenu.Items[i].Data)^,[])  ;
    if not TreeViewMenu.Items[i].HasChildren then
      if DesktopFrm.dsMainMenu.FieldByName ('f05').AsInteger =-1 then
           TreeViewMenu.Items[i].Free ;
  end;      

  menuRefreshCfgData.Visible := logininfo.isAdmin;
end;

procedure TmainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FhlUser.Logout;
  FreeAndNil(dmFrm);
//  FreeAndNil(desktopFrm);
  Action:=caFree;
end;

procedure TmainFrm.N7Click(Sender: TObject);
begin
  WriteDesktop(3,'');
end;

procedure TmainFrm.FormCreate(Sender: TObject);
begin
   //  Application.Title := logininFo.SysName +FloatToStr(cversion);

end;



procedure TmainFrm.NReflashMainMenuClick(Sender: TObject);
begin
fhluser.changeUserDataBase (logininfo.PrivorUserDataBase );
desktopfrm.InitMenu ;
end;

procedure TmainFrm.MenuShowTreeClick(Sender: TObject);
begin
MenuShowTree.Checked :=not MenuShowTree.Checked ;
gpTree.Visible := MenuShowTree.Checked  ;
end;

procedure TmainFrm.TreeViewMenuDblClick(Sender: TObject);
var   menuitem:Tmenuitem;
begin
    menuitem:=Tmenuitem.Create (nil);
    DesktopFrm.dsMainMenu.Locate('f01',TStrPointer(treeviewmenu.Selected.Data)^,[])  ;
    if not treeviewmenu.Selected.HasChildren then
      if DesktopFrm.dsMainMenu.FieldByName ('f05').AsInteger >-1 then
        if DesktopFrm.dsMainMenu.FieldByName ('f06').AsInteger >-1 then
        begin
            menuitem.Tag :=DesktopFrm.dsMainMenu.FieldByName ('f06').AsInteger ;
            menuitem.Name :=DesktopFrm.dsMainMenu.FieldByName ('f01').AsString  ;
            DesktopFrm.ActionList1.Actions[DesktopFrm.dsMainMenu.FieldByName ('f05').AsInteger ].OnExecute (menuitem) ;
        end;

     menuitem.Free ;
end;

procedure TmainFrm.NMetaDataClick(Sender: TObject);
var param:string;
begin
     param:='PrjMetaData.exe  '+GetSysVersion;
    winexec(pchar(param), SW_MAXIMIZE	) ;

end;

procedure TmainFrm.FormActivate(Sender: TObject);
begin
   NClearBUserData.Visible :=logininfo.Sys ;   
end;

procedure TmainFrm.NClearBUserDataClick(Sender: TObject);
var qry,qtyTruncate:Tadoquery;
    fsql, BackupDir:widestring;
begin
//select ' truncate table  '+tableEname+';',*from salesBasicinfo.dbo.TAllUserTable where isnull(FisBasicTable,0)<>1 and isnull(FisSys,0)<>1

 if MessageDlg(#13#10+'确实要清空业务数据?',mtInformation,[mbYes,mbNo],0)=mrNo then     exit;

 if dmfrm.ADOConnection1.DefaultDatabase=logininfo.SysDBPubName then
 begin
   showmessage  ('先打开一个业务界面再做清空');
   exit;
 end;
  try
    try
       qry:=Tadoquery.Create(nil);
       qtyTruncate:=Tadoquery.Create(nil);

       qtyTruncate.Connection :=dmfrm.ADOConnection1 ;
       qry.Connection :=dmfrm.ADOConnection1 ;
       BackupDir:= ExtractFileDir(application.ExeName)  +'\DBBACKUP' ;

      //BACKUP DATABASE mydb  TO DISK ='C:\DBBACK\mydb.BAK'
      if not DirectoryExists( BackupDir ) then
           CreateDir(BackupDir ) ;

       qry.SQL.Clear;
       fsql:=  'BACKUP DATABASE '+dmfrm.ADOConnection1.DefaultDatabase +'  TO DISK ='''+ BackupDir+'\UserDB'+FormatDateTime('yyyy-mm-dd-hhhmmss', Now )+'.BAK'' '  ;
       qry.SQL.Add( fsql );
       qry.ExecSQL ;

       qry.SQL.Clear;
       qry.SQL.Add( 'select  '' truncate table  ''+ tableEname,*from '+logininfo.SysDBPubName+'.dbo.TAllUserTable where isnull(FisBasicTable,0)<>1 and isnull(FisSys,0)<>1' ) ;
       qry.Open ;

       while(not qry.Eof ) do
       begin
           qtyTruncate.SQL.Clear;

           qtyTruncate.SQL.Add(  ' if exists(select *from sysobjects where name='+  QuotedStr(qry.fieldbyname( 'tableEname').AsString   ) +')'  ) ;
           qtyTruncate.SQL.Add( qry.Fields[0].AsString   ) ;
           qtyTruncate.ExecSQL;
           qry.Next ;
       end;
       qtyTruncate.SQL.Clear;
       qtyTruncate.SQL.Add( 'delete sys_user where sys=0 and  empid not in (select FempCode from Temployee)' ) ;
       qtyTruncate.ExecSQL;

       showmessage('清空数据成功！如果是误删请用/DBBACK的备份文件恢复！');
    except
        on err:exception do
        begin
            showmessage(err.Message );
        end;
    end;
  finally
    qry.Free ;
    qtyTruncate.Free ;
  end;

end;

procedure TmainFrm.menuRefreshCfgDataClick(Sender: TObject);
begin
  fhlknl1.RefreshCfgData;
end;

end.
