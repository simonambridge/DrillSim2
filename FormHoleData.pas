unit FormHoleData;

{$mode objfpc}{$H+}
interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;

type
  { THoleDataForm }
  THoleDataForm = class(TForm)
    Riser: TCheckBox;
    SubSeaWellHead: TCheckBox;
    OffshoreYN: TCheckBox;
    CasingYNRadioGroup: TRadioGroup;
    CashingShoeDepth: TLabel;
    CasingShoeDepthData: TEdit;
    CasingShoeDepthUoMLabel: TLabel;
    CasingID: TLabel;
    CasingIDData: TEdit;
    CasingIDUoMLabel: TLabel;
    LinerYNRadioGroup: TRadioGroup;
    LinerTopDepthUoMLabel: TLabel;
    LinerBottomDepthUoMLabel: TLabel;
    LinerTopDepth: TLabel;
    LinerTopDepthData: TEdit;
    LinerBottomDepth: TLabel;
    LinerBottomDepthData: TEdit;
    LinerID: TLabel;
    LinerIDUoMLabel: TLabel;
    LinerIDData: TEdit;
    Deviation: TLabel;
    DeviationData: TEdit;
    DeviationUoM: TLabel;
    NumOHSections: TLabel;
    NumOHSectionsComboBox: TComboBox;
    TDColumnLabel: TLabel;
    IDColumnLabel: TLabel;
    OHIDUoMLabel: TLabel;
    OHTDUoMLabel: TLabel;
    OHSection1: TLabel;
    OHSection1TDData: TEdit;
    OHSection1IDData: TEdit;
    OHSection2: TLabel;
    OHSection2IDData: TEdit;
    OHSection2TDData: TEdit;
    OHSection3: TLabel;
    OHSection3TDData: TEdit;
    OHSection3IDData: TEdit;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure CasingIDDataChange(Sender: TObject);
    procedure CasingShoeDepthDataChange(Sender: TObject);
    procedure CasingYNRadioGroupClick(Sender: TObject);
    procedure DeviationDataChange(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure LinerBottomDepthDataChange(Sender: TObject);
    procedure LinerIDDataChange(Sender: TObject);
    procedure LinerTopDepthDataChange(Sender: TObject);
    procedure LinerYNRadioGroupClick(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: char);
    procedure NumOHSectionsComboBoxChange(Sender: TObject);
    procedure OHSection1IDDataChange(Sender: TObject);
    procedure OHSection1TDDataChange(Sender: TObject);
    procedure OHSection2IDDataChange(Sender: TObject);
    procedure OHSection2TDDataChange(Sender: TObject);
    procedure OHSection3IDDataChange(Sender: TObject);
    procedure OHSection3TDDataChange(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  i: integer;
  HoleDataForm: THoleDataForm;
  _WellCasing: boolean;
  _WellCasingTD: real;
  _WellCasingID: real;
  _WellLiner: boolean;
  _WellLinerTopTD: real;
  _WellLinerBottomTD: real;
  _WellLinerID: real;
  _WellMaxHoles: integer;
  _WellHole: array[1..3, 1..3] of real;
  _WellDeviation: real;

implementation

      {$R *.lfm}
{ ------------- Edit Procedures ------------ }

procedure THoleDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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



procedure THoleDataForm.CasingYNRadioGroupClick(Sender: TObject);
begin
  case CasingYNRadioGroup.ItemIndex of
    0:
    begin
      _WellCasing := False; { there is no casing... }
      CasingYNRadioGroup.ItemIndex := 0;
      CasingShoeDepthData.Enabled := False;
      //CasingShoeDepthData.Text:=FloatToStr(0); { depth }
      CasingIDData.Enabled := False;
      //CasingIDData.Text:=FloatToStr(0); { inches }
      _WellLiner := False; { ...so there can be no liner either }
      LinerYNRadioGroup.ItemIndex := 0;
      LinerYNRadioGroup.Enabled := False;
      LinerTopDepthData.Enabled := False;
      //LinerTopDepthData.Text:=FloatToStr(0); { depth }
      LinerBottomDepthData.Enabled := False;
      //LinerBottomDepthData.Text:=FloatToStr(0); { depth }
      LinerIDData.Enabled := False;
      //LinerIDData.Text:=FloatToStr(0); { inches }
    end;
    1:
    begin
      _WellCasing := True; { there is casing... }
      CasingYNRadioGroup.ItemIndex := 1;
      LinerYNRadioGroup.Enabled := True;
      CasingShoeDepthData.Enabled := True;
      CasingShoeDepthData.Text := FloatToStr(Round2(Data.CasingTD * UoMConverter[1], 2)); { depth }
      CasingIDData.Enabled := True;
      CasingIDData.Text := FloatToStr(Data.CasingID * UoMConverter[8]); { inches }
    end;
  end;
end;

procedure THoleDataForm.LinerYNRadioGroupClick(Sender: TObject);
begin
  case LinerYNRadioGroup.ItemIndex of
    0:
    begin
      _WellLiner := False; { there is no Liner }
      LinerYNRadioGroup.ItemIndex := 0;
      LinerTopDepthData.Enabled := False;
      //LinerTopDepthData.Text:=FloatToStr(0); { depth }
      LinerBottomDepthData.Enabled := False;
      //LinerBottomDepthData.Text:=FloatToStr(0); { depth }
      LinerIDData.Enabled := False;
      //LinerIDData.Text:=FloatToStr(0); { inches }
    end;
    1:
    begin
      _WellLiner := True; { there is a Liner }
      LinerYNRadioGroup.ItemIndex := 1;
      LinerTopDepthData.Enabled := True;
      //LinerTopDepthData.Text:=FloatToStr(Round2(Data.LinerTopTD*UoMConverter[1],2)); { depth }
      LinerBottomDepthData.Enabled := True;
      //LinerBottomDepthData.Text:=FloatToStr(Round2(Data.LinerBottomTD*UoMConverter[1],2)); { depth }
      LinerIDData.Enabled := True;
      //LinerIDData.Text:=FloatToStr(Data.LinerID*UoMConverter[8]); { inches }
    end;
  end;
end;

procedure THoleDataForm.NumOHSectionsComboBoxChange(Sender: TObject);
begin
  case NumOHSectionsComboBox.ItemIndex of
    0:
    begin
      _WellMaxHoles := 0; { nothing in the OH depth boxes }
      OHSection1TDData.Enabled := False;
      OHSection1IDData.Enabled := False;
      //OHSection1TDData.Text:=FloatToStr(0); { user depth }
      //OHSection1TDData.Text:=FloatToStr(0); { inches }

      OHSection2TDData.Enabled := False;
      OHSection2IDData.Enabled := False;
      //OHSection2TDData.Text:=FloatToStr(0); { user depth }
      //OHSection2TDData.Text:=FloatToStr(0); { inches }

      OHSection3TDData.Enabled := False;
      OHSection3IDData.Enabled := False;
      //OHSection3TDData.Text:=FloatToStr(0); { user depth }
      //OHSection3TDData.Text:=FloatToStr(0); { inches }
    end;
    1:
    begin
      _WellMaxHoles := 1;
      OHSection1TDData.Enabled := True; { just the first OH displayed }
      OHSection1IDData.Enabled := True;
      //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2)); { API->user depth }
      //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],4)); { inches }

      OHSection2TDData.Enabled := False;
      OHSection2IDData.Enabled := False;
      //OHSection2TDData.Text:=FloatToStr(0); { user depth }
      //OHSection2TDData.Text:=FloatToStr(0); { inches }

      OHSection3TDData.Enabled := False;
      OHSection3IDData.Enabled := False;
      //OHSection3TDData.Text:=FloatToStr(0); { user depth }
      //OHSection3TDData.Text:=FloatToStr(0); { inches }
    end;
    2:
    begin
      _WellMaxHoles := 2;
      OHSection1TDData.Enabled := True; { display the first and second OH }
      OHSection1IDData.Enabled := True;
      //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2)); { API->user depth }
      //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],4)); { inches }

      OHSection2TDData.Enabled := True;
      OHSection2IDData.Enabled := True;
      //OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2)); { API->user depth }
      //OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],4)); { inches }

      OHSection3TDData.Enabled := False;
      OHSection3IDData.Enabled := False;
      //OHSection3TDData.Text:=FloatToStr(0); { user depth }
      //OHSection3TDData.Text:=FloatToStr(0); { inches }
    end;
    3:
    begin
      _WellMaxHoles := 3;
      OHSection1TDData.Enabled := True; { All OH data displayed }
      OHSection1IDData.Enabled := True;
      //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2)); { API->user depth }
      //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],4)); { inches }

      OHSection2TDData.Enabled := True;
      OHSection2IDData.Enabled := True;
      //OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2)); { API->user depth }
      //OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],4)); { inches }

      OHSection3TDData.Enabled := True;
      OHSection3IDData.Enabled := True;
      //OHSection3TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2)); { API->user depth }
      //OHSection3TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],4)); { inches }
    end;
  end;
end;

procedure THoleDataForm.CasingShoeDepthDataChange(Sender: TObject);
{ set _WellCasingTD with API value }
begin
  if not ((TEdit(Sender).Text = '-')
     or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
     or (TEdit(Sender).Text = ''))
  then _WellCasingTD := Round2(StrToFloat(CasingShoeDepthData.Text) / UoMConverter[1], 2);
  { User->API depth }
end;

procedure THoleDataForm.CasingIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellCasingID := Round2(StrToFloat(CasingIDData.Text) / UoMConverter[8], 4); { inches }
end;

procedure THoleDataForm.LinerTopDepthDataChange(Sender: TObject);
{ set _WellLinerTopTD with API value }
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellLinerTopTD := Round2(StrToFloat(LinerTopDepthData.Text) / UoMConverter[1], 2);
  { User->API depth }
end;

procedure THoleDataForm.LinerBottomDepthDataChange(Sender: TObject);
{ set _WellLinerBottomTDTD with API value }
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellLinerBottomTD := Round2(StrToFloat(LinerBottomDepthData.Text) / UoMConverter[1], 2);
  { User->API depth }
end;

procedure THoleDataForm.LinerIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
     or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
     or (TEdit(Sender).Text = ''))
  then _WellLinerID := Round2(StrToFloat(LinerIDData.Text) / UoMConverter[8], 4); { inches }
end;

procedure THoleDataForm.OHSection1TDDataChange(Sender: TObject);
{ set _WellHole[1,1] with API value }
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellHole[1, 1] := Round2(StrToFloat(OHSection1TDData.Text) / UoMConverter[1], 2);
  { User->API depth }
end;

procedure THoleDataForm.OHSection1IDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellHole[1, 2] := Round2(StrToFloat(OHSection1IDData.Text) / UoMConverter[8], 4); { inches }
end;

procedure THoleDataForm.OHSection2TDDataChange(Sender: TObject);
{ set _WellHole[2,1] with API value }
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellHole[2, 1] := Round2(StrToFloat(OHSection2TDData.Text) / UoMConverter[1], 2);
  { User->API depth }
end;

procedure THoleDataForm.OHSection2IDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellHole[2, 2] := Round2(StrToFloat(OHSection2IDData.Text) / UoMConverter[8], 4); { inches }
end;

procedure THoleDataForm.OHSection3TDDataChange(Sender: TObject);
{ set _WellHole[3,1] with API value }
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellHole[3, 1] := Round2(StrToFloat(OHSection3TDData.Text) / UoMConverter[1], 2);
  { User->API depth }
end;

procedure THoleDataForm.OHSection3IDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellHole[3, 2] := Round2(StrToFloat(OHSection3IDData.Text) / UoMConverter[8], 4); { inches }
end;

procedure THoleDataForm.DeviationDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-') or (TEdit(Sender).Text =
    DefaultFormatSettings.DecimalSeparator) or (TEdit(Sender).Text = '')) then
    _WellDeviation := Round2(StrToFloat(DeviationData.Text), 2); { degrees - no conversion }
