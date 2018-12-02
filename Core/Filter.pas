unit Filter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Db, ADODB,DBGrids,StrUtils;

type
  TFilterFrm = class(TForm)
    GroupBox1: TGroupBox;
    ValGroupBox: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox2: TGroupBox;
    oprtComboBox: TComboBox;
    FldComboBox: TComboBox;
    Button1: TButton;
    Button2: TButton;
    fOkBtn: TButton;
    fCancelBtn: TButton;
    ListBox1: TListBox;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Panel1: TPanel;
    RadioGroup3: TRadioGroup;
    Button5: TButton;
    ChkSqlCon: TCheckBox;
    FilterName: TEdit;
    procedure FldComboBoxChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure ListBox1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure SumExpresses;
    procedure RadioGroup2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function  GetFilterStr:wideString;
    procedure InitFrm(ADataSet:TDataSet;AIsLocate:Boolean;Dbgrid:Tdbgrid=nil);
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChkSqlConClick(Sender: TObject);
  private
    sqltext,express,bracket,logic,oprt,cnexpress,cnlogic,vallogic,valcnlogic,valbracket:TStringList;
    fDataSet:TDataSet;
    fDBGrid:TDBGrid;

    LKPFieldValues:Tstringlist; //lkp values
  public

  end;

implementation
           uses datamodule;
{$R *.DFM}

procedure TFilterFrm.InitFrm(ADataSet:TDataSet;AIsLocate:Boolean;Dbgrid:Tdbgrid=nil);
 var i:integer;
begin
  ChkSqlCon.Hint :='保存每次'+self.Caption +' 条件，以备以后重复使用';

  fDataSet:=ADataSet;
  fDBGrid:=  Dbgrid;
  FldComboBox.Items.Clear;

  if Dbgrid=nil then
  begin
      for i:=0 to ADataSet.Fields.Count-1 do
        FldComboBox.Items.Append(ADataSet.Fields[i].DisplayLabel) ;
  end      
  else
      for i:=0 to Dbgrid.Columns.Count-1do
      begin
          if Dbgrid.Columns[i].Visible =true then
          FldComboBox.Items.Append(Dbgrid.Columns[i].Title.Caption  );
      end;    

  if AIsLocate then
  begin
    fOkBtn.Visible:=False;
    fCancelBtn.Visible:=False;
    FormStyle:=fsStayOnTop;
    Caption:='定位';
    Position:=poDesigned;
  end else
    Height:=Height-40;
end;

procedure TFilterFrm.FldComboBoxChange(Sender: TObject);
 var ft:TFieldType;i:Integer;fld:TField;s:string;
begin
 for i:=ValGroupBox.ControlCount-1 downto 0 do
     ValGroupBox.Controls[i].free;

 if fDBGrid=nil then
   fld:=fDataSet.Fields[FldComboBox.ItemIndex]
 else
 begin
    for i:=0 to  fDBGrid.Columns.Count -1  do
    begin
       if  trim( fDBGrid.Columns[i].Title.Caption)  =trim(FldComboBox.Text )    then
       begin
          fld:=fDBGrid.Columns [i].Field  ;//fDataSet.FieldByName ()
          break;
       end;
    end;

 end;
 if fld.FieldKind=fkLookup then begin
       with TComboBox.Create(ValGroupBox) do begin
            Left:=5;
            Width:=190;
            Height:=25;
            Top:=17;
            Parent:=ValGroupBox;
            with fld.LookupDataSet do begin
                 First;
                 while not Eof do begin
                   Items.Append(FieldByName(fld.LookupResultField).asString);
                   LKPFieldValues.Add(FieldByName(fld.LookupKeyFields).asString);
                   Next;
                 end;
            end;
       end;
         with oprtComboBox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         oprt.Clear;
         oprt.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
    end
    else begin
      ft:=fld.DataType;
      if ft=ftString then begin
         //创建值编辑对象
         with TEdit.Create(ValGroupBox) do begin
            Left:=5;
            Width:=190;
            Height:=25;
            Top:=17;
            Parent:=ValGroupBox;
         end;
         //格式化操作符
         with oprtComboBox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         oprt.Clear;
         oprt.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
      end
      else if (ft=ftDate) or (ft=ftDateTime) then begin
         with TDateTimePicker.Create(ValGroupBox) do begin
            Left:=5;
            Width:=190;
            Height:=25;
            Top:=17;
            Parent:=ValGroupBox;
            DateTime:=now;
         end;
         with oprtComboBox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于';
         end;
         oprt.Clear;
         oprt.CommaText:='=,<>,>,<,>=,<=';
      end
      else if ft=ftBoolean then begin
         with TRadioGroup.Create(ValGroupBox) do begin
            Left:=5;
            Width:=190;
            Height:=35;
            Top:=10;
            Parent:=ValGroupBox;
            Columns:=2;
            Caption:='';
            s:=TBooleanField(fld).DisplayValues;
            Items.Append(Copy(s,Pos(';',s)+1,Length(s)));
            Items.Append(Copy(s,0,Pos(';',s)-1));
         end;
         with oprtComboBox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于';
         end;
         oprt.Clear;
         oprt.CommaText:='=,<>';
      end
      else if ft=ftMemo then begin
         with TMemo.Create(ValGroupBox) do begin
            Parent:=ValGroupBox;
            Align:=alClient;
            Lines.Clear;
            ScrollBars:=ssVertical;
         end;
         with oprtComboBox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         oprt.Clear;
         oprt.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
      end
      else if (ft=ftCurrency) or (ft=ftInteger) or (ft=ftFloat)or (ft=ftBcd) then begin
        with TEdit.Create(ValGroupBox) do begin
            Left:=5;
            Width:=190;
            Height:=25;
            Top:=17;
            Parent:=ValGroupBox;
        end;
         with oprtComboBox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于';
         end;
         oprt.Clear;
         oprt.CommaText:='=,<>,>,<,>=,<=';
      end;
    end;
    oprtComboBox.ItemIndex:=0;
    Button1.Enabled :=true;
