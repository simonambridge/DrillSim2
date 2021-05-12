Unit DrillSimMessageToMemo;

Interface

Uses Dialogs,
     DrillSimVariables;

Procedure StringToMemo(S : String);
Procedure MessageToMemo(x : integer);


Implementation

Uses DrillSimGUI;


Procedure StringToMemo(S : String);
Begin
  if length(S) > Zero then   // display it
  Begin
    DrillSim.Memo1.Lines.Add(S);
    DrillSim.Memo1.SelStart:=Length(DrillSim.Memo1.Text);

    writeln(S);             {* write to the console too *}
  End;
End;

Procedure MessageToMemo(x : integer);  {pre-defined status messages }
Begin
  With Data do
  Begin
    LastString:=PreviousString;
    PreviousString:=ThisString;
    Case x of
      1 : ThisString:='Autodrill is ON';
      2 : ThisString:='Autodrill is OFF';
//      3 : ThisString:='ERROR : not pumping';
//      4 : ThisString:='ERROR : not rotating';
      5 : ThisString:='Unknown Command';
//      6 : ThisString:='Blind Rams are CLOSED';
//      7 : ThisString:='Blind Rams are OPEN';
//      8 : ThisString:='Pipe Rams are CLOSED';
//      9 : ThisString:='Pipe Rams are OPEN';
//     10 : ThisString:='Are you sure (Y/N)? ';
//     11 : ThisString:='Hydril is CLOSED';
//     12 : ThisString:='Hydril is OPEN';
//     13 : ThisString:='Unable to close RAMs';
//     14 : ThisString:='Circulating through Choke';
     15 : Begin
            Str(LagDS:6:Zero,ThisString);
            ThisString:='Lag Down :' + ThisString + ' str';
          End;
     16 : Begin
            Str(LagDT:6:1,ThisString);
            ThisString:='Lag Down :' + ThisString + ' min';
          End;
     17 : Begin
            Str(BitHP:6:2,ThisString);
            ThisString:='HHP Bit : ' + ThisString;
          End;
     18 : Begin
            Str(Eff:6:2,ThisString);
            ThisString:='Bit Eff : ' + ThisString + ' %';
          End;
     19 : Begin
            Str(TotHp:6:2,ThisString);
            ThisString:='HHP Total : ' + ThisString;
          End;
     20 : Begin
            Str(MWIn / UoMConverter[2]:5:2,ThisString);
            ThisString:='MW in : ' + ThisString + Space + UoMLabel[2];
          End;
     21 : Begin
            Str(MudPv:3:Zero,ThisString);
            ThisString:='PV in : ' + ThisString + ' cp';
          End;
     22 : Begin
            Str(MudYp:3:Zero,ThisString);
            ThisString:='YP in : ' + ThisString + ' lb/100ft2';
          End;
     23 : Begin
            Str(MudGel:3:Zero,ThisString);
            ThisString:='Gel in : ' + ThisString;
          End;
     24 : Begin
            Str(PlSurf / UoMConverter[3]:5:2,ThisString);
            ThisString:='Pl S.Eqpt : ' + ThisString + Space + UoMLabel[3];
          End;
     25 : Begin
            Str(PlPipe / UoMConverter[3]:5:2,ThisString);
            ThisString:='Pl Pipe : ' + ThisString + Space + UoMLabel[3];
          End;
     26 : Begin
            Str(PlBit / UoMConverter[3]:5:2,ThisString);
            ThisString:='Pl Bit : ' + ThisString  + Space + UoMLabel[3];
          End;
     27 : Begin
            Str(PlAnn / UoMConverter[3]:5:2,ThisString);
            ThisString:='Pl Ann. : ' + ThisString  + Space + UoMLabel[3];
          End;
     28 : Begin
            Str((PlSurf+PlAnn+PlBit+PlPipe+PlChoke+ChokeLinePl) / UoMConverter[3]:5:2,ThisString);
            ThisString:='Total : ' + ThisString  + Space + UoMLabel[3];
          End;
     29 : Begin
            Str(BHPAnn / UoMConverter[3]:5:2,ThisString);
            ThisString:='BHP Ann : ' + ThisString  + Space + UoMLabel[3];
          End;
     30 : Begin
            Str(AverageHhd / UoMConverter[3]:5:2,ThisString);
            ThisString:='Ave Hhd : ' + ThisString  + Space + UoMLabel[3];
          End;
     31 : ThisString:='Rheology Mode = Bingham';
     32 : ThisString:='Rheology Mode = Power Law';
     33 : ThisString:='Pump # ? ';
