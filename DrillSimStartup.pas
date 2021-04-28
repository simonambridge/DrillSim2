Unit DrillSimStartup;

Interface

Uses Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, blcksock,
     DrillSimVariables,
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
    CurrentFQFileName:=S;      { global - set file to user defined file }
    CreateNewFile:=False;      { global - its an existing file }

    LoadData;  { sets NoFileDefined=True if error during read }

    if NoFileDefined=True then // on return, is a valid file loaded?
    Begin                      // then notify the error
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile - Error loading ' + CurrentFQFileName);
      ShowMessage('Error loading well data file ' + CurrentFQFileName);
    end else
    Begin                      // otherwise confirm well name loaded
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile - ' + CurrentFQFileName + ' load completed');
      StringToMemo('DrillSimStartup.LoadDefaultWellDataFile - Simulating Well ' + Data.WellName);
    End;
  End else
  Begin
    StringToMemo('DrillSimStartup.LoadDefaultWellDataFile - Error, missing well data file ' + CurrentFQFileName);
    NoFileDefined:=True;
  end;
End;



Procedure StartUp;
Begin
  StringToMemo('DrillSimStartup.StartUp - Running DrillSim StartUp.................');
  OriginalExitProc:=ExitProc;
{  ExitProc:=@Abort; }                  { Set Error trap vector  }

  Quit:=False;                          { Initialise Simulator Quit indicator }
  NoFileDefined:=True;  // we are a blank
  CreateNewFile:=True;                  { new file until we know otherwise... }

  HoleError:=False;

  PosCounter:=1;
  TempString:='';
  Instring:='';
  CurrentFQFileName:='';
  DefaultWellDataFile:='';
  DefaultDirectory:='';

  // APIUnits;     { Initial default unit type   }
                {* set UoMLabel, UoMCOnverter and UoMDescriptor *}

  InitData;     { zero all main file variables }

    { ------- get default directory ------- }


  SystemPropertiesFile:=OriginDirectory + 'DrillSim.cfg';
  StringToMemo('DrillSimStartup.StartUp - Configuration file is ' + SystemPropertiesFile);
  StringToMemo('DrillSimStartUp.StartUp - loading system configuration from ' + SystemPropertiesFile);

    { ------- get defaults file ------- }

  AssignFile(Textfile,SystemPropertiesFile);         { /path/drillsim.cfg }
  {$I-}
  Reset(TextFile);
  {$I+}
  if OK then                  { drillsim.CFG found }
  Begin
    While not EOF(TextFile) do
    Begin
      { read FQFN of default well file into DefaultWellDataFile }
      Readln(TextFile,DefaultWellDataFile);
    End;
    CloseFile(TextFile);

    if DefaultWellDataFile=''
    then
      StringToMemo('DrillSimStartup.StartUp - No default well defined ')
    else
    Begin
      StringToMemo('DrillSimStartup.StartUp - Default well data file is ' + DefaultWellDataFile);
      LoadDefaultWellDataFile(DefaultWellDataFile);     // Load the default data file !!!
    end;
  End else
  Begin
    ShowMessage('DrillSimStartup.StartUp - Error loading ' + DefaultWellDataFile); { defaults file not found }
  End;

  {* --------- Load Help File --------- *}

  MessageToMemo(103); // 'Loading application help file...'
  StringToMemo('Skipping help file load...');
   //Assign(HelpFile,'DrillSim.hlp');                   { load help messages }
  //{$I-}
  //Reset(HelpFile);
  //{$I+}
  //if OK then
  //Begin
  //  HelpFileFound:=True;
    //Read(HelpFile,Help);
  //  Close(HelpFile);
  //End else
  //Begin
  //  HelpFileFound:=False;
  //  ShowMessage('DrillSimStartup.StartUp - Error loading DrillSim help file');
  //End;

  { -- create local network socket on port 9999 -- }

  sock := TTCPBlockSocket.Create;
  sock.Connect('localhost', '9999');
  // Was there an error?
  StringToMemo('=========================================================');
  if sock.LastError <> 0 then
  begin
    StringToMemo('DrillSimStartup.StartUp - Socket initialisation error: Could not connect to server.');
    StringToMemo(sock.LastErrorDesc);
  end else
  Begin
    StringToMemo('DrillSimStartup.StartUp - Socket initialisation successful on localhost:9999');
    sock.SendString('DrillSim calling....'#13#10);
  End;
  StringToMemo('=========================================================');

  StringToMemo('DrillSimStartup.StartUp - DrillSim Startup complete');
  StringToMemo('DrillSimStartup.StartUp - Using Well ' + Data.WellName);

End;




Begin
End.


