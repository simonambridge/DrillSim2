unit FormDisplayWellData;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  FileUtil,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  DrillSimVariables,
  DrillSimMessageToMemo,
  DrillSimUtilities;

type

  { TDisplayWellDataForm }

  TDisplayWellDataForm = class(TForm)
    Button1: TButton;
    BitTDUoM: TLabel;
    StandpipeID: TLabel;
    StandpipeLength: TLabel;
    StandpipeText: TStaticText;
    SurfaceEquipmentPanel: TPanel;
    SurfaceEquipmentText: TStaticText;
    KellyID: TLabel;
    KellyLength: TLabel;
    KellyText: TStaticText;
    SwivelID: TLabel;
    SwivelLength: TLabel;
    SwivelText: TStaticText;
    HoseID: TLabel;
    HoseLength: TLabel;
    HoseText: TStaticText;
    SEIDText: TStaticText;
    SEIDUoM: TLabel;
    SELengthText: TStaticText;
    SELengthUoM: TLabel;
    ReturnPitVolumeText: TStaticText;
    CasingID: TLabel;
    BitTDText: TStaticText;
    BitTD: TLabel;
    MudYP: TLabel;
    MudYPText: TStaticText;
    MudYPUoM: TLabel;
    MudPV: TLabel;
    MudPVText: TStaticText;
    MudPVUoM: TLabel;
    MudGel: TLabel;
    MudGelText: TStaticText;
    MudGelUoM: TLabel;
    ReturnPitUoM: TLabel;
    MudWt: TLabel;
    MudWText: TStaticText;
    MudWtUoM: TLabel;
    CurrentTDUoM: TLabel;
    ReturnPitVolume: TLabel;
    MudPanel: TPanel;
    TestTitleText: TStaticText;
    LeakOffMWText: TStaticText;
    BitTitleText: TStaticText;
    CasingBurstPressure: TLabel;
    CasingBurstPressureText: TStaticText;
    CasingBurstPressureUoM: TLabel;
    LeakOffTDUoM: TLabel;
    LeakOffTD: TLabel;
    FormationTitleText: TStaticText;
    FormationText1: TStaticText;
    FormationText10: TStaticText;
    TopDepthText: TStaticText;
    HardnessText: TStaticText;
    FormationPressureText: TStaticText;
    FormationText2: TStaticText;
    FormationText3: TStaticText;
    FormationText4: TStaticText;
    FormationText5: TStaticText;
    FormationText6: TStaticText;
    FormationText7: TStaticText;
    FormationText8: TStaticText;
    FormationText9: TStaticText;
    Horizon2Hardness: TLabel;
    Horizon3Hardness: TLabel;
    Horizon4Hardness: TLabel;
    Horizon5Hardness: TLabel;
    Horizon6Hardness: TLabel;
    Horizon7Hardness: TLabel;
    Horizon8Hardness: TLabel;
    Horizon9Hardness: TLabel;
    Horizon10Hardness: TLabel;
    Horizon2Pressure: TLabel;
    Horizon3Pressure: TLabel;
    Horizon4Pressure: TLabel;
    Horizon5Pressure: TLabel;
    Horizon6Pressure: TLabel;
    Horizon7Pressure: TLabel;
    Horizon8Pressure: TLabel;
    Horizon9Pressure: TLabel;
    Horizon10Pressure: TLabel;
    Horizon2Top: TLabel;
    Horizon3Top: TLabel;
    Horizon4Top: TLabel;
    Horizon5Top: TLabel;
    Horizon6Top: TLabel;
    Horizon7Top: TLabel;
    Horizon8Top: TLabel;
    Horizon9Top: TLabel;
    Horizon10Top: TLabel;
    Jet2Text: TStaticText;
    Jet2: TLabel;
    Jet3Text: TStaticText;
    Jet4Text: TStaticText;
    JetUoM: TStaticText;
    Jet3: TLabel;
    Jet4: TLabel;
    TVDUoM: TLabel;
    LeakOffEMWUoM: TLabel;
    MudTitleText: TStaticText;
    TVD: TLabel;
    DevText: TStaticText;
    LeakOffEMW: TLabel;
    LeakOffPressureUoM: TLabel;
    LeakOffPressure: TLabel;
    LeakOffMWUoM: TLabel;
    LeakOffMW: TLabel;
    LeakOffTDText: TStaticText;
    LeakOffEMWText: TStaticText;
    MeasurementUnitsText: TStaticText;
    MeasurementUnits: TLabel;
    DetailPanel: TPanel;
    CurrentTD: TLabel;
    TVDText: TStaticText;
    DeviationUoM: TLabel;
    DeviationDeg: TLabel;
    CurrentTDText: TStaticText;
    NumberOfJets: TLabel;
    BitNumber: TLabel;
    NumberOfJetsLabel: TStaticText;
    Jet1Text: TStaticText;
    BitNumberLabel: TStaticText;
    BitTypeText: TStaticText;
    NumberOfPumps: TStaticText;
    MaxPumpPressureText: TStaticText;
    NumPumps: TLabel;
    MaxPumpPressure: TLabel;
    PumpEffText: TStaticText;
    PumpOutputUoM: TLabel;
    PumpEfficiency2: TLabel;
    PumpEfficiency3: TLabel;
    PumpOutputText: TStaticText;
    PumpOutput1: TLabel;
    PumpOutput2: TLabel;
    PumpOutput3: TLabel;
    PumpEfficiency1: TLabel;
    Pump1: TStaticText;
    OpenHoleSection2ID: TLabel;
    OpenHoleSection1TD: TLabel;
    NumberOfPipeSections: TStaticText;
    NumOpenHoleSections: TLabel;
    LinerID: TLabel;
    LinerTopTD: TLabel;
    LinerBottomTD: TLabel;
    LinerYN: TLabel;
    KillLineIDUoM: TLabel;
    KillLineID: TLabel;
    KillLineIDText: TStaticText;
    ChokeLineID: TLabel;
    CasingTD: TLabel;
    CasingYN: TLabel;
    NumPipeSections: TLabel;
    OpenHoleSection1ID: TLabel;
    OpenHoleSection3ID: TLabel;
    OpenHoleSection2TD: TLabel;
    Jet1: TLabel;
    Horizon1Hardness: TLabel;
    Horizon1Pressure: TLabel;
    Horizon1Top: TLabel;
    FormationTopUoM: TLabel;
    FormationHardnessUoM: TLabel;
    FormationPressureUoM: TLabel;
    Pump2: TStaticText;
    Pump3: TStaticText;
    PumpEffUoM: TLabel;
    MaxPumpPressureUoM: TLabel;
    TitlePanel: TPanel;
    FormationPanel: TPanel;
    PumpsPanel: TPanel;
    BitPanel: TPanel;
    ElevationsPanel: TPanel;
    RiserPanel: TPanel;
    ChokeKillPanel: TPanel;
    CasingPanel: TPanel;
    LinerPanel: TPanel;
    HolePanel: TPanel;
    PipePanel: TPanel;
    TestsPanel: TPanel;
    PipeSection2OD: TLabel;
    PipeSection3OD: TLabel;
    PipeWtUoM: TLabel;
    PipeSection1Wt: TLabel;
    PipeSection1WtText: TStaticText;
    PipeODUoM: TLabel;
    PipeSection1OD: TLabel;
    PipeSection1ODText: TStaticText;
    PipeSection1ID: TLabel;
    OpenHoleSection3TD: TLabel;
    PipeSection2Wt: TLabel;
    PipeSection2ID: TLabel;
    PipeSection1TD: TLabel;
    PipeSection1IDText: TStaticText;
    PipeIDUoM: TLabel;
    PipeSection1TDText: TStaticText;
    PipeTDUoM: TLabel;
    PipeSection3Wt: TLabel;
    PipeSection3ID: TLabel;
    PipeSection2TD: TLabel;
    TD: TStaticText;
    PipeSection2TDText: TStaticText;
    PipeSection3TD: TLabel;
    PipeSection3TDText: TStaticText;
    LeakOffPressureText: TStaticText;


    WellOperatorText: TStaticText;
    WellOperator: TLabel;

    WellNameText: TStaticText;
    WellName: TLabel;

    ElevationRKBText: TStaticText;
    ElevationRKB: TLabel;
    ElevationRKBUoM: TLabel;

    OffshoreYNText: TStaticText;
    OffshoreYN: TLabel;

    SubSeaWellHeadYNText: TStaticText;
    SubSeaWellHeadYN: TLabel;

    WaterDepthText: TStaticText;
    WaterDepth: TLabel;
    WaterDepthUoM: TLabel;

    RiserIDText: TStaticText;
    RiserID: TLabel;
    RiserIDUoM: TLabel;

    RiserTDText: TStaticText;
    RiserTD: TLabel;
    RiserTDUoM: TLabel;

    CasingYNText: TStaticText;
    CasingIDText: TStaticText;
    CasingIDUoM: TLabel;
    CasingTDText: TStaticText;
    CasingTDUoM: TLabel;

    NumberOfOpenHoleSections: TStaticText;
    OpenHoleSectionIDText: TStaticText;
    OpenHoleSectionIDUoM: TLabel;
    OpenHoleSection1Text: TStaticText;
    OpenHoleSectionTDUoM: TLabel;

    OpenHoleSectionTDText: TStaticText;
    OpenHoleSection2Text: TStaticText;

    OpenHoleSection3Terxt: TStaticText;

    LinerYNText: TStaticText;
    LinerIDText: TStaticText;
    LinerIDUoM: TLabel;
    LinerShoeTDText: TStaticText;
    LinerBottomTDUoM: TLabel;
    LinerHangerTDText: TStaticText;
    LinerTopTDUoM: TLabel;          {refactor to CurrentTDUoM }

    ChokeLineIDText: TStaticText;
    ChokeLineIDUoM: TLabel;

    CloseDisplayWellData: TButton;
    BitType: TLabel;

    procedure FormActivate(Sender: TObject);
    Procedure OnClose(Sender: TObject);
    procedure CloseDisplayWellDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCreateActions;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DisplayWellDataForm: TDisplayWellDataForm;

