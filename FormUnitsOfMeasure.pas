unit FormUnitsOfMeasure;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,
  DrillSimVariables,
  DrillSimMessageToMemo,
  DrillSimUnitsOfMeasure;

type

  { TUnitsOfMeasureForm }

  TUnitsOfMeasureForm = class(TForm)
    SelectUoMRadioGroup: TRadioGroup;
    CloseButton: TButton;
    DensityMultiplierData: TEdit;
    FlowRateLabelData: TEdit;
    FlowRateMultiplierData: TEdit;
    FlowVolumeMultiplierData: TEdit;
    LengthMultiplierData: TEdit;
    PressureMultiplierData: TEdit;
    UoMUnitLabel: TStaticText;
    UoMMultiplierLabel: TStaticText;
    VolumeMultiplierData: TEdit;
    WeightLabelData: TEdit;
    PressureLabelData: TEdit;
    LengthLabelData: TEdit;
    DensityLabelData: TEdit;
    VolumeLabelData: TEdit;
    LengthText: TStaticText;
    DensityText: TStaticText;
    PressureText: TStaticText;
    FlowVolumeLabelData: TEdit;
    VolumeText: TStaticText;
    FlowVolumeText: TStaticText;
    FlowRateText: TStaticText;
    WeightMultiplierData: TEdit;
    WeightText: TStaticText;
    procedure OnClose(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCreateActions;
    procedure FormDisplayUnits;
    procedure SelectUoMRadioGroupClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  UnitsOfMeasureForm: TUnitsOfMeasureForm;
  _WellAPI     : boolean;

implementation

{ TUnitsOfMeasureForm }

{$R *.lfm}


Procedure TUnitsOfMeasureForm.FormDisplayUnits;
Begin
  if _WellAPI = True then   { set array contents to api or metric }
    APIUnits
  else MetricUnits;

{* set conversions for current UoM set *}
    LengthLabelData.Text:=UoMLabel[1];     {*  "ft." or "met" *}
    LengthMultiplierData.Text:=FloatToStr(UoMConverter[1]);

    DensityLabelData.Text:=UoMLabel[2];    {* "ppg" or "sg" *}
    DensityMultiplierData.Text:=FloatToStr(UoMConverter[2]);

    PressureLabelData.Text:=UoMLabel[3];    {* "psi" or "KPa" *}
    PressureMultiplierData.Text:=FloatToStr(UoMConverter[3]);

    VolumeLabelData.Text:=UoMLabel[4];    {* "psi" or "KPa" *}
    VolumeMultiplierData.Text:=FloatToStr(UoMConverter[4]);

    FlowVolumeLabelData.Text:=UoMLabel[5];    {* "psi" or "KPa" *}
    FlowVolumeMultiplierData.Text:=FloatToStr(UoMConverter[5]);

    FlowRateLabelData.Text:=UoMLabel[6];    {* "psi" or "KPa" *}
    FlowRateMultiplierData.Text:=FloatToStr(UoMConverter[6]);

    WeightLabelData.Text:=UoMLabel[7];    {* "psi" or "KPa" *}
    WeightMultiplierData.Text:=FloatToStr(UoMConverter[7]);
end;

{ ------------- Edit Procedures ------------ }

procedure TUnitsOfMeasureForm.SelectUoMRadioGroupClick(Sender: TObject);
begin
case SelectUoMRadioGroup.ItemIndex of
  0: Begin
       _WellAPI    := True;
     End;

  1: Begin
       _WellAPI    := False;
     End;
  end;
  FormDisplayUnits;

end;

{ ------------- Form Procedures ------------ }

Procedure TUnitsOfMeasureForm.FormCreateActions;
Begin
  { nothing to see here }
end;

procedure TUnitsOfMeasureForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormUnitsOfMeasure : TUnitsOfMeasureDataForm.FormCreate');
  FormCreateActions;
end;

procedure TUnitsOfMeasureForm.FormActivate(Sender: TObject);
begin
   StringToMemo('Form Units Of Measure activated....');
   if Data.API= True
   then
   Begin
     SelectUoMRadioGroup.ItemIndex:=0;   { set up radio buttons }
     _WellAPI:=True;
   end
   else
   Begin
     SelectUoMRadioGroup.ItemIndex:=1;
     _WellAPI:=False;
   end;
   FormDisplayUnits;                     { display units }
End;

procedure TUnitsOfMeasureForm.CloseButtonClick(Sender: TObject);
begin
  if Data.API <> _WellAPI then
  Begin
    Edited:=True;
    Data.API:=_WellAPI;
  end;
  Close;
end;

Procedure TUnitsOfMeasureForm.OnClose(Sender: TObject);
begin
 Close;
end;

end.

