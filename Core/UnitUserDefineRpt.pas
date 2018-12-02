unit UnitUserDefineRpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Menus, ToolWin,
  DB, ADODB;

type
  TFrmUserDefineReport = class(TForm)
    PnlRight: TPanel;
    GrpTop: TGroupBox;
    dbgrd1: TDBGrid;
    grpBtm: TGroupBox;
    PageControl1: TPageControl;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    TabSheet2: TTabSheet;
    LstUserFields: TListBox;
    lstSysFields: TListBox;
    TabSheet3: TTabSheet;
    GrpCtrlType: TRadioGroup;
    BtnCreateCtrl: TButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    FontDialog1: TFontDialog;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    Label1: TLabel;
    edMoveSpan: TEdit;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    imgtop: TImage;
    imgbtm: TImage;
    Label2: TLabel;
    edttitle: TEdit;
    TlbtnExpand: TToolButton;
    Tlbtnsuoxiao: TToolButton;
    tblSpantoSmall: TToolButton;
    tlbtnSpanTobig: TToolButton;
    edtPrintID: TEdit;
    btnUseOldModule: TButton;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    j1: TMenuItem;
    
    procedure CreateCtrl(grp:TGroupbox; Source: TObject; X,
  Y: Integer);

    procedure LstUserFieldsMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lstSysFieldsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure grpBtmDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure grpBtmDragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure SavePorpertyToDataBase( source: Tcomponent;BOXID:string);
    procedure LoadConfig( parent: TComponent;BOXID:string);
    procedure IniUserFields(mtDataSetId:string);
    procedure IniSysFileds();
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);


        procedure MouseDown(Sender: TObject;    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseUp(Sender: TObject;    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DblClick_Ex(Sender: TObject);
    procedure DblClick_LblEx(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgtopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgtopMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgtopMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure imgtopDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure imgtopDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TlbtnExpandClick(Sender: TObject);
    procedure TlbtnsuoxiaoClick(Sender: TObject);
    procedure tblSpantoSmallClick(Sender: TObject);
    procedure tlbtnSpanTobigClick(Sender: TObject);
    procedure btnUseOldModuleClick(Sender: TObject);
  private
    { Private declarations }
       FtopBoxID,FBtmBoxID:string;
       FMtdatasetID,fGridId:string;

       FCollector:Tstrings;
       oldx,oldy,newx,newy:integer;
       fstpt:Tpoint;
       drawing:boolean;


           FPrintId:string;
    FContentDataSet:TDataSet;
    FDataSetID :string;

 
    FGird:Tdbgrid;

  public
    { Public declarations }
    PPrintID:string;
      Procedure IniDefinePrt(fMasterDataSet:TDataSet;DatasetID, topboxid,
  Btmboxid: string;Midgird:Tdbgrid=nil );

  function GetMaxPrintModuleID:integer;
  end;

var
  FrmUserDefineReport1: TFrmUserDefineReport;

implementation
   uses datamodule,UPublicCtrl,FhlKnl,UnitUpdateProerty;
{$R *.DFM}
 
{ TFrmUserDefineReport }

procedure TFrmUserDefineReport.IniDefinePrt(fMasterDataSet:TDataSet;DatasetID, topboxid,
  Btmboxid: string;Midgird:Tdbgrid=nil );
  var i:integer;
  col:TColumn;
begin

    FContentDataSet:=fMasterDataSet;
    FDataSetID :=DatasetID;
    FTopBoxID:=topboxid;
    FBtmBoxID:=Btmboxid;
    FGird:=Midgird;


       FMtdatasetID:=DatasetID;


       iniUserFields(DatasetID);
      IniSysFileds();

      if Midgird<>nil then
      begin
      fGridId:=inttostr(Midgird.tag);
      for i:=0 to  Midgird.Columns.Count -1 do
      begin
        col:=self.dbgrd1.Columns.Add;
        col.Title :=  Midgird.Columns[i].Title ;  //self.dbgrd1.Columns.Assign( Midgird.Columns[i]) ;
         col.Visible :=  Midgird.Columns[i].Visible  ;
      end;
      end;

end;
procedure  TFrmUserDefineReport.IniSysFileds();
begin
      self.lstSysFields.Items.Add(logininfo.FirmCnName+'=公司中文名');
      self.lstSysFields.Items.Add(logininfo.FirmEnName+'=公司英文名');
      self.lstSysFields.Items.Add(logininfo.Tel+'=公司电话');
      self.lstSysFields.Items.Add(logininfo.Fax+'=公司传真');
      self.lstSysFields.Items.Add(logininfo.Address +'=公司地址');
end;
procedure TFrmUserDefineReport.IniUserFields(mtDataSetId:string);

var sql:string;
qry:Tadoquery;
values,valLst:string;
i:integer;
begin

            sql:='select fieldID,datasetId,name,label from V201_getCtrlField where datasetId='+mtDataSetId       +' order by F200';

            qry:=Tadoquery.Create (nil);
        try
            qry.Connection :=FhlKnl1.Connection;
            qry.SQL.Clear ;
            qry.SQL.Add(sql);
            qry.open ;

            LstUserFields.Clear;

        {
            if not qry.IsEmpty then
            begin
                  while not qry.Eof do
                  begin
                        values:= qry.FieldByName('name').AsString +'=' + qry.FieldByName('label').AsString ;
                        LstUserFields.items.Add(values) ;
                        qry.Next;
                  end;
            end
            else  }
            begin

                  for i:=0 to     self.FGird.Columns.Count -1 do
                  begin
                       values:= FGird.Columns[i].FieldName   +'=' + FGird.Columns[i].Title.Caption  ;
                    LstUserFields.items.Add(values) ;
                  end;


                //  showmessage('还没有建立字段!');

            end;
        finally
          qry.Free;
        end;





        

end;
procedure TFrmUserDefineReport.LstUserFieldsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if shift= [ssLeft] then
LstUserFields.BeginDrag(true);
end;

procedure TFrmUserDefineReport.CreateCtrl(grp:TGroupbox; Source: TObject; X,
  Y: Integer);

    var lbl:Tlabel;
  var CTRL:Tedit_Mtn;
  var FieldType:integer;
  var FieldKind :string;
  var picklist:string;
name:string;
begin
      if    (Source is   tlistbox )  then
      begin
                name:=Tlistbox (Source).Items.Names   [Tlistbox (Source).ItemIndex];

                lbl:=Tlabel_Mtn.Create(grp);
                lbl.Parent :=grp;
                lbl.Left :=x;
                lbl.Top :=y+10;
                lbl.Caption :=Tlistbox (Source).Items.Values[name];////self.qryT102.FieldValues ['f09'];
                lbl.Visible :=true;
                lbl.Hint :=  lbl.Caption         ;
                lbl.Font.Name :='宋体';
                lbl.Font.Size:=10;
                lbl.OnMouseDown:=MouseDown;
                lbl.OnDblClick :=DblClick_Ex;
                lbl.OnMouseUp  :=       MouseUp;
                Tlabel_Mtn(lbl).OnMouseDown:=MouseDown;
                Tlabel_Mtn(lbl).OnDblClick :=DblClick_LblEx  ;
                Tlabel_Mtn(lbl).OnMouseUp  :=       MouseUp;
                Tlabel_Mtn(lbl).SetCollector ( FCollector);
               // lbl.seSetCollector ( FCollector);


                CTRL:=Tedit_Mtn.Create (grp);
                CTRL.Parent :=grp;
                CTRL.Left :=x+lbl.Width +6;
                CTRL.Top :=lbl.Top-3;
                CTRL.ShowHint :=true;
                CTRL.Hint := name;

                CTRL.Text := name ;
                CTRL.Visible :=true;
                CTRL.ReadOnly :=true;
                CTRL.OnMouseDown:=MouseDown;
                CTRL.OnDblClick :=DblClick_Ex;
                CTRL.OnMouseUp  :=       MouseUp;
                CTRL.FCollector := FCollector;
                CTRL.OnMouseDown:=MouseDown;
                CTRL.OnDblClick :=DblClick_Ex;
                CTRL.OnMouseUp  :=       MouseUp;
                CTRL.fCollector:= FCollector;
                
            if   (Source as tlistbox ).Name = 'LstUserFields' then
            CTRL.Tag :=0
            else
            CTRL.Tag :=1;
      end;
end;
procedure TFrmUserDefineReport.lstSysFieldsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if shift= [ssLeft] then
lstSysFields.BeginDrag(true);
end;

procedure TFrmUserDefineReport.grpBtmDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
if  Source is tlistbox then
Accept:=true;
end;

procedure TFrmUserDefineReport.grpBtmDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
      if    (Source is   tlistbox )  then
      begin
           CreateCtrl(grpBtm,Source,x,y) ;
      end;
end;




procedure TFrmUserDefineReport.SavePorpertyToDataBase( source: TComponent;BOXID:string);
var qry:Tadoquery;
var sql,fontname:string;
var sender:  Tcontrol;
var fontsize :integer;
begin

       sender:=Tcontrol(   source);

      qry:=Tadoquery.Create (nil);
      qry.Connection :=FhlKnl1.Connection  ;
//      sql:='select * from T629  where f11='+BOXID+' and f09='+quotedstr(sender.Hint );

     if BOXID<>''   then
         sql:='select * from T506  where f20='+BOXID+' and f04='+quotedstr(sender.Hint )
      else
        sql:='select top 0 * from T506  ';

      qry.SQL.Clear ;
      qry.SQL.Add(sql);
      qry.Open ;

      if not qry.IsEmpty then
          qry.Edit
      else
      begin
          qry.Append;

      end;


{
Id	ftAutoInc	F01
BoxId	ftInteger	F02
Align	ftString	F03
Left	ftInteger	F12
Top	ftInteger	F13
Width	ftInteger	F14
Height	ftInteger	F15

}
     qry.FieldByName('f20').Value:=  BOXID ;
      qry.FieldByName('f21').Value:=edttitle.Text;
      qry.FieldByName('f02').Value:=  BOXID ;
     {Caption	ftString	F04
Color	ftString	F05
FntClr	ftString	F06
FntSiz	ftInteger	F07
FntNam	ftString	F08
      }
     if (sender is TLabel)then
     begin
       qry.FieldByName('f04').Value:= TLabel( sender).Caption  ;
       qry.FieldByName('f05').Value:=  TLabel( sender).Color ;
       qry.FieldByName('f06').Value:= colortostring(TLabel( sender).Font.Color );
       qry.FieldByName('f07').Value:= TLabel( sender).Font.Size;
       qry.FieldByName('f08').Value:=TLabel( sender).Font.Name ;

       IF     fsBold   IN       TLabel( sender).Font.Style   THEN          qry.FieldByName('f09').Value:=1;

       IF  fsItalic IN        TLabel( sender).Font.Style THEN         qry.FieldByName('f10').Value:=1  ;
       IF  fsUnderline IN        TLabel( sender).Font.Style THEN         qry.FieldByName('f11').Value:=1  ;

       qry.FieldByName('f17').Value:= 0;                      // F10 AS ctrl type
     end      ;

     if (sender is Tedit)then
     begin

       qry.FieldByName('f04').Value:=  TEDIT( sender).Text ;
       qry.FieldByName('f05').Value:=  TEDIT( sender).Color ;
       qry.FieldByName('f06').Value:= TEDIT( sender).Font.Color  ;
       qry.FieldByName('f07').Value:= TEDIT( sender).Font.Size;
       qry.FieldByName('f08').Value:=TEDIT( sender).Font.Name ;

       IF  fsBold  IN        TLabel( sender).Font.Style THEN          qry.FieldByName('f09').Value:=1;
       IF  fsItalic IN        TLabel( sender).Font.Style THEN         qry.FieldByName('f10').Value:=1 ;
       IF  fsUnderline IN        TLabel( sender).Font.Style THEN         qry.FieldByName('f11').Value:=1;

       qry.FieldByName('f17').Value:= 1;
     end  ;


     qry.FieldByName('f12').Value:= sender.Left;
     qry.FieldByName('f13').Value:= sender.top  ;
     qry.FieldByName('f14').Value:= sender.Width  ;
     qry.FieldByName('f15').Value:= sender.Height ;
     qry.FieldByName('f16').Value:= sender.Tag ;

     qry.FieldByName('f18').Value:= 1 ;
      qry.FieldByName('f22').Value:= self.PPrintID  ;
   //  qry.FieldByName('f19').Value:= sender.Tag ;


 {    IsRep	ftBoolean	F18
FldId	ftInteger	F16
TypeId	ftInteger	F17
IsRep	ftBoolean	F18
Shape	ftInteger	F19
  }


try
    qry.Post;
    qry.Free ;
except
    on err:exception do
    begin
    showmessage(err.Message );
    qry.Free ;
    end;
end;

end;
procedure TFrmUserDefineReport.LoadConfig( parent: TComponent;BOXID:string);
var qry:Tadoquery;
var sql,fontname:string;
var sender:  Tcontrol;
var fontsize :integer;

var loadCtrl:TControl;
var i:integer;
begin



      qry:=Tadoquery.Create (nil);
      qry.Connection :=FhlKnl1.Connection  ;
     // sql:='select * from T629  where f11='+BOXID ;
        sql:='select * from T506  where f20='+BOXID;
      qry.SQL.Clear ;
      qry.SQL.Add(sql);
      qry.Open ;
      edttitle.Text :=qry.FieldByName('f21').AsString ;
      if  (not qry.IsEmpty ) then
      for i:=0 to qry.RecordCount -1 do
       begin

          if  (qry.FieldByName('f17').Value='0') then
          begin
                loadCtrl:=Tlabel_Mtn.Create(parent);
                
                loadCtrl.Parent  :=TWincontrol(parent);

                Tlabel_Mtn(loadCtrl).Font.Name := qry.FieldByName('f08').Value;
                Tlabel_Mtn(loadCtrl).Font.Size := qry.FieldByName('f07').Value ;
                Tlabel_Mtn(loadCtrl).Font.Color :=stringtocolor( qry.FieldByName('f06').Value);
                Tlabel_Mtn(loadCtrl).Caption := qry.FieldByName('f04').AsString ;
                Tlabel_Mtn(loadCtrl).Color :=stringtocolor(qry.FieldByName('f05').AsString);

                Tlabel_Mtn(loadCtrl).BoxId:=BoxId;                       //记录boxid，删除控键时用到  2006-5-8
                Tlabel_Mtn(loadCtrl).OnMouseDown:=MouseDown;
                Tlabel_Mtn(loadCtrl).OnDblClick :=DblClick_LblEx;
                Tlabel_Mtn(loadCtrl).OnMouseUp  :=       MouseUp;
                Tlabel_Mtn(loadCtrl).SetCollector ( FCollector);

          end;
          if    (qry.FieldByName('f17').Value='1') then
          begin
              loadCtrl:=Tedit_Mtn.Create (parent);
              loadCtrl.Parent := Twincontrol(   parent);
              Tedit_Mtn(loadCtrl).Font.Name := qry.FieldByName('f08').Value;
              Tedit_Mtn(loadCtrl).Font.Size := qry.FieldByName('f07').Value;
              Tedit_Mtn(loadCtrl).Font.Color := stringtocolor(qry.FieldByName('f06').Value);
              Tedit_Mtn(loadCtrl).Text  := qry.FieldByName('f04').AsString ;
              Tedit_Mtn(loadCtrl).BoxId:=BoxId;                       //记录boxid，删除控键时用到  2006-5-8
              Tedit_Mtn(loadCtrl).OnMouseDown:=MouseDown;
              Tedit_Mtn(loadCtrl).OnDblClick :=DblClick_Ex;
              Tedit_Mtn(loadCtrl).OnMouseUp  :=       MouseUp;
              Tedit_Mtn(loadCtrl).FCollector := FCollector;
              Tedit_Mtn(loadCtrl).ReadOnly :=true;
          end  ;


            loadCtrl.Left :=qry.FieldByName('f12').Value;
            loadCtrl.Top := qry.FieldByName('f13').Value ;
             loadCtrl.Width :=qry.FieldByName('f14').Value;
            loadCtrl.Height :=qry.FieldByName('f15').Value;
            

            loadCtrl.Hint :=qry.FieldByName('f04').Value ;
            loadCtrl.tag:=  qry.FieldByName('f17').Value ;
            qry.Next ;
         end;



end;
procedure TFrmUserDefineReport.ToolButton1Click(Sender: TObject);
var i:integer;
var clr:Tcolor;
begin
try
    if  edttitle.Text ='' then
    begin
    showmessage('请先填标题');
    exit;
    end;

      for i:=0 to GrpTop.ComponentCount -1 do
      begin
          if (GrpTop.Components[i]is tlabel ) then
           clr:=(GrpTop.Components[i]as tlabel ).Color ;

          if (GrpTop.Components[i]is tedit ) then
             clr:=(GrpTop.Components[i]as tedit ).Color ;

              if clr <>stringtocolor('0') then
              if  FtopBoxID='' then
              FtopBoxID:=inttostr(GetMaxPrintModuleID);
                SavePorpertyToDataBase( GrpTop.Components[i],self.FtopBoxID );
      end;
      showmessage('保存成功' );
except on E:Exception do
  showmessage(E.Message );
end;
end;

procedure TFrmUserDefineReport.ToolButton2Click(Sender: TObject);
var i:integer;
begin
for i:=0 to self.GrpTop.ComponentCount -1 do
begin
      GrpTop.Components[0].Free ;
end;
for i:=0 to self.grpBtm.ComponentCount -1 do
begin
    grpBtm.Components[0].Free ;
end;

if trim(FtopBoxID) <>'' then
LoadConfig(GrpTop,self.FtopBoxID );

end;
procedure TFrmUserDefineReport.DblClick_Ex(Sender: TObject);


var actlst:Tstringlist;
var FontDialog1:TFontDialog;
begin



 if Sender is tedit then
 begin
 {
    actlst:=Tstringlist.Create ;
    actlst.CommaText :=Tedit(sender).Hint ;
    FrmUpdateProperty.cmbclick.ItemIndex :=  strtoint(actlst[1]);
    FrmUpdateProperty.Editclick.Text  :=actlst[1];
    FrmUpdateProperty.cmbdbclick.ItemIndex :=  strtoint(actlst[2]);
    FrmUpdateProperty.Editdbclick.Text :=actlst[2];
    FrmUpdateProperty.cmbexit.ItemIndex :=  strtoint(actlst[3]);
    FrmUpdateProperty.Editexit.Text :=actlst[3];
       }
      FontDialog1:=TFontDialog.Create (self);
      if    FontDialog1.Execute then
               ( Sender as tedit).Font.Assign (FontDialog1.Font );

 end;


end;

procedure TFrmUserDefineReport.MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var sql:string;
  var txt,boxid:string;
begin


    if ( Sender is Tlabel_Mtn) and (  Button=mbleft ) then
    begin

         ( Sender as tlabel).Font.Style := ( Sender as tlabel).Font.Style   +[fsBold];
         ( Sender as tlabel).Cursor  :=crsizeall;
           if    (Shift =[ ssshift ,ssleft	]	)  then
                Tlabel_Mtn(Sender).FCollector.AddObject(Tlabel_Mtn(Sender).Caption,Tlabel_Mtn(Sender));
    end;

    if ( Sender is Tedit_Mtn) and (  Button=mbleft ) then
    begin
       // ( Sender as Tedit_Mtn).Ctl3D :=true;
        ( Sender as Tedit_Mtn).Cursor  :=crsizeall;
        ( Sender as Tedit_Mtn).Font.Style  :=( Sender as Tedit_Mtn).Font.Style+[fsBold];

                   if    (Shift =[ ssshift ,ssleft	]	)  then
                Tedit_Mtn(Sender).FCollector.AddObject( Tedit_Mtn(Sender).Text  ,Tedit_Mtn(Sender));
    end;


if      (Shift =[ ssCtrl ,ssLeft	]	)  then
begin
    Twincontrol(Sender).TabOrder  :=Tcontrol(Sender).Parent.Tag ;
     Tcontrol(Sender).Parent.Tag  :=   Tcontrol(Sender).Parent.Tag +1;
end;

if     Button=mbRight then
begin

     if MessageBox(0, '删除该控键吗?', '', MB_YESNO + MB_ICONQUESTION) = IDYES
       then
     begin
         if       Sender is tlabel then
         begin
               txt:=  tlabel(   Sender).Caption ;
               boxid:=   tlabel_Mtn(   Sender).BoxId ;
         end;
         if       Sender is tedit then
         begin
               txt:=  tedit(  Sender).Text  ;
               boxid:=   tedit_Mtn(   Sender).BoxId ;
         end;

         if boxid<>''  then
         begin
           sql:='delete '+FHLKNL1.Connection.DefaultDatabase +'.DBO.t506 where f02='+quotedstr(boxid)+' and f04='+quotedstr(txt);
             if (Sender is tlabel) then
             (Sender as tlabel).Color :=stringtocolor('0');
             if (Sender is tedit) then
             (Sender as tedit).Color :=stringtocolor('0');


             fhlknl1.Kl_GetUserQuery(sql,false);
         end
         else
         showmessage('无法删除');
            //(Sender

         
     end; { }
end;
end;


procedure TFrmUserDefineReport.MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var i:integer;
begin
if FCollector=nil then exit       ; 


    if ( Sender is tlabel) then
    begin

         if    (Shift <>[ ssshift 	]	)  then
         begin
                 (  Sender as tlabel_mtn).Cursor  :=crdefault;
                 (  Sender as tlabel_mtn).Font.Style :=  (  Sender as tlabel_mtn).Font.Style  -[fsBold];

              for i:=0 to   ( Sender as tlabel_mtn).FCollector.Count -1 do
              begin
                  if ( Sender as tlabel_mtn).FCollector.Objects [i] is tlabel_mtn then
                  begin
                    tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Cursor   :=crdefault;
                    tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Font.Style := tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Font.Style  -[fsBold];
                  end;
              end;
              ( Sender as tlabel_mtn).FCollector.Clear ;
         end;

    end;

    if ( Sender is Tedit_Mtn) then
    begin
         if    (Shift <>[ ssshift 	]	)  then
         begin
              ( Sender as Tedit_Mtn).Ctl3D :=false;
              ( Sender as Tedit_Mtn).Cursor  :=crdefault;
              ( Sender as Tedit_Mtn).Font.Style  :=( Sender as Tedit_Mtn).Font.Style-[fsBold];

                 for i:=0 to   ( Sender as Tedit_Mtn).FCollector.Count -1 do
                begin
                    if ( Sender as Tedit_Mtn).FCollector.Objects [i] is Tedit_Mtn then
                    begin
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Cursor   :=crdefault;
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Font.Style := Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Font.Style  -[fsBold];
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Ctl3D := false;
                    end;
                end;
                ( Sender as Tedit_Mtn).FCollector.Clear ;
         end;       
    end;

end;

procedure TFrmUserDefineReport.FormCreate(Sender: TObject);
begin
self.FCollector :=Tstringlist.Create ;
 //imgtop.Canvas.FillRect(imgtop.BoundsRect);
    oldx:=0;
    oldy:=0; 
    newx:=0; 
    newy:=0; 
end;

procedure TFrmUserDefineReport.ToolButton3Click(Sender: TObject);
var i:integer;
begin
        if self.FCollector.Count>0 then
        if self.FontDialog1.Execute then
        for i:=0 to self.FCollector.Count -1 do
        begin
             if (FCollector.Objects [i] is tlabel) then
             begin
                 (FCollector.Objects [i]  as Tlabel).Font.Assign(FontDialog1.Font  );
             end;
     
             if (FCollector.Objects [i] is tedit) then
             begin
                 (FCollector.Objects [i]  as tedit).Font.Assign(FontDialog1.Font  );
             end;
        end;


end;

procedure TFrmUserDefineReport.ToolButton4Click(Sender: TObject);
 
var i:integer;
var firstLeft:integer;
begin
    if     self.FCollector.Count>1 then
    begin

          firstLeft :=tcontrol( self.FCollector.Objects [0]).Left ;
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol(self.FCollector.Objects [i]).Left :=  firstLeft;
          end;
    end;
end;


procedure TFrmUserDefineReport.ToolButton5Click(Sender: TObject);
var i:integer;
var firstleft,firstwidth:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          firstleft := tcontrol( self.FCollector.Objects [0]).Left;
          firstwidth:= tcontrol( self.FCollector.Objects [0]).width;

          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Left :=  firstleft+(firstwidth- tcontrol( self.FCollector.Objects [i]).width);
          end;
    end;
end;
procedure TFrmUserDefineReport.ToolButton6Click(Sender: TObject);
var i:integer;
var firstTop:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          firstTop :=tcontrol( self.FCollector.Objects [0]).Top ;
          for i:=0 to self.FCollector.Count -1 do
          begin
             if (FCollector.Objects [i] is Tlabel) then
                tcontrol( self.FCollector.Objects [i]).Top  :=  firstTop +2
             else
                tcontrol( self.FCollector.Objects [i]).Top  :=  firstTop;

          end;
    end;
end;

procedure TFrmUserDefineReport.ToolButton7Click(Sender: TObject);
var i:integer;
var MinTop,MaxTop,SumHeight,Vspan:integer;
//var MinControl:TControl;
begin
    if     self.FCollector.Count>1 then
    begin
          MinTop:=tcontrol( self.FCollector.Objects [0]).Top ;
          MaxTop:=tcontrol( self.FCollector.Objects [0]).Top ;
          SumHeight:=0;
          for i:=0 to self.FCollector.Count -1 do
          begin
             if  MinTop> tcontrol( self.FCollector.Objects [i]).Top then
             begin
                 MinTop:=tcontrol( self.FCollector.Objects [i]).Top ;
             end;
             if  MaxTop< tcontrol( self.FCollector.Objects [i]).Top then
                 MaxTop:=tcontrol( self.FCollector.Objects [i]).Top ;
             if    i<>self.FCollector.Count-1 then
             SumHeight:=   SumHeight+tcontrol( self.FCollector.Objects [i]).Height ;

          end;
          Vspan:=( (MaxTop -MinTop)-SumHeight) div (self.FCollector.Count-1);



          for i:=0 to self.FCollector.Count -1 do
          begin
               if i=0 then
                  tcontrol( self.FCollector.Objects [i]).Top:=  MinTop
               else
                  tcontrol( self.FCollector.Objects [i]).Top:= Vspan+  tcontrol( self.FCollector.Objects [i-1]).top +tcontrol( self.FCollector.Objects [i-1]).height ;
          end;
    end;
end;

procedure TFrmUserDefineReport.ToolButton8Click(Sender: TObject);
var i:integer;
var Minleft,Maxleft,SumWidth,Vspan:integer;
//var MinControl:TControl;
begin
    if     self.FCollector.Count>1 then
    begin
          Minleft:=tcontrol( self.FCollector.Objects [0]).left ;
          Maxleft:=tcontrol( self.FCollector.Objects [0]).left ;
          SumWidth:=0;

          for i:=0 to self.FCollector.Count -1 do
          begin
             if  Minleft> tcontrol( self.FCollector.Objects [i]).left then
             begin
                 Minleft:=tcontrol( self.FCollector.Objects [i]).left ;
             end;
             if  Maxleft< tcontrol( self.FCollector.Objects [i]).left then
                 Maxleft:=tcontrol( self.FCollector.Objects [i]).left ;
             if    i<>self.FCollector.Count-1 then
             SumWidth:=   SumWidth+tcontrol( self.FCollector.Objects [i]).width ;

          end;
          Vspan:=( (MaxLeft -MinLeft)-SumWidth) div (self.FCollector.Count-1);



          for i:=0 to self.FCollector.Count -1 do
          begin
               if i=0 then
                  tcontrol( self.FCollector.Objects [i]).left:=  Minleft
               else
                  tcontrol( self.FCollector.Objects [i]).left:= Vspan+  tcontrol( self.FCollector.Objects [i-1]).left +tcontrol( self.FCollector.Objects [i-1]).width ;
          end;
    end;
end;

procedure TFrmUserDefineReport.ToolButton9Click(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Left :=   tcontrol(self.FCollector.Objects [i]).Left -strtoint(edMoveSpan.Text );
          end;
    end
    else
    begin
        for i:=0 to  GrpTop.ControlCount  -1 do
        begin
            (GrpTop.Controls[i] as Tcontrol).Left:=(GrpTop.Controls[i] as Tcontrol).Left-5;

        end;
    end;
end;

procedure TFrmUserDefineReport.ToolButton11Click(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).left :=   tcontrol( self.FCollector.Objects [i]).left +strtoint(edMoveSpan.Text );
          end;
    end
    else
    begin
        for i:=0 to  GrpTop.ControlCount  -1 do
        begin
            (GrpTop.Controls[i] as Tcontrol).Left :=(GrpTop.Controls[i] as Tcontrol).Left+5;
        end;
    end;
end;

procedure TFrmUserDefineReport.ToolButton10Click(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Top  :=   tcontrol( self.FCollector.Objects [i]).Top  -strtoint(edMoveSpan.Text );
          end;
    end
    else
    begin
        for i:=0 to  GrpTop.ControlCount  -1 do
        begin
            (GrpTop.Controls[i] as Tcontrol).Top  :=(GrpTop.Controls[i] as Tcontrol).Top -5;
        end;
    end;
end;
procedure TFrmUserDefineReport.ToolButton12Click(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Top  :=   tcontrol( self.FCollector.Objects [i]).Top  +strtoint(edMoveSpan.Text );
          end;
    end
    else
    begin
        for i:=0 to  GrpTop.ControlCount  -1 do
        begin
            (GrpTop.Controls[i] as Tcontrol).Top  :=(GrpTop.Controls[i] as Tcontrol).Top +5;
        end;
    end;
end;
procedure TFrmUserDefineReport.FormShow(Sender: TObject);
begin
ToolButton2Click(Sender);
end;

procedure TFrmUserDefineReport.imgtopMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Button2: TMouseButton;
var Shift2: TShiftState    ;
var i:integer;
begin


      if(not drawing)then
    begin
         if(oldx<>newx)then imgtop.Canvas.Rectangle(oldx,oldy,newx,newy);
         oldx:=x;
         newx:=x;
         oldy:=y;
         newy:=y;
         drawing:=true;
         imgtop.Canvas.Pen.Mode:=pmnot;
         imgtop.Canvas.Brush.Style:=bsclear;

         fstpt.X :=x;
         fstpt.Y :=y;


        Button2:= mbLeft;
        Shift2 :=[ssleft	];
        for i:=0 to self.GrpTop.ComponentCount -1 do
        begin
        MouseUp(Twincontrol(GrpTop.Components[i]),Button2, Shift2,x,y);
        end;
    end;


end;

procedure TFrmUserDefineReport.imgtopMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if drawing then
    begin
         imgtop.Canvas.Rectangle(oldx,oldy,newx,newy);
         newx:=x;
         newy:=y;
         imgtop.Canvas.Rectangle(oldx,oldy,newx,newy);
    end;
end;
procedure TFrmUserDefineReport.imgtopMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
var Button2: TMouseButton;
var Shift2: TShiftState    ;

var xo,xn,yo,yn:integer;
begin
   if drawing then drawing:=false;

   if fstpt.X <   x then
   begin
      xo:=fstpt.X  ;
      xn:=x;
   end
   else
   begin
       xo:=  x;
       xn:=  fstpt.X
   end;

   if fstpt.Y  <   y then
   begin
      yo:= fstpt.Y;
      yn:=y;
   end
   else
   begin
      yo:=y;
      yn:= fstpt.Y;
   end;



      Button2:= mbLeft;
   Shift2 :=[ ssshift ,ssleft	];
   for i:=0 to self.GrpTop.ComponentCount -1 do
   begin
         if (
                  (Twincontrol(GrpTop.Components[i]).top   >yo  )
              and (Twincontrol(GrpTop.Components[i]).Top   <yn+10)
              and (Twincontrol(GrpTop.Components[i]).left   >xo   )
              and (Twincontrol(GrpTop.Components[i]).left <xn+10 )
            ) then
          MouseDown(GrpTop.Components[i],  Button2,  Shift2,0,0);
   end;
end;

procedure TFrmUserDefineReport.FormResize(Sender: TObject);
begin
 imgtop.Canvas.FillRect(imgtop.BoundsRect);
end;

procedure TFrmUserDefineReport.imgtopDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
      if    (Source is   tlistbox )  then
      begin
           CreateCtrl(GrpTop,Source,x,y) ;
      end;
end;

procedure TFrmUserDefineReport.imgtopDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
if  Source is tlistbox then
Accept:=true;
end;

function TFrmUserDefineReport.GetMaxPrintModuleID: integer;
var qry:Tadoquery;
var sql,fontname:string;
var sender:  Tcontrol;
var fontsize :integer;
begin


      qry:=Tadoquery.Create (nil);
      qry.Connection :=FhlKnl1.Connection  ;

      sql:='select isnull(max(f20),0)as f20  from T506 where f20 is not null  ';
      qry.SQL.Clear ;
      qry.SQL.Add(sql);
      qry.Open ;

      if  qry.IsEmpty then
         result:=1
         else
  result:=   qry.FieldByName('f20').AsInteger+1 ;


try
    qry.Close;;
    qry.Free ;
except
    on err:exception do
    begin
    showmessage(err.Message );
    qry.Free ;
    end;
end;

end;

procedure TFrmUserDefineReport.TlbtnExpandClick(Sender: TObject);
var i:integer;
var firstTop:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          firstTop :=tcontrol( self.FCollector.Objects [0]).Top ;
          for i:=0 to self.FCollector.Count -1 do
          begin

                tcontrol( self.FCollector.Objects [i]).Width  :=  tcontrol( self.FCollector.Objects [i]).Width +strtoint(edMoveSpan.text)   ;


          end;
    end;
end;

procedure TFrmUserDefineReport.TlbtnsuoxiaoClick(Sender: TObject);
var i:integer;
var firstTop:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          firstTop :=tcontrol( self.FCollector.Objects [0]).Top ;
          for i:=0 to self.FCollector.Count -1 do
          begin

                tcontrol( self.FCollector.Objects [i]).Width  :=  tcontrol( self.FCollector.Objects [i]).Width  -strtoint(edMoveSpan.text)   ;


          end;
    end;
end;

procedure TFrmUserDefineReport.tblSpantoSmallClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Top  :=   tcontrol( self.FCollector.Objects [i]).Top  -i ;
          end;
    end

end;

procedure TFrmUserDefineReport.tlbtnSpanTobigClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Top  :=   tcontrol( self.FCollector.Objects [i]).Top  +i ;
          end;
    end

end;
 

procedure TFrmUserDefineReport.btnUseOldModuleClick(Sender: TObject);
begin
    if edtPrintID.Text <>'' then
    begin

       LoadConfig(GrpTop,edtPrintID.Text  );
             edttitle.Text :=edttitle.Text+'2';
    end;

end;

procedure TFrmUserDefineReport.DblClick_LblEx(Sender: TObject);
var   FrmUpdateProperty: TFrmUpdateProperty;
begin
 if Sender is tlabel then
 begin
    FrmUpdateProperty:= TFrmUpdateProperty.Create(nil);

 FrmUpdateProperty.Acontrol := Tcontrol(Sender);


      FrmUpdateProperty.edtCaption.Text :=  (Sender as tlabel).Caption ;
      (FrmUpdateProperty.Acontrol as Tlabel).Color :=(Sender as Tlabel).Color ;
      FrmUpdateProperty.lbl1.Font:=(Sender as Tlabel).Font ;
 
    FrmUpdateProperty.ShowModal ;


 end;

end;

end.



