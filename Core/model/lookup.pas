unit Lookup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, Grids, DBGrids, Db, StrUtils,ADODB, ExtCtrls,Variants,FhlKnl, UnitCreateComponent,
  DBCtrls,UnitGrid,UPublicFunction;

const fstr='任意,左边,右边';
      fnum='小于,等于,大于';


type
  TLookupFrm = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    DataSource1: TDataSource;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox2: TComboBox;
    CheckBox1: TCheckBox;
    Button1: TButton;
    ADODataSet1: TADODataSet;
    grp1: TGroupBox;
    procedure InitFilterObject;
    procedure InitFrm(Fld:TField=nil);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure OnlyIntPress(Sender: TObject; var Key: Char);
    procedure OnlyFloatPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure dbGrid1DblClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ft:TFieldType;
    fDict:TLookupDict;
  public
    dbgrid1:Tdbgrid;
  end;

var
  LookupFrm: TLookupFrm;

implementation
uses datamodule,editor;
{$R *.DFM}

procedure TLookupFrm.InitFrm(Fld:TField=nil);
var i:integer;
    dbimage:Tdbimage;
    gpbox:Tgroupbox;
    fParams:variant;
begin
   fDict.DefIdx:=0;
   fDict.MyFld:=Fld;
   if fDict.MyFld<>nil then
   begin
       if Not FhlKnl1.Cf_GetDict_Lookup(intTostr(fDict.MyFld.Tag),fdict) then Close;

       fParams:=FhlKnl1.Ds_GetFieldsValue(Fld.DataSet ,fdict.fUserParametersFld );

       if Fld.DataSet.FindField(fDict.LkpFldName)<>nil then
            fDict.LkpFld:=Fld.DataSet.FieldByName(fDict.LkpFldName);
       Caption:='搜寻 '+fDict.Caption;
       if fdict.LkpFld<>nil then
       begin
         DataSource1.DataSet:=fDict.LkpFld.LookupDataSet;
         FhlUser.SetDbGrid(fDict.DbGridId,dbGrid1);
         //定位原有值
         DataSource1.DataSet.First;
         if fDict.LkpFld.AsString<>'' then
            DataSource1.DataSet.Locate(fDict.LkpFld.LookupKeyFields,fDict.LkpFld.DataSet.FieldByName(fDict.LkpFld.KeyFields).AsString,[]);
         //过滤
         if Fld.DisplayText<>'' then
         begin
           DataSource1.DataSet.Filter:=fDict.FilterFldName+' like ''%'+Fld.DisplayText+'%''';
           DataSource1.DataSet.Filtered:=True;
         end;
       end else
         FhlUser.SetDbGridAndDataSet(DbGrid1,fDict.DbGridId,fParams);
   end;

   //建立图片
{   gpbox:=Tgroupbox.Create (grp1);

    for i:=0 to self.DataSource1.DataSet.FieldCount -1 do
    begin
        if  (self.DataSource1.DataSet.Fields [i].DataType  in [ftBlob]	) and (   LowerCase(self.DataSource1.DataSet.Fields [i].FieldName) ='fimage' ) then
         begin
             gpbox.Parent :=   grp1;
             gpbox.Align := alRight;
             gpbox.Width :=grp1.Height ;
             gpbox.Caption :=fDict.Caption+'图片';

             dbimage:=Tdbimage.Create(gpbox);
             dbimage.Parent :=   gpbox;
             dbimage.DataField :='Fimage';
             dbimage.DataSource :=self.DataSource1 ;
             dbimage.Visible :=true;
             dbimage.Align :=  alclient;
             dbimage.Stretch :=true;
             dbimage.Width  :=dbimage.Parent.Height ;
             break;
         end;

    end;
    }
     //初始搜寻对象
     InitFilterObject;
     Combobox1.ItemIndex:=fDict.DefIdx;
     ComboBox1Change(ComboBox1);
     self.dbGrid1.SelectedRows.CurrentRowSelected:=true;


     if   dgMultiselect in dbgrid1.Options then      //2006-7-26加入多先功能
      dbGrid1.hint:='多选时要按住Ctrl 再选择记录。';

      dbgrid1.Options:=  dbgrid1.Options+     [dgRowSelect] ; 
end;

procedure TLookupFrm.InitFilterObject;
 var i:integer;
begin
   for i:=0 to dbgrid1.Columns.Count-1 do
       ComboBox1.Items.Append(dbgrid1.Columns[i].title.caption);
end;

procedure TLookupFrm.Edit1Change(Sender: TObject);
 var val:string;
 var PyVal:string;
 var ftpgrid:TFieldTYPE;
