unit UPublicCtrl;

interface
 uses     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,UnitAdoDataset,StdCtrls,Buttons,ExtCtrls,DBCtrls,Menus,winsock,UnitGrid,
  ComCtrls,ADODB,Grids,Editor,UPublicFunction,
   DB,FhlKnl,datamodule,DBGrids,ActnList;

type Tedit_Mtn= class(TEdit)
  private
    FDown:boolean;
    FOldX : TPoint;
    FOldY : TPoint;
    FRectList: array[1..8] of TRect;
    FPosList: array[1..8] of Integer;
    FisUserMode: Boolean;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WmNcHitTest(var Msg: TWmNcHitTest); message wm_NcHitTest;
    procedure WmSize(var Msg: TWmSize); message wm_Size;
    procedure SetisUserMode(const Value: Boolean);

  public
    FCollector:Tstrings;
    BoxId:string;        //记录boxid，删除控键时用到  2006-5-8
    FieldID        :integer;
    DataSourceType :Integer;    // 0 as maindataset  , 1 as dlgrid  dl
    constructor Create(AOwner: TComponent); override;
    property isUserMode:Boolean read FisUserMode write SetisUserMode default False;
end;

type Tlabel_Mtn= class(Tlabel)
  private
    FECaption: string;
    FDown:boolean;
    FOldX : TPoint;
    FOldY : TPoint;
    FRectList: array[1..8] of TRect;
    FPosList: array[1..8] of Integer;
    FisUserMode: Boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WmNcHitTest(var Msg: TWmNcHitTest); message wm_NcHitTest;
    procedure WmSize(var Msg: TWmSize); message wm_Size;
    procedure SetisUserMode(const Value: Boolean);
  public
    FCollector:Tstrings;
    BoxId:string;        //记录boxid，删除控键时用到  2006-5-8

    constructor Create(AOwner: TComponent); override;
    Procedure SetCollector(value:Tstrings);
    property  isUserMode:Boolean read FisUserMode write SetisUserMode default False;
    property  ECaption :string read FECaption write FECaption;
end;

type TDbRadioGroup_Mtn= class(TDbRadioGroup)
private
    FDown:boolean;
    FOldX : TPoint;
    FOldY : TPoint;
    FRectList: array[1..8] of TRect;
    FPosList: array[1..8] of Integer;
    FisUserMode: Boolean;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WmNcHitTest(var Msg: TWmNcHitTest); message wm_NcHitTest;
    procedure WmSize(var Msg: TWmSize); message wm_Size;
    procedure SetisUserMode(const Value: Boolean);

  public
    BoxId:string;        //记录boxid，删除控键时用到  2006-5-8
    constructor Create(AOwner: TComponent); override;
    property isUserMode:Boolean read FisUserMode write SetisUserMode default False;
end;

  function isinteger(value:string):boolean;
  function LocalIP:string;
  procedure GetMacAddrFromIP(const IP: String;var Mac: String);


type ModelTreeView= class(TTreeView)
  private
       FTreeID:string;
       FTreePath:string;
       FTreeCaption:string;
       FNodeDataSet1: TADODataSet;
       FCommandTextDataset:TADODataSet;
       FFhlKnl1:TFhlKnl;

       FEditorParent:TWinControl;
       FDBGrid:TdbGrid;
       fTreeGridIdField:string;
       FEditorIDField:string;
       FFhlUser:TFhlUser;
       FActionList:TActionList;
       FGridEditBtnClick:Taction;
       FUserConnection:Tadoconnection;

       FSubInterFaceID:string;

       FClassFld:string;
       SubInterFaceDict:TSubInterFaceDict;
  public

       constructor Create(Aowner:Tcomponent);override;
       destructor Destroy; override;

       procedure IniTree;
       procedure ETreeChange(Sender:Tobject; Node: TTreeNode);
       procedure SetFhlknl( PFhlKnl1:TFhlKnl);
       procedure SetFhlUser(  PFhlUser:TFhlUser);
       procedure SetUserConnection(Pconnection:Tadoconnection);

       procedure SetGridEditBtnClick(GridEditBtnClick:Taction);
       procedure SetFSubInterFaceID(PSubInterFaceID:string);
       procedure SetTreeID( TreeID:string);
       procedure SetEditorParent( PEditorParent:TWinControl);
       procedure SetFDBGrid ( PDBGrid:TDBGrid);
       procedure setTreeGridIdField (fieldName:string);
       procedure setEditorIDField(fieldName:string);
       procedure SetActionList(PActionList:TactionLIst);

       function  GetTreePath:string;

   end;

type TModelAbstractSheet=class(TTabsheet)
  private
    FWindowsFID: string;
    procedure SetWindowsFID(const Value: string);
public
    function OpenDataSet:integer;virtual;abstract;
    procedure CloseDataSet;virtual;abstract;
    procedure setUserConnection(PuserConnection:Tadoconnection);virtual;abstract;
    procedure setFMainDataset(Pdataset:Tadodataset);  virtual;abstract;
    procedure SetGridEditBtnClick(GridEditBtnClick:Taction);    virtual;abstract;
    procedure SetFhlknl( PFhlKnl1:TFhlKnl);    virtual;abstract;
    procedure SetFhlUser(  PFhlUser:TFhlUser);  virtual;abstract;
    procedure SetImageList(  PImagelist:Timagelist); virtual;abstract;
    procedure ShowEditor(sender:Tobject);    virtual;abstract;
    function  GetOpenParamFields:boolean;   virtual;abstract;
    Procedure setActionLst(PActionList:TActionList);  virtual;abstract;
    Procedure SetToolID(PtoolID:string); virtual;abstract;
    Procedure SetLoginInfo(PLoginInfo:TLoginInfo);    virtual;abstract;
    Procedure SetPopupMenu(PPopupMenu:TPopupMenu);    virtual;abstract;
    procedure ToolMenuClick(sender:Tobject);  virtual;abstract;
    procedure IniSheet;  virtual;abstract;
    property WindowsFID:string read FWindowsFID   write  SetWindowsFID;
end;



type TmodelTreeSheet=class(TModelAbstractSheet)
private
     FFhlUser:TFhlUser;
     FToolID:string;
     FLoginInfo:TLoginInfo;
     FToolPopMenu:TpopupMenu;
     FToolMenuItem:Tmenuitem;
public
     TreeView: ModelTreeView;
     Procedure dblClick(sender:Tobject);

     Procedure SetToolID(PtoolID:string);
     Procedure SetLoginInfo(PLoginInfo:TLoginInfo);
     procedure SetFhlUser(  PFhlUser:TFhlUser);
     procedure SetFhlknl( PFhlKnl1:TFhlKnl);
     procedure SetUserConnection(Pconnection:Tadoconnection);
     procedure SetGridEditBtnClick(GridEditBtnClick:Taction);
     procedure SetFSubInterFaceID(PSubInterFaceID:string);
     procedure SetTreeID(TreeID:string);
     procedure SetEditorParent( PEditorParent:TWinControl);
     procedure SetFDBGrid ( PDBGrid:TDBGrid);
     procedure setTreeGridIdField (fieldName:string);
     procedure setEditorIDField(fieldName:string);
     procedure SetActionList(PActionList:TactionLIst);
     constructor Create(Aowner:Tcomponent);override;
     destructor Destroy; override;

     published
     property ToolID:string write SetToolID;
     property LoginInfo:TLoginInfo write  SetLoginInfo;
end;

type ModelTreeGridsheet=class(TModelAbstractSheet)
private
       fDict:TTreeGridDict;
       EditorFrm:Tform  ;
       FFhlKnl1:TFhlKnl;
       FFhlUser:TFhlUser;
       FFImagelist:Timagelist;

       FAdodataset:TAdoDatasetColor;
       Fdatasource:Tdatasource;
       FGridPopupMenu:TPopupMenu;
       FGridEditBtnClick:Taction;
       FActionList:    TActionList ;//user for grid dbclick
       FmainDataset:Tadodataset;//param values
       FOpenParamFields:string;

       FuserConnection:Tadoconnection;
       FtoolID:string     ;
       FLoginInfo:TLoginInfo;
       FTreeView1:TTreeView;
       editorOpenParameterFields:string;     
