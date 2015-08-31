unit FormGeologyData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TGeologyDataForm }

  TGeologyDataForm = class(TForm)
    QuitButton: TButton;
    SaveButton: TButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  GeologyDataForm: TGeologyDataForm;

implementation

{$R *.lfm}

end.

