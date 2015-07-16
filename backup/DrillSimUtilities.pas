Unit DrillSimUtilities;

Interface

Uses Crt,
     DrillSimVariables,
     HyCalcVariables,
     Dialogs, StdCtrls;

Procedure WriteTitle(Help, ESC, CR : boolean);
Procedure SystemError(x: integer);
Procedure GetKey;
Procedure ExitPrompt;    { display "press any key..." and clear all messages }
Procedure Bright(MenuChoice : integer);
Procedure Normal(MenuChoice : integer);
Procedure GetString(x, y, z : integer);
Procedure GetReal(x, y : integer; z : real);
Procedure GetInt(x, y, z : integer);
Procedure HelpWindow(Index : integer);
Procedure ConReal(Variable : real; Field,DPlaces : integer);
Procedure ConInt(Variable : integer; Field : integer);

Implementation

Procedure WriteTitle(Help, ESC, CR : boolean);
Var ModeString : AnyString;
Begin
  TAttr:=AttrByte;
  //SetColorSet(NormColors);
  Window(1,1,80,25);           { set full window addressing }
  TextBackground(Blue);
  TextColor(LightGray);
  ClrScr;

  //LineDraw(1,80,2);            { top horizontal line }
  //Disp(17,1,chr($b3));         { top vertical separators }
  //Disp(17,2,chr($c1));
  //Disp(63,1,chr($b3));
  //Disp(63,2,chr($c1));

//  LineDraw(1,80,24);           { bottom horizontal line }
  //Disp(40,24,chr($c2));        { bottom vertical separators }
  //Disp(40,25,chr($b3));

  //Disp(64,24,chr($c2));
  //Disp(64,25,chr($b3));

  //Disp(70,24,chr($c2));
  //Disp(70,25,chr($b3));

  //Disp(76,24,chr($c2));
  //Disp(76,25,chr($b3));


  //SetColorSet(TitleColors);                  { yellow on blue }
  //Disp(2,1,Title+' V' + VersionNumber);
  //Disp(65,1,'File : ' + FileName);

  if CR   then //Disp(66,25,Enter);
  if ESC  then //Disp(72,25,'ESC');
  if Help then //Disp(78,25,'F1');

  //Disp(19,1,CurrentMode);

  //SetColorSet(DataColors);
  if Create then ModeString:='Create - ' + Mode
            else ModeString:=Mode;

  //Disp(26,1,ModeString);

  AttrByte:=TAttr;
End;


Procedure SystemError(x: integer);
Begin
  Case x of
    1 : ShowMessage('Error 1 : DrillSim.Cfg missing');
    2 : ShowMessage('Error 2 : Default directory error');
    3 : ShowMessage('Error 3 : DrillSim.Hlp missing');
    4 : ShowMessage('Error 4 : ');
    5 : ShowMessage('Error 5 : HyCalc.Exe missing');
    6 : ShowMessage('Error 6 : Unable to load well data file');
  End;
End;


Procedure GetKey;
Begin
  Repeat Until Keypressed;
  CharInput:=UpCase(ReadKey);
End;

Procedure ExitPrompt;    { display "press any key..." and clear all messages }
Begin
  TAttr:=AttrByte;
  gotoxy(58,25);                           { wait for input  }
  GetKey;
  AttrByte:=TAttr;
End;

Procedure Bright(MenuChoice : integer);
Begin
  TAttr:=AttrByte;
  //SetColorSet(NormColors);
  //Disp(27,7+MenuChoice-1,Menu[MenuChoice]);
  AttrByte:=TAttr;
End;

Procedure Normal(MenuChoice : integer);
Begin
  TAttr:=AttrByte;
  //SetColorSet(BlueOnGray);
  //Disp(27,7+MenuChoice-1,Menu[MenuChoice]);
  AttrByte:=TAttr;
End;

