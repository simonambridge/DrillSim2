unit FormLoadFile;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;

type

  { TForm2 }


  TLoadFileForm = class(TForm)
    OpenDialog1: TOpenDialog;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  LoadFileForm: TLoadFileForm;

implementation

{$R *.lfm}


procedure TLoadFileForm.Button1Click(Sender: TObject);
var
  filename: string;
begin


if OpenDialog1.Execute then
   begin
        filename := OpenDialog1.Filename;
        memo1.Lines.LoadFromFile(opendialog1.FileName);
   end;
end;
end.

