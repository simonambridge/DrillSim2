Unit DrillSimClear;

Interface

Uses Crt,
     DrillSimVariables,
     SimulateInit,
     SimulateSurfaceControls,
     SimulateHoleCalcs,
     SimulateMessageToMemo,
     SimulateUpdate;

{* Called from:
DrillSimStatrtup

*}

Procedure Clear;
Procedure InitData;

Implementation

Procedure InitData;     { Used to set everything to empty at start-up}
Var i : integer;
    x : real;
Begin
  With Data do
  Begin
    NeverSimulated:=True;       { set NeverSimulated - this will be a new file }
    Bingham:=False;
    WellOperator:='';
    WellName    :='';
    Offshore:=False;
    Riser   :=False;
    Casing  :=False;
    Liner   :=False;
    CsgTD:=Zero; CsgID:=Zero;
    RsrTD:=Zero; RsrID:=Zero;
    LinerTop:=Zero; LinerTD:=Zero; LinerID:=Zero; Dev:=Zero;
    WaterDepth:=Zero;
    ElevationRKB       :=Zero;

    Maxholes:=1;
    For i:=1 to 2 do
    Begin
      Hole[i,1]:=Zero;
      Hole[i,2]:=Zero;
    End;

    Maxpipes:=1;
    For i:=1 to 4 do
    Begin
      Pipe[i,1]:=Zero;
      Pipe[i,2]:=Zero;
      Pipe[i,3]:=Zero;
      Pipe[i,4]:=Zero;          { pipe wt. unassigned in HyCalc }
    End;

    For i:=1 to 4 do
    Begin
      Surf[i,1]:=Zero;
      Surf[i,2]:=Zero;
    End;

    MaxPumps:=1;
    For i:=1 to 3 do
    Begin
      Pump[i,1]:=Zero;
      Pump[i,2]:=Zero;
      Pump[i,3]:=Zero;
      Pump[i,4]:=Zero;
      Pump[i,5]:=Zero;
    End;
    MaxPress  :=Zero;

    MaxJets :=4;
    For i:=1 to MaxJets do Jet[i]:=Zero;
    Bit    :=Zero;
    BitType :='';

    MudYp  :=Zero;
    MudWt  :=Zero;
    MudPv  :=Zero;
    MudGel :=Zero;

    ChokeLineID:=Zero;
    KillLineID:=Zero;

    LotTD :=Zero;             { these simulator variables are here because }
    LotMW :=Zero;             { they are edited in Proc. UpdateKick and    }
    LotEMW:=Zero;             { must be set to 0 for a new file            }
    LotPressure:=Zero;
    BurstPressure:=Zero;
    RetPitVol:=100;

    Rock[1].Depth:=Hole[MaxHoles,1];   { define default formation }
    Rock[1].Hardness:=1;
    if Offshore then x:=0.442 else x:=0.4332; { x = norm. gradient * 0.052 }
    Rock[1].FP:=((Hole[MaxHoles,1] * con[1]) * x) / con[3];
    For i:=2 to 10 do                  { and zero the rest        }
    Begin
      Rock[i].Depth:=Zero;
      Rock[i].Hardness:=Zero;
      Rock[i].FP:=Zero;
    End;

    For i:=1 to 5 do
    Begin
      UserCon[i]:=Zero;
      UserLab[i]:='   ';
      UserType:='Undefined';
    End;
  End;
End;


Procedure Clear;  { used to reset a running simulation }
Var i : integer;
Begin
  With Data do
  Begin
    ResetToLoadedValues;   { restore original MudWt's, depths, RetPitVol   }
    NeverSimulated:=True;;          { make it look like a new file - }
    InitKick;          { - and force it to initialise circulation etc  }
                       { values from OriginalMudWt, Yp, Pv etc         }
    HyDril:=False;              { set all RAMs to open                       }
    PipeRam:=False;             { ShutIn set FALSE in RamCheck               }
    BlindRam:=False;
    Choke:=0;                   { set choke valve to closed                  }
    SetSurfControls;            { calls RamCheck (reset BOP's, ExcessMud)    }
                                { resets Choke                               }
    For i:=1 to MaxPumps do Pump[i,3]:=Zero;

    SimHoleCalc;                     { do HoleCalc and initialise volumes  }
    MudVol:=HoleVol;
    KelHt:=33;                       { initialise kelly height             }
    //InitialiseKelly;                 { clear box, draw scale and set up    }
    SetKelly;                        { use SetKelly to set it up for future}
                                     { use                                 }
    MessageToMemo(5);
  End;
End;

Begin
End.