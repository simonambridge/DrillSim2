unit FormWellTestData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;

type

  { TWellTestDataForm }

  TWellTestDataForm = class(TForm)
    LastLeakOffEMWUoMLabel: TLabel;
    LastLeakOffEMWData: TEdit;
    LastLeakOffEMWLabel: TLabel;
    LastLeakOffDepthUoMLabel: TLabel;
    LastLeakOffDepthData: TEdit;
    LastLeakOffDepthLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    LastLeakOffPressureUoMLabel: TLabel;
    CasingBurstPressureUoMLabel: TLabel;
    LastLeakOffPressureData: TEdit;
    CasingBurstPressureData: TEdit;
    LastLeakOffPressureLabel: TLabel;
    CasingBurstPressureLabel: TLabel;
    LastLeakOffMWUoMLabel: TLabel;
    LastLeakOffMWData: TEdit;
    LastLeakOffMWLabel: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure LastLeakOffDepthDataChange(Sender: TObject);
    procedure LastLeakOffMWDataChange(Sender: TObject);
    procedure LastLeakOffEMWDataChange(Sender: TObject);
    procedure LastLeakOffPressureDataChange(Sender: TObject);
    procedure CasingBurstPressureDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  WellTestDataForm: TWellTestDataForm;
  _WellLotTD                       : real;
  _WellLotEMW                      : real;
  _WellLotMW                       : real;
  _WellLotPressure                 : real;
  _WellCasingBurstPressure         : real;

implementation

{$R *.lfm}

{ TWellTestDataForm }

{ ------------- Edit Procedures ------------ }

procedure TWellTestDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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

procedure TWellTestDataForm.LastLeakOffDepthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellLotTD:=Round2(StrToFloat(LastLeakOffDepthData.Text)/UoMConverter[1],2); { to API depth }
end;

procedure TWellTestDataForm.LastLeakOffMWDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellLotMW:=Round2(StrToFloat(LastLeakOffMWData.Text)/UoMConverter[2],2); { to API specific gravity }
end;

procedure TWellTestDataForm.LastLeakOffEMWDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellLotEMW:=Round2(StrToFloat(LastLeakOffEMWData.Text)/UoMConverter[2],2); { to API specific gravity }
end;

procedure TWellTestDataForm.LastLeakOffPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellLotPressure:=Round2(StrToFloat(LastLeakOffPressureData.Text)/UoMConverter[3],2); { to API pressure }
end;

procedure TWellTestDataForm.CasingBurstPressureDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellCasingBurstPressure:=Round2(StrToFloat(CasingBurstPressureData.Text)/UoMConverter[3],2); { to API pressure }
end;


{ ------------------ Form procedures ---------------------- }

procedure TWellTestDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form Well Test Data activated...........................');

  // units of measure labels

  LastLeakOffDepthUoMLabel.Caption:=UoMLabel[1];        { depth }
  LastLeakOffMWUoMLabel.Caption:=UoMLabel[2];           { specific gravity }
  LastLeakOffEMWUoMLabel.Caption:=UoMLabel[2];          { specific gravity }
  LastLeakOffPressureUoMLabel.Caption:=UoMLabel[3];     { pressure }
  CasingBurstPressureUoMLabel.Caption:=UoMLabel[3];     { pressure }

  // data
  _WellLotTD              :=Data.LotTD;
  _WellLotMW              :=Data.LotMW;
  _WellLotEMW             :=Data.LotEMW;
  _WellLOTPressure        :=Data.LOTPressure;
  _WellCasingBurstPressure:=Data.CasingBurstPressure;

  StringToMemo('setup done');

  LastLeakOffDepthData.Text:=FloatToStr(Round2(Data.LotTD*UoMConverter[1],2));                       { depth }

  LastLeakOffMWData.Text:=FloatToStr(Round2(Data.LotMW*UoMConverter[2],2));                          { specific gravity }
  LastLeakOffEMWData.Text:=FloatToStr(Round2(Data.LotEMW*UoMConverter[2],2));                        { specific gravity }
  LastLeakOffPressureData.Text:=FloatToStr(Round2(Data.LotPressure*UoMConverter[3],2));              { pressure }
  CasingBurstPressureData.Text:=FloatToStr(Round2(Data.CasingBurstPressure*UoMConverter[3],2));      { pressure }

end;

procedure TWellTestDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormTestData : TWellTestDataForm.FormCreate');

end;

