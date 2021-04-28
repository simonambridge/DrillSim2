unit FormMudData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;

type

  { TMudDataForm }

  TMudDataForm = class(TForm)
    MudYPData: TEdit;
    MudGelData: TEdit;
    MudYPLabel: TLabel;
    MudGelLabel: TLabel;
    MudYPUoMLabel: TLabel;
    MudWeightData: TEdit;
    MudPVData: TEdit;
    MudWeightLabel: TLabel;
    MudPVLabel: TLabel;
    MudWeightUoMLabel: TLabel;
    MudPVUoMLabel: TLabel;
    MudGelUoMLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure MudGelDataChange(Sender: TObject);
    procedure MudPVDataChange(Sender: TObject);
    procedure MudWeightDataChange(Sender: TObject);
    procedure MudYPDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MudDataForm: TMudDataForm;
  _WellMudWt            : real;
  _WellMudYP            : real;
  _WellMudPV            : real;
  _WellMudGel           : real;

implementation

{$R *.lfm}

{ TMudDataForm }

{ ------------- Edit Procedures ------------ }

procedure TMudDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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


procedure TMudDataForm.MudWeightDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellMudWt:=Round2(StrToFloat(MudWeightData.Text), 2);
end;

procedure TMudDataForm.MudYPDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellMudYP:=Round2(StrToFloat(MudYPData.Text), 2);
end;

procedure TMudDataForm.MudPVDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellMudPV:=Round2(StrToFloat(MudPVData.Text), 2);
end;

procedure TMudDataForm.MudGelDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellMudGel:=Round2(StrToFloat(MudGelData.Text), 2);
end;


{ ------------------ Form procedures ---------------------- }

procedure TMudDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form Mud Data activated...........................');

  // units of measure labels

  MudWeightUoMLabel.Caption:=UoMLabel[2]; { mud weight }

  // data

  MudWeightData.Text:=FloatToStr(Round2(Data.MudWt*UoMConverter[2],3));  { API->user depth }
  MudYPData.Text:=FloatToStr(Round2(Data.MudYP,3));    { no conversion req'd }
  MudPVData.Text:=FloatToStr(Round2(Data.MudPV,3));    { no conversion req'd }
  MudGelData.Text:=FloatToStr(Round2(Data.MudGel,3));  { no conversion req'd }

end;

procedure TMudDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormMudData : TMudDataForm.FormCreate');

end;

procedure TMudDataForm.FormDeactivate(Sender: TObject);
begin{ Also called on QuitButton }
    StringToMemo('FormMudData.Deactivate ........................................');
end;

procedure TMudDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormMudData.Quit ..............................................');
  Close;
end;

procedure TMudDataForm.SaveButtonClick(Sender: TObject);
Begin

  StringToMemo('FormMudData.Save ..............................................');

  Data.MudWt  :=_WellMudWt;     { API mud weight }
  if _WellMudWt<>0
          then Data.MudWt:=_WellMudWt
          else
            Begin
              ShowMessage('Mud Weight cannot be 0');
              StringToMemo('FormMudData.Save: Error: Mud Weight cannot be 0');
              MudWeightData.SetFocus;
              Exit;
            end;
  if _WellMudPV<>0
          then Data.MudPV:=_WellMudPV
          else
            Begin
              ShowMessage('Mud Plastic Viscosity cannot be 0');
              StringToMemo('FormMudData.Save: Error: Mud Plastic Viscosity cannot be 0');
              MudPVData.SetFocus;
              Exit;
            end;
  if _WellMudYP<>0
          then Data.MudYP:=_WellMudYP
          else
            Begin
              ShowMessage('Mud Yield Point cannot be 0');
              StringToMemo('FormMudData.Save: Error: Mud Yield Point cannot be 0');
              MudYPData.SetFocus;
              Exit;
            end;
  if _WellMudGel<>0
          then Data.MudGel:=_WellMudGel
          else
            Begin
              ShowMessage('Mud Gel Strength cannot be 0');
              StringToMemo('FormMudData.Save: Error: Mud Gel Strength cannot be 0');
              MudGelData.SetFocus;
              Exit;
            end;

  StringToMemo('FormMudData.Save: Data.MudWt = ' + MudWeightData.Text + ' ' + UoMLabel[2]);  { Displayed mud wt }
  StringToMemo('FormMudData.Save: Data.MudYP = ' + MudYPData.Text + ' centipoise');
  StringToMemo('FormMudData.Save: Data.MudPV = ' + MudPVData.Text + ' Lbs 100foot2');
  StringToMemo('FormMudData.Save: Data.MudGel = '+ MudGelData.Text);

  Edited:=True;
  Close;
end;

end.

