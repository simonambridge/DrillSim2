program DrillSim3;

{$mode objfpc}{$H+}
{ To make a demo copy, delete procedure SaveData and replace with
  the file in NoSave.Pas which prints a message screen }

uses
  {$IFDEF UNIX} //{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF} //{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  { you can add units after this }
  DrillSimVariables,
  DrillSimStartup,
  DrillSimFile,
  DrillSimMessageToMemo,
  DrillSimGUI,
  FormGeneralData,
  FormHoleData,
  FormConfigDefaults, FormPipeData, FormBitData,
FormPumpData, FormSurfaceEquipmentData, FormWellTestData,
FormGeologyData, FormMudData, FormDisplayWellData, FormUnitsOfMeasure;

{$R *.res}

begin

  RequireDerivedFormResource := True;

  writeln('DrillSim3.lpr : Application.Initialize');
  Application.Initialize;

  // Build GUI, run DrillSim StartUp
  writeln('DrillSim3.lpr : Application.CreateForm');
  Application.CreateForm(TDrillSim, DrillSim);
  Application.CreateForm(TGeneralDataForm, GeneralDataForm);
  Application.CreateForm(TDisplayWellDataForm, DisplayWellDataForm);
  Application.CreateForm(TSystemDefaultsForm, SystemDefaultsForm);
  Application.CreateForm(THoleDataForm, HoleDataForm);
  Application.CreateForm(TPipeDataForm, PipeDataForm);
  Application.CreateForm(TBitDataForm, BitDataForm);
  Application.CreateForm(TPumpDataForm, PumpDataForm);
  Application.CreateForm(TSurfaceEquipmentDataForm, SurfaceEquipmentDataForm);
  Application.CreateForm(TWellTestDataForm, WellTestDataForm);
  Application.CreateForm(TGeologyDataForm, GeologyDataForm);
  Application.CreateForm(TMudDataForm, MudDataForm);
  StringToMemo('Initialise Form: DrillSim');
  StringToMemo('Initialise Form: General Well Data');
  StringToMemo('Initialise Form: Summary Well Data');
  StringToMemo('Initialise Form: Units Of Measure');
  StringToMemo('Initialise Form: System Defaults');
  StringToMemo('Initialise Form: Well Hole Profile');
  StringToMemo('Initialise Form: Well Pipe Profile');
  StringToMemo('Initialise Form: Well Drill Bit Data');
  StringToMemo('Initialise Form: Well Drilling Fluid Data');
  StringToMemo('Initialise Form: Rig Pump Data');
  StringToMemo('Initialise Form: Rig Surface Equipment Data');
  StringToMemo('Initialise Form: Well Test Data');
  StringToMemo('Initialise Form: Well Geology Data');

  Application.Run;

  StringToMemo('===============================');
  StringToMemo('* DrillSim3 shutdown complete *');
  StringToMemo('===============================');

  writeln('Exiting');

end.

