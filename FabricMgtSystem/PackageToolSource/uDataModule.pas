unit uDataModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids,inifiles, ComCtrls, ExtCtrls,  ComObj,StrUtils,
  VCLUnZip, VCLZip, FileCtrl  ,WinSvc, shellapi,WinSock,   WinInet,nb30;

  Const
   MAX_ADAPTER_NAME_LENGTH        = 256;
   MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
   MAX_ADAPTER_ADDRESS_LENGTH     = 8;

 type
	  TaPInAddr = array [0..10] of PInAddr;
	  PaPInAddr = ^TaPInAddr;

type
  PIPAdapterInfo = ^TIPAdapterInfo;
  TIPAdapterInfo = Record   // IP_ADAPTER_INFO
  Next                : PIPAdapterInfo;
  ComboIndex          : Integer;
  AdapterName         : Array[0..MAX_ADAPTER_NAME_LENGTH+3] of Char;
  Description         : Array[0..MAX_ADAPTER_DESCRIPTION_LENGTH+3] of Char;
  AddressLength       : Integer;
  Address             : Array[1..MAX_ADAPTER_ADDRESS_LENGTH] of Byte;
end;

type
  TLoginInfo = record
      LoginId:String;
      EmpId:String;
      DataBaseID:String;
      TabId:String;
      ChainStoreId:String;
      LoginTime:String;
      IsLocalServer:Boolean;
      LastReceiveStr:widestring;
      //FirmInfo
      FirmCnName:widestring;
      FirmEnName:widestring;
      Address:widestring;
      Zip:String;
      Tel:String;
      Fax:String;
      //SmtpInfo
      SmtpHost:String;
      SmtpPort:Integer;
      SmtpUser:String;
      SmtpPass:String;
      SmtpFrom:String;
      // WorkPlaceId:String;
      //GroupId:String;
      LockTime:integer;  //locktime  秒内鼠标没动，自动锁屏
      PubDataBasePreFix:string;
      SysDBPubName:string;
      SysDBase:string;
      UserDB:string;
      SysDBToolName:string;
      LogDataBaseName:string;

      password:string;
      isAdmin:boolean;
      Sys :boolean;
      SystemCaption:string;
      PrivorUserDataBase:string;
      IsTool:boolean;
      FMac:string;
      FIP:string;
      FMachineName:string;

    end;

type
  Tdmfrm = class(TDataModule)
    SysConnection1: TADOConnection;
    UserCnn: TADOConnection;
    CnnMaster: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);

  private
    function GetVersion: string;
    { Private declarations }
  public
    InstallPath:string ;
    MainExeFileName:string ;
    function  GetPostSQL(Adodataset: Tdataset; binsert: boolean; TableName: string): string;
    function  GetPostSQLForLogic(Adodataset: Tdataset; binsert: boolean; TableName: string): string;

    function  RunScript(FileName, dbname: string): string;
    property   Version:string read  GetVersion;
  end;


var
  dmfrm: Tdmfrm;
  LoginInfo:TLoginInfo ;

    function   GetSysVersion :  string;
    function   MakeFileList(Path,FileExt:string):TStringList ;
    function   Os_GetComputerName:String;
    function   Os_GetComputerIp:String;
    function   Os_GetComputerMac: String;

    procedure   DelDir(const   Source:string);
    procedure   DeleteDir(sDirectory:   String);
    function   RenDirectory(const   OldName,NewName:     string):   boolean;
    Function SavePass(StrPass:String):String;
    Function GetPass(StrPass:String):String;

    function  ServiceGetStatus(sMachine, sService: string ): DWord;
    function  ServiceUninstalled(sMachine, sService : string ) : boolean;
    function  ServiceRunning(sMachine, sService : string ) : boolean;
    function  ServiceStopped(sMachine, sService : string ) : boolean;


implementation

  function sendarp(ipaddr: ulong;  temp: dword;  ulmacaddr: pointer;  ulmacaddrleng: pointer): DWord;
  stdcall;  external 'Iphlpapi.dll' Name 'SendARP';
  
Function GetAdaptersInfo(AI : PIPAdapterInfo; Var BufLen : Integer) : Integer;
        StdCall; External 'iphlpapi.dll' Name 'GetAdaptersInfo';

