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
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure CancelClick(Sender: TObject);
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
  i             : integer;
  HoleDataForm  : THoleDataForm;

  _WellCasing        : boolean;
  _WellCasingTD      : real;
  _WellCasingID      : real;

  _WellLiner         : boolean;
  _WellLinerTopTD    : real;
  _WellLinerBottomTD : real;
  _WellLinerID       : real;

  _WellMaxHoles      : integer;
  _WellHole          : array[1..3,1..3] of real;

  _WellDeviation     : real;

implementation

{$R *.lfm}

{ ------------- Edit Procedures ------------ }

procedure THoleDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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
  end  else if (Key = '-') and
          ((Sender as TEdit).SelStart <> 0) then
  Begin
    Key := #0;  // discard it
  end;
end;

procedure THoleDataForm.CancelClick(Sender: TObject);
begin

end;

procedure THoleDataForm.CasingYNRadioGroupClick(Sender: TObject);
begin
  case CasingYNRadioGroup.ItemIndex of
    0: Begin
         _WellCasing:= False;               { there is no casing... }
         CasingYNRadioGroup.ItemIndex:=0;

         CasingShoeDepthData.Enabled:=False;
         //CasingShoeDepthData.Caption:=FloatToStr(0);  { depth }

         CasingIDData.Enabled:=False;
         //CasingIDData.Caption:=FloatToStr(0);   { inches }

         _WellLiner:=False;                  { ...so there can be no liner either }
         LinerYNRadioGroup.ItemIndex:=0;
         LinerYNRadioGroup.Enabled:=False;

         LinerTopDepthData.Enabled:=False;
         //LinerTopDepthData.Caption:=FloatToStr(0);  { depth }

         LinerBottomDepthData.Enabled:=False;
         //LinerBottomDepthData.Caption:=FloatToStr(0);  { depth }

         LinerIDData.Enabled:=False;
         //LinerIDData.Caption:=FloatToStr(0);   { inches }
       End;
    1: Begin
         _WellCasing:= True;               { there is casing... }
        CasingYNRadioGroup.ItemIndex:=1;
        LinerYNRadioGroup.Enabled:=True;

        CasingShoeDepthData.Enabled:=True;
        CasingShoeDepthData.Caption:=FloatToStr(Round2(Data.CasingTD*UoMConverter[1],2));  { depth }

        CasingIDData.Enabled:=True;
        CasingIDData.Caption:=FloatToStr(Data.CasingID*UoMConverter[8]);   { inches }

      end;
   End;
end;

procedure THoleDataForm.LinerYNRadioGroupClick(Sender: TObject);
begin
  case LinerYNRadioGroup.ItemIndex of
    0: Begin
         _WellLiner:= False;               { there is no Liner }
         LinerYNRadioGroup.ItemIndex:=0;

         LinerTopDepthData.Enabled:=False;
         //LinerTopDepthData.Caption:=FloatToStr(0);  { depth }

         LinerBottomDepthData.Enabled:=False;
         //LinerBottomDepthData.Caption:=FloatToStr(0);  { depth }

         LinerIDData.Enabled:=False;
         //LinerIDData.Caption:=FloatToStr(0);   { inches }
       End;
    1: Begin
        _WellLiner:=True;                  { there is a Liner }
        LinerYNRadioGroup.ItemIndex:=1;
        LinerTopDepthData.Enabled:=True;
        //LinerTopDepthData.Caption:=FloatToStr(Round2(Data.LinerTopTD*UoMConverter[1],2));  { depth }

        LinerBottomDepthData.Enabled:=True;
        //LinerBottomDepthData.Caption:=FloatToStr(Round2(Data.LinerBottomTD*UoMConverter[1],2));  { depth }

        LinerIDData.Enabled:=True;
        //LinerIDData.Caption:=FloatToStr(Data.LinerID*UoMConverter[8]);   { inches }
      end;
   End;
end;

