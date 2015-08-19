Unit SimulateHoleCalcs;

Interface

Uses DrillSimVariables,
     SimulateUpdate,
     SimulateVolumes;

Procedure SimHoleCalc;

Implementation


Procedure SimHoleCalc;    { Procedure To Determine Hole Profile }
Var                    {  Call every time 0.001 ft drilled   }
  X,Y     : real;
  i,J,K   : integer;
  Temp    : array[1..5,1..2] of real;
  ExtraHole : array[1..2] of real;
  TempCount : integer;

Begin
  ScreenService;
  With Data do
  Begin
    TempCount:=Zero;

    if Riser then                      { Assign Hole Sections To Temp[*] }
    Begin
      TempCount:=TempCount+1;
      Temp[TempCount,1]:=RiserTD; Temp[TempCount,2]:=RiserID;
    End;
    ScreenService;

    if Casing then
    Begin
      TempCount:=TempCount+1;
      Temp[TempCount,1]:=CasingTD; Temp[TempCount,2]:=CasingID;
      if Riser then Temp[TempCount,1]:=Temp[TempCount,1]-RiserTD;
      if Liner then Temp[TempCount,1]:=Temp[TempCount,1]-(CasingTD-LinerTop);
    End;
    ScreenService;

    if Liner then
    Begin
      TempCount:=TempCount+1;
      Temp[TempCount,1]:=LinerTD-LinerTop;
      Temp[TempCount,2]:=LinerID;
    End;
    ScreenService;

    if MaxHoles>Zero then
    Begin
      For i:=1 to MaxHoles do
      Begin
        TempCount:=TempCount+1;
        Temp[TempCount,1]:=Hole[i,1]; Temp[TempCount,2]:=Hole[i,2];
        if Casing then
        Begin
          if Liner then Temp[TempCount,1]:=Temp[TempCount,1]-LinerTD
                   else Temp[TempCount,1]:=Temp[TempCount,1]-CasingTD;
        End;
        if i>1 then Temp[TempCount,1]:=Temp[TempCount,1]-Temp[TempCount-1,1];
                                               { Deduct OH#1 }
      End;
    End;

    ScreenService;

    J:=1; K:=MaxPipes;                   { Calculate Hole Profile }
    i:=1;
    X:=Temp[J,1];
    Y:=Pipe[K,1];                        { From bottom to surface }
    ExtraVolume:=Zero;

    While K>Zero do        { HoleSection[*] from surface to bottom }
    Begin
      if X > Y then                    { Hole > Pipe }
      Begin
        HoleSection[i,1]:=Y;                 { section length }
        HoleSection[i,2]:=Temp[J,2];         { section hole ID }
        HoleSection[i,3]:=Pipe[K,3];         { section Pipe OD }
        HoleSection[i,4]:=Pipe[K,2];         { section Pipe ID }
        X:=X-Y;
        K:=K-1;
        if K > Zero then
        Begin
          i:=i+1;
          Y:=Pipe[K,1];
        End;
      End else
      if X < Y then
      Begin
        HoleSection[i,1]:=X;                    { Hole > Pipe }
        HoleSection[i,2]:=Temp[J,2];
        HoleSection[i,3]:=Pipe[K,3];
        HoleSection[i,4]:=Pipe[K,2];
        Y:=Y-X;
        J:=J+1;
        if J <= TempCount then
        Begin
          i:=i+1;
          X:=Temp[J,1];
        End;
      End else
      if X = Y then
      Begin
        HoleSection[i,1]:=X;                           { Pipe = Hole }
        HoleSection[i,2]:=Temp[J,2];        { section length = hole length }
        HoleSection[i,3]:=Pipe[K,3];
        HoleSection[i,4]:=Pipe[K,2];
        K:=K-1;
        J:=J+1;
        if (K > Zero) and (J <= TempCount) then
        Begin
          i:=i+1;
          X:=Temp[J,1];
          Y:=Pipe[K,1];
        End;
      End;
      if (K = 1) and (J=TempCount) then
      Begin
        HoleSection[i,1]:=Y;             { section must be pipe length }
        if X>Y then                      { if off-bottom }
        Begin
          ExtraHole[1]:=X-Y;             { off-bottom distance }
          ExtraHole[2]:=Temp[J,2];       { hole ID }
          ExtraVolume:=ExtraHole[1] * BblPerFoot(ExtraHole[2]); { extra volume }
        End;

        HoleSection[i,2]:=Temp[J,2];
        HoleSection[i,3]:=Pipe[K,3];
        HoleSection[i,4]:=Pipe[K,2];
        K:=Zero;                      { ...To Exit }
      End;
    End;

    TotHoleSections:=i;

    VolCalc;      { calculate WellVol, PipeDis, PipeCap, AnnVol, HoleVol,
                    modify WellVol if shut in and riser }
    ScreenService;

  End;
End;

Begin
End.
