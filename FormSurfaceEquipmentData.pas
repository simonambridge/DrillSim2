unit FormSurfaceEquipmentData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TSurfaceEquipmentDataForm }

  TSurfaceEquipmentDataForm = class(TForm)
    QuitButton: TButton;
    SaveButton: TButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SurfaceEquipmentDataForm: TSurfaceEquipmentDataForm;

implementation

{$R *.lfm}

end.

