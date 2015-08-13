Unit DrillSimFile;

Interface

Uses Crt,
     sysutils,
     DrillSimVariables,
     DrillSimUnitsOfMeasure,
     DrillSimUtilities,
     DrillSimMessageToMemo,
     DrillSimDataResets;

Procedure LoadData;            { Entry : FullName = filename.WDF    }
Procedure SaveData;
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


Procedure LoadData;            { Entry : "FileName" contains FQFN of file to load }
Var i : integer;               {          e.g. /a/b/c/Offshore.wdf  }
    ErrorString : String[120]; {       : NewFile  = True if new     }
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
        StringToMemo('DrillSimFile.LoadData: File handling error occurred. Details: ' + E.Message);
        InitData;   // if load borks then clear all well data elements
        Exit;
      end;
    End;
    NoFileDefined:=False;
    NoData:=False;
    Edited:=False;              { set this for entry into Simulate }

//    ConUser;                              { Load in API - then convert }
//    ConUserKickData;
  End;
End;


Procedure SaveData;
Var i : integer;
Begin
  StringToMemo('DrillSimFile.SaveData: Saving ' + FileName);
//  ConAPI;                                  { Convert to API for SAVE }
//  ConAPIKickData;
{*   For i:=1 to 7 do                user defined units no longer supported
  Begin
    Data.UserLab[i]:=Lab[i];
    Data.UserCon[i]:=Con[i];
  End;
  *}
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
//  ConUser;                                 { Convert to User after SAVE }
//  ConUserKickData;
  StringToMemo('DrillSimFile.SaveData: Saved ' + FileName);
End;

Begin
End.




