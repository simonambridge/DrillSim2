Unit DrillSimHoleChecks;

Interface

Uses SysUtils,
     DrillSimVariables,
     DrillSimMessageToMemo,
     Dialogs;

Procedure DSHoleCalc;                  { Procedure To Determine Hole Profile }
Procedure CheckHoleData;
Procedure CheckPipeData;

Implementation

Procedure ErrorScreen;
Begin
   StringToMemo('Temp message - there is an error');
  //Box(13,5,67,19);
  //Box(30,6,49,8);
  //Disp(32,7,'INPUT DATA ERROR');
  //Disp(16,9,Help.HelpText[191]);   { There is an error in the... }
  //Disp(16,10,Help.HelpText[192]);
  //Disp(16,11,Help.HelpText[193]);
  //Disp(16,12,Help.HelpText[194]);
  //Disp(16,13,Help.HelpText[195]);
  //Disp(16,14,Help.HelpText[196]);
  //Disp(16,15,Help.HelpText[197]);
  //Disp(16,16,Help.HelpText[198]);
  //Disp(16,17,Help.HelpText[199]);
  //Disp(16,18,Help.HelpText[200]);
End;

Procedure CheckHoleData; // called when a file is loaded
Begin
  DSHoleCalc;                { Check hole for errors and initialise volumes  }
                                 { mud volume reset when hole profile changed }
  if HoleError then
  Begin
    ShowMessage('Error in hole dimensions');;
  End;
End;

Procedure CheckPipeData;  // called when a file is loaded
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
    OverPipe     : real;
    PipeSectionDepth            : real;
    SectionDepth : real;
    TempHoleSectionIDIndex            : integer;
    i         : integer;
    PipeIndex  : integer;
    Counter    : integer;
    TempHoleSection : array[1..5,1..2] of real;  { Also calculates PipeTD for    }
    TempHoleSectionTDIndex  : integer;                   { Simulate and Optimise         }
    ExtraHole  : array[1..2] of real;

Function BblPerFoot(x : real) : real;
Begin
  BBlPerFoot:=sqr(x) / VolCon;
End;

