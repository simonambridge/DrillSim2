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
    Pump1EfficiencySPMData: TEdit;
    Pump3EfficiencyData: TEdit;
    Pump3Label: TLabel;
    Pump3OutputData: TEdit;
    Pump3EfficiencySPMData: TEdit;
    Pump2EfficiencyData: TEdit;
    Pump2Label: TLabel;
    Pump2OutputData: TEdit;
    Pump2EfficiencySPMData: TEdit;
    EfficiencyColumnLabel: TLabel;
    OutputColumnLabel: TLabel;
    NumPumps: TLabel;
    NumPumpsComboBox: TComboBox;
    SPMColumnLabel: TLabel;
    OutputUoMLabel: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
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
  PumpDataForm: TPumpDataForm;

implementation

{$R *.lfm}

{ TPumpDataForm }

{ ------------------ Form procedures ---------------------- }

procedure TPumpDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form Pump Data activated...........................');

  // units of measure labels


  // data


end;

procedure TPumpDataForm.FormCreate(Sender: TObject);
begin

end;

procedure TPumpDataForm.FormDeactivate(Sender: TObject);
begin

end;

procedure TPumpDataForm.QuitButtonClick(Sender: TObject);
begin

end;

procedure TPumpDataForm.SaveButtonClick(Sender: TObject);
begin

end;

end.

