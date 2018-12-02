unit uGenerateDataSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TFrmGenerateDataSQL = class(TForm)
    MmTables: TMemo;
    MmSQLScript: TMemo;
    GroupBox1: TGroupBox;
    btnGetSQL: TButton;
    ADOQuery1: TADOQuery;
    procedure btnGetSQLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGenerateDataSQL: TFrmGenerateDataSQL;

implementation
      uses uDataModule;
{$R *.dfm}

procedure TFrmGenerateDataSQL.btnGetSQLClick(Sender: TObject);
var qry:Tadoquery;
var i:integer;
begin

    self.MmSQLScript.Clear;
  
    try

      qry:=Tadoquery.Create(nil);
      qry.Connection :=dmfrm.UserCnn  ;

        for i :=0 to  MmTables.Lines.Count -1 do
        begin
          qry.close;
          qry.SQL.clear;
          qry.SQL.Add(' select  * from '+self.MmTables.Lines [i]    );
          qry.Open;
          self.MmSQLScript.Lines.Add('go');
          while(not qry.Eof) do
          begin
             self.MmSQLScript.Lines.Add ( dmfrm.GetPostSQLForLogic (qry,true,self.MmTables.Lines [i]) );
             qry.Next;
          end;
      end;
    finally
       qry.free;
    end;

end;

end.
