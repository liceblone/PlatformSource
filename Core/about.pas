unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, Grids, DBGrids,FhlKnl, ComCtrls,UPublicFunction;

type
  TaboutFrm = class(TForm)
    GroupBox1: TGroupBox;
    lblVersion: TLabel;
    Label2: TLabel;
    LblUpdataTime: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  aboutFrm: TaboutFrm;
  type
 TFileTimeType = (fttCreation, fttLastAccess, fttLastWrite);
function GetFileDateTime(const FileName: string; FileTimeType: TFileTimeType): TDateTime;
implementation
uses datamodule;
{$R *.dfm}
function GetFileDateTime(const FileName: string; FileTimeType: TFileTimeType): TDateTime;
var handle:Thandle;
var date:integer;
begin
       handle:=0;
       Handle := fileopen(FileName, fmOpenRead	);
       if Handle <> 0 then
       begin
               date:=    FileGetDate(Handle   )     ;
               result:=   FileDateToDateTime(date);
               FileClose(Handle);
       end;
end;
procedure TaboutFrm.FormCreate(Sender: TObject);
begin
    self.Caption :=logininfo.SYstemCaption+'V'+GetSysVersion;
    self.lblVersion.Caption := self.Caption ;
   // self.LblUpdataTime.Caption :=DateTimeToStr(GetFileDateTime(application.ExeName              ,fttLastWrite));
end;

procedure TaboutFrm.GroupBox1Click(Sender: TObject);
begin
close;
end;

end.


