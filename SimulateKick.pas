Unit SimulateKick;

Interface

Uses Crt,
     DrillSimVariables,
     DrillSimUtilities,
    DrillSimMath;

Procedure KickCalc;

Implementation

Procedure DeltaPressureCalc(DeltaVolume : real);
Var MudFactor   : real;
Begin
  With Data do
  Begin
    if DeltaVolume > Zero then
    Begin
      MudFactor:=Rheocon18 * Rheocon17 * WaterFraction;
      MudFactor:=MudFactor + Rheocon13 * Rheocon17 * SolidsFraction;
      DeltaCsgPr:=(DeltaVolume / (MudFactor * MudVol)) * 0.9;
      if not ShutIn then DeltaCsgPr:=Zero;             { 0.9 = modifier }
    End else DeltaCsgPr:=Zero;
  End;
End;


Procedure KickCalc;
Var Q, P, R, S, U  : real;
    ExtraFlow      : real;

Procedure ChokeCalc;   { Calculates new Q based on backpressure }
Var M1, M2, Vl : real;
Begin
  With Data do          { assumes Power Law hydraulics for Rn }
  Begin
    if DeltaCsgPr > Zero then
    Begin
      M1:=2.58 * (Choke / 100); { M1 = actual flow area of choke valve }
                                { area : 2.58" = pi/4 * sqr(1-13/16s") choke  }

      Vl:=29.962 * M1 * Sqrt(1.25 * DeltaCsgPr); { 29.962 = 42.2*0.71 }
      Vl:=Vl / Sqrt(MudOut.MW * 8.345); { Vl=mud flow out gpm due to pressure}
                                        { Vl=Q in API calculations           }
                                        { MW must be in sg }

      M2:=Vl * Rheocon1 / 4;       { M2 = mud vel (ft/m) thru' 4" choke line }
      Rn:=(61.88 * M2 * MudOut.MW) / (MudOut.Pv/3.32);{ 61.88 = 15.47 * 4 }
                                       { 15.47 from Geos' PL Pipe Rn eq'n }
      Ff:=Rheocon4 / Power(Rn,Rheocon6);
                                        { 0.5 = constant for open butterfly }
      PlChoke:=(0.5 * MudOut.MW * Sqr(Vl)) / (Sqr(M1) * 12031);{ Choke loss }
                                                    { then add surface line }
      PlChoke:=PlChoke + (Ff * MudOut.MW * Sqr(M2)/ 372000.0) * 20;{ 20' line }
                                        { 372000 = 93000 * 4 }

      if Riser then             { Subsea wellhead : choke line calculation }
      Begin
        M1:=Vl * Rheocon1 / Sqr(ChokeLineID);    { M = Mud velocity, ft/min }
        Rn:=15.47 * ChokeLineID * M1 * MudOut.MW / (MudOut.Pv/3.32);
        Ff:=Rheocon4 / Power(Rn,Rheocon6);
        ChokeLinePl:=(Ff * MudOut.MW * Sqr(M1)/ (Rheocon7 * ChokeLineID)) * RiserTD;
      End;

      Q:=((Vl * ElapsedTime) / 6000) / Bbl2Gal;   { Vl (Gals/min) to Bbl }
    End;
  End;
End;


Begin
  With Data do
  Begin
    GetCurrentTime(t);

    ElapsedTime:=t.Hundredths + ((LastHundredths - t.hundredths) / 2);
    if ElapsedTime <= Zero then ElapsedTime:=ElapsedTime + 100;
    LastHundredths:=t.Hundredths;

{ ============= Calculate pumped flow into the well ================ }

    if Pumping then
    Begin
      ElapsedFlow:=((FlowIn / Bbl2Gal) / 6000) * ElapsedTime;
      RetPitVol:=RetPitVol - ElapsedFlow;              { subtract flow in }
    End else ElapsedFlow:=Zero;

{=================  Calculate overbalance etc. ====================}

{*** need to include gas volume with R }

    BHPAnn:=AnnHhd + PlAnn + PlChoke + ChokeLinePl + DeltaCsgPr; { circ. press in annulus }

  { calculate the difference between the pressure exerted by the
    formation, and the reverse pressure due to the sum of hydrostatic,
    annular, choke and compressive pressure. The result is negative
    if annular pressure is higher, positive if formation pressure is higher.}

    AnnUnderbalance:=Formation[FormationPointer].FP - BHPAnn;

{================ Calculate formation gains/lost circulation =================}

    if AnnUnderbalance < Zero then                  { BHPAnn > FP }
    Begin
      InfluxRate :=Zero;
      Influx     :=Zero;
      if abs(AnnUnderbalance) > MACP then           { Losing to Formation }
      Begin
        BleedOffRate:=-(abs(AnnUnderbalance) - MACP) / 100; { ie 130 psi = }
                                                            { 1.3 bbls/min }
        BleedOff    :=(BleedOffRate / 6000) * ElapsedTime;
      End else
      Begin
        BleedOffRate:=Zero;                       { Not fractured }
        BleedOff    :=Zero;
      End;
    End else                                      { Gaining from Formation }

   { Porosity not taken into account:= 50 psi excess = .5 bbl/min
                                      100               1 bbl/min }
    Begin
      InfluxRate:=AnnUnderBalance / 100;            { bbls/min }
      Influx:=(InfluxRate / 6000) * ElapsedTime;    { FP > BHPAnn }
      BleedOffRate:=Zero;                           { Reset these }
      BleedOff    :=Zero;
    End;

{================== Clear "Losing" message if corrected =================}

    Instring:='Lo';
    if BleedOffRate < -0.001 then
    Begin
      if (copy(ThisString,2,2) <> Instring) then SimulateMessageCode:=54; { 'Losing }
    End;

{====== Calculate pumped volume, net formation gains/lost circulation =====}

                                                { Bleed Offs are negative }
    InfluxRate:=InfluxRate - BleedOffRate;  { Sum gains and losses in bbl/min }
    ExtraFlow:=Influx + BleedOff;                { this one is in bbl }

    P:=ElapsedFlow + ExtraFlow;         { Add net form. flow to pumped vol. }
    MudVol:=MudVol + P;                              { add to hole volume }

    R:=MudVol - HoleVol;                    { R = Mud excess }
    DeltaPressureCalc(R);                   { get the inflated backpressure }

{================== Calculate flow in and out of well =====================}

    if not(ShutIn)  or  ((Choke > Zero) {+ Flowline}) then{ hole must be open }
    Begin
      if R < Zero then      { UNDER-FILLED HOLE... }
      Begin
        if P <= abs(R) then Q:=Zero else Q:=P + R;    { add negative deficit }
      End else

      Begin                 { OR OVER-FILLED HOLE }
        if P < R then
        Begin
          S:=R - P;
          Q:=P + S;          { P = NET FLOWED IN       }
        End else Q:=R;       { Q = NET TO FLOW OUT     }
      End;
    End else Q:=Zero;

{=============== Calculate net outflow and Choke pressure drop ==============}

    U:=Zero;
    if Q > Zero then    { if shut in and choke closed then Q=Zero }
    Begin
      if ShutIn {and Flowline} then  { so if shut in then choke must be open }
      Begin
        ChokeCalc;         { calculate ChokeLineCalc too if riser present }
      End else
      Begin
        PlChoke:=Zero;               { else if choke closed, zero them }
        ChokeLinePl:=Zero;
      End;
      U:=((Q / ElapsedTime) * 6000) * Bbl2Gal;   { U = Gals/min }
      FlowOut:=U;
    End else
    Begin
      PlChoke:=Zero;
      ChokeLinePl:=Zero;
      FlowOut:=Zero;
    End;
    FlowOut:=FlowOut - DrilledHoleVol;  { subtract gal per min hole }

{====== Calculate pits, mud volume in hole, net system pressure drop ======}

    RetPitVol:=RetPitVol + Q;
    MudVol:=MudVol - Q;

    if not Pumping then
    Begin                                 { ---- totalise pressures ---- }
      PlSurf :=Zero;       PlPipe:=Zero;
      PlBit  :=Zero;       PlAnn :=Zero;
      PlChoke:=Zero;       ChokeLinePl:=Zero;
    End;

    CasingPressure:=DeltaCsgPr;

    PlCirc:=PlSurf + PlPipe + PlBit + PlAnn + DeltaCsgPr + PlChoke
                                    + ChokeLinePl + (AnnHhd - PipeHhd);

 { PlCirc zeroed if less than zero because gauges don't go negative }

    if PlCirc < Zero then PlCirc:=Zero;

{ =================== Check for end-simulation conditions =================== }

    if (Data.CasingBurstPressure < Abs(AnnUnderBalance)) or
       (Data.RetPitVol <= Zero) then
    Begin                             { empty pits (72), or burst casing (70) }
      if (Data.RetPitVol <= Zero) then SimulateMessageCode:=72 else SimulateMessageCode:=70;
    End;
  End;
End;

Begin
End.
