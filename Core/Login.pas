unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db,variants,Inifiles, ComCtrls ,UnitChgPwd;

type
  TLoginFrm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    pwEdit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Bevel2: TBevel;
    Label5: TLabel;
    warningLabel: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    Label6: TLabel;
    ydBox1: TComboBox;
    Label7: TLabel;
    placeBox1: TComboBox;
    Label8: TLabel;
    tabBox1: TComboBox;
    chkRmberPsWd: TCheckBox;
    pb1: TProgressBar;
    DtPickerOpDate: TDateTimePicker;
    Label4: TLabel;
    BtnChangePWd: TButton;
    userEdit1: TComboBox;
    procedure Timer1Timer(Sender: TObject);
    procedure pwEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tabBox1Change(Sender: TObject);
    procedure ydBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  VerifyChainStoreAuthority :Boolean;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;   Shift: TShiftState; X, Y: Integer);
    procedure pwEdit1KeyDown(Sender: TObject; var Key: Word;   Shift: TShiftState);
    function gettimestamp(var Pcomputer:string):string;
    function ThereIsSomeOnline:boolean;
    procedure BtnChangePWdClick(Sender: TObject);
    procedure userEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure userEdit1Change(Sender: TObject);
    procedure userEdit1Exit(Sender: TObject);
  private
    fTabs,fDbNames,fFiliales,fWhs:TStringList;
    fComputerName,fIpAddr,fMac:String;
    f:TIniFile;
  public
     ComputerName:string;
  end;

var
  LoginFrm: TLoginFrm;

implementation
uses datamodule,UPublicFunction;
{$R *.DFM}
procedure TLoginFrm.Timer1Timer(Sender: TObject);
begin
  warningLabel.Visible:=not warningLabel.Visible;
end;

procedure TLoginFrm.pwEdit1Change(Sender: TObject);
begin
  Timer1.Enabled:=false;
  warninglabel.visible:=false;
end;

