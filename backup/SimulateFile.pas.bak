Unit SimulateFile;

Interface

Uses Crt,
     sysutils,
     DrillSimVariables,
     DrillSimFile,
     SimulateMessageToMemo,
     SimulateInit;

Procedure SaveFile;
Procedure SimulateLoadFile;

Implementation

Procedure SaveData;
Var i : integer;
Begin
  MessageToMemo(78);
  For i:=1 to 7 do                   { FCommands and call to MessageToMemo }
  Begin
    Data.UserLab[i]:=Lab[i];
    Data.UserCon[i]:=Con[i];
  End;
  if NewFile then
  Begin
    Assign(DataFile,FileName);       { if it's not the current file }
    rewrite(DataFile);
    write(DataFile,Data);
    Close(DataFile);
    NewFile:=False;                           { reset for next time }
  End else
  Begin
    Reset(DataFile);                          { otherwise save current file }
    write(DataFile,Data);
    Close(DataFile);
  End;
  Edited:=False;                              { reset edited flag }
End;


Procedure SaveFile;
Var OriginalFileName : String120;
Begin
  Instring:='';
  Repeat
    CharInput:=UpCase(ReadKey);
    if CharInput in ['!','#'..'&','(',')','0'..'9','@'..'_'] then
    Begin
      if length(Instring) < 8 then Instring:=Instring + CharInput;
    End;
    if (CharInput=^H) and (length(Instring) > Zero) then
    Begin
      Delete(Instring,length(Instring),1);
    End;
  Until (CharInput=^M) or (CharInput=^[);

  if CharInput <> ^[ then  { will accept null entry as acceptance of current file }
  Begin
    if (Instring <> FileName) then { diff. from current }
    Begin
      NewFile:=True;
      OriginalFileName:=FileName;        { save current file name          }
      FileName:=Instring;                { set FullName for file save      }
      SaveData;                          { save it                         }
      FileName:=OriginalFileName;        { restore original "current" file }
    End else SaveData;          { if same file entered or only ENTER pressed }
  End;
  {RemoveWindow;  }
End;


Procedure SimulateLoadFile;
Var i : integer;
Begin
  if Edited then
  Begin
    if ExitCheck then SaveData;         { save current file first }
  End;
  Repeat                           { repeat here because MUST be file defined }
    Instring:='';
    //Disp(20,11,'Currently : ' + FullName);
    //Disp(20,12,'File Name : ' + copy(BlankString,1,28)); { only 8 char's permitted for file name }
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
      if (CharInput=^[) and NoFileDefined then Quit:=True;  { back to DrillSim if no file }
    Until (CharInput=^M) or (CharInput=^[);
  Until FileExists(Instring + Extension) or (CharInput=^[); { valid file or ESC }
                               { Entry : FullName = filename.WDF    }
                               {       : NoFileD'd= False           }
                               { NoFileD'd may be true on entry to Simulator. }
                               { if trie and ESC, quit back to DS }
  if not (CharInput=^[) then
  Begin
    Assign(DataFile,Instring+Extension);
    Reset(DataFile);
    {$I-}                             { I/O error checking off }
    Read(DataFile,Data);
    {$I+}
    if not OK then                    { if bad file type... }
    Begin
      NoFileDefined:=True;
      FileName:='';
      Quit:=True;                           { back to DS - bad file }
    End;
    Close(DataFile);
    FileName:=Instring;
    NoData:=False;
    For i:=1 to 7 do
    Begin
      Lab[i]:=Data.UserLab[i];
      Con[i]:=Data.UserCon[i];
    End;
    InitMud;            { set OriginalMuds (to current mud W,Pv,Yp)           }
    InitDepth;          { save the original depth for this session            }
    InitGeology;        { locate correct current position within geology table}
    InitKick;           { initialise system variables, and set up if NeverSimulated }
    NoFileDefined:=False;
    Edited:=False;
  End;
  {RemoveWindow;}
End;

Begin
End.