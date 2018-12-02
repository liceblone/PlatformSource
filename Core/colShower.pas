unit colShower;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids,dbGrids,db;

type
  TcolShowerFrm = class(TForm)
    StringGrid1: TStringGrid;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure InitFrm(DbGrid:TDbGrid);
    procedure Exchange(fRow:Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    fDbGrid:TDbGrid;
  public


  end;

Const o1='   ¡Ì';
      o2='';

implementation

{$R *.DFM}

procedure TcolShowerFrm.InitFrm(DbGrid:TDbGrid);
 var i:integer;
begin
   fDbGrid:=DbGrid;
   StringGrid1.RowCount:=fDbGrid.Columns.Count;
   with fDbGrid do
     for i:=0 to Columns.Count-1 do begin
         StringGrid1.Cols[0].Append(Columns[i].Title.Caption);
         if Columns[i].Visible then
            StringGrid1.Cells[1,i]:=o1
         else
            StringGrid1.Cells[1,i]:=o2;
     end;
end;

procedure TcolShowerFrm.Exchange(fRow:Integer);
begin
 if StringGrid1.Cells[1,fRow]=o1 then
    StringGrid1.Cells[1,fRow]:=o2
 else
    StringGrid1.Cells[1,fRow]:=o1;
end;

procedure TcolShowerFrm.Button1Click(Sender: TObject);
 var i:integer;
begin
  for i:=0 to fDbGrid.Columns.Count-1 do
      fDbGrid.Columns[i].Visible:=StringGrid1.Cells[1,i]=o1;
end;

procedure TcolShowerFrm.Button3Click(Sender: TObject);
 var i:integer;
begin
 for i:=0 to StringGrid1.RowCount-1 do
     Exchange(i);
end;

procedure TcolShowerFrm.StringGrid1Click(Sender: TObject);
begin
 ExChange(StringGrid1.Selection.Top);
end;

procedure TcolShowerFrm.Button4Click(Sender: TObject);
 var i:integer;
begin
  for i:=0 to StringGrid1.RowCount-1 do
    StringGrid1.Cells[1,i]:=o1;
end;

end.