Begin
  With Data do
  Begin
    TempHoleSectionTDIndex:=Zero;              { Create and Edit set NeverSimulated }

    if Riser then                            { Assign Hole Sections To TempHoleSection[*] }
    Begin
     TempHoleSectionTDIndex:=TempHoleSectionTDIndex+1;
     TempHoleSection[TempHoleSectionTDIndex,1]:=RiserTD;
     TempHoleSection[TempHoleSectionTDIndex,2]:=RiserID;
    End;

    if Casing then
    Begin
      TempHoleSectionTDIndex:=TempHoleSectionTDIndex+1;
      TempHoleSection[TempHoleSectionTDIndex,1]:=CasingTD;
      TempHoleSection[TempHoleSectionTDIndex,2]:=CasingID;
      if Riser then
        TempHoleSection[TempHoleSectionTDIndex,1]:=TempHoleSection[TempHoleSectionTDIndex,1]-RiserTD;
      if Liner then
        TempHoleSection[TempHoleSectionTDIndex,1]:=TempHoleSection[TempHoleSectionTDIndex,1]-(CasingTD-LinerTopTD);
    End;

    if Liner then
    Begin
      TempHoleSectionTDIndex:=TempHoleSectionTDIndex+1;
      TempHoleSection[TempHoleSectionTDIndex,1]:=LinerBottomTD-LinerTopTD;
      TempHoleSection[TempHoleSectionTDIndex,2]:=LinerID;
    End;

    writeln('MaxHoles = ' + IntToStr(MaxHoles));
    Counter:=0;
    if MaxHoles>Zero then
    Begin
      For Counter:=1 to MaxHoles do
      Begin
        TempHoleSectionTDIndex:=TempHoleSectionTDIndex+1;
        writeln('Counter = ' + IntToStr(Counter));

        TempHoleSection[TempHoleSectionTDIndex,1]:=Hole[Counter,1];
        TempHoleSection[TempHoleSectionTDIndex,2]:=Hole[Counter,2];

        if Casing and Liner
          then TempHoleSection[TempHoleSectionTDIndex,1]:=TempHoleSection[TempHoleSectionTDIndex,1]-LinerBottomTD
          else TempHoleSection[TempHoleSectionTDIndex,1]:=TempHoleSection[TempHoleSectionTDIndex,1]-CasingTD;

        if Counter>1 then TempHoleSection[TempHoleSectionTDIndex,1]:=TempHoleSection[TempHoleSectionTDIndex,1]-TempHoleSection[TempHoleSectionTDIndex-1,1];
      End;                                     { Deduct OH#1 }
    End;

    TD:=Zero;                              { Calculate TD, TVD using TempHoleSection[i,1] }
    For i:=1 to TempHoleSectionTDIndex do TD:=TD+TempHoleSection[i,1];

    PipeTD:=Zero;                          { Calculate PipeTD using Pipe[i,1] }
    For i:=1 to MaxPipes do PipeTD:=PipeTD + Pipe[i,1];

    writeln('Check hole and pipe TDs...');
                                             { Check hole and pipe TD's }
    if TD < PipeTD then                      { check for excess pipe length  }
    Begin
      OverPipe:=PipeTD - TD;
      if OverPipe >= Pipe[MaxPipes,1] then          { if it can't be accomodated in   }
      Begin                                         { Drill Pipe, then error and Exit }
        HoleError:=True;
        Exit;
      End else
      Begin                                          { otherwise subtract from Drill }
        Pipe[MaxPipes,1]:=Pipe[MaxPipes,1]-OverPipe; { Pipe to put bit on bottom     }
        PipeTD:=PipeTD-OverPipe;                     { and subtract from PipeTD      }
        KellyHeight:=33;                             { and then reset kelly on slips }
        LastKellyHeight:=33;
        LastKD:=PipeTD;                              { and set up for new kelly down }
      End;
    End;
    Tvd:=TD * Cos(DeviationDegrees * Pi / 180);

    writeln('Calculate Hole Profile...');

    TempHoleSectionIDIndex:=1; PipeIndex:=MaxPipes;                   { Calculate Hole Profile }
    i:=1;
    SectionDepth:=TempHoleSection[TempHoleSectionIDIndex,1];
    PipeSectionDepth:=Pipe[PipeIndex,1];                        { From bottom to surface }
    ExtraVolume:=Zero;                           { initialise off-bottom volume }
    While PipeIndex>Zero do
    Begin
      if SectionDepth > PipeSectionDepth then                      { Hole > Pipe }
      Begin
        HoleSection[i,1]:=PipeSectionDepth;                         { section length }
        HoleSection[i,2]:=TempHoleSection[TempHoleSectionIDIndex,2];      { section hole ID }
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
        HoleSection[i,2]:=TempHoleSection[TempHoleSectionIDIndex,2];
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];
        ErrorCheck(i);
        if HoleError then Exit;
        PipeSectionDepth:=PipeSectionDepth-SectionDepth;
        TempHoleSectionIDIndex:=TempHoleSectionIDIndex+1;
        if TempHoleSectionIDIndex <= TempHoleSectionTDIndex then
        Begin
          i:=i+1;
          SectionDepth:=TempHoleSection[TempHoleSectionIDIndex,1];
        End;
      End else
      if SectionDepth = PipeSectionDepth then
      Begin
        HoleSection[i,1]:=SectionDepth;                  { Pipe = Hole }
        HoleSection[i,2]:=TempHoleSection[TempHoleSectionIDIndex,2];          { section length = hole length }
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];
        ErrorCheck(i);
        if HoleError then Exit;
        PipeIndex:=PipeIndex-1;
        TempHoleSectionIDIndex:=TempHoleSectionIDIndex+1;
        if (PipeIndex > Zero) and (TempHoleSectionIDIndex <= TempHoleSectionTDIndex) then
        Begin
          i:=i+1;
          SectionDepth:=TempHoleSection[TempHoleSectionIDIndex,1];
          PipeSectionDepth:=Pipe[PipeIndex,1];
        End;
      End;
{  not to be confused with previous block if Pipe=Hole and on
   last hole section, because it does this first before looping
   back. K is here set to zero which exits the algorithm }

   writeln('Calculate extre hole...');

{ first check to see if pipe is off bottom (no more pipe after this).
  If yes, last hole section is equal to remaining pipe length and
  extra (non circulating) volume must be calculated in ExtraVol }

      if (PipeIndex = 1) and (TempHoleSectionIDIndex=TempHoleSectionTDIndex) then    { if on last section of pipe + hole }
      Begin
        HoleSection[i,1]:=PipeSectionDepth;       { section for analysis must be pipe length }
        if SectionDepth>PipeSectionDepth then                { if off bottom...}
        Begin
          ExtraHole[1]:=SectionDepth-PipeSectionDepth;       { off-bottom distance }
          ExtraHole[2]:=TempHoleSection[TempHoleSectionIDIndex,2]; { hole ID }
          ExtraVolume:=ExtraHole[1] * BblPerFoot(ExtraHole[2]); { extra volume }
        End;

        HoleSection[i,2]:=TempHoleSection[TempHoleSectionIDIndex,2];
        HoleSection[i,3]:=Pipe[PipeIndex,3];
        HoleSection[i,4]:=Pipe[PipeIndex,2];
        ErrorCheck(i);
        if HoleError then Exit;
        PipeIndex:=Zero;                      { ...To Exit }
      End;
    End;

    writeln('Set up well volume...');

    TotHoleSections:=i;

    { Set up well volume below before calculating from HoleSection[i].
   Initially set to zero, ExtraVolume is only non-zero if off-bottom
   Well Volume is still correct because it includes the ExtraVolume.
   Annular volume is compensated for non-circulating volume. }

    WellVol:=ExtraVolume;
    PipeCap:=Zero;
    PipeDis:=Zero;
    For i:=1 to TotHoleSections do
          WellVol:=WellVol + HoleSection[i,1] * BblPerFoot(HoleSection[i,2]);

    For i:=1 to MaxPipes do
    Begin
      PipeCap:=PipeCap + Pipe[i,1] * BblPerFoot(Pipe[i,2]);
      PipeDis:=PipeDis + Pipe[i,1] * BblPerFoot(Pipe[i,3]);
      FillCE[i]:=BblPerFoot(Pipe[i,3]) * StandLen;
      FillOE[i]:=(sqr(Pipe[i,3])-Sqr(Pipe[i,2])) / VolCon * StandLen;
    End;

    AnnVol:=(WellVol - ExtraVolume) - PipeDis; { don't include extra hole vol }
    HoleVol:=AnnVol + PipeCap + ExtraVolume;
    MudVol:=HoleVol;             { set to correct hole volume }
  End;
End;

Begin
End.


