Unit SimulateUpdate;

Interface

Uses sysutils,
     DrillSimVariables,
     DrillSimUtilities,
     DrillSimMessageToMemo;

Procedure ScreenService;
Procedure DrawKelly;    { draws appropriate kelly and bushing @ KelHt }
Procedure SetKelly; { move kelly to drilling position ie. when loading a file }
Procedure StatusUpdate;
Procedure TimeUpdate;
Procedure FlowUpdate;


Implementation

Uses DrillSimGUI;

{ -------------------- Kelly Routines ------------------- }

Procedure DrawKelly;    { draws appropriate kelly and bushing @ KelHt }
var
  x : real;
Begin

  KellyImageIndex:=trunc((33-Data.KellyHeight) * 2.667);  { 80 px /30 feet = 2.667 px/foot }
  //KellyImageIndex:=KellyImageIndex div 10;

  StringToMemo('Kelly height = ' + FloatToStr(Data.KellyHeight));
  StringToMemo('KellyImageIndex = ' + IntToStr(KellyImageIndex));

  { quick and dirty code }
  if (KellyImageIndex = 0) then  KellyImageFileName:='kellyup-0.png'
  else if (KellyImageIndex > 0) and (KellyImageIndex <= 2) then  KellyImageFileName:='kellyup-2.png'
  else if (KellyImageIndex > 2) and (KellyImageIndex <= 4) then  KellyImageFileName:='kellyup-4.png'
  else if (KellyImageIndex > 4) and (KellyImageIndex <= 6) then  KellyImageFileName:='kellyup-6.png'
  else if (KellyImageIndex > 6) and (KellyImageIndex <= 8) then  KellyImageFileName:='kellyup-8.png'
  else if (KellyImageIndex > 8) and (KellyImageIndex <= 10) then  KellyImageFileName:='kellyup-8.png'
  else if (KellyImageIndex > 10) and (KellyImageIndex <= 20) then  KellyImageFileName:='kellyup-18.png'
  else if (KellyImageIndex > 20) and (KellyImageIndex <= 30) then  KellyImageFileName:='kellyup-30.png'
  else if (KellyImageIndex > 30) and (KellyImageIndex <= 40) then  KellyImageFileName:='kellyup-30.png'
  else if (KellyImageIndex > 40) and (KellyImageIndex <= 50) then  KellyImageFileName:='kellyup-42.png'
  else if (KellyImageIndex > 50) and (KellyImageIndex <= 60) then  KellyImageFileName:='kellyup-54.png'
  else if (KellyImageIndex > 60) and (KellyImageIndex <= 70) then  KellyImageFileName:='kellyup-66.png'
  else if (KellyImageIndex > 70) and (KellyImageIndex <= 80) then  KellyImageFileName:='kellyup-80.png';

  DrillSim.KellyImage.Picture.LoadFromFile(KellyImageFileName);

  if Data.KellyHeight = 33 then            { Set at top }
  Begin
    if Data.RPM > Zero then Data.RPM:=Zero;

    BushingImageFileName:='kellybushingup.png';
    DrillSim.BushingImage.Picture.LoadFromFile(BushingImageFileName);

  End else
  if (LastKellyHeight = 33) and (LastKellyHeight <> Data.KellyHeight)
  or (Data.RPM = 0) then { check if its just come off slips... }
  Begin
    BushingImageFileName:='kellybushingdown-1.png';
    DrillSim.BushingImage.Picture.LoadFromFile(BushingImageFileName);
  end;

  //StringToMemo('Image: ' + KellyImageFileName);
  //StringToMemo('Image: ' + BushingImageFileName);

  LastKellyHeight:=Data.KellyHeight;                 { set last kelly height for next refresh }
End; { procedure DrawKelly }


