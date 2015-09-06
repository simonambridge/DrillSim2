unit FormBitData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  CheckLst;

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
    Jet3ComboBox1: TComboBox;
    Jet3Label: TLabel;
    Jet4Label: TLabel;
    BitTypeLabel: TLabel;
    MaxJetsLabel: TLabel;
    MaxJetsData: TLabel;
    QuitButton: TButton;
    SaveButton: TButton;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  BitDataForm: TBitDataForm;

implementation

{$R *.lfm}

end.