//此函数为核心函数 
function  GetAdapterInformation():string;
Var
 AI,Work : PIPAdapterInfo; 
 Size    : Integer; 
 Res     : Integer; 
 I       : Integer; 

 Function MACToStr(ByteArr : PByte; Len : Integer) : String; 
 Begin 
   Result := ''; 
   While (Len > 0) do Begin
     Result := Result+IntToHex(ByteArr^,2)+'-';
     ByteArr := Pointer(Integer(ByteArr)+SizeOf(Byte));
     Dec(Len); 
   End; 
   SetLength(Result,Length(Result)-1); { remove last dash }
 End; 

begin 
 Size := 5120; 
 GetMem(AI,Size); 
 Res := GetAdaptersInfo(AI,Size); 
 If (Res <> ERROR_SUCCESS) Then Begin 
   SetLastError(Res); 
   RaiseLastWin32Error; 
 End; 
  Begin 
   Work := AI; 
   I := 1; 
   Repeat 
     GetAdapterInformation:=MACToStr(@Work^.Address,Work^.AddressLength);
     //上面的代码是将网卡地址送给窗口的标题 
     Inc(I); 
     Work := Work^.Next; 
   Until (Work = nil); 
 End; 
 FreeMem(AI);
end;      //此函数为核心函数

function Os_GetComputerMac: String;
var   ncb   : TNCB;
   status   : TAdapterStatus;
   lanenum : TLanaEnum;
     procedure ResetAdapter (num : char);
     begin
       fillchar(ncb,sizeof(ncb),0);
       ncb.ncb_command:=char(NCBRESET);
       ncb.ncb_lana_num:=num;
       Netbios(@ncb);
     end;
var
   i:integer;
   lanNum   : char;
   address : record
              part1 : Longint;
              part2 : Word;
             end absolute status;
begin
   Result:='';
   fillchar(ncb,sizeof(ncb),0);
     ncb.ncb_command:=char(NCBENUM);
     ncb.ncb_buffer:=@lanenum;
     ncb.ncb_length:=sizeof(lanenum);
   Netbios(@ncb);
   if lanenum.length=#0 then exit;
   lanNum:=lanenum.lana[0];
   ResetAdapter(lanNum);
   fillchar(ncb,sizeof(ncb),0);
     ncb.ncb_command:=char(NCBASTAT);
     ncb.ncb_lana_num:=lanNum;
     ncb.ncb_callname[0]:='*';
     ncb.ncb_buffer:=@status;
     ncb.ncb_length:=sizeof(status);
   Netbios(@ncb);
   ResetAdapter(lanNum);
   for i:=0 to 5 do
   begin
     result:=result+inttoHex(integer(Status.adapter_address[i]),2);
     if (i<5) then
     result:=result+'-';
   end;
end;

function Os_GetComputerIp:String;

	var
	  phe : PHostEnt;
	  pptr : PaPInAddr;
	  Buffer : array [0..63] of char;
	  I : Integer;
	  GInitData : TWSADATA;
	begin
	  WSAStartup($101, GInitData);
	  Result := '';
	  GetHostName(Buffer, SizeOf(Buffer));
	  phe :=GetHostByName(buffer);
	  if phe = nil then Exit;
	  pptr := PaPInAddr(Phe^.h_addr_list);
	  I := 0;
	  while pptr^[I] <> nil do
	  begin
	     result:=StrPas(inet_ntoa(pptr^[I]^));
	     Inc(I);
	  end;
	  WSACleanup;
end;
function    GetSysVersion :  string;
var
    VerInfoSize:   DWORD;
    VerInfo:   Pointer;
    VerValueSize:   DWORD;
    VerValue:   PVSFixedFileInfo;
    Dummy:   DWORD;
    dwProductVersionMS,dwProductVersionLS:DWORD;
    sTemp,FName :   String;
    inif :Tinifile;
