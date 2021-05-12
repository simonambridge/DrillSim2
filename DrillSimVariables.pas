Unit DrillSimVariables;

Interface

uses
Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls, blcksock;

Type


    String120 =  string[120];
    String60  =  string[60];
    String20  =  string[20];
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

    FormationRecord = Record
                        Depth             : real;
                        Hardness          : real;
                        FP                : real;
                        Porosity          : real;
                      End;

    //HelpSet    = Record
    //               HelpText : array[1..200] of String60;
    //             End;
    //Test              = array[1..7] of real;

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
                   { 1..3,1..5 output, efficiency, @strokes, slow pump spm, slow pump flow rate gpm }
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
                   LotPressure                 : real;

                   FormationPointer            : integer;
                   Formation                   : array[1..10] of FormationRecord;

                   Gas                         : array[1..200] of GasRec;

                   DrillMult                   : integer;

                   NeverSimulated              : boolean;  { has this file ever been 'simulated'? }

                   FormationPressureGradient   : real;
                   CasingBurstPressure         : real;
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
                   KellyHeight                 : real;
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


    Date       =  Record
                    DayOfWeek, Year, Month, Day               : word;
                  End;

    Time       =  Record
                    Hours, Minutes, Seconds, Hundredths       : word;
                  End;


Const
    VolCon    = 1029;
    // HHPcon    = 1714;   { not used 5/21 }
    StandLen  = 90;
    Bbl2Gal   = 42;
    Presscon  = 0.052;
    Zero      = 0;

    Rheocon1  = 24.51;
    Rheocon2  = 64.57;
    Rheocon3  = 9.899999;
    Rheocon4  = 0.079;
    // Rheocon5  = 49.56;   { not used 5/21 }
    Rheocon6  = 0.25;
    Rheocon7  = 93000.0;
    Rheocon8  = 282;
    Rheocon9  = 90000.0;
    Rheocon10 = 1024;
    Rheocon11 = 0.32068;
    Rheocon12 = 10858;
    Rheocon13 = 0.2;
    // Rheocon14 = 1.86;     { not used 5/21 }
    Rheocon15 = 0.00015;
    Rheocon16 = 38780.0;
    Rheocon17 = 0.000001;
    Rheocon18 = 2.8;

    VersionNumber = '3.1.0';        { used in command line }
    VersionDate   = '(4/2021)';     { used in command line }
    //Title         = 'DrillSim';     { not used 5/21 }
    Space       :   char     = ' ';


Var
   DataFile            : File of WellData;
   Data                : WellData;
   TextFile            : Text;

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

   KellyImageFileName       : String120;
   BushingImageFileName       : String120;

   InString            : String120;          { Utility input string }
   InputString         : String120;
   LastString          : String120;
   PreviousString      : String120;
   ThisString          : String120;
   Input               : String[1];    { was char; }  { Utility input char' }
   CharInput           : char;                     {   ----- " -----     }
   TempString          : String120;    { utility diplsy string }

   SystemPropertiesFile  : String120;
   DefaultWellDataFile   : String120;        { used for .CFG file }
   DefaultDirectory    : String120;
   OriginDirectory     : String120;
   OriginalExitProc    : Pointer;

   HoleError           : boolean;
   Edited              : boolean;
   Simulating          : boolean;
   SimulateMessageCode : integer;
   Paused              : boolean;

{ Hydvar vars }
   // Bhcp                             : real;      {unused @4/21}
   PosCounter                       : integer;
{ Simvar vars }
   LastTD              : real;
   LastBitTD           : real;
   LastCasingPressure  : real;
   LastBHPAnn          : real;
   LastPitGain         : real;
   // LastPlBit           : real;   { not used @4/21}
   // LastPlAnn           : real;   { not used @4/21}
   // LastPlSurf          : real;   { not used @4/21}
   // LastPlPipe          : real;   { not used @4/21}
   LastPlCirc          : real;
   // LastPlChoke         : real;   { not used @4/21}

   LastFlowOut         : real;
   LastFlowIn          : real;
   // LastElapsedFlow     : real;   { not used @4/21}
   LastCalculatedFlow  : real;

   LastRetPitVol       : real;

   // LastJetVel          : real;   { not used @4/21}
   // LastImpForce        : real;   { not used @4/21}
   // LastBitHp           : real;   { not used @4/21}
   // LastEff             : real;   { not used @4/21}
   // LastTotHp           : real;   { not used @4/21}
   // LastFf              : real;   { not used @4/21}
   // LastRn              : real;   { not used @4/21}
   // LastFn              : real;   { not used @4/21}
   // LastFk              : real;   { not used @4/21}

   LastKellyHeight     : real;
   KellyImageIndex     : integer;

   LastWOB             : real;
   //LastWOH             : real;   { not used @4/21}
   //LastStrWt           : real;   { not used @4/21}

   LastROP             : real;
   LastRPM             : real;
   Status              : integer;

   LastSeconds         : integer;
   LastSocketSeconds   : integer;
   LastHundredths      : integer;

   // LastInflux          : real;   { not used @4/21}
   // LastInfluxRate      : real;   { not used @4/21}
   LastECD             : real;
   LastChoke           : integer;

   OriginalMudWt       : real;
   OriginalMudPV       : real;
   OriginalMudYP       : real;
   OriginalHoleDepth   : real;
   OriginalPipeDepth   : real;
   OriginalPitVolume   : real;
   LastMwOut           : real;
   LastMwIn            : real;
   // LastMudPv           : real;   { not used @4/21}
   // LastMudYp           : real;   { not used @4/21}
   // LastMudGel          : real;   { not used @4/21}
   LastCalculatedMudWt : real;

   // LastTotStrks        : real;   { not used @4/21}
   LastStrokeCounter   : real;
   // LastSPM             : array[1..3] of real;   { not used @4/21}
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
   CurrentBushing      : integer;
   CurrentTurn         : real;

   sock: TTCPBlockSocket;

Implementation

Begin
End.


