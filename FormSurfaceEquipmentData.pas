unit FormSurfaceEquipmentData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;

type

  { TSurfaceEquipmentDataForm }

  TSurfaceEquipmentDataForm = class(TForm)
    HoseLengthUoMLabel: TLabel;
    KellyLengthUoMLabel: TLabel;
    StandPipeIDUoMLabel: TLabel;
    KellyIDUoMLabel: TLabel;
    StandPipeLengthUoMLabel: TLabel;
    SwivelIDUoMLabel: TLabel;
    StandPipeIDData: TEdit;
    KellyIDData: TEdit;
    SwivelIDData: TEdit;
    StandPipeLengthData: TEdit;
    KellyLengthData: TEdit;
    HoseIDData: TEdit;
    HoseIDUoMLabel: TLabel;
    SwivelLenfgthUoMLabel: TLabel;
    SwivelLengthData: TEdit;
    KellyLengthLabel: TLabel;
    KellyIDLabel: TLabel;
    HoseLengthData: TEdit;
    SwivelLengthLabel: TLabel;
    SwivelIDLabel: TLabel;
    HoseLengthLabel: TLabel;
    HoseIDLabel: TLabel;
    StandPipeLengthLabel: TLabel;
    StandPipeIDLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure HoseIDDataChange(Sender: TObject);
    procedure HoseLengthDataChange(Sender: TObject);
    procedure KellyIDDataChange(Sender: TObject);
    procedure KellyLengthDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure StandPipeIDDataChange(Sender: TObject);
    procedure StandPipeLengthDataChange(Sender: TObject);
    procedure SwivelIDDataChange(Sender: TObject);
    procedure SwivelLengthDataChange(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SurfaceEquipmentDataForm: TSurfaceEquipmentDataForm;
  _WellSurf  : array[1..4,1..2] of real;

implementation

{$R *.lfm}

{ TSurfaceEquipmentDataForm }

{ ------------- Edit Procedures ------------ }

procedure TSurfaceEquipmentDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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

procedure TSurfaceEquipmentDataForm.KellyLengthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellSurf[1,1]:=Round2(StrToFloat(KellyLengthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TSurfaceEquipmentDataForm.KellyIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellSurf[1,2]:=StrToFloat(KellyIDData.Text)/UoMConverter[8]; { inches }
end;

procedure TSurfaceEquipmentDataForm.SwivelLengthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellSurf[2,1]:=Round2(StrToFloat(SwivelLengthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TSurfaceEquipmentDataForm.SwivelIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellSurf[2,2]:=StrToFloat(SwivelIDData.Text)/UoMConverter[8]; { inches }
end;

procedure TSurfaceEquipmentDataForm.HoseLengthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellSurf[3,1]:=Round2(StrToFloat(HoseLengthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TSurfaceEquipmentDataForm.HoseIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellSurf[3,2]:=StrToFloat(HoseIDData.Text)/UoMConverter[8]; { inches }
end;

procedure TSurfaceEquipmentDataForm.StandPipeLengthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellSurf[4,1]:=Round2(StrToFloat(StandPipeLengthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TSurfaceEquipmentDataForm.StandPipeIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellSurf[4,2]:=StrToFloat(StandPipeIDData.Text)/UoMConverter[8]; { inches }
end;



{ ------------------ Form procedures ---------------------- }

procedure TSurfaceEquipmentDataForm.FormActivate(Sender: TObject);
var i : integer;
begin
  StringToMemo('Form Surface Equipment Data activated...........................');

  // units of measure labels

  KellyLengthUoMLabel.Caption:=UoMLabel[1];        { depth }
  SwivelLenfgthUoMLabel.Caption:=UoMLabel[1];      { depth }
  HoseLengthUoMLabel.Caption:=UoMLabel[1];         { depth }
  StandPipeLengthUoMLabel.Caption:=UoMLabel[1];    { depth }

  KellyIDUoMLabel.Caption:=UoMLabel[8];        { inches }
  SwivelIDUoMLabel.Caption:=UoMLabel[8];       { inches }
  HoseIDUoMLabel.Caption:=UoMLabel[8];         { inches }
  StandPipeIDUoMLabel.Caption:=UoMLabel[8];    { inches }

  // data

  for i:=1 to 4 do
  Begin
    _WellSurf[i,1]:=Data.Surf[i,1];
    _WellSurf[i,2]:=Data.Surf[i,2];
  End;

  KellyLengthData.Text:=FloatToStr(Round2(Data.Surf[1,1]*UoMConverter[1],2));      { depth }
  KellyIDData.Text:=FloatToStr(Data.Surf[1,2]*UoMConverter[8]);                    { inches }
  SwivelLengthData.Text:=FloatToStr(Round2(Data.Surf[2,1]*UoMConverter[1],2));     { depth }
  SwivelIDData.Text:=FloatToStr(Data.Surf[2,2]*UoMConverter[8]);                   { inches }
  HoseLengthData.Text:=FloatToStr(Round2(Data.Surf[3,1]*UoMConverter[1],2));       { depth }
  HoseIDData.Text:=FloatToStr(Data.Surf[3,2]*UoMConverter[8]);                     { inches }
  StandPipeLengthData.Text:=FloatToStr(Round2(Data.Surf[4,1]*UoMConverter[1],2));  { depth }
  StandPipeIDData.Text:=FloatToStr(Data.Surf[4,2]*UoMConverter[8]);                { inches }

end;

procedure TSurfaceEquipmentDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormSurfaceEquipment : TSurface EquipmentDataForm.FormCreate');

end;

procedure TSurfaceEquipmentDataForm.FormDeactivate(Sender: TObject);
begin{ Also called on QuitButton }
    StringToMemo('FormSurfaceEquipmentData.Deactivate ........................................');
end;

procedure TSurfaceEquipmentDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormSurfaceEquipmentData.Quit ..............................................');
  Close;
end;

procedure TSurfaceEquipmentDataForm.SaveButtonClick(Sender: TObject);
var
 i : integer;
begin
  StringToMemo('FormSurfaceEquipmentData.Save ..............................................');

  For i:=1 to 4 do
  Begin
    if (_WellSurf[i,1]=0) or (_WellSurf[i,2]=0)
    then
    Begin
      ShowMessage('Length and internal diameter of surface equipment components must be greater than zero');
      StringToMemo('FormSurfaceEquipmentData.Save: Error: Length and internal diameter of surface equipment components must be greater than zero")');
      Case i of
        1: KellyLengthData.SetFocus;
        2: SwivelLengthData.SetFocus;
        3: HoseLengthData.SetFocus;
        4: StandPipeLengthData.SetFocus;
      end;
      Exit;
    end;
    Data.Surf[i,1]:=_WellSurf[i,1];
    Data.Surf[i,2]:=_WellSurf[i,2];
  end;

  StringToMemo('FormSurfaceEquipmentData.Save: Data.Surf[1,1] = '+ KellyLengthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormSurfaceEquipmentData.Save: Data.Surf[1,2] = '+ KellyIDData.Text + ' ' + UoMLabel[8]);         { inches }
  StringToMemo('FormSurfaceEquipmentData.Save: Data.Surf[2,1] = '+ SwivelLengthData.Text + ' ' + UoMLabel[1]);    { displayed depth }
  StringToMemo('FormSurfaceEquipmentData.Save: Data.Surf[2,2] = '+ SwivelIDData.Text + ' ' + UoMLabel[8]);        { inches }
  StringToMemo('FormSurfaceEquipmentData.Save: Data.Surf[3,1] = '+ HoseLengthData.Text + ' ' + UoMLabel[1]);      { displayed depth }
  StringToMemo('FormSurfaceEquipmentData.Save: Data.Surf[3,2] = '+ HoseIDData.Text + ' ' + UoMLabel[8]);          { inches }
  StringToMemo('FormSurfaceEquipmentData.Save: Data.Surf[4,1] = '+ StandPipeLengthData.Text + ' ' + UoMLabel[1]); { displayed depth }
  StringToMemo('FormSurfaceEquipmentData.Save: Data.Surf[4,2] = '+ StandPipeIDData.Text + ' ' + UoMLabel[8]);     { inches }

  Edited:=True;
  Close;
end;



end.

