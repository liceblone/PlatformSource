unit UnitDBFile;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,DBCtrls, DB, ADODB,Menus, ZLib ,Mask, ExtCtrls,StrUtils;

  type TDBFile=class(TCustomEdit)


    FDataLink: TFieldDataLink;
    FSaveDialog:TSaveDialog;
    FOpenDialog:TOpenDialog;

    FpopupMenu:TpopupMenu;
    FMenuSaveAs:TMenuItem;
    FMenuOpen:TMenuItem;


    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);

    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure FileSaveAs(sender:Tobject);
    procedure FileOpen(sender:Tobject);

    procedure MenuPopUp(sender:Tobject);

    procedure WndProc(var Message:TMessage); override;



  public
    constructor Create(AOwner: TComponent); override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    destructor Destroy; override;
    property Field: TField read GetField;
    procedure CompressStream(V: Tmemorystream);
    procedure DeCompressStream(V: Tmemorystream);
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    private
        FFileName:string;
    FAttribution:string;
  end;

implementation

procedure TDBFile.CMExit(var Message: TCMExit);
begin
begin

  try
    if Assigned(DataSource) and Assigned(DataSource.DataSet) and
       (DataSource.DataSet.State in [dsInsert, dsEdit]) then
      self.UpdateData(self);
  except
   self.SetFocus ;
    raise;
  end;
  Invalidate; { Erase the focus marker }
  inherited;

end;
end;

procedure TDBFile.CompressStream(V: Tmemorystream);
var
  mysize: integer;
  myCompression: TCompressionStream;
  temp: Tmemorystream;
begin
  mysize := v.Size;
  temp := Tmemorystream.Create;
  myCompression := TCompressionStream.Create(cldefault, temp);
  v.SaveToStream(myCompression);
  freeandnil(myCompression);
  v.Clear;
  v.WriteBuffer(mysize, sizeof(mysize));
  temp.SaveToStream(v);
  freeandnil(temp);
end;


procedure TDBFile.DeCompressStream(V: Tmemorystream);
var
  mysize: integer;
  myUNCompression: TDecompressionStream;
  temp: pchar;

begin
  mysize:=0;
  v.ReadBuffer(mysize, sizeof(mysize));
  myUNCompression := TDecompressionStream.Create(v);
  getmem(temp, mysize);
  myUNCompression.ReadBuffer(temp^, mysize);
  freeandnil(myUNCompression);
  v.Clear;

  v.WriteBuffer(temp^, mysize);
  
  freemem(temp);
end;




constructor TDBFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];// + [csFramed];;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;

  FSaveDialog:=TSaveDialog.Create(self);
  FOpenDialog:=TOpenDialog.Create(self);

  FpopupMenu:=TpopupMenu.Create (self);
  FpopupMenu.OnPopup :=   MenuPopUp;
  FMenuSaveAs:=TMenuItem.Create (self);
  FMenuOpen:=TMenuItem.Create(self);
  FMenuOpen.Caption :='选择文件';
  FMenuSaveAs.Caption :='文件另存为';
  FpopupMenu.Items.Add(FMenuOpen);
  FpopupMenu.Items.Add(FMenuSaveAs);
  FMenuSaveAs.OnClick := FileSaveAs;
  FMenuOpen.OnClick := FileOpen;
  self.PopupMenu :=self.FPopupMenu ;



end;

procedure TDBFile.DataChange(Sender: TObject);
var
strm: TADOBlobStream;
begin
  strm := tadoblobstream.Create(tblobfield(self.FDataLink.DataSet.fieldbyname(self.FDataLink.FieldName )),bmread);
  strm.position :=0;
  try
    if self.FDataLink.DataSet.findfield ('F_DocumentName')<>nil then
     if self.FDataLink.DataSet.fieldbyname('F_DocumentName').AsString='' then
      self.Text := self.FDataLink.DataSet.fieldbyname('F_DocumentName').AsString ;

  finally
    strm.Free ;
  end;
end;



destructor TDBFile.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  
  inherited Destroy;


end;

