unit FormBitData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimMessageToMemo;

type

  { TBitDataForm }

  TBitDataForm = class(TForm)
    BitNumberData: TEdit;
    BitNumberLabel: TLabel;
    BitTypeData: TEdit;
    Jet1ComboBox: TComboBox;
    Jet2ComboBox: TComboBox;
    Jet1Label: TLabel;
    Jet3ComboBox: TComboBox;
    Jet2Label: TLabel;
    Jet4ComboBox: TComboBox;
    Jet3Label: TLabel;
    Jet4Label: TLabel;
    BitTypeLabel: TLabel;
    MaxJetsData: TLabel;
    MaxJetsLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    Procedure JetCount;
    procedure BitNumberDataChange(Sender: TObject);
    procedure BitTypeDataChange(Sender: TObject);
    procedure Jet1ComboBoxChange(Sender: TObject);
    procedure Jet2ComboBoxChange(Sender: TObject);
    procedure Jet3ComboBoxChange(Sender: TObject);
    procedure Jet4ComboBoxChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeActivate(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  BitDataForm: TBitDataForm;
  _WellMaxJets                     : integer;
  _WellJet                         : array[1..4] of integer;
  _WellBitNumber                   : integer;
  _WellBitType                     : String20;


implementation

{$R *.lfm}

{ TBitDataForm }

{ ------------- Edit Procedures ------------ }

procedure TBitDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', DefaultFormatSettings.DecimalSeparator]) then
  Begin
    Key := #0;  // discard it
  end
  else if ((Key = DefaultFormatSettings.DecimalSeparator) or (Key = '-')) and
          (Pos(Key, (Sender as TEdit).Text) > 0) then
  Begin
    Key := #0;  // discard it
  end
  else if (Key = '.') and
          ((Sender as TEdit).SelStart = 0) then
  Begin
    Key := #0;  // discard it
  end;
end;

Procedure TBitDataForm.JetCount;
var i : integer;
Begin
  _WellMaxJets:=0;
  for i:=1 to 4
  do
  Begin
    if _WellJet[i]>0 then _WellMaxJets:=_WellMaxJets+1;
  End;
  MaxJetsData.Caption:=IntToStr(_WellMaxJets);
End;

//

procedure TBitDataForm.BitNumberDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellBitNumber:=StrToInt(BitNumberData.Text);
end;

procedure TBitDataForm.BitTypeDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellBitType:=BitTypeData.Text;
end;

procedure TBitDataForm.Jet1ComboBoxChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellJet[1]:=Jet1ComboBox.ItemIndex; { jet 1 diameter n/32" }
  if _WellJet[1]>0 then
  Begin
    Jet1ComboBox.Color:=clDefault;
    Jet1ComboBox.Font.Color:=clBlack;
  end else
  Begin
    Jet1ComboBox.Color:=clRed;
    Jet1ComboBox.Font.Color:=clWhite;
  End;
  JetCount;
end;

procedure TBitDataForm.Jet2ComboBoxChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellJet[2]:=Jet2ComboBox.ItemIndex; { jet 2 diameter n/32" }
  if _WellJet[2]>0 then
  Begin
    Jet2ComboBox.Color:=clDefault;
    Jet2ComboBox.Font.Color:=clBlack;
  end else
  Begin
    Jet2ComboBox.Color:=clRed;
    Jet2ComboBox.Font.Color:=clWhite;
  End;
  JetCount;
end;

procedure TBitDataForm.Jet3ComboBoxChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellJet[3]:=Jet3ComboBox.ItemIndex; { jet 3 diameter n/32" }
  if _WellJet[3]>0 then
  Begin
    Jet3ComboBox.Color:=clDefault;
    Jet3ComboBox.Font.Color:=clBlack;
  end else
  Begin
    Jet3ComboBox.Color:=clRed;
    Jet3ComboBox.Font.Color:=clWhite;
  End;
  JetCount;
end;

procedure TBitDataForm.Jet4ComboBoxChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellJet[4]:=Jet4ComboBox.ItemIndex; { jet 4 diameter n/32" }
  if _WellJet[4]>0 then
  Begin
    Jet4ComboBox.Color:=clDefault;
    Jet4ComboBox.Font.Color:=clBlack;
  end else
  Begin
    Jet4ComboBox.Color:=clRed;
    Jet4ComboBox.Font.Color:=clWhite;
  End;
  JetCount;
end;

{ ------------------ Form procedures ---------------------- }


procedure TBitDataForm.FormActivate(Sender: TObject);
var i : integer;
begin
  StringToMemo('Form Bit Data activated...........................');

  // units of measure labels
  { no UoM for this form }

  // data

  BitNumberData.Text:=IntToStr(Data.BitNumber);

  BitTypeData.Text:=Data.BitType;

  _WellMaxJets:=0;
  for i:=1 to 4 do
  Begin
    _WellJet[i]:=Data.Jet[i];

    Case i of
      1: Begin
           if Data.Jet[1]>0 then
           Begin
             Jet1ComboBox.Color:=clDefault;
             Jet1ComboBox.Font.Color:=clBlack;
             _WellMaxJets:=_WellMaxJets+1;
             Jet1ComboBox.ItemIndex:=Data.Jet[1];
           end else
           Begin
             Jet1ComboBox.Color:=clRed;
             Jet1ComboBox.Font.Color:=clWhite;
           End;
         End;
      2: Begin
           if Data.Jet[2]>0 then
           Begin
             Jet2ComboBox.Color:=clDefault;
             Jet2ComboBox.Font.Color:=clBlack;
             _WellMaxJets:=_WellMaxJets+1;
             Jet2ComboBox.ItemIndex:=Data.Jet[2];
           end else
           Begin
             Jet2ComboBox.Color:=clRed;
             Jet2ComboBox.Font.Color:=clWhite;
           End;
         End;
      3: Begin
           if Data.Jet[3]>0 then
           Begin
             Jet3ComboBox.Color:=clDefault;
             Jet3ComboBox.Font.Color:=clBlack;
             _WellMaxJets:=_WellMaxJets+1;
             Jet3ComboBox.ItemIndex:=Data.Jet[3];
           end else
           Begin
             Jet3ComboBox.Color:=clRed;
             Jet3ComboBox.Font.Color:=clWhite;
           End;
         End;
      4: Begin
           if Data.Jet[4]>0 then
           Begin
             Jet4ComboBox.Color:=clDefault;
             Jet4ComboBox.Font.Color:=clBlack;
             _WellMaxJets:=_WellMaxJets+1;
             Jet4ComboBox.ItemIndex:=Data.Jet[4];
           end else
           Begin
             Jet4ComboBox.Color:=clRed;
             Jet4ComboBox.Font.Color:=clWhite;
           End;
         End;
    end;
  end;
  MaxJetsData.Caption:=IntToStr(_WellMaxJets);
end;

procedure TBitDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormBitData : TBitDataForm.FormCreate');

end;

procedure TBitDataForm.FormDeActivate(Sender: TObject);
begin{ Also called on QuitButton }
    StringToMemo('FormBitData.Deactivate ........................................');
end;


procedure TBitDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormBitData.Quit ..............................................');
  Close;
end;

procedure TBitDataForm.SaveButtonClick(Sender: TObject);
var
  Error : boolean;
  i : integer;
Begin

  StringToMemo('FormBitData.Save ..............................................');

  if _WellBitNumber<>0
          then Data.BitNumber:=_WellBitNumber
          else
            Begin
              ShowMessage('Bit number cannot be 0');
              StringToMemo('FormBitData.Save: Error: Bit number cannot be blank');
              BitNumberData.SetFocus;
              Exit;
            end;
  if _WellBitType<> ''
          then Data.BitType:=_WellBitType
          else
            Begin
              ShowMessage('Bit type cannot be blank');
              StringToMemo('FormBitData.Save: Error: Bit type cannot be blank');
              BitTypeData.SetFocus;
              Exit;
            end;

  Error:=True;
  For i:=1 to 4 do
  Begin
    if _WellJet[i]>0
      then Error:=False     { OK if at least one jet is valid }
      else _WellJet[i]:=0;  { and force it to 0 if -1 }
    Data.Jet[i]:=_WellJet[i];
  end;

  if Error=True then
  Begin
    ShowMessage('At least one of the bit jets must be open (more than 0/32")');
    StringToMemo('FormBitData.Save: Error: At least one of the bit jets must be open (more than 0/32")');
    Jet1ComboBox.SetFocus;
    Exit;
  end;

  Data.MaxJets:=_WellMaxJets;

  StringToMemo('FormBitData.Save: Data.BitNumber = '+ IntToStr(Data.BitNumber));
  StringToMemo('FormBitData.Save: Data.BitType = '+ Data.BitType);
  StringToMemo('FormBitData.Save: Data.MaxJets = '+ IntToStr(Data.MaxJets));
  For i:=1 to 4 do
  Begin
    StringToMemo('FormBitData.Save: Data.Jet[' + IntToStr(i) + '] = ' +  IntToStr(Data.Jet[i]));
  end;

  Edited:=True;
  Close;
end;

end.

