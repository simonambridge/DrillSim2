Unit DrillSimHoleChecks;

Interface

Uses SysUtils,
     Dialogs,
     DrillSimVariables,
     DrillSimMessageToMemo,
     SimulateVolumes;

Procedure DSHoleCalc;                  { Procedure To Determine Hole Profile }
Procedure CheckHoleData;
Procedure CheckPipeData;

Implementation

Procedure CheckHoleData; // called when a file is loaded
Begin
  DSHoleCalc;                { Check hole for errors and initialise volumes  }
                                 { mud volume reset when hole profile changed }
  if HoleError then
  Begin
    ShowMessage('Error in hole/pipe dimensions');;
  End;
End;

Procedure CheckPipeData;
Begin
  DSHoleCalc;                { Check hole for errors and initialise volumes }
                               { mud volume reset when pipe profile changed }
  if HoleError then
  Begin
    ShowMessage('Error in pipe dimensions');;
  End;
End;

Procedure ErrorCheck(SectionNumber : integer);
Begin
  With Data do
  Begin
    HoleError:=False;
    if HoleSection[SectionNumber,3] >= HoleSection[SectionNumber,2] then
                                      HoleError:=True;    { Pipe OD > Hole ID }
    if HoleSection[SectionNumber,4] >= HoleSection[SectionNumber,3] then
                                      HoleError:=True;    { Pipe ID > Pipe OD }
  End;
End;


Procedure DSHoleCalc;                  { Procedure To Determine Hole Profile }
Var
    OverPipe          : real;
    PipeSectionDepth  : real;
    PipeIndex         : integer;
    SectionDepth      : real;
    i                 : integer;
    Counter           : integer;
    TempSection       : array[1..5,1..2] of real;  { Also calculates PipeTD for    }
    TS_TD_Index       : integer;                   { Simulate and Optimise         }
    TS_ID_Index       : integer;
    ExtraHole         : array[1..2] of real;


Begin
  With Data do
  Begin
    StringToMemo('DrillSimHoleChecks.DSHoleCalc - Running DSHoleCalc to validate well geometry...');

    TS_TD_Index:=Zero;              { Create and Edit set NeverSimulated }

    if Riser then                   { -- Assign Hole Sections To TempSection[*] -- }
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

    StringToMemo('DrillSimHoleChecks.DSHoleCalc - MaxHoles = ' + IntToStr(MaxHoles));
    StringToMemo('DrillSimHoleChecks.DSHoleCalc - TS_TD_Index = ' + IntToStr(TS_TD_Index));

    Counter:=0;
    if MaxHoles>Zero then
    Begin
      For Counter:=1 to MaxHoles do
      Begin
        TS_TD_Index:=TS_TD_Index+1;
        StringToMemo('DrillSimHoleChecks.DSHoleCalc - Counter = ' + IntToStr(Counter) + ' Hole TD='+FloatToStr(Hole[Counter,1]));

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

    StringToMemo('DrillSimHoleChecks.DSHoleCalc - TS_TD_Index = ' + IntToStr(TS_TD_Index));
    For i:=1 to TS_TD_Index do
    Begin
      StringToMemo('DrillSimHoleChecks.DSHoleCalc - TempSection Depth='+FloatToStr(TempSection[i,1])+' feet, ID='+FloatToStr(TempSection[i,2]));
    end;

