Unit SimulateHydraulicCalcs;

Interface

Uses  DrillSimVariables,
      DrillSimUtilities,
      SimulateHydrostaticCalcs,
      SimulateRheology;

Procedure FlowRateCalc;
Procedure HydraulicCalc;


Implementation

{ ---------------------- Flow ---------------------- }

Procedure FlowRateCalc;         { call more often than holecalc }
Var
  i       : integer;
 { PmpOp   : array[1..3] of real;  }
Begin
  With Data do
  Begin
    FlowIn:=Zero; TotStrks:=Zero;
    for i:=1 to MaxPumps do
    Begin
      PmpOp[i]:=Pump[i,1] * Pump[i,2] / 100 * Pump[i,3];
      TotStrks:=TotStrks + Pump[i,3];
      FlowIn :=FlowIn + PmpOp[i];
    End;

    if (TotStrks > Zero) and (FlowIn > Zero) then Pumping:=True
                                             else Pumping:=False;
    GetCurrentTime (t);
    t1:=t2;
    t2:=t.Seconds;
    if t2<t1 then t1:=t1-60;
    if Pumping then
    Begin
      if t2<>t1 then StrokeCounter:=StrokeCounter+((t2-t1)/60*TotStrks);
      LagDT:=PipeCap * Bbl2Gal / FlowIn;                    { Down Time    }
      LagUT:=AnnVol  * Bbl2Gal / FlowIn;                    { Up   Time    }

      LagDS:=LagDT   * TotStrks;                          { Down Strokes }
      LagUS:=LagUT   * TotStrks;                          { Up   Strokes }
      TotCircStrks:=LagDS + LagUS;
    End;

  End;
End;



{ ------------------ Hydraulic Controller ---------------- }

Procedure HydraulicCalc;
Begin
  With Data do
  Begin
    HyCalcCounter:=HyCalcCounter + 1;
    if HyCalcCounter > 20 then
    Begin
      StackCalc;
      HyCalcCounter:=Zero;
    End;
    if Pumping then    { zero it forces a complete hydraulic calculation.  }
    Begin              { if pumping, calcs are requested by HoleCalcCounter}

      if MudWt  <> LastCalculatedMudWt then CalculatedSoFar:=Zero; { new ave. MW }
      if FlowIn <> LastCalculatedFlow  then CalculatedSoFar:=Zero;
      if PlCirc=Zero then CalculatedSoFar:=Zero;

      if CalculatedSoFar < 3 then
      Begin
        Case HyCalcCounter of
           5 : Begin
                 if CalculatedSoFar=Zero then
                 Begin
                   AnnCalc;          { subtract riser pressure drop }
                   If ShutIn and Riser then PlAnn:=PlAnn - Vel[1,3];
                   CalculatedSoFar:=1;
                   LastCalculatedMudWt:=MudWt;
                   LastCalculatedFlow :=FlowIn;
                 End;
               End;
          10 : Begin
                 if CalculatedSoFar=1 then
                 Begin
                   PipeCalc;
                   CalculatedSoFar:=2;
                 End;
               End;
         15 :  Begin
                 if CalculatedSoFar=2 then
                 Begin
                   BitCalc;
                   CalculatedSoFar:=3;
                 End;
               End;
        End;
      End;
    End;
  End;
End;

Begin
End.

