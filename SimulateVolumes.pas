Unit SimulateVolumes;

Interface

Uses DrillSimVariables;

Procedure VolCalc; { called in HoleCalc and RamCheck }
Function BblPerFoot(x : real) : real;

Implementation

Function BblPerFoot(x : real) : real;
Begin
  BBlPerFoot:=sqr(x) / VolCon;
End;

Procedure VolCalc; { called in HoleCalc and RamCheck }
Var i : integer;
    x,y,z,w : real;

{ ***************************************************************************

Subject : maintaining integrity of MudVol - actual circulating volume
            of mud in the well (including pipe capacity).
        
  MudVol not modified here because VolCalc (this procedure) is called
  in HoleCalc, (which is called when the TD increases by 0.001 ft or more),
  and mudvol is maintained by the flow manager in procedure KickCalc. MudVol
  should only be reset to HoleVol when initialising. MudVol is therefore
  only set to HoleVol in InitKick if NeverSimulated, ie at start-up, or when
  "CLEAR"ing, or when loading a file.

  MudVol summary : set to HoleVol in DrillSim (after a HoleCalc).
                   modified in KickCalc according to flow.
                   set to plus ExcessMud in RamCheck (ie = HoleVol)
                   set to minus ExcessMud in RamCheck (ie shut in)

  ExcessMud calculated in Proc. RamCheck from MudVol - HoleVol when
  shutting in. Only a problem if MudVol less than calculated shut in
  volume when shutting in - very unlikely.

  HoleSection assigned as follows : HoleSection[i,1]:= section length
                                    HoleSection[i,2]:= section hole ID
                                    HoleSection[i,3]:= section Pipe OD
                                    HoleSection[i,4]:= section Pipe ID

**************************************************************************}

Begin
  With Data do
  Begin
    { Set up well volume below before calculating from HoleSection[i].
     Initially set to zero, ExtraVolume is only non-zero if off-bottom
     Well Volume is still correct because it includes the ExtraVolume.
     Annular volume is compensated for non-circulating volume. }

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        WellVol:=ExtraVolume;
    PipeCap:=Zero;
    PipeDis:=Zero;

    For i:=1 to TotHoleSections do
          WellVol:=WellVol + HoleSection[i,1] * BblPerFoot(HoleSection[i,2]);

    For i:=1 to MaxPipes do
    Begin
      PipeCap:=PipeCap + Pipe[i,1] * BblPerFoot(Pipe[i,2]);
      PipeDis:=PipeDis + Pipe[i,1] * BblPerFoot(Pipe[i,3]);
      FillCE[i]:=BblPerFoot(Pipe[i,3]) * StandLen;
      FillOE[i]:=(BblPerFoot(Pipe[i,3])-BblPerFoot(Pipe[i,2])) * StandLen;
    End;

    AnnVol:=(WellVol - ExtraVolume) - PipeDis;  { don't include extra volume }
    HoleVol:=AnnVol + PipeCap + ExtraVolume;    { vol of mud in hole }

{ adjust volumes if shut in with sub-sea wellhead. Uses
  HoleSection[1,x] - riser can only be the first hole section }

    if Riser and ShutIn then
    Begin
      x:=HoleSection[1,1] * BblPerFoot(HoleSection[1,2]); { riser volume     }
      y:=HoleSection[1,1] * BblPerFoot(HoleSection[1,3]); { riser pipe dis.t }
      z:=HoleSection[1,1] * BblPerFoot(HoleSection[1,4]); { riser pipe cap.y }
      w:=HoleSection[1,1] * BblPerFoot(ChokeLineID);      { choke line cap.y }
      HoleVol:=(HoleVol - x) + z + w;       { HoleVol = circulating vol }
      PipeDis:=PipeDis - y;                 { WellVol = empty well vol }
      PipeCap:=PipeCap - z;                 { MudVol  = actual circ. vol }
      AnnVol:=AnnVol - (x-y);               { AnnVol = ann vol exc non-circ vol }
    End;
  End;
End;


Begin
End.