{ vvvvvv this section is what makes DSHoleCalc different from SimHoleCalc vvvvvv }

    { -- Calculate TD, TVD using TempSection[i,1] -- }

    StringToMemo('DrillSimHoleChecks.DSHoleCalc - Check hole and pipe TDs...');
    TD:=Zero;
    For i:=1 to TS_TD_Index do TD:=TD+TempSection[i,1];
    StringToMemo('DrillSimHoleChecks.DSHoleCalc - Hole TD='+FloatToStr(TD));

    Tvd:=TD * Cos(DeviationDegrees * Pi / 180);
    StringToMemo('DrillSimHoleChecks.DSHoleCalc - TvD='+FloatToStr(TvD));


    { -- Calculate PipeTD using Pipe[i,1] -- }

    PipeTD:=Zero;
    For i:=1 to MaxPipes do PipeTD:=PipeTD + Pipe[i,1];
    BitTD:=PipeTD;

    { -- Calculate hole and pipe TD's -- }
    if TD < PipeTD then                      { check for excess pipe length  }
    Begin
      OverPipe:=PipeTD - TD;
      if OverPipe >= Pipe[MaxPipes,1] then          { if it can't be accomodated in   }
      Begin                                         { Drill Pipe, then error and Exit }
        StringToMemo('DrillSimHoleChecks.DSHoleCalc - Error: Overpipe >= Pipe[MaxPipes,1]');

        HoleError:=True;
        Exit;
      End else
      Begin                                          { otherwise subtract from Drill }
        Pipe[MaxPipes,1]:=Pipe[MaxPipes,1]-OverPipe; { Pipe to put bit on bottom     }
        PipeTD:=PipeTD-OverPipe;                     { and subtract from PipeTD      }
        BitTD:=PipeTD;
        KellyHeight:=33;                             { and then reset kelly on slips }
        LastKellyHeight:=33;
        LastKD:=PipeTD;                              { and set up for new kelly down }
      End;
    End;

    StringToMemo('DrillSimHoleChecks.DSHoleCalc - Pipe TD='+FloatToStr(PipeTD));
    StringToMemo('DrillSimHoleChecks.DSHoleCalc - Bit TD='+FloatToStr(BitTD));

{ ^^^^^^^ end of extra section ^^^^^^^ }

    StringToMemo('DrillSimHoleChecks.DSHoleCalc - Calculate Hole Profile...');

    TS_ID_Index:=1; PipeIndex:=MaxPipes;                   { Calculate Hole Profile }
    i:=1;
    SectionDepth:=TempSection[TS_ID_Index,1];
    PipeSectionDepth:=Pipe[PipeIndex,1];                        { From bottom to surface }
    ExtraVolume:=Zero;                           { initialise off-bottom volume }
    While PipeIndex>Zero do
    Begin
      if SectionDepth > PipeSectionDepth then                      { Hole > Pipe }
      Begin
        HoleSection[i,1]:=PipeSectionDepth;                         { section length }
        HoleSection[i,2]:=TempSection[TS_ID_Index,2];      { section hole ID }
        HoleSection[i,3]:=Pipe[PipeIndex,3];         { section Pipe OD }
        HoleSection[i,4]:=Pipe[PipeIndex,2];         { section Pipe ID }

        ErrorCheck(i);
        if HoleError then Exit;

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
        HoleSection[i,1]:=SectionDepth;                  { Pipe < Hole }
        HoleSection[i,2]:=TempSection[TS_ID_Index,2];
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];

        ErrorCheck(i);
        if HoleError then Exit;

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
        HoleSection[i,1]:=SectionDepth;                  { Pipe = Hole }
        HoleSection[i,2]:=TempSection[TS_ID_Index,2];          { section length = hole length }
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];
        ErrorCheck(i);
        if HoleError then Exit;
        PipeIndex:=PipeIndex-1;
        TS_ID_Index:=TS_ID_Index+1;
        if (PipeIndex > Zero) and (TS_ID_Index <= TS_TD_Index) then
        Begin
          i:=i+1;
          SectionDepth:=TempSection[TS_ID_Index,1];
          PipeSectionDepth:=Pipe[PipeIndex,1];
        End;
      End;
{  not to be confused with previous block if Pipe=Hole and on
   last hole section, because it does this first before looping
   back. K is here set to zero which exits the algorithm }

{ first check to see if pipe is off bottom (no more pipe after this).
  If yes, last hole section is equal to remaining pipe length and
  extra (non circulating) volume must be calculated in ExtraVol }

      if (PipeIndex = 1) and (TS_ID_Index=TS_TD_Index) then    { if on last section of pipe + hole }
      Begin
        HoleSection[i,1]:=PipeSectionDepth;       { section for analysis must be pipe length }
        if SectionDepth>PipeSectionDepth then                { if off bottom...}
        Begin
          ExtraHole[1]:=SectionDepth-PipeSectionDepth;       { off-bottom distance }
          ExtraHole[2]:=TempSection[TS_ID_Index,2]; { hole ID }
          ExtraVolume:=ExtraHole[1] * BblPerFoot(ExtraHole[2]); { extra volume }
        End;

        HoleSection[i,2]:=TempSection[TS_ID_Index,2];
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];

        ErrorCheck(i);
        if HoleError then Exit;

        PipeIndex:=Zero;                      { ...To Exit }
      End;
    End;

    StringToMemo('DrillSimHoleChecks.DSHoleCalc - Set up well volume...');

    TotHoleSections:=i;

    VolCalc;
  End;
End;

Begin
End.


