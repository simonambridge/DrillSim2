unit FormGeologyData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;

type

  { TGeologyDataForm }
  TGeologyDataForm = class(TForm)
      Horizon1DepthData: TEdit;
      Horizon2DepthData: TEdit;
      Horizon3DepthData: TEdit;
      Horizon4DepthData: TEdit;
      Horizon5DepthData: TEdit;
      Horizon6DepthData: TEdit;
      Horizon7DepthData: TEdit;
      Horizon8DepthData: TEdit;
      Horizon9DepthData: TEdit;
      Horizon10DepthData: TEdit;
      Horizon2HardnessData: TEdit;
      Horizon3HardnessData: TEdit;
      Horizon4HardnessData: TEdit;
      Horizon5HardnessData: TEdit;
      Horizon6HardnessData: TEdit;
      Horizon7HardnessData: TEdit;
      Horizon8HardnessData: TEdit;
      Horizon9HardnessData: TEdit;
      Horizon10HardnessData: TEdit;
      Horizon2Label: TLabel;
      Horizon3Label: TLabel;
      Horizon4Label: TLabel;
      Horizon5Label5: TLabel;
      Horizon6Label: TLabel;
      Horizon7Label: TLabel;
      Horizon8Label: TLabel;
      Horizon9Label: TLabel;
      Horizon10Label: TLabel;
      Horizon1FormationPressureData: TEdit;
      Horizon1HardnessData: TEdit;
      Horizon1Label: TLabel;
      Horizon2FormationPressureData: TEdit;
      Horizon3FormationPressureData: TEdit;
      Horizon4FormationPressureData: TEdit;
      Horizon5FormationPressureData: TEdit;
      Horizon6FormationPressureData: TEdit;
      Horizon7FormationPressureData: TEdit;
      Horizon8FormationPressureData: TEdit;
      Horizon9FormationPressureData: TEdit;
      Horizon10FormationPressureData: TEdit;
      HorizonColumnLabel: TLabel;
      HorizonTopDepthUoMLabel: TLabel;
      HardnessColumnLabel: TLabel;
      ReservoirPressureUoMLabel: TLabel;
      ReservoirPressureColumnLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Horizon1FormationPressureDataChange(Sender: TObject);
    procedure Horizon1DepthDataChange(Sender: TObject);
    procedure Horizon1HardnessDataChange(Sender: TObject);
    procedure Horizon2DepthDataChange(Sender: TObject);
    procedure Horizon2HardnessDataChange(Sender: TObject);
    procedure Horizon2FormationPressureDataChange(Sender: TObject);
    procedure Horizon3DepthDataChange(Sender: TObject);
    procedure Horizon3HardnessDataChange(Sender: TObject);
    procedure Horizon3FormationPressureDataChange(Sender: TObject);
    procedure Horizon4DepthDataChange(Sender: TObject);
    procedure Horizon4HardnessDataChange(Sender: TObject);
    procedure Horizon4FormationPressureDataChange(Sender: TObject);
    procedure Horizon5DepthDataChange(Sender: TObject);
    procedure Horizon5HardnessDataChange(Sender: TObject);
    procedure Horizon5FormationPressureDataChange(Sender: TObject);
    procedure Horizon6DepthDataChange(Sender: TObject);
    procedure Horizon6HardnessDataChange(Sender: TObject);
    procedure Horizon6FormationPressureDataChange(Sender: TObject);
    procedure Horizon7DepthDataChange(Sender: TObject);
    procedure Horizon7HardnessDataChange(Sender: TObject);
    procedure Horizon7FormationPressureDataChange(Sender: TObject);
    procedure Horizon8DepthDataChange(Sender: TObject);
    procedure Horizon8HardnessDataChange(Sender: TObject);
    procedure Horizon8FormationPressureDataChange(Sender: TObject);
    procedure Horizon9DepthDataChange(Sender: TObject);
    procedure Horizon9HardnessDataChange(Sender: TObject);
    procedure Horizon9FormationPressureDataChange(Sender: TObject);
    procedure Horizon10DepthDataChange(Sender: TObject);
    procedure Horizon10HardnessDataChange(Sender: TObject);
    procedure Horizon10FormationPressureDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  GeologyDataForm: TGeologyDataForm;
  _WellFormation  : array[1..10] of FormationRecord;

implementation

{$R *.lfm}

{ TGeologyDataForm }

{ ------------- Edit Procedures ------------ }

procedure TGeologyDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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