end;


procedure TFilterFrm.Button1Click(Sender: TObject);
 var fld,opt,val,s:wideString;

 ctrl:TControl;
 ft:TFieldtype;
 var i:integer;

Var ObjectField:Tfield;
begin
    if FldComboBox.Text ='' then
    begin
        showmessage('请先选择条件');
        exit;
    end;

    ctrl:=ValGroupBox.Controls[0];
    if ctrl is TEdit then
       val:=TEdit(ctrl).Text
    else if ctrl is TComboBox then
       val:=TComboBox(ctrl).Items.Strings[TComboBox(ctrl).ItemIndex]
    else if ctrl is TDateTimePicker then
       val:=QuotedStr(FormatDateTime('yyyy"-"mm"-"dd',TDateTimePicker(ctrl).DateTime))
    else if ctrl is TRadioGroup then
       val:=intTostr(TRadioGroup(ctrl).ItemIndex)
    else if ctrl is TMemo then
       val:=TMemo(ctrl).Text;

    if self.fDBGrid =nil then
       ObjectField:=fDataSet.Fields[FldComboBox.ItemIndex]
    else
    begin
        for i:=0 to  fDBGrid.Columns.Count -1 do
        begin
             if trim(fDBGrid.Columns[i].Title.Caption )= trim(FldComboBox.Text ) then
             begin
                  ObjectField:=fDBGrid.Columns[i].Field     ;
                  break;
             end;
        end;
    end;
    fld:= ObjectField.FieldName ;
    ft := ObjectField.DataType ;

    opt:=oprt.Strings[oprtComboBox.ItemIndex];

    if  ObjectField.FieldKind=fkLookup then             //LKP 要做转化
    begin
         fld:= ObjectField.KeyFields ;
         if TComboBox(ctrl).ItemIndex>-1 then
             val:=self.LKPFieldValues [TComboBox(ctrl).ItemIndex]
         else
             val:='';
    end;
    
    if  ObjectField.FieldKind=fkCalculated then             //LKP 要做转化
    begin
         fld:= ObjectField.FieldName   ;
         fld:=leftstr( fld,length(fld)-3);
    end;


    if (ft=ftString) or (ft=ftMemo) then
    begin//字符及文本型
       if opt='like' then
          s:=' like ''%'+val+'%'''
       else if opt='not like' then
          s:=' not like ''%'+val+'%'''
       else if opt='like x%' then
          s:=' like '''+val+'%'''
       else if opt='not like x%' then
          s:=' not like '''+val+'%'''
       else if opt='like %x' then
          s:=' like ''%'+val+''''
       else if opt='not like %x' then
          s:=' not like ''%'+val+''''
       else
          s:=' '+opt+' '''+val+'''';
    end
    else
      s:=' '+opt+' '+val;

    if ((ft=ftString) or (ft=ftMemo))and ( (val='') and (opt='=') ) then
         express.Append(fld+s+'  or '+fld+'=null')
    else if   (ft=ftboolean ) and ( (val='0' ) and (opt='=' ) ) then
         express.Append(fld+s+'  or '+fld+'=null')
    else
         express.Append(fld+s);


    if ctrl is TRadioGroup then
       val:=TRadioGroup(ctrl).Items.Strings[TRadioGroup(ctrl).ItemIndex];
    s:=FldComboBox.Items.Strings[FldComboBox.ItemIndex]+OprtComboBox.Items.Strings[OprtComboBox.ItemIndex];
    Val:='"'+Val+'"';
    if pos('...',s)<>0 then
       s:=Copy(s,0,pos('...',s)-1)+Val+Copy(s,pos('...',s)+3,Length(s))
    else
       s:=s+Val;
    cnexpress.Append(s);
    bracket.Append('');
    logic.Append('');
    cnlogic.Append('');
    SumExpresses;
    Button1.Enabled :=false;
end;

procedure TFilterFrm.Button2Click(Sender: TObject);
begin
 if ListBox1.ItemIndex>-1 then begin
    express.Delete(ListBox1.ItemIndex);
    cnexpress.Delete(ListBox1.ItemIndex);
    bracket.Delete(ListBox1.ItemIndex);
    logic.Delete(ListBox1.ItemIndex);
    cnlogic.Delete(ListBox1.ItemIndex);
    listbox1.items.Delete(ListBox1.ItemIndex);
    Panel1.Caption:='';
    SumExpresses;

    Button1.Enabled :=true;
 end;
 if ListBox1.Items.Count>0 then
    ListBox1.ItemIndex:=0;

 
end;

procedure TFilterFrm.FormCreate(Sender: TObject);
begin
 sqltext:=TStringList.Create;
 express:=TStringList.Create;
 cnexpress:=TStringList.Create;
 bracket:=TStringList.Create;
 logic:=TStringList.Create;
 cnlogic:=TStringList.Create;
 oprt:=TStringList.Create;
 vallogic:=TStringList.Create;
 vallogic.CommaText:='" and"," or",""';
 valbracket:=TStringList.Create;
 valbracket.CommaText:='"(",")",""';
 valcnlogic:=TStringList.Create;
 valcnlogic.CommaText:='" 并且"," 或者",""';

 LKPFieldValues:=Tstringlist.Create ;
end;

procedure TFilterFrm.ListBox1Click(Sender: TObject);
begin

if logininfo.sys then
begin
     Panel1.Caption:=sqltext.Strings[ListBox1.ItemIndex];
     RadioGroup1.ItemIndex:=valbracket.IndexOf(bracket.Strings[ListBox1.ItemIndex]);
     RadioGroup2.ItemIndex:=vallogic.IndexOf(logic.Strings[ListBox1.ItemIndex]);
end;
end;

procedure TFilterFrm.RadioGroup1Click(Sender: TObject);
 var s:string;i:integer;
begin
 if ListBox1.ItemIndex>-1 then begin
    s:=valbracket.Strings[RadioGroup1.ItemIndex];
    if bracket.Strings[ListBox1.ItemIndex]<>s then begin
       i:=ListBox1.itemindex;
       bracket.Strings[ListBox1.ItemIndex]:=s;
       SumExpresses;
       ListBox1.itemindex:=i;
    end;
 end;
end;

procedure TFilterFrm.RadioGroup2Click(Sender: TObject);
 var s:string;i:integer;
begin
 if (ListBox1.ItemIndex>-1 ) and (ListBox1.ItemIndex<> ListBox1.Count -1) then begin
    s:=vallogic.Strings[RadioGroup2.ItemIndex];
    if logic.Strings[ListBox1.ItemIndex]<>s then begin
       i:=ListBox1.itemindex;
       logic.Strings[ListBox1.ItemIndex]:=s;
       cnlogic.Strings[ListBox1.ItemIndex]:=valcnlogic.Strings[RadioGroup2.ItemIndex];
       SumExpresses;
       ListBox1.itemindex:=i;
    end;
 end;
end;

procedure TFilterFrm.SumExpresses;
 var i:integer;s,cns:String;
begin
  sqltext.Clear;
  listbox1.Items.Clear;
  for i:=0 to express.Count-1 do begin
      s:=express.Strings[i];
      cns:=cnexpress.Strings[i];
      if bracket.Strings[i]='(' then begin
         s:='('+s+logic.Strings[i];
         cns:='('+cns+cnlogic.Strings[i];
      end
      else if bracket.Strings[i]=')' then begin
         s:=s+')'+logic.Strings[i];
         cns:=cns+')'+cnlogic.Strings[i];
      end
      else begin
         s:=s+logic.Strings[i];
         cns:=cns+cnlogic.Strings[i];
      end;
      sqltext.Append(s);
      listbox1.Items.Append(cns);
  end;
end;

function  TFilterFrm.GetFilterStr:WideString;
 var i:integer;
begin
  Result:='';
  for i:=0 to ListBox1.Items.Count-1 do
    Result:=trim(Result)+' '+trim(sqltext.Strings[i]);
end;

procedure TFilterFrm.FormDestroy(Sender: TObject);
begin
 sqltext.Free;
 express.Free;
 cnexpress.Free;
 bracket.Free;
 logic.Free;
 cnlogic.Free;
 oprt.Free;
end;

procedure TFilterFrm.Button5Click(Sender: TObject);
begin
  Close;
end;

procedure TFilterFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if self.ModalResult=mrok then
        if   (ChkSqlCon.Checked ) and (FilterName.Text ='') then
        begin
           showmessage('请填写过滤条件名!')    ;
           abort;
        end;
  Action:=caFree;
  LKPFieldValues.Free;
end;

procedure TFilterFrm.ChkSqlConClick(Sender: TObject);
begin
if chksqlcon.Checked then
   FilterName.Visible :=true
else
   FilterName.Visible :=false;

end;

end.







