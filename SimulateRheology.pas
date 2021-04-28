Unit SimulateRheology;

Interface

Uses DrillSimVariables,
     DrillSimMath;

Procedure AnnCalc;
Procedure PipeCalc;
Procedure BitCalc;

Implementation

Procedure AnnCalc;
Var
  X,Y,P,Q : real;
  i       : integer;

Procedure AnnVelCalc;
Begin
  With Data do
  Begin
    X:=Sqr(HoleSection[i,2]) - Sqr(HoleSection[i,3]);
    Y:=HoleSection[i,2] - HoleSection[i,3];
    Vel[i,1]:=FlowIn * Rheocon1 / X;       { Annular Velocity }
  End;
End;

Begin
  With Data do
  Begin

    TurbFlag:=False;                          { Default Is Laminar }
    FlowMode:='Laminar  ';
    PlAnn:=Zero;
    Fn:=3.32 * (ln((MudYp + 2 * MudPv)/(MudYp + MudPv)) / ln(10));
    Fk:=(MudYp + MudPv) / Power(511,Fn);

    if Bingham then
    Begin
      Model:='Bingham  ';

      For i:=1 to TotHoleSections do
      Begin
        AnnVelCalc;
        P:=Rheocon2 * MudPv;               { Critical Velocity }
        Q:=Rheocon2 * Sqrt(Sqr(MudPv) + Rheocon3 * AnnMW * Sqr(Y) *MudYp);
        Vel[i,2]:=(P + Q) / (AnnMW * Y);

        if (Vel[i,1]>Vel[i,2]) then
        Begin                      { Turbulent }
          { InputScan; }
          TurbFlag:=True;
          FlowMode:='Turbulent';
          Rn:=(49.56 * Vel[i,1] * Y * AnnMW)/ MudPv;
          Ff:=Rheocon4 / Power(Rn,Rheocon6);
          Vel[i,3]:=( (Ff * AnnMW * Sqr(Vel[i,1])) / (Rheocon7 * Y) );
          Vel[i,3]:=Vel[i,3] * HoleSection[i,1];

        End else
        Begin                      { Laminar }

          P:=(MudYp / (Y * Rheocon8));
          P:=P+((MudPv * Vel[i,1])/(Sqr(Y) * Rheocon9));
          Vel[i,3]:=P * HoleSection[i,1];

        End;
        PlAnn:=PlAnn + Vel[i,3];
      End;

    End else

    Begin
      Model:='Power Law';

      For i:=1 to TotHoleSections do
      Begin
        AnnVelCalc;
        { Critical Velocity }
        Vel[i,2]:=Power(Rheocon16 * Fk / AnnMW, 1/(2-Fn));
        Vel[i,2]:=Vel[i,2] *
                 Power((2.4/Y)*((2*Fn+1)/(3*Fn)), Fn/(2-Fn));

        if (Vel[i,1]>Vel[i,2]) then
        Begin                                   { Turbulent }

          TurbFlag:=True;
          FlowMode:='Turbulent';
          Rn:=(15.47 * AnnMW * Vel[i,1] * Y) / (MudPv / 3.2);
          Ff:=0.046 / Power(Rn,Rheocon13);
          Vel[i,3]:=((AnnMW * Sqr(Vel[i,1]) * Ff) / (Rheocon7 * Y)) * HoleSection[i,1];

        End else
        Begin                                   { Laminar }

          P:=Power((2.4 * Vel[i,1] / Y) * ((2 * Fn+1) / (3 * Fn)), Fn );
          Vel[i,3]:=P * ((Fk * HoleSection[i,1]) / (300 * Y));

        End;
        PlAnn:=PlAnn + Vel[i,3];
      End;

    End;
  End;
End;


Procedure PipeCalc;
Var Y,P : real;
    i   : integer;
Begin
  WIth Data do
  Begin

    PlPipe:=Zero;
    PlSurf:=Zero;
    if Bingham then
    Begin        { Bingham is too high **** - same as PL except f, Rn }
      For i:=1 to MaxPipes do                    { Pipe Delta dP's    }
      Begin
        P:=FlowIn * Rheocon1 / Sqr(Pipe[i,2]);   { pipe velocity }
        Rn:=49.56 * Pipe[i,2] * P * PipeMW / MudPv;
        Ff:=Rheocon4 / Power(Rn, Rheocon6);
        Y:=(Ff * PipeMW * Sqr(P)/ (Rheocon7 * Pipe[i,2])) * Pipe[i,1];
        PlPipe:=PlPipe + Y;
      End;


      For i:=1 to 4 do                    { Surf. Eqpt. dP's    }
      Begin
        P:=FlowIn * Rheocon1 / Sqr(Surf[i,2]);
        Rn:=49.56 * Surf[i,2] * P * PipeMW / MudPv;
        Ff:=Rheocon4 / Power(Rn, Rheocon6);
        Y:=(Ff * PipeMW * Sqr(P)/ (Rheocon7 * Surf[i,2])) * Surf[i,1];
        PlSurf:=PlSurf + Y;

      End;
    End else
    Begin                                    { **** too low **** }
      For i:=1 to MaxPipes do                   { Pipe Delta dP's    }
      Begin
        P:=FlowIn * Rheocon1 / Sqr(Pipe[i,2]); { pipe veolicity }
        Rn:=(15.47 * PipeMW * P) / (MudPv / 3.2);
        Ff:=0.046 / Power(Rn, Rheocon13);
        Y:=((Ff * PipeMW * Sqr(P)) / (Rheocon7 * Pipe[i,2])) * Pipe[i,1];
        PlPipe:=PlPipe + Y;
      End;

      For i:=1 to 4 do
      Begin
        P:=FlowIn * Rheocon1 / Sqr(Surf[i,2]);
        Rn:=(15.47 * PipeMW * P) / (MudPv / 3.2);
        Ff:=0.046 / Power(Rn, Rheocon13);
        Y:=(Ff * PipeMW * Sqr(P)/ (Rheocon7 * Surf[i,2])) * Surf[i,1];
        PlSurf:=PlSurf + Y;
      End;
    End;
  End;
End;


Procedure BitCalc;
Var P : real;
    i : integer;
Begin
  With Data do
  Begin

    P:=Zero;
    For i:=1 to MaxJets do
    Begin
      P:=P+Sqr(Jet[i]);
    End;
    P:=Pi / 4 * (P / Rheocon10);
    JetVel :=Rheocon11 * FlowIn / P;
    PlBit  :=PipeMW * Sqr(FlowIn) / (Sqr(P) * Rheocon12);
    ImpForce:=Rheocon15 * PipeMW * FlowIn *  JetVel;
    BitHp  :=PlBit * FlowIn / 1714;
    Eff    :=PlBit / PlCirc * 100;
    TotHP  :=PlCirc * (FlowIn / 1714);

  End;
End;

Begin
End.
