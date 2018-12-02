unit Finder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Db, ADODB,variants,FhlKnl;


type
  TFinderFrm = class(TForm)
    GroupBox1: TGroupBox;
    ValGroupBox: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox2: TGroupBox;
    oprtComboBox: TComboBox;
    FldComboBox: TComboBox;
    Button1: TButton;
    Button2: TButton;
    OkBtn: TButton;
    Button4: TButton;
    ListBox1: TListBox;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Panel1: TPanel;
    Button5: TButton;
    ADODataSet2: TADODataSet;
    Button3: TButton;
    ADODataSet3: TADODataSet;
procedure SetNoLogic();
function GetValue:wideString;
function SumOneCnExpress:String;
function GetSqlExpress:wideString;
function GetCnExpress:String;
procedure DoFilter(FilterStr:String);
function SumSql:wideString;
function GetHavingSql:wideString;
function GetWhereSql:wideString;
function GetAllSql:wideString;
    procedure OpenLkpDlg(Sender:TObject);
    procedure GetOneSql(Sender: TObject);
    procedure DeleteSqlItem(Sender: TObject);
    procedure SumExpresses;
    procedure SetOpt(fItems,fOprts:wideString);
    function  GetEditCtrl:TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure InitFrm(FinderId:String);
    procedure FormDestroy(Sender: TObject);
    procedure FldComboBoxSelect(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure oprtComboBoxSelect(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    oprt:TStringList;
    fdict:TFinderDict;
  public
    property SysParams:wideString read fDict.fSysParams;
  end;

const tAnd=' and '; tCnAnd=' 并且 ';
      tOr=' or ';   tCnOr=' 或者 ';
      tNoLogic='';   tCnNoLogic='      ';
      tlow=105;  thigh=257;

var
  FinderFrm: TFinderFrm;

implementation
uses datamodule,lookup;
{$R *.DFM}
procedure TFinderFrm.InitFrm(FinderId:String);
begin
  AdoDataSet2.Connection:=FhlKnl1.Connection;
  AdoDataSet3.Connection:=AdoDataSet2.Connection;
  if Not FhlKnl1.Cf_GetDict_Finder(FinderId,fdict) then Close;
  AdoDataSet3.CommandText:='select * from udd_finderlist where 1=2';
  AdoDataSet3.Active:=True;
  AdoDataSet3.Sort:='ishaving';
  with AdoDataSet2 do
  begin
    CommandText:=fDict.fDtlSql;
    Active:=True;
    while not eof do
    begin
      FldComboBox.Items.Append(FieldByName('F04').asString);
      next;
    end;
  end;
  FldComboBox.ItemIndex:=fDict.fItemIdx;
  FldComboBoxSelect(FldcomboBox);
  oprtComboBox.ItemIndex:=fDict.fCompareIdx;
end;

function TFinderFrm.GetEditCtrl:TComboBox;
begin
       Result:=TComboBox.Create(ValGroupBox);
       with Result do begin
            Left:=5;
            Width:=190;
            Height:=25;
            Top:=24;
            Parent:=ValGroupBox;
            Ctl3D:=false;
            BevelKind:=bkSoft;
            ShowHint:=True;
        end;
end;
//取得值
function TFinderFrm.GetValue:wideString;
  var ctrl:TControl;
begin
    ctrl:=ValGroupBox.Controls[0];
    if ctrl is TDateTimePicker then
       Result:=''''+FormatDateTime('yyyy"-"mm"-"dd',TDateTimePicker(ctrl).DateTime)+''''
    else if ctrl is TRadioGroup then
       Result:=intTostr(TRadioGroup(ctrl).ItemIndex)
    else if ctrl is TMemo then
       Result:=TMemo(ctrl).Text
    else //ctrl is TEdit then
       Result:=TComboBox(ctrl).Text;
end;
//取得Sql语句
function TFinderFrm.GetSqlExpress:wideString;
  var opt:String;ft:Integer;fld,val:widestring;
begin
    fld:=AdoDataSet2.FieldByName('F05').asString;
    opt:=oprt.Strings[oprtComboBox.ItemIndex];
    val:=GetValue;
    ft:=AdoDataSet2.FieldByName('F06').asInteger;
    if (ft=cftString) or (ft=cftMemo) then
    begin
       if opt='like' then
          result:=' like ''%'+val+'%'''
       else if opt='not like' then
          result:=' not like ''%'+val+'%'''
       else if opt='like x%' then
          result:=' like '''+val+'%'''
       else if opt='not like x%' then
          result:=' not like '''+val+'%'''
       else if opt='like %x' then
          result:=' like ''%'+val+''''
       else if opt='not like %x' then
          result:=' not like ''%'+val+''''
       else
          result:=opt+''''+val+'''';
    end
    else
       result:=opt+val;
    result:=fld+result;
end;

function TFinderFrm.GetCnExpress:String;
  var ctrl:TControl;val,s:wideString;
begin
    ctrl:=ValGroupBox.Controls[0];
    if ctrl is TRadioGroup then
       val:=TRadioGroup(ctrl).Items.Strings[TRadioGroup(ctrl).ItemIndex]
    else if ctrl is TComboBox then
       val:=TComboBox(Ctrl).Text
    else
       val:=GetValue;
    s:=FldComboBox.Items.Strings[FldComboBox.ItemIndex]+' '+OprtComboBox.Items.Strings[OprtComboBox.ItemIndex]+' ';
    Val:='"'+Val+'"';
    if pos('...',s)<>0 then
       s:=Copy(s,0,pos('...',s)-1)+Val+Copy(s,pos('...',s)+3,Length(s))
    else
       s:=s+Val;
    result:=s;
end;

procedure TFinderFrm.GetOneSql(Sender: TObject);
begin
    if ValGroupBox.ControlCount=0 then exit;
    if self.Height=tlow then  FhlKnl1.Ds_ClearAllData(AdoDataSet3);
    FhlKnl1.Ds_AssignValues(AdoDataSet3,varArrayof(['ishaving','logic','lbracket','express','rbracket','subjectIdx','compareIdx','value','cnlogic','cnexpress']),varArrayof([AdoDataSet2.FieldByName('F07').asString,tAnd,' ',GetSqlExpress,' ',FldComboBox.ItemIndex,OprtComboBox.ItemIndex,GetValue,tCnAnd,GetCnExpress]));
    SumExpresses;
    ListBox1.ItemIndex:=ListBox1.Items.Count-1;
    ListBox1.SetFocus;
end;

procedure TFinderFrm.DeleteSqlItem(Sender: TObject);
begin
 if ListBox1.ItemIndex>-1 then
 begin
   AdoDataSet3.Delete;
   ListBox1.DeleteSelected;
 end;
 ListBox1.ItemIndex:=ListBox1.Items.Count-1;
end;

procedure TFinderFrm.FormCreate(Sender: TObject);
begin
  oprt:=TStringList.Create;
end;

procedure TFinderFrm.ListBox1Click(Sender: TObject);
 var s:string;i:integer;
begin
 AdoDataSet3.RecNo:=ListBox1.ItemIndex+1;

 if AdoDataSet3.FieldByName('lbracket').asString='(' then i:=0
 else if AdoDataSet3.FieldByName('rbracket').asString=')' then i:=1
 else i:=2;
 RadioGroup1.ItemIndex:=i;

 s:=AdoDataSet3.FieldByName('logic').asString;
 if s=tAnd then i:=0
 else if s=tOr then i:=1
 else i:=2;
 RadioGroup2.ItemIndex:=i;
end;

procedure TFinderFrm.RadioGroup1Click(Sender: TObject);
 var s1,s2:string;
begin
 if ListBox1.ItemIndex>-1 then begin
    case RadioGroup1.ItemIndex of
         0:begin
            s1:='(';
            s2:=' ';
           end;
         1:begin
            s1:=' ';
            s2:=')';
           end
      else begin
            s1:=' ';
            s2:=' ';
           end;
    end;
    FhlKnl1.Ds_AssignValues(AdoDataSet3,varArrayof(['lbracket','rbracket']),varArrayof([s1,s2]),false);
    ListBox1.Items.Strings[ListBox1.ItemIndex]:=SumOneCnExpress;
 end;
end;

procedure TFinderFrm.RadioGroup2Click(Sender: TObject);
 var s1,s2:string;
begin
 if ListBox1.ItemIndex>-1 then begin
    case RadioGroup2.ItemIndex of
         0:begin
            s1:=tAnd;
            s2:=tCnAnd;
           end;
         1:begin
            s1:=tOr;
            s2:=tCnOr;
           end
      else begin
            s1:=tNoLogic;
            s2:=tCnNoLogic;
           end;
    end;
    FhlKnl1.Ds_AssignValues(AdoDataSet3,varArrayof(['logic','cnlogic']),varArrayof([s1,s2]),false);
    ListBox1.Items.Strings[ListBox1.ItemIndex]:=SumOneCnExpress;
 end;
end;

function TFinderFrm.SumOneCnExpress:String;
begin
  with AdoDataSet3 do begin
       Result:=FieldByName('ishaving').asString+FieldByName('cnlogic').asString+FieldByName('lbracket').asString+FieldByName('cnexpress').asString+FieldByName('rbracket').asString;
  end;
end;

function TFinderFrm.SumSql:wideString;
begin
  with AdoDataSet3 do begin
       First;
       while not eof do begin
         Result:=Result+FieldByName('logic').asString+FieldByName('lbracket').asString+FieldByName('express').asString+FieldByName('rbracket').asString;
         Next;
       end;
  end;
end;

function TFinderFrm.GetWhereSql:wideString;
begin
  DoFilter('ishaving=''''');
  Result:=SumSql;
  DoFilter('');
  if fDict.fWhere<>'' then begin
     if Result<>'' then
        Result:=fDict.fWhere+' and '+Result
     else
        Result:=fDict.fWhere;
  end
  else if Result<>'' then
     Result:='where '+Result;
end;

function TFinderFrm.GetAllSql:wideString;
begin
  Result:=fDict.fSelect+' '+GetWhereSql+' '+fDict.fGroup+' '+GetHavingSql+' '+fDict.fOrder;
// showMessage(Result);
end;

function TFinderFrm.GetHavingSql:wideString;
begin
  DoFilter('ishaving=''+''');
  Result:=SumSql;
  DoFilter('');
  if Result<>'' then Result:='Having '+Result;
end;

procedure TFinderFrm.SetNoLogic();
begin
  FhlKnl1.Ds_AssignValues(AdoDataSet3,varArrayof(['logic','cnlogic']),varArrayof([tNoLogic,tCnNoLogic]),false);
end;

procedure TFinderFrm.DoFilter(FilterStr:String);
begin
  with AdoDataSet3 do begin
          Filter:=FilterStr;
          Filtered:=Filter<>'';
  end;
end;

procedure TFinderFrm.SumExpresses;
begin
  listbox1.Items.Clear;
  with AdoDataSet3 do begin
       DoFilter('ishaving=''+''');
       if RecordCount>0 then SetNoLogic();
       DoFilter('');
       First;
       SetNoLogic();
       while not eof do begin
         ListBox1.Items.Append(SumOneCnExpress);
         Next;
       end;
  end;
end;

procedure TFinderFrm.FormDestroy(Sender: TObject);
begin
 oprt.Free;
end;

procedure TFinderFrm.OpenLkpDlg(Sender:TObject);
  var a:Variant;
begin
  a:=FhlKnl1.Vr_CommaStrToVarArray(AdoDataSet2.FieldByName('F09').asString);
  LookupFrm:=TLookupFrm.Create(Application);
  Screen.Cursor:=crSqlWait;
  try
    FhlUser.SetDbGridAndDataSet(LookupFrm.DbGrid1,a[0],Null);
    LookupFrm.InitFrm;
    if LookupFrm.ShowModal=mrOk then
      TComboBox(Sender).Text:=LookupFrm.DataSource1.DataSet.FieldByName(a[1]).asString;
 finally
  LookupFrm.Free;
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFinderFrm.SetOpt(fItems,fOprts:wideString);
begin

       with oprtComboBox do begin
            Items.Clear;
            Items.CommaText:=fItems;
       end;
       oprt.Clear;
       oprt.CommaText:=fOprts;

end;

procedure TFinderFrm.FldComboBoxSelect(Sender: TObject);
 var ft,i:Integer;
begin
 for i:=ValGroupBox.ControlCount-1 downto 0 do
     ValGroupBox.Controls[i].free;
 AdoDataSet2.RecNo:=FldComboBox.ItemIndex+1;
 ft:=AdoDataSet2.FieldByName('F06').asInteger;
 if (ft=cftDate) or (ft=cftDateTime) then
 begin
       with TDateTimePicker.Create(ValGroupBox) do
       begin
            Left:=5;
            Width:=190;
            Height:=25;
            Top:=24;
            Parent:=ValGroupBox;
            DateTime:=now;
        end;
        SetOpt('等于,不等于,大于,小于,大于等于,小于等于','=,<>,>,<,>=,<=');
 end
 else if ft=cftBoolean then
 begin
       with TRadioGroup.Create(ValgroupBox) do
       begin
            Parent:=ValGroupBox;
            Align:=alClient;
            Columns:=2;
            Items.CommaText:='否,是';
       end;
       SetOpt('等于,不等于','=,<>');
 end
 else if ft=cftMemo then
 begin
       with TMemo.Create(ValGroupBox) do
       begin
            Parent:=ValGroupBox;
            Align:=alClient;
            Lines.Clear;
            ScrollBars:=ssVertical;
            Ctl3D:=false;
       end;
       SetOpt('等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾','=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"');
 end
 else if (ft=cftCurrency) or (ft=cftInteger) or (ft=cftFloat) then
 begin
        GetEditCtrl;
        SetOpt('等于,不等于,大于,小于,大于等于,小于等于','=,<>,>,<,>=,<=');
 end
 else begin
       SetOpt('等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾','=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"');
       with GetEditCtrl do
       begin
         if AdoDataSet2.FieldByName('F09').asString<>'' then
         begin
            OnDblClick:=OpenLkpDlg;
            Hint:='双击可以弹出选项框...';ShowHint:=True;
         end;
         if AdoDataSet2.FieldByName('F12').asString<>'' then
         begin
           dmFrm.GetQuery1(AdoDataSet2.FieldByName('F12').asString);
           while not dmFrm.FreeQuery1.Eof do
           begin
             Items.Append(dmFrm.FreeQuery1.Fields[0].asString);
             dmFrm.FreeQuery1.Next;
           end;
           dmFrm.FreeQuery1.Close;
         end else
           Style:=csSimple;
       end;
 end;
 oprtComboBox.ItemIndex:=0;
end;

procedure TFinderFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
  begin
    if ssCtrl in Shift then
       ModalResult:=mrOk
    else if Self.ActiveControl.Parent=ValGroupBox then
       Button1.Click;
  end else if (Key=vk_Delete) and (Self.ActiveControl=ListBox1) then
    Button2.Click;
end;

procedure TFinderFrm.oprtComboBoxSelect(Sender: TObject);
begin
  if Visible then
     TEdit(ValGroupBox.Controls[0]).SetFocus;
end;

procedure TFinderFrm.FormActivate(Sender: TObject);
begin
  TEdit(ValGroupBox.Controls[0]).SetFocus;
end;

end.
