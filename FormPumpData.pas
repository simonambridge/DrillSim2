unit FormPumpData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;


type

  { TPumpDataForm }

  TPumpDataForm = class(TForm)
    MaxPumpPressureUoMLabel: TLabel;
    Pump1EfficiencyData: TEdit;
    MaxPumpPressureData: TEdit;
    MaxPumpPressureLabel: TLabel;
    Pump1Label: TLabel;
    Pump1OutputData: TEdit;
    Pump3EfficiencyData: TEdit;
    Pump3Label: TLabel;
    Pump3OutputData: TEdit;
    Pump2EfficiencyData: TEdit;
    Pump2Label: TLabel;
    Pump2OutputData: TEdit;
    EfficiencyColumnLabel: TLabel;
    OutputColumnLabel: TLabel;
    NumPumps: TLabel;
    NumPumpsComboBox: TComboBox;
    OutputUoMLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure MaxPumpPressureDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure NumPumpsComboBoxChange(Sender: TObject);
    procedure Pump1EfficiencyDataChange(Sender: TObject);
    procedure Pump1OutputDataChange(Sender: TObject);
    procedure Pump2EfficiencyDataChange(Sender: TObject);
    procedure Pump2OutputDataChange(Sender: TObject);
    procedure Pump3EfficiencyDataChange(Sender: TObject);
    procedure Pump3OutputDataChange(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  PumpDataForm: TPumpDataForm;
  _WellMaxPumps : Integer;
  _WellPump : array [1..3,1..2] of real;  { not using 3rd element - SPM - here so only 1..2 }
  _WellMaxPumpPressure : real;

implementation

{$R *.lfm}

{ TPumpDataForm }

{ ------------- Edit Procedures ------------ }

procedure TPumpDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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


procedure TPumpDataForm.NumPumpsComboBoxChange(Sender: TObject);
begin
  case NumPumpsComboBox.ItemIndex of
    0: Begin
         _WellMaxPumps:=1;
         Pump1OutPutData.Enabled:=True;
         Pump1EfficiencyData.Enabled:=True;

         Pump2OutPutData.Enabled:=False;
         Pump2EfficiencyData.Enabled:=False;

         Pump3OutPutData.Enabled:=False;
         Pump3EfficiencyData.Enabled:=False;
       end;

    1: Begin
         _WellMaxPumps:=2;
         Pump1OutPutData.Enabled:=True;
         Pump1EfficiencyData.Enabled:=True;

         Pump2OutPutData.Enabled:=True;
         Pump2EfficiencyData.Enabled:=True;

         Pump3OutPutData.Enabled:=False;
         Pump3EfficiencyData.Enabled:=False;
       end;

    2: Begin
         _WellMaxPumps:=3;
         Pump1OutPutData.Enabled:=True;
         Pump1EfficiencyData.Enabled:=True;

         Pump2OutPutData.Enabled:=True;
         Pump2EfficiencyData.Enabled:=True;

         Pump3OutPutData.Enabled:=True;
         Pump3EfficiencyData.Enabled:=True;
       end;
  end;
end;

procedure TPumpDataForm.Pump1OutputDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[1,1]:=Round2(StrToFloat(Pump1OutputData.Text)/UoMConverter[5],2); { User gals or litres ->API volume gals }
end;

procedure TPumpDataForm.Pump1EfficiencyDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[1,2]:=Round2(StrToFloat(Pump1EfficiencyData.Text),2); { % }
end;

procedure TPumpDataForm.Pump2OutputDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[2,1]:=Round2(StrToFloat(Pump2OutputData.Text)/UoMConverter[5],2); { User gals or litres ->API volume gals }
end;

procedure TPumpDataForm.Pump2EfficiencyDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[2,2]:=Round2(StrToFloat(Pump2EfficiencyData.Text),2); { % }
end;

procedure TPumpDataForm.Pump3OutputDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[3,1]:=Round2(StrToFloat(Pump3OutputData.Text)/UoMConverter[5],2); { User gals or litres ->API volume gals }
end;

procedure TPumpDataForm.Pump3EfficiencyDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPump[3,2]:=Round2(StrToFloat(Pump3EfficiencyData.Text),2); { % }
end;

procedure TPumpDataForm.MaxPumpPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellMaxPumpPressure:=Round2(StrToFloat(MaxPumpPressureData.Text)/UoMConverter[3],2); { User psi or KPa ->API psi }
end;





{ ------------------ Form procedures ---------------------- }

procedure TPumpDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form Pump Data activated...........................');

  // units of measure labels

  OutputUoMLabel.Caption:='('+ UoMLabel[5] + ')';
  MaxPumpPressureUoMLabel.Caption:=UoMLabel[3];

  // data

  _WellMaxPumps:=Data.MaxPumps;
  case Data.MaxPumps of
    1: Begin
         NumPumpsComboBox.ItemIndex:=0;

         Pump1OutputData.Enabled:=True;
         Pump1OutputData.Text:=FloatToStr(Round2(Data.Pump[1,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[1,1]:=Data.Pump[1,1]; { API internal }

         Pump1EfficiencyData.Enabled:=True;
         Pump1EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[1,2],3));  { % }
         _WellPump[1,2]:=Data.Pump[1,2]; {API internal }

         Pump2OutputData.Enabled:=False;
         Pump2OutputData.Text:=FloatToStr(Round2(Data.Pump[2,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[2,1]:=Data.Pump[2,1]; { API internal }

         Pump2EfficiencyData.Enabled:=False;
         Pump2EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[2,2],3));  { % }
         _WellPump[2,2]:=Data.Pump[2,2]; {API internal }

         Pump3OutputData.Enabled:=False;
         Pump3OutputData.Text:=FloatToStr(Round2(Data.Pump[3,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[3,1]:=Data.Pump[3,1]; { API internal }

         Pump3EfficiencyData.Enabled:=False;
         Pump3EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[3,2],3));  { % }
         _WellPump[3,2]:=Data.Pump[3,2]; {API internal }

        end;

    2: Begin
         NumPumpsComboBox.ItemIndex:=1;

         Pump1OutputData.Enabled:=True;
         Pump1OutputData.Text:=FloatToStr(Round2(Data.Pump[1,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[1,1]:=Data.Pump[1,1]; { API internal }

         Pump1EfficiencyData.Enabled:=True;
         Pump1EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[1,2],3));  { % }
         _WellPump[1,2]:=Data.Pump[1,2]; {API internal }

         Pump2OutputData.Enabled:=True;
         Pump2OutputData.Text:=FloatToStr(Round2(Data.Pump[2,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[2,1]:=Data.Pump[2,1]; { API internal }

         Pump2EfficiencyData.Enabled:=True;
         Pump2EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[2,2],3));  { % }
         _WellPump[2,2]:=Data.Pump[2,2]; {API internal }

         Pump3OutputData.Enabled:=False;
         Pump3OutputData.Text:=FloatToStr(Round2(Data.Pump[3,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[3,1]:=Data.Pump[3,1]; { API internal }

         Pump3EfficiencyData.Enabled:=False;
         Pump3EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[3,2],3));  { % }
         _WellPump[3,2]:=Data.Pump[3,2]; {API internal }

       end;

    3: Begin
         NumPumpsComboBox.ItemIndex:=2;

         Pump1OutputData.Enabled:=True;
         Pump1OutputData.Text:=FloatToStr(Round2(Data.Pump[1,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[1,1]:=Data.Pump[1,1]; { API internal }

         Pump1EfficiencyData.Enabled:=True;
         Pump1EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[1,2],3));  { % }
         _WellPump[1,2]:=Data.Pump[1,2]; {API internal }


         Pump2OutputData.Enabled:=True;
         Pump2OutputData.Text:=FloatToStr(Round2(Data.Pump[2,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[2,1]:=Data.Pump[2,1]; { API internal }

         Pump2EfficiencyData.Enabled:=True;
         Pump2EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[2,2],3));  { % }
         _WellPump[2,2]:=Data.Pump[2,2]; {API internal }


         Pump3OutputData.Enabled:=True;
         Pump3OutputData.Text:=FloatToStr(Round2(Data.Pump[3,1]*UoMConverter[5],2));  { API->user volume }
         _WellPump[3,1]:=Data.Pump[3,1]; { API internal }

         Pump3EfficiencyData.Enabled:=True;
         Pump3EfficiencyData.Text:=FloatToStr(Round2(Data.Pump[3,2],3));  { % }
         _WellPump[3,2]:=Data.Pump[3,2]; {API internal }

       end;
  end;
  MaxPumpPressureData.Text:=FloatToStr(Round2(Data.MaxPumpPressure*UoMConverter[3],2));  { API->user pressure }
  _WellMaxPumpPressure:=Data.MaxPumpPressure; {API internal }

end;

procedure TPumpDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormPumpData : TPumpDataForm.FormCreate');

end;

procedure TPumpDataForm.FormDeactivate(Sender: TObject);
begin     { Also called on QuitButton }
  StringToMemo('FormPumpData.Deactivate ........................................');
end;

procedure TPumpDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormPumpData.Quit ..............................................');
  Close;
end;

procedure TPumpDataForm.SaveButtonClick(Sender: TObject);
var
    i : integer;
    Error : boolean;
begin

  Error:=True;

  For i:=1 to _WellMaxPumps do
  Begin
    if _WellPump[i,1]>0
    then
    Begin
      Error:=False;     { OK if at least one pump is valid }
    End else _WellPump[i,1]:=0;  { and force it to 0 in case its minus }

    if _WellPump[i,1]=0 then  { but if defined, a pump cannot be invalid }
    Begin
        ShowMessage('Pump output cannot be zero');
        StringToMemo('FormPumpData.Save: Error: Pump output cannot be zero');
        if i=1 then Pump1OutputData.SetFocus
        else if i=2 then Pump2OutputData.SetFocus
        else if i=3 then Pump3OutputData.SetFocus;
        Exit;
    end;
    if (_WellPump[i,2] = 0) { and efficiency rating must be valid }
    then
    Begin
        ShowMessage('Pump efficiency must be defined correctly');
        StringToMemo('FormPumpData.Save: Error: Pump efficiency must be defined correctly');

        if i=1 then Pump1EfficiencyData.SetFocus
        else if i=2 then Pump2EfficiencyData.SetFocus
        else if i=3 then Pump3EfficiencyData.SetFocus;
        Exit;
    end;
    Data.Pump[i,1]:=_WellPump[i,1];
    Data.Pump[i,2]:=_WellPump[i,2];
  end;

  if Error=True then
  Begin
    ShowMessage('At least one of the pumps must be defined correctly');
    StringToMemo('FormPumpData.Save: Error: At least one of the pumps must be defined correctly');
    Pump1OutputData.SetFocus;
    Exit;
  end;

  if _WellMaxPumpPressure > 0
    then Data.MaxPumpPressure:=_WellMaxPumpPressure
    else
  Begin
    ShowMessage('Maximum pump pressure must be defined');
    StringToMemo('FormPumpData.Save: Error: Maximum pump pressure must be defined');
    MaxPumpPressureData.SetFocus;
    Exit;
  end;

  Data.MaxPumps:=_WellMaxPumps;

  For i:=1 to Data.MaxPumps do
  Begin
    StringToMemo('FormPumpData.Save: Data.Pump[' + IntToStr(i) + '] output = ' +  FloatToStr(Data.Pump[i,1]) + ' ' + UoMLabel[5]); { displayed pump volume }
    StringToMemo('FormPumpData.Save: Data.Pump[' + IntToStr(i) + '] efficiency = ' +  FloatToStr(Data.Pump[i,2]) + ' %'); { eff % }
  end;

  StringToMemo('FormPumpata.Save: Data.MaxPumpPressure = '+ MaxPumpPressureData.Text + ' ' + UoMLabel[3]); { displayed pressure }

  Edited:=True;
  Close;
end;

end.