procedure THoleDataForm.NumOHSectionsComboBoxChange(Sender: TObject);
begin
  case NumOHSectionsComboBox.ItemIndex of
    0: Begin
         _WellMaxHoles:=0;
         OHSection1TDData.Enabled:=False;
         OHSection1IDData.Enabled:=False;
         //OHSection1TDData.Text:=FloatToStr(0);  { depth }
         //OHSection1TDData.Text:=FloatToStr(0);  { inches }

         OHSection2TDData.Enabled:=False;
         OHSection2IDData.Enabled:=False;
         //OHSection2TDData.Text:=FloatToStr(0);  { depth }
         //OHSection2TDData.Text:=FloatToStr(0);  { inches }

         OHSection3TDData.Enabled:=False;
         OHSection3IDData.Enabled:=False;
         //OHSection3TDData.Text:=FloatToStr(0);  { depth }
         //OHSection3TDData.Text:=FloatToStr(0);  { inches }
       end;

    1: Begin
         _WellMaxHoles:=1;
         OHSection1TDData.Enabled:=True;
         OHSection1IDData.Enabled:=True;
         //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
         //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

         OHSection2TDData.Enabled:=False;
         OHSection2IDData.Enabled:=False;
         //OHSection2TDData.Text:=FloatToStr(0);  { depth }
         //OHSection2TDData.Text:=FloatToStr(0);  { inches }

         OHSection3TDData.Enabled:=False;
         OHSection3IDData.Enabled:=False;
         //OHSection3TDData.Text:=FloatToStr(0);  { depth }
         //OHSection3TDData.Text:=FloatToStr(0);  { inches }
       end;

  2: Begin
       _WellMaxHoles:=2;
       OHSection1TDData.Enabled:=True;
       OHSection1IDData.Enabled:=True;
       //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
       //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

       OHSection2TDData.Enabled:=True;
       OHSection2IDData.Enabled:=True;
       //OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
       //OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

       OHSection3TDData.Enabled:=False;
       OHSection3IDData.Enabled:=False;
       //OHSection3TDData.Text:=FloatToStr(0);  { depth }
       //OHSection3TDData.Text:=FloatToStr(0);  { inches }
     end;

   3: Begin
        _WellMaxHoles:=3;
        OHSection1TDData.Enabled:=True;
        OHSection1IDData.Enabled:=True;
        //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
        //OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

        OHSection2TDData.Enabled:=True;
        OHSection2IDData.Enabled:=True;
        //OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
        //OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

        OHSection3TDData.Enabled:=True;
        OHSection3IDData.Enabled:=True;
        //OHSection3TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
        //OHSection3TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }
      end;
    end;

end;

