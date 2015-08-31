unit FormWellTestData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TWellTestDataForm }

  TWellTestDataForm = class(TForm)
    QuitButton: TButton;
    SaveButton: TButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  WellTestDataForm: TWellTestDataForm;

implementation

{$R *.lfm}

end.

