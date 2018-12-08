unit UnitUpdateProerty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,datamodule, ComCtrls,StrUtils, Menus, ExtCtrls , UPublicCtrl;
type TcontrolEx=class(Tcontrol)  ;
type
  TFrmUpdateProperty = class(TForm)
    FontDialog1: TFontDialog;
    pm1: TPopupMenu;
    F1: TMenuItem;
    B1: TMenuItem;
    dlgColor1: TColorDialog;
    P1: TMenuItem;
    a1: TMenuItem;
    GrpCTRL: TGroupBox;
    rg1: TRadioGroup;
    Label1: TLabel;
    Editclick: TEdit;
    cmbclick: TComboBox;
    Label2: TLabel;
    Editdbclick: TEdit;
    cmbdbclick: TComboBox;
    cmbexit: TComboBox;
    Editexit: TEdit;
    Label3: TLabel;
    ChkReadOnly: TCheckBox;
    edtUpdateAction: TButton;
    BtnClearhint: TButton;
    btnRemoveCtrl: TButton;
    ColorBox1: TColorBox;
    GrpLabel: TGroupBox;
    edtCaption: TEdit;
    lbl1: TLabel;
    btnRemove: TButton;
    btnUpdate: TButton;
    lbl2: TLabel;
    edtECaption: TEdit;
    chkDLGridDatasource: TCheckBox;
    procedure btnUpdateClick(Sender: TObject);
    procedure edtCaptionChange(Sender: TObject);
    procedure edtUpdateActionClick(Sender: TObject);
    procedure cmbclickClick(Sender: TObject);
    procedure cmbdbclickClick(Sender: TObject);
    procedure cmbexitClick(Sender: TObject);
    procedure BtnClearhintClick(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure lbl1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnRemoveCtrlClick(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure a1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChkReadOnlyClick(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure chkDLGridDatasourceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Acontrol:    Tcontrol;
  end;

var
  FrmUpdateProperty: TFrmUpdateProperty;

implementation

uses desktop;

{$R *.dfm}

procedure TFrmUpdateProperty.btnUpdateClick(Sender: TObject);
begin
    if  Acontrol is Tlabel then
    begin
        Tlabel( Acontrol ).Caption := lbl1.Caption ;//  edtCaption.Text ;
        Tlabel_Mtn( Acontrol ).ECaption :=edtEcaption.Text ;
        Tlabel( Acontrol ).Font :=lbl1.Font ;
        Tlabel( Acontrol ).Color :=  lbl1.Color ;

    end;

end;

procedure TFrmUpdateProperty.edtCaptionChange(Sender: TObject);
begin
if  Acontrol is Tlabel then
 lbl1.Caption :=  edtCaption.Text ;
   
end;

procedure TFrmUpdateProperty.edtUpdateActionClick(Sender: TObject);
var hintlist:Tstringlist;
begin
    try
      hintlist:=Tstringlist.Create;
      hintlist.CommaText:=  Tedit( Acontrol).Hint ;
      if  Acontrol is Tedit then
      begin
            if hintlist.Count<=1 then
                Tedit( Acontrol).Hint := Tedit( Acontrol).Hint+ ','+ Editclick.Text   +','+Editdbclick.Text + ','+Editexit.Text
            else
                Tedit( Acontrol).Hint :=hintlist[0]+ ','+ Editclick.Text   +','+Editdbclick.Text + ','+Editexit.Text;
      end;
    finally
      hintlist.Free;
    end;

end;

procedure TFrmUpdateProperty.cmbclickClick(Sender: TObject);
begin
       Editclick.Text :=inttostr(Tcombobox(Sender).ItemIndex );
end;

procedure TFrmUpdateProperty.cmbdbclickClick(Sender: TObject);
begin
  Editdbclick.Text :=inttostr(Tcombobox(Sender).ItemIndex );
edtUpdateAction.Click ;
end;

procedure TFrmUpdateProperty.cmbexitClick(Sender: TObject);
begin
 Editexit.Text :=inttostr(Tcombobox(Sender).ItemIndex );
end;

procedure TFrmUpdateProperty.BtnClearhintClick(Sender: TObject);
begin
       if  Acontrol is Tedit then
    begin
        Tedit( Acontrol).Hint := '';//Tedit( Acontrol).Hint+ ','+ Editclick.Text   +','+Editdbclick.Text + ','+Editexit.Text  ;
    end;
end;

procedure TFrmUpdateProperty.F1Click(Sender: TObject);
var   FontDialog1: TFontDialog;
begin
      FontDialog1:=TFontDialog.Create (self);
      if    FontDialog1.Execute then
               lbl1.Font.Assign (FontDialog1.Font );


      btnUpdate.Click ;
end;

procedure TFrmUpdateProperty.B1Click(Sender: TObject);
begin
if  dlgColor1.Execute then
    lbl1.Color :=dlgColor1.Color ;

    btnUpdate.Click ;
end;

procedure TFrmUpdateProperty.P1Click(Sender: TObject);
begin
     lbl1.Color :=self.Color ;
     btnUpdate.Click ;
end;

procedure TFrmUpdateProperty.lbl1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var pp:Tpoint;
begin
GetCursorPos(pp);
pm1.Popup(pp.x,pp.y);
end;

procedure TFrmUpdateProperty.btnRemoveClick(Sender: TObject);
begin
Acontrol.Free ;
end;

procedure TFrmUpdateProperty.btnRemoveCtrlClick(Sender: TObject);
begin
Acontrol.Free ;
end;

procedure TFrmUpdateProperty.rg1Click(Sender: TObject);
begin
Acontrol.Tag :=  rg1.itemindex;
edtUpdateAction.Click ;
end;

procedure TFrmUpdateProperty.a1Click(Sender: TObject);
begin
lbl1.Color :=stringtocolor('clCream');
btnUpdate.Click ;
end;

procedure TFrmUpdateProperty.FormCreate(Sender: TObject);
var i:integer;
begin

 


  if    DesktopFrm.dsMainMenu.FieldByName('F15').AsBoolean   then
  begin
     for i:= 0 to    dmfrm.dbCtrlActionList1.ActionCount-1 do
    begin
        cmbclick.Items.Add(dmfrm.dbCtrlActionList1.Actions [i].Name ) ;
        cmbdbclick.Items.Add(dmfrm.dbCtrlActionList1.Actions [i].Name ) ;
        cmbexit.Items.Add(dmfrm.dbCtrlActionList1.Actions [i].Name ) ;
    end;
  end
  else
  begin
    for i:= 0 to    dmfrm.UserDbCtrlActLst.ActionCount-1 do
    begin
        cmbclick.Items.Add(dmfrm.UserDbCtrlActLst.Actions [i].Name ) ;
        cmbdbclick.Items.Add(dmfrm.UserDbCtrlActLst.Actions [i].Name ) ;
        cmbexit.Items.Add(dmfrm.UserDbCtrlActLst.Actions [i].Name ) ;
    end;

end;



//dbCtrlActionList1

 {   if  Acontrol is Tlabel then
    begin

       lbl1.Color :=  Tlabel( Acontrol ).Color ;

    end;
    }
end;

procedure TFrmUpdateProperty.ChkReadOnlyClick(Sender: TObject);
begin
       if  Acontrol is Tedit then
          (Acontrol as  Tedit).ReadOnly :=ChkReadOnly.Checked ;
end;

procedure TFrmUpdateProperty.ColorBox1Change(Sender: TObject);
begin
       if  Acontrol is Tedit then
    begin

        Tedit( Acontrol).Font.Color :=  ColorBox1.Selected ;

    end;
end;

procedure TFrmUpdateProperty.chkDLGridDatasourceClick(Sender: TObject);
begin
    Tedit_Mtn( Acontrol).DLDataSourceType:=1;
end;

end.



