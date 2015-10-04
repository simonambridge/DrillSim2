Unit DrillSimDataResets;

Interface

Uses Crt,
     DrillSimVariables,
     SimulateSurfaceControls,
     SimulateHoleCalcs,
     DrillSimMessageToMemo,
     SimulateUpdate;

{* Called from:
DrillSimStatrtup
...
*}

Procedure Clear;
Procedure InitData;

Procedure ResetToLoadedValues;               { call this from CLEAR to reset to }
Procedure InitKick;  { only used by Simulate.Chn at startup, Load and CLEAR }
Procedure InitMud; { called from LoadData }
Procedure InitDepth;
Procedure InitGeology;        { called on each entry into Simulator, and    }
                              { whenever Loaded or Cleared                  }

Implementation

Procedure InitData;     { Used to set everything to empty at start-up}
Var i : integer;
    x : real;
Begin
  StringToMemo('Initialise - DrillSimDataResets:InitData called');
  With Data do
  Begin
    Simulating:=False;
    Paused:=False;
    NoFileDefined    :=True;
    DefaultWellDataFile:='';
    CurrentFQFileName:='';
    NeverSimulated   :=True;       { set NeverSimulated - this will be a new file }
    Bingham          :=False;
    WellOperator     :='';
    WellName         :='';
    Offshore         :=False;
    SubSeaWellHead   :=False;
    Riser            :=False;
    Casing           :=False;
    Liner            :=False;
    CasingTD         :=Zero;
    CasingID         :=Zero;
    RiserTD          :=Zero;
    RiserID          :=Zero;
    LinerTopTD       :=Zero;
    LinerBottomTD    :=Zero;
    LinerID          :=Zero;
    DeviationDegrees :=Zero;
    WaterDepth       :=Zero;
    ElevationRKB     :=Zero;

    MaxHoles:=0;
    For i:=1 to 3 do
    Begin
      Hole[i,1]:=Zero;          { depth }
      Hole[i,2]:=Zero;          { ID }
    End;

    Maxpipes:=1;                { must be at least one section of drill pipe }
    For i:=1 to 3 do            { data file caters for up to 4 but we only use 3 }
    Begin
      Pipe[i,1]:=Zero;          { pipe length }
      Pipe[i,2]:=Zero;          { pipe ID }
      Pipe[i,3]:=Zero;          { pipe OD }
      Pipe[i,4]:=Zero;          { pipe wt. }
    End;

    For i:=1 to 4 do            { kelly, swivel, hose and standpipe }
    Begin
      Surf[i,1]:=Zero;          { length }
      Surf[i,2]:=Zero;          { ID }
    End;

    MaxPumps:=1;
    For i:=1 to 3 do
    Begin
      Pump[i,1]:=Zero;          { output }
      Pump[i,2]:=Zero;          { efficiency }
      Pump[i,3]:=Zero;          { @ strokes per minute }
      Pump[i,4]:=Zero;          { SPM }
      Pump[i,5]:=Zero;          { not used }
    End;
    MaxPumpPressure  :=Zero;

    MaxJets :=4;
    For i:=1 to MaxJets do Jet[i]:=Zero;
    BitNumber    :=Zero;
    BitType :='';

    MudYp  :=Zero;
    MudWt  :=Zero;
    MudPv  :=Zero;
    MudGel :=Zero;

    ChokeLineID:=Zero;
    KillLineID:=Zero;

    LotTD :=Zero;
    LotMW :=Zero;
    LotEMW:=Zero;
    LotPressure:=Zero;
    CasingBurstPressure:=Zero;

    RetPitVol:=100;

//    Formation[1].Depth:=Hole[MaxHoles,1];   { define default formation }
//    Formation[1].Hardness:=1;
//    if Offshore then x:=0.442 else x:=0.4332; { x = norm. gradient * 0.052 }
//    Formation[1].FP:=((Hole[MaxHoles,1] * UoMConverter[1]) * x) / UoMConverter[3];

    For i:=1 to 10 do                  { and zero the rest        }
    Begin
      Formation[i].Depth:=Zero;
      Formation[i].Hardness:=Zero;
      Formation[i].FP:=Zero;
    End;