end;

{ ------------------ Form procedures ---------------------- }
procedure THoleDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form Well Hole Profile Data activated...........................');

  // units of measure labels
  CasingShoeDepthUoMLabel.Caption := UoMLabel[1]; { user depth }
  CasingIDUoMLabel.Caption := UoMLabel[8]; { inches }
  LinerTopDepthUoMLabel.Caption := UoMLabel[1]; { user depth }
  LinerBottomDepthUoMLabel.Caption := UoMLabel[1]; { user depth }
  LinerIDUoMLabel.Caption := UoMLabel[8]; { inches }
  OHTDUoMLabel.Caption := UoMLabel[1]; { user depth }
  OHIDUoMLabel.Caption := UoMLabel[8]; { inches }

  // data
  OffshoreYN.Enabled := False;
  if Data.Offshore then
    OffshoreYN.Checked := True
  else
    OffshoreYN.Checked := False;
  SubSeaWellHead.Enabled := False;
  if Data.SubSeaWellHead then
    SubSeaWellHead.Checked := True
  else
    SubSeaWellHead.Checked := False;
  Riser.Enabled := False;
  if Data.Riser then
    Riser.Checked := True
  else
    Riser.Checked := False;
  CasingYNRadioGroup.Enabled := True;
  LinerYNRadioGroup.Enabled := True;

  if Data.Casing = True then { there is casing }
  begin
    CasingYNRadioGroup.ItemIndex := 1;
    CasingShoeDepthData.Enabled := True;
    _WellCasing:=True;

    CasingShoeDepthData.Text := FloatToStr(Round2(Data.CasingTD * UoMConverter[1], 2)); { API->user depth }
    _WellCasingTD:=Data.CasingTD;

    CasingIDData.Enabled := True;
    CasingIDData.Text := FloatToStr(Data.CasingID * UoMConverter[8]); { inches }
    _WellCasingID:=Data.CasingID;

    if Data.Liner = True { is there a liner with this casing? } then
    begin
      LinerYNRadioGroup.ItemIndex := 1;
      LinerYNRadioGroup.Enabled := True;
      _WellLiner:=True;

      LinerTopDepthData.Enabled := True;
      LinerTopDepthData.Text := FloatToStr(Round2(Data.LinerTopTD * UoMConverter[1], 2));      { API->user depth }
      _WellLinerTopTD:=Data.LinerTopTD;

      LinerBottomDepthData.Enabled := True;
      LinerBottomDepthData.Text := FloatToStr(Round2(Data.LinerBottomTD * UoMConverter[1], 2));      { API->user depth }
      _WellLinerBottomTD:=Data.LinerBottomTD;

      LinerIDData.Enabled := True;
      LinerIDData.Text := FloatToStr(Data.LinerID * UoMConverter[8]); { inches }
      _WellLinerID:=Data.LinerID;
    end
    else
    begin { there is no liner with this casing }
      LinerYNRadioGroup.ItemIndex := 0;
      LinerTopDepthData.Enabled := False;
      LinerTopDepthData.Text := FloatToStr(0); { user depth }
      LinerBottomDepthData.Enabled := False;
      LinerBottomDepthData.Text := FloatToStr(0); { user depth }
      LinerIDData.Enabled := False;
      LinerIDData.Text := FloatToStr(0); { inches }
    end;
  end
  else { there is no casing...so no liner either }
  begin
    CasingYNRadioGroup.ItemIndex := 0;
    CasingShoeDepthData.Enabled := False;
    CasingShoeDepthData.Text := FloatToStr(0); { user depth }
    CasingIDData.Enabled := False;
    CasingIDData.Text := FloatToStr(0); { inches }
    { ...so there can be no liner }
    LinerYNRadioGroup.ItemIndex := 0;
    LinerYNRadioGroup.Enabled := False;
    LinerTopDepthData.Enabled := False;
    LinerTopDepthData.Text := FloatToStr(0); { user depth }
    LinerBottomDepthData.Enabled := False;
    LinerBottomDepthData.Text := FloatToStr(0); { user depth }
    LinerIDData.Enabled := False;
    LinerIDData.Text := FloatToStr(0); { inches }
  end;
  _WellMaxHoles := Data.MaxHoles;
  case Data.MaxHoles of
    0:
    begin
      NumOHSectionsComboBox.ItemIndex := 0;
      OHSection1TDData.Enabled := False;
      OHSection1IDData.Enabled := False;
      //OHSection1TDData.Text:=FloatToStr(0); { user depth }
      //OHSection1TDData.Text:=FloatToStr(0); { inches }

      OHSection2TDData.Enabled := False;
      OHSection2IDData.Enabled := False;
      //OHSection2TDData.Text:=FloatToStr(0); { user depth }
      //OHSection2TDData.Text:=FloatToStr(0); { inches }

      OHSection3TDData.Enabled := False;
      OHSection3IDData.Enabled := False;
      //OHSection3TDData.Text:=FloatToStr(0); { user depth }
      //OHSection3TDData.Text:=FloatToStr(0); { inches }
    end;
    1:
    begin
      NumOHSectionsComboBox.ItemIndex := 1;
      OHSection1TDData.Enabled := True;
      OHSection1TDData.Text := FloatToStr(Round2(Data.Hole[1, 1] * UoMConverter[1], 2));      { API->user depth }
      OHSection1IDData.Enabled := True;
      OHSection1IDData.Text := FloatToStr(Round2(Data.Hole[1, 2] * UoMConverter[8], 4)); { inches }
      _WellHole[1, 1] := Data.Hole[1, 1];
      _WellHole[1, 2] := Data.Hole[1, 2];

      OHSection2TDData.Enabled := False;
      //OHSection2TDData.Text:=FloatToStr(0); { user depth }
      OHSection2IDData.Enabled := False;
      //OHSection2IDData.Text:=FloatToStr(0); { inches }

      OHSection3TDData.Enabled := False;
      //OHSection3TDData.Text:=FloatToStr(0); { user depth }
      OHSection3IDData.Enabled := False;
      //OHSection3IDData.Text:=FloatToStr(0); { inches }
    end;
    2:
    begin
      NumOHSectionsComboBox.ItemIndex := 2;
      OHSection1TDData.Enabled := True;
      OHSection1TDData.Text := FloatToStr(Round2(Data.Hole[1, 1] * UoMConverter[1], 2));      { API->user depth }
      OHSection1IDData.Enabled := True;
      OHSection1IDData.Text := FloatToStr(Round2(Data.Hole[1, 2] * UoMConverter[8], 4)); { inches }
      _WellHole[1, 1] := Data.Hole[1, 1];
      _WellHole[1, 2] := Data.Hole[1, 2];

      OHSection2TDData.Enabled := True;
      OHSection2TDData.Text := FloatToStr(Round2(Data.Hole[1, 1] * UoMConverter[1], 2));      { API->user depth }
      OHSection2IDData.Enabled := True;
      OHSection2IDData.Text := FloatToStr(Round2(Data.Hole[1, 2] * UoMConverter[8], 4)); { inches }
      _WellHole[2, 1] := Data.Hole[2, 1];
      _WellHole[2, 2] := Data.Hole[2, 2];

      OHSection3TDData.Enabled := False;
      //OHSection3TDData.Text:=FloatToStr(0); { user depth }
      OHSection3IDData.Enabled := False;
      //OHSection3IDData.Text:=FloatToStr(0); { inches }
    end;
    3:
    begin
      NumOHSectionsComboBox.ItemIndex := 3;
      OHSection1TDData.Enabled := True;
      OHSection1TDData.Text := FloatToStr(Round2(Data.Hole[1, 1] * UoMConverter[1], 2)); { API->user depth }
      OHSection1IDData.Enabled := True;
      OHSection1IDData.Text := FloatToStr(Round2(Data.Hole[1, 2] * UoMConverter[8], 4)); { inches }
      _WellHole[1, 1] := Data.Hole[1, 1];
      _WellHole[1, 2] := Data.Hole[1, 2];

      OHSection2TDData.Enabled := True;
      OHSection2TDData.Text := FloatToStr(Round2(Data.Hole[2, 1] * UoMConverter[1], 2)); { API->user depth }
      OHSection2IDData.Enabled := True;
      OHSection2IDData.Text := FloatToStr(Round2(Data.Hole[2, 2] * UoMConverter[8], 4)); { inches }
      _WellHole[2, 1] := Data.Hole[2, 1];
      _WellHole[2, 2] := Data.Hole[2, 2];

      OHSection3TDData.Enabled := True;
      OHSection3TDData.Text := FloatToStr(Round2(Data.Hole[3, 1] * UoMConverter[1], 2)); { API->user depth }
      OHSection3IDData.Enabled := True;
      OHSection3IDData.Text := FloatToStr(Round2(Data.Hole[3, 2] * UoMConverter[8], 4)); { inches }
      _WellHole[3, 1] := Data.Hole[3, 1];
      _WellHole[3, 2] := Data.Hole[3, 2];
    end;
  end;
  DeviationData.Text := FloatToStr(Round2(Data.DeviationDegrees, 2));
  _WellDeviation:=Data.DeviationDegrees;
