Unit SimulateClear;

Interface

Uses Crt,
     DrillSimVariables,
     SimulateInit,
     SimulateSurfaceControls,
     SimulateHoleCalcs,
     SimulateScreen,
     SimulateMessageToMemo,
     SimulateUpdate;


Procedure Clear;

Implementation

Procedure Clear;
Var i : integer;
Begin
  With Data do
  Begin
    ResetToOriginal;   { restore original MudWt's, depths, RetPitVol   }
    NewIf0:=0;         { make it look like a new file - }
    InitKick;          { - and force it to initialise circulation etc  }
                       { values from OriginalMudWt, Yp, Pv etc         }
    HyDril:=False;              { set all RAMs to open                       }
    PipeRam:=False;             { ShutIn set FALSE in RamCheck               }
    BlindRam:=False;
    Choke:=0;                   { set choke valve to closed                  }
    SetSurfControls;            { calls RamCheck (reset BOP's, ExcessMud)    }
                                { resets Choke                               }
    For i:=1 to MaxPumps do Pump[i,3]:=Zero;

    SimHoleCalc;                        { do HoleCalc and initialise volumes  }
    MudVol:=HoleVol;
    KelHt:=33;                       { initialise kelly height             }
    InitialiseKelly;                 { clear box, draw scale and set up    }
    SetKelly;                        { use SetKelly to set it up for future}
                                     { use                                 }
    MessageToMemo(5);
    gotoxy(39,12);
  End;
End;

Begin
End.