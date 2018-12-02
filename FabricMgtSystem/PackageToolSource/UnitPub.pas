unit UnitPub;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids,inifiles, ComCtrls, ExtCtrls,  ComObj,StrUtils,
  VCLUnZip, VCLZip, FileCtrl  ,WinSvc, shellapi,WinSock   ;

Type ILogger=interface
   procedure Save(Msg:string);
{ TxtLogger }



end ;
Type TTxtLogger=class(TObject)
    public
    procedure Save(Msg:string);
end ;

implementation
   
{ TxtLogger }

procedure TTxtLogger.Save(Msg: string);
var
LogFile: TextFile;
logfieldName:string;
begin

    logfieldName := 'SQLLog.txt' ;
    if not FileExists(logfieldName) then
    begin
      AssignFile(LogFile, logfieldName);
        Rewrite(LogFile);

      CloseFile(LogFile); //关闭时自动保存文件
    end;

    AssignFile(LogFile, logfieldName);
    Append(LogFile);

    Write(LogFile, Msg +#9 );
    writeln(LogFile, '                ');

    CloseFile(LogFile);
end;



/////////////////////////////////////////////////////////////////////////////

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
end.
