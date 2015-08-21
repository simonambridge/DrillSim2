unit FormHoleData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, DrillSimVariables, DrillSimMessageToMemo;

type

  { THoleDataForm }

  THoleDataForm = class(TForm)
    QuitButton: TButton;
    SaveButton: TButton;
    LinerHangerDepth: TLabel;
    LinerShoeDepth: TLabel;
    LinerHangerDepthData1: TEdit;
    LinerHangerDepthUoM: TLabel;
    Casing: TRadioGroup;
    LinerID: TLabel;
    LinerHangerDepthData: TEdit;
    LinerIDUoM: TLabel;
    Deviation: TLabel;
    DeviationData: TEdit;
    DeviationUoM: TLabel;
    CashingShoeDepth: TLabel;
    CasingShoeData: TEdit;
    CashingShoeDepthUoM: TLabel;
    CasingID: TLabel;
    CasingIDData: TEdit;
    CasingIDUoM: TLabel;
    LinerShoeDepthUoM: TLabel;
    LinerSHoe: TEdit;
    OHSection1IDData: TEdit;
    OHSection2IDData: TEdit;
    OHSectionID3Data: TEdit;
    OHSection1TDData: TEdit;
    ID: TLabel;
    IDLabelUoM: TLabel;
    OHSection2TDData: TEdit;
    OHSection3TDData: TEdit;
    OHSection2: TLabel;
    OHSection3: TLabel;
    TDLabelUoM: TLabel;
    TDColumnLabel: TLabel;
    OHSection1: TLabel;
    NumOHSectionsData: TEdit;
    NumOHSections: TLabel;
    Liner: TRadioGroup;
    Riser: TCheckBox;
    SubSeaWellHead: TCheckBox;
    OffshoreYN: TCheckBox;
    procedure CancelClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  HoleDataForm: THoleDataForm;

implementation

{$R *.lfm}

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




end;

procedure THoleDataForm.FormCreate(Sender: TObject);
begin

end;

procedure THoleDataForm.CancelClick(Sender: TObject);
begin
  Close;
end;

procedure THoleDataForm.SaveClick(Sender: TObject);
begin
end;

end.

