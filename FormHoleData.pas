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
    NumOHSectionsComboBox: TComboBox;
    QuitButton: TButton;
    SaveButton: TButton;
    LinerTopDepth: TLabel;
    LinerBottomDepth: TLabel;
    LinerBottomDepthData: TEdit;
    LinerTopDepthUoMLabel: TLabel;
    CasingYNRadioGroup: TRadioGroup;
    LinerID: TLabel;
    LinerTopDepthData: TEdit;
    LinerIDUoMLabel: TLabel;
    Deviation: TLabel;
    DeviationData: TEdit;
    DeviationUoM: TLabel;
    CashingShoeDepth: TLabel;
    CasingShoeDepthData: TEdit;
    CasingShoeDepthUoMLabel: TLabel;
    CasingID: TLabel;
    CasingIDData: TEdit;
    CasingIDUoMLabel: TLabel;
    LinerBottomDepthUoMLabel: TLabel;
    LinerIDData: TEdit;
    OHSection1IDData: TEdit;
    OHSection2IDData: TEdit;
    OHSection3IDData: TEdit;
    OHSection1TDData: TEdit;
    IDColumnLabel: TLabel;
    OHIDUoMLabel: TLabel;
    OHSection2TDData: TEdit;
    OHSection3TDData: TEdit;
    OHSection2: TLabel;
    OHSection3: TLabel;
    OHTDUoMLabel: TLabel;
    TDColumnLabel: TLabel;
    OHSection1: TLabel;
    NumOHSections: TLabel;
    LinerYNRadioGroup: TRadioGroup;
    Riser: TCheckBox;
    SubSeaWellHead: TCheckBox;
    OffshoreYN: TCheckBox;
    procedure CasingYNRadioGroupClick(Sender: TObject);
    procedure LinerYNRadioGroupClick(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure CancelClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  HoleDataForm: THoleDataForm;
  _WellCasing : boolean;
  _WellLiner: boolean;


implementation

{$R *.lfm}

{ ------------- Edit Procedures ------------ }

procedure THoleDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', DefaultFormatSettings.DecimalSeparator]) then
  Begin
    Key := #0;
  end
  else if ((Key = DefaultFormatSettings.DecimalSeparator) or (Key = '-')) and
          (Pos(Key, (Sender as TEdit).Text) > 0) then
  Begin
    Key := #0;
  end
  else if (Key = '-') and
          ((Sender as TEdit).SelStart <> 0) then
  Begin
    Key := #0;
  end;
end;

procedure THoleDataForm.CasingYNRadioGroupClick(Sender: TObject);
begin
  case CasingYNRadioGroup.ItemIndex of
    0: Begin
         _WellCasing:= False;               { there is no casing... }
         CasingYNRadioGroup.ItemIndex:=0;

         CasingShoeDepthData.Enabled:=False;
         CasingShoeDepthData.Caption:=FloatToStr(0);  { depth }

         CasingIDData.Enabled:=False;
         CasingIDData.Caption:=FloatToStr(0);   { inches }

         _WellLiner:=False;                  { ...so there can be no liner either }
         LinerYNRadioGroup.ItemIndex:=0;
         LinerYNRadioGroup.Enabled:=False;

         LinerTopDepthData.Enabled:=False;
         LinerTopDepthData.Caption:=FloatToStr(0);  { depth }

         LinerBottomDepthData.Enabled:=False;
         LinerBottomDepthData.Caption:=FloatToStr(0);  { depth }

         LinerIDData.Enabled:=False;
         LinerIDData.Caption:=FloatToStr(0);   { inches }
       End;
    1: Begin
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
         LinerTopDepthData.Caption:=FloatToStr(0);  { depth }

         LinerBottomDepthData.Enabled:=False;
         LinerBottomDepthData.Caption:=FloatToStr(0);  { depth }

         LinerIDData.Enabled:=False;
         LinerIDData.Caption:=FloatToStr(0);   { inches }
       End;
    1: Begin
        _WellLiner:=True;                  { there is no Liner }
        LinerYNRadioGroup.ItemIndex:=1;
        LinerTopDepthData.Enabled:=True;
        LinerTopDepthData.Caption:=FloatToStr(0);     { depth }

        LinerBottomDepthData.Enabled:=True;
        LinerBottomDepthData.Caption:=FloatToStr(0);  { depth }

        LinerIDData.Enabled:=True;
        LinerIDData.Caption:=FloatToStr(0);           { inches }
      end;
   End;
end;


{ ------------------ Form procedures ---------------------- }

procedure THoleDataForm.FormActivate(Sender: TObject);
begin
    StringToMemo('Form Well Hole Profile Data activated....');
    OffshoreYN.Enabled:=False;
    SubSeaWellHead.Enabled:=False;
    Riser.Enabled:=False;

    if Data.Offshore
    then OffshoreYN.Checked:=True
    else OffshoreYN.Checked:=False;

    if Data.SubSeaWellHead
    then SubSeaWellHead.Checked:=True
    else SubSeaWellHead.Checked:=False;

    if Data.Riser
    then Riser.Checked:=True
    else Riser.Checked:=False;

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
        LinerYNRadioGroup.Enabled:=False;

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
           OHSection1TDData.Text:=FloatToStr(0);  { depth }
           OHSection1TDData.Text:=FloatToStr(0);  { inches }

           OHSection2TDData.Enabled:=False;
           OHSection2IDData.Enabled:=False;
           OHSection2TDData.Text:=FloatToStr(0);  { depth }
           OHSection2TDData.Text:=FloatToStr(0);  { inches }

           OHSection3TDData.Enabled:=False;
           OHSection3IDData.Enabled:=False;
           OHSection3TDData.Text:=FloatToStr(0);  { depth }
           OHSection3TDData.Text:=FloatToStr(0);  { inches }
         end;

      1: Begin
           NumOHSectionsComboBox.ItemIndex:=1;
           OHSection1TDData.Enabled:=True;
           OHSection1IDData.Enabled:=True;
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection2TDData.Enabled:=False;
           OHSection2IDData.Enabled:=False;
           OHSection2TDData.Text:=FloatToStr(0);  { depth }
           OHSection2TDData.Text:=FloatToStr(0);  { inches }

           OHSection3TDData.Enabled:=False;
           OHSection3IDData.Enabled:=False;
           OHSection3TDData.Text:=FloatToStr(0);  { depth }
           OHSection3TDData.Text:=FloatToStr(0);  { inches }
         end;

      2: Begin
           NumOHSectionsComboBox.ItemIndex:=2;
           OHSection1TDData.Enabled:=True;
           OHSection1IDData.Enabled:=True;
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection2TDData.Enabled:=True;
           OHSection2IDData.Enabled:=True;
           OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection3TDData.Enabled:=False;
           OHSection3IDData.Enabled:=False;
           OHSection3TDData.Text:=FloatToStr(0);  { depth }
           OHSection3TDData.Text:=FloatToStr(0);  { inches }
         end;

      3: Begin
           NumOHSectionsComboBox.ItemIndex:=3;
           OHSection1TDData.Enabled:=True;
           OHSection1IDData.Enabled:=True;
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection1TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection2TDData.Enabled:=True;
           OHSection2IDData.Enabled:=True;
           OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection2TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }

           OHSection3TDData.Enabled:=True;
           OHSection3IDData.Enabled:=True;
           OHSection3TDData.Text:=FloatToStr(Round2(Data.Hole[1,1]*UoMConverter[1],2));  { depth }
           OHSection3TDData.Text:=FloatToStr(Round2(Data.Hole[1,2]*UoMConverter[8],2));  { inches }
         end;
    end;
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

procedure THoleDataForm.CancelClick(Sender: TObject);
begin
  Close;
end;

procedure THoleDataForm.SaveButtonClick(Sender: TObject);
begin
  Data.Casing:=_WellCasing;
  Data.Liner:=_WellLiner;
  Close;
end;

end.

