Unit SimulateVariables;

Interface

Const
   KickMode = 'DrillSim Data';   { used by DrillSim for UpdateKick }
   HelpPrompt = 'Press ENTER to continue or ESC to exit';
   Slash      : char = '/';
Var
   LastTD, LastBitTD   : real;
   LastCasingPressure  : real;
   LastBHPAnn          : real;
   LastPitGain         : real;
   LastPlBit           : real;
   LastPlAnn           : real;
   LastPlSurf          : real;
   LastPlPipe          : real;
   LastPlCirc          : real;
   LastPlChoke         : real;

   LastFlowOut         : real;
   LastFlowIn          : real;
   LastElapsedFlow     : real;
   LastCalculatedFlow  : real;

   LastRetPitVol       : real;

   LastJetVel          : real;
   LastImpForce        : real;
   LastBitHp           : real;
   LastEff             : real;
   LastTotHp           : real;
   LastFf, LastRn      : real;
   LastFn, LastFk      : real;

   LastKelHt           : real;
   LastWOB             : real;
   LastWOH             : real;
   LastStrWt           : real;
   LastROP             : real;
   LastRPM             : real;
   Status          : integer;

   LastSeconds         : integer;
   LastHundredths      : integer;

   LastInflux          : real;
   LastInfluxRate      : real;
   LastEcd             : real;
   LastChoke           : integer;

   OriginalMudWt       : real;
   OriginalMudPV       : real;
   OriginalMudYP       : real;
   OriginalHoleDepth   : real;
   OriginalPipeDepth   : real; { not used yet }
   OriginalPitVolume   : real;
   LastMwOut           : real;
   LastMwIn            : real;
   LastMudPv           : real;
   LastMudYp           : real;
   LastMudGel          : real;
   LastCalculatedMudWt : real;

   LastTotStrks        : real;
   LastStrokeCounter   : real;
   LastSPM             : array[1..3] of real;
   DrilledHoleVol      : real;
   ExtraVolume         : real;
   ChokeLinePl         : real;
   Twistoff            : real;
   PitGain             : real;
   Trace               : boolean;

   HoleCalcCounter     : real;         { depth of last HoleCalc }
   HyCalcCounter       : integer;
   ROPCalcCounter      : integer;
   CalculatedSoFar     : integer;
   StatusCounter       : integer;
   SolidUpper          : String[3];
   SplitUpper          : String[3];
   SplitLower          : String[3];
   KellyPipe           : String[3];
   UpBushing           : String[5];
   DnBushing           : String[5];
   Bushing             : array[1..3] of String[5];
   CurrentBushing      : integer;
   CurrentTurn         : real;

Implementation

Begin
End.
