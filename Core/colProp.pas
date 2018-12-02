unit colProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,TypInfo,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls,dbgrids,UPublicCtrl,DB;

type
   TcolPropFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Label4: TLabel;
    titleBgColorBox1: TColorBox;
    titleFontColorBox1: TColorBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    bgColorBox1: TColorBox;
    fontColorBox1: TColorBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Label6: TLabel;
    titleFontSizeEdit1: TEdit;
    Label9: TLabel;
    fontSizeEdit1: TEdit;
    CheckBox1: TCheckBox;
    Label11: TLabel;
    widthEdit1: TEdit;
    GroupBox3: TGroupBox;
    visRadioBtn2: TRadioButton;
    visRadioBtn1: TRadioButton;
    Label5: TLabel;
    edtTitleCaption: TEdit;
    Label10: TLabel;
    ComDecimal: TComboBox;
    Label12: TLabel;
    ComBoGrpType: TComboBox;
    procedure InitFrm(ADbGrid:TDbGrid);
    procedure ShowData;
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure visRadioBtn1Click(Sender: TObject);
    procedure widthEdit1Change(Sender: TObject);
    procedure titleBgColorBox1Change(Sender: TObject);
    procedure titleFontColorBox1Change(Sender: TObject);
    procedure titleFontSizeEdit1Change(Sender: TObject);
    procedure bgColorBox1Change(Sender: TObject);
    procedure fontColorBox1Change(Sender: TObject);
    procedure fontSizeEdit1Change(Sender: TObject);
    procedure widthEdit1KeyPress(Sender: TObject; var Key: Char);
    function  GetCurrCol:TColumn;
    procedure RadioButton1Click(Sender: TObject);
    procedure edtTitleCaptionChange(Sender: TObject);
    procedure ComDecimalChange(Sender: TObject);
    procedure ComBoGrpTypeChange(Sender: TObject);
  private
    fDbGrid:TDbGrid;
    fRecNos:TStringList;
    fColsProp: Variant;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TcolPropFrm.InitFrm(ADbGrid:TDbGrid);
var
  i:integer;
begin
  fDbGrid:=ADbGrid;
  fColsProp:=VarArrayCreate([0,fDbGrid.Columns.Count-1],varVariant);
  for i:=0 to fDbGrid.Columns.Count-1 do
    with TChyColumn(fDbGrid.Columns.Items[i])  do
      fColsProp[i]:=VarArrayOf([Visible,Width,Title.Color,Title.Font.Color,Title.Font.Size,Alignment,Color,Font.Color,Font.Size,Title.Caption ,DeciamlFormat,SumType ]);
  CheckBox1Click(CheckBox1);
end;


procedure TcolPropFrm.ComboBox1Change(Sender: TObject);
begin
  ShowData;
end;

procedure TcolPropFrm.ShowData;
begin
  with GetCurrCol do
  begin
    self.Caption:='¡– Ù–‘ - '+Title.Caption;
    visRadioBtn1.Checked:=Visible;
    visRadioBtn2.Checked:=not visRadioBtn1.Checked;
    widthEdit1.Text:=intTostr(Width);
    titleBgColorBox1.Selected:=Title.Color;
    titleFontColorBox1.Selected:=Title.Font.Color;
    titleFontSizeEdit1.Text:=intTostr(Title.Font.Size);
    bgColorBox1.Selected:=Color;
    fontColorBox1.Selected:=Font.Color;
    fontSizeEdit1.Text:=intTostr(Font.Size);
    edtTitleCaption.Text :=title.Caption ;
    if Alignment=taLeftJustify then
      RadioButton1.Checked:=True
    else if Alignment=taCenter then
      RadioButton1.Checked:=True
    else
      RadioButton1.Checked:=True;

      if  (GetCurrCol.Field is   TFloatField)
       or (GetCurrCol.Field is   TCurrencyField)
       or (GetCurrCol.Field is   TIntegerField)
       or (GetCurrCol.Field is   TLargeintField)
       or (GetCurrCol.Field is   TFMTBCDField)
       or (GetCurrCol.Field is   TBCDField)       then
      begin
        self.ComDecimal.Enabled :=true;
        self.ComDecimal.Text := TChyColumn(GetCurrCol).DeciamlFormat ;

        self.ComBoGrpType.Enabled :=true;
        self.ComBoGrpType.ItemIndex :=ord(TChyColumn(GetCurrCol).SumType )
      end
      else
      begin
        self.ComDecimal.Enabled :=false;
        self.ComBoGrpType.Enabled :=false;
      end;  

  end;
