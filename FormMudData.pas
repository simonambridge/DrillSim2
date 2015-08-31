unit FormMudData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TMudDataForm }

  TMudDataForm = class(TForm)
    QuitButton: TButton;
    SaveButton: TButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MudDataForm: TMudDataForm;

implementation

{$R *.lfm}

end.

