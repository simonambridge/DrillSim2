Unit DrillSimVariables;

Interface

uses
Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls;

Type


    String120 =  string[120];
    String20  =  string[20];
    String60  =  string[60];
    String3   =  string[3];

    AttrType  =  byte;

    MudRec     =  Record
                    StartStrokes : real;  { StrokeCounter @ start circ' }
                    MW           : real;  { New MW }
                    PV           : real;  {     PV }
                    YP           : real;  {     YP }
                  End;

    GasRec     =  Record
                    Spare1 : real;
                    Spare2 : real;
                    Spare3 : real;
                    Spare4 : real;
                  End;

    RockRec    = Record
                   Depth             : real;
                   Hardness          : real;
                   FP                : real;
                   Porosity          : real;
                 End;

    HelpSet    = Record
                   HelpText : array[1..200] of String60;
                 End;
    Test              = array[1..7] of real;

    WellData   = Record
                   WellOperator                : String120;
                   WellName                    : String120;
                   TD, BitTD                   : real;
                   API                         : boolean;
                   Offshore                    : boolean;
                   SubSeaWellHead              : boolean;

                   Riser                       : boolean;
                   RiserTD                     : real;
                   RiserID                     : real;

                   Casing                      : boolean;
                   CasingID                    : real;
                   CasingTD                    : real;

                   Liner                       : boolean;
                   LinerTopTD                  : real;
                   LinerBottomTD               : real;
                   LinerID                     : real;

                   Surf                        : array[1..4,1..2] of real;  { length, ID }

                   MaxHoles                    : integer;
                   Hole                        : array[1..3,1..3] of real; { TD, ID, OD }

                   MaxPipes                    : integer;                  { we only use three sections of }
                   Pipe                        : array[1..4,1..4] of real; { pipe length, ID, OD, lbs/ft }

                   ChokeLineID                 : real;
                   KillLineID                  : real;

                   DeviationDegrees            : real;
                   TVD                         : real;

                   ElevationRKB                : real;
                   WaterDepth                  : real;

                   MaxJets                     : integer;
                   Jet                         : array[1..4] of integer;
                   BitNumber                   : integer;
                   BitType                     : String20;

                   MaxPumps                    : integer;
                   Pump                        : array[1..3,1..5] of real;
                   { output, efficiency, @strokes, slow pump spm, slow pump flow rate gpm }
                   MaxPumpPressure             : real;

                   ExcessMud                   : real;

                   MudWt                       : real;
                   MudPv                       : real;
                   MudYp                       : real;
                   MudGel                      : real;
                   RetPitVol                   : real;

                   LotTD                       : real;
                   LotEMW                      : real;
                   LotMW                       : real;
                   LOTPressure                 : real;

                   RockPointer                 : integer;
                   Rock                        : array[1..10] of RockRec;

                   Gas                         : array[1..200] of GasRec;

                   DrillMult                   : integer;

                   NeverSimulated              : boolean;  { has this file ever been 'simulated'? }

                   FormationPressureGradient   : real;
                   BurstPressure               : real;
                   InfluxDensity               : real;

                   PipeRAMRating               : real;
                   HydrilRating                : real;

                   Pumping                     : boolean;
                   Drilling                    : boolean;
                   AutoDrill                   : boolean;
                   ShutIn                      : boolean;
                   BlindRam                    : boolean;
                   PipeRam                     : boolean;
                   Hydril                      : boolean;
                   FlowLine                    : boolean;
                   Bingham                     : boolean;
                   UpdateFlow                  : boolean;
                   PmpOp                       : array[1..3] of real;
                   FillCE                      : array[1..4] of real;
                   FillOE                      : array[1..4] of real;
                   LagDT, LagDS                : real;
                   LagUT,   LagUS              : real;
                   WellVol, HoleVol            : real;
                   AnnVol,  MudVol             : real;
                   PipeCap, PipeDis            : real;
                   TotHoleSections             : integer;
                   HoleSection                 : array[1..9,1..4] of real;
                   Vel                         : array[1..9,1..3] of real;

                   StackPointer                : integer;
                   CircStack                   : array[1..200] of MudRec;
                   MudOut                      : MudRec;
                   StrokeCounter               : real;
                   TotStrks                    : real;
                   TotCircStrks                : real;

                   PipeMW                      : real;
                   AnnMW                       : real;
                   MwIn                        : real;
                   MwOut                       : real;
                   AnnPV                       : real;
                   AnnYP                       : real;
                   PipePV                      : real;
                   PipeYP                      : real;

                   FlowIn, FlowOut             : real;
                   ElapsedTime                 : real;
                   ElapsedFlow                 : real;
                   PlSurf, PlPipe              : real;
                   PlBit, PlAnn                : real;
                   PlCirc                      : real;
                   MACP                        : real;
                   AnnUnderbalance             : real;
                   CasingPressure              : real;
                   DeltaCsgPr                  : real;
                   PlChoke                     : real;
                   Choke                       : integer;

                   JetVel, ImpForce            : real;
                   BitHp, Eff, TotHP           : real;
                   AverageHhd                  : real;
                   PipeHhd, AnnHhd             : real;
                   BHPAnn                      : real;
                   Ecd                         : real;
                   Ff, Rn                      : real;
                   Fn, Fk                      : real;
                   WaterFraction               : real;
                   OilFraction                 : real;
                   SolidsFraction              : real;

                   PipeTD                      : real;
                   StringTD                    : real;
                   KelHt                       : real;
                   LastKD                      : real;
                   WOB                         : real;
                   WOH                         : real;
                   StrWt                       : real;
                   ROP                         : real;
                   RPM                         : real;
                   OverDrill                   : real;
                   t1,t2                       : integer;
                   ROPt1,ROPt2                 : integer;
                   RPMt1,RPMt2                 : integer;

                   Influx                      : real;
                   InfluxRate                  : real;
                   BleedOffRate                : real;
                   BleedOff                    : real;

                 End;

      ColorSet    = (NormColors, { grey on blue }
                     BlueonGray,
                     WhiteOnBlue,
                     YellowOnBlack,
                     GrayOnBlack,
                     DataColors,   { high cyan on blue }
                     TitleColors,  { yellow on blue }
                     RedOnGray,
                     RedOnBlue,
                     FlashColors,  { red on blue }
                     BlackOnGreen,
                     WhiteOnGreen,
                     WhiteOnRed);

    Date       =  Record
                    DayOfWeek, Year, Month, Day               : word;
                  End;

    Time       =  Record
                    Hours, Minutes, Seconds, Hundredths       : word;
                  End;


Const
    VolCon    = 1029;               HHPcon    = 1714;
    StandLen  = 90;                 Bbl2Gal   = 42;
    Presscon  = 0.052;              Zero      = 0;
    Rheocon1  = 24.51;              Rheocon2  = 64.57;
    Rheocon3  = 9.899999;           Rheocon4  = 0.079;
    Rheocon5  = 49.56;              Rheocon6  = 0.25;
    Rheocon7  = 93000.0;            Rheocon8  = 282;
    Rheocon9  = 90000.0;            Rheocon10 = 1024;
    Rheocon11 = 0.32068;            Rheocon12 = 10858;
    Rheocon13 = 0.2;                Rheocon14 = 1.86;
    Rheocon15 = 0.00015;            Rheocon16 = 38780.0;
    Rheocon17 = 0.000001;           Rheocon18 = 2.8;
    VersionNumber = '3.0.0';
    VersionDate   = '(6/2015)';
    Title         = 'DrillSim';

    PressPrompt = 'Press any key...';
    CommandLine = '>                     ';
    Extension   : String[4]  = '.WDF';
    Space       :   char     = ' ';
    CurrentMode = 'Mode : ';
    UnitMode    = 'Select User Units';
    SelectMode  = 'Main Menu';
    FileMode    = 'File Utilities';
    SetUpMode   = 'Setup';
    CreateMode  = 'Create Data File';
    UpdateMode  = 'Update Data File';
    GenMode     = 'General Data';
    HoleMode    = 'Hole Profile';
    PipeMode    = 'Drill String';
    BitMode     = 'Bit Data';
    MudMode     = 'Mud Data';
    PumpMode    = 'Pump Data';
    SurfMode    = 'Surface Equipment';
    OptMode     = 'Optimise';
    HyPrMode    = 'Hydraulic Print';
    ErrorMode   = 'Data Error';
    NoHelp1     = 'Help file was not found in start-up directory';
    NoHelp2     = 'No help messages available';
    Yes         = 'Yes';
    No          = ' No';

{ hydvar constants }
    LaminarText   = 'Laminar  ';
    TurbulentText = 'Turbulent';
    Blank4      = '    ';
    Blank5      = '     ';
    Blank6      = '      ';
    Blank7      = '       ';
    Blank9      = '         ';
    Blank11     = '           ';
    Dollar4      = '$$$$';
    Dollar5      = '$$$$$';
    Dollar6      = '$$$$$$';
    Dollar7      = '$$$$$$$';
    Dollar9      = '$$$$$$$$$';

{ Simvar constants }
   KickMode = 'DrillSim Data';   { used by DrillSim for UpdateKick }
   HelpPrompt = 'Press ENTER to continue or ESC to exit';
   Slash      : char = '/';
Var
   DataFile            : File of WellData;
   Data                : WellData;
   TextFile            : Text;
   SubProgram          : File;
   HelpFile            : File of HelpSet;
   Help                : HelpSet;

   d                   : Date;
   t                   : Time;

   CurrentFQFileName     : String120;
   CreateNewFile       : boolean;
   Quit                : boolean;
   NoFileDefined       : boolean;
   HelpFileFound       : boolean;

   UoMConverter        : array[1..8] of real;   { Units Of Measure }
   UoMLabel            : array[1..8] of String3;
   UoMDescriptor       : String[20];
   ROPLabel            : String[20];

   TurbFlag            : boolean;
   FlowMode            : String20;
   Model               : String20;
   InString            : String120;          { Utility input string }
   InputString         : String120;
   LastString          : String120;
   PreviousString      : String120;
   ThisString          : String120;
   Enter               : String[3];
   YesNo               : string[4];
   Input               : String[1]; { was char; }  { Utility input char' }
   CharInput           : char;                     {   ----- " -----     }
//   Util                : char;                { Box building  char' }

   OutString           : String120;    { FastDisp variables }
   TempString          : String120;    { utility diplsy string }
//   Row, Col            : integer;
//   AttrByte            : byte;         { current Disp colour }
//   TAttr               : byte;         { store current Disp Colour }

   Code                : integer;           { used by Proc. }
   Name                : String20;        { GetDirectory  }

   SystemPropertiesFile  : String120;
   DefaultWellDataFile   : String120;        { used for .CFG file }
   DefaultDirectory    : String120;
//   PathString          : String120;         { Used for DOS Path - replaced }
   OriginDirectory     : String120;
   OriginalExitProc    : Pointer;

   RealResult          : real;          { used by Proc. GetReal, GetInt }
   IntResult           : integer;
   IntParam            : integer;
   RealParam           : real;

   HoleError           : boolean;
   Edited              : boolean;
   Valid               : boolean;
   Esc                 : boolean;

   MinChoice           : integer;
   MaxChoice           : integer;
   OldChoice           : integer;
   NewChoice           : integer;
   Choice              : integer;
   Menu                : array [1..10] of String120;

{ Hydvar vars }
   Bhcp                             : real;
   PosCounter                       : integer;
   LineCnt                          : integer;
   ColorCount                       : integer;
{ Simvar vars }
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
   Status              : integer;

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
   PumpsOff            : boolean;

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