end;

procedure THoleDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormHoleData : THoleDataForm.FormCreate');
end;

procedure THoleDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormHoleData.Quit ..............................................');
  Close;
end;

procedure THoleDataForm.FormDeactivate(Sender: TObject);
begin { Also called on QuitButton }
  StringToMemo('FormHoleData.Deactivate ........................................');
end;

procedure THoleDataForm.SaveButtonClick(Sender: TObject);
var
  Error: boolean;

  { Validate hole section input : 3 functions }
  { ------------- OH Section #1 Checks ----------------}
  function WellSection1isOK: boolean;
  var
    TDisOK: boolean;
    IDisOK: boolean;
  begin
    StringToMemo('Validating Well Section 1...');
    if ((_WellHole[1, 1] <= _WellCasingTD) and (Data.Casing = True)) or
      { total OH depth must be greater than casing if present }
      ((_WellHole[1, 1] <= _WellLinerBottomTD) and (Data.Liner = True)) or
      { total OH depth must be greater than liner if present }
      ((_WellHole[1, 1] >= _WellHole[2, 1]) and (_WellMaxHoles > 1))
    { total OH depth must be less than OH 2 depth if 2 OHs } then
    begin
      ShowMessage('Hole section 1 depth must be deeper than casing shoe and liner shoe (if present) and less than OD 2 TD (if present)');
      StringToMemo(
        'FormHoleData.Save: Error: Hole section 1 depth must be deeper than casing shoe and liner shoe (if present) and less than OD 2 TD (if present)');
      OHSection1TDData.SetFocus;
      TDisOK := False;
    end
    else
    begin
      Data.Hole[1, 1] := _WellHole[1, 1];
      StringToMemo('FormHoleData.Save: Data.Hole[1,1] = ' + OHSection1TDData.Text +
        ' ' + UoMLabel[1]); { displayed depth }
      TDisOK := True;
    end;
    if ((_WellHole[1, 2] > _WellCasingID) and (Data.Casing = True)) or
      { OH ID must be less than casing ID if present }
      ((_WellHole[1, 2] < _WellLinerID) and (Data.Liner = True)) or
      { OH ID must be greater than liner ID if present }
      (_WellHole[1, 2] <= 0) or { OH ID must be greater than zero }
      ((_WellHole[1, 2] <= _WellHole[2, 2]) and (_WellMaxHoles > 1))
    { OH ID must be less than OH 2 ID if 2 OHs } then
    begin
      ShowMessage(
        'Hole section 1 ID must be greater than zero, less than casing ID (if present), and greater than liner OD (if present)');
      StringToMemo(
        'FormHoleData.Save: Error: Hole section 1 ID must be greater than zero, less than casing ID (if present), and greater than liner OD (if present)');
      OHSection1IDData.SetFocus;
      IDisOK := False;
    end
    else
    begin
      Data.Hole[1, 2] := _WellHole[1, 2];
      StringToMemo('FormHoleData.Save: Data.Hole[1,2] = ' + OHSection1IDData.Text +
        ' ' + UoMLabel[8]); { inches }
      IDisOK := True;
    end;
    if (TDisOK and IDisOK) then
    begin
      WellSection1isOK := True;
      StringToMemo('WellSection1isOK: Success');
    end
    else
    begin
      WellSection1isOK := False;
      StringToMemo('WellSection1isOK: Fail');
    end;
  end;

  { ------------- OH Section #2 Checks ----------------}
  function WellSection2isOK: boolean;
  var
    TDisOK: boolean;
    IDisOK: boolean;
  begin
    StringToMemo('Validating Well Section 2...');
    if (_WellHole[2, 1] <= _WellHole[1, 1]) or
      { total OH depth must be greater than previous OH TD }
      ((_WellHole[2, 1] <= _WellLinerBottomTD) and (Data.Liner = True)) or
      { total OH depth must be greater than liner if present }
      ((_WellHole[2, 1] >= _WellHole[3, 1]) and (_WellMaxHoles > 2))
    { total OH depth must be less than OH 3 depth if 3 OHs } then
    begin
      ShowMessage(
        'Hole section 2 depth must be deeper than OH section 1 TD and liner shoe (if present) and less than OD 3 TD (if present)');
      StringToMemo(
        'FormHoleData.Save: Error: Hole section 2 depth must be deeper than OH section 1 TD and liner shoe (if present) and less than OD 3 TD (if present)');
      OHSection2TDData.SetFocus;
      TDisOK := False;
    end
    else
    begin
      Data.Hole[2, 1] := _WellHole[2, 1];
      StringToMemo('FormHoleData.Save: Data.Hole[2,1] = ' + OHSection2TDData.Text +
        ' ' + UoMLabel[1]); { displayed depth }
      TDisOK := True;
    end;
    if (_WellHole[2, 2] >= _WellHole[1, 2]) or { OD 2 ID must be less than OH 1 ID }
      ((_WellHole[2, 2] <= _WellLinerID) and (Data.Liner = True)) or
      { OH 2 ID must be greater than liner ID if present }
      (_WellHole[2, 2] <= 0) or { OH 2 ID must be greater than zero }
      ((_WellHole[2, 2] <= _WellHole[3, 2]) and (_WellMaxHoles > 2))
    { OH 2 ID must be less than OH 3 ID if 3 OHs } then
    begin
      ShowMessage(
        'Hole section 2 ID must be greater than zero, less than OH section 1 ID, greater than OH 3 ID (present) and greater than liner OD (if present)');
      StringToMemo(
        'FormHoleData.Save: Error: Hole section 2 ID must be greater than zero, less than OH section 1 ID, greater than OH 3 ID (present) and greater than liner OD (if present)');
      OHSection2IDData.SetFocus;
      IDisOK := False;
    end
    else
    begin
      Data.Hole[2, 2] := _WellHole[2, 2];
      StringToMemo('FormHoleData.Save: Data.Hole[2,2] = ' + OHSection2IDData.Text +
        ' ' + UoMLabel[8]); { inches }
      IDisOK := True;
    end;
    if TDisOK and IDisOK then
    begin
      WellSection2isOK := True;
      StringToMemo('WellSection2isOK: Success');
    end
    else
    begin
      WellSection2isOK := False;
      StringToMemo('WellSection2isOK: Fail');
    end;
  end;

  { ------------- OH Section #3 Checks ----------------}
  function WellSection3isOK: boolean;
  var
    TDisOK: boolean;
    IDisOK: boolean;
  begin
    StringToMemo('Validating Well Section 3...');
    if (_WellHole[3, 1] <= _WellHole[2, 1]) or
      { total OH depth must be greater than previous OH TD }
      ((_WellHole[3, 1] <= _WellLinerBottomTD) and (Data.Liner = True))
    { total OH depth must be greater than liner if present } then
    begin
      ShowMessage('Hole section 3 depth must be deeper than OH section 2 TD and liner shoe (if present)');
      StringToMemo('FormHoleData.Save: Error: Hole section 3 depth must be deeper than OH section 2 TD and liner shoe (if present)');
      OHSection3TDData.SetFocus;
      TDisOK := False;
    end
    else
    begin
      Data.Hole[3, 1] := _WellHole[3, 1];
      StringToMemo('FormHoleData.Save: Data.Hole[3,1] = ' + OHSection3TDData.Text +
        ' ' + UoMLabel[1]); { displayed depth }
      TDisOK := True;
    end;
    if (_WellHole[3, 2] >= _WellHole[2, 2]) or { OD 3 ID must be less than OH 2 ID }
      ((_WellHole[3, 2] <= _WellLinerID) and (Data.Liner = True)) or
      { OH 3 ID must be greater than liner ID if present }
      (_WellHole[3, 2] <= 0) { OH 3 ID must be greater than zero } then
    begin
      ShowMessage('Hole section 3 ID must be greater than zero, less than OH section 2 ID, and greater than liner OD (if present)');
      StringToMemo(
        'FormHoleData.Save: Error: Hole section 3 ID must be greater than zero, less than OH section 2 ID (if present), and greater than liner OD (if present)');
      OHSection3IDData.SetFocus;
      IDisOK := False;
    end
    else
    begin
      Data.Hole[3, 2] := _WellHole[3, 2];
      StringToMemo('FormHoleData.Save: Data.Hole[3,2] = ' + OHSection3IDData.Text +
        ' ' + UoMLabel[8]); { inches }
      IDisOK := True;
    end;
    if TDisOK and IDisOK then
    begin
      WellSection3isOK := True;
      StringToMemo('WellSection3isOK: Success');
    end
    else
    begin
      WellSection3isOK := False;
      StringToMemo('WellSection3isOK: Fail');
    end;
  end;

  { ------------- Casing Checks ----------------}
  function CasingisOK: boolean;
  var
    TDisOK: boolean;
    IDisOK: boolean;
  begin
    StringToMemo('Validating Casing...');
    if (_WellCasingTD <= Data.WaterDepth)
    { Casing depth must be greater than Water Depth } then
    begin
      ShowMessage('Casing shoe must be deeper than water depth');
      StringToMemo('FormHoleData.Save: Error: Casing shoe must be deeper than water depth');
      CasingShoeDepthData.SetFocus;
      TDisOK := False;
    end
    else
    begin
      Data.CasingTD := _WellCasingTD;
      StringToMemo('FormHoleData.Save: Data.CasingTD = ' + CasingShoeDepthData.Text +
        ' ' + UoMLabel[1]); { displayed depth }
      TDisOK := True;
    end;
    if (_WellCasingID > Data.RiserID) or { Casing ID must be less than or equal to Riser ID }
      ((_WellCasingID <= _WellHole[1, 2]) and (Data.MaxHoles > 0))
    { Casing ID must be greater than OH 1 ID if present } then
    begin
      ShowMessage('Casing ID must be greater than zero, less than Riser ID, and greater than OH 1 OD (if present)');
      StringToMemo(
        'FormHoleData.Save: Error: Casing ID must be greater than zero, less than Riser ID, and greater than OH 1 OD (if present)');
      CasingIDData.SetFocus;
      IDisOK := False;
    end
    else
    begin
      Data.CasingID := _WellCasingID;
      StringToMemo('FormHoleData.Save: Data.CasingID = ' + CasingIDData.Text +
        ' ' + UoMLabel[8]);
      { inches }
      IDisOK := True;
    end;
    if TDisOK and IDisOK then
    begin
      CasingisOK := True;
      StringToMemo('CasingisOK: Success');
    end
    else
    begin
      CasingisOK := False;
      StringToMemo('CasingisOK: Fail');
      Exit;
    end;
  end;

  { ------------- Liner Checks ----------------}
  function LinerisOK: boolean;
  var
    TopTDisOK: boolean;
    BottomTDisOK: boolean;
    IDisOK: boolean;
  begin
    StringToMemo('Validating Liner...');
    if (_WellLinerTopTD >= Data.CasingTD)
    { Liner top depth must be less than Casing Shoe depth } then
    begin
      ShowMessage('Liner hanger must be shallower than casing shoe');
      StringToMemo('FormHoleData.Save: Error: Liner hanger must be shallower than casing shoe');
      LinerTopDepthData.SetFocus;
      TopTDisOK := False;
    end
    else
    begin
      Data.LinerTopTD := _WellLinerTopTD;
      StringToMemo('FormHoleData.Save: Data.LinerTopTD = ' + LinerTopDepthData.Text +
        ' ' + UoMLabel[1]); { displayed depth }
      TopTDisOK := True;
    end;
    if (_WellLinerBottomTD < Data.CasingTD)
    { Liner bottom depth must be greater than Casing Shoe depth } then
    begin
      ShowMessage('Liner shoe must be deeper than Casing shoe');
      StringToMemo('FormHoleData.Save: Error: Liner shoe must be deeper than Casing shoe');
      LinerBottomDepthData.SetFocus;
      BottomTDisOK := False;
    end
    else
    begin
      Data.LinerBottomTD := _WellLinerBottomTD;
      StringToMemo('FormHoleData.Save: Data.LinerShoeTD = ' + LinerBottomDepthData.Text +
        ' ' + UoMLabel[1]); { displayed depth }
      BottomTDisOK := True;
    end;
    if (_WellLinerID > Data.CasingID) { Liner ID must be less than Casing ID } then
    begin
      ShowMessage('Liner ID must be greater than zero and less than Casing ID');
      StringToMemo('FormHoleData.Save: Error: Liner ID must be greater than zero and less than Casing ID');
      LinerIDData.SetFocus;
      IDisOK := False;
    end
    else
    begin
      Data.LinerID := _WellLinerID;
      StringToMemo('FormHoleData.Save: Data.LinerID = ' + LinerIDData.Text + ' ' + UoMLabel[8]);
      { inches }
      IDisOK := True;
    end;
    if TopTDisOK and BottomTDisOK and IDisOK then
    begin
      LinerisOK := True;
      StringToMemo('LinerisOK: Success');
    end
    else
    begin
      LinerisOK := False;
      StringToMemo('LinerisOK: Fail');
    end;
  end;

begin
  StringToMemo('FormHoleData.Save ..............................................');
  Error := False;
  Data.Casing := _WellCasing;
  StringToMemo('FormHoleData.Save: Data.Casing = ' +
    IntToStr(CasingYNRadioGroup.ItemIndex));
  if Data.Casing then
  begin
    StringToMemo('Checking Casing...');
    if CasingisOK = True then
      StringToMemo('Casing profile validation: Success')
    else
    begin
      StringToMemo('Casing profile validation: Fail');
      Exit;
    end;
  end;
  Data.Liner := _WellLiner;
  StringToMemo('FormHoleData.Save: Data.Liner = ' + IntToStr(LinerYNRadioGroup.ItemIndex));
  if Data.Liner then
  begin
    StringToMemo('Checking Liner...');
    if LinerisOK = True then
      StringToMemo('Liner profile validation: Success')
    else
    begin
      StringToMemo('Liner profile validation: Fail');
      Exit;
    end;
  end;
  StringToMemo('FormHoleData.Save: Data.MaxHoles = ' + IntToStr(Data.MaxHoles));
  case _WellMaxHoles of { very ugly...cant interate through objects but it works...}
    1:
    begin
      StringToMemo('Checking 1 OH section...');
      if WellSection1isOK = False then
        Error := True;
    end;
    2:
    begin
      StringToMemo('Checking 2 OH sections...');
      if (WellSection1isOK = False) or (WellSection2isOK = False) then
        Error := True;
    end;
    3:
    begin
      StringToMemo('Checking 3 OH sections...');
      if (WellSection1isOK = False) or (WellSection2isOK = False) or
        (WellSection3isOK = False) then
        Error := True;
    end;
  end;
  if Error = False then
  Begin
    StringToMemo('Hole profile validation: Success');
    Data.MaxHoles := _WellMaxHoles;
  end
  else
  begin
    StringToMemo('Hole profile validation: Fail');
    Exit;
  end;
  Data.DeviationDegrees := _WellDeviation;
  StringToMemo('FormHoleData.Save: Data.DeviationDegrees = ' +
    DeviationData.Text + ' Degrees');
  Edited := True;
  Close;
end;

end.
