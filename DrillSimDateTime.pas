Unit DrillSimDateTime;

Interface

Uses Dos,
     DrillSimVariables;

Procedure GetCurrentDate (Var d : Date);
Procedure GetCurrentTime (Var t : Time);

Implementation


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

