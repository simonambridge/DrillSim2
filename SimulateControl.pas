Unit SimulateControl;

Interface

Uses DrillSimVariables,
     SimulateHydraulicCalcs,
     SimulateDrillingCalcs,
     SimulateControlChecks,
     SimulateUpdate,
     SimulateKick;

Procedure Control;

Implementation

Procedure Control;
Label Loop;                { This looping is deliberate, not bad programming }
Label Done;
Begin
Loop :
  HyCalc;
  TimeUpdate;

  // InputScan;   now done in the GUI
  if Quit then Goto Done;

  { check for hole deeper then next horizon          }
  { if yes, check if next horizon data is valid (>0) }
  { if yes, advance RockPointer and calculate new    }
  { formation pressure gradient                      }

  ControlChecks;

  DrillCalc;

  // InputScan;   now done in the GUI
  if Quit then Goto Done;

  KickCalc;
  if Quit then Goto Done;

  // InputScan;   now done in the GUI
  if Quit then Goto Done;

  Goto Loop;
Done :
  ChDir(OriginDirectory);{ to ensure correct startup in DS if HyCalc used  }
End;

Begin
End.