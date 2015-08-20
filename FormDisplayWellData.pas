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
 DrillSimMessageToMemo;

type

  { TDisplayWellDataForm }

  TDisplayWellDataForm = class(TForm)
    Button1: TButton;
    ElevationRKBValue: TLabel;
    OffshoreYNValue: TLabel;
    WellOperatorValue: TLabel;
    OpenHoleSection2IDUoMLabel: TLabel;
    OpenHoleSection1TDUoMLabel: TLabel;
    LinerID: TStaticText;
    LinerIDUoMLabel: TLabel;
    LinerShoeTDUoMLabel: TLabel;
    LinerHangerTD: TStaticText;
    LinerHangerUoMLabel: TLabel;
    ChokeLineID: TStaticText;
    CasingShoeTDUoMLabel: TLabel;
    ElevationRKB: TStaticText;
    ElevationRKBUoMLabel: TLabel;
    ChokeLineLength: TStaticText;
    ChokeLineLengthUoMLabel: TLabel;
    CasingID: TStaticText;
    LinerShoeTD: TStaticText;
    ChokeLineIDUoMLabel: TLabel;
    CasingShoeTD: TStaticText;
    CasingIDUoMLabel: TLabel;
    LinerYN: TStaticText;
    NumberOfOpenHoleSections: TStaticText;
    OpenHoleSection3IDUoMLabel: TLabel;
    OpenHoleSection2TDUoMLabel: TLabel;
    OpenHoleSection2ID: TStaticText;
    OpenHoleSection1TD: TStaticText;
    OpenHoleSection3TDUoMLabel: TLabel;
    OpenHoleSection3ID: TStaticText;
    OpenHoleSection2TD: TStaticText;
    OpenHoleSection3TD: TStaticText;
    OpenHoleSection1ID: TStaticText;
    OpenHoleSection1IDUoMLabel: TLabel;
    WaterDepth: TStaticText;
    WaterDepthUoMLabel: TLabel;
    SubSeaWellHeadYN: TStaticText;
    RiserID: TStaticText;
    RiserTDUoMLabel: TLabel;
    OffshoreYN: TStaticText;
    CloseDisplayWellData: TButton;
    RiserIDUoMLabel: TLabel;
    WellDataSummaryTitle: TStaticText;
    RiserTD: TStaticText;
    CasingYN: TStaticText;
    WellName: TStaticText;
    WellOperator: TStaticText;
    WellNameValue: TLabel;
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

Uses DrillSimGUI;

{ TDisplayWellDataForm }

{$R *.lfm}

{ ------------- Form Procedures ------------ }

Procedure TDisplayWellDataForm.FormCreateActions;
Begin
end;

procedure TDisplayWellDataForm.FormCreate(Sender: TObject);
begin
  FormCreateActions;
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
 ElevationRKBValue.Caption:=FloatToStr(Data.ElevationRKB);
 OffshoreYNValue.Caption:=BoolToStr(Data.Offshore);
end;

end.

