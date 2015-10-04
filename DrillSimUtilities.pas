Unit DrillSimUtilities;

Interface

Uses Crt,
     Dos,
     Math, Classes, SysUtils, ExtCtrls,
     DrillSimVariables,
     Dialogs;

Procedure HelpWindow(Index : integer);
Procedure GetCurrentDate (Var d : Date);
Procedure GetCurrentTime (Var t : Time);
Function Round2(const Number: extended; const Places: longint): extended;

Implementation

function Round2(const Number: extended; const Places: longint): extended;
var t: extended;
begin
   t := power(10, places);
   Round2 := round(Number*t)/t;
end;

Procedure GetCurrentDate (Var d : Date);
Begin
  GetDate(d.Year, d.Month, d.day, d.DayOfWeek);
End;

Procedure GetCurrentTime (Var t : Time);
Begin
  GetTime(t.Hours, t.Minutes, t.Seconds, t.Hundredths);
End;


Procedure HelpWindow(Index : integer);
Var i,j : integer;
Begin
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
End;

Begin
End.