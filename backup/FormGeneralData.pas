unit FormGeneralData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;

type

  { TGeneralDataForm }

  TGeneralDataForm = class(TForm)
    WellNameData: TEdit;
    WellOperatorData: TEdit;
    ElevationRKB: TStaticText;
    WellOperator: TStaticText;
    WellName: TStaticText;
    RiserTD: TStaticText;
    RiserID: TStaticText;
    SubSeaWellHeadYNRadioGroup: TRadioGroup;
    WaterDepthUoMLabel: TLabel;
    RiserTDUoMLabel: TLabel;
    RiserIDUoMLabel: TLabel;
    WaterDepthData: TEdit;
    RiserTDData: TEdit;
    RiserIDData: TEdit;
    WaterDepth: TStaticText;
    ElevationRKBData: TEdit;
    ElevationRKBUoMLabel: TLabel;
    OffshoreYNRadioGroup: TRadioGroup;
    KillLineID: TStaticText;
    ChokeLineIDData: TEdit;
    KillLineIDData: TEdit;
    ChokeLineIDUoMLabel: TLabel;
    KillLineIDUoMLabel: TLabel;
    ChokeLineID: TStaticText;
    Save: TButton;
    //Quit: TButton; not used

    procedure WellOperatorDataChange(Sender: TObject);
    procedure WellNameDataChange(Sender: TObject);
    procedure ElevationRKBDataChange(Sender: TObject);
    procedure OffshoreYNRadioGroupClick(Sender: TObject);
    procedure SubSeaWellHeadYNRadioGroupClick(Sender: TObject);
    procedure RiserIDDataChange(Sender: TObject);
    procedure RiserTDDataChange(Sender: TObject);
    procedure ChokeLineIDDataChange(Sender: TObject);
    procedure KillLineIDDataChange(Sender: TObject);
    procedure WaterDepthDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);

    procedure QuitClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  GeneralDataForm           : TGeneralDataForm;

  _WellOperator             : String120;
  _WellName           : String120;
  _WellElevationRKB   : real;
  _WellOffshore       : boolean;
  _WellSubSeaWellHead : boolean;
  _WellRiser          : boolean;
  _WellRiserTD        : real;
  _WellRiserID        : real;
  _WellChokeLineID    : real;
  _WellKillLineID     : real;
  _WellWaterDepth     : real;

implementation

Uses DrillSimGUI;

{$R *.lfm}

{ TGeneralDataForm }

{ ------------- Edit Procedures ------------ }

procedure TGeneralDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', DefaultFormatSettings.DecimalSeparator]) then   { discard if not in approved list of chars }
  Begin
    Key := #0;  // discard it
  end
  else if ((Key = '-')) and  ((Sender as TEdit).SelStart <> 0) then             { discard if "-" and not first char in string }
  Begin
    Key := #0;  // discard it
  end
  else if ((Key = DefaultFormatSettings.DecimalSeparator) or (Key = '-')) and        { discard if "." or "-" already in string }
          (Pos(Key, (Sender as TEdit).Text) > 0) then
  Begin
    Key := #0;  // discard it
  end
  else if (Key = DefaultFormatSettings.DecimalSeparator) and                         { discard if "." is first charachter }
          ((Sender as TEdit).SelStart = 0) then
  Begin
    Key := #0;  // discard it
  end;
end;

procedure TGeneralDataForm.WellOperatorDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellOperator:=WellOperatorData.Text;
end;

procedure TGeneralDataForm.WellNameDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellName:=WellNameData.Text;
end;