procedure THoleDataForm.CasingShoeDepthDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellCasingTD:=Round2(StrToFloat(CasingShoeDepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure THoleDataForm.CasingIDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellCasingID:=Round2(StrToFloat(CasingIDData.Text)/UoMConverter[8],2); { inches }
end;

procedure THoleDataForm.LinerTopDepthDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellLinerTopTD:=Round2(StrToFloat(LinerTopDepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure THoleDataForm.LinerBottomDepthDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellLinerBottomTD:=Round2(StrToFloat(LinerBottomDepthData.Text)/UoMConverter[1],2); { depth }
end;

procedure THoleDataForm.LinerIDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellLinerID:=Round2(StrToFloat(LinerIDData.Text)/UoMConverter[8],2); { inches }
end;

procedure THoleDataForm.OHSection1TDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellHole[1,1]:=Round2(StrToFloat(OHSection1TDData.Text)/UoMConverter[1],2); { depth }
end;

procedure THoleDataForm.OHSection1IDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellHole[1,2]:=Round2(StrToFloat(OHSection1IDData.Text)/UoMConverter[8],2); { inches }
end;

procedure THoleDataForm.OHSection2TDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellHole[2,1]:=Round2(StrToFloat(OHSection2TDData.Text)/UoMConverter[1],2); { depth }
end;

procedure THoleDataForm.OHSection2IDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellHole[2,2]:=Round2(StrToFloat(OHSection2IDData.Text)/UoMConverter[8],2); { inches }
end;

procedure THoleDataForm.OHSection3TDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellHole[3,1]:=Round2(StrToFloat(OHSection3TDData.Text)/UoMConverter[1],2); { depth }
end;

procedure THoleDataForm.OHSection3IDDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellHole[3,2]:=Round2(StrToFloat(OHSection3IDData.Text)/UoMConverter[8],2); { inches }
end;


procedure THoleDataForm.DeviationDataChange(Sender: TObject);
begin
  if TEdit(Sender).Text <> ''
          then _WellDeviation:=Round2(StrToFloat(DeviationData.Text),2); { degrees - no conversion }
end;



{ ------------------ Form procedures ---------------------- }

procedure THoleDataForm.FormActivate(Sender: TObject);
begin
    StringToMemo('Form Well Hole Profile Data activated....');


    OffshoreYN.Enabled:=False;
    if Data.Offshore
    then OffshoreYN.Checked:=True
    else OffshoreYN.Checked:=False;

    SubSeaWellHead.Enabled:=False;
    if Data.SubSeaWellHead
    then SubSeaWellHead.Checked:=True
    else SubSeaWellHead.Checked:=False;

    Riser.Enabled:=False;
    if Data.Riser
    then Riser.Checked:=True
    else Riser.Checked:=False;

    CasingYNRadioGroup.Enabled:=True;
    LinerYNRadioGroup.Enabled:=True;

    if Data.Casing=True then                { there is casing }
    Begin
      CasingYNRadioGroup.ItemIndex:=1;
      CasingShoeDepthData.Enabled:=True;
      CasingShoeDepthData.Caption:=FloatToStr(Round2(Data.CasingTD*UoMConverter[1],2));  { depth }
      CasingIDData.Enabled:=True;
      CasingIDData.Caption:=FloatToStr(Data.CasingID*UoMConverter[8]);   { inches }

      if Data.Liner=True                     { is there a liner with this casing? }
      then
      Begin
        LinerYNRadioGroup.ItemIndex:=1;
        LinerYNRadioGroup.Enabled:=True;

        LinerTopDepthData.Enabled:=True;
        LinerTopDepthData.Caption:=FloatToStr(Round2(Data.LinerTopTD*UoMConverter[1],2));  { depth }

        LinerBottomDepthData.Enabled:=True;
        LinerBottomDepthData.Caption:=FloatToStr(Round2(Data.LinerBottomTD*UoMConverter[1],2));  { depth }

        LinerIDData.Enabled:=True;
        LinerIDData.Caption:=FloatToStr(Data.LinerID*UoMConverter[8]);   { inches }
      end else
      Begin                                     { there is no liner with this casing }
        LinerYNRadioGroup.ItemIndex:=0;

        LinerTopDepthData.Enabled:=False;
        LinerTopDepthData.Caption:=FloatToStr(0);  { depth }

        LinerBottomDepthData.Enabled:=False;
        LinerBottomDepthData.Caption:=FloatToStr(0);  { depth }

        LinerIDData.Enabled:=False;
        LinerIDData.Caption:=FloatToStr(0);   { inches }
      end;
    end
    else                         { there is no casing...so no liner either }
    Begin
      CasingYNRadioGroup.ItemIndex:=0;

      CasingShoeDepthData.Enabled:=False;
      CasingShoeDepthData.Caption:=FloatToStr(0);   { depth }

      CasingIDData.Enabled:=False;
      CasingIDData.Caption:=FloatToStr(0);          { inches }
                                 { ...so there can be no liner }
      LinerYNRadioGroup.ItemIndex:=0;
      LinerYNRadioGroup.Enabled:=False;

      LinerTopDepthData.Enabled:=False;
      LinerTopDepthData.Caption:=FloatToStr(0);     { depth }

      LinerBottomDepthData.Enabled:=False;
      LinerBottomDepthData.Caption:=FloatToStr(0);  { depth }

      LinerIDData.Enabled:=False;
      LinerIDData.Caption:=FloatToStr(0);           { inches }
    end;

    case Data.MaxHoles of
      0: Begin
           NumOHSectionsComboBox.ItemIndex:=0;
           OHSection1TDData.Enabled:=False;
           OHSection1IDData.Enabled:=False;
           //OHSection1TDData.Text:=FloatToStr(0);  { depth }
           //OHSection1TDData.Text:=FloatToStr(0);  { inches }

           OHSection2TDData.Enabled:=False;
           OHSection2IDData.Enabled:=False;
           //OHSection2TDData.Text:=FloatToStr(0);  { depth }
           //OHSection2TDData.Text:=FloatToStr(0);  { inches }

           OHSection3TDData.Enabled:=False;
           OHSection3IDData.Enabled:=False;
           //OHSection3TDData.Text:=FloatToStr(0);  { depth }
           //OHSection3TDData.Text:=FloatToStr(0);  { inches }
         end;

      1: Begin
           NumOHSectionsComboBox.ItemIndex:=1;
           OHSection1TDData.Enabled:=True;
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection1IDData.Enabled:=True;
           OHSection1IDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection2TDData.Enabled:=False;
           //OHSection2TDData.Text:=FloatToStr(0);  { depth }
           OHSection2IDData.Enabled:=False;
           //OHSection2IDData.Text:=FloatToStr(0);  { inches }

           OHSection3TDData.Enabled:=False;
           //OHSection3TDData.Text:=FloatToStr(0);  { depth }
           OHSection3IDData.Enabled:=False;
           //OHSection3IDData.Text:=FloatToStr(0);  { inches }
         end;

      2: Begin
           NumOHSectionsComboBox.ItemIndex:=2;
           OHSection1TDData.Enabled:=True;
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection1IDData.Enabled:=True;
           OHSection1IDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection2TDData.Enabled:=True;
           OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection2IDData.Enabled:=True;
           OHSection2IDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection3TDData.Enabled:=False;
           //OHSection3TDData.Text:=FloatToStr(0);  { depth }
           OHSection3IDData.Enabled:=False;
           //OHSection3IDData.Text:=FloatToStr(0);  { inches }
         end;

      3: Begin
           NumOHSectionsComboBox.ItemIndex:=3;
           OHSection1TDData.Enabled:=True;
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection1IDData.Enabled:=True;
           OHSection1IDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection2TDData.Enabled:=True;
           OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[2,1]*UoMConverter[1],2));  { depth }
           OHSection2IDData.Enabled:=True;
           OHSection2IDData.Text:=FloatToStr(Round2(Data.Hole[2,2]*UoMConverter[8],2));  { inches }

           OHSection3TDData.Enabled:=True;
           OHSection3TDData.Text:=FloatToStr(Round2(Data.Hole[3,1]*UoMConverter[1],2));  { depth }
           OHSection3IDData.Enabled:=True;
           OHSection3IDData.Text:=FloatToStr(Round2(Data.Hole[3,2]*UoMConverter[8],2));  { inches }
         end;
    end;

    DeviationData.Text:=FloatToStr(Round2(Data.DeviationDegrees,2));

    // units of measure labels

    CasingShoeDepthUoMLabel.Caption:=UoMLabel[1];      { depth }
    CasingIDUoMLabel.Caption:=UoMLabel[8];             { inches }

    LinerTopDepthUoMLabel.Caption:=UoMLabel[1];        { depth }
    LinerBottomDepthUoMLabel.Caption:=UoMLabel[1];     { depth }
    LinerIDUoMLabel.Caption:=UoMLabel[8];              { inches }

    OHTDUoMLabel.Caption:=UoMLabel[1];         { depth }
    OHIDUoMLabel.Caption:=UoMLabel[8];         { inches }
end;

procedure THoleDataForm.FormCreate(Sender: TObject);
begin

end;

procedure THoleDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormHoleData.Quit');
  Close;
end;

procedure THoleDataForm.FormDeactivate(Sender: TObject);
begin
  StringToMemo('FormHoleData.Deactivate');
  Close;
end;

!!! add error condition on return from check well sections - make it a function?

procedure THoleDataForm.SaveButtonClick(Sender: TObject);
  Procedure CheckWellSection1;
  Begin
    if ((_WellHole[1,1] <= _WellCasingTD) and (Data.Casing=True))
    then
    Begin
      ShowMessage('Hole section #1 depth must be deeper than casing shoe');
      StringToMemo('FormHoleData.Save: Error: Hole section #1 depth must be deeper than casing shoe');
      OHSection1TDData.SetFocus;
      Exit;
    end
    else
    Begin
      Data.Hole[1,1]     :=_WellHole[1,1];
      Data.Hole[1,2]     :=_WellHole[1,2];
      StringToMemo('FormHoleData.Save: Data.Hole[1,1] = '+ OHSection1TDData.Text + ' ' + UoMLabel[1]); { depth }
      StringToMemo('FormHoleData.Save: Data.Hole[1,2] = '+ OHSection1IDData.Text + ' ' + UoMLabel[8]); { inches }
    End;
  end;

  Procedure CheckWellSection2;
  Begin
    if (_WellHole[2,1] <= _WellHole[1,1])
    then
    Begin
      ShowMessage('Hole section #2 depth must be deeper than hole section #1 depth');
      StringToMemo('FormHoleData.Save: Error: Hole section #2 depth must be deeper than hole section #1 depth');
      OHSection2TDData.SetFocus;
      Exit;
    end
    else
    Begin
      Data.Hole[2,1]     :=_WellHole[2,1];
      Data.Hole[2,2]     :=_WellHole[2,2];
      StringToMemo('FormHoleData.Save: Data.Hole[2,1] = '+ OHSection2TDData.Text + ' ' + UoMLabel[1]); { depth }
      StringToMemo('FormHoleData.Save: Data.Hole[2,2] = '+ OHSection2IDData.Text + ' ' + UoMLabel[8]); { inches }
    End;
  end;

  Procedure CheckWellSection3;
  Begin
    if (_WellHole[3,1] <= _WellHole[2,1])
    then
    Begin
      ShowMessage('Hole section #3 depth must be deeper than hole section #2 depth');
      StringToMemo('FormHoleData.Save: Error: Hole section #3 depth must be deeper than hole section #2 depth');
      OHSection3TDData.SetFocus;
      Exit;
    end
    else
    Begin
      Data.Hole[3,1]     :=_WellHole[3,1];
      Data.Hole[3,2]     :=_WellHole[3,2];
      StringToMemo('FormHoleData.Save: Data.Hole[3,1] = '+ OHSection3TDData.Text + ' ' + UoMLabel[1]); { depth }
      StringToMemo('FormHoleData.Save: Data.Hole[3,2] = '+ OHSection3IDData.Text + ' ' + UoMLabel[8]); { inches }
    End;
  end;

  begin
  StringToMemo('FormHoleData.Save');

  Data.Casing          :=_WellCasing;
  StringToMemo('FormHoleData.Save: Data.Casing = '+ IntToStr(CasingYNRadioGroup.ItemIndex));
  Data.Liner           :=_WellLiner;
  StringToMemo('FormHoleData.Save: Data.Liner = '+ IntToStr(LinerYNRadioGroup.ItemIndex));
  Data.CasingTD        :=_WellCasingTD;
  StringToMemo('FormHoleData.Save: Data.CasingTD = '+ CasingShoeDepthData.Text + ' ' + UoMLabel[1]); { depth }
  Data.CasingID        :=_WellCasingID;
  StringToMemo('FormHoleData.Save: Data.CasingID = '+ CasingIDData.Text + ' ' + UoMLabel[8]); { inches }

  Data.Liner           :=_WellLiner;
  if _WellLinerTopTD > _WellCasingTD
  then
    Begin
      ShowMessage('Liner hanger must be higher than casing shoe');
      StringToMemo('FormHoleData.Save: Error: Liner hanger must be higher than casing shoe');
      LinerTopDepthData.SetFocus;
      Exit;
    end
  else
  Begin
    Data.LinerTopTD:=_WellLinerTopTD;
    StringToMemo('FormHoleData.Save: Data.LinerTopTD = '+ LinerTopDepthData.Text + ' ' + UoMLabel[1]); { depth }
  end;

  if _WellLinerBottomTD < _WellLinerTopTD
  then
    Begin
      ShowMessage('Liner shoe must be lower than liner hanger');
      StringToMemo('FormHoleData.Save: Error: Liner hanger must be higher than casing shoe');
      LinerBottomDepthData.SetFocus;
      Exit;
    end
  else
  Begin
    Data.LinerBottomTD:=_WellLinerBottomTD;
    StringToMemo('FormHoleData.Save: Data.LinerShoeTD = '+ LinerBottomDepthData.Text + ' ' + UoMLabel[1]); { depth }
  end;

  Data.LinerID:=_WellLinerID;
  StringToMemo('FormHoleData.Save: Data.LinerID = '+ LinerIDData.Text + ' ' + UoMLabel[8]); { inches }

  Data.MaxHoles        :=_WellMaxHoles;
  StringToMemo('FormHoleData.Save: Data.MaxHoles = '+ IntToStr(NumOHSectionsComboBox.ItemIndex));

  Case Data.MaxHoles of    { very ugly...cant interate through objects but it works...}
    1 : Begin
          CheckWellSection1;
        End;
    2 : Begin
          CheckWellSection1;
          CheckWellSection2;
        End;
    3 : Begin
          CheckWellSection1;
          CheckWellSection2;
          CheckWellSection2;
        End;
   End;

  Data.DeviationDegrees:=_WellDeviation;
  StringToMemo('FormHoleData.Save: Data.DeviationDegrees = '+ DeviationData.Text + ' Degrees');

  Close;
end;

end.

