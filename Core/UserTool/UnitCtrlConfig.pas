unit UnitCtrlConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ToolWin, DB, ADODB, Grids, DBGrids,UPublicFunction ,
  StrUtils,UPublicCtrl;

type
  TFrmCtrlConfig = class(TForm)
    tlb1: TToolBar;
    btnALLeft: TToolButton;
    btnTbALRight: TToolButton;
    btnTbALTop: TToolButton;
    btnTBVESpan: TToolButton;
    btnTbHEspan: TToolButton;
    btnTbMoveLeft: TToolButton;
    btnTbMoveRight: TToolButton;
    btnTbMoveUP: TToolButton;
    btnTbMoveDown: TToolButton;
    lbl1: TLabel;
    edMoveSpan: TEdit;
    btnSave: TToolButton;
    btnReflash: TToolButton;
    grpLeft: TGroupBox;
    spl1: TSplitter;
    dbgrdGdCtrl: TDBGrid;
    dsSet: TADODataSet;
    dsSourceCtrl: TDataSource;
    grpGrpParent: TPanel;
    imgtop: TImage;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnReflashClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnALLeftClick(Sender: TObject);
    procedure btnTbALRightClick(Sender: TObject);
    procedure btnTbALTopClick(Sender: TObject);
    procedure btnTBVESpanClick(Sender: TObject);
    procedure btnTbHEspanClick(Sender: TObject);
    procedure btnTbMoveLeftClick(Sender: TObject);
    procedure btnTbMoveRightClick(Sender: TObject);
    procedure btnTbMoveUPClick(Sender: TObject);
    procedure btnTbMoveDownClick(Sender: TObject);
    procedure imgtopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgtopMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgtopMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
          procedure chyMouseUp(Sender: TObject;    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chyMouseDown(Sender: TObject;    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgtopDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure imgtopDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure dbgrdGdCtrlMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edMoveSpanKeyPress(Sender: TObject; var Key: Char);
  private
    FBoxid: string;
    FCollector:Tstrings;
    drawing:boolean;
    oldx,oldy,newx,newy:integer;
    fstpt:Tpoint;

    procedure SetBoxId(const Value: string);
    procedure Reflash;
    procedure SavePorpertyToDataBase(sender: Tedit_Mtn);overload;   //SavePorpertyToDataBase
    procedure SavePorpertyToDataBase(sender: Tlabel_Mtn );overload;
    { Private declarations }
  public
    property boxid :string read FBoxid write SetBoxId;
    { Public declarations }
  end;

var
  FrmCtrlConfig: TFrmCtrlConfig;

implementation
      uses datamodule;
{$R *.dfm}

{ TFrmCtrlConfig }

procedure TFrmCtrlConfig.SetBoxId(const Value: string);
begin
   FBoxid := Value;
   Reflash;
end;

procedure TFrmCtrlConfig.FormDestroy(Sender: TObject);
begin
FCollector.Free ;
end;

procedure TFrmCtrlConfig.FormCreate(Sender: TObject);
begin
self.FCollector :=Tstringlist.Create ;
end;

procedure TFrmCtrlConfig.btnReflashClick(Sender: TObject);
var i:integer;
begin
   self.FCollector.Clear ;
  for i:=0 to grpGrpParent.ComponentCount-1 do
  begin
     grpGrpParent.Components [0].Free ;
  end;
  Reflash;
end;

procedure TFrmCtrlConfig.Reflash;
var fsql:string;
begin
  fsql:=' select A.* , B.f01, B.F02, B.F04,B.F05,B.F09,B.F11 from  V501  A join T102 B on A.Fldid   =B.F01  where A.Boxid=' +quotedstr(self.FBoxid )  ;

  dsSet.Connection :=FhlKnl1.Connection;
  self.dsSet.Close;
  self.dsSet.CommandText :=fsql;
  self.dsSet.Open;


  FhlKnl1.q_SetLabel_mtn ( self.boxid ,grpGrpParent,self.FCollector );
  FhlKnl1.q_SetDbCtrl_mtn(  self.boxid ,grpGrpParent,dmFrm.UserDbCtrlActLst,FCollector);
end;

procedure TFrmCtrlConfig.SavePorpertyToDataBase(sender: Tedit_Mtn );   //SavePorpertyToDataBase
var qry:Tadoquery;
var sql :string;

var actlist:Tstringlist;
begin
if sender.Color =stringtocolor('clblack')then exit;

      actlist:=Tstringlist.Create ;
      if length(sender.Hint)=4 then
          sender.Hint :=sender.Hint+',-1,-1,-1'
      else
          actlist.CommaText :=sender.Hint ;

      qry:=Tadoquery.Create (nil);
      qry.Connection :=FhlKnl1.Connection;
      sql:='select * from T502  where f02='+quotedstr(BOXID)+' and f03='+leftstr(sender.Hint,4) ;
      qry.SQL.Clear ;
      qry.SQL.Add(sql);
      qry.Open ;

      if not qry.IsEmpty then
          qry.Edit
      else
          qry.Append;

     qry.FieldByName('f02').Value:= BoxId;
     qry.FieldByName('f03').Value:= actlist[0]      ;              //sender.Hint;   //fieldID
     qry.FieldByName('f04').Value:= sender.Left;
     qry.FieldByName('f05').Value:= sender.top  ;

     qry.FieldByName('f06').Value:= sender.Width;
     qry.FieldByName('f07').Value:= sender.Height  ;
     qry.FieldByName('f08').Value:= ColorToString(sender.Color);
     qry.FieldByName('f09').Value:= sender.ReadOnly ;
     qry.FieldByName('f10').Value:= 0;                      // F10 AS PwChar,

     qry.FieldByName('f11').Value:= '';                     // f11 Hint
     qry.FieldByName('f12').Value:= inttostr(sender.tag)  ; // f12 CtrlTypeId        1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox;
     qry.FieldByName('f13').Value:= 1;                      // f13  这模块没用到   功能尚不清楚
     qry.FieldByName('f14').Value:= sender.Font.Name ;
     qry.FieldByName('f15').Value:= sender.Font.Size;

     qry.FieldByName('f16').Value:= ColorToString(sender.Font.Color  );
     qry.FieldByName('f17').Value:= sender.TabOrder;                     // f17   OrderIndex

     qry.FieldByName('f18').Value:= actlist[1] ;                     // c.F18 AS ClickId,
     qry.FieldByName('f19').Value:= actlist[2];                      // c.F19 AS DblClickId,
     qry.FieldByName('f20').Value:= actlist[3];                      // c.F20 AS ExitId,

     qry.FieldByName('f21').Value:= '';                      //  c.F21 AS LoginId,

     if (sender as  Tedit_Mtn ).isUserMode then
     qry.FieldByName('f300').Value:= '1';



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

procedure TFrmCtrlConfig.SavePorpertyToDataBase(sender: Tlabel_Mtn);
var qry:Tadoquery;
sql:string; 
begin
if sender.Color =stringtocolor('clblack') then exit;

    qry:=Tadoquery.Create (nil);
    qry.Connection :=FhlKnl1.Connection;
    if BOXID='' then
    begin
        showmessage('BOXID 为空');
        exit;
    end;

    sql:='select *from t503 where f02 ='+quotedstr(BOXID )+' and f03='+quotedstr(Tlabel(sender).Caption  );
    qry.SQL.Clear ;
    qry.SQL.Add(sql);
    qry.Open;
    if not qry.IsEmpty then
      qry.Edit
    else
     qry.Append;

     qry.FieldByName('f02').Value:= BoxId;
     qry.FieldByName('f03').Value:= sender.Caption ;
     qry.FieldByName('f04').Value:= sender.Left;
     qry.FieldByName('f05').Value:= sender.top  ;

     qry.FieldByName('f06').Value:= ColorToString(sender.color);
     qry.FieldByName('f07').Value:= sender.Transparent  ;
     qry.FieldByName('f08').Value:= sender.Font.Name ;
     qry.FieldByName('f09').Value:= sender.Font.Size ;
     qry.FieldByName('f10').Value:= ColorToString(sender.Font.Color );
     

     if   fsBold in    sender.Font.Style then
          qry.FieldByName('f11').Value:= 1
     else
          qry.FieldByName('f11').Value:= 0;

     if   fsUnderline in    sender.Font.Style then
          qry.FieldByName('f12').Value:=  1
     else
          qry.FieldByName('f12').Value:=0;

     if (sender as  Tlabel_Mtn).isUserMode then
     qry.FieldByName('f300').Value:= '1';

    try
          qry.Post ;
         qry.Free;
    except
        on err:exception do
        begin
            showmessage(err.Message );
            qry.Free;
        end;
    end;

end;

procedure TFrmCtrlConfig.btnSaveClick(Sender: TObject);
var i:integer;
var grpbox:Tpanel;

var Lst:Tstringlist;
begin
Lst:=Tstringlist.Create ;

   grpbox:=grpGrpParent ;

try dmFrm.ADOConnection1.BeginTrans   ;
    for i:=0 to grpbox.controlcount-1 do
    begin
           if (grpbox.controls[i] is TEdit) then
           begin
              Lst.CommaText :=   (grpbox.controls[i] as TEdit).Hint;
              if  isinteger( Lst[0] )then  //if  the hint is fieldID  then continue else break. fieldID is integer
              SavePorpertyToDataBase(grpbox.controls[i] as Tedit_Mtn)
              else
              break
           end;
           if  (grpbox.controls[i] is Tlabel) then
           SavePorpertyToDataBase ( grpbox.controls[i] as Tlabel_Mtn );
    end;

    dmFrm.ADOConnection1.CommitTrans ;
     self.Caption := self.Caption +'控键  保存成功';
except
    dmFrm.ADOConnection1.RollbackTrans ;
end;
end;

procedure TFrmCtrlConfig.btnALLeftClick(Sender: TObject);
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

procedure TFrmCtrlConfig.btnTbALRightClick(Sender: TObject);
var i:integer;
var firstleft,firstwidth:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          firstleft := tcontrol( self.FCollector.Objects [0]).Left;
          firstwidth:= tcontrol( self.FCollector.Objects [0]).width;

          for i:=0 to self.FCollector.Count -1 do
          begin
            if ( tcontrol( self.FCollector.Objects [i]) is Tlabel_Mtn)  then
               ( tcontrol( self.FCollector.Objects [i]) as tlabel).Font.Style := ( tcontrol( self.FCollector.Objects [i]) as tlabel).Font.Style   -[fsBold];
          end;

          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Left :=  firstleft+(firstwidth- tcontrol( self.FCollector.Objects [i]).width);

             if ( tcontrol( self.FCollector.Objects [i]) is Tlabel_Mtn)  then
                ( tcontrol( self.FCollector.Objects [i]) as tlabel).Font.Style := ( tcontrol( self.FCollector.Objects [i]) as tlabel).Font.Style   +[fsBold];
          end;
    end;
end;
procedure TFrmCtrlConfig.btnTbALTopClick(Sender: TObject);
var i:integer;
var firstTop:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          firstTop :=tcontrol( self.FCollector.Objects [0]).Top ;
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Top  :=  firstTop;
          end;
    end;
end;

procedure TFrmCtrlConfig.btnTBVESpanClick(Sender: TObject);
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

procedure TFrmCtrlConfig.btnTbHEspanClick(Sender: TObject);
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

procedure TFrmCtrlConfig.btnTbMoveLeftClick(Sender: TObject);
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
        for i:=0 to  grpGrpParent.ControlCount  -1 do
        begin
            (grpGrpParent.Controls[i] as Tcontrol).Left:=(grpGrpParent.Controls[i] as Tcontrol).Left-strtoint(edMoveSpan.Text );

        end;
    end;
end;

procedure TFrmCtrlConfig.btnTbMoveRightClick(Sender: TObject);
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
        for i:=0 to  grpGrpParent.ControlCount  -1 do
        begin
            (grpGrpParent.Controls[i] as Tcontrol).Left :=(grpGrpParent.Controls[i] as Tcontrol).Left+strtoint(edMoveSpan.Text );
        end;
    end;
end;


procedure TFrmCtrlConfig.btnTbMoveUPClick(Sender: TObject);
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
        for i:=0 to  grpGrpParent.ControlCount  -1 do
        begin
            (grpGrpParent.Controls[i] as Tcontrol).Top  :=(grpGrpParent.Controls[i] as Tcontrol).Top -strtoint(edMoveSpan.Text );
        end;
    end;
end;


procedure TFrmCtrlConfig.btnTbMoveDownClick(Sender: TObject);
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
        for i:=0 to  grpGrpParent.ControlCount  -1 do
        begin
            (grpGrpParent.Controls[i] as Tcontrol).Top  :=(grpGrpParent.Controls[i] as Tcontrol).Top +strtoint(edMoveSpan.Text );
        end;
    end;
end;


procedure TFrmCtrlConfig.imgtopMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var MButton2: TMouseButton;
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
      MButton2:= mbLeft;
      Shift2 :=[ssleft	];
      for i:=0 to self.grpGrpParent.ComponentCount -1 do
      begin
      chyMouseUp(Twincontrol(grpGrpParent.Components[i]),MButton2, Shift2,x,y);
      end;
    end;
end;    

procedure TFrmCtrlConfig.imgtopMouseMove(Sender: TObject;
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

procedure TFrmCtrlConfig.imgtopMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
var mmButton2: TMouseButton;
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

   mmButton2:= mbLeft;
   Shift2 :=[ ssshift ,ssleft	];
   for i:=0 to self.grpGrpParent.ComponentCount -1 do
   begin
       if (
                (Twincontrol(grpGrpParent.Components[i]).top   >yo  )
            and (Twincontrol(grpGrpParent.Components[i]).Top   <yn+10)
            and (Twincontrol(grpGrpParent.Components[i]).left   >xo   )
            and (Twincontrol(grpGrpParent.Components[i]).left <xn+10 )
          ) then
        chyMouseDown(grpGrpParent.Components[i],mmButton2,  Shift2,0,0); { }
   end;
end;

procedure TFrmCtrlConfig.chyMouseDown(Sender: TObject;
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


end;

procedure TFrmCtrlConfig.chyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
   var i:integer;
begin
if FCollector=nil then exit       ;


    if ( Sender is tlabel) then
    begin

         if    (Shift <>[ ssshift 	]	)  then
         begin
                 (  Sender as tlabel_mtn).Cursor  :=crdefault;
                 (  Sender as tlabel_mtn).Font.Style :=  (  Sender as tlabel_mtn).Font.Style  -[fsBold];
              if( Sender as tlabel_mtn).FCollector<>nil then
              begin
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

    end;

    if ( Sender is Tedit_Mtn) then
    begin
         if    (Shift <>[ ssshift 	]	)  then
         begin
              ( Sender as Tedit_Mtn).Ctl3D :=false;
              ( Sender as Tedit_Mtn).Cursor  :=crdefault;
              ( Sender as Tedit_Mtn).Font.Style  :=( Sender as Tedit_Mtn).Font.Style-[fsBold];

              if( Sender as Tedit_Mtn).FCollector<>nil then
              begin
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

end;

procedure TFrmCtrlConfig.imgtopDragDrop(Sender, Source: TObject; X,
  Y: Integer);

var lbl:Tlabel_Mtn;
var CTRL:Tedit_Mtn;
var FieldType:integer;
var FieldKind :string;
var picklist:string;
var name:string;
begin
      if    Source is   TDBGrid  then
      begin
            lbl:=Tlabel_Mtn.Create(grpGrpParent);
            lbl.isUserMode:=True;
            lbl.Parent :=grpGrpParent;
            lbl.Left :=x;
            lbl.Top :=y;
            name:=self.dsSet .FieldValues ['f01'];;
            lbl.Caption :=self.dsSet .FieldValues ['f09'];
            lbl.OnDblClick :=FhlKnl1.DblClick_Ex  ;
            lbl.Visible :=true;
            lbl.Hint :='0'         ;
            lbl.Font.Name :='宋体';
            lbl.Font.Size:=10;

            CTRL:=Tedit_Mtn.Create (grpGrpParent);
            CTRL.isUserMode:=True;
            CTRL.Parent :=grpGrpParent;
            CTRL.Left :=x+lbl.Width +10;
            CTRL.Top :=y ;
            CTRL.ShowHint :=true;
            CTRL.Hint := name+','+dsSet.Fieldbyname ('ClickID').AsString +','+dsSet.Fieldbyname ('DblClickid').AsString +','+dsSet.Fieldbyname ('Exitid').AsString ;
            CTRL.Text := self.dsSet .FieldValues ['f02'];;
            CTRL.Visible :=true;

            CTRL.OnDblClick := FhlKnl1.DblClick_Ex;
            FieldType:=dsSet.FieldValues ['f04'];
            FieldKind:=dsSet.Fieldbyname ('f05').AsString ;
            picklist:=dsSet.Fieldbyname ('F11').AsString ;

            CTRL.ReadOnly :=dsSet.Fieldbyname ('readonly').AsBoolean; 
            CTRL.Tag :=dsSet.Fieldbyname ('CtrlTypeId').AsInteger  ;
            //1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox;  13 TDbImage
//             0 :cftString  1 :cftDate  2 :cftDateTime  3 :cftBoolean  4 :cftFloat  5 :cftCurrency  6 :cftMemo  7 :cftBlob  8 :cftBytes  9 :cftAutoInc  10:cftInteger  11:cftImage  12:cftLargeint
            
      end;
end;

procedure TFrmCtrlConfig.imgtopDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     if  Source is TDBGrid  then
Accept:=true;
end;

procedure TFrmCtrlConfig.dbgrdGdCtrlMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if shift= [ssLeft] then
TDBGrid(Sender) .BeginDrag(true);
end;

procedure TFrmCtrlConfig.edMoveSpanKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (Key in (['0'..'9'])) then
    Key:=#0;
end;

end.