public
       FGrid:TModelDbGrid;
       FMSumFieldName:string ;
       FDLSumFieldName:string;
       FDLSumFunction:string;
       Procedure SetToolID(PtoolID:string);  override ;
       Procedure SetLoginInfo(PLoginInfo:TLoginInfo);   override ;
       Procedure SetPopupMenu(PPopupMenu:TPopupMenu); override ;
       Procedure setActionLst(PActionList:TActionList);  override ;
       procedure ToolMenuClick(sender:Tobject);  override ;
       procedure setUserConnection(PuserConnection:Tadoconnection); override ;
       procedure setFMainDataset(Pdataset:Tadodataset); override ;
       procedure SetDict(PDict:TTreeGridDict);
       procedure SetGridEditBtnClick(GridEditBtnClick:Taction);  override ;
       procedure SetFhlknl( PFhlKnl1:TFhlKnl);   override ;
       procedure SetFhlUser(  PFhlUser:TFhlUser);   override ;
       procedure SetImageList(  PImagelist:Timagelist);override ;

       procedure ShowEditor(sender:Tobject);        override ;
       function  GetOpenParamFields:boolean;     override ;
       function  OpenDataSet:integer; override ;
       procedure CloseDataSet;override ;
       procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
       procedure LeftTreeView1Change(Sender: TObject; Node: TTreeNode);

       procedure ShowConfigMenu(sender:Tobject);
       procedure IniSheet; override ;
       procedure PopUp(sender:Tobject);
       procedure  ClearFilter(sender:Tobject);
       constructor Create(Aowner:Tcomponent);override;
       destructor Destroy; override;
published
       property ToolID:string write SetToolID;
       property LoginInfo:TLoginInfo   write  SetLoginInfo;
end;

type ModelEditorsheet=class(TModelAbstractSheet)
private
    EditorFrm:TForm   ;
    FFhlKnl1:TFhlKnl;
    FFhlUser:TFhlUser;
    FDict  :TEditorDict;

    FmainDataset:Tadodataset;//param values
    FOpenParamFields:string;
public
    procedure SetFhlknl( PFhlKnl1:TFhlKnl);     override ;
    procedure SetFhlUser(  PFhlUser:TFhlUser);    override ;
    procedure SetFmainDataset(Pdataset:Tadodataset);  override ;
    procedure SetDict(PDict:TEditorDict);    //  override ;
    function  GetOpenParamFields: boolean;   override ;
    function  OpenDataSet:integer;   override;
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    constructor Create(Aowner:Tcomponent);override;
    destructor Destroy; override;
end;

type TGrpQueryRecord=class(Tscrollbox)
    private
    FTableName:string;
    FDbgrid:TDbgrid;
    public
    LabelName:Tlabel;
    ComBoxFieldCname:TFhlComboBox;
    TStrLstFieldEname:Tstringlist;
    OptCombobox: TFhlComboBox;
    OptStrLst: Tstringlist;
    ValGroupBox:Tgroupbox;
    Btnqry:Tspeedbutton;

    Sqlexpress:Tstringlist;
    LKPFieldValues:Tstringlist;

    fldval:variant;   //字段值
    fldName:string;    //字段名
    constructor create(aowner:Tcomponent);override;
    destructor  destroy;override;
    procedure IniQuickQuery(PDbgrid:TDbgrid;Filter:boolean=false);
    Procedure BtnClick(sender:TObject);
    function GetSqlCon:string;
    procedure FldComboBoxChange(Sender: TObject);
end;

type TGrpSelRecord=class(Tscrollbox)
public
    TargetDbGrid:TDbGrid;
    MtDataset:Tadodataset;
    MtDatasource:TDatasource;
    Lable:Tlabel;
    lkpCombobox:Tdblookupcombobox;
    SelectType:boolean;
    TableName:string;
    listdataset:Tadodataset;
    ListDataSource:TDataSource;
    popupmenu:Tpopupmenu;
    MenuClear:Tmenuitem;
    MenuAll:Tmenuitem;
    IsFilter:boolean;

    constructor create(aowner:Tcomponent);override;
    procedure IniGrpBox(PDbGrid:TDbGrid);
    Procedure Click(sender:Tobject);
    Procedure DBLClick(sender:Tobject);
    procedure MenuClearClick(sender:Tobject);
    procedure MenuALLClick(sender:Tobject);
end;

type TUserField  =class  (Tobject)
    FieldID:integer;
    FieldEname:string;
    fieldtype:integer;
    fieldKind:string;
    length:integer;
    fieldFormat:string ;
    caption:string;
    PcikList:string;
    OnlyPick:boolean;
    LkpDatasetID:string;
    keyField:string;
    LkpKeyField:string;
    LkpResultField:string;
    ListField:string;
   // constructor create;
end;
Type TDbControl=class (Tobject)
    lableCaption :string;
    BindField  :TUserField;
    CtrlTypeID:integer;
    ClickAct:integer;
    DBLClickAct:integer;
    ExitAct:integer;
    constructor create;
    destructor Destroy;
end;
Type TSumType=(STEmpty,STSum,STAvg,STFirst,STLast,STMax,STMin) ;
type TChyColumn=Class( Tcolumn)
 public
     isAsc:boolean;
     DeciamlFormat:string;
     colid:string;

     GroupValue:string;
     SumType:TSumType ;
end;

implementation
          uses UnitCreateComponent ,UnitUpdateProerty ;
{ Tedit_Mtn }
type
 ipaddr = longint;
 pulong = ^u_long;
function SendARP(DestIP: ipaddr; SrcIP: ipaddr; pMacAddr: pulong;
 PhyAddrLen: pulong): DWORD; stdcall; external 'IPHLPAPI.DLL'     ;





constructor ModelTreeView.Create(Aowner: Tcomponent);
begin
  inherited create(Aowner);
    self.FNodeDataSet1 :=TAdodataset.Create(self);
    FCommandTextDataset:=TAdodataset.Create(self);
    self.OnChange :=self.ETreeChange;
    self.ReadOnly :=true;

end;

destructor ModelTreeView.Destroy;
begin
  freeandnil(FCommandTextDataset);
  freeandnil(FNodeDataSet1);
  inherited;
end;

procedure ModelTreeView.ETreeChange(Sender: Tobject; Node: TTreeNode);
var GridID,Boxid,DatasetID:string;
var TreeCommandCon:widestring;  //tree  sql  条件
var ClrID:integer;
var p,SysParamsFls,Filter:string;
var CmdType,i:integer;
var ClassFLDs:TStrings;
begin
      Screen.Cursor:=crSqlWait;
     try
        begin
          if (self.SubInterFaceDict.TreeGridID <>'' ) and (self.SubInterFaceDict.TreeGridID <>'-1') then     //tree view link with dbgrid
          begin
             self.FFhlKnl1.Kl_GetQuery2('select A.f04,B.f03 ,c.F03 as sqlCon ,C.F04 as CmdType,C.F13 as SysParams,C.F06 as Filter From T612  A    '
                                      +' join T504  B on A.f04=B.f01     '
                                      +' join T201  C on B.F03=C.f01     '
                                      + 'where  A.f01='+quotedstr(self.SubInterFaceDict.TreeGridID));


           //  ClassFld:= FFhlKnl1.FreeQuery.fieldbyname('ClassFld').AsString ;

             DatasetID :=FFhlKnl1.FreeQuery.fieldbyname('F03').AsString ;
             CmdType:=FFhlKnl1.FreeQuery.fieldbyname('CmdType').AsInteger  ;
             SysParamsFls:=FFhlKnl1.FreeQuery.fieldbyname('SysParams').AsString   ;
             Filter :=FFhlKnl1.FreeQuery.fieldbyname('Filter').AsString   ;
             TreeCommandCon:= FFhlKnl1.FreeQuery.fieldbyname('sqlCon').AsString ;
             ClrID:=TAdoDatasetColor(self.FDBGrid.DataSource.DataSet).ColorID  ;

             self.FDBGrid.DataSource.DataSet.Close ;
             FFhlKnl1.AddColorTOCommandtext(TreeCommandCon,ClrID);
             case CmdType of
             0:  Tadodataset(self.FDBGrid.DataSource.DataSet).CommandType :=cmdText;
             1:  Tadodataset(self.FDBGrid.DataSource.DataSet).CommandType :=cmdStoredProc ;
             end;


             self.FDBGrid.DataSource.DataSet.Tag:=StrToInt(DatasetID);
             Tadodataset(self.FDBGrid.DataSource.DataSet).CommandText := Format(TreeCommandCon,[self.FFhlKnl1.Connection.DefaultDatabase ]) ;


             Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters.Refresh ;


             if  Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters.Count >0 then
                 Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters[CmdType].Value :=  TStrPointer(Node.Data)^+'%'
             else
             begin
                 if  pos(')',TreeCommandCon)>-1 then
                 begin
                     Tadodataset(self.FDBGrid.DataSource.DataSet).Prepared :=true;
                     Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters.AddParameter ;
                     Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters[0].Value :=  TStrPointer(Node.Data)^+'%'
                 end;
             end;
             if trim(SysParamsFls)<>'' then
             begin
                 if Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters.Count =1 then
                    Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters.AddParameter ;
                 Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters[1].Value :=   self.FFhlUser.GetSysParamVal(SysParamsFls);
             end;

            self.FDBGrid.DataSource.DataSet.Open ;
            if (Filter<>'') and (not FDBGrid.DataSource.DataSet.IsEmpty ) then
            begin
               FDBGrid.DataSource.DataSet.Filter :=Filter;
               FDBGrid.DataSource.DataSet.Filtered :=True;
            end;

            p:=TStrPointer(Node.Data)^;
            ClassFLDs:=TStringlist.Create ;
            ClassFLDs.CommaText :=   self.FClassFld  ;

            for i:=0 to  ClassFLDs.Count -1 do
            begin
                if self.FDBGrid.DataSource.DataSet.FindField(ClassFLDs[i] )<>Nil then
                begin
                   //sDefaultVals:=self.FClassFld +'='+p;
                   ClassFLDs[i]:=ClassFLDs[i]+'='+p ;
                end;
            end;
            sDefaultVals:=   ClassFLDs.CommaText ;
            FFhlUser.AssignDefault(self.FDBGrid.DataSource.DataSet);
            ClassFLDs.Free ;

             {  self.FDBGrid.DataSource.DataSet.Close ;
               p:= TStrPointer(Node.Data)^        ;
                Tadodataset(self.FDBGrid.DataSource.DataSet).CommandType:= cmdStoredProc;
                Tadodataset(self.FDBGrid.DataSource.DataSet).CommandText :=TreeCommandCon;
                Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters.Refresh ;
                Tadodataset(self.FDBGrid.DataSource.DataSet).Parameters[1].Value :=p;
                 self.FDBGrid.DataSource.DataSet.Open;

           // FhlKnl1.Ds_OpenDataSet(self.FDBGrid.DataSource.DataSet,p);
                 }
            // if DatasetID<>'' then
            //   FFhlUser.SetDataSet (self.FDBGrid.DataSource.DataSet ,DatasetID,TStrPointer(Node.Data)^ +'%') //it is not need ini fields and dataset's  events (eg : before post ,after delete )
          end
          else           ////tree view link with twincontrol          T616 editor
          begin
            self.FFhlKnl1.Kl_GetQuery2('select * From T616 where f01='+quotedstr(self.SubInterFaceDict.EditorID ));
            Boxid:=FFhlKnl1.FreeQuery.fieldbyname('F03').AsString ;
            if BoxId <>'' then
            FFhlKnl1.Cf_SetBox(BoxId ,self.FDBGrid.DataSource ,self.FEditorParent ,dmFrm.UserDbCtrlActLst); //  if have not grid then initial the boxes
          end;
        end;
     finally
      Screen.Cursor:=crDefault;
     end;
     FTreeCaption:=FFhlKnl1.Tv_GetTreePath(Node);
