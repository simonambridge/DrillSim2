unit FormPipeData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TPipeDataForm }

  TPipeDataForm = class(TForm)
    QuitButton: TButton;
    SaveButton: TButton;
    IDColumnLabel: TLabel;
    Label1: TLabel;
    ODColumnLabel: TLabel;
    PipeIDUoMLabel: TLabel;
    PipeODUoMLabel: TLabel;
    DrillCollarLabel: TLabel;
    DrillCollarIDData: TEdit;
    DrillCollarODData: TEdit;
    DrillCollarLengthData: TEdit;
    HWDrillPipeLabel: TLabel;
    HWDrillPipeIDData: TEdit;
    HWDrillPipeODData: TEdit;
    HWDrillPipeLengthData: TEdit;
    DrillPipeLabel: TLabel;
    DrillPipeIDData: TEdit;
    DrillPipeODData: TEdit;
    DrillPipeLengthData: TEdit;
    PipeLengthUoMLabel: TLabel;
    LengthColumnLabel: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  PipeDataForm: TPipeDataForm;

implementation

{$R *.lfm}

{ TPipeDataForm }

procedure TPipeDataForm.FormActivate(Sender: TObject);
begin

end;

procedure TPipeDataForm.FormCreate(Sender: TObject);
begin

end;

procedure TPipeDataForm.FormDeactivate(Sender: TObject);
begin

end;


end.

