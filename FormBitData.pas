unit FormBitData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TBitDataForm }

  TBitDataForm = class(TForm)
    QuitButton: TButton;
    SaveButton: TButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  BitDataForm: TBitDataForm;

implementation

{$R *.lfm}

end.

