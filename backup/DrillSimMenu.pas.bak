Unit DrillSimMenu;

Interface

Uses Dos,Crt,
     DrillSimVariables,
     HyCalcVariables,
     DrillSimFile,
     DrillSimUtilities,
     DrillSimUnitsOfMeasure,
     DrillSimConversions,
     DrillSimHoleCalc,
     DrillSimUoMMenu,
     DrillSimDataInput,
     DrillSimStartup,
     SimulateMessageToMemo;

Procedure CallHoleData;
Procedure CreateFile;
Procedure SetDefaultFile;
Procedure SetDefaultDirectory;
Procedure CallPipeData;

Implementation

Procedure WriteDefaults;
Begin
  ChDir(OriginDirectory);              { set to dir' at start up }
{$I-}  Rewrite (TextFile); {$I+}       { do the business... }
  if OK then
  Begin
    for IResult:=1 to 2 do
    Begin
      Case IResult of
        1 : writeln(TextFile,'PATH=' + DefaultDirectory);
        2 : writeln(TextFile,'FILE=' + DefaultFile);
      End;
    End;
    Close(TextFile);
  End;
  ChDir(LoggedDirectory);               { ...and set back to current dir' }
End;


Procedure SetDefaultDirectory;
Begin        {row,col,rows,cols,wattr,battr,brdr,name}
  {MakeWindow (10,10, 6,60,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1); }
  Instring:='';
  //Disp(12,12,'Currently  ' + LoggedDirectory);
  //Disp(12,13,'New Path : ');
  //Disp(23,13,copy(BlankString,1,45));    { only 48 char's for path }
  Repeat
    gotoxy(23 + length(Instring),13);
    Input:=ReadKey;
    if UpCase(CharInput) in ['!','#'..'&','(',')','0'..':','<'..'_'] then
    Begin
      if length(Instring) < 45 then Instring:=Instring + CharInput;
    End;
    if (CharInput=^H) and (length(Instring) > Zero) then
    Begin
      //Disp(23 + length(Instring)-1,13,' ');
      Delete(Instring,length(Instring),1);
    End;
    if CharInput=^[ then
    Begin
     { RemoveWindow; }
      Exit;
    End;
    //Disp(23,13,Instring);              { if no user entry then set  }
  Until CharInput=^M;                      { default to logged and save }
  if length(Instring)>0 then DefaultDirectory:=Instring
                        else DefaultDirectory:=LoggedDirectory;
  WriteDefaults;
  {RemoveWindow;}
End;


Procedure SetDefaultFile;
Begin
  {MakeWindow (10,10, 6,60,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1); }
  Window(1,1,80,25);
  Instring:='';
  //Disp(12,12,'Default File ' + FileName);
  //Disp(12,13,'File : ');
  //Disp(20,13,copy(BlankString,1,8));    { only 8 char's for file }
  Repeat
    gotoxy(20 + length(Instring),13);
    CharInput:=ReadKey;
    if UpCase(CharInput) in ['!','#'..'&','(',')','0'..':','<'..'_'] then
    Begin
      if length(Instring) < 8 then Instring:=Instring + CharInput;
    End;
    if (CharInput=^H) and (length(Instring) > Zero) then
    Begin
      //Disp(20 + length(Instring)-1,13,' ');
      Delete(Instring,length(Instring),1);
    End;
    if CharInput=^[ then
    Begin
     { RemoveWindow; }
      Exit;
    End;
    //Disp(20,13,Instring);
  Until CharInput=^M;
  if length(Instring) > Zero then DefaultFile:=Instring
                             else DefaultFile:=FileName;
  WriteDefaults;
  {RemoveWindow; }
End;


{ ---------------------- Update Procs -------------------- }

Procedure ErrorScreen;
Begin
  Mode:=ErrorMode;                    { Hole/Pipe data error screen }

  Window(13,5,67,19);
  TextBackground(Red);
  TextColor(LightGray);
  ClrScr;
  Window(1,1,80,25);
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
  ExitPrompt;
End;

Procedure CallHoleData;
Begin
  Repeat
    UpdateHole;
    if not Create then      { don't do this first time round ie on a new file }
    Begin
      DSHoleCalc;                  { check hole and initialise volumes }
                                 { mud volume reset when hole profile changed }
      if HoleError then
      Begin
        ErrorScreen;
        UpdatePipe;
      End;
    End;
  Until not HoleError;
End;

Procedure CallPipeData;
Begin
  Repeat
    UpdatePipe;
    DSHoleCalc;                  { Check for errors }
                               { mud volume reset when pipe profile changed }
    if HoleError then
    Begin
      ErrorScreen;
      UpdateHole;
    End;
  Until not HoleError;
End;


{ ---------------------- Create Procedures -------------------- }

Procedure CreateFileError;
Begin
 { MakeWindow (10,18, 5,44,Blue+LightGray,Blue+LightGray,HdoubleBrdr,
               Window1);}
  Window(1,1,80,25);
  //Disp(20,12,FileName + ' must first be CREATED');
  //Disp(20,13,PressPrompt);
  gotoxy(36,13);
  GetKey;
  NoFileDefined:=True;
 { RemoveWindow; }
End;


Procedure CreateFile;
Begin
  Create:=True;
  InitData;                             { and sets NewIf0 to Zero }
  APIUnits;                             { Default to API units    }
  UnitMenu;                             { then get selected units }
  UpdateGen;
  CallHoleData;         { get hole data and redo pipe/hole screens if error }
  CallPipeData;         { get pipe data and redo hole/pipe screens if error }
  UpdateBit;
  UpdateMud;
  UpdatePump;
  UpdateSurf;
  UpDateKick;
  NoData:=False;
  SaveData;
  Create:=False;
End;


Begin
End.
