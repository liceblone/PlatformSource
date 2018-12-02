unit UnitSendMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, DBCtrls, ExtCtrls, DB, ADODB;
type
  Temp=class
    FEmpCode :string;
    FEmpName:String;
end;
type TDept=class
    FDeptCode :string;
    FDeptName:string;

end;
type
  TFrmSendMsg = class(TForm)
    GroupBox2: TGroupBox;
    ChkLstDept: TCheckListBox;
    GroupBox3: TGroupBox;
    ChkLstEmp: TCheckListBox;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox4: TGroupBox;
    BtnSend: TButton;
    QryHistory: TADOQuery;
    DsHistory: TDataSource;
    DsContent: TDataSource;
    QryContent: TADOQuery;
    MMContent: TMemo;
    MMHistory: TMemo;
    BtnClose: TButton;
    BtnReceivedMsg: TButton;
    grpReceivedMsg: TGroupBox;
    mmReceivedMsg: TMemo;
    Timer1: TTimer;
    QryReceivedMsg: TADOQuery;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure BtnSendClick(Sender: TObject);
    procedure ReflashHistory;
    procedure Button1Click(Sender: TObject);
    procedure BtnReceivedMsgClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSendMsg: TFrmSendMsg;

implementation
uses datamodule,UPublicFunction;

{$R *.dfm}

procedure TFrmSendMsg.FormCreate(Sender: TObject);
var
  qry:Tadoquery;
  Emp:Temp;
  Dept:TDept;
begin
try
  qry:=Tadoquery.Create(nil);
  qry.Connection :=dmfrm.ADOConnection1;
  qry.SQL.Clear;
  qry.SQL.Add('select FempName,FempCode from Temployee where  FDel=0 or FDel is null ');
  qry.Open;

  while (not qry.Eof )    do
  begin
     Emp:=Temp.Create ;
     Emp.FEmpCode :=qry.Fieldbyname('FEmpCode').AsString  ;
     Emp.FempName :=qry.Fieldbyname('FempName').AsString  ;
     self.ChkLstEmp.AddItem(qry.Fieldbyname('FempName').AsString ,Emp) ;
     qry.Next;
  end;
  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add('select FDeptCode,FDeptName From Tdept ') ;
  qry.Open;
  while (not qry.Eof )  do
  begin
     Dept:=TDept.Create ;
     Dept.FDeptCode:=qry.Fieldbyname('FDeptCode').AsString ;
     Dept.FDeptName :=qry.Fieldbyname('FDeptName').AsString ;
     self.ChkLstDept.AddItem(qry.Fieldbyname('FDeptName').AsString ,Dept) ;
     qry.Next;
  end;

  ReflashHistory ;
finally
  qry.Free ;
end;

end;

procedure TFrmSendMsg.BtnSendClick(Sender: TObject);
var
   lstDepts,LstEmps:string;
   LstStrDept,LstStrEmp:Tstrings;
   i:integer;
begin
  try
    LstStrDept:=Tstringlist.Create ;
    LstStrEmp:=Tstringlist.Create ;

    for i:=0 to self.ChkLstDept.Count-1 do
      if  ChkLstDept.Checked [i] then
          LstStrDept.Add( Temp(ChkLstDept.Items.Objects[i]).FEmpCode  ) ;

    for i:=0 to self.ChkLstEmp.Count-1 do
      if  ChkLstEmp.Checked [i] then
          LstStrEmp.Add( TDept(ChkLstEmp.Items.Objects [i]).FDeptCode  ) ;

    if ( ( LstStrEmp.CommaText ='') and (LstStrDept.CommaText ='' ) ) then
    begin
        showmessage('请先选择接收对象!');
        exit;
    end;
    QryContent.Open;
    QryContent.Append ;
    QryContent.FieldByName('F_ID').Value := GetGUID;
    QryContent.FieldByName('FCreateEmp').Value := logininfo.EmpId  ;
    QryContent.FieldByName('FMsgContent').Value :=self.MMContent.Text ;
    QryContent.FieldByName('FRecEmps').Value  :=LstStrEmp.CommaText ;
    QryContent.FieldByName('FRecDepts').Value := LstStrDept.CommaText ;

    QryContent.Post ;
    QryContent.Close;

    ReflashHistory ;
    MMContent.Lines.Clear;

  finally
    LstStrDept.Free ;
    LstStrEmp.Free ;
  end;
