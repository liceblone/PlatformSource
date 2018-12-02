unit UnitEditCtrl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,UPublicCtrl,datamodule, ActnList;

type
  TFrmEditCtrl = class(TForm)
    grpTool: TGroupBox;
    spl1: TSplitter;
    grpparent: TGroupBox;
    btnCreate: TButton;
    btnClear: TButton;
    btnsave: TButton;
    lbledtLintCnt: TLabeledEdit;
    lbledtPosX: TLabeledEdit;
    lbledtPosy: TLabeledEdit;
    lbledtgap: TLabeledEdit;
    lbledtCtrlGap: TLabeledEdit;
    lbledtGapY: TLabeledEdit;
    lbledtLabelFont: TLabeledEdit;
    lbledtFont: TLabeledEdit;
    dlgFontFont: TFontDialog;
    actlst1: TActionList;
    actChangeFont: TAction;
    actChgALblFont: TAction;
    procedure btnCreateClick(Sender: TObject);
    procedure actChangeFontExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DatasetID,boxID:string;
  end;

var
  FrmEditCtrl: TFrmEditCtrl;

implementation

{$R *.dfm}

procedure TFrmEditCtrl.btnCreateClick(Sender: TObject);
  var lbl:array of Tlabel;
  var CTRL:array of Tedit_Mtn;
  var FieldType:integer;
  var FieldKind :string;
  var picklist:string;
name:string;

  var cntpL,i,j,x,y :integer;
begin

fhlknl1.Kl_GetQuery2('select * from V201 where datasetid='+self.DatasetID  );

if   fhlknl1.FreeQuery.IsEmpty then
exit;


            dmfrm.actClearCtrls.Execute ;


            cntpL:=strtoint(lbledtLintCnt.Text );
            y:=strtoint(lbledtPosy.Text );
            x:=strtoint(lbledtPosx.Text );
            j:=0;

            setlength(lbl,fhlknl1.FreeQuery.RecordCount );
            setlength(CTRL,fhlknl1.FreeQuery.RecordCount );





         for i:=0 to  fhlknl1.FreeQuery.RecordCount-1 do
            begin

                  if ((i mod cntpL)=0  )and (i>0)then
                  begin
                   y:=y+strtoint(lbledtGapY.Text );
                  end;



                  lbl[i]:=Tlabel_Mtn.Create(self.grpparent);
                  lbl[i].Parent :=grpparent;

                  name:=fhlknl1.FreeQuery. fieldbyname('name').asstring;
                  lbl[i].Caption :=fhlknl1.FreeQuery. fieldbyname('label').asstring;
              //    lbl[i].OnDblClick := DblClick_Ex;
                  lbl[i].Visible :=true;
                  lbl[i].Hint :='0'         ;
                  lbl[i].Font.Size:=strtoint(lbledtLabelFont.text );
                  lbl[i].Width :=lbl[i].Width +20;
                  if i>=cntpL then
                  lbl[i].Left :=lbl[i-cntpL].Left+ (  lbl[i-cntpL].width   -lbl[i].width  )
                  else
                  lbl[i].Left :=x;

                  lbl[i].Top :=y;

                  CTRL[i]:=Tedit_Mtn.Create (grpparent);
                  CTRL[i].Parent :=grpparent;
                  CTRL[i].Left :=lbl[i].left +lbl[i].width+strtoint(lbledtCtrlGap.Text );
                  CTRL[i].Top :=y-3;
                  CTRL[i].ShowHint :=true;
                  CTRL[i].Hint := name+',-1,-1,-1';
                  CTRL[i].Text := name;
                  CTRL[i].Visible :=true;

              //    CTRL[i].OnDblClick := DblClick_Ex;
                  FieldType:=fhlknl1.FreeQuery. fieldbyname('Typeid').AsInteger ;
                  FieldKind:=fhlknl1.FreeQuery. fieldbyname('Kindid').asstring;
                  picklist:=fhlknl1.FreeQuery. fieldbyname('picklist').asstring;



                  case FieldType of
                  0:begin
                         if  FieldKind='l' then
                           CTRL[i].Tag :=5;

                          if picklist<>'' then
                          begin
                            CTRL[i].Tag:=12;
                          end
                          else
                           CTRL[i].Tag :=1;
                    end;
                  4,5,10:        CTRL[i].Tag :=1;
                  1,2  :         CTRL[i].Tag :=9;
                  3:             CTRL[i].Tag :=7;
                  6:             CTRL[i].Tag :=6;
                  7 :            CTRL[i].Tag :=13;
                  end;


                  x:=CTRL[i].Left +CTRL[i].Width +strtoint(lbledtgap.Text ) ;

                  fhlknl1.FreeQuery.Next ;

            end;





end;


procedure TFrmEditCtrl.actChangeFontExecute(Sender: TObject);
begin
if dlgFontFont.Execute then


end;

end.
