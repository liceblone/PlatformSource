unit UnitUserDefineRpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Menus, ToolWin, UnitGrid,
  DB, ADODB;

type
  TFrmUserDefineReport = class(TForm)
    PnlRight: TPanel;
    GrpTop: TGroupBox;
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
    LstMDatasetFields: TListBox;
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
    TlbtnExpand: TToolButton;
    Tlbtnsuoxiao: TToolButton;
    tblSpantoSmall: TToolButton;
    tlbtnSpanTobig: TToolButton;
    edtPrintID: TEdit;
    btnUseOldModule: TButton;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    j1: TMenuItem;
    Panel1: TPanel;
    edttitle: TEdit;
    RdoGrpPosition: TRadioGroup;
    Label2: TLabel;
    MmlblCaption: TMemo;
    LstGridFields: TListBox;
    Splitter4: TSplitter;

    procedure CreateCtrl(grp:TGroupbox; Source: TObject; X,  Y: Integer);

    procedure LstMDatasetFieldsMouseMove(Sender: TObject; Shift: TShiftState;  X, Y: Integer);
    procedure lstSysFieldsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure grpBtmDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure grpBtmDragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure SavePorpertyToDataBase( source: Tcomponent;BOXID:string;ModelID:String);
    procedure LoadConfig( parent: TComponent;BOXID:string);
    procedure IniUserFields(mtDataSetId:string);
    procedure IniSysFileds();
    procedure ToolButton1Click(Sender: TObject);
    procedure SaveCtrl(Grp:TgroupBox;BoxID:string;ModelID:String);
    procedure SaveQrGridCols(pGrid: TDBGrid; ModelID: String);
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
    procedure imgtopMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure imgtopMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure imgtopMouseUp(Sender: TObject; Button: TMouseButton;   Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure imgtopDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure imgtopDragOver(Sender, Source: TObject; X, Y: Integer;  State: TDragState; var Accept: Boolean);
    procedure TlbtnExpandClick(Sender: TObject);
    procedure TlbtnsuoxiaoClick(Sender: TObject);
    procedure tblSpantoSmallClick(Sender: TObject);
    procedure tlbtnSpanTobigClick(Sender: TObject);
    procedure btnUseOldModuleClick(Sender: TObject);
    procedure imgbtmDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure imgbtmDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BtnCreateCtrlClick(Sender: TObject);
    procedure imgbtmMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgbtmMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgbtmMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure LstGridFieldsMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);

  private
      GridPrt:TModelDbGrid ; // GridPrt;
      FGird:Tdbgrid;         //GridDataSource
    { Private declarations }
      FtopBoxID,FBtmBoxID:string;
      FMtdatasetID,fGridId:string;

      FCollector:Tstrings;
      oldx,oldy,newx,newy:integer;
      fstpt:Tpoint;
      drawing:boolean;

      FContentDataSet:TDataSet;
      FDataSetID :string;

      modelID:string;
    procedure SetBtmBoxID(const Value: string);
    procedure SetTopBoxID(const Value: string);

  public
    { Public declarations }
     PPrintId:string;
     IsLabelTemplate:boolean;
     Procedure IniDefinePrt(fMasterDataSet:TDataSet;DatasetID, topboxid,   pBtmboxid,pmodelID: string;Midgird:Tdbgrid=nil );

     function GetMaxPrintModuleID:integer;
     property topBoxID:string read FTopBoxID write SetTopBoxID;

     property BtmBoxID:string read FBtmBoxID write SetBtmBoxID;


  end;

var
  FrmUserDefineReport1: TFrmUserDefineReport;

implementation
   uses datamodule,UPublicCtrl,FhlKnl,UnitUpdateProerty,UPublicFunction ,UnitUpdateQLabel;
{$R *.DFM}

{ TFrmUserDefineReport }

procedure TFrmUserDefineReport.IniDefinePrt(fMasterDataSet:TDataSet;DatasetID, topboxid, pBtmboxid,pmodelID: string;Midgird:Tdbgrid=nil );
  var i:integer;
  col:TColumn;
  asql:string ;
