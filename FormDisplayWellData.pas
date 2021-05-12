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
    CasingIDValue: TLabel;
    FormationText: TStaticText;
    FormationText1: TStaticText;
    FormationText10: TStaticText;
    FormationText11: TStaticText;
    FormationText12: TStaticText;
    FormationText13: TStaticText;
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
    Jet2Label: TStaticText;
    Jet2: TLabel;
    Jet3Label: TStaticText;
    Jet4Label: TStaticText;
    JetUoMLabel: TStaticText;
    Jet3: TLabel;
    Jet4: TLabel;
    NumberOfJets: TLabel;
    BitNumber: TLabel;
    NumberOfJetsLabel: TStaticText;
    Jet1Label: TStaticText;
    BitNumberLabel: TStaticText;
    BitTypeLabel: TStaticText;
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
    OpenHoleSection2IDValue: TLabel;
    OpenHoleSection1TDValue: TLabel;
    NumberOfPipeSections: TStaticText;
    NumOpenHoleSectionsValue: TLabel;
    LinerIDValue: TLabel;
    LinerTopTDValue: TLabel;
    LinerBottomTDValue: TLabel;
    LinerYNValue: TLabel;
    KillLineIDUoMLabel: TLabel;
    KillLineIDValue: TLabel;
    KillLineID: TStaticText;
    ChokeLineIDValue: TLabel;
    CasingTDValue: TLabel;
    CasingYNValue: TLabel;
    NumPipeSectionsValue: TLabel;
    OpenHoleSection1IDValue: TLabel;
    OpenHoleSection3IDValue: TLabel;
    OpenHoleSection2TDValue: TLabel;
    Jet1: TLabel;
    Horizon1Hardness: TLabel;
    Horizon1Pressure: TLabel;
    Horizon1Top: TLabel;
    FormationTopUoMLabel: TLabel;
    FormationHardnessUoMLabel: TLabel;
    FormationPressureUoMLabel: TLabel;
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
    PipeSection2ODValue: TLabel;
    PipeSection3ODValue: TLabel;
    PipeWtUoMLabel: TLabel;
    PipeSection1WtValue: TLabel;
    PipeSection1Wt: TStaticText;
    PipeODUoMLabel: TLabel;
    PipeSection1ODValue: TLabel;
    PipeSection1OD: TStaticText;
    PipeSection1IDValue: TLabel;
    OpenHoleSection3TDValue: TLabel;
    PipeSection2WtValue: TLabel;
    PipeSection2IDValue: TLabel;
    PipeSection1TDValue: TLabel;
    PipeSection1ID: TStaticText;
    PipeIDUoMLabel: TLabel;
    PipeSection1TD: TStaticText;
    PipeTDUoMLabel: TLabel;
    PipeSection3WtValue: TLabel;
    PipeSection3IDValue: TLabel;
    PipeSection2TDValue: TLabel;
    TD: TStaticText;
    PipeSection2TD: TStaticText;
    PipeSection3TDValue: TLabel;
    PipeSection3TD: TStaticText;


    WellOperator: TStaticText;
    WellOperatorValue: TLabel;

    WellName: TStaticText;
    WellNameValue: TLabel;

    ElevationRKB: TStaticText;
    ElevationRKBValue: TLabel;
    ElevationRKBUoMLabel: TLabel;

    OffshoreYN: TStaticText;
    OffshoreYNValue: TLabel;

    SubSeaWellHeadYN: TStaticText;
    SubSeaWellHeadYNValue: TLabel;

    WaterDepth: TStaticText;
    WaterDepthValue: TLabel;
    WaterDepthUoMLabel: TLabel;

    RiserID: TStaticText;
    RiserIDValue: TLabel;
    RiserIDUoMLabel: TLabel;

    RiserTD: TStaticText;
    RiserTDValue: TLabel;
    RiserTDUoMLabel: TLabel;

    CasingYN: TStaticText;
    CasingID: TStaticText;
    CasingIDUoMLabel: TLabel;
    CasingTD: TStaticText;
    CasingTDUoMLabel: TLabel;

    NumberOfOpenHoleSections: TStaticText;
    OpenHoleSection1ID: TStaticText;
    OpenHoleSection1IDUoMLabel: TLabel;
    OpenHoleSection1TD: TStaticText;
    OpenHoleSection1TDUoMLabel: TLabel;

    OpenHoleSectionTD: TStaticText;
    OpenHoleSection2TD: TStaticText;

    OpenHoleSection3TD: TStaticText;

    LinerYN: TStaticText;
    LinerID: TStaticText;
    LinerIDUoMLabel: TLabel;
    LinerShoeTD: TStaticText;
    LinerBottomTDUoMLabel: TLabel;
    LinerHangerTD: TStaticText;
    LinerTopTDUoMLabel: TLabel;          {refactor to TDUoMLabel }

    ChokeLineID: TStaticText;
    ChokeLineIDUoMLabel: TLabel;

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

  WellOperatorValue.Caption:=Data.WellOperator;
  WellNameValue.Caption:=Data.WellName;

 // API->user depth
  ElevationRKBValue.Caption:=FloatToStr(Round2(Data.ElevationRKB*UoMConverter[1],2));
  ElevationRKBUoMLabel.Caption:=UoMLabel[1];  { user depth }

  OffshoreYNValue.Caption:=BoolToStr(Data.Offshore);

  if Data.Offshore then
  begin
    OffshoreYNValue.Caption:='Y';
    // API->user depth
    WaterDepthValue.Caption:=FloatToStr(Round2(Data.WaterDepth*UoMConverter[1],2));
    WaterDepthUoMLabel.Caption:=UoMLabel[1];    { user depth }

    if Data.SubSeaWellHead then
      begin
        SubSeaWellHeadYNValue.Caption:='Y';
        RiserIDValue.Caption:=FloatToStr(Round2(Data.RiserID*UoMConverter[8],4));
        RiserIDUoMLabel.Caption:=UoMLabel[8];       { always inches }
        // API->user depth
        RiserTDValue.Caption:=FloatToStr(Round2(Data.RiserTD*UoMConverter[1],2));
        RiserTDUoMLabel.Caption:=UoMLabel[1];       { user depth }
      end else
      begin
        SubSeaWellHeadYNValue.Caption:='N';
        RiserIDValue.Caption:='N/A';
        RiserIDUoMLabel.Caption:='-';
        RiserTDValue.Caption:='N/A';
        RiserTDUoMLabel.Caption:='-';
      end;
  end
  else
  begin
    OffshoreYNValue.Caption:='N';
    WaterDepthValue.Caption:='N/A';
    WaterDepthUoMLabel.Caption:='-';
  end;

  ChokeLineIDValue.Caption:=FloatToStr(Round2(Data.ChokeLineID*UoMConverter[8],4));
  ChokeLineIDUoMLabel.Caption:=UoMLabel[8];       { always inches }
  // API->user depth
  KillLineIDValue.Caption:=FloatToStr(Round2(Data.KillLineID*UoMConverter[8],4));
  KillLineIDUoMLabel.Caption:=UoMLabel[8];       { always inches }

  CasingYNValue.Caption:='N';
  CasingTDValue.Caption:='N/A';
  CasingTDUoMLabel.Caption:='-';    { user depth }
  CasingIDValue.Caption:='N/A';
  CasingIDUoMLabel.Caption:='-';       { always inches }

  LinerYNValue.Caption:='N';
  LinerTopTDValue.Caption:='N/A';
  LinerBottomTDUoMLabel.Caption:='-';    { user depth }
  LinerBottomTDValue.Caption:='N/A';
  LinerTopTDUoMLabel.Caption:='-';    { user depth }
  LinerIDValue.Caption:='N/A';
  LinerIDUoMLabel.Caption:='-';       { always inches }

  if Data.Casing then
  begin
    CasingYNValue.Caption:='Y';
    CasingTDValue.Caption:=FloatToStr(Round2(Data.CasingTD*UoMConverter[1],2));
    CasingTDUoMLabel.Caption:=UoMLabel[1];    { user depth }
    CasingIDValue.Caption:=FloatToStr(Round2(Data.KillLineID*UoMConverter[8],4));
    CasingIDUoMLabel.Caption:=UoMLabel[8];       { always inches }
    if Data.Liner then
    begin
      LinerYNValue.Caption:='Y';
      LinerTopTDValue.Caption:=FloatToStr(Round2(Data.LinerTopTD*UoMConverter[1],2));
      LinerTopTDUoMLabel.Caption:=UoMLabel[1];    { user depth }
      LinerBottomTDValue.Caption:=FloatToStr(Round2(Data.LinerBottomTD*UoMConverter[1],2));
      LinerBottomTDUoMLabel.Caption:=UoMLabel[1];    { user depth }
      LinerIDValue.Caption:=FloatToStr(Round2(Data.LinerID*UoMConverter[8],4));
      LinerIDUoMLabel.Caption:=UoMLabel[8];       { always inches }
    end;
  end;

  NumOpenHoleSectionsValue.Caption:=IntToStr(Data.MaxHoles);

  OpenHoleSection1TDValue.Caption:='N/A';
  OpenHoleSection1TDUoMLabel.Caption:='-';
  OpenHoleSection1IDValue.Caption:='N/A';
  OpenHoleSection1IDUoMLabel.Caption:='-';

  OpenHoleSection2TDValue.Caption:='N/A';
  OpenHoleSection2IDValue.Caption:='N/A';

  OpenHoleSection3TDValue.Caption:='N/A';
  OpenHoleSection3IDValue.Caption:='N/A';

  if Data.MaxHoles > 0 then
  begin
    // do hole 1
    OpenHoleSection1TDValue.Caption:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));
    OpenHoleSection1TDUoMLabel.Caption:=UoMLabel[1];    { user depth }
    OpenHoleSection1IDValue.Caption:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],4));
    OpenHoleSection1IDUoMLabel.Caption:=UoMLabel[8];       { always inches }

    if Data.MaxHoles > 1 then
    begin
      // do hole 2
      OpenHoleSection2TDValue.Caption:=FloatToStr(Round2(Data.Hole[2,1]*UoMConverter[1],2));
      OpenHoleSection2IDValue.Caption:=FloatToStr(Round2(Data.Hole[2,2]*UoMConverter[8],4));
      if Data.MaxHoles > 2 then
      begin
        // do hole 3
        OpenHoleSection3TDValue.Caption:=FloatToStr(Round2(Data.Hole[3,1]*UoMConverter[1],2));
        OpenHoleSection3IDValue.Caption:=FloatToStr(Round2(Data.Hole[3,2]*UoMConverter[8],4));
      end
    end;
  end else
  begin
    // no hole defined!
  end;

  NumPipeSectionsValue.Caption:=IntToStr(Data.MaxPipes);

  PipeSection1TDValue.Caption:='N/A';
  PipeTDUoMLabel.Caption:='-';
  PipeSection1IDValue.Caption:='N/A';
  PipeIDUoMLabel.Caption:='-';
  PipeSection1ODValue.Caption:='N/A';
  PipeODUoMLabel.Caption:='-';
  PipeSection1WtValue.Caption:='N/A';
  PipeWtUoMLabel.Caption:='-';

  PipeSection2TDValue.Caption:='N/A';
  PipeSection2IDValue.Caption:='N/A';
  PipeSection2ODValue.Caption:='N/A';
  PipeSection2WtValue.Caption:='N/A';

  PipeSection3TDValue.Caption:='N/A';
  PipeSection3IDValue.Caption:='N/A';
  PipeSection3ODValue.Caption:='N/A';
  PipeSection3WtValue.Caption:='N/A';

  if Data.MaxPipes > 0 then
  begin
    // do pipe 1
    PipeSection1TDValue.Caption:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));
    PipeTDUoMLabel.Caption:=UoMLabel[1];    { user depth }
    PipeSection1IDValue.Caption:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));
    PipeIDUoMLabel.Caption:=UoMLabel[8];       { always inches }
    PipeSection1ODValue.Caption:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));
    PipeODUoMLabel.Caption:=UoMLabel[8];       { always inches }
    PipeSection1WtValue.Caption:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }
    PipeWtUoMLabel.Caption:='lbs/ft';       { always lbs/ft }

    if Data.MaxPipes > 1 then
    begin
      // do pipe 2
      PipeSection2TDValue.Caption:=FloatToStr(Round2(Data.Pipe[2,1]*UoMConverter[1],2));
      PipeSection2IDValue.Caption:=FloatToStr(Round2(Data.Pipe[2,2]*UoMConverter[8],4));
      PipeSection2ODValue.Caption:=FloatToStr(Round2(Data.Pipe[2,3]*UoMConverter[8],4));
      PipeSection2WtValue.Caption:=FloatToStr(Round2(Data.Pipe[2,4],2));  { lbs per foot }

      if Data.MaxPipes > 2 then
      begin
        // do pipe 3
        PipeSection3TDValue.Caption:=FloatToStr(Round2(Data.Pipe[3,1]*UoMConverter[1],2));
        PipeSection3IDValue.Caption:=FloatToStr(Round2(Data.Pipe[3,2]*UoMConverter[8],4));
        PipeSection3ODValue.Caption:=FloatToStr(Round2(Data.Pipe[3,3]*UoMConverter[8],4));
        PipeSection3WtValue.Caption:=FloatToStr(Round2(Data.Pipe[3,4],2));  { lbs per foot }
      end;
    end;
  end else
  begin
    // no pipe defined!
  end;



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

  FormationTopUoMLabel.Caption:=UoMLabel[1];    { user depth }
  FormationHardnessUoMLabel.Caption:='0-1';
  FormationPressureUoMLabel.Caption:=UoMLabel[3];    { pressure }

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

  { 1..3,1..5 PumpOutputText, efficiency, @strokes, slow pump spm, slow pump flow rate gpm }
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




  // UoM, TD etc?

end;



end.