end;

function ModelTreeView.GetTreePath: string;
begin
result:=self.FTreePath ;
end;

procedure ModelTreeView.IniTree;
begin
      FNodeDataSet1.Connection:=self.FUserConnection ;
      FFhlKnl1.Cf_SetTreeView(FTreeId,self,FNodeDataSet1,null,'T703');


      FFhlKnl1.Kl_GetQuery2('select *,B.F12  from T701 A join T612 B on A.TreeGridID=B.f01 where SubInterFaceID='+self.FSubInterFaceID );

      if FFhlKnl1.FreeQuery.RecordCount <>1 then
      begin
          showmessage('Crm tree subinterfaceID error ');
          exit;
      end;

      FClassFld:= FFhlKnl1.FreeQuery.fieldbyname('F12').AsString   ;
      case       SubInterFaceDict.ModeltypeID  of
      0: begin
             SubInterFaceDict.TreeGridID :=  FFhlKnl1.FreeQuery.fieldbyname('TreeGridID').AsString ;
         end;
      1: SubInterFaceDict.EditorID   :=  FFhlKnl1.FreeQuery.fieldbyname('EditorID').AsString ;
      end;

end;

procedure ModelTreeView.SetActionList(PActionList: TactionList);
begin
self.FActionList :=Pactionlist;
end;

procedure ModelTreeView.setEditorIDField(fieldName: string);
begin
self.FEditorIDField :=fieldname;
end;

procedure ModelTreeView.setTreeGridIdField(fieldName: string);
begin
self.fTreeGridIdField:=fieldname;



end;

procedure ModelTreeView.SetEditorParent(PEditorParent: TWinControl);
begin
self.FEditorParent := PEditorParent;
end;

procedure ModelTreeView.SetFDBGrid(PDBGrid: TDBGrid);
begin
self.FDBGrid :=PDBGrid;
end;

procedure ModelTreeView.SetFhlknl(PFhlKnl1: TFhlKnl);
begin
self.FFhlKnl1 := PFhlKnl1;
end;







function LocalIP:string;//获得本机的ip地址
type
   TaPInAddr = array [0..10] of PInAddr;
   PaPInAddr = ^TaPInAddr;
var
   phe  : PHostEnt;
   pptr : PaPInAddr;
   Buffer : array [0..63] of char;
   I    : Integer;
   GInitData      : TWSADATA;


BEGIN
   WSAStartup($101, GInitData);
   Result := '';
   GetHostName(Buffer, SizeOf(Buffer));
   phe :=GetHostByName(buffer);
   IF phe = nil THEN Exit;
   pptr := PaPInAddr(Phe^.h_addr_list);
   I := 0;
   while pptr^[I] <> nil do BEGIN
     result:=StrPas(inet_ntoa(pptr^[I]^));
     Inc(I);
   END;
   WSACleanup;
END;
procedure GetMacAddrFromIP(const IP: String;
 var Mac: String);
var
 DestIP: integer;
 pmacaddr: pulong;
 addrlen: u_long;
 macaddr: array[1..6] of byte;
 p: pbyte;
 i: integer;
begin
 DestIP := inet_addr(pchar(IP)); //目标机器的IP地址
 pMacAddr := pulong(@MacAddr);
 AddrLen := sizeof(MacAddr);
 Mac := '';
 if SendARP(DestIP, 0, pMacAddr, @AddrLen) = 0 then
 begin
   p := pbyte(pMacAddr);
   if ((p <> nil) and (AddrLen > 0)) then
   begin
     for i := 1 to AddrLen do
     begin
       Mac := Mac + IntToHex(p^, 2) + '-';
       p := Pointer(Integer(p) + SizeOf(Byte));
     end;
     SetLength(Mac, Length(Mac) - 1);
   end;
 end;
 end;

constructor Tedit_Mtn.Create(AOwner: TComponent);
begin
    inherited;
    self.ShowHint :=true;
    FieldID:=-1;
    self.BoxId :='-1';
end;

procedure Tedit_Mtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X,Y: Integer);
begin
    if self<>nil then
    begin
      inherited;
      FOldX := Point(X,Y);
    end;
end;

procedure Tedit_Mtn.MouseMove(Shift: TShiftState; X, Y: Integer);
var NewPoint : TPoint;
    tempPoint: TPoint;    
begin
  inherited;
  if Shift=[ssleft] then
  begin
    tempPoint.X :=   Left + X-  FOldX.x;
    tempPoint.Y:=Top + Y- FOldX.Y;
    NewPoint:= tempPoint;
    
    with Self do
      SetBounds(NewPoint.x, NewPoint.Y , Width, Height);
  end;      
end;


procedure Tedit_Mtn.SetisUserMode(const Value: Boolean);
begin
  FisUserMode := Value;
end;

procedure Tedit_Mtn.WmNcHitTest(var Msg: TWmNcHitTest);
var
  Pt: TPoint;
  I: Integer;
begin

  FPosList[1] := htTopLeft;         //这里为什么要这么初始化？？？不然不能改控件大小
  FPosList[2] := htTop;
  FPosList[3] := htTopRight;
  FPosList[4] := htRight;
  FPosList[5] := htBottomRight;
  FPosList[6] := htBottom;
  FPosList[7] := htBottomLeft;
  FPosList[8] := htLeft;


  Pt := Point(Msg.XPos, Msg.YPos);
  Pt := ScreenToClient(Pt);
  Msg.Result := 0;

  for I := 1 to 8 do
    if PtInRect(FRectList[I], Pt) then
      Msg.Result := FPosList[I];
  if Msg.Result = 0 then
    inherited;
end;

procedure Tedit_Mtn.WmSize(var Msg: TWmSize);
var
  R: TRect;
