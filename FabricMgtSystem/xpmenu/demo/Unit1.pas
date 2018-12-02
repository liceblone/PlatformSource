unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, XPMenu, StdCtrls, ComCtrls, ToolWin;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    sd1: TMenuItem;
    sdf1: TMenuItem;
    s1: TMenuItem;
    df1: TMenuItem;
    sdf2: TMenuItem;
    sd2: TMenuItem;
    f1: TMenuItem;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    hg1: TMenuItem;
    jk1: TMenuItem;
    j1: TMenuItem;
    hj1: TMenuItem;
    jh1: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ScrollBox1: TScrollBox;
    PopupMenu1: TPopupMenu;
    ret1: TMenuItem;
    d1: TMenuItem;
    fg1: TMenuItem;
    df2: TMenuItem;
    g1: TMenuItem;
    dfg1: TMenuItem;
    Button1: TButton;
    XPMenu1: TXPMenu;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  fMitem:Tmenuitem;
    fMitem2:Tmenuitem;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
XPMenu1.Active :=self.CheckBox1.Checked ;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
XPMenu1.Gradient  :=self.CheckBox2.Checked ;
end;

procedure TForm1.Button1Click(Sender: TObject);

begin
fMitem:=Tmenuitem.Create(MainMenu1);
fMitem2:=Tmenuitem.Create(fMitem);
fMitem.Add (fMitem2);
//fMitem2.HasParent:=   true;
   fMitem2.Caption :='sdfsdfdsfsd'    ;

fMitem.Caption :='hello ha ';
self.MainMenu1.Items.Add(fmitem);


end;

end.

