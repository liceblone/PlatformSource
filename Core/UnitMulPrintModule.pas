unit UnitMulPrintModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB, ExtCtrls, DBCtrls, Mask,
  FR_Class;

type
  TFrmMulModulePrint = class(TForm)
    StrGridPrintModule: TStringGrid;
    BtnPreview: TButton;
    Button2: TButton;
    DatasetReport: TADODataSet;
    btnprint: TButton;
    btnPrintOne: TButton;
    BtnDelete: TButton;
    BtnPageSize: TButton;
    GroupBox1: TGroupBox;
    plPageSize: TPanel;
    lblheight: TLabel;
    lblwidth: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnDefineRptModel: TButton;
    lblTitle: TLabel;
    btnFont: TButton;
    FontDialog1: TFontDialog;
    DataSource1: TDataSource;
    edtLeftMargin: TDBEdit;
    edtRightMargin: TDBEdit;
    edtTopMargin: TDBEdit;
    edtBtmMargin: TDBEdit;
    edtWidth: TDBEdit;
    edtHeight: TDBEdit;
    RdgpOrientation: TDBCheckBox;
    ChkDrawGrid: TDBCheckBox;
    BtnPrevior: TButton;
    BtnNext: TButton;
    dbChkLabelTemplate: TDBCheckBox;
    btnExit: TButton;
    frReport1: TfrReport;
    procedure FormDblClick(Sender: TObject);
    procedure BtnPreviewClick(Sender: TObject);
    procedure btnprintClick(Sender: TObject);
    procedure btnPrintOneClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnDefineRptModelClick(Sender: TObject);
    procedure ReflashConfig;
    procedure btnFontClick(Sender: TObject);
    procedure edtKeyPress(Sender: TObject; var Key: Char);
    procedure StrGridPrintModuleClick(Sender: TObject);
    procedure BtnPageSizeClick(Sender: TObject);
    procedure BtnPreviorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
    FPrintId:string;
    FContentDataSet:TDataSet;
    FDataSetID :string;
    FTopBoxID:string;
    FBtmBoxID:string;
    FGrid:Tdbgrid;
    fMaxPrintModule: Integer;
    function  getTopBoxID: string;
    procedure setTopBoxID(const Value: string);
    procedure SetMaxPrintModule(const Value: Integer);
    procedure PreviewMDTemplate;
    procedure PreviewLabelTemplate;
    function  CreatePage(report: TfrReport ;width,height:integer): TfrPage;

  public
    { Public declarations }
   function   FrmIni(PrintID: string;fMasterDataSet:TDataSet;DatasetID, topboxid,      Btmboxid: string;Midgird:Tdbgrid=nil ):boolean;overload ;
   function   FrmIni :boolean;overload ;
   property TopBoxID  :string  read getTopBoxID write setTopBoxID;
   property MaxPrintModule:Integer read   fMaxPrintModule write SetMaxPrintModule;
  end;

var
  FrmMulModulePrint: TFrmMulModulePrint;

implementation
     uses datamodule,fhlknl ,UnitUserDefineRpt ,UnitEditorReport,RepBill,Printers ,QRPrntr ,UnitUserQrRptEx,UPublicFunction
     ,UnitGrid,UPublicCtrl, UnitChyFrReportView;
{$R *.dfm}

{ TFrmMulModulePrint }