begin


  FRectList[1] := Rect(0, 0, 5, 5);
  FRectList[2] := Rect(Width div 2 - 3, 0, Width div 2 + 2, 5);
  FRectList[3] := Rect(Width - 5, 0, Width, 5);
  FRectList[4] := Rect(Width - 5, height div 2 - 3, Width, Height div 2 + 2);
  FRectList[5] := Rect(Width - 5, Height - 5, Width, Height);
  FRectList[6] := Rect(Width div 2 - 3, Height - 5, Width div 2 + 2, Height);
  FRectList[7] := Rect(0, Height - 5, 5, Height);
  FRectList[8] := Rect(0, Height div 2 - 3, 5, Height div 2 + 2);

//====================================================================

end;
procedure ModelTreeView.SetTreeID(TreeID: string);
begin
self.FTreeID :=treeid;

end;

{ Tlabel_Mtn }

constructor Tlabel_Mtn.Create(AOwner: TComponent);
begin
    inherited;

    self.Visible :=true;
    self.Hint :='0'         ;
    self.Font.Name :='宋体';
    self.Font.Size:=10;
end;

procedure Tlabel_Mtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if (self<>nil)and (Button=  mbLeft  ) then
  begin
    FOldX := Point(X,Y);
  end;
end;

procedure Tlabel_Mtn.MouseMove(Shift: TShiftState; X, Y: Integer);
var NewPoint : TPoint;
tempPoint: TPoint;  
begin
  inherited;
  if Shift=[ssleft] then
  begin
    tempPoint.X :=   Left + X-  FOldX.x;
    tempPoint.Y:=Top + Y- FOldX.Y;
    NewPoint:= tempPoint;

    with Self do
       SetBounds(NewPoint.x, NewPoint.Y , Width, Height);

  end;

end;


procedure Tlabel_Mtn.SetCollector(value: Tstrings);
begin
self.FCollector :=  value;
end;

procedure Tlabel_Mtn.SetisUserMode(const Value: Boolean);
begin
  FisUserMode := Value;
end;

procedure Tlabel_Mtn.WmNcHitTest(var Msg: TWmNcHitTest);
var
  Pt: TPoint;
  I: Integer;
begin

  FPosList[1] := htTopLeft;         //这里为什么要这么初始化？？？不然不能改控件大小
  FPosList[2] := htTop;
  FPosList[3] := htTopRight;
  FPosList[4] := htRight;
  FPosList[5] := htBottomRight;
  FPosList[6] := htBottom;
  FPosList[7] := htBottomLeft;
  FPosList[8] := htLeft;


  Pt := Point(Msg.XPos, Msg.YPos);
  Pt := ScreenToClient(Pt);
  Msg.Result := 0;

  for I := 1 to 8 do
    if PtInRect(FRectList[I], Pt) then
      Msg.Result := FPosList[I];
  if Msg.Result = 0 then
    inherited;
end;

procedure Tlabel_Mtn.WmSize(var Msg: TWmSize);
var
  R: TRect;
begin             
  FRectList[1] := Rect(0, 0, 5, 5);
  FRectList[2] := Rect(Width div 2 - 3, 0, Width div 2 + 2, 5);
  FRectList[3] := Rect(Width - 5, 0, Width, 5);
  FRectList[4] := Rect(Width - 5, height div 2 - 3, Width, Height div 2 + 2);
  FRectList[5] := Rect(Width - 5, Height - 5, Width, Height);
  FRectList[6] := Rect(Width div 2 - 3, Height - 5, Width div 2 + 2, Height);
  FRectList[7] := Rect(0, Height - 5, 5, Height);
  FRectList[8] := Rect(0, Height div 2 - 3, 5, Height div 2 + 2);

//====================================================================

end;
{ TDbRadioGroup_Mtn }

constructor TDbRadioGroup_Mtn.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TDbRadioGroup_Mtn.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  FOldX := Point(X,Y);
end;

procedure TDbRadioGroup_Mtn.MouseMove(Shift: TShiftState; X, Y: Integer);
var NewPoint : TPoint;
tempPoint: TPoint;


begin
  inherited;
if Shift=[ssleft] then
  begin
    tempPoint.X :=   Left + X-  FOldX.x;
    tempPoint.Y:=Top + Y- FOldX.Y;
    NewPoint:= tempPoint;

     with Self do
     SetBounds(NewPoint.x, NewPoint.Y , Width, Height);

  end;

end;


procedure TDbRadioGroup_Mtn.SetisUserMode(const Value: Boolean);
begin
  FisUserMode := Value;
end;

procedure TDbRadioGroup_Mtn.WmNcHitTest(var Msg: TWmNcHitTest);
var
  Pt: TPoint;
  I: Integer;
begin

  FPosList[1] := htTopLeft;         //这里为什么要这么初始化？？？不然不能改控件大小
  FPosList[2] := htTop;
  FPosList[3] := htTopRight;
  FPosList[4] := htRight;
  FPosList[5] := htBottomRight;
  FPosList[6] := htBottom;
  FPosList[7] := htBottomLeft;
  FPosList[8] := htLeft;


  Pt := Point(Msg.XPos, Msg.YPos);
  Pt := ScreenToClient(Pt);
  Msg.Result := 0;

  for I := 1 to 8 do
    if PtInRect(FRectList[I], Pt) then
      Msg.Result := FPosList[I];
  if Msg.Result = 0 then
    inherited;
end;

procedure TDbRadioGroup_Mtn.WmSize(var Msg: TWmSize);
var
  R: TRect;
begin


  FRectList[1] := Rect(0, 0, 5, 5);
  FRectList[2] := Rect(Width div 2 - 3, 0, Width div 2 + 2, 5);
  FRectList[3] := Rect(Width - 5, 0, Width, 5);
  FRectList[4] := Rect(Width - 5, height div 2 - 3, Width, Height div 2 + 2);
  FRectList[5] := Rect(Width - 5, Height - 5, Width, Height);
  FRectList[6] := Rect(Width div 2 - 3, Height - 5, Width div 2 + 2, Height);
  FRectList[7] := Rect(0, Height - 5, 5, Height);
  FRectList[8] := Rect(0, Height div 2 - 3, 5, Height div 2 + 2);

//====================================================================

end;
  function isinteger(value:string):boolean;
  var temp:integer;
  begin
      try
          temp:=strtoint(value);
          result:=true;
      except
          result:=false;
      end;
  end;


procedure ModelTreeView.SetFhlUser(PFhlUser: TFhlUser);
begin
self.FFhlUser :=PFhlUser;
end;

procedure ModelTreeView.SetUserConnection(Pconnection: Tadoconnection);
begin
self.FUserConnection :=Pconnection;
end;

procedure ModelTreeView.SetFSubInterFaceID(PSubInterFaceID: string);
begin
self.FSubInterFaceID:= PSubInterFaceID;
end;

procedure ModelTreeView.SetGridEditBtnClick(GridEditBtnClick: Taction);
begin
self.FGridEditBtnClick := GridEditBtnClick;
end;


{ ModelTreeGridsheet }

constructor ModelTreeGridsheet.Create(Aowner: Tcomponent);
begin
  inherited;

  FAdodataset:=TAdoDatasetColor.Create(self);
  //FAdodataset.CursorLocation := clUseServer ;
  Fdatasource:=Tdatasource.Create(self);
  Fdatasource.DataSet :=self.FAdodataset ;

  self.FGrid :=TmodelDBGrid.create(self);
  self.FGrid.Parent :=self;
  self.FGrid.DataSource :=self.Fdatasource ;
  self.FGrid.Align :=alclient;

  FGridPopupMenu:=TPopupMenu.Create (self);
  FGridPopupMenu.OnPopup :=  PopUp ;
end;

destructor ModelTreeGridsheet.Destroy;
begin

  inherited;
end;

function ModelTreeGridsheet.GetOpenParamFields: boolean;
begin
    self.FFhlKnl1.Kl_GetQuery2('select * From TTreeGridOpenParams where f01='+quotedstr(self.fDict.id ));

    if self.FFhlKnl1.FreeQuery.IsEmpty then
    begin
      result:=false;
      // showmessage('error ! TabTreeGrid  openParamValues='' ')   ;
    end
    else
      FOpenParamFields  :=self.FFhlKnl1.FreeQuery.fieldbyname('OpenParamFields').AsString ;
      FMSumFieldName    :=self.FFhlKnl1.FreeQuery.fieldbyname('FMSumFieldName').AsString ;
      FDLSumFieldName   :=self.FFhlKnl1.FreeQuery.fieldbyname('FDLSumFieldName').AsString ;
      FDLSumFunction    :=self.FFhlKnl1.FreeQuery.fieldbyname('FDLSumFunction').AsString ;


    self.FFhlKnl1.Kl_GetQuery2('select * From T616  where f01='+quotedstr(self.fDict.EditorId  ));
    EditorOpenParameterFields:=self.FFhlKnl1.FreeQuery.fieldbyname('f20').AsString ;
    result:=true;
