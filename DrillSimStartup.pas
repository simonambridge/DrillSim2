Unit DrillSimStartup;

Interface

Uses Crt,
     sysutils,
     DrillSimVariables,
     SimulateVariables,
     HyCalcVariables,
     DrillSimUnitsOfMeasure,
     DrillSimUtilities,
     DrillSimFile,
     DrillSimMessageToMemo,
     DrillSimDataResets;

Procedure StartUp;

Implementation

{ ----------------- Initialize Data --------------------- }

Procedure LoadDefaultWellDataFile(S : String120);
Begin                                        { Extract path string }
  if FileExists(S) then
  Begin
    FileName:=S;               { set file to user defined file }
    CreateNewFile:=False;      { its an existing file }
    NoFileDefined:=False;
    StringToMemo('DrillSimStartup.LoadDefaultWellDataFile: Loading well data file ' + FileName + '...');

    LoadData;

    if NoFileDefined=True then // on return, is a valid file loaded?
    Begin                      // then notify the error
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile: Error loading well data file ' + FileName);
      SystemError(6);  // DrillSimUtilities - cannot load file
    end else
    Begin                      // otherwise confirm well name loaded
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile: Default well data file ' + FileName + ' loaded');
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile: Simulating Well ' + Data.WellName);
    End;
  End;
End;



Procedure StartUp;
Begin
  StringToMemo('DrillSimStartup.StartUp: Running DrillSim StartUp.................');
  OriginalExitProc:=ExitProc;
{  ExitProc:=@Abort; }                  { Set Error trap vector  }

  Quit:=False;                          { Initialise Simulator Quit indicator }
  NoFileDefined:=True;  // we are a blank
  NoData:=True;
  CreateNewFile:=True;                  { new file until we know otherwise... }
  Create:=False;

  Error:=False;                         { Hydraulic calculation }
  HoleError:=False;

  PosCounter:=1;
  TempString:='';
  Instring:='';
  FileName:='';
  DefaultFile:='';
  DefaultDirectory:='';

  APIUnits;     { Initial default unit type   }
                {* set UoMLabel, UoMCOnverter and UoMDescriptor *}

  InitData;     { zero all main file variables }

//  StringToMemo('Well <' + Data.WellName + '>');

    { ------- get default directory ------- }

  GetDir(0,Instring);                 { get current directory spec}
  StringToMemo('DrillSimStartup.StartUp: Current directory is ' + Instring);
  OriginDirectory:=Instring;               { save original direc'y }
  LoggedDirectory:=Instring;               { default to original   }

    { ------- get defaults file ------- }

  Assign(TextFile,OriginDirectory + '/' + 'DrillSim.cfg');         { load drillsim.cfg }
  MessageToMemo(102); // 'Loading application configuration file'
  writeln('DrillSimStartup.StartUp: Configuration file is ' + OriginDirectory + '/' + 'DrillSim.cfg');
  StringToMemo('DrillSimStartup.StartUp: Configuration file is ' + OriginDirectory + '/' + 'DrillSim.cfg');

  {$I-}
  Reset(TextFile);
  {$I+}
  IResult:=0;
  if OK then                  { drillsim.CFG found }
  Begin
    While not EOF(TextFile) do
    Begin
      Readln(TextFile,TextFileLine); { read location of default well file }
      End;
    Close(TextFile);

    StringToMemo('DrillSimStartup.StartUp: Default well data file is ' + TextFileLine);

    LoadDefaultWellDataFile(TextFileLine);     // Load the default data file !!!
  End else
  Begin                  { defaults file not found }
    SystemError(1);      // pop up error message
  End;

  {* --------- Load Help File --------- *}

  MessageToMemo(103); // 'Loading application help file...'

  Assign(HelpFile,'DrillSim.hlp');                   { load help messages }
  {$I-}
  Reset(HelpFile);
  {$I+}
  if OK then
  Begin
    HelpFileFound:=True;
    //Read(HelpFile,Help);
    Close(HelpFile);
  End else
  Begin
    HelpFileFound:=False;
    SystemError(3);
  End;
  StringToMemo('DrillSimStartup.StartUp: DrillSim Startup complete');
  ThisString:=Data.WellName;
    writeln(ThisString);

  StringToMemo('DrillSimStartup.StartUp: Well <' + ThisString + '>');
  StringToMemo('DrillSimStartup.StartUp: Units selected: '+ UoMDescriptor);

End;

Begin
End.

