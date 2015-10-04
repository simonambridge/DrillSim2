Unit SimulateControlChecks;

Interface

Uses Crt,
     DrillSimVariables,
     DrillSimMessageToMemo,
     SimulateUpdate,
     DrillSimDataResets;

Procedure ControlChecks;

Implementation

Procedure ControlChecks;
Var
   x : real;
   i : integer;
Begin
  With Data do
  Begin
    { check for hole deeper then next horizon          }
    { if yes, check if next horizon data is valid (>0) }
    { if yes, advance FormationPointer and calculate new    }
    { formation pressure gradient                      }

    if (FormationPointer<=9) and (Hole[MaxHoles,1] > Formation[FormationPointer+1].Depth) then
    Begin
      if (Formation[FormationPointer+1].FP > Zero) and       { check for valid data }
         (Formation[FormationPointer+1].Hardness > Zero) and
         (Formation[FormationPointer+1].Depth > Formation[FormationPointer].Depth) then
      Begin
        FormationPointer:=FormationPointer + 1;
        FormationPressureGradient:=         { calculate here for ROPCalc }
                (Formation[FormationPointer].FP / Formation[FormationPointer].Depth) / Presscon;
      End;
    End;

             { -------- Cheque for twist-off --------- }

    if (StatusCounter=5) and (Status=3) then   { check every 5 loops }
    Begin                                          { if drilling          }
      x:=Zero;
      for i:=1 to MaxPipes do        { calculate drill collar weight }
      Begin                          { pipe must be > 5" OD          }
        if Pipe[i,3] > 5 then x:=x + Pipe[i,1] * Pipe[i,4];
      End;
      if x = Zero then
      Begin
        for i:=1 to MaxPipes do
        Begin
          x:=x + Pipe[i,1] * Pipe[i,4];   { ...otherwise total DP wt   }
        End;
      End;
      TwistOff:=x /1000 * 0.7;            { t.off @ 70% of string wt   }
      if WOB > TwistOff then              { if twisted off...          }
      Begin
        MessageToMemo(71);
        MessageToMemo(74);
        Repeat Until KeyPressed;
        Input:=ReadKey;
        Clear;                    { reset screen and restart simulation }
      End;
    End;

    StatusCounter:=StatusCounter + 1;
    if StatusCounter>10 then               { check every 10 loops }
    Begin
      StatusUpdate;
      StatusCounter:=Zero;
    End;
  End;
End;

Begin
End.