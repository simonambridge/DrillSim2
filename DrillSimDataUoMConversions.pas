Unit DrillSimDataUoMConversions;

Interface

Uses DrillSimVariables;

Procedure ConUser;
Procedure ConApi;
Procedure ConUserData;   { data not in ConUser }
Procedure ConUserKickData;
Procedure ConAPIKickData;

Implementation

Procedure ConUser;  {* Convert primary well drilling data to user units e.g. *}
Var i : integer;    {* For i:=1 to Maxholes do Hole[i,1]:=Hole[i,1]/UoMConverter[1]; *}
Begin
  With Data do
  Begin
    RsrTD      :=RsrTD/UoMConverter[1];
    CsgTD      :=CsgTD/UoMConverter[1];
    LinerTop   :=LinerTop/UoMConverter[1];
    LinerTD    :=LinerTD /UoMConverter[1];
    MaxPress   :=MaxPress/UoMConverter[3];
    ElevationRKB        :=ElevationRKB/UoMConverter[1];
    WaterDepth :=WaterDepth/UoMConverter[1];
    For i:=1 to Maxholes do Hole[i,1]:=Hole[i,1]/UoMConverter[1];
    For i:=1 to maxpipes do Pipe[i,1]:=Pipe[i,1]/UoMConverter[1];
    For i:=1 to 4        do Surf[i,1]:=Surf[i,1]/UoMConverter[1];
    For i:=1 to maxpumps do
    Begin
      Pump[i,1]:=Pump[i,1]/UoMConverter[5];
      Pump[i,5]:=Pump[i,5]/UoMConverter[3];
    End;
    MudWt      :=MudWt/UoMConverter[2];
  End;
End;


Procedure ConApi;
Var i : integer;
Begin
  With Data do
  Begin
    RsrTD:=RsrTD*UoMConverter[1];
    CsgTD:=CsgTD*UoMConverter[1];
    LinerTop:=LinerTop*UoMConverter[1];
    LinerTD :=LinerTD *UoMConverter[1];
    MaxPress:=MaxPress*UoMConverter[3];
    ElevationRKB     :=ElevationRKB*UoMConverter[1];
    WaterDepth:=WaterDepth*UoMConverter[1];
    For i:=1 to maxholes do Hole[i,1]:=Hole[i,1]*UoMConverter[1];
    For i:=1 to maxpipes do Pipe[i,1]:=Pipe[i,1]*UoMConverter[1];
    For i:=1 to 4        do Surf[i,1]:=Surf[i,1]*UoMConverter[1];
    For i:=1 to maxpumps do
    Begin
      Pump[i,1]:=Pump[i,1]*UoMConverter[5];
      Pump[i,5]:=Pump[i,5]*UoMConverter[3];
    End;
    MudWt:=MudWt*UoMConverter[2];
  End;
End;


Procedure ConUserData;   { data not in ConUser }
Var i : integer;
Begin
  With Data do
  Begin
    TD :=TD/UoMConverter[1];
    TVD:=TVD/UoMConverter[1];
    For i:=1 to MaxPipes do
    Begin
      FillCE[i] :=FillCE[i] / UoMConverter[4];
      FillOE[i] :=FillOE[i] / UoMConverter[4];
    End;
    WellVol:=WellVol / UoMConverter[4];
    HoleVol:=HoleVol / UoMConverter[4];
    AnnVol :=AnnVol / UoMConverter[4];
    PipeDis:=PipeDis / UoMConverter[4];
    PipeCap:=PipeCap / UoMConverter[4];
    FlowIn   :=FlowIn / UoMConverter[5];
    PlSurf :=PlSurf / UoMConverter[3];
    PlPipe :=PlPipe / UoMConverter[3];
    PlBit  :=PlBit  / UoMConverter[3];
    PlAnn  :=PlAnn  / UoMConverter[3];
    PlCirc  :=PlCirc  / UoMConverter[3];
    JetVel :=JetVel / UoMConverter[1];
    AverageHhd    :=AverageHhd    / UoMConverter[3];
    Bhcp   :=Bhcp   / UoMConverter[3];
    Ecd    :=Ecd    / UoMConverter[2];

    For i:=1 to TotHoleSections do
    Begin
      HoleSection[i,1]:=HoleSection[i,1]/UoMConverter[1];
      Vel[i,1]:=Vel[i,1]/UoMConverter[1];
      Vel[i,2]:=Vel[i,2]/UoMConverter[1];
      Vel[i,3]:=Vel[i,3]/UoMConverter[3];
    End;
  End;
End;

Procedure ConUserKickData; {* Convert kick variables to user units *}
Var i : integer;
Begin
  With Data do
  Begin
    TD :=TD/UoMConverter[1];
    TVD:=TVD/UoMConverter[1];
    LotTD:=LotTD / UoMConverter[1];
    LotMW:=LotMW / UoMConverter[2];
    LotEMW:=LotEMW / UoMConverter[2];
    LotPressure:=LotPressure / UoMConverter[3];
    BurstPressure:=BurstPressure / UoMConverter[3];
    For i:=1 to 10 do
    Begin
      if Rock[i].Depth > Zero then Rock[i].Depth:=Rock[i].Depth / UoMConverter[1];
      if Rock[i].FP    > Zero then Rock[i].FP   :=Rock[i].FP / UoMConverter[3];
    End;
    FormationPressureGradient:=FormationPressureGradient / UoMConverter[2];
  End;
End;


Procedure ConAPIKickData;
Var i : integer;
Begin
  With Data do
  Begin
    TD :=TD * UoMConverter[1];
    TVD:=TVD * UoMConverter[1];
    LotTD:=LotTD * UoMConverter[1];
    LotMW:=LotMW * UoMConverter[2];
    LotEMW:=LotEMW * UoMConverter[2];
    LotPressure:=LotPressure * UoMConverter[3];
    BurstPressure:=BurstPressure * UoMConverter[3];

    For i:=1 to 10 do
    Begin
      if Rock[i].Depth > Zero then Rock[i].Depth:=Rock[i].Depth * UoMConverter[1];
      if Rock[i].FP    > Zero then Rock[i].FP   :=Rock[i].FP * UoMConverter[3];
    End;
    FormationPressureGradient:=FormationPressureGradient * UoMConverter[2];
  End;
End;


Begin
End.