begin
    //StringReplace
    if pos( edit1.text,'=')>0 then
    begin
      showmessage('过滤时不能录入等号');
      exit;
    end;

    if edit1.text='' then
       DataSource1.DataSet.filtered:=false
    else
    begin
         val:=edit1.text;
        // val:=leftstr(val,6) ;
         if (ft=ftString) or (ft=ftMemo) or (ft=ftwideString)then
            case ComboBox2.ItemIndex of      //2010-2-11
                 1:begin
                      PyVal:='   or FPhoneticize like  '''+val+'%''';   val:=' like '''+val+'%''' ;
                      if DataSource1.DataSet.findField ('FPhoneticize')<>nil then
                      val:=val+PyVal;
                   end;
                 2:begin
                      PyVal:='   or FPhoneticize like  ''%'+val+''''; val:=' like ''%'+val+'''' ;
                      if DataSource1.DataSet.findField ('FPhoneticize')<>nil then
                      val:=val+PyVal;
                   end;
                 0:begin
                      PyVal:='   or FPhoneticize like  ''%'+val+'%'''; val:=' like ''%'+val+'%''';
                      if DataSource1.DataSet.findField ('FPhoneticize')<>nil then
                      val:=val+PyVal;
                   end;
            end
         else
         if (ft=ftInteger) or (ft=ftFloat) or (ft=ftAutoInc) then
         BEGIN
             IF NOT Isnumeric (VAL) THEN VAL:='0';
            case ComboBox2.ItemIndex of
                 0:val:='<'+val;
                 1:val:='='+val;
                 2:val:='>'+val;
            end;
         end;
         DataSource1.DataSet.filter:=''+dbgrid1.Columns[combobox1.itemIndex].fieldname+' '+val;
         DataSource1.DataSet.filtered:=true;
    end;
end;

procedure TLookupFrm.ComboBox1Change(Sender: TObject);
begin
 edit1.text:='';
 if dbGrid1.Columns[ComboBox1.ItemIndex].Field<>nil then
   ft:=dbGrid1.Columns[ComboBox1.ItemIndex].Field.DataType
 else
   ft:=dbGrid1.Columns[ComboBox1.ItemIndex+1].Field.DataType;   


 if (ft=ftInteger) or (ft=ftFloat) or (ft=ftAutoInc) or (ft=ftDate) or (ft=ftDateTime) then
     ComboBox2.Items.CommaText:=fnum
 else if (ft=ftString) or (ft=ftMemo)or (ft=ftwideString) then
     ComboBox2.Items.CommaText:=fstr
 else
     ComboBox2.Items.CommaText:='';
 Edit1.Enabled:=Not (ComboBox2.Items.CommaText='');
 ComboBox2.Enabled:=Edit1.Enabled;
 if Edit1.Enabled then begin
    if (ft=ftInteger) or (ft=ftAutoInc) then
       Edit1.OnKeyPress:=OnlyIntPress
    else if ft=ftFloat then
       Edit1.OnKeyPress:=OnlyFloatPress
    else
       Edit1.OnKeyPress:=nil;
    Combobox2.ItemIndex:=0;
    if Active then
    Edit1.SetFocus;
 end;
end;

procedure TLookupFrm.OnlyIntPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9']+['-']) then
      key:=#0;
end;

procedure TLookupFrm.OnlyFloatPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9']+['.']+['-']) then
      key:=#0;
end;

procedure TLookupFrm.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 
  if Key=vk_Down then
     DbGrid1.SetFocus;
end;

procedure TLookupFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult=mrOk then
  begin
    if fDict.MyFld<>nil then
    begin
      if Not CheckBox1.Checked then
         //FhlKnl1.Ds_CopyValues(DataSource1.DataSet,fDict.MyFld.DataSet,fDict.LkpChgFldNames,fDict.ChgFldNames,False,False)
         FhlKnl1.Ds_CopyValues(self.dbGrid1,  DataSource1.DataSet,fDict.MyFld.DataSet,fDict.LkpChgFldNames,fDict.ChgFldNames,true,False) //多选
      else
         FhlKnl1.Ds_AssignNulls(fDict.MyFld.DataSet,fDict.ChgFldNames,False);

      DataSource1.DataSet.Filtered:=False;
    end;
  end else if (fDict.LkpFld<>nil) and (fDict.LkpFld.AsString<>'') then
      FhlKnl1.Ds_AssignValues(fDict.MyFld.DataSet,fDict.MyFld.FieldName,fDict.LkpFld.AsString,False,False);
end;

procedure TLookupFrm.Button1Click(Sender: TObject);
begin
     with TEditorFrm.Create(Application) do begin
          InitFrm('19',null,self.DataSource1.DataSet);
          ShowModal;
          Free;
     end;
     if fDict.LkpFld.LookupDataSet<>nil then
      with fDict.LkpFld do begin
           LookupDataSet.Close;
           LookupDataSet.Open;
           RefreshLookupList;
      end;
end;

procedure TLookupFrm.dbGrid1DblClick(Sender: TObject);
begin
  if DataSource1.DataSet.RecordCount>0 then ModalResult:=mrOk;
end;

procedure TLookupFrm.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
      // modeltpe:=Bill;
    if LoginInfo.Sys  then
    begin
      CrtCom:=TfrmCreateComponent.Create(self);
      CrtCom.FTLookupDict :=  fdict;
      CrtCom.ModelType :=ModelLookup;
      CrtCom.DLGrid :=self.dbGrid1 ;
      CrtCom.mtDataSet1 :=self.ADODataSet1 ;
      CrtCom.DlGridId := fdict.DbGridId ;
    try
      CrtCom.Show;
    finally
    end;
    end;
end;



procedure TLookupFrm.FormCreate(Sender: TObject);
begin
    dbgrid1:=TModelDbGrid.create(self);
    dbgrid1.OnDblClick := dbGrid1DblClick;

    dbgrid1.DataSource :=self.DataSource1;
    dbgrid1.Parent :=self.grp1;
    dbgrid1.Align :=alclient;
    dbgrid1.PopupMenu :=dmfrm.DbGridPopupMenu1;
   
end;

procedure TLookupFrm.FormDestroy(Sender: TObject);
begin
    dbgrid1.Free ;
end;

end.
