unit UnitAdoDataset;


interface

  uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, ADODB,
  Dialogs;

      type TAdoDatasetColor=class(TADODataSet)
      Public
         ColorID:integer;
         Constructor create(aowner:Tcomponent);override;
      end;
implementation

{ TAdoDatasetColor }

constructor TAdoDatasetColor.create(aowner: Tcomponent);
begin
  inherited;
self.ColorID :=-1;
end;

end.