end;

procedure ModelTreeGridsheet.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 case key of
   vk_Return:
         begin
             self.OpenDataSet ;
         end;
   end;

end;

function ModelTreeGridsheet.OpenDataSet:integer;
var openParamValues:variant;
   var p:string;
//var tstr:string;
begin
//get params fields
//get params values
// ini Grid open

      IF ((fDict.TreeId <>'' )AND (fDict.TreeId <>'-1') and (FTreeView1=nil) )THEN
      BEGIN
           FTreeView1:=TTreeView.Create(self);
           FTreeView1.Images :=self.FFImagelist ;
           FTreeView1.Parent :=self;
           FTreeView1.Align :=alleft;
           FFhlKnl1.Cf_SetTreeView(fDict.TreeId,FTreeView1,dmFrm.FreeDataSet1,null);
           p:=FTreeView1.Items[2].text;

           FTreeView1.OnChange :=LeftTreeView1Change;

      END;
      if     not self.FmainDataset.IsEmpty then
      begin
         if (FOpenParamFields='' ) then
            if   (self.FmainDataset.FindField('F_cltCode')<>nil ) then
             FOpenParamFields:='F_cltCode';

          openParamValues:=FFhlKnl1.Ds_GetFieldsValue(self.FmainDataset  ,self.FOpenParamFields  )     ;
          // if  FmainDataset.state<>dsinsert then
          if not   self.FGrid.DataSource.DataSet.Active  then           //if the fields is already exist  then just open dataset
          begin
             FFhlUser.SetDbGridAndDataSet(self.FGrid,self.fDict.DbGridId,openParamValues,self.fDict.IsOpen,self.FGridEditBtnClick )  ;
             FFhlKnl1.SetColFormat(FGrid );
          end
          else
          begin
                FFhlKnl1.Ds_SetParams(FGrid.DataSource.DataSet,
                  FFhlKnl1.Vr_MergeVarArray(
                self.FFhlUser.GetSysParamsVal(
                       FFhlKnl1.GetSysParametersName(FGrid.DataSource.DataSet )
                    ),
                    openParamValues
                  )
                );
              FGrid.DataSource.DataSet.Open ;
          end;
          if not self.FLoginInfo.isAdmin then
          self.FFhlKnl1.Cf_DeleteDbGridUnAuthorizeCol(fDict.DbGridId,FGrid,FLoginInfo.EmpId ,self.FWindowsFID,FLoginInfo.SysDBPubName) ;
      end
      else
         FGrid.DataSource.DataSet.Close;
//      if (self.fDict.EditorId <>'' ) and (self.fDict.EditorId <>'-1') then
      if assigned(FGrid.OnDblClick) then
        self.Caption :=self.fDict.Caption  +'* '     ;

      if  FGrid.DataSource.DataSet.Active then
      result:=FGrid.DataSource.DataSet.RecordCount ;
end;
procedure ModelTreeGridsheet.LeftTreeView1Change(Sender: TObject; Node: TTreeNode);
  var p:string;
begin
  Screen.Cursor:=crSqlWait;
  try
    p:=TStrPointer(Node.Data)^;


    if FAdodataset.FindField(fDict.ClassFld)<>Nil then
    begin
      sDefaultVals:=fDict.ClassFld+'='+p;
      FFhlUser.AssignDefault(FAdodataset);
    end;
   // p:=p+'%';



        self.FAdodataset.Filtered :=false ;
        if  p<>'' then
        begin
            self.FAdodataset.Filter   :=fDict.ClassFld+' = '+quotedstr(p);
            self.FAdodataset.Filtered :=true
        end;

 //   FhlKnl1.Ds_OpenDataSet(AdoDataSet1,varArrayof([p,LoginInfo.LoginId]));
 //   lblPnl.Caption:=FhlKnl1.Tv_GetTreePath(Node);//+inttostr(AdoDataSet1.recordCount)+' 个项目';
 //   statLabel1.Left :=lblPnl.Left +lblPnl.Width ;//
 //   expBtn.Enabled:=Node.HasChildren;

  finally
    Screen.Cursor:=crDefault;
  end;
end;
procedure ModelTreeGridsheet.SetDict(PDict: TTreeGridDict);
begin
self.fDict := PDict;
self.Caption :=self.fDict.Caption ;
GetOpenParamFields;
end;


procedure ModelTreeGridsheet.SetFhlknl(PFhlKnl1: TFhlKnl);
begin
self.FFhlKnl1 := PFhlKnl1;
self.FGrid.setfhlknl(PFhlKnl1);
end;

procedure ModelTreeGridsheet.SetFhlUser(PFhlUser: TFhlUser);
begin
self.FFhlUser :=PFhlUser;
end;

procedure ModelTreeGridsheet.SetGridEditBtnClick(
  GridEditBtnClick: Taction);
begin
self.FGridEditBtnClick := GridEditBtnClick;
end;

procedure ModelTreeGridsheet.setFMainDataset(Pdataset:Tadodataset);
begin
self.FmainDataset :=Pdataset;


end;

procedure ModelTreeGridsheet.setUserConnection(
  PuserConnection: Tadoconnection);
begin
self.FuserConnection :=PuserConnection;
FAdodataset.Connection :=self.FuserConnection ;
end;

procedure ModelTreeGridsheet.ShowEditor(sender: Tobject);
var Lststr :Tstrings ;
var i:integer;
var fopenVariant:Variant; 
begin
    if not ( FmainDataset.State in [dsinsert ]) then
    begin
         if   FmainDataset.State in [dsEdit ] then
           FmainDataset.Cancel ;
          Lststr :=Tstringlist.Create ;
          Lststr.CommaText :=   FOpenParamFields;

          if (self.fDict.EditorId<>'') and (self.fDict.EditorId<>'-1') and (self.FGrid.DataSource.DataSet.Active )then
          begin
                if not assigned(EditorFrm) then
                sDefaultVals:='';
                for i:=0 to  Lststr.Count -1 do
                begin
                    if self.FmainDataset.FindField (Lststr[i])<>nil then
                    begin
                      if i=   Lststr.Count -1 then
                         sDefaultVals:=   sDefaultVals+ Lststr[i]+'='+self.FmainDataset.FieldByName(Lststr[i]).asString
                      else
                         sDefaultVals:=   sDefaultVals+ Lststr[i]+'='+self.FmainDataset.FieldByName(Lststr[i]).asString+',';
                    end;
                end;
                if EditorOpenParameterFields='' then
                  fopenVariant:= FhlKnl1.Ds_GetFieldsValue(FmainDataset,FOpenParamFields)    //2010-1-30
                else
                  fopenVariant:= FhlKnl1.Ds_GetFieldsValue(FGrid.DataSource.DataSet,EditorOpenParameterFields) ;

                EditorFrm:=FFhlUser.ShowEditorFrm(self.fDict.EditorId  ,fopenVariant , FGrid.DataSource.DataSet, Twincontrol(self.Owner ),self.FGrid );
                EditorFrm.Showmodal;
                sDefaultVals:='';
          end;
          Lststr.Free ;
    end;
end;

procedure ModelTreeGridsheet.SetLoginInfo(PLoginInfo: TLoginInfo);
begin
self.FLoginInfo :=  PLoginInfo;
self.FGrid.SetLoginInfo(PLoginInfo)  ;
end;

procedure ModelTreeGridsheet.SetToolID(PtoolID: string);
begin
self.FtoolID :=  PtoolID;
self.FGrid.SetToolID(PtoolID);
end;

procedure ModelTreeGridsheet.SetPopupMenu(PPopupMenu: TPopupMenu);
//var i,j,UserMenuCont:integer;
//var GridMenuItem: array of TMenuItem;
//var sql:string;
begin
  self.FFhlUser.MergeGridUserMenuAndSysCongfigMenu(FGridPopupMenu,PPopupMenu,fdict.GridUserMenuIDs ,self.FActionList );
  self.FGrid.SetPopupMenu ( FGridPopupMenu);
end;

procedure ModelTreeGridsheet.ToolMenuClick(sender: Tobject);


begin

//          showmessage(tdbgrid(Tmeunitem(sender).PopupComponent ).className );
 self.FGrid.ToolMenuClick(sender);
end;
procedure ModelTreeGridsheet.setActionLst(PActionList: TActionList);
begin
self.FActionList := PActionList;
end;