procedure TGeneralDataForm.ElevationRKBDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellElevationRKB:=Round2(StrToFloat(ElevationRKBData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeneralDataForm.OffshoreYNRadioGroupClick(Sender: TObject);
begin
  case OffshoreYNRadioGroup.ItemIndex of
    0: Begin
         _WellOffshore:= False;
         SubSeaWellHeadYNRadioGroup.Enabled:=False;
         RiserTDData.Enabled:=False;
         RiserIDData.Enabled:=False;
         ChokeLineIDData.Enabled:=False;
         KillLineIDData.Enabled:=False;
         WaterDepthData.Enabled:=False;

         SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
//         RiserTDData.Caption:=FloatToStr(0);     { leave data - no need to zero }
//         RiserIDData.Caption:=FloatToStr(0);     { leave data - no need to zero }
//         ChokeLineIDData.Caption:=FloatToStr(0); { leave data - no need to zero }
//         KillLineIDData.Caption:=FloatToStr(0);  { leave data - no need to zero }
//         WaterDepthData.Caption:=FloatToStr(0);  { leave data - no need to zero }
       End;
    1: Begin
         _WellOffshore:= True;
         SubSeaWellHeadYNRadioGroup.Enabled:=True;

         if Data.SubSeaWellHead=True then
         Begin
           SubSeaWellHeadYNRadioGroup.ItemIndex:=1;
           ChokeLineIDData.Enabled:=True;
           KillLineIDData.Enabled:=True;
           RiserTDData.Enabled:=True;
           RiserIDData.Enabled:=True;
         end else
         Begin
           SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
         end;
         WaterDepthData.Enabled:=True;
       End;
    end;
end;

procedure TGeneralDataForm.SubSeaWellHeadYNRadioGroupClick(Sender: TObject);
begin
  case SubSeaWellHeadYNRadioGroup.ItemIndex of
    0: Begin
         _WellSubSeaWellHead:=False;
         _WellRiser:=False;
         RiserTDData.Enabled:=False;
         RiserIDData.Enabled:=False;
         ChokeLineIDData.Enabled:=False;
         KillLineIDData.Enabled:=False;
//         WaterDepthData.Enabled:=True;

//         SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
//         RiserTDData.Caption:=FloatToStr(0);  { leave data - no need to zero }
//         RiserIDData.Caption:=FloatToStr(0);  { leave data - no need to zero }
       End;
    1: Begin
         _WellSubSeaWellHead:=True;
         _WellRiser:=True;
         ChokeLineIDData.Enabled:=True;
         KillLineIDData.Enabled:=True;
         WaterDepthData.Enabled:=True;
         RiserTDData.Enabled:=True;
         RiserIDData.Enabled:=True;
//         WaterDepthData.Enabled:=True;

//         ChokeLineIDData.Caption:=FloatToStr(0); { leave data - no need to zero }
       End;
    end;
end;

procedure TGeneralDataForm.RiserTDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellRiserTD:=Round2(StrToFloat(RiserTDData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeneralDataForm.RiserIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellRiserID:=StrToFloat(RiserIDData.Text)/UoMConverter[8]; { inches }
end;

procedure TGeneralDataForm.ChokeLineIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellChokeLineID:=StrToFloat(ChokeLineIDData.Text)/UoMConverter[8]; { inches }
end;

procedure TGeneralDataForm.KillLineIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellKillLineID:=StrToFloat(KillLineIDData.Text)/UoMConverter[8]; { inches }
end;

procedure TGeneralDataForm.WaterDepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellWaterDepth:=Round2(StrToFloat(WaterDepthData.Text)/UoMConverter[1],2); { depth }
end;


{ ------------------ Form procedures ---------------------- }

procedure TGeneralDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form General Well Data activated....');
//  StringToMemo('Well name is ' + Data.WellName);

  // units of measure labels
  ElevationRKBUoMLabel.Caption:=UoMLabel[1];         { depth }
  RiserTDUoMLabel.Caption:=UoMLabel[1];              { depth }
  RiserIDUoMLabel.Caption:=UoMLabel[8];              { inches }
  ChokeLineIDUoMLabel.Caption:=UoMLabel[8];          { inches }
  KillLineIDUoMLabel.Caption:=UoMLabel[8];          { inches }
  WaterDepthUoMLabel.Caption:=UoMLabel[1];           { depth }

  // data
  WellOperatorData.Caption:=Data.WellOperator;
  _WellOperator:=Data.WellOperator;

  WellNameData.Caption:=Data.WellName;
  _WellName:=Data.WellName;

  ElevationRKBData.Caption:=FloatToStr(Round2(Data.ElevationRKB*UoMConverter[1],2)); { depth }
  _WellElevationRKB:=Data.ElevationRKB;

  if Data.Offshore=True then
  Begin
    OffshoreYNRadioGroup.ItemIndex:=1;
    SubSeaWellHeadYNRadioGroup.Enabled:=True;
    if Data.SubSeaWellHead=True then
    Begin
      SubSeaWellHeadYNRadioGroup.ItemIndex:=1;
      RiserTDData.Enabled:=True;
      RiserTDData.Caption:=FloatToStr(Round2(Data.RiserTD*UoMConverter[1],2));  { depth }
      _WellRiserTD:=Data.RiserTD;

      RiserIDData.Enabled:=True;
      RiserIDData.Caption:=FloatToStr(Data.RiserID*UoMConverter[8]);   { inches }
      _WellRiserID:=Data.RiserID;

      ChokeLineIDData.Enabled:=True;
      ChokeLineIDData.Caption:=FloatToStr(Data.ChokeLineID*UoMConverter[8]); { inches }
      _WellChokeLineID:=Data.ChokeLineID;

      KillLineIDData.Enabled:=True;
      KillLineIDData.Caption:=FloatToStr(Data.KillLineID*UoMConverter[8]); { inches }
      _WellKillLineID:=Data.KillLineID;

    end else
    Begin
      SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
    end;

    WaterDepthData.Enabled:=True;
    WaterDepthData.Caption:=FloatToStr(Round2(Data.WaterDepth*UoMConverter[1],2)); { depth }
    _WellWaterDepth:=Data.WaterDepth;

  end
  else
  Begin
    OffshoreYNRadioGroup.ItemIndex:=0;
    SubSeaWellHeadYNRadioGroup.ItemIndex:=0;
    SubSeaWellHeadYNRadioGroup.Enabled:=False;
    RiserTDData.Enabled:=False;
    RiserIDData.Enabled:=False;
    ChokeLineIDData.Enabled:=False;
    KillLineIDData.Enabled:=False;
    WaterDepthData.Enabled:=False;
  end;
end;

procedure TGeneralDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormGeneralData : TGeneralDataForm.FormCreate');
end;

procedure TGeneralDataForm.QuitClick(Sender: TObject);
begin
  Close;
end;

procedure TGeneralDataForm.SaveClick(Sender: TObject);

  { ------------- Riser Checks ----------------}
  Function RiserisOK : boolean;
  Var
    TDisOK : boolean;
    IDisOK : boolean;
  Begin
    StringToMemo('Validating Riser...');
    if (_WellRiserTD <= _WellWaterDepth)     { Casing depth must be greater than Water Depth }
    then
    Begin
      ShowMessage('Riser depth must be at least as deep as the water depth');
      StringToMemo('FormHoleData.Save: Error: Riser depth must be at least as deep as the water depth');
      RiserTDData.SetFocus;
      TDisOK:=False;
    end
    else
    Begin
      Data.RiserTD:=_WellRiserTD;
      StringToMemo('FormHoleData.Save: Data.RiserTD = '+ RiserTDData.Text + ' ' + UoMLabel[1]); { displayed depth }
      TDisOK:=True;
    End;

    if (_WellRiserID > 50) or (_WellRiserID <= 0)                { Riser ID must be less than something sensible }
    then
    Begin
      ShowMessage('Riser ID must be greater than zero and less than 50 inches');
      StringToMemo('FormHoleData.Save: Error: Riser ID must be greater than zero and less than 50 inches');
      RiserIDData.SetFocus;
      IDisOK:=False;
    end
    else
    Begin
      Data.RiserID :=_WellRiserID;
      StringToMemo('FormHoleData.Save: Data.RiserID = '+ RiserIDData.Text + ' ' + UoMLabel[8]); { inches }
      IDisOK:=True;
    End;
    if TDisOK and IDisOK then
    Begin
      RiserisOK:=True;
      StringToMemo('RiserisOK: Success');
    End
    else
    Begin
      RiserisOK:=False;
      StringToMemo('RiserisOK: Fail');
      Exit;
    End;

  end;

begin
  StringToMemo('FormGeneralData.Save ..............................................');

  Data.WellOperator   :=_WellOperator;
  Data.WellName       :=_WellName;

  Data.ElevationRKB   :=_WellElevationRKB;
  Data.Offshore       :=_WellOffshore;
  Data.SubSeaWellHead :=_WellSubSeaWellHead;
  Data.Riser          :=_WellRiser;

  if Data.Offshore then
  Begin
    if Data.SubSeaWellHead
    then
    Begin
      StringToMemo('Checking Riser...');
      if RiserisOK = True then StringToMemo('Riser profile validation: Success') else
      Begin
        StringToMemo('Riser profile validation: Fail');
        Exit
      End;
      Data.ChokeLineID :=_WellChokeLineID;
      Data.KillLineID  :=_WellKillLineID;
    End;
    if _WellWaterDepth > _WellRiserTD then
    Begin
      ShowMessage('Water depth cannot be deeper than the riser TD');
      StringToMemo('FormHoleData.Save: Error: Water depth cannot be deeper than the riser TD');
      RiserTDData.SetFocus;
      Exit;
    end
    else
    Begin
      Data.WaterDepth:=_WellWaterDepth;
      StringToMemo('FormHoleData.Save: Data.WaterDepth = '+ WaterDepthData.Text + ' ' + UoMLabel[1]); { displayed depth }
     End;
  end;

  Edited:=True;
  Close;
end;


end.