{*     For i:=1 to 5 do        user defined units not supported
    Begin
      UserCon[i]:=Zero;
      UserLab[i]:='   ';
      UnitType:='Undefined';
    End;
    *}
  End;
End;


Procedure Clear;  { used to reset a running simulation }
Var i : integer;
Begin
  StringToMemo('DrillSimDataResets:Simulation reset - Clear called');
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
    KellyHeight:=33;                       { initialise kelly height             }
    LastKellyHeight:=33;             { initialise kelly height             }
    KellyImageIndex:=0;              { initialise kelly image index        }
    SetKelly;                        { use SetKelly to set it up for future}
                                     { use                                 }
    MessageToMemo(5);
  End;
End;

Procedure ResetToLoadedValues;               { call this from CLEAR to reset to }
Begin                                        { start-up values                  }
  StringToMemo('DrillSimDataResets:ResetToLoadedValues called');
  With Data do
  Begin
    Hole[MaxHoles,1]:=OriginalHoleDepth;
    Pipe[MaxPipes,1]:=OriginalPipeDepth;
    MudWt:=OriginalMudWt;
    MudPV:=OriginalMudPV;
    MudYP:=OriginalMudYP;
    RetPitVol:=OriginalPitVolume;
  End;
End;

Procedure InitMud; { called from LoadData }
Begin              { called at start of simulation when starting a }
  StringToMemo('DrillSimDataResets:InitMud called');
  With Data do     { session with a file, and called in LoadData in Simulate }
  Begin
    OriginalMudWt:=MudWt;                { not file variables and must      }
    OriginalMudPV:=MudPV;                { therefore be initialised before  }
    OriginalMudYP:=MudYP;                { they are used when Simulate is       }
    OriginalPitVolume:=RetPitVol;        { started or a file is loaded.     }
  End;
End;

Procedure InitDepth;
Begin
  StringToMemo('DrillSimDataResets:InitDepth called');
  With Data do
  Begin
    OriginalHoleDepth:=Hole[MaxHoles,1]; { this proc. called, like InitMud,   }
    OriginalPipeDepth:=Pipe[MaxPipes,1]; { when a file is loaded to save the  }
                                         { start depth, also called when      }
                                         { entering from DrillSim             }
  End;
End;


