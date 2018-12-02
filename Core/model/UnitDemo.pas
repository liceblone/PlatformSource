unit UnitDemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,datamodule, Menus, ComCtrls, ExtCtrls, ExtDlgs, StdCtrls;

type TTabSheetImg=class(TTabSheet)
     Img:Timage;
     constructor Create (AOwner: TComponent);override;
     destructor Destroy ;override;
end      ;

type TDictDemo=record
    formId:integer;
    Count:integer;
    Images:string;
    FormName:string;
    width:integer;
    height:integer;
    left:integer;
    Top:integer;

    defaultPage:integer;
end;

type
  TFrmDemo = class(TForm)
    imgMain: TImage;
    pgc: TPageControl;
    pmDemo: TPopupMenu;
    save: TMenuItem;
    GetPic: TMenuItem;
    PriView: TMenuItem;
    dlgOpenPicDemo: TOpenPictureDialog;
    addPage: TMenuItem;
    procedure pgcChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PriViewClick(Sender: TObject);
    procedure GetPicClick(Sender: TObject);
    procedure saveClick(Sender: TObject);
    procedure addPageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     DictDemo:  TDictDemo;
     Imagelist:Tstringlist;
     Tabs:array of TTabSheetImg;

     procedure GetDict(var DictDemo:  TDictDemo;frmID:integer);
     procedure initFrm(FormID:integer);
     procedure imgdbClick(sender:Tobject);
  end;

var
  FrmDemo: TFrmDemo;

implementation

{$R *.dfm}

procedure TFrmDemo.GetDict(var DictDemo: TDictDemo;frmID:integer);
begin
fhlknl1.Kl_GetQuery2('select * from TDemo where F01='+inttostr(frmID));
DictDemo.formId   :=frmID;
DictDemo.Count :=fhlknl1.FreeQuery.fieldbyname('F02').AsInteger ;
DictDemo.Images  :=fhlknl1.FreeQuery.fieldbyname('F03').AsString ;
DictDemo.FormName   :=fhlknl1.FreeQuery.fieldbyname('F04').AsString ;

DictDemo.width :=fhlknl1.FreeQuery.fieldbyname('F05').AsInteger ;
DictDemo.height :=fhlknl1.FreeQuery.fieldbyname('F06').AsInteger ;

DictDemo.left :=fhlknl1.FreeQuery.fieldbyname('F07').AsInteger ;
DictDemo.top:=fhlknl1.FreeQuery.fieldbyname('F08').AsInteger ;
DictDemo.defaultPage :=fhlknl1.FreeQuery.fieldbyname('F08').AsInteger ;
end;

procedure TFrmDemo.imgdbClick(sender: Tobject);
begin



if self.dlgOpenPicDemo.Execute then
   if    self.dlgOpenPicDemo.FileName<>'' then
   begin
     TTabSheetImg(Timage(sender).Parent ).Caption :=ExtractFileName  (self.dlgOpenPicDemo.FileName);
     Timage(sender).Picture.LoadFromFile(self.dlgOpenPicDemo.FileName );


   end;
end;

procedure TFrmDemo.initFrm(FormID: integer);
var i:integer;

begin

      self.GetDict(self.DictDemo ,FormID);
      Imagelist:=Tstringlist.Create ;
      Imagelist.CommaText :=  DictDemo.Images ;


      if  DictDemo.Count =0 then DictDemo.Count :=1;

      setlength(Tabs,DictDemo.Count) ;

      for i:=0 to self.DictDemo.Count-1 do
      begin
        Tabs[i]:=TTabSheetImg.Create(pgc);
        Tabs[i].PageControl:=pgc;
        if  Imagelist.Count >0 then
        begin
            Tabs[i].Caption :=Imagelist[i];
            //ExtractFilePath          ExtractFileName
             if    fileexists( ExtractFilePath  (application.ExeName )+'demoPic\'+ Imagelist[i] ) then
                 Tabs[i].Img.Picture.LoadFromFile(ExtractFilePath  (application.ExeName )+'demoPic\'+ Imagelist[i] )
             else
                  showmessage( ExtractFilePath  (application.ExeName )+'demoPic\'+ Imagelist[i] +'  文件不存在');


        end;
        Tabs[i].Img.OnDblClick :=  imgdbClick;
      end;

    if  Tabs[0].Img.Picture <>nil then
      begin

         self.imgMain.Picture:=Tabs[0].Img.Picture;
          self.pgc.Visible :=false; {  }
         self.Width :=self.DictDemo.width ;
         self.height :=self.DictDemo.height ;
          self.Left := self.DictDemo.left ;
         self.top := self.DictDemo.top ;


      end; 

end;

procedure TFrmDemo.pgcChange(Sender: TObject);
begin

end;

{ TTabSheetImg }

constructor TTabSheetImg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner) ;
  img:=Timage.Create(self);
  img.Parent:=self;
  img.Align :=alClient;
  img.Stretch :=true;

end;

destructor TTabSheetImg.Destroy;
begin
   img.Free ;
  inherited;
end;

procedure TFrmDemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmDemo.PriViewClick(Sender: TObject);
begin
self.imgMain.Picture:=(      TTabSheetImg(self.pgc.ActivePage).Img .Picture );
 pgc.Visible :=false;
end;

procedure TFrmDemo.GetPicClick(Sender: TObject);
begin
 pgc.Visible :=true;
end;

procedure TFrmDemo.saveClick(Sender: TObject);
var i:integer;
var imgNames:string;

begin
    imgNames:='';
   for i:=0 to   self.pgc.PageCount -1      do
        begin
            if i=0 then
            imgNames:=self.pgc.Pages[i].Caption
            else
           imgNames:=imgNames+','+ self.pgc.Pages[i].Caption;
        end;

    fhlknl1.Kl_GetQuery2('select * from TDemo where f01='+inttostr(self.DictDemo.formId ),true,true);

    if fhlknl1.FreeQuery.IsEmpty then
    begin
    fhlknl1.FreeQuery.Append       ;
     fhlknl1.FreeQuery.FieldByName('F01').AsInteger:= self.DictDemo.formId;
    end
    else
    fhlknl1.FreeQuery.edit ;

    fhlknl1.FreeQuery.FieldByName('F02').AsInteger  :=self.pgc.PageCount ;
    fhlknl1.FreeQuery.FieldByName('F03').AsString   :=imgNames;
    fhlknl1.FreeQuery.FieldByName('F04').AsString   :=self.Caption ;
    fhlknl1.FreeQuery.FieldByName('F05').asinteger   :=self.Width ;
    fhlknl1.FreeQuery.FieldByName('F06').asinteger   :=self.Height ;
    fhlknl1.FreeQuery.FieldByName('F07').asinteger   :=self.left ;
    fhlknl1.FreeQuery.FieldByName('F08').asinteger   :=self.top ;
    fhlknl1.FreeQuery.Post ;
end;

procedure TFrmDemo.addPageClick(Sender: TObject);
begin
    self.pgc.Visible :=true;

    inc(self.DictDemo.Count );
    setlength(self.Tabs,self.DictDemo.Count );
    Tabs[self.DictDemo.Count -1]:=TTabSheetImg.Create(pgc);
    Tabs[self.DictDemo.Count -1].PageControl:=pgc;
    Tabs[self.DictDemo.Count -1].Img.OnDblClick :=  imgdbClick;
end;

end.
