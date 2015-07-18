unit FormHoleData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { THoleData }

  THoleData = class(TForm)
    RiserTD: TStaticText;
    CasingYN: TStaticText;
    RiserID: TStaticText;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  HoleData: THoleData;

implementation

{$R *.lfm}

end.

