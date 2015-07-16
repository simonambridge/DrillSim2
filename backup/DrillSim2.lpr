program DrillSim2;

{$mode objfpc}{$H+}
{ To make a demo copy, delete procedure SaveData and replace with
  the file in NoSave.Pas which prints a message screen }

uses
  {$IFDEF UNIX} //{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF} //{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, DrillSimGUI,
  { you can add units after this }
  DrillSimVariables,
  DrillSimStartup,
  DrillSimFile,
  DrillSimMenu,
  SimulateMessageToMemo;

{$R *.res}

begin

  RequireDerivedFormResource := True;

  writeln('DrillSim2.lpr : Application.Initialize');
  Application.Initialize;

  // Build GUI, run DrillSim StartUp : DrillSimGUI and DrillSimStartup
  writeln('DrillSim2.lpr : Application.CreateForm');
  Application.CreateForm(TDrillSim, DrillSim);

  StringToMemo('DrillSim2.lpr : Application.Run');
  Application.Run;


  // if ExitCheck then SaveData;       <- where's this set?
  if Edited then
  Begin
    writeln('Edited');
    // do some exit file save check
  End;

  writeln('Exiting');
  ChDir(OriginDirectory);

end.

