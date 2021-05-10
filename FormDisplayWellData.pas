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

    WellDataSummaryTitle: TStaticText;

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
    CasingShoeTD: TStaticText;
    CasingShoeTDUoMLabel: TLabel;

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
    LinerShoeTDUoMLabel: TLabel;
    LinerHangerTD: TStaticText;
    LinerHangerUoMLabel: TLabel;          {refactor to TDUoMLabel }

    ChokeLineID: TStaticText;
    ChokeLineIDUoMLabel: TLabel;
    ChokeLineLength: TStaticText;
    ChokeLineLengthUoMLabel: TLabel;

    CloseDisplayWellData: TButton;

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
 ElevationRKBUoMLabel.Caption:=UoMLabel[1];  { user depth }
 WaterDepthUoMLabel.Caption:=UoMLabel[1];    { user depth }
 RiserTDUoMLabel.Caption:=UoMLabel[1];       { user depth }
 RiserIDUoMLabel.Caption:=UoMLabel[8];       { always inches }


 StringToMemo('Form Well Data Summary activated....');
 WellOperatorValue.Caption:=Data.WellOperator;
 WellNameValue.Caption:=Data.WellName;
 ElevationRKBValue.Caption:=FloatToStr(Data.ElevationRKB);

 OffshoreYNValue.Caption:=BoolToStr(Data.Offshore);

 if Data.Offshore then
 begin
   OffshoreYNValue.Caption:='Y';
   WaterDepthValue.Caption:=FloatToStr(Data.WaterDepth);

   if Data.SubSeaWellHead then
     begin
       SubSeaWellHeadYNValue.Caption:='Y';
       RiserIDValue.Caption:=FloatToStr(Data.RiserID);
       RiserTDValue.Caption:=FloatToStr(Data.RiserTD);
     end else
     begin
       SubSeaWellHeadYNValue.Caption:='N';
       RiserIDValue.Caption:='N/A';
       RiserTDValue.Caption:='N/A';
     end;
 end
 else
 begin
   OffshoreYNValue.Caption:='N';
   WaterDepthValue.Caption:='N/A';
 end;


end;

procedure TDisplayWellDataForm.LinerIDUoMLabelClick(Sender: TObject);
begin

end;

end.

