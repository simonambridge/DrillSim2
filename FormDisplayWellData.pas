unit FormDisplayWellData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TDisplayWellData }

  TDisplayWellData = class(TForm)
    StaticText1: TStaticText;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DisplayWellData: TDisplayWellData;

implementation

Uses DrillSimGUI;

{$R *.lfm}

end.

