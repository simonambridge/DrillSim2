Unit DrillSimSound;

Interface

Uses Crt;

Procedure Beep;
Procedure LowBeep;

Implementation


Procedure Beep;
Begin
  Sound(880);
  Delay(100);
  NoSound;
End;


Procedure LowBeep;
Begin
  Sound(220);
  Delay(200);
  NoSound;
End;

Begin
End.

