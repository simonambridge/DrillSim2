unit FormWellTestData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

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
    procedure CasingBurstPressureDataChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure LastLeakOffDepthDataChange(Sender: TObject);
    procedure LastLeakOffEMWDataChange(Sender: TObject);
    procedure LastLeakOffMWDataChange(Sender: TObject);
    procedure LastLeakOffPressureDataChange(Sender: TObject);
    procedure LastLeakOffPressureDataKeyPress(Sender: TObject; var Key: char);
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

end;

procedure TWellTestDataForm.CasingBurstPressureDataChange(Sender: TObject);
begin

end;

procedure TWellTestDataForm.LastLeakOffEMWDataChange(Sender: TObject);
begin

end;

procedure TWellTestDataForm.LastLeakOffMWDataChange(Sender: TObject);
begin

end;

procedure TWellTestDataForm.LastLeakOffPressureDataChange(Sender: TObject);
begin

end;

procedure TWellTestDataForm.LastLeakOffPressureDataKeyPress(Sender: TObject;
  var Key: char);
begin

end;


{ ------------------ Form procedures ---------------------- }

procedure TWellTestDataForm.FormActivate(Sender: TObject);
begin

end;

procedure TWellTestDataForm.FormCreate(Sender: TObject);
begin

end;

procedure TWellTestDataForm.FormDeactivate(Sender: TObject);
begin

end;

procedure TWellTestDataForm.QuitButtonClick(Sender: TObject);
begin

end;

procedure TWellTestDataForm.SaveButtonClick(Sender: TObject);
begin

end;



end.