function  TFrmMulModulePrint.FrmIni(PrintID: string;fMasterDataSet:TDataSet;DatasetID, topboxid,      Btmboxid: string;Midgird:Tdbgrid=nil ):boolean;
var RowsStrLst:Tstrings;
var i:integer;
begin
    FPrintId:=PrintID;
    FContentDataSet:=fMasterDataSet;
    FContentDataSet.Name :=fMasterDataSet.Name;
    FDataSetID :=DatasetID;
    FTopBoxID:=topboxid;
    FBtmBoxID:=Btmboxid;
    FGrid:=Midgird;
    Result:=False;
    TModelDbGrid(Midgird).ReflashSumValues;

    for i:= self.StrGridPrintModule.RowCount -1 to 0 do
    begin
      self.StrGridPrintModule.Cols  [0].Clear ;
      self.StrGridPrintModule.Cols [1].Clear ;
    end;

    fhlknl1. Kl_GetQuery2('select distinct f20 ,f21 from '+dmfrm.ADOConnection1.DefaultDatabase +'.dbo.T506 where F22='+quotedstr(PrintID));
    if  fhlknl1.FreeQuery .RecordCount>=1 then
    begin
          StrGridPrintModule.ColWidths[0]:=1;
          StrGridPrintModule.ColWidths[1]:=200;
          StrGridPrintModule.RowCount :=   fhlknl1.FreeQuery.RecordCount+1;
          for   i:=0 to   fhlknl1.FreeQuery.RecordCount -1   do
          begin
             StrGridPrintModule.Cols[0].Add(fhlknl1.FreeQuery.FieldByName('f20').asString)   ;
             StrGridPrintModule.Cols[1].Add(fhlknl1.FreeQuery.FieldByName('f21').asString)   ;
             fhlknl1.FreeQuery.Next;
          end;

          Result:=True;
    end;
    StrGridPrintModule.Cols[0].Add('')   ;
    StrGridPrintModule.Cols[1].Add('新增模板')   ;
    fhlknl1.FreeQuery.Close;
    StrGridPrintModule.OnClick(StrGridPrintModule);

end;

procedure TFrmMulModulePrint.FormDblClick(Sender: TObject);
 var FrmUserDefineReport1: TFrmUserDefineReport;
 var modelID:string;
begin
  if LoginInfo.Sys  then
  if GetKeyState(vk_control) <0  then
  begin

      modelID:=StrGridPrintModule.Cols[0].Strings[0];
      FrmUserDefineReport1:= TFrmUserDefineReport.Create (self);
      FrmUserDefineReport1.IniDefinePrt(self.FContentDataSet   , self.FDataSetID,self.FTopBoxID ,self.FBtmBoxID,modelID,self.FGrid );
      FrmUserDefineReport1.PPrintID:=self.FPrintId ;
      FrmUserDefineReport1.ShowModal ;
      FrmUserDefineReport1.Free ;
      exit;
  end;

end;

procedure TFrmMulModulePrint.BtnPreviewClick(Sender: TObject);
var modelID:string;
var i:integer;
var CurRow:integer;
var GridPrt:TModelDbGrid;
var CunCol:TChyColumn;
begin
  //   FhlUser.CheckRight(fDict.PrintRitId);
  GridPrt:=TModelDbGrid.Create (nil);
  GridPrt.DataSource :=fgrid.DataSource;
  GridPrt.DataSource.DataSet.DisableControls ;
  CurRow:= StrGridPrintModule.Row ;
  modelID:=StrGridPrintModule.Cols[0].Strings[CurRow];

  if trim(modelID) ='' then
  begin
    ShowMessage('请选择正确打印模板');
    exit;
  end;

  if ( FTopBoxID<>'') and (not dbChkLabelTemplate.Checked ) then
      PreviewMDTemplate
  else
      PreviewLabelTemplate ;
      

end;

procedure TFrmMulModulePrint.btnprintClick(Sender: TObject);
var RepBillFrm:TEditorReport;
var i:integer;
begin

//   FhlUser.CheckRight(fDict.PrintRitId);

  if FTopBoxID<>'' then
  begin
      RepBillFrm:=TEditorReport.Create(Application);
      try
      FContentDataSet.First;
        for i:=0 to FContentDataSet.RecordCount -1 do
        begin

          //  RepBillFrm.SetBillRep(self.FTopBoxID ,self.FContentDataSet   , '');
         //   RepBillFrm.Print;

             FhlUser.DoExecProc(FContentDataSet ,null);
        FContentDataSet.Next ;
        end;

      finally
        FreeAndNil(RepBillFrm);

       end;

   end;
end;