Procedure GetString(x, y, z : integer);  { cursor is set on in calling routine }
Begin
  Edited:=True;
  Valid:=False;
  Esc:=False;
  Instring:='';
  Repeat
    gotoxy(x + length(Instring),y);
    CharInput:=ReadKey;
    if UpCase(CharInput) in [' '..'_',^[] then
    Begin
      if CharInput=^[ then
      Begin
        Esc:=True;
        Exit;
      End;
      if length(Instring) < z then Instring:=Instring + CharInput;
    End;
    if (CharInput=^H) and (length(Instring) > Zero) then
    Begin
        //Disp(x + length(Instring)-1,y,' ');
      Delete(Instring,length(Instring),1);
    End;
    //Disp(x,y,Instring);
  Until CharInput=^M;
  if length(Instring) > Zero then Valid:=True;
  //Disp(x,y,copy(BlankString,1,length(Instring)));
End;


Procedure GetReal(x, y : integer; z : real);
Var i : integer;
Begin
  Edited:=True;
  Valid:=False;
  Esc:=False;
  Repeat
    Instring:=''; i:=Zero; RResult:=Zero;
    gotoxy(x,y);
    //Disp(x,y,copy(BlankString,1,9));
    Repeat
      CharInput:=ReadKey;
      if UpCase(CharInput) in ['-','.','0'..'9',^[] then
      Begin
        if CharInput=^[ then
        Begin
          Esc:=True;
          Exit;
        End;
        if length(Instring) < 9 then Instring:=Instring + CharInput; { ie 99999.999}
      End;
      if (CharInput=^H) and (length(Instring) > Zero) then
      Begin
        gotoxy(x + length(Instring)-1,y); write(' ');
        Delete(Instring,length(Instring),1);
      End;
      gotoxy(x,y); write(Instring);
    Until CharInput=^M;
    if length(Instring)>Zero then Val(Instring,RResult,i);
  Until (i = Zero) and (RResult <= z);
  if length(Instring) > Zero then Valid:=True;
  //Disp(x,y,copy(BlankString,1,length(Instring)));
End;


Procedure GetInt(x, y, z : integer);
Var i : integer;
Begin
  Edited:=True;
  Valid:=False;
  Esc:=False;
  Repeat
    Instring:=''; i:=Zero; IResult:=Zero;
    gotoxy(x,y);
    //Disp(x,y,copy(BlankString,1,5));
    Repeat
      CharInput:=ReadKey;
      if UpCase(CharInput) in ['-','0'..'9',^[] then
      Begin
        if CharInput=^[ then
        Begin
          Esc:=True;
          Exit;
        End;
        if length(Instring) < 5 then Instring:=Instring + CharInput; { ie 32767 }
      End;
      if (CharInput=^H) and (length(Instring) > Zero) then
      Begin
        gotoxy(x + length(Instring)-1,y); write(' ');
        Delete(Instring,length(Instring),1);
      End;
      gotoxy(x,y); write(Instring);
    Until CharInput=^M;
    if length(Instring)>Zero then Val(Instring,IResult,i);
  Until (i = Zero) and (IResult <= z);
  if length(Instring) > Zero then Valid:=True;
  //Disp(x,y,copy(BlankString,1,length(Instring)));
End;


Procedure ConReal(Variable : real; Field,DPlaces : integer);
Begin
  Str(Variable:Field:DPlaces,TempString);
End;


Procedure ConInt(Variable : integer; Field : integer);
Begin
  Str(Variable:Field,TempString);
End;


Procedure HelpWindow(Index : integer);
Var i,j : integer;
Begin
  TAttr:=AttrByte;
  j:=(Index-1)*10+1;  { ie 1=1-10, 2=11-20, etc }
  {MakeWindow (4,10,15,60,Blue+LightGrayBG,Blue+LightGrayBG,HdoubleBrdr,
               Window1); }
  Window(1,1,80,25);
  //SetColorSet(BlueOnGray);
  if HelpFileFound then
  Begin
    for i:= j to j+9 do //Disp(12,6+(i-j),Help.HelpText[i]);
  End else
  Begin
    //Disp(12,12,NoHelp1);  { "help not found" }
    //Disp(12,14,NoHelp2);  { "no help available" }
  End;
  {ModCursor(CursorOn);}
  //Disp(12,17,PressPrompt);
  gotoxy(28,17);
  Repeat Until KeyPressed;
  CharInput:=ReadKey;
  {ModCursor(CursorOff); }
  {RemoveWindow; }
  AttrByte:=TAttr;
End;

Begin
End.