unit UnitIBillEx;

interface
uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,ADODB, DB,StdCtrls;
 
type
    IBillEx = interface
           procedure SetParamDataset(  dataset :Tdataset);
           procedure InitFrm(FrmId:string);
           procedure OpenBill( code :string );
 
    end;
 implementation
end.
