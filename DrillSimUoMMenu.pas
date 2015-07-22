Unit DrillSimUoMMenu;

Interface
Uses Crt,
     DrillSimVariables,
     DrillSimUnitsOfMeasure,
     DrillSimConversions,
     DrillSimUtilities,
     SimulateMessageToMemo;

Procedure UnitMenu;

Implementation

{*********************** Units Definition **************************}

Procedure ShowUnits(UnitType : String120; UnitNumber, LineNumber : integer);
Begin
  Str(con[UnitNumber]:10:5,TempString);
  //Disp(12,LineNumber,UnitType);
  //Disp(36,LineNumber,lab[UnitNumber]);
  //Disp(50,LineNumber,TempString);
End;


Procedure DisplayUnits;
Begin
  ShowUnits('Length',1,7);
  ShowUnits('Density',2,9);
  ShowUnits('Pressure',3,11);
  ShowUnits('Volume',4,13);
  ShowUnits('Flow Volume',5,15);
  ShowUnits('Flow Rate',6,17);
  ShowUnits('Weight',7,19);
  ExitPrompt;
  CharInput:=^M;              { set up for exit from UnitMenu }
End;


Procedure GetUserUnits(UnitType : String120; UnitNumber, LineNumber : integer);
var i : integer;
Begin
  //Disp(12,LineNumber,UnitType);                   { display unit type }
  //Disp(32,LineNumber,Lab[UnitNumber] + ' :');     { write current unit label }
  TextColor(White);                               { set text color for writes }

  gotoxy(38,LineNumber); { read new value, if any }
  read(Instring);
  if length(Instring) > Zero then Lab[UnitNumber]:=Instring;
  gotoxy(38,LineNumber); write(Lab[UnitNumber]);  { write new/old value }

  Repeat
    Str(Con[UnitNumber]:10:5,TempString);
    //Disp(45,LineNumber,TempString + ' :');  { write current conversion factor }

    gotoxy(58,LineNumber); { read new value, if any }
    read(Instring);
    if length(Instring) > Zero then Val(Instring,Con[UnitNumber],i);
//    if Con[UnitNumber]=Zero then LowBeep;
  Until Con[UnitNumber]<>Zero;

  gotoxy(58,LineNumber);
  write(Con[UnitNumber]:8:5);                      { write new/old value }
  TextColor(LightGray);
End;


Procedure UserScreen;
Begin
  GetUserUnits('Length',1,7);
  GetUserUnits('Density',2,9);
  GetUserUnits('Pressure',3,11);
  GetUserUnits('Volume',4,13);
  GetUserUnits('Flow Volume',5,15);
  GetUserUnits('Flow Rate',6,17);
  GetUserUnits('Weight',7,19);
  ExitPrompt;
End;


Procedure UnitScreen;
Begin
  StringToMemo('Selected Units : ' + Data.UserType);

  //Box(10,4,70,20);
  gotoxy(12,5); write('TYPE');
  gotoxy(36,5); write('UNIT');
  gotoxy(47,5); write('Multiplier to API');
  //DrawSingleLine(10,70,6);
  //DrawSingleLine(10,70,8);
  //DrawSingleLine(10,70,10);
  //DrawSingleLine(10,70,12);
  //DrawSingleLine(10,70,14);
  //DrawSingleLine(10,70,16);
  //DrawSingleLine(10,70,18);
End;

{*********************** Unit Menu Procedures ***************************}

Procedure UnitMenu;
Var i       : integer;

Procedure MenuChoice1;
Begin
  APIUnits;
  UnitScreen;
  DisplayUnits;
End;

Procedure MenuChoice2;
Begin
  MetricUnits;
  UnitScreen;
  DisplayUnits;
End;

Procedure MenuChoice3;
Begin
  if NewFile then APIUnits;
  Data.UserType:='User Defined';
  UnitScreen;
  UserScreen;
End;

Begin
  Mode  := UnitMode;
  Menu[1]:='API.......................1';
  Menu[2]:='Metric....................2';
  Menu[3]:='User......................3';
  Menu[4]:='Accept Current Units......4';

  //Box(25,6,55,12);            { set menu box colours and draw box }
  MaxChoice:=4;
  For i:=1 to MaxChoice do //Disp(27,7+i-1,Menu[i]);
  MinChoice:=1;
  Choice:=1;
  OldChoice:=1;
  NewChoice:=1;
  ConAPI;                        { Convert to API prior to selection }
  ConAPIKickData;
  StringToMemo('Current units are '+Data.UserType);

  Repeat
    Normal(OldChoice);
    Bright(NewChoice);
    OldChoice:=NewChoice;
    Repeat
      CharInput:=ReadKey;
    until CharInput in ['1'..'4',' ',^M,^[,#0];
    Case CharInput of
      '1' : MenuChoice1;
      '2' : MenuChoice2;
      '3' : MenuChoice3;    { choice=4 will fall through - no change }
      ' ' : Choice:=Choice+1;
      ^M  : Begin
              Case Choice of
                1 : MenuChoice1;
                2 : MenuChoice2;
                3 : MenuChoice3;
              End;
            End;
      #0  : Begin
              //if KeyPressed then
              Begin
                CharInput:=ReadKey;
                if CharInput=#72 then Choice:=Choice-1;
                if CharInput=#80 then Choice:=Choice+1;
              End;
            End;
    End;
    if Choice > MaxChoice then Choice:=MinChoice;
    if Choice < MinChoice then Choice:=MaxChoice;
    NewChoice:=Choice;
  Until CharInput in [^M,'1'..'4'];
  if not NoData then
  Begin
    ConUser;           { Convert to new user units }
    ConUserKickData;
  End;
End;

Begin
End.