Unit DrillSimDataInput;

Interface

Uses Crt,
     DrillSimVariables,
     DrillSimUtilities,
     DrillSimMessageToMemo;

Procedure UpdateWellTests;
Procedure UpdatePipe;
Procedure UpdateBit;
Procedure UpdateMud;
Procedure UpdatePump;
Procedure UpdateSurf;

Implementation

Procedure GetState(Item : boolean);
Begin
  if Item then YesNo:=Yes else YesNo:=No;
End;

{*********************** Input Procedures ******************}

Procedure UpdateWellTests;
Var i,j : integer;
    ZeroFound : boolean;
    EscPressed: boolean;

Function CheckForZero : boolean;
Begin
  if (Data.Rock[i].Depth = Zero)
    or (Data.Rock[i].Hardness = Zero)
    or (Data.Rock[i].FP = Zero) then CheckForZero:=True
                                else CheckForZero:=False;
End;

Begin
  With Data do
  Begin
    gotoxy(10,6);
    write('Last Leak-off depth      : ',LotTD:9:3,' ',UoMLabel[1]);
    gotoxy(10,8);
    write('Last Leak-off Mud Weight : ',LotMW:9:3,' ',UoMLabel[2]);
    gotoxy(10,10);
    write('Last Leak-off EMW        : ',LotEMW:9:3,' ',UoMLabel[2]);
    gotoxy(10,12);
    write('Last Leak-off Pressure   : ',LotPressure:9:3,' ',UoMLabel[3]);
    gotoxy(10,14);
    write('Casing Burst Pressure    : ',BurstPressure:9:3,' ',UoMLabel[3]);
    For i:=1 to MaxPipes do
    Begin
      gotoxy(10,16+(i-1));
      write('Pipe #',i,' Weight           : ',Pipe[i,4]:9:3,' lb/ft');
    End;

    GetReal(55,6,25000/UoMConverter[1]);
    if Valid then LotTD:=RealResult;
    gotoxy(55,6); write(LotTD:9:3);

    GetReal(55,8,25/UoMConverter[2]);
    if Valid then LotMW:=RealResult;
    gotoxy(55,8); write(LotMW:9:3);

    GetReal(55,10,25/UoMConverter[2]);
    if Valid then LotEMW:=RealResult;
    gotoxy(55,10); write(LotEMW:9:3);

    GetReal(55,12,5000/UoMConverter[3]);
    if Valid then LotPressure:=RealResult;
    gotoxy(55,12); write(LotPressure:9:3);

    GetReal(55,14,15000/UoMConverter[3]);
    if Valid then BurstPressure:=RealResult;
    gotoxy(55,14); write(BurstPressure:9:3);

    For i:=1 to MaxPipes do
    Begin
      GetReal(55,16+(i-1),250);
      if Valid then Pipe[i,4]:=RealResult;
      gotoxy(55,16+(i-1)); write(Pipe[i,4]:9:3);
    End;

    StrWt:=Zero;       { set up strwt in case pipe weights changed }
    For i:=1 to MaxPipes do StrWt:=StrWt + (Pipe[i,1] * Pipe[i,4]) / 1000;