procedure TFrmMulModulePrint.btnPrintOneClick(Sender: TObject);
var RepBillFrm:TFrmUserQrRptEx;
var i:integer;
var modelID:string;
var GridPrt   :TModelDbGrid;
begin
  //   FhlUser.CheckRight(fDict.PrintRitId);

  if FTopBoxID<>'' then
  begin
      RepBillFrm:=TFrmUserQrRptEx.Create(Application);       //2010-3-25 直接打印不行
      try
          modelID:=StrGridPrintModule.Cols[0].Strings[StrGridPrintModule.Row ];

          GridPrt:=TModelDbGrid.Create (nil);
          GridPrt.DataSource :=fgrid.DataSource;
          FhlKnl1.Cf_SetDbGrid_PRT (modelID,GridPrt );

          RepBillFrm.SetBillRep(self.FTopBoxID,self.FPrintId ,self.FBtmBoxID,modelID,self.FContentDataSet ,GridPrt );     //fgrid
          RepBillFrm.Print;

          FhlUser.DoExecProc(FContentDataSet ,null);


      finally
        FreeAndNil(GridPrt);
        FreeAndNil(RepBillFrm);
      end;
  end;
end;

function TFrmMulModulePrint.getTopBoxID: string;
begin
  result:=FTopBoxID;
end;

procedure TFrmMulModulePrint.setTopBoxID(const Value: string);
begin
  self.FTopBoxID :=value;
end;

procedure TFrmMulModulePrint.BtnDeleteClick(Sender: TObject);
var sql ,modelID :string;
begin
    modelID:=StrGridPrintModule.Cols[0].Strings[StrGridPrintModule.Row];
    if Trim(modelID)='' then
      Exit;

    if messagedlg('确定删除？',  mtWarning,[mbyes,mbno],0)=mryes then
    begin
    //MessageDlg(s+#13#10#13#10+'请纠正后重试!',mtWarning,[mbOk],0);
        sql:=' delete '+dmfrm.ADOConnection1.DefaultDatabase +'.dbo.T506 where F22='+quotedstr(self.FPrintId)  +' and f20='+quotedstr(modelID);
        fhlknl1.Kl_GetQuery2(sql,false);
        // self.FrmIni ;
    end;

end;

procedure TFrmMulModulePrint.FormCreate(Sender: TObject);
var sql:string ;
var i  :integer;
begin


  BtnDelete.Visible :=  logininfo.isAdmin;
  lblwidth.Visible := logininfo.Sys ;
  lblheight.Visible := logininfo.Sys ;
  edtWidth.Visible := logininfo.Sys ;
  edtHeight.Visible := logininfo.Sys ;
end;

procedure TFrmMulModulePrint.BtnDefineRptModelClick(Sender: TObject);
 var FrmUserDefineReport1: TFrmUserDefineReport;
 var modelID:string;
begin
  if self.StrGridPrintModule.RowCount >=self.fMaxPrintModule+1 then
  begin
   //    showmessage('列表数据只能定义1个打印模板，单据能定义20个打印模板');
   //    Exit;
  end;

  if LoginInfo.isAdmin   then
  begin

      modelID:=StrGridPrintModule.Cols[0].Strings[StrGridPrintModule.Row ];
      if Trim(modelID)='' then modelID:=GetGUID ;// IntToStr(FGrid.Tag );
      FrmUserDefineReport1:= TFrmUserDefineReport.Create (self);

      if   DatasetReport.Active then
          FrmUserDefineReport1.IsLabelTemplate := self.dbChkLabelTemplate.Checked
      else
          if MessageBox(0, '标签模板？', '', MB_YESNO + MB_ICONQUESTION) = IDYES  then
            FrmUserDefineReport1.IsLabelTemplate  :=   true
          else
            FrmUserDefineReport1.IsLabelTemplate  :=   false;
 
      FrmUserDefineReport1.PPrintID:=self.FPrintId ;
      FrmUserDefineReport1.IniDefinePrt(self.FContentDataSet   , self.FDataSetID,self.FTopBoxID ,self.FBtmBoxID,modelID,self.FGrid );
      FrmUserDefineReport1.ShowModal ;
      FrmUserDefineReport1.Free ;

      //self.FrmIni ;
      ReflashConfig;
  end
  else
  begin
      showmessage('只有管理员才有权限定义打印模板');
  end;