begin
 inif :=Tinifile.Create (ExtractFileDir(Application.ExeName)+'\update.ini');
  dmfrm.MainExeFileName:=inif.ReadString('Exe','Exe','');

    FName   :=   '..\'+dmfrm.MainExeFileName;
    if not fileexists( FName) then
    begin
      result:='';
      FName   :=  dmfrm.MainExeFileName ;
      if not fileexists( FName) then
      begin
         Exit;
      end;
    end;

  
    VerInfoSize   :=   GetFileVersionInfoSize(PChar(FName),   Dummy);
    GetMem(VerInfo,   VerInfoSize);
    GetFileVersionInfo(PChar(FName),   0,   VerInfoSize,   VerInfo);
    VerQueryValue(VerInfo,   '\',   Pointer(VerValue),   VerValueSize);
    with   VerValue^   do
    begin
        dwProductVersionMS   :=   dwFileVersionMS;
        dwProductVersionLS   :=   dwFileVersionLS;
        sTemp   :=Format('%d.%d.%d.%d',   [
            dwProductVersionMS   shr   16,
            dwProductVersionMS   and   $FFFF,
            dwProductVersionLS   shr   16,
            dwProductVersionLS   and   $FFFF
            ]);
    end;
  //  ShowMessage(sTemp);

    FreeMem(VerInfo,   VerInfoSize);
    result:= sTemp;
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
function   Os_GetComputerName:String;
var
ComputerName:   PChar;
size:   DWord   ;
begin
    GetMem(ComputerName   ,   255   )   ;
    size   :=   255   ;
    GetComputerName(ComputerName,size) ;
    result:=ComputerName   ;
    FreeMem(ComputerName);
end;
procedure   DelDir(const   Source:string);
  var   SH:TSHFileOpStruct;
  begin
                  SH.Wnd:=0;
                  SH.pFrom:=pchar(Source);//删除c:\1这个目录
                  sh.wFunc:=FO_DELETE;//有四种操作，copy,delete,move,rename
                  sh.pTo:=nil;
                  sh.fFlags:=FOF_ALLOWUNDO;//这里有很多参数，这个用上后，是放到回收站
                  SHFileOperation(sh);
  end;
procedure   DeleteDir(sDirectory:   String);
  //删除目录和目录下得所有文件和文件夹   
  var   
      sr:   TSearchRec;
      sPath,sFile:   String;   
  begin   
      //检查目录名后面是否有   '\'   
      if   Copy(sDirectory,Length(sDirectory),1)   <>   '\'   then   
          sPath   :=   sDirectory   +   '\'   
      else   
          sPath   :=   sDirectory;   
    
      //------------------------------------------------------------------
      if   FindFirst(sPath+'*.*',faAnyFile,   sr)   =   0   then   
      begin   
          repeat   
              sFile:=Trim(sr.Name);   
              if   sFile='.'   then   Continue;   
              if   sFile='..'   then   Continue;   
    
              sFile:=sPath+sr.Name;   
              if   (sr.Attr   and   faDirectory)<>0   then   
                  DeleteDir(sFile)
              else   if   (sr.Attr   and   faAnyFile)   =   sr.Attr   then   
                  DeleteFile(sFile);                                                 //删除文件
          until   FindNext(sr)   <>   0;   
          FindClose(sr);   
      end;   
      RemoveDir(sPath);
      //------------------------------------------------------------------   
  end;
function   RenDirectory(const   OldName,NewName:     string):   boolean;
  var
      fo:   TSHFILEOPSTRUCT;
  begin   
      FillChar(fo,   SizeOf(fo),   0);   
      with   fo   do   
      begin   
          Wnd   :=   0;   
          wFunc   :=   FO_RENAME;
          pFrom   :=   PChar(OldName+#0);   
          pTo   :=   pchar(NewName+#0);
          fFlags   :=   FOF_NOCONFIRMATION+FOF_SILENT;
      end;
      Result   :=   (SHFileOperation(fo)   =   0);
  end;
//转换明码为暗码
Function SavePass(StrPass:String):String;
var
  Pass:string;
  i,k:Integer;
const
  F_charset='`1234567890-=qwertyuiop[]\asdfghjkl;''zxcvbnm,./?><MNBVCXZ":LKJHGFDSA|}{POIUYTREWQ+_)(*&^%$#@!~';
begin
  Result:='';
  if StrPass='' then Exit;
  Pass:='';
  for i:=1 to Length(StrPass) do begin
    Pass:=Pass+IntToHex(Ord(StrPass[i]),0);
  end;
  for i:=1 to Length(Pass) do Result:=Result+Pass[Length(Pass)-i+1];
  Pass:='';
  for i:=1 to Length(Result) do begin
    k:=0;
    while k=0 do k:=random(94);
    Pass:=Pass+F_CharSet[k]+Result[i];
  end;
  k:=0;
  while k=0 do k:=random(94);
  Result:=Pass+F_Charset[k];
end;
//-----------------------------------------------------------------------
//转换暗码为明码
Function GetPass(StrPass:String):String;
var
  Pass:string;
  i:Integer;
  F_Low,F_High:Integer;
  F_Hex:String;
begin
  Result:='';
  if StrPass='' then Exit;
  Pass:='';
  for i:=1 to Length(StrPass) div 2 do Pass:=Pass+Copy(StrPass,i*2,1);
  For i:=1 to Length(Pass) do  Result:=Result+Pass[Length(Pass)-i+1];
  Pass:='';
  for i:=1 to Length(Result) div 2 do begin
    F_Hex:=Copy(Result,i*2-1,2);
    case F_Hex[1] of
      '1':F_high:=$10;
      '2':F_high:=$20;
      '3':F_high:=$30;
      '4':F_high:=$40;
      '5':F_high:=$50;
      '6':F_high:=$60;
      '7':F_high:=$70;
      '8':F_high:=$80;
      '9':F_high:=$90;
      'A':F_High:=$A0;
      'B':F_High:=$B0;
      'C':F_High:=$C0;
      'D':F_High:=$D0;
      'E':F_High:=$E0;
      'F':F_High:=$F0;
    else F_high:=$00;
    end;
    case F_Hex[2] of
      '1':F_Low:=$1;
      '2':F_Low:=$2;
      '3':F_Low:=$3;
      '4':F_Low:=$4;
      '5':F_Low:=$5;
      '6':F_Low:=$6;
      '7':F_Low:=$7;
      '8':F_Low:=$8;
      '9':F_Low:=$9;
      'A':F_Low:=$A;
      'B':F_Low:=$B;
      'C':F_Low:=$C;
      'D':F_Low:=$D;
      'E':F_Low:=$E;
      'F':F_Low:=$F;
    else F_Low:=$0;
    end;
    Pass:=Pass+chr(F_High + F_Low);
  end;
  Result:=Pass;
end;
function ServiceGetStatus(sMachine, sService: string ): DWord;
var
//service control
//manager handle
schm,
//service handle
schs: SC_Handle;
//service status
ss: TServiceStatus;
//current service status
dwStat : DWord;
begin
dwStat := 0;
//connect to the service
//control manager
schm := OpenSCManager(PChar(sMachine), Nil, SC_MANAGER_CONNECT);
//if successful...
if(schm > 0)then
begin
//open a handle to
//the specified service
schs := OpenService(schm, PChar(sService), SERVICE_QUERY_STATUS);
//if successful...
if(schs > 0)then
begin
//retrieve the current status
//of the specified service
if(QueryServiceStatus(schs, ss))then
begin
dwStat := ss.dwCurrentState;
end;
//close service handle
CloseServiceHandle(schs);
end;

// close service control
// manager handle
CloseServiceHandle(schm);
end;

Result := dwStat;
end;

{判断某服务是否安装，未安装返回true，已安装返回false}
function  ServiceUninstalled(sMachine, sService : string ) : boolean;
begin
Result := 0 = ServiceGetStatus(sMachine, sService);
end;

{判断某服务是否启动，启动返回true，未启动返回false}
function  ServiceRunning(sMachine, sService : string ) : boolean;
begin
   Result := SERVICE_RUNNING = ServiceGetStatus(sMachine, sService );
end;

{判断某服务是否停止，停止返回true，未停止返回false}
function  ServiceStopped(sMachine, sService : string ) : boolean;
begin
Result := SERVICE_STOPPED = ServiceGetStatus(sMachine, sService );
end;


function TDmfrm.GetPostSQL(Adodataset: Tdataset; binsert: boolean;
  TableName: string): string;
var
    i:integer;
    sql1  ,F_ID ,ValueStr,FieldValue:string;
    flds,values,updateItem:Tstrings;

begin
    if  Adodataset.findfield('F_ID') =nil then exit;

    F_ID:=Adodataset.fieldbyname('F_ID').AsString ;
    flds:=TstringLIST.Create ;
    values:=TstringLIST.Create ;
    updateItem:=TstringLIST.Create ;




    ValueStr:='';
    for i:=0 to   Adodataset.FieldCount -1 do
    begin
      if   Adodataset.Fields[i].FieldKind = fkData then
      begin
          if  (Adodataset.Fields[i]is  TAutoIncField ) then
              continue;
          if  Adodataset.Fields[i] is  TBCDField then
              continue;
          if  Adodataset.Fields[i] is  TBinaryField then
              continue;
          if  Adodataset.Fields[i] is  TBlobField then
              continue;

          flds.Add( Adodataset.Fields[i].FieldName  ) ;

          if Adodataset.Fields[i].Value =null then
              FieldValue:='null'
          else
          begin
              if Adodataset.Fields[i] is TBooleanField	then
              begin
                if Adodataset.Fields[i].AsBoolean then
                    FieldValue:='1'
                else
                    FieldValue:='0' ;
              end
              else
                FieldValue:=quotedstr(  Adodataset.Fields[i].AsString)  ;
          end;
          if i=0 then
            ValueStr:= FieldValue
          else
            ValueStr:= ValueStr+','+FieldValue ;
      end;
    end;

    if  binsert  then
    begin
        sql1:=' if exists(select * from '+TableName+' where F_ID= '+quotedstr(F_ID)+') '+#13#10 +'delete '+TableName+' where F_ID= '+quotedstr(F_ID);
        sql1:=sql1 +#13#10 +'  go   '+#13#10  +'if exists(select *from syscolumns where id=object_id('+quotedstr(TableName)+') and colstat=1 )' ;
        sql1:=sql1 +#13#10 +'set IDENTITY_INSERT '+TableName+' on     ' ;
        sql1:=sql1 +#13#10 +'insert into '+TableName+' (';
        sql1:=sql1 +#13#10 +flds.CommaText +')values( '   +ValueStr+')' ;
        sql1:=sql1 +#13#10;

    end
    else
    begin

        sql1:=sql1     +' update '+TableName+' set ';
        for i:=0 to flds.Count-1 do
        begin
        if flds[i]<>'F_ID' then
           updateItem.Add(  flds[i]+'='+values[i])
        end;

        sql1:=sql1+updateItem.CommaText +' where F_ID='+ Adodataset.Fieldbyname('F_ID').AsString  ;


    end;



    result:=sql1;

    flds.Free ;
    values.Free ;
    updateItem.Free ;

end;
function Tdmfrm.GetVersion: string;
begin
Result :=GetSysVersion
end;

function TDmfrm.RunScript(FileName ,dbname: string): string;
var adoquery1:Tadoquery;
var
  s:string;
  sqltext : string;
begin
    try
        adoquery1:=Tadoquery.Create(nil);
        adoquery1.Connection :=dmfrm.UserCnn;
        adoquery1.Connection.DefaultDatabase :=LoginInfo.UserDB ;


       sqltext:='   exec exeSqlFileBatch   ''.'','+ QuotedStr(  dbname)+',''sa'',' + QuotedStr(LoginInfo.password )+   ','+quotedstr(FileName);


        try
            dmfrm.UserCnn.Open;
            dmfrm.UserCnn.BeginTrans;

            adoquery1.Close;
            adoquery1.SQL.Clear;
            adoquery1.SQL.Add(sqltext);

            adoquery1.open;

            dmfrm.UserCnn.CommitTrans;

            adoquery1.Next ;
            result:=adoquery1.Fields[0].AsString ;
            adoquery1.Next ;
            result:=result+ adoquery1.Fields[0].AsString ;

//          application.MessageBox('SQL脚本完成！',             '提示',MB_OK+MB_ICONINFORMATION);
        except
          on err:Exception do
          begin
             result:=err.Message ;
            raise exception.Create(err.Message );
            dmfrm.UserCnn.RollbackTrans;
          end;
        end;
    finally
        adoquery1.Free ;
    end;
end;
{$R *.dfm}

procedure Tdmfrm.DataModuleCreate(Sender: TObject);
var inif:TIniFile;
var ServerName,User, PCName:string;
var  vFilenameCaseMatch: TFilenameCaseMatch;
begin


    if ParamCount> 1 then
      InstallPath  :=ParamStr(2)
    else
      InstallPath  :=ExtractFilePath( ExtractFileDir((ParamStr(0))) );
      InstallPath := ExpandFileNameCase(InstallPath, vFilenameCaseMatch);

      inif:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
      ServerName              :=GetPass(inif.ReadString('DBConn','Server',''));
      LoginInfo.SysDBPubName  :=GetPass( inif.ReadString('DBConn','DataBase',''));
      LoginInfo.SysDBase      := ( inif.ReadString('DBConn','SysDataBase',''));
      LoginInfo.UserDB        := ( inif.ReadString('Config','UserDB',''));
      LoginInfo.SysDBToolName := inif.ReadString('DBConn','ToolDataBase','')   ;
      LoginInfo.LogDataBaseName  := inif.ReadString('DBConn','LogDataBase','')   ;
      User                    :=GetPass(inif.ReadString('DBConn','User',''));
      LoginInfo.password                :=GetPass(inif.ReadString('DBConn','Password',''));


      logininfo.FMachineName:=Os_GetComputerName;
      logininfo.FMac :=Os_GetComputerMac;
      logininfo.FIP:=  Os_GetComputerIp;

    inif.Free;


    begin
         LoginInfo.LastReceiveStr:=format('Provider=SQLOLEDB.1;'+
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
        [User,LoginInfo.password, LoginInfo.SysDBPubName ,ServerName]);

        dmfrm.SysConnection1.ConnectionString :=LoginInfo.LastReceiveStr ;
        dmfrm.UserCnn.ConnectionString :=LoginInfo.LastReceiveStr ;
        dmfrm.UserCnn.DefaultDatabase :=LoginInfo.UserDB ;;

       // Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=master;Data Source=.

        dmfrm.CnnMaster.ConnectionString :=format('Provider=SQLOLEDB.1;'+
        'Integrated Security=SSPI;Persist Security Info=false;'+
        'Initial Catalog=%s;'+
        'Data Source=%s;',
        ['master' ,ServerName]);
    end;
end;

function Tdmfrm.GetPostSQLForLogic(Adodataset: Tdataset; binsert: boolean;
  TableName: string): string;
var
    i:integer;
    sql1  ,F_ID ,ValueStr,FieldValue:string;
    flds,values,updateItem:Tstrings;

begin
//    if  Adodataset.findfield('F_ID') =nil then exit;

  //  F_ID:=Adodataset.fieldbyname('F_ID').AsString ;
    flds:=TstringLIST.Create ;
    values:=TstringLIST.Create ;
    updateItem:=TstringLIST.Create ;




    ValueStr:='';
    for i:=0 to   Adodataset.FieldCount -1 do
    begin
      if   Adodataset.Fields[i].FieldKind = fkData then
      begin
          if  (Adodataset.Fields[i]is  TAutoIncField ) then
              continue;
          if  Adodataset.Fields[i] is  TBCDField then
              continue;
          if  Adodataset.Fields[i] is  TBinaryField then
              continue;
          if  Adodataset.Fields[i] is  TBlobField then
              continue;

          flds.Add( Adodataset.Fields[i].FieldName  ) ;

          if Adodataset.Fields[i].Value =null then
              FieldValue:='null'
          else
          begin
              if Adodataset.Fields[i] is TBooleanField	then
              begin
                if Adodataset.Fields[i].AsBoolean then
                    FieldValue:='1'
                else
                    FieldValue:='0' ;
              end
              else
                FieldValue:=quotedstr(  Adodataset.Fields[i].AsString)  ;
          end;
          if (i=0 ) then
            ValueStr:= FieldValue
          else
            ValueStr:= ValueStr+','+FieldValue ;

            if Trim( LeftStr(ValueStr,1))=',' then
              ValueStr:=rightstr(ValueStr,length(ValueStr)-1)
      end;
    end;

    if  binsert  then
    begin
       // sql1:=' if exists(select * from '+TableName+' where F_ID= '+quotedstr(F_ID)+') '+#13#10 +'delete '+TableName+' where F_ID= '+quotedstr(F_ID);
        //sql1:=sql1 +#13#10 +'  go   '+#13#10  +'if exists(select *from syscolumns where id=object_id('+quotedstr(TableName)+') and colstat=1 )' ;
        //sql1:=sql1 +#13#10 +'set IDENTITY_INSERT '+TableName+' on     ' ;
        sql1:=sql1 +#13#10 +'insert into '+TableName+' (';
        sql1:=sql1 +#13#10 +flds.CommaText +')values( '   +ValueStr+')' ;
        sql1:=sql1 +#13#10;

    end
    else
    begin

        sql1:=sql1     +' update '+TableName+' set ';
        for i:=0 to flds.Count-1 do
        begin
        if flds[i]<>'F_ID' then
           updateItem.Add(  flds[i]+'='+values[i])
        end;

        sql1:=sql1+updateItem.CommaText +' where F_ID='+ Adodataset.Fieldbyname('F_ID').AsString  ;


    end;



    result:=sql1;

    flds.Free ;
    values.Free ;
    updateItem.Free ;

end;

end.
