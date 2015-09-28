Unit SimulateDrillingCalcs;

Interface

Uses Crt,
     DrillSimVariables,
     SimulateUpdate,
     DrillSimMessageToMemo,
     DrillSimUtilities,
     SimulateHoleCalcs,
     DrillSimMath;

Procedure DrillCalc;

Implementation

{ ------------------ Drilling Calculations ----------------- }

{ TD and PipeTD also calculated in DrillSim (HoleCalc) before entering Simulate }
{ they're also calculated here :
            TD        (ROPCalc)     from TD + fx(ROP,overdrill) <=StringTD
            PipeTD    (DrillCalc)   from Pipe[i,1]
            StringTD  (DrillCalc)   from PipeTD, KelHt
            BitTD     (ROPCalc)     from TD (if drilling)
                      (DrillCalc)   from StringTD }

Procedure ROPCalc;
Var
 { i     : integer;   }
  x, y  : real;

Procedure DrillingError;
Begin
  Delay(1000);
  Data.KellyHeight:=Data.KellyHeight + 0.5;
  DrawKelly;
  ScreenService;
End;

Begin
  With Data do
  Begin
    { InputScan; }
    GetCurrentTime (t);
    ROPt1:=ROPt2;
    ROPt2:=t.Seconds;
    ScreenService;

    if RPM > Zero then                  { No drilling if not rotating }
    Begin
      if FlowIn > Zero then             { No drilling if not pumping }
      Begin
        if ROPt2 < ROPt1 then ROPt1:=ROPt1 - 60;
        if ROP >Zero then
        Begin
          x:=((ROPt2 - ROPt1) / 60) / ROP;     { Calculate footage drilled }
          TD:=TD + (x * DrillMult);      { speed up real-time by DrillMult }
          if AutoDrill then
          Begin
            KellyHeight:=KellyHeight - (x * DrillMult); { speed-up drop kelly by DrillMult }
            if KellyHeight < 3 then
            Begin
              KellyHeight:=3;                        { check for kelly down }
              DrawKelly;
              AutoDrill:=False;
              MessageToMemo(2);
            End else DrawKelly;
            ScreenService;
          End;
          if TD > StringTD then TD:=StringTD;  { can't be longer than string }
          Tvd:=TD * Cos(DeviationDegrees * Pi / 180);
          ScreenService;
        End;
        OverDrill:=StringTD - TD;                 { calculate overdrill }
        if OverDrill < 0.001 then                 { accurate to 1/1000' }
        Begin
          TD:=StringTD;       { if Overdrill < 0.001 then Overdrill = 0 }
          WOB:=Zero;
          ROP:=Zero;
        End else
        Begin                               { calculate ROP from modified dcs }
          if OverDrill > 2 then OverDrill:=2;  { Assume full load taken at 2' }
          WOB:=StrWt * (OverDrill / 2);        { with linear increase in WOB  }
                                               { WOB in Klbs }
          x:=ln(Formation[FormationPointer].Hardness / (RPM * 60)) / ln(10);

          y:=(WOB * 12000) / (Hole[MaxHoles,2] * Power(10,6));
          y:=ln(y) / ln(10);

          x:=(x/y) * (FormationPressureGradient / ECD); { Includes o/bal}

          ROP:=1 / x * 60;                               { min/ft }
        End;
        BitTD:=TD;
        WOH:=StrWt - WOB;
        ScreenService;
      End else
      Begin
        MessageToMemo(3);
        DrillingError;
      End;
    End else
    Begin
      MessageToMemo(4);
      DrillingError;
    End;

    HoleCalcCounter:=HoleCalcCounter + 1;    { do HoleCalc routinely every }
    if HoleCalcCounter > 10 then             { 10 loops                    }
    Begin
      Hole[MaxHoles,1]:=TD;
      SimHoleCalc;
      CalculatedSoFar:=Zero;                 { force a complete hydraulic  }
    End;                                     { calculation                 }


{ decided against this method (based on changing hole depth) in favour
  of that above }

{    x:=TD - Hole[MaxHoles,1];   }        { calculate extra footage }

{    if x >= 0.001 then            }      { recalculate every 0.001 ft }
{    Begin                          }
{      Hole[MaxHoles,1]:=TD;        }     { set new hole depth }
{      HoleCalc;                    }     { recalculate hole   }
{    End;                           }     { NOTE : could be speeded up when  }
  End;                                  { drilling by not calling HoleCalc }
End;                                    { so often, ie every 0.05 feet ?   }


{ ------------------ Drilling Controller ----------------- }

Procedure DrillCalc;
Var  i     : integer;
Begin
  With Data do
  Begin
    ScreenService;
    PipeTD:=Zero;
    For i:=1 to MaxPipes do PipeTD:=PipeTD+Pipe[i,1];  { calc. string length }

    StringTD:=PipeTD + (30 - KellyHeight);                   { set pipe depth }

    if StringTD > TD then                  { D R I L L I N G  }
    Begin                                  { ---------------- }
      Drilling:=True;
      ROPCalcCounter:=ROPCalcCounter + 1;
      if ROPCalcCounter > 5 then      { only calculate every 5 iterations }
      Begin
        ROPCalc;
        ROPCalcCounter:=Zero;
      End;

      DrilledHoleVol:=(Sqr(Hole[MaxHoles,2])-Sqr(Pipe[MaxPipes,3])) / 1724;
      if ROP > Zero then DrilledHoleVol:=(DrilledHoleVol / ROP) * Bbl2Gal
                    else DrilledHoleVol:=Zero;       { gal per minute }
    End else
    Begin                                { O F F - B O T T O M }
      Drilling:=False;                   { ------------------- }
      ROP:=Zero;
      DrilledHoleVol:=Zero;
      WOB:=Zero;
      WOH:=StrWt;
      BitTD:=StringTD;
    End;
    ScreenService;
    if RPM = Zero then
    Begin
      if KellyHeight < 33 then
      Begin
//        TAttr:=AttrByte;
        //SetColorSet(WhiteOnBlue);
        //Disp(37,13,DnBushing);
//        AttrByte:=TAttr;
      End;
    End;
    ScreenService;
  End;
End;

Begin
End.

