Unit DrillSimFileIO;

Interface

Uses Crt,
     DrillSimVariables,
     DrillSimSound;

Function OK : boolean;
Function Exist(Name:AnyString) : Boolean;

Procedure SetPath;
Procedure GetDirectory;
Function  ExitCheck : boolean;



Implementation

Function OK : boolean;
Begin
  if IOResult <> Zero then OK:=False else OK:=True;
End;


Function Exist(Name:AnyString) : Boolean;
Begin
  {$i-}
  assign(DataFile,Name);
  reset(DataFile);
  {$i+}
  if not OK then
  Begin
    Exist:=false;
  End else
  Begin
    Exist:=true;
    Close(DataFile);
  End;
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
        if not OK then LowBeep else LoggedDirectory:=Instring;
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
  //Disp(18,4,FullName + ' has been edited. Save (Y/N) ?');
  {ModCursor(CursorOn);}
  GotoXY(49+length(FullName),4);
  Repeat
    CharInput:=ReadKey;
  Until UpCase(CharInput) in ['Y','N'];
  if UpCase(CharInput)='Y' then ExitCheck:=True else ExitCheck:=False;
  {ModCursor(CursorOff);
  RemoveWindow; }
End;

Begin
End.