Procedure SetKelly; { move kelly to drilling position ie. after loading a file }
Var q, r : real;    { this procedure simply ramps the kelly height down until its = Data.KellyHeight }
Begin
  With Data do
  Begin
    if KellyHeight<33 then              { if off-slips move it to last position  }
    Begin
      q:=KellyHeight;
      KellyHeight:=33;
      While KellyHeight > q do          { ...move kelly down to correct position }
      Begin
        if (KellyHeight-q) > 0.05 then r:=0.05 else r:=0.0005; { 1/50000' }
        KellyHeight:=KellyHeight-r;
        DrawKelly;                { go away and draw it }
      End;
    End else DrawKelly;           { draw it in case KelHt=33               }
    LastKellyHeight:=KellyHeight;
    Str(Data.KellyHeight / UoMConverter[1]:5:2,TempString);
  End;
End;

{ ------------------ Rotate Kelly Bushing ----------------- }

Procedure TurnBushing;
Var x : real;
Begin
  With Data do
  Begin
    GetCurrentTime (t);
    RPMt1:=RPMt2;
    RPMt2:=t.Hundredths;
    if RPMt2 < RPMt1 then RPMt1:=RPMt1-100;
    x:=((RPMt2 - RPMt1) / 100);
    CurrentTurn:=CurrentTurn + x;
    if CurrentTurn > (10 / RPM) then
    Begin
      CurrentTurn:=Zero;
      CurrentBushing:=CurrentBushing + 1;
      if CurrentBushing > 9 then CurrentBushing:=1;
      BushingImageFileName:='kellybushingdown-'+ IntToStr(CurrentBushing) + '.png';
      DrillSim.BushingImage.Picture.LoadFromFile(BushingImageFileName);
    End;
  End;
//  AttrByte:=TAttr;
End;

{ -------------------- Screen  Updates ------------------- }

Procedure FlowUpdate;
Var i          : integer;
Begin
  With Data do
  Begin
    for i:=1 to 3 do
    Begin
      if Pump[i,3] <> LastSPM[i] then
      Begin
        Str(Pump[i,3]:6:Zero,TempString);
        ////Disp(16,16+((i-1)*2),TempString);
        LastSPM[i]:=Pump[i,3];
      End;
    End;

    if MwIn <> LastMwIn then
    Begin
      Str(MwIn / UoMConverter[2]:6:3,TempString);
      ////Disp(43,17,TempString);
      LastMwIn:=MwIn;
    End;

    if MwOut <> LastMwOut then
    Begin
      Str(MwOut / UoMConverter[2]:6:3,TempString);
      ////Disp(43,19,TempString);
      LastMwOut:=MwOut;
    End;

    if int(StrokeCounter) <> int(LastStrokeCounter) then
    Begin
      Str(StrokeCounter:8:Zero,TempString);
      ////Disp(14,23,TempString);
      LastStrokeCounter:=StrokeCounter;
    End;

    if FlowIn <> LastFlowIn then
    Begin
      Str(FlowIn / UoMConverter[5]:8:2,TempString);
      ////Disp(66,13,TempString);
      LastFlowIn:=FlowIn;
    End;

    if FlowOut <> LastFlowOut then
    Begin
      Str(FlowOut / UoMConverter[5]:8:2,TempString);
      ////Disp(66,15,TempString);
      LastFlowOut:=FlowOut;
    End;

    if PlCirc <> LastPlCirc then
    Begin
      Str(PlCirc / UoMConverter[3]:8:2,TempString);
      ////Disp(66,18,TempString);
      LastPlCirc:=PlCirc;
    End;

    if RetPitVol <> LastRetPitVol then
    Begin
      Str(RetPitVol / UoMConverter[4]:8:2,TempString);
      ////Disp(66,21,TempString);
      LastRetPitVol:=RetPitVol;
    End;

    PitGain:=FlowOut - FlowIn;              { Check Differential Flow }
    if PitGain <> LastPitGain then
    Begin
      Str(PitGain / Bbl2Gal / UoMConverter[4]:8:3,TempString);
      ////Disp(66,23,TempString);
      LastPitGain:=PitGain;
    End;

    if Choke <> LastChoke then
    Begin
      Str(Choke:4,TempString);
      ////Disp(66,10,TempString);
      LastChoke:=Choke;
    End;
  End;
End;

Procedure DepthUpdate;
Begin
  With Data do
  Begin
    if BitTD <> LastBitTD then
    Begin
      Str(BitTD / UoMConverter[1]:8:2,TempString);
      ////Disp(15,3,TempString);
      LastBitTD:=BitTD;
    End;
    if TD <> LastTD then
    Begin
      Str(TD / UoMConverter[1]:8:2,TempString);
      ////Disp(15,6,TempString);
      LastTD:=TD;
    End;
  End;
End;


Procedure ShutInUpdate;
Begin
  With Data do
  Begin
    if BHPAnn <> LastBHPAnn then
    Begin
      Str(BHPAnn / UoMConverter[3]:8:2,TempString);
      ////Disp(15,9,TempString);
      LastBHPAnn:=BHPAnn;
    End;
    if CasingPressure <> LastCasingPressure then
    Begin
      Str(CasingPressure / UoMConverter[3]:8:2,TempString);
      ////Disp(15,12,TempString);
      LastCasingPressure:=CasingPressure;
    End;
  End;
End;


Procedure DrillUpdate;
Begin
  With Data do
  Begin
    DepthUpdate;
    if WOB <> LastWOB then
    Begin
      Str(WOB / UoMConverter[7]:8:2,TempString);
      ////Disp(15,9,TempString);
      LastWOB:=WOB;
    End;
    if RPM <> LastRPM then
    Begin
      Str(RPM:6:Zero,TempString);
      ////Disp(16,12,TempString);
      LastRPM:=RPM;
    End;
    if ROP <> LastROP then
    Begin
      Str(ROP * UoMConverter[1]:6:2,TempString);
      ////Disp(46,13,TempString);
      LastROP:=ROP;
    End;
  End;
End;


Procedure TimeUpdate;
Begin
  GetCurrentTime (t);
  if t.Seconds <> LastSeconds then
  Begin
    TempString:=''; InString:='';
    Str(t.Hours:2,InString);     TempString:=InString  + ':';
    Str(t.Minutes:2,InString);   TempString:=TempString + InString + ':';
    Str(t.Seconds:2,InString);   TempString:=TempString + InString;
    ////Disp(46,10,TempString);
    LastSeconds:=t.Seconds;
  End;
End;


Procedure StatusUpdate;
Var i          : integer;
Label Loop;
Begin
  With Data do
  Begin
    if KellyHeight = 33 then                { calculate based on kelly height   }
    Begin                             { if at top then on slips           }
      if ShutIn then i:=6 else i:=1;  { and if shut in too then...shut in }
    End else
    if (TD >= LastKD + 27) then i:=2         { else if at KD depth...     }
    else                                     { ...then kelly down         }
    if Drilling then i:=3 else i:=4;         { else if we're DRILLING...  }
                                             { ...then we're drilling     }
                                             { else we're off bottom      }

Loop : if i<>Status then                   { i=current status, so update    }
       Begin                               { Status if different            }
         Case i of
           1 : TempString:=' On Slips ';   { this table maintains a pointer }
           2 : TempString:='Kelly Down';   { to the current operating       }
           3 : TempString:=' Drilling ';   { situation, but only updated    }
           4 : TempString:='Off Bottom';   { every 10 loops of Proc. Control}
           5 : TempString:='On Bottom ';
           6 : TempString:=' Shut-In  ';
         End;
         DrillSim.DrillingStatusValue.Caption:=TempString;           { display status on screen       }
         Status:=i;
       End;
  End;
End;


Procedure ScreenService;
Begin
  if Data.RPM > Zero then TurnBushing;
  TimeUpdate;
  FlowUpdate;
  if Data.ShutIn then ShutInUpdate else DrillUpdate;
End;

Begin
End.