end;

procedure TFrmMulModulePrint.btnFontClick(Sender: TObject);
begin
    FontDialog1.Font :=   lblTitle.Font ;

    if self.FontDialog1.Execute then
    self.lblTitle.Font:=FontDialog1.Font;
end;

procedure TFrmMulModulePrint.edtKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (Key in (['0'..'9'])) then
    Key:=#0;
end;

procedure TFrmMulModulePrint.StrGridPrintModuleClick(Sender: TObject);
var sql:string;
var i:integer;
begin
    i:=self.StrGridPrintModule.row ;
    if (self.StrGridPrintModule.RowCount >1 ) and (i<>self.StrGridPrintModule.RowCount-1 ) then
    begin
      DatasetReport.close;
      sql:='select f01,FLabelTemplate,FLeftMargin,FRightMargin,FTopMargin,FBtmMargin,FRptWidth,FRptHeight,FHasVline,FIsPortrait,FTitleFontName,FTitleFontSize,FHasPageNumber,FHasPrintTime,FFreezeBtmPnlPosition  ';
      sql:=sql+'from '+dmfrm.ADOConnection1.DefaultDatabase +'.dbo.T506 where F22='+quotedstr(fPrintID)
      +' and F20='+quotedstr(StrGridPrintModule.Cols[0][i])
      +' order by FCreateTime  ' ;

      self.DatasetReport.CommandText :=sql;
      DatasetReport.Connection :=fhlknl1.Connection ;

      DatasetReport.Open;
      if DatasetReport.FieldByName('FTitleFontSize').Value <>null then
       self.lblTitle.Font.Size :=    DatasetReport.FieldByName('FTitleFontSize').AsInteger ;
       self.lblTitle.Font.Name  :=    DatasetReport.FieldByName('FTitleFontName').AsString  ;

    end
    else
      DatasetReport.Close;
end;

procedure TFrmMulModulePrint.BtnPageSizeClick(Sender: TObject);
var i:integer;
var qry:TADOQuery;
begin
  if LoginInfo.isAdmin   then
  begin
    DatasetReport.Edit ;
    DatasetReport.FieldByName('FTitleFontSize').AsInteger :=self.lblTitle.Font.Size;
    DatasetReport.FieldByName('FTitleFontName').AsString  :=self.lblTitle.Font.Name      ;
    DatasetReport.Post ;
    try
      qry:=TADOQuery.Create(nil) ;
      qry.Connection :=fhlknl1.Connection ;
      qry.SQL.Add( ' update A set ');
      qry.SQL.Add( ' FLeftMargin=B.FLeftMargin,FRightMargin=B.FRightMargin,FTopMargin=B.FTopMargin,');
      qry.SQL.Add( ' FBtmMargin=B.FBtmMargin,FRptWidth=B.FRptWidth,FRptHeight=B.FRptHeight,         ');
      qry.SQL.Add( ' FHasVline=B.FHasVline,FIsPortrait=B.FIsPortrait,FTitleFontName=B.FTitleFontName, ');
      qry.SQL.Add( ' FTitleFontSize=B.FTitleFontSize,FHasPageNumber=B.FHasPageNumber,FHasPrintTime=B.FHasPrintTime,');
      qry.SQL.Add( ' FFreezeBtmPnlPosition=B.FFreezeBtmPnlPosition                                                  ');
      qry.SQL.Add( ' from '+dmfrm.ADOConnection1.DefaultDatabase +'.dbo.T506 A join '+dmfrm.ADOConnection1.DefaultDatabase +'.dbo.T506 B on A.F20=B.F20 and A.F22=B.F22 and B.F01='+quotedstr(self.DatasetReport.fieldbyname('F01').AsString ));
      qry.ExecSQL ;
      showmessage('保存成功！');
    finally
      qry.Free ;
    end;
  end
  else
  begin
      showmessage('只有管理员才有权限');
  end;