begin
    if pBtmboxid='' then
        grpBtm.Visible :=False ;

    FContentDataSet:=fMasterDataSet;
    FDataSetID :=DatasetID;
    FTopBoxID:=topboxid;
    FBtmBoxID:=pBtmboxid;
    FGird:=Midgird;
    modelID:=  pmodelID ;
    FMtdatasetID:=DatasetID;
    iniUserFields(DatasetID);
    IniSysFileds();

    if IsLabelTemplate then
      GrpTop.Align :=alclient;

    grpBtm.visible :=  not self.IsLabelTemplate ;
    GridPrt.visible :=  not self.IsLabelTemplate ;
    
    if ( Midgird<>nil ) and ( not self.IsLabelTemplate )   then
    begin 
      asql:='insert into '+dmFrm.ADOConnection1.DefaultDatabase +'.dbo.T516 ';
      asql:=asql+'(F02,F03,F04,F05,F06,F07,F08,F09,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F200,F27,F28,F29) ';
      asql:=asql+'select '+quotedstr(ModelID)+', col.F03,col.F04,col.F05,col.F06,col.F07,col.F08,col.F09,col.F10, ';
      asql:=asql+'col.F11,col.F12,col.F13,col.F14,col.F15,col.F16,col.F17,col.F18,col.F19,col.F20,col.F21,col.F22,col.F23,col.F24,col.F200,col.F27,col.F28,col.F29 ';
      asql:=asql+' from t505 col join T102 fld on col.f03=fld.f01 ';
      asql:=asql+' where col.f02='+IntToStr(Midgird.Tag )    ;
      asql:=asql+' and fld.f02  not in (select ufld.f02 from '+dmFrm.ADOConnection1.DefaultDatabase +'.dbo.T516 uCol join T102 ufld on col.f03=ufld.f01  where uCol.f02= '+quotedstr(ModelID )+') ';

     FhlKnl1.Kl_GetQuery2(asql,False);   {   }
     FhlKnl1.Cf_SetDbGrid_PRT (modelID,GridPrt );
    end;

    if Midgird<>nil then
      for i:=0 to Midgird.Columns.Count -1 do
      begin 
        LstGridFields.Items.Add(Midgird.Columns[i].FieldName+'='+ Midgird.Columns[i].Title.Caption ) ;
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

      LstMDatasetFields.Clear;

             
      if not qry.IsEmpty then
      begin
            while not qry.Eof do
            begin
                  values:= qry.FieldByName('name').AsString +'=' + qry.FieldByName('label').AsString ;
                  LstMDatasetFields.items.Add(values) ;
                  qry.Next;
            end;
      end;  {
      else  
      begin

            for i:=0 to     self.FGird.Columns.Count -1 do
            begin
                 values:= FGird.Columns[i].FieldName   +'=' + FGird.Columns[i].Title.Caption  ;
              LstUserFields.items.Add(values) ;
            end;
                       

          //  showmessage('还没有建立字段!');

      end;    }
  finally
    qry.Free;
  end;

end;
procedure TFrmUserDefineReport.LstMDatasetFieldsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if shift= [ssLeft] then
      LstMDatasetFields.BeginDrag(true);
end;

procedure TFrmUserDefineReport.CreateCtrl(grp:TGroupbox; Source: TObject; X,  Y: Integer);
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
          Tlabel_Mtn(lbl).SetCollector ( FCollector);
          lbl.Hint := GetGUID ;

         // lbl.seSetCollector ( FCollector);


          CTRL:=Tedit_Mtn.Create (grp);
          CTRL.Parent :=grp;
          CTRL.Left :=x+lbl.Width +6;
          CTRL.Top :=lbl.Top-3;
          CTRL.ShowHint :=true;
          CTRL.Hint := GetGUID;

          CTRL.Text := name ;
          CTRL.Visible :=true;
          CTRL.ReadOnly :=true;
          CTRL.OnMouseDown:=MouseDown;
          CTRL.OnDblClick :=DblClick_Ex;
          CTRL.OnMouseUp  :=MouseUp; 
          CTRL.fCollector:= FCollector;
           Tedit_Mtn(CTRL).Tag :=1;
          if   (Source as tlistbox ).Name = 'LstMDatasetFields' then
            CTRL.DLDataSourceType := 0   // mt data set
          else
            CTRL.DLDataSourceType :=1;  //dl dataset
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

