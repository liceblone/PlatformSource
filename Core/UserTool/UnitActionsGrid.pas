unit UnitActionsGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ActnList, ComCtrls, ImgList, ExtCtrls,StrUtils;

type
  TFrmActions = class(TForm)
    PnlLeft: TPanel;
    CombSelectMolde: TListBox;
    pnlRight: TPanel;
    F: TPageControl;
    ts1: TTabSheet;
    ActionGrid: TStringGrid;
    TabSheet1: TTabSheet;
    TreeView1: TTreeView;
    btnCancel: TButton;
    btnConfirm: TButton;
    Splitter1: TSplitter;
    procedure InitFrm(Actionlist:Tactionlist;Filter:string='';catogary:string='');
    procedure InitFrmImageLst(ImageList:TImageList );
    procedure ActionGridClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1DblClick(Sender: TObject);
    procedure CombSelectMoldeClick(Sender: TObject);
  private
    { Private declarations }
  procedure Exchange(fRow:Integer);
  public
    { Public declarations }
    SelectedIndex:integer;
    ImageSelIndex:string;
  end;

var
  FrmActions: TFrmActions;

Const o1='   °Ã';
      o2='';
implementation
         uses datamodule,UnitModelFrm,
         Editor,TreeEditor,TreeGrid ,UnitFrmAnalyserEx  ,UnitBillEx,UnitCrmMain  ,UnitLookUpImport
         ;
{$R *.dfm}

procedure TFrmActions.Exchange(fRow:Integer);
begin
 if ActionGrid.Cells[2,fRow]=o1 then
 begin
    ActionGrid.Cells[2,fRow]:=o2;
    SelectedIndex:=-1;
   
 end
 else
 begin
    if ActionGrid.Cells[3,fRow]<>'' then
        SelectedIndex:=strtoint(ActionGrid.Cells[3,fRow])
    else
        SelectedIndex:=-1;
    ActionGrid.Cells[2,fRow]:=o1;
 end;
end;
procedure TFrmActions.InitFrm(Actionlist:Tactionlist;Filter:string='';catogary:string='');
 var i,j,currow:integer;
var StrLst:Tstringlist;
begin

    currow:=0;
    StrLst:=Tstringlist.Create ;
    StrLst.CommaText:=Filter;

    for i:=0 to  ActionGrid.RowCount -1 do
    begin
        ActionGrid.Rows[i].Clear;
    end;
    

   self.ActionGrid.RowCount :=Actionlist.ActionCount ;
   //

   with Actionlist do
     for i:=0 to ActionCount-1 do begin

         if   Actions[i].Category = catogary then
         begin
             ActionGrid.Cols[0].Append(Actions[i].Name );
             ActionGrid.Cols[1].Append(Taction(Actionlist.Actions [i]).caption);
             ActionGrid.Cols[4].Append(inttostr( Actions[i].Tag  ));

             if   StrLst.Count=0 then
             begin
             ActionGrid.Cells [3,currow] :=inttostr(i);
             currow :=currow+1;
             end
             else
                for j:=0 to StrLst.Count -1 do
                 begin
                     if  i=  strtoint(StrLst[j]) then
                     ActionGrid.Cells [3,i]:=inttostr(i);
                 end;

         end;
     end;
     if assigned(StrLst)  then   StrLst.Free ;
end;

procedure TFrmActions.ActionGridClick(Sender: TObject);
begin
  ExChange(ActionGrid.Selection.Top);
end;

procedure TFrmActions.FormCreate(Sender: TObject);
begin
self.SelectedIndex :=-1;
end;

procedure TFrmActions.InitFrmImageLst(ImageList: TImageList);
var i:integer;
var bitmap:Tbitmap;
begin

{ for i:=0 to   ImageList.Count -1 do
 begin
   ImageList.GetBitmap(i,bitmap)    ;
   LstImage.Items.AddObject(inttostr(i),bitmap)  ;
   //      LstImage.AddItem(inttostr(i),bitmap)        ;

 end;
 }
 for i:=0 to   ImageList.Count -1 do
 begin
  FhlKnl1.Tv_NewDataNode(Treeview1,nil,'','   '+inttostr(i),i,i);
  end;