procedure TGeologyDataForm.Horizon1DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[1].Depth:=Round2(StrToFloat(Horizon1DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon1HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[1].Hardness:=Round2(StrToFloat(Horizon1HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon1FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[1].FP:=Round2(StrToFloat(Horizon1FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;

procedure TGeologyDataForm.Horizon2DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[2].Depth:=Round2(StrToFloat(Horizon2DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon2HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[2].Hardness:=Round2(StrToFloat(Horizon2HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon2FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[2].FP:=Round2(StrToFloat(Horizon2FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;


procedure TGeologyDataForm.Horizon3DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[3].Depth:=Round2(StrToFloat(Horizon3DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon3HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[3].Hardness:=Round2(StrToFloat(Horizon3HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon3FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[3].FP:=Round2(StrToFloat(Horizon3FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;


procedure TGeologyDataForm.Horizon4DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[4].Depth:=Round2(StrToFloat(Horizon4DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon4HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[4].Hardness:=Round2(StrToFloat(Horizon4HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon4FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[4].FP:=Round2(StrToFloat(Horizon4FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;


procedure TGeologyDataForm.Horizon5DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[5].Depth:=Round2(StrToFloat(Horizon5DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon5HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[5].Hardness:=Round2(StrToFloat(Horizon5HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon5FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[5].FP:=Round2(StrToFloat(Horizon5FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;


procedure TGeologyDataForm.Horizon6DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[6].Depth:=Round2(StrToFloat(Horizon6DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon6HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[6].Hardness:=Round2(StrToFloat(Horizon6HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon6FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[6].FP:=Round2(StrToFloat(Horizon6FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;


procedure TGeologyDataForm.Horizon7DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[7].Depth:=Round2(StrToFloat(Horizon7DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon7HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[7].Hardness:=Round2(StrToFloat(Horizon7HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon7FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[7].FP:=Round2(StrToFloat(Horizon7FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;


procedure TGeologyDataForm.Horizon8DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[8].Depth:=Round2(StrToFloat(Horizon8DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon8HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[8].Hardness:=Round2(StrToFloat(Horizon8HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon8FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[8].FP:=Round2(StrToFloat(Horizon8FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;


procedure TGeologyDataForm.Horizon9DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[9].Depth:=Round2(StrToFloat(Horizon9DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon9HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[9].Hardness:=Round2(StrToFloat(Horizon9HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon9FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[9].FP:=Round2(StrToFloat(Horizon9FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;


procedure TGeologyDataForm.Horizon10DepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[10].Depth:=Round2(StrToFloat(Horizon10DepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure TGeologyDataForm.Horizon10HardnessDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[10].Hardness:=Round2(StrToFloat(Horizon10HardnessData.Text),2); { hardness }
end;

procedure TGeologyDataForm.Horizon10FormationPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellFormation[10].FP:=Round2(StrToFloat(Horizon10FormationPressureData.Text)/UoMConverter[3],2); { pressure }
end;

{ ------------------ Form procedures ---------------------- }

procedure TGeologyDataForm.FormActivate(Sender: TObject);
var i : integer;
begin
  StringToMemo('Form Well Geology Data activated...........................');

  // units of measure labels

  HorizonTopDepthUoMLabel.Caption:='(' + UoMLabel[1] + ')';        { depth }
  ReservoirPressureUoMLabel.Caption:='(' + UoMLabel[3] + ')';      { pressure }

  // data

  for i:=1 to 10 do
  Begin
    _WellFormation[i]:=Data.Formation[i];
  End;

  Horizon1DepthData.Text:=FloatToStr(Round2(Data.Formation[1].Depth*UoMConverter[1],2));               { depth }
  Horizon1HardnessData.Text:=FloatToStr(Round2(Data.Formation[1].Hardness,2));                         { hardness }
  Horizon1FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[1].FP*UoMConverter[3],2));      { pressure }

  Horizon2DepthData.Text:=FloatToStr(Round2(Data.Formation[2].Depth*UoMConverter[1],2));               { depth }
  Horizon2HardnessData.Text:=FloatToStr(Round2(Data.Formation[2].Hardness,2));                         { hardness }
  Horizon2FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[2].FP*UoMConverter[3],2));      { pressure }

  Horizon3DepthData.Text:=FloatToStr(Round2(Data.Formation[3].Depth*UoMConverter[1],2));               { depth }
  Horizon3HardnessData.Text:=FloatToStr(Round2(Data.Formation[3].Hardness,2));                         { hardness }
  Horizon3FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[3].FP*UoMConverter[3],2));      { pressure }

  Horizon4DepthData.Text:=FloatToStr(Round2(Data.Formation[4].Depth*UoMConverter[1],2));               { depth }
  Horizon4HardnessData.Text:=FloatToStr(Round2(Data.Formation[4].Hardness,2));                         { hardness }
  Horizon4FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[4].FP*UoMConverter[3],2));      { pressure }

  Horizon5DepthData.Text:=FloatToStr(Round2(Data.Formation[5].Depth*UoMConverter[1],2));               { depth }
  Horizon5HardnessData.Text:=FloatToStr(Round2(Data.Formation[5].Hardness,2));                         { hardness }
  Horizon5FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[5].FP*UoMConverter[3],2));      { pressure }

  Horizon6DepthData.Text:=FloatToStr(Round2(Data.Formation[6].Depth*UoMConverter[1],2));               { depth }
  Horizon6HardnessData.Text:=FloatToStr(Round2(Data.Formation[6].Hardness,2));                         { hardness }
  Horizon6FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[6].FP*UoMConverter[3],2));      { pressure }

  Horizon7DepthData.Text:=FloatToStr(Round2(Data.Formation[7].Depth*UoMConverter[1],2));               { depth }
  Horizon7HardnessData.Text:=FloatToStr(Round2(Data.Formation[7].Hardness,2));                         { hardness }
  Horizon7FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[7].FP*UoMConverter[3],2));      { pressure }

  Horizon8DepthData.Text:=FloatToStr(Round2(Data.Formation[8].Depth*UoMConverter[1],2));               { depth }
  Horizon8HardnessData.Text:=FloatToStr(Round2(Data.Formation[8].Hardness,2));                         { hardness }
  Horizon8FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[8].FP*UoMConverter[3],2));      { pressure }

  Horizon9DepthData.Text:=FloatToStr(Round2(Data.Formation[9].Depth*UoMConverter[1],2));               { depth }
  Horizon9HardnessData.Text:=FloatToStr(Round2(Data.Formation[9].Hardness,2));                         { hardness }
  Horizon9FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[9].FP*UoMConverter[3],2));      { pressure }

  Horizon10DepthData.Text:=FloatToStr(Round2(Data.Formation[10].Depth*UoMConverter[1],2));               { depth }
  Horizon10HardnessData.Text:=FloatToStr(Round2(Data.Formation[10].Hardness,2));                         { hardness }
  Horizon10FormationPressureData.Text:=FloatToStr(Round2(Data.Formation[10].FP*UoMConverter[3],2));      { pressure }

end;

procedure TGeologyDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormGeologyData : TGeologyDataForm.FormCreate');

end;

procedure TGeologyDataForm.FormDeactivate(Sender: TObject);
begin{ Also called on QuitButton }
    StringToMemo('FormGeologyData.Deactivate ........................................');
end;

procedure TGeologyDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormGeologyData.Quit ..............................................');
  Close;
end;

procedure TGeologyDataForm.SaveButtonClick(Sender: TObject);
var
 i, j : integer;
begin
  StringToMemo('FormGeologyData.Save ..............................................');

  if (_WellFormation[1].Depth=0)              { must be at least one formation defined }
          or (_WellFormation[1].Hardness=0)
          or (_WellFormation[1].FP=0)
  then
  Begin
    ShowMessage('At least one valid formation must be defined');
    StringToMemo('FormGeologyData.Save: Error: At least one valid formation must be defined');
    if _WellFormation[1].Depth=0 then Horizon1DepthData.SetFocus;
    if _WellFormation[1].Hardness=0 then Horizon1HardnessData.SetFocus;
    if _WellFormation[1].FP=0 then Horizon1FormationPressureData.SetFocus;
    Exit;
  end;

  for i:=2 to 10 do     { check remaining horizons }
  Begin
    if (_WellFormation[i].Depth<=_WellFormation[i-1].Depth)  { if depth is non-zero check that depths are in sequence }
    and (_WellFormation[i].Depth>0)
    then
    Begin
      ShowMessage('Horizon top depth must be deeper than previous horizon top depth');
      StringToMemo('FormGeologyData.Save: Error: Horizon top depth must be deeper than previous horizon top depth');
      Case i of
        2: Horizon2DepthData.SetFocus;
        3: Horizon3DepthData.SetFocus;
        4: Horizon4DepthData.SetFocus;
        5: Horizon5DepthData.SetFocus;
        6: Horizon6DepthData.SetFocus;
        7: Horizon7DepthData.SetFocus;
        8: Horizon8DepthData.SetFocus;
        9: Horizon9DepthData.SetFocus;
        10: Horizon10DepthData.SetFocus;
      End;
      Exit;
    End;

    if _WellFormation[i].Depth=0       { if depth is zero, clear all remaining values }
    then
    Begin
      for j:=i to 10 do
      Begin
        _WellFormation[j].Depth:=0;
        _WellFormation[j].Hardness:=0;
        _WellFormation[j].FP:=0;
      End;
    End else
    Begin

    if _WellFormation[i].Depth>0       { if depth is non-zero and in sequence, check hardness and FP }
    then
    Begin
      if (_WellFormation[i].Hardness<=0)
      or (_WellFormation[i].Hardness>1)then
      Begin
        ShowMessage('Formation hardness must be greater than 0 and less than 1');
        StringToMemo('FormGeologyData.Save: Error: Formation hardness must be greater than 0 and less than 1');
        Case i of
          2: Horizon2HardnessData.SetFocus;
          3: Horizon3HardnessData.SetFocus;
          4: Horizon4HardnessData.SetFocus;
          5: Horizon5HardnessData.SetFocus;
          6: Horizon6HardnessData.SetFocus;
          7: Horizon7HardnessData.SetFocus;
          8: Horizon8HardnessData.SetFocus;
          9: Horizon9HardnessData.SetFocus;
          10: Horizon10HardnessData.SetFocus;
        End;
        Exit;
      End;
      if (_WellFormation[i].FP<=0)
      then
      Begin
        ShowMessage('Formation pressure cannot be zero or less than zero');
        StringToMemo('FormGeologyData.Save: Error: Formation pressure cannot be zero or less than zero');
        Case i of
          2: Horizon2FormationPressureData.SetFocus;
          3: Horizon3FormationPressureData.SetFocus;
          4: Horizon4FormationPressureData.SetFocus;
          5: Horizon5FormationPressureData.SetFocus;
          6: Horizon6FormationPressureData.SetFocus;
          7: Horizon7FormationPressureData.SetFocus;
          8: Horizon8FormationPressureData.SetFocus;
          9: Horizon9FormationPressureData.SetFocus;
          10: Horizon10FormationPressureData.SetFocus;
        End;
        Exit;
      End;
    End;
    End;
  End;

  for i:=1 to 10 do    { if we get here, all data is good so copy it to Data record }
  Begin
    Data.Formation[i].Depth:=_WellFormation[i].Depth;
    Data.Formation[i].Hardness:=_WellFormation[i].Hardness;
    Data.Formation[i].FP:=_WellFormation[i].FP;
  End;

  StringToMemo('FormGeologyData.Save: Data.Formation[1].Depth = '+ Horizon1DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[1].Hardness = '+ Horizon1HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[1].FP = '+ Horizon1FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[2].Depth = '+ Horizon2DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[2].Hardness = '+ Horizon2HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[2].FP = '+ Horizon2FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[3].Depth = '+ Horizon3DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[3].Hardness = '+ Horizon3HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[3].FP = '+ Horizon3FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[4].Depth = '+ Horizon4DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[4].Hardness = '+ Horizon4HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[4].FP = '+ Horizon4FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[5].Depth = '+ Horizon5DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[5].Hardness = '+ Horizon5HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[5].FP = '+ Horizon5FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[6].Depth = '+ Horizon6DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[6].Hardness = '+ Horizon6HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[6].FP = '+ Horizon6FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[7].Depth = '+ Horizon7DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[7].Hardness = '+ Horizon7HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[7].FP = '+ Horizon7FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[8].Depth = '+ Horizon8DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[8].Hardness = '+ Horizon8HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[8].FP = '+ Horizon8FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[9].Depth = '+ Horizon9DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[9].Hardness = '+ Horizon9HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[9].FP = '+ Horizon9FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  StringToMemo('FormGeologyData.Save: Data.Formation[10].Depth = '+ Horizon10DepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[10].Hardness = '+ Horizon10HardnessData.Text );              { displayed hardness - dimensionless }
  StringToMemo('FormGeologyTestData.Save: Data.Formation[10].FP = '+ Horizon10FormationPressureData.Text + ' ' + UoMLabel[3]);  { displayed pressure }

  Edited:=True;
  Close;
end;


end.

