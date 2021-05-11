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
    PipeSection2OD: TStaticText;
    PipeSection3OD: TStaticText;
    PipeSection2ODUoMLabel: TLabel;
    PipeSection3ODUoMLabel: TLabel;
    PipeSection2ODValue: TLabel;
    PipeSection3ODValue: TLabel;
    PipeSection2Wt: TStaticText;
    PipeSection1WtUoMLabel: TLabel;
    PipeSection3Wt: TStaticText;
    PipeSection2WtUoMLabel: TLabel;
    PipeSection1WtValue: TLabel;
    PipeSection1Wt: TStaticText;
    PipeSection1ODUoMLabel: TLabel;
    PipeSection1ODValue: TLabel;
    PipeSection1OD: TStaticText;
    PipeSection1IDValue: TLabel;
    OpenHoleSection3TDValue: TLabel;
    PipeSection3WtUoMLabel: TLabel;
    PipeSection2WtValue: TLabel;
    PipeSection2IDValue: TLabel;
    PipeSection1TDValue: TLabel;
    PipeSection1ID: TStaticText;
    PipeSection1IDUoMLabel: TLabel;
    PipeSection1TD: TStaticText;
    PipeSection1TDUoMLabel: TLabel;
    PipeSection3WtValue: TLabel;
    PipeSection3IDValue: TLabel;
    PipeSection2TDValue: TLabel;
    PipeSection2ID: TStaticText;
    PipeSection2IDUoMLabel: TLabel;
    PipeSection2TD: TStaticText;
    PipeSection2TDUoMLabel: TLabel;
    PipeSection3TDValue: TLabel;
    PipeSection3ID: TStaticText;
    PipeSection3IDUoMLabel: TLabel;
    PipeSection3TD: TStaticText;
    PipeSection3TDUoMLabel: TLabel;


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

    OpenHoleSection2ID: TStaticText;
    OpenHoleSection2IDUoMLabel: TLabel;
    OpenHoleSection2TD: TStaticText;
    OpenHoleSection2TDUoMLabel: TLabel;

    OpenHoleSection3ID: TStaticText;
    OpenHoleSection3IDUoMLabel: TLabel;
    OpenHoleSection3TD: TStaticText;
    OpenHoleSection3TDUoMLabel: TLabel;

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

    procedure KillLineIDClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LinerIDUoMLabelClick(Sender: TObject);
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
  OpenHoleSection2TDUoMLabel.Caption:='-';
  OpenHoleSection2IDValue.Caption:='N/A';
  OpenHoleSection2IDUoMLabel.Caption:='-';

  OpenHoleSection3TDValue.Caption:='N/A';
  OpenHoleSection3TDUoMLabel.Caption:='-';
  OpenHoleSection3IDValue.Caption:='N/A';
  OpenHoleSection3IDUoMLabel.Caption:='-';

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
      OpenHoleSection2TDUoMLabel.Caption:=UoMLabel[1];    { user depth }
      OpenHoleSection2IDValue.Caption:=FloatToStr(Round2(Data.Hole[2,2]*UoMConverter[8],4));
      OpenHoleSection2IDUoMLabel.Caption:=UoMLabel[8];       { always inches }
      if Data.MaxHoles > 2 then
      begin
        // do hole 3
        OpenHoleSection3TDValue.Caption:=FloatToStr(Round2(Data.Hole[3,1]*UoMConverter[1],2));
        OpenHoleSection3TDUoMLabel.Caption:=UoMLabel[1];    { user depth }
        OpenHoleSection3IDValue.Caption:=FloatToStr(Round2(Data.Hole[3,2]*UoMConverter[8],4));
        OpenHoleSection3IDUoMLabel.Caption:=UoMLabel[8];       { always inches }
      end
    end;
  end else
  begin
    // no hole defined!
  end;

  NumPipeSectionsValue.Caption:=IntToStr(Data.MaxPipes);

  PipeSection1TDValue.Caption:='N/A';
  PipeSection1TDUoMLabel.Caption:='-';
  PipeSection1IDValue.Caption:='N/A';
  PipeSection1IDUoMLabel.Caption:='-';
  PipeSection1ODValue.Caption:='N/A';
  PipeSection1ODUoMLabel.Caption:='-';
  PipeSection1WtValue.Caption:='N/A';
  PipeSection1WtUoMLabel.Caption:='-';

  PipeSection2TDValue.Caption:='N/A';
  PipeSection2TDUoMLabel.Caption:='-';
  PipeSection2IDValue.Caption:='N/A';
  PipeSection2IDUoMLabel.Caption:='-';
  PipeSection2ODValue.Caption:='N/A';
  PipeSection2ODUoMLabel.Caption:='-';
  PipeSection2WtValue.Caption:='N/A';
  PipeSection2WtUoMLabel.Caption:='-';

  PipeSection3TDValue.Caption:='N/A';
  PipeSection3TDUoMLabel.Caption:='-';
  PipeSection3IDValue.Caption:='N/A';
  PipeSection3IDUoMLabel.Caption:='-';
  PipeSection3ODValue.Caption:='N/A';
  PipeSection3ODUoMLabel.Caption:='-';
  PipeSection3WtValue.Caption:='N/A';
  PipeSection3WtUoMLabel.Caption:='-';

  if Data.MaxPipes > 0 then
  begin
    // do pipe 1
    PipeSection1TDValue.Caption:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));
    PipeSection1TDUoMLabel.Caption:=UoMLabel[1];    { user depth }

    PipeSection1IDValue.Caption:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));
    PipeSection1IDUoMLabel.Caption:=UoMLabel[8];       { always inches }

    PipeSection1ODValue.Caption:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));
    PipeSection1ODUoMLabel.Caption:=UoMLabel[8];       { always inches }

    PipeSection1WtValue.Caption:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }
    PipeSection1WtUoMLabel.Caption:='lbs/ft';       { always lbs/ft }

    if Data.MaxPipes > 1 then
    begin
      // do pipe 2
      PipeSection2TDValue.Caption:=FloatToStr(Round2(Data.Pipe[2,1]*UoMConverter[1],2));
      PipeSection2TDUoMLabel.Caption:=UoMLabel[1];    { user depth }

      PipeSection2IDValue.Caption:=FloatToStr(Round2(Data.Pipe[2,2]*UoMConverter[8],4));
      PipeSection2IDUoMLabel.Caption:=UoMLabel[8];       { always inches }

      PipeSection2ODValue.Caption:=FloatToStr(Round2(Data.Pipe[2,3]*UoMConverter[8],4));
      PipeSection2ODUoMLabel.Caption:=UoMLabel[8];       { always inches }

      PipeSection2WtValue.Caption:=FloatToStr(Round2(Data.Pipe[2,4],2));  { lbs per foot }
      PipeSection2WtUoMLabel.Caption:='lbs/ft';       { always lbs/ft }

      if Data.MaxPipes > 2 then
      begin
        // do pipe 3
        PipeSection3TDValue.Caption:=FloatToStr(Round2(Data.Pipe[3,1]*UoMConverter[1],2));
        PipeSection3TDUoMLabel.Caption:=UoMLabel[1];    { user depth }

        PipeSection3IDValue.Caption:=FloatToStr(Round2(Data.Pipe[3,2]*UoMConverter[8],4));
        PipeSection3IDUoMLabel.Caption:=UoMLabel[8];       { always inches }
      
        PipeSection3ODValue.Caption:=FloatToStr(Round2(Data.Pipe[3,3]*UoMConverter[8],4));
        PipeSection3ODUoMLabel.Caption:=UoMLabel[8];       { always inches }

        PipeSection3WtValue.Caption:=FloatToStr(Round2(Data.Pipe[3,4],2));  { lbs per foot }
        PipeSection3WtUoMLabel.Caption:='lbs/ft';       { always lbs/ft }

      end;
    end;
  end else
  begin
    // no pipe defined!
  end;


end;

procedure TDisplayWellDataForm.KillLineIDClick(Sender: TObject);
begin

end;

procedure TDisplayWellDataForm.LinerIDUoMLabelClick(Sender: TObject);
begin

end;

end.