procedure TDBFile.FileOpen(sender: Tobject);
var postion:integer;
begin
//
  if self.FOpenDialog.Execute then
  begin
  //FFileName:=FOpenDialog.FileName ;
        if      FOpenDialog.FileName<>'' then
        begin
            self.FFileName :=FOpenDialog.FileName ;
            postion:=    pos('.',self.FFileName )            ;
            FAttribution :=rightstr(self.FFileName , length(self.FFileName )-postion);

            if self.FDataLink.Field.DataSet.fieldbyname('F_DocumentName').AsString ='' then
            self.Text :=FOpenDialog.FileName ;

        end
        else
        begin


        end;

  end;

end;

procedure TDBFile.FileSaveAs(sender: Tobject);
var
strm: TADOBlobStream;
// var i:integer;
var TmpMemStream:TmemoryStream;
begin

  TmpMemStream:= TmemoryStream.Create ;
  strm := tadoblobstream.Create(tblobfield(self.FDataLink.DataSet.fieldbyname(self.FDataLink.FieldName )),bmread);
  strm.position :=0;

  TmpMemStream.LoadFromStream(strm) ;
  TmpMemStream.Position :=0;
  FSaveDialog.Filter  :=        self.FDataLink.Field.DataSet.FieldByName('F_attribute').AsString ;
  try
      DeCompressStream(TmpMemStream); //     解压数据
     if  TmpMemStream.Size >0 then
       if self.FSaveDialog.Execute then
         TmpMemStream.SaveToFile (FSaveDialog.FileName +'.'+FDataLink.Field.DataSet.FieldByName('F_attribute').AsString);

  finally
      TmpMemStream.Free ;
      strm.Free ;
  end;

end;

function TDBFile.GetDataField: string;
begin
  result:=self.FDataLink.FieldName ;
end;

function TDBFile.GetDataSource: TDataSource;
begin
  result:=self.FDataLink.DataSource ;
end;

function TDBFile.GetField: TField;
begin
  result:=self.FDataLink.Field ;
end;

procedure TDBFile.MenuPopUp(sender: Tobject);
var strm: TADOBlobStream;
begin
  if self.FDataLink.DataSet.State in [dsinsert,dsedit] then
     self.FMenuOpen.Enabled :=true
  else
     self.FMenuOpen.Enabled :=false;


  strm := tadoblobstream.Create(tblobfield(self.FDataLink.DataSet.fieldbyname(self.FDataLink.FieldName )),bmread);
  strm.position :=0;
  if  strm.Size >0 then
     self.FMenuSaveAs.Enabled :=true
  else
     self.FMenuSaveAs.Enabled :=false;

  strm.Free ;
end;

procedure TDBFile.SetDataField(const Value: string);
begin
self.FDataLink.FieldName :=value;
end;

procedure TDBFile.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource:=value;
end;

procedure TDBFile.UpdateData(Sender: TObject);
var
strm: TMemoryStream;
//MemAfterCompress: TMemoryStream;
begin
  strm := tmemorystream.Create ;
  strm.Position :=0;
  try
    if   (fileexists(self.FFileName )) then
    begin
        strm.LoadFromFile(self.FFileName  )  ;
        CompressStream (strm);
        if FDataLink.DataSet.State in [dsinsert,dsedit] then
        begin
           tblobfield(self.FDataLink.DataSet.FieldByName(self.FDataLink.FieldName)).LoadFromStream  (strm);
           self.FDataLink.Field.DataSet.FieldByName ('F_attribute').AsString :=  FAttribution;
           if  self.FDataLink.Field.DataSet.FieldByName ('F_DocumentName').AsString='' then
               self.Text :=self.FFileName
           else
               self.Text :=self.FDataLink.Field.DataSet.FieldByName ('F_DocumentName').AsString ;
        end
        else
           showmessage('State not in [dsinsert,dsedit] ');
    end
    else
    begin
        //

    end;
  finally
    strm.Free ; //笔者发现如strm采用tblobstream类，程序运行到该语句会出现问题
  end;

end;
procedure TDBFile.WndProc(var Message: TMessage);
begin
  if Message.Msg=Cm_Enter then
        Color:=clAqua
  else if Message.Msg=Cm_Exit then
    Color:=clWhite;
  Inherited WndProc(Message);
end;
end.



