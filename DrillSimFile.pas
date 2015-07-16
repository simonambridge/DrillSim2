Unit DrillSimFile;

Interface

Uses Crt,
     sysutils,
     DrillSimVariables,
     DrillSimUnitsOfMeasure,
     DrillSimConversions,
     DrillSimUtilities,
     SimulateMessageToMemo;

Procedure LoadData;            { Entry : FullName = filename.WDF    }
Procedure SaveData;
Procedure LoadFile;
Function OK : boolean;
Procedure SetPath;
Procedure GetDirectory;
Function  ExitCheck : boolean;

Implementation

Function OK : boolean;
Begin
  if IOResult <> Zero then OK:=False else OK:=True;
End;


Procedure SetPath;
Begin
  {MakeWindow (10,10, 6,60,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1);}
  Window(1,1,80,25);
  //Disp(12,12,'Currently  ' + LoggedDirectory);
  Repeat
    Instring:='';
    //Disp(12,13,'New Path : ' + copy(BlankString,1,45));  { only 45 char's for path }
    {ModCursor(CursorOn); }
    Repeat
        //Disp(23,13,Instring);
      GotoXY(23 + length(Instring),13);
      CharInput:=UpCase(ReadKey);
      if CharInput in ['!','#'..'&','(',')','0'..':','@'..'_'] then
      Begin
        if length(Instring) < 45 then Instring:=Instring + CharInput;
      End;
      if (CharInput=^H) and (length(Instring) > Zero) then
      Begin
          //Disp(23 + length(Instring)-1,13,' ');
        Delete(Instring,length(Instring),1);
      End;
    Until (CharInput=^M) or (CharInput=^[);
    if CharInput=^M then
    Begin
      if length(Instring) > Zero then
      Begin
        {$I-}
        ChDir(Instring);
        {$I+}
        if OK then LoggedDirectory:=Instring;
      End;
    End;
  Until OK or (CharInput=^[);       { go back if bad path }
  {ModCursor(CursorOff);}
  {RemoveWindow;   }
End;


Procedure GetDirectory;
Var FileCount, ColCount : integer;
Begin
  FileCount:=Zero; ColCount:=Zero;
  {MakeWindow (5,10, 15,60,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1);  }

  Code:=Zero;
  FileSpec:='*.WDF'+chr(Zero);;

  {RemoveWindow; }
End;

Function ExitCheck : boolean;
Begin
  {MakeWindow (2,10, 5,61,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1); }
  Window(1,1,80,25);
  //Disp(18,4,FileName + ' has been edited. Save (Y/N) ?');
  {ModCursor(CursorOn);}
  GotoXY(49+length(Filename),4);
  Repeat
    CharInput:=ReadKey;
  Until UpCase(CharInput) in ['Y','N'];
  if UpCase(CharInput)='Y' then ExitCheck:=True else ExitCheck:=False;
  {ModCursor(CursorOff);
  RemoveWindow; }
End;

{*********************** File Procedures ***************************}


Procedure LoadData;            { Entry : FullName = filename.WDF    }
Var i : integer;               {       : NewFile  = True if new     }
    ErrorString : AnyString;
Begin                          { Exit  : NewFile  = True if new     }
  NoFileDefined:=True;
  if NewFile then              {       : NoData   = True if NewFile }
  Begin                        {       : NoFileD'd= False           }
    NoData:=True;              {       : Edited   = False           }
    APIUnits;                  { InitMud not called here because it's called }
  End else                     { when entering Simulate for the first time on }
  Begin                        { any file loaded in DrillSim, and called  }
    Assign(DataFile,FileName); { in LoadFile in Simulate so all files are covered }
    Reset(DataFile);
    try                      { I/O error checking off }
      Read(DataFile,Data);
      CloseFile(DataFile);
    except
      on E: EInOutError do
      Begin
        StringToMemo(' - File handling error occurred. Details: ' + E.Message);
        Exit;
      end;
    End;
    NoFileDefined:=False;
    NoData:=False;
    Edited:=False;              { set this for entry into Simulate }
    For i:=1 to 7 do
    Begin
      Lab[i]:=Data.UserLab[i];
      Con[i]:=Data.UserCon[i];
    End;
    ConUser;                              { Load in API - then convert }
    ConUserKickData;
  End;
End;

Procedure LoadFile;
Var NoCreate : boolean;
    FileToLoad : string[12];
Begin
  if Edited then
  Begin
    if ExitCheck then SaveData; { save current file ? }
  End;
  {MakeWindow (10,18, 5,44,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1);  }
  Window(1,1,80,25);
  {ModCursor(CursorOn); }
  NoCreate:=False;
  NewFile:=False;
  Instring:='';
  //Disp(20,12,'File Name : '); { 8 char's  for file name }
  Repeat
    //Disp(32,12,Instring);
    gotoxy(32 + length(Instring),12);
    CharInput:=UpCase(ReadKey);
    if CharInput in ['!','#'..'&','(',')','0'..'9','@'..'_'] then
    Begin
      if length(Instring) < 8 then Instring:=Instring + CharInput;
    End;
    if (CharInput=^H) and (length(Instring) > Zero) then
    Begin
        //Disp(32 + length(Instring)-1,12,' ');
      Delete(Instring,length(Instring),1);
    End;
  Until (CharInput=^M) or (CharInput=^[);             { until end or abort }
  if CharInput<>^[ then                           { if not abort... }
  Begin
    if length(Instring) > Zero then           { check for any input }
    Begin
      FileToLoad:=Instring + Extension;
      if not FileExists(FileToLoad) then             { if it doesn't exist... }
      Begin
          //Disp(20,12,copy(BlankString,1,39));
          //Disp(20,12,FileToLoad + ' not found. Continue? (Y/N)');
        gotoxy(47+length(FileToLoad),12);
        Repeat                           { do you really want to continue ? }
          CharInput:=ReadKey;
        Until UpCase(CharInput) in ['Y','N'];
        if UpCase(CharInput)='N' then NoCreate:=True else NewFile:=True;
      End;
      if not NoCreate then             { if not abandoning create... }
      Begin
        FileName:=FileToLoad;
        LoadData;
      End;
    End;                                     { if no input then no change }
  End;
  {ModCursor(CursorOff);
  RemoveWindow;}
End;

Procedure SaveData;
Var i : integer;
Begin
  StringToMemo('Saving ' + FileName);
  ConAPI;                                  { Convert to API for SAVE }
  ConAPIKickData;
  For i:=1 to 7 do
  Begin
    Data.UserLab[i]:=Lab[i];
    Data.UserCon[i]:=Con[i];
  End;
  if NewFile then
  Begin
    Assign(DataFile,FileName);
    rewrite(DataFile);
    write(DataFile,Data);
    Close(DataFile);
    NewFile:=False;
  End else
  Begin
    Reset(DataFile);
    write(DataFile,Data);
    Close(DataFile);
  End;
  Edited:=False;                           { reset edit flag after save }
  ConUser;                                 { Convert to User after SAVE }
  ConUserKickData;
  StringToMemo('Saving ' + FileName);
End;

Begin
End.