end;

 

procedure TFrmMulModulePrint.BtnPreviorClick(Sender: TObject);
begin
FContentDataSet.Prior;
end;

procedure TFrmMulModulePrint.BtnNextClick(Sender: TObject);
begin
FContentDataSet.Next ;
end;

procedure TFrmMulModulePrint.SetMaxPrintModule(const Value: Integer);
begin
  fMaxPrintModule := Value;
end;

function TFrmMulModulePrint.FrmIni: boolean;
begin
    self.FrmIni (FPrintId , FContentDataSet ,FDataSetID,FTopBoxID ,FBtmBoxID,FGrid );
end;

procedure TFrmMulModulePrint.ReflashConfig;
begin
//  self.DatasetReport.Close;
//  self.DatasetReport.Open;
end;

procedure TFrmMulModulePrint.btnExitClick(Sender: TObject);
begin
self.Close;
end;

procedure TFrmMulModulePrint.PreviewLabelTemplate;
var newpage : TfrPage;
fieldView  : TfrView;
i,j:integer;
sql,modelID, FieldValue,FieldName:string;
var l,t,w ,h,ABeginTop :Integer;Fnt:TFont;
fDictDataSet:TDataSet ;
const ConstGap:Integer=1;
var DLDataSourceType:boolean;
begin

    frReport1.Pages.Clear;
    ABeginTop :=  strtoint( self.edtTopMargin.Text );
    modelID:=StrGridPrintModule.Cols[0].Strings[StrGridPrintModule.Row];

    t:=0;
    Fnt:=TFont.Create;
    Fnt.Assign(self.Font);
    FGrid.DataSource.DataSet.First;

    for j:=0 to 199 do
    begin
        if self.FGrid.DataSource.DataSet.Eof then   break; 
        for i:=0+j to 199+j do
        begin
              if self.FGrid.DataSource.DataSet.Eof then   break;
              newpage:=CreatePage(frReport1 ,  strtoint( self.edtWidth.Text ) *10,  strtoint( self.edtHeight.Text )*10);
              newpage.Left  := strtoint( edtLeftMargin.text );    // newpage. := strtoint( self.edtRightMargin.Text );  //newpage.Bottom := strtoint( self.edtBtmMargin.Text );
              newpage.Top  := strtoint( self.edtTopMargin.Text );

              sql:=  'select r.*,f.F02 as F99 from '+dmfrm.ADOConnection1.DefaultDatabase
                   +'.dbo.T506 r left outer join T102 f on r.F16=f.F01 where r.F02='+ quotedstr(  fTopBoxId ) +' AND r.f20='
                   +quotedstr( modelID )+' and r.F22='+quotedstr( fprintid )+' and r.F18=1 order by r.f13' ;
              FhlKnl1.Kl_GetQuery2(sql);

              fDictDataSet := FhlKnl1.FreeQuery  ;
              fDictDataSet.First;
              While not fDictDataSet.Eof do
              begin
                  l:=fDictDataSet.FieldByName('F12').asInteger;
                  t:=fDictDataSet.FieldByName('F13').asInteger+ABeginTop;
                  Fnt.Size:=fDictDataSet.FieldByName('F07').asInteger;
                  Fnt.Name:=fDictDataSet.FieldByName('F08').asString;
                  w:=fDictDataSet.FieldByName('F14').asInteger;
                  h:= fDictDataSet.FieldByName('f15').asInteger;
                  fieldName := fDictDataSet.FieldByName('F04').AsString ;
                  DLDataSourceType := fDictDataSet.FieldByName('F23').AsBoolean   ;
                  if fDictDataSet.FieldByName('F10').asBoolean then
                      Fnt.Style:=Fnt.Style+[fsUnderLine]
                  else
                      Fnt.Style:=Fnt.Style-[fsUnderLine];
                  if fDictDataSet.FieldByName('F09').asBoolean then
                      Fnt.Style:=Fnt.Style+[fsBold]
                  else
                      Fnt.Style:=Fnt.Style-[fsBold];

                  if fDictDataSet.FieldByName('F17').asInteger =0 then
                  begin
                      w := w+13;
                      h:= h+3;
                      FieldValue := fieldName    ;
                  end
                  else
                      if  ( DLDataSourceType ) then
                          FieldValue :=   self.FGrid.DataSource.DataSet.fieldbyname( fieldName ).AsString
                      else
                          FieldValue :=   self.FContentDataSet.fieldbyname( fieldName ).AsString  ;
 
                  if fDictDataSet.FieldByName('F17').asInteger <=14 then
                  begin
                      fieldView := TfrMemoView.Create;
                      (fieldView as TfrMemoView).Font.Assign ( Fnt );
                  end;
                   if fDictDataSet.FieldByName('F17').asInteger =15  then
                  begin
                      fieldView :=  TChyFrBarCodeView.Create;
                      with  (fieldView as TChyFrBarCodeView) do
                      begin
                          BarCodeShowText:=false;
                          ResetWidthHeight(w,  h)  ;
                          LineWidth :=1;
                          Ratio :=2;
                          BarCodeType :=6;
                          CacheBarcodeImage :=true;
                      end;
                  end;
                  if fDictDataSet.FieldByName('F17').asInteger  =16   then
                  begin
                      fieldView := TChyFrQRCodeView.Create; 
                  end;
                  fieldView.Memo.Text := fieldValue ;
                  fieldView.ParentPage :=newpage;
                  fieldView.x :=l;
                  fieldView.y :=t;
                  fieldView.dx:=w;
                  fieldView.dy:=h;
                  if (fieldView is TFrDigitalImageView) then
                      (fieldView as TFrDigitalImageView).LoadPicture(); 
                  newpage.Objects.Add( fieldView ); 
                  fDictDataSet.next;
               end;
        self.FGrid.DataSource.DataSet.Next;
        end;
         
      frReport1.PrepareReport;
      frReport1.ShowReport;
     end;
      {FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery, FGrid.DataSource.DataSet,    TQRBand(TopBand1),0,fdbGrid);

      chyBar:= TChyFrBarCodeView.Create;
      chyBar.Memo.Text :=  FContentDataSet.fieldbyname( 'FWhinCOde' ).AsString  ;
      chyBar.ParentPage :=newpage;
      chyBar.x :=10;
      chyBar.y :=15;
      chybar.ResetWidthHeight(strtoint( self.edtWidth.Text ),  30)  ;
      chyBar.LineWidth :=1;
      chyBar.Ratio :=2;
      chyBar.BarCodeType :=6;
      chyBar.CacheBarcodeImage :=true;
      chyBar.LoadPicture();


      mm := TfrMemoView.Create;
      mm.ParentPage := newpage;
      mm.Memo.Text := FContentDataSet.fieldbyname( 'FWhinCOde' ).AsString  ;
      mm.x := 80;//mm1.x ;
      mm.y := 80;//mm1.y ;
      mm.dx := 60;//mm1.dx ;
      mm.dy := 30;//mm1.dy;
         
      newpage.Objects.Add( mm );

            



  
  
      qrCode:= TChyFrQRCodeView.Create ;
      with qrCode do
      begin
      Memo.Text :='[ADODataSet1."Id"]' ;
      ParentPage :=newpage;
      x :=0;
      y :=60;
      ResetWidthHeight(50,  50)  ;
      CacheBarcodeImage :=true;
      LoadPicture();
      end;


      newpage.Objects.Add( qrCode );
      newpage.Objects.Add( chyBar );
                                 }