//     34 : Begin
//            Str(Pump[1,4]:5:Zero,ThisString);
//            ThisString:='' + ThisString  + Space + '   SPM ?'
//          End;
//     35 : Begin
//            Str(Pump[1,5] / UoMConverter[3]:8:2,ThisString);
//            ThisString:='' + ThisString  + Space + UoMLabel[3] + ' ? ';
//          End;
//     36 : Begin
//            Str(Pump[2,4]:5:Zero,ThisString);
//            ThisString:='' + ThisString  + Space + '   SPM ?';
//          End;
//     37 : Begin
//            Str(Pump[2,5] / UoMConverter[3]:8:2,ThisString);
//            ThisString:='' + ThisString  + Space + UoMLabel[3] + ' ? ';
//          End;
     38 : Begin
            Str(WOH / UoMConverter[7]:6:2,ThisString);
            ThisString:='WOH : ' + ThisString + Space + UoMLabel[7];
          End;
     39 : Begin
            Str(StrWt / UoMConverter[7]:6:2,ThisString);
            ThisString:='Str. Wt : ' + ThisString  + Space + UoMLabel[7];
          End;
     40 : Begin
            Str(ECD / UoMConverter[2]:6:3,ThisString);
            ThisString:='ECD : ' + ThisString  + Space + UoMLabel[2];
          End;
     41 : Begin
            Str(MudWt / UoMConverter[2]:6:3,ThisString);
            ThisString:='Av. MW : ' + ThisString  + Space + UoMLabel[2];
          End;
     42 : Begin
            Str(AnnMW / UoMConverter[2]:6:3,ThisString);
            ThisString:='Ann. MW : ' + ThisString  + Space + UoMLabel[2];
          End;
     43 : Begin
            Str(PipeMW / UoMConverter[2]:6:3,ThisString);
            ThisString:='Pipe MW : ' + ThisString  + Space + UoMLabel[2];
          End;
     44 : Begin
            Str(Fn:6:2,ThisString);
            ThisString:='Exp "n" : ' + ThisString;
          End;
     45 : Begin
            Str(Fk:6:2,ThisString);
            ThisString:='Exp "k" : ' + ThisString  + Space + UoMLabel[3];
          End;
     46 : Begin
            Str(LagUS:8:Zero,ThisString);
            ThisString:='Lag Up : ' + ThisString  + ' str';
          End;
     47 : Begin
            Str(LagUT:8:1,ThisString);
            ThisString:='Lag Up : ' + ThisString  + ' min';
          End;
     48 : Begin
            Str(AnnVol/UoMConverter[4]:6:2,ThisString);
            ThisString:='Ann. Vol. : ' + ThisString  + Space + UoMLabel[4];
          End;
     49 : Begin
            Str(PipeCap/UoMConverter[4]:6:2,ThisString);
            ThisString:='Pipe Vol. : ' + ThisString  + Space + UoMLabel[4];
          End;
     50 : Begin
            Str(MudVol/UoMConverter[4]:6:2,ThisString);
            ThisString:='Mud Vol. : ' + ThisString  + Space + UoMLabel[4];
          End;
     51 : Begin
            Str(WellVol/UoMConverter[4]:6:2,ThisString);
            ThisString:='Well ' + ThisString  + Space + UoMLabel[4];
          End;
     52 : ThisString:='Bushing not in table';
     53 : Begin
            Str((Formation[FormationPointer].FP + MACP) / UoMConverter[3]:5:2,ThisString);
            ThisString:='MACP : ' + ThisString  + Space + UoMLabel[3];
          End;