procedure TFrmUserDefineReport.SavePorpertyToDataBase( source: TComponent;BOXID:string;ModelID:String);
var qry:Tadoquery;
var sql,fontname:string;
var sender:  Tcontrol;
var fontsize :integer;
var list:TStringList;
begin
  try
      sender:=Tcontrol(   source);
      list:= Tstringlist.Create;
      list.CommaText := sender.Hint;

      qry:=Tadoquery.Create (nil);
      qry.Connection :=FhlKnl1.Connection  ;
      qry.Close ;

      if BOXID<>''   then
         sql:='select * from '+dmFrm.ADOConnection1.DefaultDatabase +'.dbo.T506  where f20='+quotedstr(ModelID)+' and f02='+quotedstr(BOXID)+' and f22='+quotedstr(self.PPrintId )+' and f01='+quotedstr( Tcontrol(source).Hint )
      else
        sql:='select top 0 * from '+dmFrm.ADOConnection1.DefaultDatabase +'.dbo.T506  ';

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
      qry.FieldByName('f20').Value:=  ModelID ;
      qry.FieldByName('f21').Value:=edttitle.Text;
      qry.FieldByName('f02').Value:=  BOXID ;
      qry.FieldByName('FLabelTemplate').Value:=  self.IsLabelTemplate  ;


     {Caption	ftString	F04
      Color	ftString	F05
      FntClr	ftString	F06
      FntSiz	ftInteger	F07
      FntNam	ftString	F08
      }
     qry.FieldByName('f01').Value:=sender.Hint;// ;
     if (sender is TLabel)then
     begin
       qry.FieldByName('f04').Value:= TLabel( sender).Caption  ;
       qry.FieldByName('f05').Value:=  TLabel( sender).Color ;
       qry.FieldByName('f06').Value:= ColorToString(TLabel( sender).Font.Color );
       qry.FieldByName('f07').Value:= TLabel( sender).Font.Size;
       qry.FieldByName('f08').Value:=TLabel( sender).Font.Name ;

       IF fsBold   IN       TLabel( sender).Font.Style   THEN
          qry.FieldByName('f09').Value:=1
       else
          qry.FieldByName('f09').Value:=0;

       IF fsItalic IN        TLabel( sender).Font.Style THEN
          qry.FieldByName('f10').Value:=1  ;
       IF fsUnderline IN        TLabel( sender).Font.Style THEN
          qry.FieldByName('f11').Value:=1  ;

       qry.FieldByName('f17').Value:= 0;                      // F10 AS ctrl type
     end      ;

     if (sender is Tedit_Mtn)then
     begin    
       qry.FieldByName('f04').Value:= TEDIT( sender).Text ;
       qry.FieldByName('f05').Value:= TEDIT( sender).Color ;
       qry.FieldByName('f06').Value:= TEDIT( sender).Font.Color  ;
       qry.FieldByName('f07').Value:= TEDIT( sender).Font.Size;
       qry.FieldByName('f08').Value:= TEDIT( sender).Font.Name ;

       IF  fsBold  IN        Tedit( sender).Font.Style THEN
           qry.FieldByName('f09').Value:=1
       else
          qry.FieldByName('f09').Value:=0;

       IF  fsItalic    IN        TLabel( sender).Font.Style THEN         qry.FieldByName('f10').Value:=1 ;
       IF  fsUnderline IN        TLabel( sender).Font.Style THEN         qry.FieldByName('f11').Value:=1;

       qry.FieldByName('f17').Value:= Tedit_Mtn(sender).Tag ;
       qry.FieldByName('f23').Value:=Tedit_Mtn(sender).DLDataSourceType;
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
  finally
    freeandnil(list);
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
  sql:='select * from '+dmFrm.ADOConnection1.DefaultDatabase +'.dbo.T506  where f22 ='+quotedstr(self.PPrintId )+' and    f02='+quotedstr(BOXID)+' and F20='+quotedstr(self.modelID );
  qry.SQL.Clear ;
  qry.SQL.Add(sql);
  qry.Open ;
    
  if  (not qry.IsEmpty ) then
  edttitle.Text :=qry.FieldByName('f21').AsString ;
  begin
  for i:=0 to qry.RecordCount -1 do
   begin
      if  (qry.FieldByName('f17').Value='0') then
      begin
          loadCtrl:=Tlabel_Mtn.Create(parent);
          loadCtrl.Parent  :=TWincontrol(parent);
          Tlabel_Mtn(loadCtrl).Font.Name := qry.FieldByName('f08').Value;
          Tlabel_Mtn(loadCtrl).Font.Size := qry.FieldByName('f07').Value ;
          Tlabel_Mtn(loadCtrl).Font.Color :=StringToColor( qry.FieldByName('f06').Value);
          Tlabel_Mtn(loadCtrl).Caption := qry.FieldByName('f04').AsString ;
          Tlabel_Mtn(loadCtrl).Color :=StringToColor(qry.FieldByName('f05').AsString);

          Tlabel_Mtn(loadCtrl).BoxId:=BoxId;                       //记录boxid，删除控键时用到  2006-5-8
          Tlabel_Mtn(loadCtrl).OnMouseDown:=MouseDown;
          Tlabel_Mtn(loadCtrl).OnDblClick :=DblClick_LblEx;
          Tlabel_Mtn(loadCtrl).OnMouseUp  :=       MouseUp;
          Tlabel_Mtn(loadCtrl).SetCollector ( FCollector);

      end;
      if    (qry.FieldByName('f17').Value>=1) then
      begin
          loadCtrl:=Tedit_Mtn.Create (parent);
          loadCtrl.Parent := Twincontrol(   parent);
          Tedit_Mtn(loadCtrl).Font.Name := qry.FieldByName('f08').Value;
          Tedit_Mtn(loadCtrl).Font.Size := qry.FieldByName('f07').Value;
          Tedit_Mtn(loadCtrl).Font.Color := StringToColor(qry.FieldByName('f06').Value);
          Tedit_Mtn(loadCtrl).Text  := qry.FieldByName('f04').AsString ;
          Tedit_Mtn(loadCtrl).BoxId:=BoxId;                       //记录boxid，删除控键时用到  2006-5-8
          Tedit_Mtn(loadCtrl).OnMouseDown:=MouseDown;
          Tedit_Mtn(loadCtrl).OnDblClick :=DblClick_Ex;
          Tedit_Mtn(loadCtrl).OnMouseUp  :=       MouseUp;
          Tedit_Mtn(loadCtrl).FCollector := FCollector;
          Tedit_Mtn(loadCtrl).ReadOnly :=true;
          Tedit_Mtn(loadCtrl).DLDataSourceType :=qry.FieldByName('f23').Value;
      end  ;
        loadCtrl.Left :=qry.FieldByName('f12').Value;
        loadCtrl.Top := qry.FieldByName('f13').Value ;
         loadCtrl.Width :=qry.FieldByName('f14').Value;
        loadCtrl.Height :=qry.FieldByName('f15').Value;

        loadCtrl.Hint :=qry.FieldByName('f01').Value ;
        loadCtrl.tag:=  qry.FieldByName('f17').Value ;
        qry.Next ;
     end;
   end;


