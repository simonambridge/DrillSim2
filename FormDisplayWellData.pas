unit FormDisplayWellData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TDisplayWellData }

  TDisplayWellData = class(TForm)
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
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DisplayWellData: TDisplayWellData;

implementation

Uses DrillSimGUI;

{$R *.lfm}

{ TDisplayWellData }

procedure TDisplayWellData.FormCreate(Sender: TObject);
begin

end;

end.

