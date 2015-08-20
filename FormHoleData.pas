unit FormHoleData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { THoleDataForm }

  THoleDataForm = class(TForm)
    CasingYN: TStaticText;
    procedure CancelClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  HoleDataForm: THoleDataForm;

implementation

{$R *.lfm}

{ ------------------ Form procedures ---------------------- }

procedure THoleDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form General Well Data activated....');
//  StringToMemo('Well name is ' + Data.WellName);

  WellOperatorData.Caption:=Data.WellOperator;
  WellNameData.Caption:=Data.WellName;
  ElevationRKBData.Caption:=FloatToStr(Round2(Data.ElevationRKB*UoMConverter[1],2)); { depth }

  if Data.Offshore=True then
  Begin
    OffshoreYNRadioGroup.ItemIndex:=1;
    SubSeaWellHeadYNRadioGroup.Enabled:=True;
    if Data.SubSeaWellHead=True then
    Begin
      SubSeaWellHeadYNRadioGroup.ItemIndex:=1;
      ChokeLineIDData.Enabled:=True;
      ChokeLineIDData.Caption:=FloatToStr(Data.ChokeLineID*UoMConverter[8]); { inches }
    end else
    Begin
      SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
      RiserTDData.Enabled:=True;
      RiserTDData.Caption:=FloatToStr(Round2(Data.RiserTD*UoMConverter[1],2));  { depth }
      RiserIDData.Enabled:=True;
      RiserIDData.Caption:=FloatToStr(Data.RiserID*UoMConverter[8]);   { inches }
    end;
    WaterDepthData.Enabled:=True;
    WaterDepthData.Caption:=FloatToStr(Round2(Data.WaterDepth*UoMConverter[1],2)); { depth }
  end
  else
  Begin
    OffshoreYNRadioGroup.ItemIndex:=0;
    SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
    SubSeaWellHeadYNRadioGroup.Enabled:=False;
    RiserTDData.Enabled:=False;
    RiserIDData.Enabled:=False;
    ChokeLineIDData.Enabled:=False;
    WaterDepthData.Enabled:=False;
  end;
  ElevationRKBUoMLabel.Caption:=UoMLabel[1];         { depth }
  RiserTDUoMLabel.Caption:=UoMLabel[1];              { depth }
  RiserIDUoMLabel.Caption:=UoMLabel[8];              { inches }
  ChokeLineIDUoMLabel.Caption:=UoMLabel[8];          { inches }
  WaterDepthUoMLabel.Caption:=UoMLabel[1];           { depth }
end;

procedure THoleDataForm.FormCreate(Sender: TObject);
begin

end;

procedure THoleDataForm.CancelClick(Sender: TObject);
begin
  Close;
end;

procedure THoleDataForm.SaveClick(Sender: TObject);
begin
  Data.WellOperator   :=_WellOperator;
  Data.WellName       :=_WellName;
  Data.ElevationRKB   :=_WellElevation;
  Data.Offshore       :=_WellOffshore;
  Data.SubSeaWellHead :=_WellSubSeaWellHead;
  Data.RiserTD        :=_WellRiserTD;
  Data.RiserID        :=_WellRiserID;
  Data.ChokeLineID    :=_WellChokeLineID;
  Data.WaterDepth     :=_WellWaterDepth;
  Edited              :=True;
  Close;
end;

end.