implementation

//Uses DrillSimGUI;

{ TDisplayWellDataForm }

{$R *.lfm}

{ ------------- Form Procedures ------------ }

Procedure TDisplayWellDataForm.FormCreateActions;
Begin
 { nothing to see here }
end;

procedure TDisplayWellDataForm.FormCreate(Sender: TObject);
begin
  FormCreateActions;
  StringToMemo('FormDisplayWellData : TDisplayWellDataForm.FormCreate');
end;

procedure TDisplayWellDataForm.CloseDisplayWellDataClick(Sender: TObject);
begin
  Close;
end;

Procedure TDisplayWellDataForm.OnClose(Sender: TObject);
begin
 Close;
end;

procedure TDisplayWellDataForm.FormActivate(Sender: TObject);
begin

  StringToMemo('Form Well Data Summary activated....');

  WellOperator.Caption:=Data.WellOperator;
  WellName.Caption:=Data.WellName;
  if Data.API then MeasurementUnits.Caption:='API'
              else MeasurementUnits.Caption:='Metric';

 // API->user depth
  ElevationRKB.Caption:=FloatToStr(Round2(Data.ElevationRKB*UoMConverter[1],2));
  ElevationRKBUoM.Caption:=UoMLabel[1];  { user depth }

  OffshoreYN.Caption:=BoolToStr(Data.Offshore);

  if Data.Offshore then
  begin
    OffshoreYN.Caption:='Y';
    // API->user depth
    WaterDepth.Caption:=FloatToStr(Round2(Data.WaterDepth*UoMConverter[1],2));
    WaterDepthUoM.Caption:=UoMLabel[1];    { user depth }

    if Data.SubSeaWellHead then
      begin
        SubSeaWellHeadYN.Caption:='Y';
        RiserID.Caption:=FloatToStr(Round2(Data.RiserID*UoMConverter[8],4));
        RiserIDUoM.Caption:=UoMLabel[8];       { always inches }
        // API->user depth
        RiserTD.Caption:=FloatToStr(Round2(Data.RiserTD*UoMConverter[1],2));
        RiserTDUoM.Caption:=UoMLabel[1];       { user depth }
      end else
      begin
        SubSeaWellHeadYN.Caption:='N';
        RiserID.Caption:='N/A';
        RiserIDUoM.Caption:='-';
        RiserTD.Caption:='N/A';
        RiserTDUoM.Caption:='-';
      end;
  end
  else
  begin
    OffshoreYN.Caption:='N';
    WaterDepth.Caption:='N/A';
    WaterDepthUoM.Caption:='-';
  end;

  // Choke & kill
  ChokeLineID.Caption:=FloatToStr(Round2(Data.ChokeLineID*UoMConverter[8],4));
  ChokeLineIDUoM.Caption:=UoMLabel[8];       { always inches }
  // API->user depth
  KillLineID.Caption:=FloatToStr(Round2(Data.KillLineID*UoMConverter[8],4));
  KillLineIDUoM.Caption:=UoMLabel[8];       { always inches }

  // Casing & Liner
  CasingYN.Caption:='N';
  CasingTD.Caption:='N/A';
  CasingTDUoM.Caption:='-';    { user depth }
  CasingID.Caption:='N/A';
  CasingIDUoM.Caption:='-';       { always inches }

  LinerYN.Caption:='N';
  LinerTopTD.Caption:='N/A';
  LinerBottomTDUoM.Caption:='-';    { user depth }
  LinerBottomTD.Caption:='N/A';
  LinerTopTDUoM.Caption:='-';    { user depth }
  LinerID.Caption:='N/A';
  LinerIDUoM.Caption:='-';       { always inches }

  if Data.Casing then
  begin
    CasingYN.Caption:='Y';
    CasingTD.Caption:=FloatToStr(Round2(Data.CasingTD*UoMConverter[1],2));
    CasingTDUoM.Caption:=UoMLabel[1];    { user depth }
    CasingID.Caption:=FloatToStr(Round2(Data.KillLineID*UoMConverter[8],4));
    CasingIDUoM.Caption:=UoMLabel[8];       { always inches }
    if Data.Liner then
    begin
      LinerYN.Caption:='Y';
      LinerTopTD.Caption:=FloatToStr(Round2(Data.LinerTopTD*UoMConverter[1],2));
      LinerTopTDUoM.Caption:=UoMLabel[1];    { user depth }
      LinerBottomTD.Caption:=FloatToStr(Round2(Data.LinerBottomTD*UoMConverter[1],2));
      LinerBottomTDUoM.Caption:=UoMLabel[1];    { user depth }
      LinerID.Caption:=FloatToStr(Round2(Data.LinerID*UoMConverter[8],4));
      LinerIDUoM.Caption:=UoMLabel[8];       { always inches }
    end;
  end;

  // Hole
  NumOpenHoleSections.Caption:=IntToStr(Data.MaxHoles);

  OpenHoleSection1TD.Caption:='N/A';
  OpenHoleSectionTDUoM.Caption:='-';
  OpenHoleSection1ID.Caption:='N/A';
  OpenHoleSectionIDUoM.Caption:='-';

  OpenHoleSection2TD.Caption:='N/A';
  OpenHoleSection2ID.Caption:='N/A';

  OpenHoleSection3TD.Caption:='N/A';
  OpenHoleSection3ID.Caption:='N/A';

  if Data.MaxHoles > 0 then
  begin
    // do hole 1
    OpenHoleSection1TD.Caption:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));
    OpenHoleSectionTDUoM.Caption:=UoMLabel[1];    { user depth }
    OpenHoleSection1ID.Caption:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],4));
    OpenHoleSectionIDUoM.Caption:=UoMLabel[8];       { always inches }

    if Data.MaxHoles > 1 then
    begin
      // do hole 2
      OpenHoleSection2TD.Caption:=FloatToStr(Round2(Data.Hole[2,1]*UoMConverter[1],2));
      OpenHoleSection2ID.Caption:=FloatToStr(Round2(Data.Hole[2,2]*UoMConverter[8],4));
      if Data.MaxHoles > 2 then
      begin
        // do hole 3
        OpenHoleSection3TD.Caption:=FloatToStr(Round2(Data.Hole[3,1]*UoMConverter[1],2));
        OpenHoleSection3ID.Caption:=FloatToStr(Round2(Data.Hole[3,2]*UoMConverter[8],4));
      end
    end;
  end else
  begin
    // no hole defined!
  end;

  // Pipe
  NumPipeSections.Caption:=IntToStr(Data.MaxPipes);

  PipeSection1TD.Caption:='N/A';
  PipeTDUoM.Caption:='-';
  PipeSection1ID.Caption:='N/A';
  PipeIDUoM.Caption:='-';
  PipeSection1OD.Caption:='N/A';
  PipeODUoM.Caption:='-';
  PipeSection1Wt.Caption:='N/A';
  PipeWtUoM.Caption:='-';

  PipeSection2TD.Caption:='N/A';
  PipeSection2ID.Caption:='N/A';
  PipeSection2OD.Caption:='N/A';
  PipeSection2Wt.Caption:='N/A';

  PipeSection3TD.Caption:='N/A';
  PipeSection3ID.Caption:='N/A';
  PipeSection3OD.Caption:='N/A';
  PipeSection3Wt.Caption:='N/A';

  if Data.MaxPipes > 0 then
  begin
    // do pipe 1
    PipeSection1TD.Caption:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));
    PipeTDUoM.Caption:=UoMLabel[1];    { user depth }
    PipeSection1ID.Caption:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));
    PipeIDUoM.Caption:=UoMLabel[8];       { always inches }
    PipeSection1OD.Caption:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));
    PipeODUoM.Caption:=UoMLabel[8];       { always inches }
    PipeSection1Wt.Caption:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }
    PipeWtUoM.Caption:='lbs/ft';       { always lbs/ft }

    if Data.MaxPipes > 1 then
    begin
      // do pipe 2
      PipeSection2TD.Caption:=FloatToStr(Round2(Data.Pipe[2,1]*UoMConverter[1],2));
      PipeSection2ID.Caption:=FloatToStr(Round2(Data.Pipe[2,2]*UoMConverter[8],4));
      PipeSection2OD.Caption:=FloatToStr(Round2(Data.Pipe[2,3]*UoMConverter[8],4));
      PipeSection2Wt.Caption:=FloatToStr(Round2(Data.Pipe[2,4],2));  { lbs per foot }

      if Data.MaxPipes > 2 then
      begin
        // do pipe 3
        PipeSection3TD.Caption:=FloatToStr(Round2(Data.Pipe[3,1]*UoMConverter[1],2));
        PipeSection3ID.Caption:=FloatToStr(Round2(Data.Pipe[3,2]*UoMConverter[8],4));
        PipeSection3OD.Caption:=FloatToStr(Round2(Data.Pipe[3,3]*UoMConverter[8],4));
        PipeSection3Wt.Caption:=FloatToStr(Round2(Data.Pipe[3,4],2));  { lbs per foot }
      end;
    end;
  end else
  begin
    // no pipe defined!
  end;

  // bit
  BitNumber.Caption:=IntToStr(Data.BitNumber);
  BitType.Caption:=Data.BitType;
  NumberofJets.Caption:=IntToStr(Data.MaxJets);
  if Data.MaxJets > 0 then
  begin
    Jet1.Caption:=FloatToStr(Round2(Data.Jet[1],2));
    if Data.MaxJets > 1 then
    begin
      Jet2.Caption:=FloatToStr(Round2(Data.Jet[2],2));
      if Data.MaxJets > 2 then
      begin
        Jet3.Caption:=FloatToStr(Round2(Data.Jet[3],2));
        if Data.MaxJets > 3 then
        begin
          Jet4.Caption:=FloatToStr(Round2(Data.Jet[4],2));
        end;
      end;
    end;
  end;

  // Formation & geology
  FormationTopUoM.Caption:=UoMLabel[1];    { user depth }
  FormationHardnessUoM.Caption:='0-1';
  FormationPressureUoM.Caption:=UoMLabel[3];    { pressure }

  Horizon1Top.Caption:=FloatToStr(Round2(Data.Formation[1].Depth*UoMConverter[1],2));       {depth }
  Horizon1Hardness.Caption:=FloatToStr(Round2(Data.Formation[1].Hardness,2));
  Horizon1Pressure.Caption:=FloatToStr(Round2(Data.Formation[1].FP*UoMConverter[3],2));  {pressure}
  Horizon2Top.Caption:=FloatToStr(Round2(Data.Formation[2].Depth*UoMConverter[1],2));       {depth }
  Horizon2Hardness.Caption:=FloatToStr(Round2(Data.Formation[2].Hardness,2));
  Horizon2Pressure.Caption:=FloatToStr(Round2(Data.Formation[2].FP*UoMConverter[3],2));  {pressure}
  Horizon3Top.Caption:=FloatToStr(Round2(Data.Formation[3].Depth*UoMConverter[1],2));       {depth }
  Horizon3Hardness.Caption:=FloatToStr(Round2(Data.Formation[3].Hardness,2));
  Horizon3Pressure.Caption:=FloatToStr(Round2(Data.Formation[3].FP*UoMConverter[3],2));  {pressure}
  Horizon4Top.Caption:=FloatToStr(Round2(Data.Formation[4].Depth*UoMConverter[1],2));       {depth }
  Horizon4Hardness.Caption:=FloatToStr(Round2(Data.Formation[4].Hardness,2));
  Horizon4Pressure.Caption:=FloatToStr(Round2(Data.Formation[4].FP*UoMConverter[3],2));  {pressure}
  Horizon5Top.Caption:=FloatToStr(Round2(Data.Formation[5].Depth*UoMConverter[1],2));       {depth }
  Horizon5Hardness.Caption:=FloatToStr(Round2(Data.Formation[5].Hardness,2));
  Horizon5Pressure.Caption:=FloatToStr(Round2(Data.Formation[5].FP*UoMConverter[3],2));  {pressure}
  Horizon6Top.Caption:=FloatToStr(Round2(Data.Formation[6].Depth*UoMConverter[1],2));       {depth }
  Horizon6Hardness.Caption:=FloatToStr(Round2(Data.Formation[6].Hardness,2));
  Horizon6Pressure.Caption:=FloatToStr(Round2(Data.Formation[6].FP*UoMConverter[3],2));  {pressure}
  Horizon7Top.Caption:=FloatToStr(Round2(Data.Formation[7].Depth*UoMConverter[1],2));       {depth }
  Horizon7Hardness.Caption:=FloatToStr(Round2(Data.Formation[7].Hardness,2));
  Horizon7Pressure.Caption:=FloatToStr(Round2(Data.Formation[7].FP*UoMConverter[3],2));  {pressure}
  Horizon8Top.Caption:=FloatToStr(Round2(Data.Formation[8].Depth*UoMConverter[1],2));       {depth }
  Horizon8Hardness.Caption:=FloatToStr(Round2(Data.Formation[8].Hardness,2));
  Horizon8Pressure.Caption:=FloatToStr(Round2(Data.Formation[8].FP*UoMConverter[3],2));  {pressure}
  Horizon9Top.Caption:=FloatToStr(Round2(Data.Formation[9].Depth*UoMConverter[1],2));       {depth }
  Horizon9Hardness.Caption:=FloatToStr(Round2(Data.Formation[9].Hardness,2));
  Horizon9Pressure.Caption:=FloatToStr(Round2(Data.Formation[9].FP*UoMConverter[3],2));  {pressure}
  Horizon10Top.Caption:=FloatToStr(Round2(Data.Formation[10].Depth*UoMConverter[1],2));       {depth }
  Horizon10Hardness.Caption:=FloatToStr(Round2(Data.Formation[10].Hardness,2));
  Horizon10Pressure.Caption:=FloatToStr(Round2(Data.Formation[10].FP*UoMConverter[3],2));  {pressure}

  // Pumps
  { Pump 1..3,1..5 PumpOutputText, efficiency, @strokes, slow pump spm, slow pump flow rate gpm }
  PumpOutputUoM.Caption:=UoMLabel[5];    { gal/litre}
  MaxPumpPressureUoM.Caption:=UoMLabel[3];    { psi/kpa}

  NumPumps.Caption:=IntToStr(Data.MaxPumps);

  PumpOutput1.Caption:=FloatToStr(Round2(Data.Pump[1,1]*UoMConverter[5],2));  { API->user volume }
  PumpEfficiency1.Caption:=FloatToStr(Round2(Data.Pump[1,2],3));  { % }
  PumpOutput2.Caption:=FloatToStr(Round2(Data.Pump[2,1]*UoMConverter[5],2));  { API->user volume }
  PumpEfficiency2.Caption:=FloatToStr(Round2(Data.Pump[2,2],3));  { % }
  PumpOutput3.Caption:=FloatToStr(Round2(Data.Pump[3,1]*UoMConverter[5],2));  { API->user volume }
  PumpEfficiency3.Caption:=FloatToStr(Round2(Data.Pump[3,2],3));  { % }

  MaxPumpPressure.Caption:=FloatToStr(Round2(Data.MaxPumpPressure*UoMConverter[3],2));  { API->user pressure }

  // mud
  MudWtUoM.Caption:=UoMLabel[2]; { mud weight }
  MudWt.Caption:=FloatToStr(Round2(Data.MudWt*UoMConverter[2],3));  { API->user }
  MudYP.Caption:=FloatToStr(Round2(Data.MudYP,3));    { no conversion req'd }
  MudPV.Caption:=FloatToStr(Round2(Data.MudPV,3));    { no conversion req'd }
  MudGel.Caption:=FloatToStr(Round2(Data.MudGel,3));  { no conversion req'd }

  // general eg TD, tvd, dev, uom
  CurrentTDUoM.Caption:=UoMLabel[1];    { user depth }
  BitTDUoM.Caption:=UoMLabel[1];    { user depth }
  TVDUoM.Caption:=UoMLabel[1];    { user depth }
  CurrentTD.Caption:=FloatToStr(Round2(Data.TD/UoMConverter[1],2)); { API -> displayed }
  BitTD.Caption:=FloatToStr(Round2(Data.BitTD/UoMConverter[1],2)); { API -> displayed }
  DeviationDeg.Caption:=FloatToStr(Round2(Data.DeviationDegrees,2));
  TVD.Caption:=FloatToStr(Round2(Data.TVD/UoMConverter[1],2)); { API -> displayed }

  // tests
  LeakOffTDUoM.Caption:=UoMLabel[1];    { user depth }
  LeakOffMWUoM.Caption:=UoMLabel[2];    { user mw }
  LeakOffEMWUoM.Caption:=UoMLabel[2];    { user mw }
  LeakOffPressureUoM.Caption:=UoMLabel[3];    { user pressure }
  CasingBurstPressureUoM.Caption:=UoMLabel[3];    { user pressure }

  LeakOffTD.Caption:=FloatToStr(Round2(Data.LoTTD/UoMConverter[1],2)); { API -> displayed }
  LeakOffMW.Caption:=FloatToStr(Round2(Data.LoTMW*UoMConverter[2],3));  { API->user }
  LeakOffEMW.Caption:=FloatToStr(Round2(Data.LoTEMW*UoMConverter[2],3));  { API->user }
  LeakOffPressure.Caption:=FloatToStr(Round2(Data.LoTPressure*UoMConverter[3],2));  {pressure}
  CasingBurstPressure.Caption:=FloatToStr(Round2(Data.CasingBurstPressure*UoMConverter[3],2));  { API->user pressure }

  // surf eq
  SELengthUoM.Caption:=UoMLabel[1];        { depth }
  SEIDUoM.Caption:=UoMLabel[8];        { inches }

  KellyLength.Caption:=FloatToStr(Round2(Data.Surf[1,1]*UoMConverter[1],2));      { depth }
  KellyID.Caption:=FloatToStr(Data.Surf[1,2]*UoMConverter[8]);                    { inches }
  SwivelLength.Caption:=FloatToStr(Round2(Data.Surf[2,1]*UoMConverter[1],2));     { depth }
  SwivelID.Caption:=FloatToStr(Data.Surf[2,2]*UoMConverter[8]);                   { inches }
  HoseLength.Caption:=FloatToStr(Round2(Data.Surf[3,1]*UoMConverter[1],2));       { depth }
  HoseID.Caption:=FloatToStr(Data.Surf[3,2]*UoMConverter[8]);                     { inches }
  StandPipeLength.Caption:=FloatToStr(Round2(Data.Surf[4,1]*UoMConverter[1],2));  { depth }
  StandPipeID.Caption:=FloatToStr(Data.Surf[4,2]*UoMConverter[8]);                { inches }


end;



end.