Procedure InitKick;  { only used at startup, Load and CLEAR }
Var i : integer;     { CLEAR sets NeverSimulated to force complete initialisation }
Begin
  StringToMemo('DrillSimDataResets:InitKick called');
  With Data do
  Begin
      t1           :=Zero;                  { no problem if file not saved }
      t2           :=Zero;                     { after this initialisation }
                                               { because it will be reset  }
      ROPt1        :=Zero;                     { each time until saved     }
      ROPt2        :=Zero;                     { after entering Simulate       }

      RPMt1        :=Zero;
      RPMt2        :=Zero;
      LastHundredths   :=Zero;

      Pumping     :=false;          { set up for drilling }
      Drilling    :=false;
      AutoDrill   :=false;
      ShutIn      :=false;
      BlindRam    :=false;
      PipeRam     :=false;
      Hydril      :=false;
      FlowLine    :=false;
      UpdateFlow  :=false;

      ElapsedTime      :=Zero;
      ElapsedFlow      :=Zero;

      AnnUnderbalance  :=Zero;
      CasingPressure   :=Zero;
      DeltaCsgPr       :=Zero;

      WaterFraction    :=Zero;
      OilFraction      :=Zero;
      SolidsFraction   :=Zero;
      WOB              :=Zero;
      WOH              :=Zero;
      ROP              :=Zero;
      RPM              :=Zero;
      OverDrill        :=Zero;

      Influx           :=Zero;
      InfluxRate       :=Zero;
      InfluxDensity    :=Zero;
      BleedOffRate     :=Zero;
      BleedOff         :=Zero;
      PipeRAMRating    :=Zero;
      HydrilRating     :=Zero;

      For i:=1 to MaxPumps do Pump[i,3]:=Zero; { reset pump strokes      }

      StackPointer              :=Zero;        { circulation stack empty }
      CircStack[1].MW           :=Zero;        { therefore no new mud on }
      CircStack[1].StartStrokes :=Zero;        { it's way round.         }
      TotCircStrks :=Zero;
      TotStrks     :=Zero;

      MudOut.StartStrokes :=Zero;              { Mud out is same as mud in }
      MudOut.MW           :=MudWt;
      MudOut.PV           :=MudPV;
      MudOut.YP           :=MudYP;

      MWIn         :=MudWt;                    { MudWt from DrillSim/HyCalc }
      MWOut        :=MudWt;                    { is used as mud wt. in      }

      AnnMW        :=MudWt;                    { ditto for variables used to }
      AnnPV        :=MudPV;                    { calculate hydrostatics etc  }
      AnnYP        :=MudYP;                    { from CircStack.             }

      PipeMW       :=MudWt;
      PipePV       :=MudPV;
      PipeYP       :=MudYP;

      StrokeCounter:=Zero;          { set stroke counter to zero             }
      Status       :=Zero;          { force a status display in StatusUpdate }

      LastKellyHeight:=33;          { initialise last kelly height           }
      KellyHeight  :=33;
      LastKD       :=PipeTD;        { initialize for next KD (=LastKD+27)    }


      DrillMult:=10;          { default value of 10 for drilling accelerator }
      ExcessMud:=Zero;                             { no excess to start with }

      FlowIn           :=Zero;
      FlowOut          :=Zero;

      PlSurf           :=Zero;
      PlPipe           :=Zero;
      PlBit            :=Zero;
      PlAnn            :=Zero;
      PlCirc           :=Zero;
      MACP             :=Zero;

      JetVel           :=Zero;
      ImpForce         :=Zero;
      BitHp            :=Zero;
      Eff              :=Zero;
      TotHP            :=Zero;
      AverageHhd       :=Zero;
      PipeHhd          :=Zero;
      AnnHhd           :=Zero;
      BHPAnn           :=Zero;
      Ecd              :=Zero;
      Ff               :=Zero;
      Rn               :=Zero;
      Fn               :=Zero;
      Fk               :=Zero;

      For i:=1 to 9 do
      Begin
        Vel[i,1]:=Zero;
        Vel[i,2]:=Zero;
        Vel[i,3]:=Zero;
      End;
                                    { PipeTD initialised in HyCalc/DrillSim  }
                                    { and also in Proc. DrillCalc. PipeTD is }
                                    { initialised in DrillSim, for use here  }
                                    { and in the HyCalc Optimiser            }

    HoleCalcCounter:=Zero;          { start at 0 - counts to 10              }
    HyCalcCounter  :=20;            { force an initial StackCalc etc         }
    ROPCalcCounter :=Zero;          { force an ROPCalc if drilling           }
    CalculatedSoFar:=Zero;          { force an initial hydraulics calculation}
                                    { based on value of HyCalcCounter        }
    StatusCounter  :=zero;          { start from 0 - this is incremented and }
                                    { when it gets to 10 will do StatusUpdate}

    LastPitGain    :=Zero;          { reset for new display   }
    ChokeLinePl    :=Zero;
    PlChoke        :=Zero;
    Choke          :=Zero;
    TwistOff       :=Zero;

    Input          :=Space;

    ThisString     :='';
    PreviousString :='';
    LastString     :='';
    CurrentTurn    :=Zero;
    CurrentBushing :=1;
    Trace:=False;                   { initialise for future use }
  End;
End;

Procedure InitGeology;        { called on each entry into Simulator, and    }
Begin                         { whenever Loaded or Cleared                  }
  With Data do
  Begin
    FormationPointer:=1;                    { must be at least the first horizon }

    While (FormationPointer<=9) and (Hole[MaxHoles,1] > Formation[FormationPointer+1].Depth)
          and (Formation[FormationPointer+1].FP > Zero)
          and (Formation[FormationPointer+1].Hardness > Zero)
          and (Formation[FormationPointer+1].Depth > Formation[FormationPointer].Depth)
            do FormationPointer:=FormationPointer + 1;
    FormationPressureGradient:=               { calculate here for ROPCalc }
                (Formation[FormationPointer].FP / Formation[FormationPointer].Depth) / Presscon;
  End;
End;

Begin
End.