end;

procedure TFrmActions.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
ImageSelIndex:=node.Text ;
end;

procedure TFrmActions.TreeView1DblClick(Sender: TObject);
begin
btnConfirm.Click;
end;

procedure TFrmActions.CombSelectMoldeClick(Sender: TObject);
var i:integer;
var values:string;
var ModelTable:string;
var form:TForm;
var actions:Tstrings;
begin
     actions:=Tstringlist.Create ;
     if    CombSelectMolde.Items[CombSelectMolde.ItemIndex ] <>'' then

        ModelTable:=leftstr(   CombSelectMolde.Items[CombSelectMolde.ItemIndex ]  ,4);
     //bill
     if uppercase(ModelTable)  ='T602' then
     begin
             form:=TTreeGridfrm.Create(nil);
             form.Caption :='bill';
             InitFrm(TTreeGridfrm(form).ActionList1  );
             form.free;
     end;
     //TreeGrid
     if uppercase(ModelTable)  ='T612' then
     begin
             if        messagedlg(' π”√treeGrid?',mtInformation,[mbYes,mbNo],0 )=mryes then  //because crm model have used T612
             begin
                 form:=TTreeGridfrm.Create(nil);
                 form.Caption :='TreeGrid';
                 InitFrm(TTreeGridfrm(form).ActionList1  );
                 form.free;
             end
             else
             ModelTable:='T700';
     end;
// T616 cfg_editor
     if uppercase(ModelTable)  ='T616' then
     begin
             form:=TEditorFrm.Create(nil);
             form.Caption :='cfg_editor';
             InitFrm(TEditorFrm(form).ActionList1  );
             form.free;
     end;
// T611	cfg_TreeEditor
     if uppercase(ModelTable)  ='T611' then
     begin
         exit;
     end;

// T601	cfg_analyser
     if uppercase(ModelTable)  ='T601' then
     begin
             form.Caption :='cfg_analyser';
             form:=TAnalyseEx.Create(nil);
             InitFrm(TAnalyseEx(form).ActionList1  );
             form.free;
     end;

// T700	cfg_CRm TFrmCrm
     if uppercase(ModelTable)  ='T700' then
     begin
             form.Caption :='cfg_CRm';
             form:=TFrmCrm.Create(nil);
             InitFrm(TFrmCrm(form).actlstCRM   );
             form.free;
     end;
     // T625	cfg_billex
     if uppercase(ModelTable)  ='T625' then
     begin
             form.Caption :='FrmBillEx';
             form:=TFrmBillEx.Create(nil);
             InitFrm(TFrmBillEx(form).ActionList1    );
             form.free;
     end;
// T627	cfg_FrmOpenImport
     if uppercase(ModelTable)  ='T627' then
     begin
             form.Caption :='FrmOpenImport';
             form:=TFrmLoopUpImPortEx.Create(nil);
             InitFrm(TFrmLoopUpImPortEx(form).ActionList1    );
             form.free;
     end;
// T628	cfg_FrmSerialNos
     if uppercase(ModelTable)  ='T628' then
     begin
          //   form.Caption :='FrmOpenImport';
          ////   form:=TFrmSerialNos.Create(nil);
          //   FrmActions.InitFrm(TFrmSerialNos(form).ActionList1    );
          //   form.free;
     end;


     if (uppercase(ModelTable)  <>'T627')and (uppercase(ModelTable)  <>'T628') and (uppercase(ModelTable)  <>'T625')  then
     for i:=0 to  actions.Count-1 do
     begin
         if ( actions.Strings [i]<>'' ) and (actions.Strings [i]<>'-1') then
         if  ActionGrid.RowCount >   strtoint(actions.Strings [i]) then
         ActionGrid.Cells [2,strtoint(actions.Strings [i])]:='   °Ã';
     end;

     actions.Free;
end;

end.
