unit UnitModelFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFrmModel = class(TForm)
  private
    { Private declarations }
    FSubSysName:string;
    FwinID:string;
    procedure SetFwinID(const Value: string);

  public
    PAuthoriseTmpTable:string;
    { Public declarations }
    procedure Active(sender:Tobject);
    procedure SetSubSysName(PSubSysName:string);
    property  FWindowsFID:string read FwinID write SetFwinID;
    constructor Create(owner:Tcomponent);override;
    procedure   CommonFormClose(Sender: TObject; var Action: TCloseAction);virtual;
  end;

var
  FrmModel: TFrmModel;

implementation

uses desktop ,FhlKnl,datamodule;

{$R *.dfm}

{ TFrmModel }

procedure TFrmModel.Active(sender: Tobject);
begin
if self.FSubSysName <>'' then
    desktopfrm.ChangSubSysName (self.FSubSysName );
end;

procedure TFrmModel.CommonFormClose(Sender: TObject; var Action: TCloseAction);
var sql:string;
begin
  if PAuthoriseTmpTable<>'' then
  begin
    sql := Format('if exists( select * from tempdb.dbo.sysobjects where name =''%s'') drop table %s',[PAuthoriseTmpTable, PAuthoriseTmpTable]);
    fhlknl1.Kl_GetQuery2(sql  ,false );
    Action:=caFree;

  end;
end;

constructor TFrmModel.Create(owner: Tcomponent);
begin
self.OnActivate :=self.Active;
  inherited;

end;

 

procedure TFrmModel.SetFwinID(const Value: string);
var fsql:string;
begin
  FwinID := Value;
  fsql:='select FCaption from '+LoginInfo.MainUserDBName +'.dbo.TSysUMenuConfig where FWindowsFID ='+quotedstr(Value);
  FhlKnl1.Kl_GetQuery2(fsql); 
  Self.Caption :=FhlKnl1.FreeQuery.fieldbyname('Fcaption').AsString;
end;

procedure TFrmModel.SetSubSysName(PSubSysName: string);
begin

{
     if (fhlknl1.Connection.DefaultDatabase <> PSubSysName)and (PSubSysName<>'') then

                         }
  self.FSubSysName :=PSubSysName;
end;

end.