end;
procedure TFrmUserDefineReport.SaveCtrl(Grp: TgroupBox; BoxID: string;ModelID:String);
var i:integer;   var clr:Tcolor;
begin
    for i:=0 to Grp.ComponentCount -1 do
    begin
        if (Grp.Components[i]is tlabel ) then
         clr:=(Grp.Components[i]as tlabel ).Color ;

        if (Grp.Components[i]is tedit ) then
           clr:=(Grp.Components[i]as tedit ).Color ;

        if clr <>stringtocolor('0') then
           if  BoxID='' then
               BoxID:=GetGUID;

        SavePorpertyToDataBase( Grp.Components[i],BoxID ,ModelID);
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
    if trim(self.modelID) ='' then
    modelID:=getguid;

    if ( ( FtopBoxID<>'')and (FtopBoxID<>'-1'))  then
      SaveCtrl(GrpTop, FtopBoxID,modelID);
    if ( ( FBtmBoxID<>'')and (FBtmBoxID<>'-1'))  then
      SaveCtrl(grpBtm, self.FBtmBoxID ,modelID);
    if not IsLabelTemplate then
      SaveQrGridCols(Self.GridPrt ,modelID);
 
    showmessage('保存成功' );
except on E:Exception do
    showmessage(E.Message );
end;
end;

procedure TFrmUserDefineReport.ToolButton2Click(Sender: TObject);
var i:integer;
var asql:string;
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

     if trim(self.FBtmBoxID ) <>'' then
     LoadConfig(grpBtm,self.FBtmBoxID );


 