end;
function TFrmMulModulePrint.CreatePage(report: TfrReport ;width,height:integer): TfrPage;
var newPage:TfrPage ;
begin
  report.Pages.Add;
  newPage := report.Pages[report.Pages.Count -1] ;
  newpage.pgWidth := width ;
  newpage.pgHeight:= height;
  newpage.pgSize  := 0;//report.Pages[ 0 ].pgSize ;
  result:=  newPage;
end;
procedure TFrmMulModulePrint.PreviewMDTemplate;
var RepBillFrm:TFrmUserQrRptEx;
var modelID:string;
var i:integer;
var frm:TFrmUserQrRptEx;
var CurRow:integer;
var GridPrt:TModelDbGrid;
var CunCol:TChyColumn;
begin
      //   FhlUser.CheckRight(fDict.PrintRitId);
      GridPrt:=TModelDbGrid.Create (nil);
      GridPrt.DataSource :=fgrid.DataSource;
      GridPrt.DataSource.DataSet.DisableControls ;
      CurRow:= StrGridPrintModule.Row ;
      modelID:=StrGridPrintModule.Cols[0].Strings[CurRow];

      RepBillFrm:=TFrmUserQrRptEx.Create(nil);
      try
        RepBillFrm.QuickRep1.Page.LeftMargin  := strtoint(self.edtLeftMargin.Text );
        RepBillFrm.QuickRep1.Page.RightMargin :=strtoint(self.edtRightMargin.Text );
        RepBillFrm.QuickRep1.Page.TopMargin   :=strtoint(self.edtTopMargin.Text ) ;
        RepBillFrm.QuickRep1.Page.BottomMargin:=strtoint(self.edtBtmMargin.Text );
        RepBillFrm.QuickRep1.Width            := strtoint(self.edtWidth.Text );
        RepBillFrm.QuickRep1.Height       := strtoint(self.edtHeight.Text );
        RepBillFrm.QuickRep1.Page.Width       := strtoint(self.edtWidth.Text );
        RepBillFrm.QuickRep1.Page.Length      := strtoint(self.edtHeight.Text );

        if RdgpOrientation.Checked   then
        RepBillFrm.QuickRep1.Page.Orientation:=poPortrait
        else
        RepBillFrm.QuickRep1.Page.Orientation:=poLandscape  ;

        RepBillFrm.lblTitle.Caption :=  StrGridPrintModule.Cols[1].Strings[CurRow];
        
        RepBillFrm.lblTitle.Left :=trunc(RepBillFrm.QuickRep1.Width /2 -  RepBillFrm.lblTitle.Width /2-20);
        RepBillFrm.lblTitle.Font :=self.lblTitle.Font  ;

        RepBillFrm.PdrawGrid :=self.ChkDrawGrid.Checked ;

        FhlKnl1.Cf_SetDbGrid_PRT (modelID,GridPrt );
        for i:=0 to TModelDbGrid(FGrid).Columns.Count -1 do
        begin
          CunCol:= TChyColumn ( TModelDbGrid(GridPrt).GetColbyFieldName( FGrid.Columns[i].FieldName ) ) ;
           if  CunCol<>nil then
            if TChyColumn(  FGrid.Columns[i])<>nil then
                CunCol.GroupValue :=TChyColumn(  FGrid.Columns[i]).GroupValue ;
        end;
        GridPrt.NeedSumRow := TModelDbGrid(FGrid).NeedSumRow ;

        RepBillFrm.SetBillRep(self.FTopBoxID,self.FPrintId ,self.FBtmBoxID ,modelID ,self.FContentDataSet , GridPrt ); // fgrid

        for i:=  RepBillFrm.ColumnHeaderBand1.ControlCount -1 downto 0 do
        begin
            if not RepBillFrm.ColumnHeaderBand1.Controls[i].Visible then
               RepBillFrm.ColumnHeaderBand1.Controls[i].Free ;
        end;
        
        RepBillFrm.QuickRep1.Preview;          //纸张设置
      finally
        GridPrt.DataSource.DataSet.EnableControls ;
        FreeAndNil(GridPrt);
        FreeAndNil(RepBillFrm);
      end;
end;

end.