procedure ModelTreeGridsheet.IniSheet;
begin
  // FhlKnl1.Cf_SetTreeView(fDict.TreeId,TreeView1,dmFrm.FreeDataSet1,AParam);


 //

  if (self.fDict.Actions  ='-1') or (self.fDict.Actions  ='') then
  begin
      if  (self.fDict.EditorId  <>'-1') and (self.fDict.EditorId  <>'') then
      self.FGrid.OnDblClick :=self.ShowEditor;

  end
  else
     if  self.FActionList.ActionCount >        strtoint(fDict.Actions) then
     self.FGrid.OnDblClick :=        self.FActionList.Actions [strtoint(fDict.Actions)].OnExecute ;
{}


  self.OnKeyDown :=self.KeyDown;
 
 // self.Hint :='回车显示数据';
 // self.ShowHint :=true;
end;

procedure ModelTreeGridsheet.ShowConfigMenu(sender:Tobject);
var i:Integer;
begin
    for i:=0 to self.FGridPopupMenu.Items.Count-1 do
    begin
         if   self.FGridPopupMenu.Items[i].Tag =1 then
           self.FGridPopupMenu.Items[i].Visible := not FGridPopupMenu.Items[i].Visible;
    end;
end;

procedure ModelTreeGridsheet.SetImageList(PImagelist: Timagelist);
begin
self.FFImagelist:=PImagelist;
end;

procedure ModelTreeGridsheet.CloseDataSet;
begin
  inherited;
FGrid.DataSource.DataSet.Close;
end;

 

procedure ModelTreeGridsheet.PopUp(sender: Tobject);
var MClearFilter:Tmenuitem;
begin
  if self.FGrid.DataSource.DataSet.Active then 
      if self.FGrid.DataSource.DataSet.Filter <>'' then
        if FGridPopupMenu.Items [0].caption<>'取消过滤' then
        begin
          MClearFilter:=Tmenuitem.Create (FGridPopupMenu);
          MClearFilter.Name :='MClearFilter';
          MClearFilter.Caption :='取消过滤';
          MClearFilter.OnClick := ClearFilter;
          FGridPopupMenu.Items.Insert(0, MClearFilter) ;
        end;
end;

procedure ModelTreeGridsheet.ClearFilter(sender: Tobject);
var MClearFilter:Tmenuitem;
begin
   self.FGrid.DataSource.DataSet.Filter :='';
  self.FGrid.DataSource.DataSet.Filtered  :=true;
  MClearFilter:=FGridPopupMenu .Items[0];
  MClearFilter.Free ;


end;

{ ModelEditorsheet }

constructor ModelEditorsheet.Create(Aowner: Tcomponent);
begin

  inherited Create(aowner);
  self.OnKeyDown :=self.KeyDown;
 // self.Hint :='回车显示数据';
 // self.ShowHint :=true;
  
{  self.EditorFrm :=TEditorFrm.Create(self);
  self.EditorFrm.Top :=0;
  self.EditorFrm.left :=0;
  self.EditorFrm.Width :=self.Width ;
  self.EditorFrm.Height :=self.Height ;

  self.Dock(self.EditorFrm ,self.EditorFrm.ClientRect );
 }

end;

destructor ModelEditorsheet.Destroy;
begin

  inherited;
end;

function ModelEditorsheet.GetOpenParamFields: boolean;
begin

self.FFhlKnl1.Kl_GetQuery2('select * From TEditorOpenParams where f01='+quotedstr(self.FDict.Id  ));

if self.FFhlKnl1.FreeQuery.IsEmpty then
begin
  result:=false;
    showmessage('error ! Tab eidtor FOpenParamFields =''');
end
else
  self.FOpenParamFields :=self.FFhlKnl1.FreeQuery.fieldbyname('OpenParamFields').AsString ;

  result:=true;
end;


procedure ModelEditorsheet.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case key of
   vk_Return:
         begin
             self.OpenDataSet ;
         end;
   end;
end;

function ModelEditorsheet.OpenDataSet:integer;
var openParamValues:variant;
var i:integer;
begin
//get params fields
//get params values
// ini editor open

            openParamValues:=FFhlKnl1.Ds_GetFieldsValue(self.FmainDataset  ,self.FOpenParamFields  );

            if self.EditorFrm=nil         then
               self.EditorFrm := self.FFhlUser.ShowEditorFrm(self.FDict.Id   ,openParamValues,nil,self)
            else
            begin
               for i:=0 to   TEditorFrm(EditorFrm).PageControl1.PageCount -1 do
               begin
                   TEditorFrm(EditorFrm).PageControl1.Pages [i].Free ;
               end;
               TEditorFrm(EditorFrm).initFrm(self.FDict.Id ,openParamValues,nil);
            end;


            TEditorFrm(EditorFrm).ExtBtn.Visible :=false;
            EditorFrm.Align :=alClient;

            EditorFrm.Dock(self,self.EditorFrm.ClientRect );
            EditorFrm.Show ;
            

end;

procedure ModelEditorsheet.SetDict(PDict: TEditorDict);
begin
self.FDict :=   PDict;
self.Caption :=self.FDict.Caption ;

GetOpenParamFields  ;





end;


procedure ModelEditorsheet.SetFhlknl(PFhlKnl1: TFhlKnl);
begin
self.FFhlKnl1 := PFhlKnl1;

end;

procedure ModelEditorsheet.SetFhlUser(PFhlUser: TFhlUser);
begin
self.FFhlUser :=PFhlUser;
end;

procedure ModelEditorsheet.SetFmainDataset(Pdataset: Tadodataset);
begin
self.FmainDataset := Pdataset;
end;

{ TmodelTreeSheet }


constructor TmodelTreeSheet.Create(Aowner: Tcomponent);

begin
  inherited create(Aowner);
   TreeView:= ModelTreeView.Create (self);
   FToolPopMenu:=TpopupMenu.Create (self);
   FToolMenuItem:=Tmenuitem.Create (self);

   FToolMenuItem.Caption :='Ctm Tree ';
   FToolMenuItem.Name :='EditCrmTree';
   FToolMenuItem.OnClick :=  self.dblClick ;
   FToolPopMenu.Items.Add(FToolMenuItem) ;



   TreeView.Parent :=self;
   TreeView.Align :=alclient;


   self.OnDblClick  :=self.dblClick;




end;

procedure TmodelTreeSheet.dblClick(sender: Tobject);
begin
if self.FLoginInfo.Sys then
self.FFhlUser.ShowEditorFrm(self.FToolID ,inttostr(self.Tag )).ShowModal ;
end;



destructor TmodelTreeSheet.Destroy;
begin
{
   freeandnil(self.TreeView);

   freeandnil(  FToolPopMenu);
}
     

  inherited;
end;



procedure TmodelTreeSheet.SetActionList(PActionList: TactionLIst);
begin
self.TreeView.SetActionList(PActionList);
end;

procedure TmodelTreeSheet.setEditorIDField(fieldName: string);
begin
self.TreeView.setEditorIDField(fieldName);
end;

procedure TmodelTreeSheet.SetEditorParent(PEditorParent: TWinControl);
begin
self.TreeView.SetEditorParent (PEditorParent);
end;

procedure TmodelTreeSheet.SetFDBGrid(PDBGrid: TDBGrid);
begin
self.TreeView.SetFDBGrid(PDBGrid);
end;

procedure TmodelTreeSheet.SetFhlknl(PFhlKnl1: TFhlKnl);
begin
self.TreeView.SetFhlknl(PFhlKnl1);
end;

procedure TmodelTreeSheet.SetFhlUser(PFhlUser: TFhlUser);
begin
self.FFhlUser :=PFhlUser;
self.TreeView.SetFhlUser(PFhlUser);
end;

procedure TmodelTreeSheet.SetFSubInterFaceID(PSubInterFaceID: string);
begin
self.TreeView.SetFSubInterFaceID(PSubInterFaceID);
end;

procedure TmodelTreeSheet.SetGridEditBtnClick(GridEditBtnClick: Taction);
begin
self.TreeView.SetGridEditBtnClick(GridEditBtnClick);
end;

procedure TmodelTreeSheet.SetLoginInfo(PLoginInfo: TLoginInfo);
begin
self.FLoginInfo :=  PLoginInfo;


   if   self.FLoginInfo.Sys  then
   self.TreeView.PopupMenu :=self.FToolPopMenu ;

end;

procedure TmodelTreeSheet.SetToolID(PtoolID:string);
begin
self.FToolID :=PtoolID;
end;

procedure TmodelTreeSheet.setTreeGridIdField(fieldName: string);
begin
self.TreeView.setTreeGridIdField(fieldName);
end;

procedure TmodelTreeSheet.SetTreeID(TreeID: string);
begin
self.TreeView.SetTreeID (TreeID);
self.Tag :=strtoint(TreeID);
end;



procedure TmodelTreeSheet.SetUserConnection(Pconnection: Tadoconnection);
begin
self.TreeView.SetUserConnection(Pconnection);
end;