end;
procedure TFrmUserDefineReport.DblClick_Ex(Sender: TObject);
var actlst:Tstringlist;
var FontDialog1:TFontDialog;
var FrmUpdateProperty: TFrmUpdateProperty;
begin
   if Sender is tedit then
   begin
      FrmUpdateProperty:=TFrmUpdateProperty.Create (self);
      FrmUpdateProperty.Acontrol:=Tcontrol(sender);
      FrmUpdateProperty.GrpLabel.Visible:=true;
      FrmUpdateProperty.rg1.ItemIndex := Tcontrol(sender).Tag ;
      FrmUpdateProperty.Show ;
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
           sql:='delete '+dmFrm.ADOConnection1.DefaultDatabase +'.dbo.t506 where f02='+quotedstr(boxid)+' and f01='+quotedstr(Tcontrol(sender).hint);
             if (Sender is tlabel) then
             (Sender as tlabel).Color :=stringtocolor('0');
             if (Sender is tedit) then
             (Sender as tedit).Color :=stringtocolor('0');


             fhlknl1.Kl_GetUserQuery(sql,false);
         end
         else
         showmessage('无法删除');
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
var i:integer;
begin
  self.FCollector :=Tstringlist.Create ;
  //imgtop.Canvas.FillRect(imgtop.BoundsRect);
  oldx:=0;
  oldy:=0;
  newx:=0;
  newy:=0;
  GridPrt:=TModelDbGrid.create(nil) ;
  GridPrt.PopupMenu:=dmFrm.MPopupGridCoLRPT ;
  //GridPrt.DataSource :=self.FGird.DataSource;
 
  GridPrt.Parent := PnlRight ;
  GridPrt.Align :=alclient;
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

procedure TFrmUserDefineReport.imgtopDragDrop(Sender, Source: TObject; X,  Y: Integer);
var dataSetName:string;
begin
      if    (Source is   tlistbox )  then
      begin
           CreateCtrl( GrpTop,Source,x,y) ;
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

    sql:='select isnull(max(f20),0)as f20  from '+dmFrm.ADOConnection1.DefaultDatabase +'.dbo.T506 where f20 is not null  ';
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
    if  self.FCollector.Count>1 then
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
             tcontrol( self.FCollector.Objects [i]).left  :=   tcontrol( self.FCollector.Objects [i]).left  -strtoint(edMoveSpan.Text )*i ;
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
             tcontrol( self.FCollector.Objects [i]).left  :=   tcontrol( self.FCollector.Objects [i]).left  +strtoint(edMoveSpan.Text ) *i;
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
var   FrmUpdateProperty: TFrmUpdateQLabel;
begin
   if Sender is tlabel then
   begin
      FrmUpdateProperty:= TFrmUpdateQLabel.Create(nil);
      FrmUpdateProperty.QLabel:=(Sender as tlabel);
      FrmUpdateProperty.ShowModal ;
   end;
end;

procedure TFrmUserDefineReport.imgbtmDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
if  Source is tlistbox then
Accept:=true;
end;

procedure TFrmUserDefineReport.imgbtmDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
      if    (Source is   tlistbox )  then
      begin
           CreateCtrl( grpBtm,Source,x,y) ;
      end;
end;


procedure TFrmUserDefineReport.BtnCreateCtrlClick(Sender: TObject);
var loadCtrl:Tlabel_Mtn;
var i:integer;
begin
    for i:=0 to MmlblCaption.Lines.Count -1 do
    begin
        if  trim(MmlblCaption.Lines[i])='' then continue;
        if RdoGrpPosition.ItemIndex =0 then
        begin
            loadCtrl:=Tlabel_Mtn.Create(GrpTop);
            loadCtrl.Parent  :=TWincontrol(self.GrpTop );
            Tlabel_Mtn(loadCtrl).BoxId:=self.FtopBoxID ;                       //记录boxid，删除控键时用到  2006-5-8
        end
        else
        begin
            loadCtrl:=Tlabel_Mtn.Create(grpBtm);
            loadCtrl.Parent  :=TWincontrol(self.grpBtm);
            Tlabel_Mtn(loadCtrl).BoxId:=self.FBtmBoxID ;
        end;
        loadCtrl.Hint := GetGUID;
        loadCtrl.Caption :=  MmlblCaption.Lines[i] ;
        loadCtrl.Left :=i*35;
        loadCtrl.top:=20;

        Tlabel_Mtn(loadCtrl).OnMouseDown:=MouseDown;
        Tlabel_Mtn(loadCtrl).OnDblClick :=DblClick_LblEx;
        Tlabel_Mtn(loadCtrl).OnMouseUp  :=       MouseUp;
        Tlabel_Mtn(loadCtrl).SetCollector ( FCollector);
    end;

