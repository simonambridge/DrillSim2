unit FormConfigDefaults;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLType,
  DrillSimVariables,
  DrillSimMessageToMemo,
  DrillSimFile;

type

  { TSystemDefaultsForm }

  TSystemDefaultsForm = class(TForm)
    Cancel: TButton;
    Save: TButton;
    DefaultWellFileButton: TButton;
    DefaultWellFileData: TEdit;
    DefaultWellFile: TLabel;
    procedure FormClose(Sender: TObject);
    procedure DefaultWellFileButtonClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    Procedure FormCreateActions;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SystemDefaultsForm         : TSystemDefaultsForm;
  _WellDefaultDataFile   : String120;

implementation

{$R *.lfm}

{ TSystemDefaultsForm }

procedure TSystemDefaultsForm.DefaultWellFileButtonClick(Sender: TObject);
var
  saveDialog : TSaveDialog;    // Save dialog variable
begin
  // Create the save dialog object - assign to our save dialog variable
  saveDialog := TSaveDialog.Create(self);

  // Give the dialog a title
  saveDialog.Title := 'Select Default Well Data File';

  // Set up the starting directory to be the current one
  saveDialog.InitialDir := GetCurrentDir;

  // Allow only filtered file types to be saved
  saveDialog.Filter := 'DrillSim data file|*.wdf|All Files|*.*';

  // Set the default extension
  saveDialog.DefaultExt := 'wdf';

  // Select text files as the starting filter type
  saveDialog.FilterIndex := 1;

  // Display the open file dialog
  if saveDialog.Execute then
  Begin
    _WellDefaultDataFile:=saveDialog.FileName;  // set global active file name variable
    DefaultWellFileData.Text:=_WellDefaultDataFile;
  end;
  saveDialog.Free; // Free up the dialog
end;

procedure TSystemDefaultsForm.CancelClick(Sender: TObject);
begin
  Close
end;

procedure TSystemDefaultsForm.FormClose(Sender: TObject);
begin
  Close;
end;

procedure TSystemDefaultsForm.SaveClick(Sender: TObject);
begin
  AssignFile(Textfile,SystemPropertiesFile);         { /path/drillsim.cfg }
  {$I+}
  try
    Rewrite(TextFile);
    Writeln(TextFile, _WellDefaultDataFile); { write location of default well file }
    CloseFile(TextFile);
    StringToMemo('FormConfigDefaults.SaveClick: Default well data file ' + SystemPropertiesFile + ' updated');
    StringToMemo('Default file='+ _WellDefaultDataFile);
    DefaultWellDataFile:=_WellDefaultDataFile;
    Close;
  except
    // If there was an error the reason can be found here
    on E: EInOutError do
       ShowMessage('Error Saving Details: ' + SystemPropertiesFile + ': ' + E.ClassName + '/' + E.Message);
  end;
end;

Procedure TSystemDefaultsForm.FormCreateActions;
Begin
end;

procedure TSystemDefaultsForm.FormCreate(Sender: TObject);
begin
  FormCreateActions;
end;


procedure TSystemDefaultsForm.FormActivate(Sender: TObject);
begin
   StringToMemo('Form System Defaults activated....');
   _WellDefaultDataFile:=DefaultWellDataFile;
   DefaultWellFileData.Text:=DefaultWellDataFile;
End;

end.