end;

procedure TFrmSendMsg.ReflashHistory;
begin
 
    self.QryHistory.Close;
    QryHistory.Parameters[0].Value :=logininfo.EmpId ;
    QryHistory.Open;

    MMHistory.Clear;
    while (not qryhistory.Eof ) do
    begin
        MMHistory.Lines.Insert(0,  QryHistory.FieldByName('FCreateTime').AsString +'  '+QryHistory.FieldByName('FempName').AsString+':  '+QryHistory.FieldByName('FMsgcontent').AsString ) ;
        QryHistory.Next;
    end;
end;

procedure TFrmSendMsg.Button1Click(Sender: TObject);
begin
ReflashHistory ;
end;

procedure TFrmSendMsg.BtnReceivedMsgClick(Sender: TObject);
begin

grpReceivedMsg.Visible :=not grpReceivedMsg.Visible ;
  self.Splitter1.Visible:=not self.Splitter1.Visible;
end;

procedure TFrmSendMsg.Timer1Timer(Sender: TObject);
var sql:string;
var pDeptCode :string;

begin
    //self.QryContent
    //1 receive
    //2 show record

    self.QryReceivedMsg.close;
    self.QryReceivedMsg.SQL.Clear;
    self.QryReceivedMsg.SQL.Text :='select FdeptCode from Temployee where FempCode ='+quotedstr(logininfo.EmpId)  ;
    self.QryReceivedMsg.Open;
    pDeptCode:=QryReceivedMsg.Fields[0].AsString;

    self.QryReceivedMsg.close;
    self.QryReceivedMsg.SQL.Clear;
    if  pDeptCode<>'' then
    begin
        self.QryReceivedMsg.SQL.Add (' INSERT INTO TMessageRec(F_ID,FMsgCode, FDeptCode,Fempcode) ');
        self.QryReceivedMsg.SQL.Add (' SELECT newid(),F_ID  ');
        self.QryReceivedMsg.SQL.Add ('  , '+quotedstr(pDeptCode) +',' +quotedstr(logininfo.EmpId) );
        self.QryReceivedMsg.SQL.Add (' FROM TMessage   A        ');
        self.QryReceivedMsg.SQL.Add (' where	( ' +quotedstr(logininfo.EmpId) +' in (Frecemps) or	'+quotedstr(pDeptCode) +' in (FRecDepts) ) ');
        self.QryReceivedMsg.SQL.Add (' and FCreateEmp<>'+quotedstr(logininfo.EmpId) );
        self.QryReceivedMsg.SQL.Add (' and A.F_ID not in (select FMsgCode FROM TMessageRec where FempCode = '+quotedstr(logininfo.EmpId) +') ');


        self.QryReceivedMsg.ExecSQL ;


        self.QryReceivedMsg.close;
        self.QryReceivedMsg.SQL.Clear;
        self.QryReceivedMsg.SQL.Add (' select top 18 A.*,emp.FempName from TMessage A join TMessageRec b on A.F_ID=B.FMsgCode ');
        self.QryReceivedMsg.SQL.Add (' left join Temployee emp on emp.FempCode=A.FCreateEmp    ');
        self.QryReceivedMsg.SQL.Add ('  where B.FempCode='+quotedstr(logininfo.EmpId)  );
        self.QryReceivedMsg.SQL.Add ('   order by A.FCreateTime desc ' );

        self.QryReceivedMsg.Open;

        mmReceivedMsg.Lines.Clear;
        if not self.QryReceivedMsg.IsEmpty then
          while(not self.QryReceivedMsg.Eof ) do
          begin
   
               mmReceivedMsg.Lines.Insert(0,  QryReceivedMsg.FieldByName('FCreateTime').AsString +'  '+QryReceivedMsg.FieldByName('FempName').AsString+':  '+QryReceivedMsg.FieldByName('FMsgcontent').AsString ) ;
               QryReceivedMsg.Next;
          end;
    end;

end;

end.

