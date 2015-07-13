Unit DrillSimMath;

Interface

Function Power(number, exponent : real) : real;

Implementation

Function Power(number, exponent : real) : real;
Begin
  Power:=exp(ln(number) * exponent);
End;

Begin
End.