//     54 : ThisString:='Losing to formation';
     55 : Begin
            Str((PlChoke+ChokeLinePl) / UoMConverter[3]:5:2,ThisString);
            ThisString:='Pl Choke: ' + ThisString + Space + UoMLabel[3];
          End;
     56 : Begin
            Str(WaterFraction * 100:5:2,ThisString);
            ThisString:='Mud : ' + ThisString + ' % water';
          End;
     57 : Begin
            Str(OilFraction * 100:5:2,ThisString);
            ThisString:='Mud : ' + ThisString + ' % oil';
          End;
     58 : Begin
            Str(SolidsFraction * 100:5:2,ThisString);
            ThisString:='Mud : ' + ThisString + ' % sol.';
          End;
     59 : ThisString:='Version ' + VersionNumber + ' ' + VersionDate;
     60 : Begin
            Str(HoleVol / UoMConverter[4]:6:2,ThisString);
            ThisString:='Hole Vol. : ' + ThisString  + Space + UoMLabel[4];
          End;
     61 : Begin
            Str(AnnUnderbalance / UoMConverter[3]:5:2,ThisString);
            ThisString:='Ann U/b : ' + ThisString  + Space + UoMLabel[3];
          End;
     62 : Begin
            Str(PipeHhd / UoMConverter[3]:5:2,ThisString);
            ThisString:='P.Head : ' + ThisString  + Space + UoMLabel[3];
          End;
     63 : Begin
            Str(AnnHhd / UoMConverter[3]:5:2,ThisString);
            ThisString:='A.Head : ' + ThisString  + Space + UoMLabel[3];
          End;
     64 : ThisString:='Chokeline is open';

     65 : ThisString:='Chokeline is closed';

     66 : ThisString:='Stroke counter zeroed';

//     67 : ThisString:='Blow Out Preventers are OPEN';

     68 : ThisString:='Turn off pumps';

     69 : Begin
            Str(Data.Formation[FormationPointer].FP / UoMConverter[3]:5:2,ThisString);
            ThisString:='Form Pressure : ' + ThisString + Space + UoMLabel[3];
          End;

//     70 : Begin
//            ThisString:='Casing Failure!!!!!!!';
//            ShowMessage('Burst Casing! Game over :( ');
//            Clear;
//          End;

//     71 : ThisString:='PRESS ANY KEY...';

//     72 : Begin
//            ThisString:='Pits empty - no mud';
//            ShowMessage('Pits Empty! Game over :( ');
//            Clear;
//          End;

     73 : Begin
            Str(DrillMult,ThisString);
            ThisString:='Accelerator : ' + ThisString;
          End;

//     74 : Begin
//            ThisString:='Twisted off!!!!!!!';
//            ShowMessage('Twisted Off! Game over :( ');
//            Clear;
//          end;

     75 : Begin
            Str(TwistOff / UoMConverter[7]:5:2,ThisString);
            ThisString:='Twist off @ ' + ThisString + Space + UoMLabel[7];
          End;
     76 : Begin
            Str((LastKD + 27) / UoMConverter[1]:8:2,ThisString);
            ThisString:='K. down :' + ThisString + Space + UoMLabel[1];
          End;
     77 : Begin
            Str((RetPitVol) / UoMConverter[4]:8:2,ThisString);
            ThisString:='Pit Vol :' + ThisString + Space + UoMLabel[4];
          End;
     78 : Begin
            ThisString:='Saving '+ CurrentFQFileName;    { called by SaveData }
          End;

//    80 : Begin
//           ThisString:='Riser dimension error';
//         End;

//     81 : Begin
//            ThisString:='Casing dimension error';
//          End;
//     82 : Begin
//            ThisString:='You must have a casing if offshore';
//          End;
//     83 : Begin
//            ThisString:='Liner Dimension Error';
//          End;
//     84 : Begin
//            ThisString:='Hole Dimensions Error';
//          End;
//     85 : Begin
//            ThisString:='Number of pipes must be 1 to 4';
//          End;
//     86 : Begin
//            ThisString:='Enter pipe from BHA up to surface';
//          End;
//     87 : Begin
//            ThisString:='Pipe dimensions must not be zero';
//          End;
//    88 : Begin
//            ThisString:='Bit jets must be greater than zero';
//          End;
//     89 : Begin
//            ThisString:='Mud data must be greater than zero';
//          End;
//     90 : Begin
//            ThisString:='Invalid number of pumps (1 to 3)';
//          End;
//     91 : Begin
//            ThisString:='At least one pump must be defined';
//          End;
//     92 : Begin
//            ThisString:='At least one pump must be defined';
//          End;


     100 : Begin
            ThisString:='Please Wait';
          End;

//     101 : ThisString:='Blow Out Preventers are CLOSED';
//
//     102 : Begin
//            ThisString:='Loading application configuration file';
//          End;
//     103 : Begin
//            ThisString:='Loading application help file';
//          End;
//     104 : Begin
//            ThisString:='<Empty>';
//          End;

    End;
    if length(ThisString) > Zero then   // display it
    Begin
      DrillSim.Memo1.Lines.Add(ThisString);
      DrillSim.Memo1.SelStart:=Length(DrillSim.Memo1.Text);
      //writeln(ThisString);  {* write to the console too *}
      ThisString:='';
    End;
  End;
End;

Begin
End.



