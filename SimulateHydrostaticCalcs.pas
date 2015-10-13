Unit SimulateHydrostaticCalcs;

Interface

Uses sysutils,
     DrillSimVariables;

Procedure StackCalc;

Implementation


Procedure StackCalc;
Var
  i      : integer;
  x, y, z, P, Q, R, S : real;
  TempPipePV, TempHolePV : real;
  TempPipeYP, TempHoleYP : real;
Begin
  With Data do
  Begin

    if (StackPointer = Zero) or (StrokeCounter = Zero) then
    Begin
      Q:=TotCircStrks;
      AnnMw :=MudOut.MW;
      AnnPV:=MudPV;
      AnnYP:=MudYP;
      MudWt :=MWIn;
      if StrokeCounter > Zero then
      Begin                            { Dont set Pipe mud to MWIn if
        PipeMW:=MWIn;                    nothing pumped yet }
        PipePV:=MudPV;
        PipeYP:=MudYP;
      End;
    End else
    Begin
      x:=StrokeCounter;
      P:=Zero;  R:=Zero;
      S:=Zero;  z:=Zero;
      TempPipePV:=Zero; TempHolePV:=Zero;
      TempPipeYP:=Zero; TempHoleYP:=Zero;
      for i:=StackPointer downto 1 do
      Begin                     { y = elapsed strokes, z = already calc. strks }

        y:=x-CircStack[i].StartStrokes;
        P:=P    + (y * CircStack[i].MW);                 { P = density*strokes }
        TempHolePV:=TempHolePV  + (y * CircStack[i].PV); {   = PV * strokes }
        TempHoleYP:=TempHoleYP  + (y * CircStack[i].YP); {   = YP * strokes }
        z:=z+y;
        if (z <= LagDS) then                { if Pipe not finished }
        Begin
          R:=P;                                 { P = total wt }
          TempPipePV:=TempHolePV;               { R = DP wt    }
          TempPipeYP:=TempHoleYP;
          if i=1 then                     { if in Pipe and on last mud }
          Begin

            R:=R   + ((LagDS - z) * MudOut.MW);
            TempPipePV:=TempPipePV + ((LagDS - z) * MudOut.PV);
            TempPipeYP:=TempPipeYP + ((LagDS - z) * MudOut.YP);
          End;
        End else
        Begin
          if S=Zero then
          Begin

            R:=P;
            TempPipePV:=TempHolePV;
            TempPipeYP:=TempHoleYP;
            R:=R   - ((z - LagDS) * CircStack[i].MW);
            TempPipePV:=TempPipePV - ((z - LagDS) * MudOut.PV);
            TempPipeYP:=TempPipeYP - ((z - LagDS) * MudOut.YP);
            S:=1;
          End;
        End;
        x:=x-y;
      End;

      Q:=TotCircStrks - (StrokeCounter - CircStack[1].StartStrokes);
      P:=P + (Q * MudOut.MW);
      TempHolePV:=TempHolePV + (Q * MudOut.PV);
      TempHoleYP:=TempHoleYP + (Q * MudOut.YP);
      PipeMW:=R / LagDS;
      AnnMW :=(P - R) / LagUS;
      MudWt :=P / TotCircStrks;           { = Average density }
      PipePV:=TempPipePV / LagDS;
      AnnPV:=(TempHolePV - TempPipePV) / LagUS;
      PipeYP:=TempPipeYP / LagDS;
      AnnYP:=(TempHoleYP - TempPipeYP) / LagUS;

      if (StrokeCounter-CircStack[1].StartStrokes) >= TotCircStrks then
      Begin
        MudOut:=CircStack[1];
        MwOut:=MudOut.MW;
        for i:=1 to StackPointer-1 do CircStack[i]:=CircStack[i+1];
        if StackPointer>Zero then StackPointer:=StackPointer-1;
      End;
    End;

    x:=MudVol/HoleVol;    { need to compensate for volume of mud in the hole }

    PipeHhd:=x * Presscon * PipeMW * Tvd;
    AnnHhd :=x * Presscon * AnnMW  * Tvd;
    AverageHhd    :=Presscon * MudWt  * Tvd;

    //writeln('AnnMW: ' + FloatToStr(AnnMw));
    //writeln('PlAnn: ' + FloatToStr(PlAnn));
    //writeln('PressCon: ' + FloatToStr(PressCon));
    //writeln('TvD: ' + FloatToStr(TvD));

    ECD    :=AnnMW + PlAnn / (Presscon * Tvd);
    LastECD:=ECD;
    MACP   :=(LotEMW - AnnMW) * LotTD * PressCon;
    OilFraction   :=Zero;                  { need to correct for kicking wells }
    SolidsFraction:=(AnnMW - 8.33) * 3.75 * 0.01;
    WaterFraction :=1.0 - OilFraction - SolidsFraction;

   End;
End;

Begin
End.

