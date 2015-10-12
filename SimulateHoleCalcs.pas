Unit SimulateHoleCalcs;

Interface

Uses SysUtils,
     DrillSimVariables,
     DrillSimMessageToMemo,
     SimulateVolumes;

Procedure SimHoleCalc;

Implementation


Procedure SimHoleCalc;    { Procedure To Determine Hole Profile }
Var                       {  Call every time 0.001 ft drilled   }
  PipeSectionDepth     : real;
  PipeIndex      : integer;
  SectionDepth   : real;
  i              : integer;
  Counter        : integer;
  TempSection    : array[1..5,1..2] of real;
  TS_ID_Index    : integer;
  TS_TD_Index    : integer;
  ExtraHole      : array[1..2] of real;

Begin
  With Data do
  Begin

    TS_TD_Index:=Zero;

    if Riser then                      { Assign Hole Sections To Temp[*] }
    Begin
      TS_TD_Index:=TS_TD_Index+1;
      TempSection[TS_TD_Index,1]:=RiserTD;
      TempSection[TS_TD_Index,2]:=RiserID;
    End;

    if Casing then
    Begin
      TS_TD_Index:=TS_TD_Index+1;
      TempSection[TS_TD_Index,1]:=CasingTD;
      TempSection[TS_TD_Index,2]:=CasingID;
      if Riser then
        TempSection[TS_TD_Index,1]:=TempSection[TS_TD_Index,1]-RiserTD;
      if Liner then
        TempSection[TS_TD_Index,1]:=TempSection[TS_TD_Index,1]-(CasingTD-LinerTopTD);
    End;

    if Liner then
    Begin
      TS_TD_Index:=TS_TD_Index+1;
      TempSection[TS_TD_Index,1]:=LinerBottomTD-LinerTopTD;
      TempSection[TS_TD_Index,2]:=LinerID;
    End;

    if not Simulating then
    Begin
      StringToMemo('SimHoleCalc: MaxHoles = ' + IntToStr(MaxHoles));
      StringToMemo('SimHoleCalc: TS_TD_Index = ' + IntToStr(TS_TD_Index));
    End;

    Counter:=0;
    if MaxHoles>Zero then
    Begin
      For Counter:=1 to MaxHoles do
      Begin
        TS_TD_Index:=TS_TD_Index+1;

        if not Simulating then
          StringToMemo('SimHoleCalc: Counter = ' +                                      IntToStr(Counter) + ' Hole TD='+FloatToStr(Hole[Counter,1]));

                if (Counter=1) then
        Begin
          if (Casing=True)
          then             { deduct TD of casing if present }
            TempSection[TS_TD_Index,1]:=Hole[Counter,1]-CasingTD
          else             { otherwise take depth of first open hole }
            TempSection[TS_TD_Index,1]:=Hole[Counter,1];
        End else           { deduct TD of previous OH section }
          TempSection[TS_TD_Index,1]:=Hole[Counter,1]- Hole[Counter-1,1];


        TempSection[TS_TD_Index,2]:=Hole[Counter,2];

        if (counter=1) and (Liner=True) then
          TempSection[TS_TD_Index,1]:=TempSection[TS_TD_Index,1]-LinerBottomTD;
      End;
    End;


    if not Simulating then
    Begin
      StringToMemo('SimHoleCalc: TS_TD_Index = ' + IntToStr(TS_TD_Index));
      For i:=1 to TS_TD_Index do
      Begin
        StringToMemo('TempSection Depth='+FloatToStr(TempSection[i,1])+' feet, ID='+FloatToStr(TempSection[i,2]));
      end;
    End;

    TS_ID_Index:=1; PipeIndex:=MaxPipes;                   { Calculate Hole Profile }
    i:=1;
    SectionDepth:=TempSection[TS_ID_Index,1];
    PipeSectionDepth:=Pipe[PipeIndex,1];                        { From bottom to surface }
    ExtraVolume:=Zero;

    While PipeIndex>Zero do        { HoleSection[*] from surface to bottom }
    Begin
      if SectionDepth > PipeSectionDepth then                    { Hole > Pipe }
      Begin
        HoleSection[i,1]:=PipeSectionDepth;                 { section length }
        HoleSection[i,2]:=TempSection[TS_ID_Index,2];         { section hole ID }
        HoleSection[i,3]:=Pipe[PipeIndex,3];         { section Pipe OD }
        HoleSection[i,4]:=Pipe[PipeIndex,2];         { section Pipe ID }
        SectionDepth:=SectionDepth-PipeSectionDepth;
        PipeIndex:=PipeIndex-1;
        if PipeIndex > Zero then
        Begin
          i:=i+1;
          PipeSectionDepth:=Pipe[PipeIndex,1];
        End;
      End else
      if SectionDepth < PipeSectionDepth then
      Begin
        HoleSection[i,1]:=SectionDepth;                    { Hole > Pipe }
        HoleSection[i,2]:=TempSection[TS_ID_Index,2];
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];
        PipeSectionDepth:=PipeSectionDepth-SectionDepth;
        TS_ID_Index:=TS_ID_Index+1;
        if TS_ID_Index <= TS_TD_Index then
        Begin
          i:=i+1;
          SectionDepth:=TempSection[TS_ID_Index,1];
        End;
      End else
      if SectionDepth = PipeSectionDepth then
      Begin
        HoleSection[i,1]:=SectionDepth;                           { Pipe = Hole }
        HoleSection[i,2]:=TempSection[TS_ID_Index,2];        { section length = hole length }
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];
        PipeIndex:=PipeIndex-1;
        TS_ID_Index:=TS_ID_Index+1;
        if (PipeIndex > Zero) and (TS_ID_Index <= TS_TD_Index) then
        Begin
          i:=i+1;
          SectionDepth:=TempSection[TS_ID_Index,1];
          PipeSectionDepth:=Pipe[PipeIndex,1];
        End;
      End;
      if (PipeIndex = 1) and (TS_ID_Index=TS_TD_Index) then
      Begin
        HoleSection[i,1]:=PipeSectionDepth;             { section must be pipe length }
        if SectionDepth>PipeSectionDepth then                      { if off-bottom }
        Begin
          ExtraHole[1]:=SectionDepth-PipeSectionDepth;             { off-bottom distance }
          ExtraHole[2]:=TempSection[TS_ID_Index,2];       { hole ID }
          ExtraVolume:=ExtraHole[1] * BblPerFoot(ExtraHole[2]); { extra volume }
        End;

        HoleSection[i,2]:=TempSection[TS_ID_Index,2];
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];
        PipeIndex:=Zero;                      { ...To Exit }
      End;
    End;

    TotHoleSections:=i;

    VolCalc;      { calculate WellVol, PipeDis, PipeCap, AnnVol, HoleVol,
                    modify WellVol if shut in and riser }

  End;
End;

Begin
End.
