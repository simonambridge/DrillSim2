Unit DrillSimUtilities;

Interface

Uses Crt,
     Dos,
     Math, Classes, SysUtils, ExtCtrls,
     DrillSimVariables,
     Dialogs;

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


Begin
End.