{ GrpSelRecord }

constructor TGrpSelRecord.create(aowner: Tcomponent);
begin
  inherited;
  self.BorderStyle :=bsnone;
 // dragkind:=dkDock;
 //DragMode:=dmautoMatic;
  
  self.MtDataset :=Tadodataset.Create(self);
  self.MtDataset.Connection:=    dmfrm.ADOConnection1;

  self.MtDatasource :=TDatasource.Create(self);
  self.MtDatasource.DataSet  :=self.MtDataset ;
  self.OnDblClick :=self.DBLClick;

  Lable:=Tlabel.Create (self);
  Lable.Parent :=self;
  Lable.Caption :='过滤条件:' ;
  Lable.Left :=5;
  Lable.top :=25;

  popupmenu:=Tpopupmenu.Create (self);
  MenuClear:=Tmenuitem.Create(popupmenu);
  MenuAll:=Tmenuitem.Create(popupmenu);

  popupmenu.Items.Add(MenuAll);
  popupmenu.Items.Add(MenuClear);

  MenuClear.Caption :='删除过滤条件';
  MenuClear.OnClick :=    MenuClearClick;

  MenuAll.Caption :='全部';
  MenuAll.OnClick := MenuALLClick ;




end;

procedure TGrpSelRecord.Click(sender: Tobject);
var consql,sql:string;
var i:integer;
var LkpCombo:TdblookupCombobox;
begin
//consql:=self.TargetDbGrid

     for i:=0 to self.ComponentCount -1 do
     begin
         if self.Components[i] is  TdblookupCombobox then
            LkpCombo:= ( self.Components[i]as  TdblookupCombobox  )   ;
     end;

     if   LkpCombo.Text ='' then
     consql:= ''
     else
     begin
        consql:=   LkpCombo.ListSource.DataSet.fieldbyname (LkpCombo.DataField ).AsString ;
        if consql<>'' then
        begin
            listdataset.Edit ;
            listdataset.FieldByName('createtime').AsDateTime  :=now;
            listdataset.FieldByName('UseCount').AsInteger :=listdataset.FieldByName('UseCount').AsInteger+1;
            listdataset.Post ;
        end;
     end;
     self.TargetDbGrid.DataSource.DataSet.Filtered:=false;             //query
     self.TargetDbGrid.DataSource.DataSet.Filter :=  consql;
     self.TargetDbGrid.DataSource.DataSet.Filtered:=true;;



end;

procedure TGrpSelRecord.IniGrpBox(PDbGrid:TDbGrid);
var sql:string;

begin
    self.TargetDbGrid:=  PDbGrid;


    lkpCombobox:=TFhlDbLookupComboBox.Create (self);
    lkpCombobox.Parent :=self;
    lkpCombobox.Top :=lable.Top-2 ;
    lkpCombobox.Left :=   lable.Left +lable.Width +10;
    lkpCombobox.Visible :=true;
    lkpCombobox.DataSource :=self.MtDatasource ;
    lkpCombobox.Width :=120;
    lkpCombobox.DropDownRows:=10;

    lkpCombobox.OnClick :=     Click;
    lkpCombobox.PopupMenu :=self.popupmenu ;


    self.Width :=self.lkpCombobox.Left +self.lkpCombobox.Width +40;

    sql:='select str0  as sqlcon from '+fhlknl1.Connection.DefaultDatabase +'.dbo.Sys_QueryParameters where 1<>1' ;
    self.MtDataset.CommandText :=sql;
    self.MtDataset.Open ;
    self.lkpCombobox.KeyField :='sqlcon';//MtDataset.fieldbyname()
    self.lkpCombobox.DataField :='sqlcon';//
    listdataset:=Tadodataset.Create (self);
    ListDataSource:=TDataSource.Create(self);
    ListDataSource.DataSet :=listdataset;
    listdataset.Connection :=dmfrm.ADOConnection1 ;
//    listdataset.CommandText :='select top 10 * from sys_FilterOrqtyCon where loginid='+quotedstr(logininfo.LoginId )+'  and gridid='+inttostr(self.TargetDbGrid.tag )+' order by Createtime';
    listdataset.CommandText :='select top 10 sqlCon,AlisName ,createtime,UseCount from sys_FilterOrqtyCon where gridid='+inttostr(self.TargetDbGrid.tag )
                            +' union  all '
                            +' select top 1 '+quotedstr('')+','+quotedstr('全部')+'  as AlisName,Getdate() ,0 from sys_FilterOrqtyCon  '
                            +' order by createtime desc , UseCount desc  ';
    listdataset.Open ;

    self.lkpCombobox.ListSource := ListDataSource;
    lkpCombobox.ListField :='AlisName';


    if IsFilter then
     self.Caption :='快捷过滤'
  else
     self.Caption :='快捷查询';
end;

procedure TGrpSelRecord.DBLClick(sender: Tobject);
var CrtCom:TfrmCreateComponent    ;
begin
      // modeltpe:=Bill;
        if LoginInfo.Sys  then  begin
          CrtCom:=TfrmCreateComponent.Create(self);
          CrtCom.mtDataSet1 :=self.MtDataset  ;

            try
          CrtCom.Show;
      finally

      end;
        end;

   

end;

procedure TGrpSelRecord.MenuClearClick(sender: Tobject);
begin

    if listdataset.FieldByName('sqlCon').AsString <>'' then
    begin
     self.MtDataset.FieldByName('sqlcon').Value:=null;
     self.listdataset.Delete ;
    end;
end;

procedure TGrpSelRecord.MenuALLClick(sender: Tobject);
begin
    self.MtDataset.FieldByName('sqlcon').Value:=null;
   // self.listdataset.FieldByName('alisname').AsString :='全部';
    self.Click(self.lkpCombobox );
end;

{ TGrpQueryRecord }

procedure TGrpQueryRecord.BtnClick(sender: TObject);
var sql,consql:string;

 var i:integer;

begin

    ConSql:=GetSqlCon ;

    if ( self.OptStrLst[self.OptCombobox.Itemindex]= '') or (ConSql='') then
    begin
         showmessage('查询备件出错!')   ;
         exit;
    end;


    fhlknl1.Ds_QuickQuery (FDbgrid.DataSource.DataSet,ConSql) ;

end;

constructor TGrpQueryRecord.create(aowner: Tcomponent);
begin
      inherited create(aowner);
      self.BorderStyle :=bsnone;
    //  dragkind:=dkDock;
    //  DragMode:=dmautoMatic;

      self.LabelName:=Tlabel.Create(nil);
      LabelName.Top :=25;
      LabelName.Left :=5;
      
      self.ComBoxFieldCname:=TFhlComboBox.Create(nil);

      self.TStrLstFieldEname :=Tstringlist.Create ;

      self.OptCombobox :=  TFhlComboBox.Create(nil);

      self.OptStrLst :=Tstringlist.Create ;

      self.ValGroupBox:=Tgroupbox.Create (nil);
      self.Btnqry:=Tspeedbutton.Create(nil);

      self.Sqlexpress :=Tstringlist.Create ;
            LKPFieldValues:=Tstringlist.Create ;
end;

destructor TGrpQueryRecord.destroy;
begin
  self.LabelName.Free;

  self.ComBoxFieldCname.Free;

  self.TStrLstFieldEname.Free;

  self.OptCombobox.Free;

  self.OptStrLst.Free;
  self.ValGroupBox.Free ;
  self.Btnqry.Free;
  self.Sqlexpress.Free ;

  LKPFieldValues.Free;
  inherited;
end;

