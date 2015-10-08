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
Procedure MudUpdate;
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

  //StringToMemo('Kelly height = ' + FloatToStr(Data.KellyHeight) + '    KellyImageIndex = ' + IntToStr(KellyImageIndex));

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
    if CurrentTurn > (1 / RPM) then
    Begin
      CurrentTurn:=Zero;
      CurrentBushing:=CurrentBushing + 1;
      if CurrentBushing > 9 then CurrentBushing:=1;
      BushingImageFileName:='kellybushingdown-'+ IntToStr(CurrentBushing) + '.png';
      DrillSim.BushingImage.Picture.LoadFromFile(BushingImageFileName);
    End;
  End;
End;

{ -------------------- Screen  Updates ------------------- }

Procedure MudUpdate;
Begin
  //StringToMemo('SimulateUpdate:FlowUpdate called');
  With Data do
  Begin
    if MwIn <> LastMwIn then
    Begin
      DrillSim.MudWeightInValue.Caption:=FloatToStr(Round2(MwIn/UoMConverter[2],2)); { API -> displayed }
      LastMwIn:=MwIn;
    End;

    if MwOut <> LastMwOut then
    Begin
      DrillSim.MudWeightOutValue.Caption:=FloatToStr(Round2(MwOut/UoMConverter[2],2)); { API -> displayed }
      LastMwOut:=MwOut;
    End;

    if int(StrokeCounter) <> int(LastStrokeCounter) then
    Begin
      DrillSim.PumpStrokesValue.Caption:=FloatToStr(Round2(StrokeCounter/UoMConverter[2],2)); { API -> displayed }
      LastStrokeCounter:=StrokeCounter;
    End;

  end;
End;

Procedure FlowUpdate;
Begin
  //StringToMemo('SimulateUpdate:FlowUpdate called');
  With Data do
  Begin

    if FlowIn <> LastFlowIn then
    Begin
      DrillSim.FlowInValue.Caption:=FloatToStr(Round2(FlowIn/UoMConverter[5],2)); { API -> displayed }
      LastFlowIn:=FlowIn;
    End;

    if FlowOut <> LastFlowOut then
    Begin
      DrillSim.FlowOutValue .Caption:=FloatToStr(Round2(FlowIn/UoMConverter[5],2)); { API -> displayed }
      LastFlowOut:=FlowOut;
    End;

    if PlCirc <> LastPlCirc then
    Begin
      DrillSim.StandPipePressureValue.Caption:=FloatToStr(Round2(PlCirc/UoMConverter[3],2)); { API -> displayed }
      LastPlCirc:=PlCirc;
    End;

    if RetPitVol <> LastRetPitVol then
    Begin
      DrillSim.ReturnPitValue.Caption:=FloatToStr(Round2(RetPitVol/UoMConverter[4],2)); { API -> displayed }
      LastRetPitVol:=RetPitVol;
    End;

    PitGain:=FlowOut - FlowIn;              { Check Differential Flow }
    if PitGain <> LastPitGain then
    Begin
      DrillSim.DiffFlowValue.Caption:=FloatToStr(Round2(PitGain/UoMConverter[4],2)); { API -> displayed }
      LastPitGain:=PitGain;
    End;

    if Choke <> LastChoke then
    Begin
      DrillSim.ChokeValue.Caption:=FloatToStr(Round2(Choke,2)); { API -> displayed }
      LastChoke:=Choke;
    End;
  End;
End;

Procedure DepthUpdate;
Begin
  //StringToMemo('SimulateUpdate:DepthUpdate called');
  With Data do
  Begin
    if BitTD <> LastBitTD then
    Begin
      DrillSim.BitDepthValue.Caption:=FloatToStr(Round2(BitTD/UoMConverter[1],2)); { API -> displayed }
      LastBitTD:=BitTD;
    End;
    if TD <> LastTD then
    Begin
      DrillSim.TotalDepthValue.Caption:=FloatToStr(Round2(TD/UoMConverter[1],2)); { API -> displayed }
      LastTD:=TD;
    End;
  End;
End;


Procedure ShutInUpdate;
Begin
  //StringToMemo('SimulateUpdate:ShutInUpdate called');
  With Data do
  Begin
    if BHPAnn <> LastBHPAnn then
    Begin
      DrillSim.AnnularPressureValue.Caption:=FloatToStr(Round2(BHPAnn/UoMConverter[3],2)); { API -> displayed }
      LastBHPAnn:=BHPAnn;
    End;
    if CasingPressure <> LastCasingPressure then
    Begin
      DrillSim.CasingPressureValue.Caption:=FloatToStr(Round2(CasingPressure/UoMConverter[3],2)); { API -> displayed }
      LastCasingPressure:=CasingPressure;
    End;
  End;
End;


Procedure DrillUpdate;
Begin
  //StringToMemo('SimulateUpdate:DrillUpdate called');
  With Data do
  Begin
    DepthUpdate;
    if WOB <> LastWOB then
    Begin
      DrillSim.WOBValue.Caption:=FloatToStr(Round2(WOB/UoMConverter[7],2)); { API -> displayed }
      LastWOB:=WOB;
    End;
    if RPM <> LastRPM then
    Begin
      DrillSim.RPMValue.Caption:=FloatToStr(RPM); { API -> displayed }
      LastRPM:=RPM;
    End;
    if ROP <> LastROP then
    Begin
      DrillSim.ROPValue.Caption:=FloatToStr(Round2(ROP/UoMConverter[1],2)); { API -> displayed }
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
    DrillSim.TimeValue.Caption:=TempString; { API -> displayed }
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
    Begin                                   { if at top then on slips           }
      if ShutIn then i:=6 else i:=1;        { and if shut in too then...shut in }
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
  StatusCounter:=StatusCounter + 1;
  if StatusCounter>10 then               { check every 10 loops }
  Begin
    StatusUpdate;
    StatusCounter:=Zero;
  End;
  if Data.RPM > Zero then TurnBushing;

  TimeUpdate;
  MudUpdate;
  FlowUpdate;
  if Data.ShutIn then ShutInUpdate else DrillUpdate;
End;

Begin
End.