procedure TWellTestDataForm.FormDeactivate(Sender: TObject);
begin{ Also called on QuitButton }
    StringToMemo('FormWellTestData.Deactivate ........................................');
end;

procedure TWellTestDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormWellTestData.Quit ..............................................');
  Close;
end;

procedure TWellTestDataForm.SaveButtonClick(Sender: TObject);
begin
  StringToMemo('FormWellTestData.Save ..............................................');

  if (_WellLotTD <= 0) then                                                      { length cannot be zero }
  Begin
    ShowMessage('Leak off test depth must be greater than zero');
    StringToMemo('FormHoleData.Save: Error: Leak off test depth must be greater than zero');
    LastLeakOffDepthData.SetFocus;
    Exit;
  end else
  Begin
    Data.LotTD:=_WellLotTD;   { API depth }
    StringToMemo('FormWellTestData.Save: Data.LotTD = '+ LastLeakOffDepthData.Text + ' ' + UoMLabel[1]); { displayed depth }
  end;

  if (_WellLotMW <= 0) then                                                    { mw cannot be zero }
  Begin
    ShowMessage('Leak off test mud weight must be greater than zero');
    StringToMemo('FormHoleData.Save: Error: Leak off test mud weight must be greater than zero');
    LastLeakOffMWData.SetFocus;
    Exit;
  end else
  Begin
    Data.LotMW:=_WellLotMW;   { API specific gravity}
    StringToMemo('FormWellTestData.Save: Data.LotMW = '+ LastLeakOffMWData.Text + ' ' + UoMLabel[2]); { displayed specific gravity }
  end;

  if (_WellLotEMW <= 0) then                                                    { emw cannot be zero }
  Begin
    ShowMessage('Leak off test equivalent mud weight must be greater than zero');
    StringToMemo('FormHoleData.Save: Error: Leak off test equivalent mud weight must be greater than zero');
    LastLeakOffEMWData.SetFocus;
    Exit;
  end else
  Begin
    Data.LotEMW:=_WellLotEMW;   { API specific gravity}
    StringToMemo('FormWellTestData.Save: Data.LotEMW = '+ LastLeakOffEMWData.Text + ' ' + UoMLabel[2]); { displayed specific gravity }
  end;

  if (_WellLotPressure <= 0) then                                                    { lot pressure cannot be zero }
  Begin
    ShowMessage('Leak off test pressure must be greater than zero');
    StringToMemo('FormHoleData.Save: Error: Leak off test pressure must be greater than zero');
    LastLeakOffPressureData.SetFocus;
    Exit;
  end else
  Begin
    Data.LotPressure:=_WellLotPressure;   { API pressure}
    StringToMemo('FormWellTestData.Save: Data.LotPressure = '+ LastLeakOffPressureData.Text + ' ' + UoMLabel[2]); { displayed pressure }
  end;


  if (_WellCasingBurstPressure <= 0) then                                                    { lot pressure cannot be zero }
  Begin
    ShowMessage('Casing burst pressure must be greater than zero');
    StringToMemo('FormHoleData.Save: Error: Csing burst pressure must be greater than zero');
    CasingBurstPressureData.SetFocus;
    Exit;
  end else
  Begin
    Data.CasingBurstPressure:=_WellCasingBurstPressure;   { API pressure}
    StringToMemo('FormWellTestData.Save: Data.CasingBurstPressure = '+ CasingBurstPressureData.Text + ' ' + UoMLabel[2]); { displayed pressure }
  end;

  StringToMemo('FormWellTestData.Save: Data.LotTD = '+ LastLeakOffDepthData.Text + ' ' + UoMLabel[1]);     { displayed depth }
  StringToMemo('FormWellTestData.Save: Data.LotMW = '+ LastLeakOffMWData.Text + ' ' + UoMLabel[2]);         { displayed specific gravity }
  StringToMemo('FormWellTestData.Save: Data.LotEMW = '+ LastLeakOffEMWData.Text + ' ' + UoMLabel[2]);         { displayed specific gravity }
  StringToMemo('FormWellTestData.Save: Data.LotPressure = '+ LastLeakOffPressureData.Text + ' ' + UoMLabel[3]);         { displayed pressure }
  StringToMemo('FormWellTestData.Save: Data.CasingBurstPressure = '+ CasingBurstPressureData.Text + ' ' + UoMLabel[3]);         { displayed pressure }

  Edited:=True;
  Close;
end;



end.

