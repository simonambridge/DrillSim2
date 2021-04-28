program DrillSim3;

{$mode objfpc}{$H+}
{ To make a demo copy, delete procedure SaveData and replace with
  the file in NoSave.Pas which prints a message screen }

uses
  {$ifdef unix}
    cthreads,
    //cmem, // the c memory manager is on some systems much faster for multi-threading
  {$endif}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, lazcontrols,

  DrillSimGUI,
  FormGeneralData,
  FormHoleData,
  FormConfigDefaults,
  FormPipeData,
  FormBitData,
  FormPumpData,
  FormSurfaceEquipmentData,
  FormWellTestData,
  FormGeologyData,
  FormMudData,
  FormDisplayWellData,
  FormUnitsOfMeasure,
  uversion;

{$R *.res}


begin

  RequireDerivedFormResource := True;

  writeln('DrillSim3.lpr : Application.Initialize');
  Application.Scaled:=True;
  Application.Initialize;

  // Build GUI, run DrillSim StartUp
  writeln('DrillSim3.lpr - call Application.CreateForm for each application form');
  Application.CreateForm(TDrillSim, DrillSim);
  Application.CreateForm(TGeneralDataForm, GeneralDataForm);
  Application.CreateForm(TDisplayWellDataForm, DisplayWellDataForm);
  Application.CreateForm(TSystemDefaultsForm, SystemDefaultsForm);
  Application.CreateForm(THoleDataForm, HoleDataForm);
  Application.CreateForm(TPipeDataForm, PipeDataForm);
  Application.CreateForm(TMudDataForm, MudDataForm);
  Application.CreateForm(TBitDataForm, BitDataForm);
  Application.CreateForm(TPumpDataForm, PumpDataForm);
  Application.CreateForm(TSurfaceEquipmentDataForm, SurfaceEquipmentDataForm);
  Application.CreateForm(TWellTestDataForm, WellTestDataForm);
  Application.CreateForm(TGeologyDataForm, GeologyDataForm);
  Application.CreateForm(TGeneralDataForm, GeneralDataForm);
  Application.CreateForm(TUnitsOfMeasureForm, UnitsOfMeasureForm);

  // Don;t use StringToMemo until startup complete
  writeln('DrillSim3.lpr - Initialise Form: DrillSim');
  writeln('DrillSim3.lpr - Initialise Form: General Well Data');
  writeln('DrillSim3.lpr - Initialise Form: Summary Well Data');
  writeln('DrillSim3.lpr - Initialise Form: Units Of Measure');
  writeln('DrillSim3.lpr - Initialise Form: System Defaults');
  writeln('DrillSim3.lpr - Initialise Form: Well Hole Profile');
  writeln('DrillSim3.lpr - Initialise Form: Well Pipe Profile');
  writeln('DrillSim3.lpr - Initialise Form: Well Drill Bit Data');
  writeln('DrillSim3.lpr - Initialise Form: Well Drilling Fluid Data');
  writeln('DrillSim3.lpr - Initialise Form: Rig Pump Data');
  writeln('DrillSim3.lpr - Initialise Form: Rig Surface Equipment Data');
  writeln('DrillSim3.lpr - Initialise Form: Well Test Data');
  writeln('DrillSim3.lpr - Initialise Form: Well Geology Data');
  writeln('DrillSim3.lpr - Initialise Form: General Data');
  writeln('DrillSim3.lpr - Initialise Form: Units Of Measure');

  Application.Run;

  writeln('===============================');
  writeln('* DrillSim3 shutdown complete *');
  writeln('===============================');



end.

