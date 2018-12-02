unit Date;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, db, dbctrls;

type
  TDateFrm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    MonthCalendar1: TMonthCalendar;
    ChkNull: TCheckBox;
    TimeTPicker: TDateTimePicker;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}



end.