procedure TGrpQueryRecord.IniQuickQuery(PDbgrid: TDbgrid;Filter:boolean=false);
var i:integer;
begin
    //
      LabelName.Parent :=self;
      LabelName.Caption :='快捷查询：';


      ComBoxFieldCname.Parent :=self;
      ComBoxFieldCname.Top :=self.LabelName.Top -2;
      ComBoxFieldCname.Width :=100;
      ComBoxFieldCname.Left := LabelName.Left +LabelName.Width +10;
      ComBoxFieldCname.OnClick :=     FldComboBoxChange;

      OptCombobox.Parent :=self;
      OptCombobox.Top :=self.LabelName.Top -2;
      OptCombobox.Left :=ComBoxFieldCname.Left +ComBoxFieldCname.Width +10;
      OptCombobox.Width :=100;
      OptCombobox.Items.CommaText :='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';

      OptStrLst.CommaText :='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';

      ValGroupBox.Parent :=self;
      ValGroupBox.Top :=  OptCombobox.Top -20;
      ValGroupBox.Left := OptCombobox.Left+OptCombobox.Width +10;
      ValGroupBox.Caption :='值';
      ValGroupBox.Ctl3D :=true;
      ValGroupBox.Height := OptCombobox.Height+30;

      Btnqry.Parent :=self;
      Btnqry.Top :=self.LabelName.Top-2;
      Btnqry.Left := ValGroupBox.Left +ValGroupBox.Width +20;
      if fileexists( ExtractFileDir(Application.ExeName)+'\pic\btnqry.bmp') then
      Btnqry.Glyph.LoadFromFile(ExtractFileDir(Application.ExeName)+'\pic\btnqry.bmp');
      Btnqry.Width :=60;
      Btnqry.Caption :='查询';
      Btnqry.OnClick :=self.BtnClick;


      self.AutoSize :=true;


      self.FDbgrid := PDbgrid;
      for i:=0  to FDbgrid.Columns.Count -1 do
      begin
          if   Filter then
          begin
              if  ( FDbgrid.Columns[i].Visible ) and (not FDbgrid.Columns[i].ReadOnly  )  then
              begin
                  self.ComBoxFieldCname.Items.Add( FDbgrid.Columns[i].Title.Caption );
                  self.TStrLstFieldEname.Add(FDbgrid.Columns[i].FieldName );
              end;
          end
          else
          begin
              if  ( FDbgrid.Columns[i].Visible )   then
              begin
                  self.ComBoxFieldCname.Items.Add( FDbgrid.Columns[i].Title.Caption );
                  self.TStrLstFieldEname.Add(FDbgrid.Columns[i].FieldName );
              end;
          end;


      end;
end;
procedure TGrpQueryRecord.FldComboBoxChange(Sender: TObject);
 var ft:TFieldType;i:Integer;fld:TField;s:string;
 

begin
 for i:=ValGroupBox.ControlCount-1 downto 0 do
     ValGroupBox.Controls[i].free;



    for i:=0 to  fDBGrid.Columns.Count -1  do
    begin
       if  trim( fDBGrid.Columns[i].FieldName )  =trim(self.TStrLstFieldEname [self.ComBoxFieldCname.itemindex] )    then
       begin
          fld:=fDBGrid.Columns [i].Field  ;//fDataSet.FieldByName ()
          break;
       end;
    end;


    if not assigned(fld) then showmessage('字段查找不误，请联系管理员');
 if fld.FieldKind=fkLookup then begin
       with TFhlComboBox.Create(ValGroupBox) do begin
           Parent:=ValGroupBox;

           LKPFieldValues.Clear ;
            with fld.LookupDataSet do begin
                 First;
                 while not Eof do begin
                   Items.Append(FieldByName(fld.LookupResultField).asString);

                   LKPFieldValues.Add(FieldByName(fld.LookupKeyFields).asString);
                   Next;
                 end;
            end;



       end;
         with self.OptCombobox  do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
    end
    else begin
      ft:=fld.DataType;
      if ft=ftString then begin
         //创建值编辑对象
         with TfhlEdit.Create(ValGroupBox) do begin
               Parent:=ValGroupBox;
         end;
         //格式化操作符
         with self.OptCombobox  do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
      end
      else if (ft=ftDate) or (ft=ftDateTime) then begin
         with TDateTimePicker.Create(ValGroupBox) do begin
            Parent:=ValGroupBox;
            DateTime:=now;
         end;
         with self.OptCombobox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=';
      end
      else if ft=ftBoolean then begin
         with TRadioGroup.Create(ValGroupBox) do begin
            Parent:=ValGroupBox;
            height:=Parent.Height -5;
            align:=alClient;
            Columns:=2;
            s:=TBooleanField(fld).DisplayValues;
            Items.Append(Copy(s,Pos(';',s)+1,Length(s)));
            Items.Append(Copy(s,0,Pos(';',s)-1));
         end;
         with self.OptCombobox  do begin
              Items.Clear;
              Items.CommaText:='等于,不等于';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>';
      end
      else if ft=ftMemo then begin
         with TMemo.Create(ValGroupBox) do begin
            Parent:=ValGroupBox;
            Align:=alClient;
            Lines.Clear;
            ScrollBars:=ssVertical;
         end;
         with self.OptCombobox  do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于,包含,不包含,以...开头,不以...开头,以...结尾,不以...结尾';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=,"like","not like","like x%","not like x%","like %x","not like %x"';
      end
      else if (ft=ftCurrency) or (ft=ftInteger) or (ft=ftFloat) then begin
        with TfhlEdit.Create(ValGroupBox) do begin
             Parent:=ValGroupBox;
        end;
         with self.OptCombobox do begin
              Items.Clear;
              Items.CommaText:='等于,不等于,大于,小于,大于等于,小于等于';
         end;
         self.OptStrLst.Clear;
         self.OptStrLst.CommaText:='=,<>,>,<,>=,<=';
      end;
    end;

    with ValGroupBox.Controls[0] do
    begin
        Parent:=ValGroupBox;
        top := 20;
        left:=5;
        width:= ValGroupBox.Width -10;

       // height:=ValGroupBox.height -10;

    end;

    self.OptCombobox.ItemIndex:=0;
   
end;

function TGrpQueryRecord.GetSqlCon: string;
var sql,consql:string;
 var opt,s:wideString;

 ctrl:TControl;
 ft:TFieldtype;
 var i:integer;

Var ObjectField:Tfield;
begin
    if self.ComBoxFieldCname.Text ='' then
    begin
        showmessage('请先选择条件');
        exit;
    end;

    ctrl:=ValGroupBox.Controls[0];
    if ctrl is TEdit then
       fldval:=TEdit(ctrl).Text
    else if ctrl is TComboBox then
       fldval:=TComboBox(ctrl).Items.Strings[TComboBox(ctrl).ItemIndex]
    else if ctrl is TDateTimePicker then
       fldval:=QuotedStr(FormatDateTime('yyyy"-"mm"-"dd',TDateTimePicker(ctrl).DateTime))
    else if ctrl is TRadioGroup then
       fldval:=intTostr(TRadioGroup(ctrl).ItemIndex)
    else if ctrl is TMemo then
       fldval:=TMemo(ctrl).Text;


   for i:=0 to  fDBGrid.Columns.Count -1 do
   begin
             if trim(fDBGrid.Columns[i].FieldName )= trim(self.TStrLstFieldEname[self.ComBoxFieldCname.itemindex] ) then
             begin
                  ObjectField:=fDBGrid.Columns[i].Field     ;
                  break;
             end;
   end;


    fldName:= ObjectField.FieldName ;
    ft := ObjectField.DataType ;

    opt:=self.OptStrLst[self.OptCombobox.ItemIndex];

    if  ObjectField.FieldKind=fkLookup then             //LKP 要做转化
    begin
         fldName:= ObjectField.KeyFields ;
         if TComboBox(ctrl).ItemIndex>-1 then
             fldval:=self.LKPFieldValues [TComboBox(ctrl).ItemIndex]
         else
             fldval:='';
    end;

    if (ft=ftString) or (ft=ftMemo) then
    begin//字符及文本型
       if opt='like' then
          s:=' like ''%'+fldval+'%'''
       else if opt='not like' then
          s:=' not like ''%'+fldval+'%'''
       else if opt='like x%' then
          s:=' like '''+fldval+'%'''
       else if opt='not like x%' then
          s:=' not like '''+fldval+'%'''
       else if opt='like %x' then
          s:=' like ''%'+fldval+''''
       else if opt='not like %x' then
          s:=' not like ''%'+fldval+''''
       else
          s:=' '+opt+' '''+fldval+'''';
    end
    else
      s:=' '+opt+' '+fldval;

    Sqlexpress.Clear ;


    if ((ft=ftString) or (ft=ftMemo))and ( (fldval='') and (opt='=') ) then
         self.Sqlexpress.Append(fldName+s+'  or '+fldName+'=null')
    else if   (ft=ftboolean ) and ( (fldval='0' ) and (opt='=' ) ) then
         self.Sqlexpress.Append(fldName+s+'  or '+fldName+'=null')
    else
         self.Sqlexpress.Append(fldName+s);




    ConSql:= Sqlexpress[0];

    result:=  ConSql;
end;

{ TDbControl }

constructor TDbControl.create;
begin

      self.BindField:=TUserField.Create  ;
      BindField.FieldID :=-1;
      self.ClickAct :=-1;
      self.DBLClickAct :=-1;
      self.ExitAct :=-1;
      CtrlTypeID:=-1;
end;

destructor TDbControl.Destroy;
begin
self.BindField.Free ;
end;

{ TUserField }



{ TModelAbstractSheet }

procedure TModelAbstractSheet.SetWindowsFID(const Value: string);
begin
  FWindowsFID := Value;
end;

end.