end;

procedure TcolPropFrm.CheckBox1Click(Sender: TObject);
 var i:integer;
begin
  ComboBox1.Items.Clear;
  fRecNos.Clear;
  for i:=0 to fDbGrid.Columns.Count-1 do
      if (Not CheckBox1.Checked) or (fDbGrid.Columns[i].Visible) then
      begin
          ComboBox1.Items.Append(fDbGrid.Columns[i].Title.Caption);
          fRecNos.Append(intTostr(i));
      end;
  ComboBox1.ItemIndex:=0;
  ShowData;
end;

procedure TcolPropFrm.FormCreate(Sender: TObject);
begin
   fRecNos:=TStringList.Create;
end;

procedure TcolPropFrm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i:integer;
begin

  if ModalResult<>mrOk then
    for i:=0 to fDbGrid.Columns.Count-1 do
      with TChyColumn(fDbGrid.Columns[i]) do
      begin
        Visible:=fColsProp[i][0];
        Width:=fColsProp[i][1];
        Title.Color:=fColsProp[i][2];
        Title.Font.Color:=fColsProp[i][3];
        Title.Font.Size:=fColsProp[i][4];
        Alignment:=fColsProp[i][5];
        Color:=fColsProp[i][6];
        Font.Color:=fColsProp[i][7];
        Font.Size:=fColsProp[i][8];
        Title.Caption:=fColsProp[i][9];
        DeciamlFormat :=fColsProp[i][10];
        SumType:=fColsProp[i][11];
      end;
  fRecNos.Free;

end;

function TcolPropFrm.GetCurrCol:TColumn;
var col:TColumn;
begin
  col:=fDbGrid.Columns[strToint(fRecNos.Strings[ComboBox1.ItemIndex])];
  Result:=col ;
end;

procedure TcolPropFrm.visRadioBtn1Click(Sender: TObject);
begin
  GetCurrCol.Visible:=visRadioBtn1.Checked;
end;

procedure TcolPropFrm.widthEdit1Change(Sender: TObject);
begin
  GetCurrCol.Width:=strToint(widthEdit1.Text);
end;

procedure TcolPropFrm.titleBgColorBox1Change(Sender: TObject);
begin
  GetCurrCol.Title.Color:=titleBgColorBox1.Selected;
end;

procedure TcolPropFrm.titleFontColorBox1Change(Sender: TObject);
begin
  GetCurrCol.Title.Font.Color:=titleFontColorBox1.Selected;
end;

procedure TcolPropFrm.titleFontSizeEdit1Change(Sender: TObject);
var col:Tcolumn;
begin
col:=GetCurrCol ;
  col.Title.Font.Size:=strToint(titleFontSizeEdit1.Text);
end;

procedure TcolPropFrm.bgColorBox1Change(Sender: TObject);
begin
  GetCurrCol.Color:=bgColorBox1.Selected;
end;

procedure TcolPropFrm.fontColorBox1Change(Sender: TObject);
begin
  GetCurrCol.Font.Color:=fontColorBox1.Selected;
end;

procedure TcolPropFrm.fontSizeEdit1Change(Sender: TObject);
begin
  GetCurrCol.Font.Size:=strToint(fontSizeEdit1.Text);
end;

procedure TcolPropFrm.widthEdit1KeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in (['0'..'9'])) then
    Key:=#0;
end;

procedure TcolPropFrm.RadioButton1Click(Sender: TObject);
begin
  case (Sender as TRadioButton).Tag of
       1:GetCurrCol.Alignment:=taCenter;
       2:GetCurrCol.Alignment:=taRightJustify;
       else GetCurrCol.Alignment:=taLeftJustify;
  end;
end;

procedure TcolPropFrm.edtTitleCaptionChange(Sender: TObject);
begin
  GetCurrCol.Title.Caption :=edtTitleCaption.Text  ;
end;

procedure TcolPropFrm.ComDecimalChange(Sender: TObject);
begin
   TChyColumn(GetCurrCol).DeciamlFormat :=self.ComDecimal.Text ;
end;

procedure TcolPropFrm.ComBoGrpTypeChange(Sender: TObject);
begin
  
   if ComBoGrpType.Text ='' then
      TChyColumn(GetCurrCol).SumType  :=  STEmpty
   else
      TChyColumn(GetCurrCol).SumType  :=  TSumType(  ComBoGrpType.ItemIndex );
      { }
end;

end.
