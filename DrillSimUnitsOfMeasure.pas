Unit DrillSimUnitsOfMeasure;

Interface

Uses SysUtils,
  DrillSimVariables,
  DrillSimMessageToMemo;

Procedure MetricUnits;
Procedure APIUnits;

Implementation

Uses DrillSimGUI;

Procedure DisplayLabels;
Begin
  With DrillSim do
  Begin
    BitDepthUoMLabel.Caption:=UoMLabel[1];           { depth feet or metres }
    TotalDepthUoMLabel.Caption:=UoMLabel[1];         { depth feet or metres }
    WOBUoMLabel.Caption:=UoMLabel[7];                { weight Klbs or metric tons }
    KellyHeightUoMLabel.Caption:=UoMLabel[1];        { depth feet or metres }
    ROPUoMLabel.Caption:=ROPLabel;
    MudWeightInUoMLabel.Caption:=UoMLabel[2];        { specific gravity ppg or sg }
    MudWeightOutUoMLabel.Caption:=UoMLabel[2];       { specific gravity ppg or sg }
    ECDUoMLabel.Caption:=UoMLabel[2];                { specific gravity ppg or sg }
    FlowInUoMLabel.Caption:=UoMLabel[6];             { flow litres or gals/minute }
    FlowOutUoMLabel.Caption:=UoMLabel[6];            { flow litres or gals/minute }
    DiffFlowUoMLabel.Caption:=UoMLabel[6];           { flow litres or gals/minute }
    ReturnPitUoMLabel.Caption:=UoMLabel[4];          { volume bbl or m3}
    StandPipePressureUoMLabel.Caption:=UoMLabel[3];  { pressure psi or KPa }
    AnnularPressureUoMLabel.Caption:=UoMLabel[3];    { pressure psi or KPa }
    CasingPressureUoMLabel.Caption:=UoMLabel[3];     { pressure psi or KPa }
  End;
end;

Procedure MetricUnits;
Begin
  Data.API:=False;
  UoMDescriptor:='Metric';          { divide by these numbers to get API }
  ROPLabel:='min/met';
  UoMConverter[1] :=3.28084;  { length feet -> metres      }
  UoMConverter[2]:=8.345;     { fluid ppg -> sg            }
  UoMConverter[3]:=1.45033;   { pressure psi -> KPa        }
  UoMConverter[4]:=6.291;     { volume bbls -> m3          }
  UoMConverter[5]:=0.264;     { volume gals -> litres      }
  UoMConverter[6]:=0.264;     { rate gpm -> lpm            }
  UoMConverter[7]:=2.2046;    { weight Klbs -> metric tons }
  UoMConverter[8]:=1;   { hidden - not used - ID's are always inches }
  UoMLabel[1]:='met';
  UoMLabel[2]:='sg ';
  UoMLabel[3]:='KPa';
  UoMLabel[4]:='m3 ';
  UoMLabel[5]:='ltr';
  UoMLabel[6]:='lpm';
  UoMLabel[7]:='ton';
  UoMLabel[8]:='ins';     { hidden - not used - ID's are always inches }

  DisplayLabels;
  StringToMemo('DrillSimUnitsOfMeasure.MetricUnits - Metric Units selected. Depth units are '+UoMLabel[1]);
End;


Procedure APIUnits;      {* Assign values to UoMConverter[] and UoMLabel[] arrays *}
Begin
  Data.API:=True;
  UoMDescriptor:='API';
  ROPLabel:='min/ft';
  UoMConverter[1]:=1;
  UoMConverter[2]:=1;
  UoMConverter[3]:=1;
  UoMConverter[4]:=1;
  UoMConverter[5]:=1;
  UoMConverter[6]:=1;
  UoMConverter[7]:=1;
  UoMConverter[8]:=1;      { hidden - not used - ID's are always inches }
  UoMLabel[1]:='ft.';
  UoMLabel[2]:='ppg';
  UoMLabel[3]:='psi';
  UoMLabel[4]:='bbl';
  UoMLabel[5]:='gal';
  UoMLabel[6]:='gpm';
  UoMLabel[7]:='Klb';
  UoMLabel[8]:='ins';      { hidden - not used - ID's are always inches }

  DisplayLabels;
  StringToMemo('DrillSimUnitsOfMeasure.APIUnits - API Units selected. Depth units are '+UoMLabel[1]);
End;

Begin
End.
