Unit DrillSimUnitsOfMeasure;

Interface

Uses SysUtils,
  DrillSimVariables,
  DrillSimMessageToMemo;

Procedure MetricUnits;
Procedure APIUnits;

Implementation

Procedure MetricUnits;
Begin
  Data.API:=False;
  UoMDescriptor:='Metric';          { divide by these numbers to get API }
  ROPLab:='min/met';
  UoMConverter[1] :=3.28084;
  UoMConverter[2]:=8.345;
  UoMConverter[3]:=1.45033;
  UoMConverter[4]:=6.291;
  UoMConverter[5]:=0.264;
  UoMConverter[6]:=0.264;
  UoMConverter[7]:=2.2046;
  UoMLabel[1]:='met';
  UoMLabel[2]:='sg ';
  UoMLabel[3]:='KPa';
  UoMLabel[4]:='m3 ';
  UoMLabel[5]:='ltr';
  UoMLabel[6]:='lpm';
  UoMLabel[7]:='ton';
  StringToMemo('Metric Units selected. Depth units are '+UoMLabel[1]);
End;


Procedure APIUnits;      {* Assign values to UoMConverter[] and UoMLabel[] arrays *}
Begin
  Data.API:=True;
  UoMDescriptor:='API';
  ROPLab:='min/ft';
  UoMConverter[1]:=1;
  UoMConverter[2]:=1;
  UoMConverter[3]:=1;
  UoMConverter[4]:=1;
  UoMConverter[5]:=1;
  UoMConverter[6]:=1;
  UoMConverter[7]:=1;
  UoMLabel[1]:='ft.';
  UoMLabel[2]:='ppg';
  UoMLabel[3]:='psi';
  UoMLabel[4]:='bbl';
  UoMLabel[5]:='gal';
  UoMLabel[6]:='gpm';
  UoMLabel[7]:='Klb';
  StringToMemo('API Units selected. Depth units are '+UoMLabel[1]);
End;

Begin
End.