end;

procedure TFrmUserDefineReport.SetBtmBoxID(const Value: string);
begin
  FBtmBoxID := Value;
end;

procedure TFrmUserDefineReport.SetTopBoxID(const Value: string);
begin
  FTopBoxID := Value;
end;

procedure TFrmUserDefineReport.imgbtmMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Button2: TMouseButton;
var Shift2: TShiftState    ;
var i:integer;
begin
    if(not drawing)then
    begin
      if(oldx<>newx)then imgbtm.Canvas.Rectangle(oldx,oldy,newx,newy);
      oldx:=x;
      newx:=x;
      oldy:=y;
      newy:=y;
      drawing:=true;
      imgbtm.Canvas.Pen.Mode:=pmnot;
      imgbtm.Canvas.Brush.Style:=bsclear;

      fstpt.X :=x;
      fstpt.Y :=y;
      Button2:= mbLeft;
      Shift2 :=[ssleft	];
      for i:=0 to self.grpBtm.ComponentCount -1 do
      begin
          MouseUp(Twincontrol(grpBtm.Components[i]),Button2, Shift2,x,y);
      end;
    end;
end;

procedure TFrmUserDefineReport.imgbtmMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if drawing then
    begin
         imgbtm.Canvas.Rectangle(oldx,oldy,newx,newy);
         newx:=x;
         newy:=y;
         imgbtm.Canvas.Rectangle(oldx,oldy,newx,newy);
    end;
end;

procedure TFrmUserDefineReport.imgbtmMouseUp(Sender: TObject;
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
   for i:=0 to self.grpBtm.ComponentCount -1 do
   begin
       if (
                (Twincontrol(grpBtm.Components[i]).top   >yo  )
            and (Twincontrol(grpBtm.Components[i]).Top   <yn+10)
            and (Twincontrol(grpBtm.Components[i]).left  >xo   )
            and (Twincontrol(grpBtm.Components[i]).left  <xn+10 )
          ) then
        MouseDown(grpBtm.Components[i],  Button2,  Shift2,0,0);
   end;
end;

procedure TFrmUserDefineReport.FormDestroy(Sender: TObject);
begin
  GridPrt.Free ;
end;

procedure TFrmUserDefineReport.SaveQrGridCols(pGrid: TDBGrid;
  ModelID: String);
var
  i:integer;
  a:string[1];
  asql,OriCaption:string;
begin
  Screen.Cursor:=crSqlWait;
  try
    with pGrid do
      for i:=0 to Columns.Count-1 do
      begin
        case Columns[i].Alignment of
          taLeftJustify: a:='0';
          taRightJustify: a:='2';
          taCenter: a:='1';
        end;
  

        asql:='update '+dmFrm.ADOConnection1.DefaultDatabase +'.dbo.T516 set'+
          ' F04='+intTostr(Columns[i].Width)+
          ',F07='+intTostr(ord(Columns[i].Visible))+
          ',F23='+intTostr(i)+
          ',F09='+QuotedStr(ColorToString(Columns[i].Color))+
          ',F21='+intTostr(Columns[i].Font.Size)+
          ',F22='+QuotedStr(ColorToString(Columns[i].Font.Color))+
          ',F13='+a+
          ',F14='+QuotedStr(Columns[i].Title.Caption )+
          ',F15='+QuotedStr(ColorToString(Columns[i].Title.Color))+
          ',F18='+intTostr(Columns[i].Title.Font.Size)+
          ',F19='+QuotedStr(ColorToString(Columns[i].Title.Font.Color))+
          ',F27='+QuotedStr(  TChyColumn(Columns[i]).DeciamlFormat )+
          //f28 order asc dec
          ',F29='+ inttostr(  ord(TChyColumn(Columns[i]).SumType   ))   +

          ' where F02='+quotedstr(ModelID)+
          //' and F14='+QuotedStr(Columns[i].Title.Caption)  ;
           ' and F03 in (select f01 From T102 where F02=  '+QuotedStr(Columns[i].FieldName  )+')'  ;

        FhlKnl1.Kl_GetQuery2(asql,False);

      end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

 

procedure TFrmUserDefineReport.LstGridFieldsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if shift= [ssLeft] then
      LstGridFields.BeginDrag(true);
end;

end.
