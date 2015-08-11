Unit DrillSimConversions;

Interface

Uses DrillSimVariables;

Procedure ConUser;
Procedure ConApi;
Procedure ConUserData;   { data not in ConUser }
Procedure ConUserKickData;
Procedure ConAPIKickData;

Implementation

Procedure ConUser;  {* Convert primary well data to user units e.g. *}
Var i : integer;    {* For i:=1 to Maxholes do Hole[i,1]:=Hole[i,1]/con[1]; *}
Begin
  With Data do
  Begin
    RsrTD      :=RsrTD/con[1];
    CsgTD      :=CsgTD/con[1];
    LinerTop   :=LinerTop/con[1];
    LinerTD    :=LinerTD /con[1];
    MaxPress   :=MaxPress/con[3];
    ElevationRKB        :=ElevationRKB/con[1];
    WaterDepth :=WaterDepth/con[1];
    For i:=1 to Maxholes do Hole[i,1]:=Hole[i,1]/con[1];
    For i:=1 to maxpipes do Pipe[i,1]:=Pipe[i,1]/con[1];
    For i:=1 to 4        do Surf[i,1]:=Surf[i,1]/con[1];
    For i:=1 to maxpumps do
    Begin
      Pump[i,1]:=Pump[i,1]/con[5];
      Pump[i,5]:=Pump[i,5]/con[3];
    End;
    MudWt      :=MudWt/con[2];
  End;
End;


Procedure ConApi;
Var i : integer;
Begin
  With Data do
  Begin
    RsrTD:=RsrTD*con[1];
    CsgTD:=CsgTD*con[1];
    LinerTop:=LinerTop*con[1];
    LinerTD :=LinerTD *con[1];
    MaxPress:=MaxPress*con[3];
    ElevationRKB     :=ElevationRKB*con[1];
    WaterDepth:=WaterDepth*con[1];
    For i:=1 to maxholes do Hole[i,1]:=Hole[i,1]*con[1];
    For i:=1 to maxpipes do Pipe[i,1]:=Pipe[i,1]*con[1];
    For i:=1 to 4        do Surf[i,1]:=Surf[i,1]*con[1];
    For i:=1 to maxpumps do
    Begin
      Pump[i,1]:=Pump[i,1]*con[5];
      Pump[i,5]:=Pump[i,5]*con[3];
    End;
    MudWt:=MudWt*con[2];
  End;
End;


Procedure ConUserData;   { data not in ConUser }
Var i : integer;
Begin
  With Data do
  Begin
    TD :=TD/con[1];
    TVD:=TVD/con[1];
    For i:=1 to MaxPipes do
    Begin
      FillCE[i] :=FillCE[i] / con[4];
      FillOE[i] :=FillOE[i] / con[4];
    End;
    WellVol:=WellVol / con[4];
    HoleVol:=HoleVol / con[4];
    AnnVol :=AnnVol / con[4];
    PipeDis:=PipeDis / con[4];
    PipeCap:=PipeCap / con[4];
    FlowIn   :=FlowIn / con[5];
    PlSurf :=PlSurf / con[3];
    PlPipe :=PlPipe / con[3];
    PlBit  :=PlBit  / con[3];
    PlAnn  :=PlAnn  / con[3];
    PlCirc  :=PlCirc  / con[3];
    JetVel :=JetVel / con[1];
    AverageHhd    :=AverageHhd    / con[3];
    Bhcp   :=Bhcp   / con[3];
    Ecd    :=Ecd    / con[2];

    For i:=1 to TotHoleSections do
    Begin
      HoleSection[i,1]:=HoleSection[i,1]/con[1];
      Vel[i,1]:=Vel[i,1]/con[1];
      Vel[i,2]:=Vel[i,2]/con[1];
      Vel[i,3]:=Vel[i,3]/con[3];
    End;
  End;
End;

Procedure ConUserKickData; {* Convert kick variables to user units *}
Var i : integer;
Begin
  With Data do
  Begin
    TD :=TD/con[1];
    TVD:=TVD/con[1];
    LotTD:=LotTD / con[1];
    LotMW:=LotMW / con[2];
    LotEMW:=LotEMW / con[2];
    LotPressure:=LotPressure / con[3];
    BurstPressure:=BurstPressure / con[3];
    For i:=1 to 10 do
    Begin
      if Rock[i].Depth > Zero then Rock[i].Depth:=Rock[i].Depth / con[1];
      if Rock[i].FP    > Zero then Rock[i].FP   :=Rock[i].FP / con[3];
    End;
    FormationPressureGradient:=FormationPressureGradient / con[2];
  End;
End;


Procedure ConAPIKickData;
Var i : integer;
Begin
  With Data do
  Begin
    TD :=TD * con[1];
    TVD:=TVD * con[1];
    LotTD:=LotTD * con[1];
    LotMW:=LotMW * con[2];
    LotEMW:=LotEMW * con[2];
    LotPressure:=LotPressure * con[3];
    BurstPressure:=BurstPressure * con[3];

    For i:=1 to 10 do
    Begin
      if Rock[i].Depth > Zero then Rock[i].Depth:=Rock[i].Depth * con[1];
      if Rock[i].FP    > Zero then Rock[i].FP   :=Rock[i].FP * con[3];
    End;
    FormationPressureGradient:=FormationPressureGradient * con[2];
  End;
End;


Begin
End.