procedure TLoginFrm.FormCreate(Sender: TObject);
var LastUser, fsql :string;
begin
   DtPickerOpdate.DateTime:= date  ;
   fFiliales:=TStringList.Create;
   fTabs:=TStringList.Create;
   fDbNames:=TStringList.Create;
   fWhs:=TStringList.Create;

   f:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\cfg.ini');


   fComputerName:=FhlKnl1.Os_GetComputerName;
   fIpAddr:=FhlKnl1.Os_GetComputerIp;
   fMac:=FhlKnl1.Os_GetComputerMac ;

   if  (fComputerName='chyvmxp') then
   begin
     FhlKnl1.Kl_GetQuery2('select code,name,ename,ApplicationName from '+logininfo.SysDBPubName +'.dbo.sys_branch where IsUse=1') ;
   end
   else
   begin
     fsql :=   'exec    Pr_GetAvailableBranch '''+fComputerName+''','''+fIpAddr +''','''+fMac+''' ' ;
     FhlKnl1.Kl_GetQuery2( fsql );
   end;
  if  FhlKnl1.FreeQuery.Recordset.RecordCount =0 then
  begin
    showmessage(fComputerName+','+fIpAddr +','+fMac);
    application.Terminate ;
  end;

  with FhlKnl1.FreeQuery do
  begin
   while not eof do
   begin
     ydBox1.Items.Append(Fields[1].asString);
     fFiliales.Append(Fields[0].asString);
      logininfo.SYstemCaption := Fieldbyname('ApplicationName').asString;
     Next;
   end;
   Close;
  end;
  
  Label1.Caption :=  logininfo.SYstemCaption + GetSysVersion;
  Label2.Caption :=  logininfo.SYstemCaption + GetSysVersion;
  label1.Left := strtoint(floattostr(int(self.Width /2- label1.Width /2)));
  label2.Left:=label1.Left+3;

  ydBox1.ItemIndex:=f.ReadInteger('Login','YdIdx',0);
  ydBox1Change(ydBox1);
  tabBox1.ItemIndex:=f.ReadInteger('Login','TabIdx',0);
  tabBox1Change(tabBox1);
  placeBox1.ItemIndex:=f.ReadInteger('Login','WhIdx',0);
  LastUser:=f.Readstring('Login','LastUser','');
  userEdit1.Items.CommaText  :=  f.ReadString('Users','Users','');

  if LastUser<>'' then
  begin
    userEdit1.Text:=LastUser;
    if  f.ReadInteger(LastUser,'RmBerPsWd',0)=1 then
    begin
      pwEdit1.Text :=FhlKnl1.St_Encrypt(f.Readstring (LastUser,'PassWord',''));//
      chkRmberPsWd.Checked :=true;
    end;
  end;
end;

procedure TLoginFrm.ydBox1Change(Sender: TObject);
var fsql:string;
begin
  tabBox1.Items.Clear;
  placeBox1.Items.Clear;
  fTabs.Clear;
  fDbNames.Clear;

  if ydBox1.ItemIndex=- 1 then ydBox1.ItemIndex:=0;

  fsql := 'select * from ' +logininfo.SysDBPubName+'.dbo.sys_DataBase where filialeid='''+fFiliales.Strings[ydBox1.ItemIndex]+'''' ;

  FhlKnl1.Kl_GetQuery2( fsql );
  with FhlKnl1.FreeQuery do
  begin
   Button1.Enabled:=Not Isempty;
   if Isempty then
   begin
      MessageDlg(#13#10+'该分公司尚未有任何帐套,请创建新帐套.',mtInformation,[mbOk],0);
      Exit;
   end;
   while not eof do
   begin
      tabBox1.Items.Append(FieldByName('name').asString);
      fTabs.Append(FieldByName('code').asString);
      fDbNames.Append(FieldByName('db').asString);
      Next;
   end;
   Close;
  end;
  tabBox1.ItemIndex:=0;
  tabBox1Change(tabBox1);
end;

procedure TLoginFrm.tabBox1Change(Sender: TObject);
begin
  placeBox1.Items.Clear;
  fWhs.Clear;
  dmFrm.ADOConnection1.DefaultDatabase:=fDbNames.Strings[tabBox1.ItemIndex];
  FHLKNL1.setUserDataBase(fDbNames.Strings[ tabBox1.ItemIndex ])  ;

  dmFrm.GetQuery1('select Code,Name from  ' +logininfo.SysDBPubName+'.dbo.sys_ChainStore where FBranchCode='+fTabs[tabBox1.ItemIndex] );
  with dmfrm.freeQuery1 do
  begin
    if IsEmpty then  exit;
    while not eof do
    begin
      placeBox1.Items.Append(Fields[1].asString);
      fWhs.Append(Fields[0].asString);
      Next;
    end;
    Close;
  end;
  placeBox1.ItemIndex:=0;
end;

procedure TLoginFrm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  fEId,fLTime:String;
  FLockTime:integer;
  PIssys,PIsAdmin:boolean;
  NameList:Tstrings;
begin
    if ModalResult=mrOk then
    begin
          //is anyone already online?
          // if   not  ThereIsSomeOnline then
          begin
           //判断C/S之间的时间是否有差别     zxh 08.1.6
                 {
                  if not dmFrm.ExecStoredProc('Pr_GetSerDate',FormatDateTime('yyyy-mm-dd',now)) then
                  begin
                      showmessage(dmFrm.FreeStoredProc1.Parameters.Items[2].Value);
                      ModalResult:= MrCancel;
                      exit;
                  end;
                  }
                if dmFrm.ExecStoredProc( 'sys_Login',varArrayof([fWhs.Strings[placeBox1.ItemIndex],userEdit1.Text,pwEdit1.Text,fComputerName,fIpAddr])) then
                begin
                    fEId:=dmFrm.FreeStoredProc1.Parameters.ParamValues['@EmpId'];
                    FLockTime:=dmFrm.FreeStoredProc1.Parameters.ParamValues['@LockTime'];
                    PIssys:=dmFrm.FreeStoredProc1.Parameters.ParamValues['@Issys'];
                    PIsAdmin:=dmFrm.FreeStoredProc1.Parameters.ParamValues['@IsAdmin'];
                    fLTime:=FormatDateTime('yyyy"-"mm"-"dd" "hh":"nn":"ss"."zzz',dmFrm.FreeStoredProc1.Parameters.ParamValues['@LoginTime']);

                    FhlUser.Logout('注消,并以'+userEdit1.Text+'重新登陆');
                    with LoginInfo do
                    begin
                        EmpId:=fEId;
                        LoginTime:=fLTime;
                        DataBaseID:=fFiliales.Strings[ydBox1.ItemIndex];
                        TabId:=fTabs.Strings[tabBox1.ItemIndex];
                        ChainStoreId:=fWhs.Strings[placeBox1.ItemIndex];
                        LoginId:=userEdit1.Text;
                        LockTime:=FLockTime;
                        sys:=PIssys;
                        IsAdmin:= PIsAdmin;
                        Istool:=false;
                        
                        ChainStoreName:=placeBox1.Items[ placeBox1.ItemIndex ]   ;
                        ChainStoreCode:=fWhs[ placeBox1.ItemIndex ]   ;
                        FirmCnName:=ydBox1.Items[ydBox1.ItemIndex ]   ;
                        OperationDate:=DtPickerOpDate.Date;
                    end;

                   { FhlKnl1.Kl_GetQuery2( 'select * from  '+logininfo.SysDBPubName+'.dbo.sys_branch where code= '+quotedstr( LoginInfo.ChainStoreId));
                    with FhlKnl1.FreeQuery do
                    begin
                        with LoginInfo do
                        begin
                            FirmCnName:=FieldByName('Name').asString;
                            FirmEnName:=FieldByName('eName').asString;
                            Address:=FieldByName('Addr').asString;
                            Zip:=FieldByName('Zip').asString;
                            Tel:=FieldByName('Tel').asString;
                            Fax:=FieldByName('Fax').asString;
                        end;
                        Close;
                    end; }
                    Action:=caFree;
                    // Application.MainForm.Caption:=Application.Title+' - '+ydBox1.Items.Strings[tabBox1.ItemIndex] +' - '+tabBox1.Items.Strings[tabBox1.ItemIndex];
                    f.WriteInteger('Login','YdIdx'  ,ydbox1.ItemIndex);
                    f.WriteInteger('Login','TabIdx' ,tabbox1.ItemIndex);
                    f.WriteInteger('Login','WhIdx'  ,placeBox1.ItemIndex);
                    f.WriteString ('Login','LoginId',userEdit1.Text);
                    f.WriteString ('Login','LastUser',userEdit1.Text);

                    if chkRmberPsWd.Checked then
                    begin
                        NameList :=Tstringlist.Create;
                        NameList.CommaText :=f.ReadString ( 'Users' ,'Users','');
                        if (namelist.IndexOf( userEdit1.Text )=-1) then
                          namelist.Add( userEdit1.Text );

                        f.WriteInteger ( userEdit1.Text ,'RmBerPsWd',1);
                        f.WriteString ( userEdit1.Text ,'PassWord',FhlKnl1.St_Encrypt(pwEdit1.Text));
                        f.WriteString ( 'Users' ,'Users',namelist.CommaText  );
                    end
                    else
                    begin
                        f.WriteInteger ( userEdit1.Text ,'RmBerPsWd',0);
                        f.WriteString ( userEdit1.Text ,'PassWord','');
                     end;

                    if not LoginInfo.Sys then
                    if not LoginInfo.isAdmin  then
                    if not VerifyChainStoreAuthority then
                    begin
                       Timer1.Enabled:=true;
                       Action:=caNone;
                       Exit;
                    end;
               end
               else
               begin
                   MessageDlg(#13#10+Format(dmFrm.FreeStoredProc1.Parameters.ParamValues['@ErrorMsg'],[userEdit1.Text,placeBox1.Items.Strings[placeBox1.ItemIndex]]),mtError,[mbOk],0);
                   Timer1.Enabled:=true;
                   Action:=caNone;
               end;
          end;
    end;
end;

procedure TLoginFrm.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  releasecapture;
  perform(wm_syscommand,sc_move+1,0);
end;

procedure TLoginFrm.pwEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (ssCtrl in Shift) and ( key=67 ) then
key:=0;
//  if (ssCtrl in Shift) and (ssAlt in Shift) and (ssShift in Shift) and (Key=vk_F12) then
  //  ShowMessage(dmFrm.ADOConnection1.ConnectionString);
end;

function TLoginFrm.gettimestamp(var Pcomputer:string): string;
var asql:string;
begin
   // 当天最后一次非本机登录，且没正常退出
   asql:=' select  top 1 *  from sys_loginlog     '
        +' where loginid='+quotedstr(userEdit1.Text  )+'  and islogin=1   '
        +' and convert(char(10),intime,121)  =convert(char(10),getdate(),121) '
        +' and computer <> '+quotedstr(fComputerName)+'order by intime desc '  ;

      dmFrm.GetQuery1(asql );
      with dmfrm.freeQuery1 do
      begin
          if  FieldByName('outtime').AsString ='' then
          begin
             Pcomputer:= FieldByName('computer').AsString ;
             result :=  FieldByName('online').asstring  ;
          end
          else
            result :=  '';
      end;
end;

function TLoginFrm.ThereIsSomeOnline: boolean;
  var timestamp1,timestamp2:string ;
  var i,pmax:integer;
begin
     self.Cursor := crsqlwait;

     timestamp1:= self.gettimestamp (ComputerName);
     if     timestamp1<>'' then
     begin
         if MessageBox(0, '需要约半分钟时间验证是否有人在使用您的帐号.同意验证吗？', '', MB_YESNO +
           MB_ICONQUESTION) = IDNO then
         begin
            self.Cursor := crdefault;
            abort;
         end;

         self.Refresh;
         pmax:=50;
         self.pb1.Max :=pmax;

         for i:=1 to pmax do
         begin
              self.pb1.Position :=i;
              sleep(440);
         end;{}
         timestamp2:= self.gettimestamp (ComputerName);
         if  timestamp2=timestamp1 then
             result:=false
         else
             result:=true;
     end
     else
         result:=false;

    self.Cursor := crdefault;
end;

procedure TLoginFrm.BtnChangePWdClick(Sender: TObject);
var
FrmChgPwd:TFrmChgPwd ;
sql:string;
begin
try
    FrmChgPwd:=TFrmChgPwd.Create (nil);
    FrmChgPwd.edtUserName.Text :=self.userEdit1.Text ;
    FrmChgPwd.ShowModal;
    if FrmChgPwd.ModalResult =mrOk then
    begin
       sql:='select * From sys_user where  loginid='  + quotedstr(FrmChgPwd.edtUserName.Text) ;
       fhlknl1.Kl_GetUserQuery(sql);

       if  fhlknl1.User_Query.IsEmpty then
       begin
           self.warningLabel.Caption :='用户名不存在!';
           exit;
       end;
       if  FrmChgPwd.edtNewPwd.Text <>FrmChgPwd.edtConfirmPwd.Text then
       begin
           self.warningLabel.Caption :='新密码不匹配!';
           exit;
       end;
       sql:='select * From sys_user where  loginid='  + quotedstr(FrmChgPwd.edtUserName.Text) +' and password='+quotedstr(FrmChgPwd.edtOriPwd.Text );
       fhlknl1.Kl_GetUserQuery(sql);
       if  fhlknl1.User_Query.IsEmpty then
       begin
           self.warningLabel.Caption :='原密码不正确!';
           exit;
       end;

       sql:='update sys_user set password= '+FrmChgPwd.edtNewPwd.Text   +' ,passwordx=password  where  loginid='  + quotedstr(FrmChgPwd.edtUserName.Text) +' and password='+quotedstr(FrmChgPwd.edtOriPwd.Text );
       fhlknl1.Kl_GetUserQuery(sql,false);

    end;
finally
    FrmChgPwd.Free ;
end;

 end;

procedure TLoginFrm.userEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    self.pwEdit1.Text :='';
    self.chkRmberPsWd.Checked :=false;
end;

function TLoginFrm.VerifyChainStoreAuthority: Boolean;
var sql:string;
begin
//
   result:=True;
   FhlKnl1.Kl_GetQuery2(  'select * from  '+logininfo.SysDBPubName+'.dbo.sys_ChainStore where FisNotSys=1 and code= '+quotedstr( LoginInfo.ChainStoreId)) ;

   if not FhlKnl1.FreeQuery.IsEmpty then
   begin
      sql:='select * from '+FhlKnl1.UserConnection.DefaultDatabase+'.dbo.TEmployee where FLoginName='+quotedstr( LoginInfo.LoginId )+' and FChainStoreCode ='+quotedstr( LoginInfo.ChainStoreId);
      FhlKnl1.Kl_GetQuery2( sql)   ;
      result:= not FhlKnl1.FreeQuery.IsEmpty
   end;
end;

procedure TLoginFrm.FormDestroy(Sender: TObject);
begin
    if Assigned ( f) then
       FreeAndNil(f);
end;

procedure TLoginFrm.userEdit1Change(Sender: TObject);
begin
//


end;

procedure TLoginFrm.userEdit1Exit(Sender: TObject);
begin
    f:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\cfg.ini');
  if  f.ReadInteger(userEdit1.Text ,'RmBerPsWd',0)=1 then
  begin
    pwEdit1.Text :=FhlKnl1.St_Encrypt(f.ReadString (userEdit1.Text,'PassWord',''));//
    chkRmberPsWd.Checked :=true;
  end
  else
  begin
    pwEdit1.Text :='';
    chkRmberPsWd.Checked :=false;
  end;  

end;

end.