{ ===================== Formation Parameter Table ==========================}

    //Disp(14,4,'Horizon Top');
    //Disp(16,5,'('+UoMLabel[1]+')');

    //Disp(36,4, 'Hardness');
    //Disp(35,5,'(0.1 - 1.0)');

    //Disp(50,4,'Formation Pressure');
    //Disp(57,5,'('+UoMLabel[3]+')');

    //Box(10,6,70,17);
    //DrawSingleLine(10,70,6);

    For i:=1 to 10 do         { display current data table }
    Begin
      j:=7+(i-1);                              { calculate screen line number }

      Str(i:2,TempString);                     { display horizon number }
      //Disp(8,j,TempString);

      Str(Rock[i].Depth:9:3,TempString);       { display horizon top }
      //Disp(11,j,TempString);

      Str(Rock[i].Hardness:5:2,TempString);    { display horizon hardness }
      //Disp(33,j,TempString);

      Str(Rock[i].FP:9:3,TempString);          { display horizon form. pr. }
      //Disp(50,j,TempString);
    End;

    EscPressed:=False;
    i:=1;                                { start at first entry }

    Repeat
      j:=7+(i-1);
      TextColor(White);                             { select input text color }

      GetReal(22,j,25000/UoMConverter[1]);                   { get depth }
      if Esc then EscPressed:=True;                 { ESC ?     }
      if Valid then Rock[i].Depth:=RealResult;         { valid ? if yes, use it  }
      gotoxy(22,j); write(Rock[i].Depth:9:3);       { display current value   }
      if not EscPressed then                        { not if exit requested }
      Begin
        GetReal(42,j,1);                            { get hardness }
        if Esc then EscPressed:=True;
        if Valid then Rock[i].Hardness:=RealResult;
        gotoxy(42,j); write(Rock[i].Hardness:5:2);

        if not EscPressed then                      { not if exit requested }
        Begin
          GetReal(60,j,20000/UoMConverter[1]);               { get formation pressure }
          if Esc then EscPressed:=True;
          if Valid then Rock[i].FP:=RealResult;
          gotoxy(60,j); write(Rock[i].FP:9:3);
        End;
      End;

      if (i=1) and CheckForZero then
      Begin
        StringToMemo('First entries cannot be zero');
        EscPressed:=False;      { don't permit exit if bad data }
        i:=Zero;                { reset to start at first entry }
      End;
      i:=i+1;
    Until (i>10) or EscPressed;

    ZeroFound:=False;
    i:=1;               { start at second entry - first entry checked above }

    Repeat
      i:=i+1;
      if CheckForZero then
      Begin
        ZeroFound:=True;
        StringToMemo('Warning : some entries contain zero');
      End;
    Until (i=10) or ZeroFound;

    RockPointer:=1;          { set up for drilling - gets set up in Simulate }
                             { anyway but needs initialisation               }
    FormationPressureGradient:=
             ((Rock[1].FP * UoMConverter[3]) / (Rock[1].Depth * UoMConverter[1])) / Presscon;
  End;
 End;

{ ===================== General Well Data ==========================}



{ ===================== Hole Data ==========================}



{ ===================== Pipe Data ==========================}

Procedure UpdatePipe;
Var i, j : integer;
    InputError : boolean;
    Str1,Str2 : String[10];
Begin
  With Data do
  Begin
    Repeat
      Repeat
        gotoxy(10,4);
        write('How Many Pipe Sections  : ',MaxPipes:4,' ?');
        ClrEol;
        GetInt(55,4,4);
        if Valid then MaxPipes:=IntResult;
        gotoxy(55,4); write(MaxPipes:9);
        if not(MaxPipes in [1..4]) then
                        MessageToMemo(85); // Number of pipes must be 1 to 4
      Until MaxPipes in [1..4];

      MessageToMemo(85); // Enter pipe from BHA up to surface

      For i:=1 to MaxPipes do
      Begin
        Str(i:3,Str1);
        Str(Pipe[i,1]:9:3,Str2);
        //Disp(10,6+(i-1)*4,'Pipe #'+Str1+' Length : '+Str2 + ' '+UoMLabel[1]+' ?');

        Str(Pipe[i,2]:9:3,Str2);
        //Disp(20,7+(i-1)*4,'ID     : '+Str2+' ins ?');

        Str(Pipe[i,3]:9:3,Str2);
        //Disp(20,8+(i-1)*4,'OD     : '+Str2+' ins ?');
      End;

      For i:=1 to MaxPipes do
      Begin
        GetReal(55,6+(i-1)*4,35000.0/UoMConverter[1]);   { get pipe length }
        if Valid then Pipe[i,1]:=RealResult;
        Str(Pipe[i,1]:9:3,Str2);
        //Disp(55,6+(i-1)*4,Str2);

        GetReal(55,7+(i-1)*4,20);               { get pipe id }
        if Valid then Pipe[i,2]:=RealResult;
        Str(Pipe[i,2]:9:3,Str2);
        //Disp(55,7+(i-1)*4,Str2);

        GetReal(55,8+(i-1)*4,20);               { get pipe od }
        if Valid then Pipe[i,3]:=RealResult;
        Str(Pipe[i,3]:9:3,Str2);
        //Disp(55,8+(i-1)*4,Str2);
      End;
      InputError:=False;
      for i:=1 to MaxPipes do
      Begin
        for j:=1 to 3 do if Pipe[i,j]=Zero then InputError:=True;
      End;
      if InputError then
      Begin
        MessageToMemo(87); // Pipe dimensions must not be zero
        Window(55,4,80,18);
        ClrScr;
        Window(1,1,80,25);
      End;
    Until not InputError;
  End;
End;


{ ===================== Bit Data ==========================}

Procedure UpdateBit;
Var i : integer;
    InputError : boolean;
Begin
  With Data do
  Begin
    Repeat
      gotoxy(10,10);
      write('Current Bit #   : ',BitNumber:10,'  ?');
      GetInt(55,10,200);
      if Valid then BitNumber:=IntResult;
      gotoxy(55,10); write(BitNumber:9);

      //Disp(10,11,'Bit Type        :');
      //Disp(41-length(BitType+'  ?'),11,BitType+'  ?');
      GetString(55,11,10);
      if Valid then BitType:=InString;
      //Disp(64-length(BitType),11,BitType);

      Repeat
        gotoxy(10,12);
        write('How Many Jets   : ',MaxJets:10,'  ?');
        GetInt(55,12,4);
        if Valid then MaxJets:=IntResult;
      Until MaxJets in [1..4];
      gotoxy(55,12); write(MaxJets:9);

      if MaxJets<4 then
      Begin
        For i:=MaxJets+1 to 4 do
        Begin
          Jet[i]:=Zero;               { Zero all extra jets }
        End;
      End;

      For i:=1 to MaxJets do
      Begin
        gotoxy(10,13+(i-1));
        write('Jet # ',i,Blank9,': ',Jet[i]:5,' / 32" ?');
        ClrEol;
      End;

      InputError:=False;
      For i:=1 to MaxJets do
      Begin
        GetInt(55,13+(i-1),32);
        if Valid then Jet[i]:=IntResult;
        gotoxy(55,13+(i-1)); write(Jet[i]:9);
        if Jet[i]<=Zero then InputError:=True;   { Check for at least one }
      End;                                       { valid bit jet          }
      if InputError then MessageToMemo(88); // Bit jets must be greater than zero
    Until not InputError;
  End;
End;


{ ===================== Mud Data ==========================}

Procedure UpdateMud;
Var InputError : boolean;
Begin
 With Data do
  Begin
    Repeat
      gotoxy(10,10);
      write('Mud Weight',Blank9,': ',MudWt:9:3,' ',UoMLabel[2],Blank7,' ?');

      gotoxy(10,11);
      write('Plastic Viscosity  :   ',MudPv:7:1,' centipoise ?');

      gotoxy(10,12);
      write('Yield Point',Blank7,' :   ',MudYp:7:1,' lb/100ft2  ?');

      gotoxy(10,13);
      write('Gel Strength       :   ',MudGel:7:1,Blank11,' ?');

      GetReal(55,10,25/UoMConverter[2]);
      if Valid then MudWt:=RealResult;
      gotoxy(55,10); write(MudWt:9:3);

      GetReal(55,11,100);
      if Valid then MudPv:=RealResult;
      gotoxy(57,11); write(MudPv:7:1);

      GetReal(55,12,100);
      if Valid then MudYp:=RealResult;
      gotoxy(57,12); write(MudYp:7:1);

      GetReal(55,13,100);
      if Valid then MudGel:=RealResult;
      gotoxy(57,13); write(MudGel:7:1);
      if (MudWt=Zero) or (MudYP=Zero) or (MudPV=Zero) then
      Begin
        InputError:=True;
        MessageToMemo(89); // Mud data must be greater than zero
      End else InputError:=False;
    Until not InputError;
  End;
End;

{ ===================== Pump Data ==========================}


Procedure UpdatePump;
Var i : integer;
    Str1,Str2 : String[10];
    InputError : boolean;
Begin
  With Data do
  Begin
    Repeat
      Str(MaxPumps:9,Str1);
      //Disp(10,6,'How Many Pumps      : '+Str1+'     ?');
      GetInt(55,6,3);
      if Valid then MaxPumps:=IntResult;
      gotoxy(55,6); write(MaxPumps:9);

      if not(MaxPumps in [1..3]) then
                         MessageToMemo(90); // Invalid number of pumps (1 to 3)
    Until MaxPumps in [1..3];

    Str(MaxPumpPressure:9:3,Str1);
    //Disp(10,7,'Max. Pump Pressure  : '+Str1+' '+UoMLabel[3]+' ?');
    GetReal(55,7,5000/UoMConverter[3]);
    if Valid then MaxPumpPressure:=RealResult;
    gotoxy(55,7); write(MaxPumpPressure:9:1);

    Repeat
      For i:=1 to MaxPumps do            { first display current data }
      Begin
        Str(i:3,Str2);
        Str(Pump[i,1]:9:3,Str1);
        //Disp(10,9+(i-1)*4,'Pump #'+Str2+'  Output     : '+Str1+' '+UoMLabel[5]+' ?');

        Str(Pump[i,2]:9:3,Str1);
        //Disp(21,10+(i-1)*4,'Efficiency : '+Str1+' %   ?');

        Str(Pump[i,3]:9:Zero,Str1);
        //Disp(21,11+(i-1)*4,'Strokes    : '+Str1+' SPM ?');
      End;

      For i:=1 to MaxPumps do            { then get the data required }
      Begin
        GetReal(55,9+(i-1)*4,5000/UoMConverter[5]);
        if Valid then Pump[i,1]:=RealResult;
        gotoxy(55,9+(i-1)*4); write(Pump[i,1]:9:1);

        GetReal(55,10+(i-1)*4,100);
        if Valid then Pump[i,2]:=RealResult;
        gotoxy(55,10+(i-1)*4); write(Pump[i,2]:9:1);

        GetReal(55,11+(i-1)*4,300);
        if Valid then Pump[i,3]:=RealResult;
        gotoxy(55,11+(i-1)*4); write(Pump[i,3]:9:Zero);
      End;

      InputError:=True;          { check vol/stroke and efficiency     }
      For i:=1 to MaxPumps do    { if at least one pump pair is valid, }
      Begin                      { then no error in pump data          }
        if ((Pump[i,1]>Zero) and (Pump[i,2]>Zero)) then InputError:=False;
      End;

      if InputError then
      Begin
        MessageToMemo(91); // At least one pump must be defined
        Window(55,9,80,19);          { clear input variables display }
        ClrScr;
        Window(1,1,80,25);
      End;
    Until not InputError;
  End;
End;


{ ===================== Surface Equipment Data ==========================}

Procedure UpdateSurf;
Var j : integer;
    InputError : boolean;
    Str1 : String[10];
Begin
  With Data do
  Begin
    Repeat

      Str(Surf[1,1]:9:3,Str1);
      //Disp(10,7,'Kelly  Length      : '+Str1+' '+UoMLabel[1]+' ?');

      Str(Surf[1,2]:9:3,Str1);
      //Disp(17,8,'ID          : '+Str1+' ins ?');

      Str(Surf[2,1]:9:3,Str1);
      //Disp(10,10,'Swivel Length      : '+Str1+' '+UoMLabel[1]+' ?');

      Str(Surf[2,2]:9:3,Str1);
      //Disp(17,11,'ID          : '+Str1+' ins ?');

      Str(Surf[3,1]:9:3,Str1);
      //Disp(10,13,'Hose   Length      : '+Str1+' '+UoMLabel[1]+' ?');

      Str(Surf[3,2]:9:3,Str1);
      //Disp(17,14,'ID          : '+Str1+' ins ?');

      Str(Surf[4,1]:9:3,Str1);
      //Disp(10,16,'StandPipe Length   : '+Str1+' '+UoMLabel[1]+' ?');

      Str(Surf[4,2]:9:3,Str1);
      //Disp(17,17,'ID          : '+Str1+' ins ?');

      GetReal(55,7,40/UoMConverter[1]);
      if Valid then Surf[1,1]:=RealResult;
      gotoxy(55,7); write(Surf[1,1]:9:3);

      GetReal(55,8,30);
      if Valid then Surf[1,2]:=RealResult;
      gotoxy(55,8); write(Surf[1,2]:9:3);

      GetReal(55,10,20/UoMConverter[1]);
      if Valid then Surf[2,1]:=RealResult;
      gotoxy(55,10); write(Surf[2,1]:9:3);

      GetReal(55,11,30);
      if Valid then Surf[2,2]:=RealResult;
      gotoxy(55,11); write(Surf[2,2]:9:3);

      GetReal(55,13,150/UoMConverter[1]);
      if Valid then Surf[3,1]:=RealResult;
      gotoxy(55,13); write(Surf[3,1]:9:3);

      GetReal(55,14,30);
      if Valid then Surf[3,2]:=RealResult;
      gotoxy(55,14); write(Surf[3,2]:9:3);

      GetReal(55,16,200/UoMConverter[1]);
      if Valid then Surf[4,1]:=RealResult;
      gotoxy(55,16); write(Surf[4,1]:9:3);

      GetReal(55,17,30);
      if Valid then Surf[4,2]:=RealResult;
      gotoxy(55,17); write(Surf[4,2]:9:3);

      InputError:=False;
      For j:=1 to 4 do                    { check for any zero entries }
      Begin
        if (Surf[j,1]=Zero) or (Surf[j,2]=Zero) then InputError:=True
      End;

      if InputError then
      Begin
        MessageToMemo(92); // Equipment data must not be zero
        Window(55,7,80,17);
        ClrScr;
        Window(1,1,80,25);
      End;
    Until not InputError;
  End;
End;

Begin
End.

