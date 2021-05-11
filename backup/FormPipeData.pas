unit FormPipeData;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  DrillSimVariables,
  DrillSimUtilities,
  DrillSimMessageToMemo;

type

  { TPipeDataForm }

  TPipeDataForm = class(TForm)
    DrillCollarWeightData: TEdit;
    DrillPipeWeightData: TEdit;
    HWDrillPipeWeightData: TEdit;
    NumPipeSections: TLabel;
    NumPipeSectionsComboBox: TComboBox;
    WeightColumnLabel: TLabel;
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
    procedure DrillCollarIDDataChange(Sender: TObject);
    procedure DrillCollarLengthDataChange(Sender: TObject);
    procedure DrillCollarODDataChange(Sender: TObject);
    procedure DrillCollarWeightDataChange(Sender: TObject);
    procedure DrillPipeIDDataChange(Sender: TObject);
    procedure DrillPipeLengthDataChange(Sender: TObject);
    procedure DrillPipeODDataChange(Sender: TObject);
    procedure DrillPipeWeightDataChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure HWDrillPipeIDDataChange(Sender: TObject);
    procedure HWDrillPipeLengthDataChange(Sender: TObject);
    procedure HWDrillPipeODDataChange(Sender: TObject);
    procedure HWDrillPipeWeightDataChange(Sender: TObject);
    procedure NumericOnlyKeyPress(Sender: TObject; var Key: Char);
    procedure NumPipeSectionsComboBoxChange(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  PipeDataForm  : TPipeDataForm;
  _WellMaxPipes : integer;
  _WellPipe     : array[1..4,1..4] of real;

implementation

{$R *.lfm}

{ TPipeDataForm }

{ ------------- Edit Procedures ------------ }

procedure TPipeDataForm.NumericOnlyKeyPress(Sender: TObject; var Key: Char);
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

procedure TPipeDataForm.NumPipeSectionsComboBoxChange(Sender: TObject);
begin
  case NumPipeSectionsComboBox.ItemIndex of
    0: Begin
         _WellMaxPipes:=1;
         DrillCollarLengthData.Enabled:=True;
         //DrillCollarLengthData.Text:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));  { API->user depth }
         DrillCollarIDData.Enabled:=True;
         //DrillCollarIDData.Text:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));  { inches }
         DrillCollarODData.Enabled:=True;
         //DrillCollarODData.Text:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));  { inches }
         DrillCollarWeightData.Enabled:=True;
         //DrillCollarWeightData.Text:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }

         HWDrillPipeLengthData.Enabled:=False;
         //HWDrillPipeLengthData.Text:=FloatToStr(0);  { user depth }
         HWDrillPipeIDData.Enabled:=False;
         //HWDrillPipeIDData.Text:=FloatToStr(0);  { inches }
         HWDrillPipeODData.Enabled:=False;
         //HWDrillPipeODData.Text:=FloatToStr(0);  { inches }
         HWDrillPipeWeightData.Enabled:=False;
         //HWDrillPipeWeightData.Text:=FloatToStr(0);  { lbs/ft }

         DrillPipeLengthData.Enabled:=False;
         //DrillPipeLengthData.Text:=FloatToStr(0);  { user depth }
         DrillPipeIDData.Enabled:=False;
         //DrillPipeIDData.Text:=FloatToStr(0);  { inches }
         DrillPipeODData.Enabled:=False;
         //DrillPipeODData.Text:=FloatToStr(0);  { inches }
         DrillPipeWeightData.Enabled:=False;
         //DrillPipeWeightData.Text:=FloatToStr(0);  { lbs/ft }
       end;

    1: Begin
         _WellMaxPipes:=2;
         DrillCollarLengthData.Enabled:=True;
//         DrillCollarLengthData.Text:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));  { API->user depth }
         DrillCollarIDData.Enabled:=True;
//         DrillCollarIDData.Text:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));  { inches }
         DrillCollarODData.Enabled:=True;
//         DrillCollarODData.Text:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));  { inches }
         DrillCollarWeightData.Enabled:=True;
//         DrillCollarWeightData.Text:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }

         HWDrillPipeLengthData.Enabled:=True;
//         HWDrillPipeLengthData.Text:=FloatToStr(Round2(Data.Pipe[2,1]*UoMConverter[1],2));  { API->user depth }
         HWDrillPipeIDData.Enabled:=True;
//         HWDrillPipeIDData.Text:=FloatToStr(Round2(Data.Pipe[2,2]*UoMConverter[8],4));  { inches }
         HWDrillPipeODData.Enabled:=True;
//         HWDrillPipeODData.Text:=FloatToStr(Round2(Data.Pipe[2,3]*UoMConverter[8],4));  { inches }
         HWDrillPipeWeightData.Enabled:=True;
//         HWDrillPipeWeightData.Text:=FloatToStr(Round2(Data.Pipe[2,4],2));  { lbs per foot }

         DrillPipeLengthData.Enabled:=False;
         //DrillPipeLengthData.Text:=FloatToStr(0);  { user depth }
         DrillPipeIDData.Enabled:=False;
         //DrillPipeIDData.Text:=FloatToStr(0);  { inches }
         DrillPipeODData.Enabled:=False;
         //DrillPipeODData.Text:=FloatToStr(0);  { inches }
         DrillPipeWeightData.Enabled:=False;
         //DrillPipeWeightData.Text:=FloatToStr(0);  { lbs/ft }
       end;

    2: Begin
         _WellMaxPipes:=3;
         DrillCollarLengthData.Enabled:=True;
//         DrillCollarLengthData.Text:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));  { API->user depth }
         DrillCollarIDData.Enabled:=True;
//         DrillCollarIDData.Text:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));  { inches }
         DrillCollarODData.Enabled:=True;
//         DrillCollarODData.Text:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));  { inches }
         DrillCollarWeightData.Enabled:=True;
//         DrillCollarWeightData.Text:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }

         HWDrillPipeLengthData.Enabled:=True;
//         HWDrillPipeLengthData.Text:=FloatToStr(Round2(Data.Pipe[2,1]*UoMConverter[1],2));  { API->user depth }
         HWDrillPipeIDData.Enabled:=True;
//         HWDrillPipeIDData.Text:=FloatToStr(Round2(Data.Pipe[2,2]*UoMConverter[8],4));  { inches }
         HWDrillPipeODData.Enabled:=True;
//         HWDrillPipeODData.Text:=FloatToStr(Round2(Data.Pipe[2,3]*UoMConverter[8],4));  { inches }
         HWDrillPipeWeightData.Enabled:=True;
//         HWDrillPipeWeightData.Text:=FloatToStr(Round2(Data.Pipe[2,4],2));  { lbs per foot }

         DrillPipeLengthData.Enabled:=True;
//         DrillPipeLengthData.Text:=FloatToStr(Round2(Data.Pipe[3,1]*UoMConverter[1],2));  { API->user depth }
         DrillPipeIDData.Enabled:=True;
//         DrillPipeIDData.Text:=FloatToStr(Round2(Data.Pipe[3,2]*UoMConverter[8],4));  { inches }
         DrillPipeODData.Enabled:=True;
//         DrillPipeODData.Text:=FloatToStr(Round2(Data.Pipe[3,3]*UoMConverter[8],4));  { inches }
         DrillPipeWeightData.Enabled:=True;
//         DrillPipeWeightData.Text:=FloatToStr(Round2(Data.Pipe[3,4],2));  { lbs per foot }
       end;
  end;
end;

procedure TPipeDataForm.DrillCollarLengthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[1,1]:=Round2(StrToFloat(DrillCollarLengthData.Text)/UoMConverter[1],2); { User->API depth }
end;

procedure TPipeDataForm.DrillCollarIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[1,2]:=Round2(StrToFloat(DrillCollarIDData.Text)/UoMConverter[8],4); { inches }
end;

procedure TPipeDataForm.DrillCollarODDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[1,3]:=Round2(StrToFloat(DrillCollarODData.Text)/UoMConverter[8],4); { inches }
end;

procedure TPipeDataForm.DrillCollarWeightDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[1,4]:=Round2(StrToFloat(DrillCollarWeightData.Text),4); { lbs/ft }
end;

procedure TPipeDataForm.HWDrillPipeLengthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[2,1]:=Round2(StrToFloat(HWDrillPipeLengthData.Text)/UoMConverter[1],2); { User->API depth }
end;

procedure TPipeDataForm.HWDrillPipeIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[2,2]:=Round2(StrToFloat(HWDrillPipeIDData.Text)/UoMConverter[8],4); { inches }
end;

procedure TPipeDataForm.HWDrillPipeODDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[2,3]:=Round2(StrToFloat(HWDrillPipeODData.Text)/UoMConverter[8],4); { inches }
end;

procedure TPipeDataForm.HWDrillPipeWeightDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[2,4]:=Round2(StrToFloat(HWDrillPipeWeightData.Text),4); { lbs/ft }
end;

procedure TPipeDataForm.DrillPipeLengthDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[3,1]:=Round2(StrToFloat(DrillPipeLengthData.Text)/UoMConverter[1],2); { User->API depth }
end;

procedure TPipeDataForm.DrillPipeIDDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[3,2]:=Round2(StrToFloat(DrillPipeIDData.Text)/UoMConverter[8],4); { inches }
end;

procedure TPipeDataForm.DrillPipeODDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[3,3]:=Round2(StrToFloat(DrillPipeODData.Text)/UoMConverter[8],4); { inches }
end;

procedure TPipeDataForm.DrillPipeWeightDataChange(Sender: TObject);
begin
  if not ((TEdit(Sender).Text = '-')
      or (TEdit(Sender).Text = DefaultFormatSettings.DecimalSeparator)
      or (TEdit(Sender).Text = ''))
          then _WellPipe[3,4]:=Round2(StrToFloat(DrillPipeWeightData.Text),4); { lbs/ft }
end;

{ ------------------ Form procedures ---------------------- }

procedure TPipeDataForm.FormActivate(Sender: TObject);
begin
  StringToMemo('Form Drill String Profile Data activated...........................');

  // units of measure labels


  PipeLengthUoMLabel.Caption:=UoMLabel[1];   { user depth }
  PipeIDUoMLabel.Caption:=UoMLabel[8];       { inches }
  PipeODUoMLabel.Caption:=UoMLabel[8];       { inches }

  // data

    _WellMaxPipes:=Data.MaxPipes;
    case Data.MaxPipes of
      1: Begin
           NumPipeSectionsComboBox.ItemIndex:=0;
           DrillCollarLengthData.Enabled:=True;
           DrillCollarLengthData.Text:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));  { API->user depth }
           _WellPipe[1,1]:=Data.Pipe[1,1]; { API internal }

           DrillCollarIDData.Enabled:=True;
           DrillCollarIDData.Text:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));  { inches }
           _WellPipe[1,2]:=Data.Pipe[1,2]; {API internal }

           DrillCollarODData.Enabled:=True;
           DrillCollarODData.Text:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));  { inches }
           _WellPipe[1,3]:=Data.Pipe[1,3]; {API internal }

           DrillCollarWeightData.Enabled:=True;
           DrillCollarWeightData.Text:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }
           _WellPipe[1,4]:=Data.Pipe[1,4]; {API internal }


           HWDrillPipeLengthData.Enabled:=False;
           //HWDrillPipeLengthData.Text:=FloatToStr(0);  { user depth }
           HWDrillPipeIDData.Enabled:=False;
           //HWDrillPipeIDData.Text:=FloatToStr(0);  { inches }
           HWDrillPipeODData.Enabled:=False;
           //HWDrillPipeODData.Text:=FloatToStr(0);  { inches }
           HWDrillPipeWeightData.Enabled:=False;
           //HWDrillPipeWeightData.Text:=FloatToStr(0);  { lbs/ft }

           DrillPipeLengthData.Enabled:=False;
           //DrillPipeLengthData.Text:=FloatToStr(0);  { user depth }
           DrillPipeIDData.Enabled:=False;
           //DrillPipeIDData.Text:=FloatToStr(0);  { inches }
           DrillPipeODData.Enabled:=False;
           //DrillPipeODData.Text:=FloatToStr(0);  { inches }
           DrillPipeWeightData.Enabled:=False;
           //DrillPipeWeightData.Text:=FloatToStr(0);  { lbs/ft }
         end;

      2: Begin
           NumPipeSectionsComboBox.ItemIndex:=1;
           DrillCollarLengthData.Enabled:=True;
           DrillCollarLengthData.Text:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));  { API->user depth }
           _WellPipe[1,1]:=Data.Pipe[1,1]; { API internal }

           DrillCollarIDData.Enabled:=True;
           DrillCollarIDData.Text:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));  { inches }
           _WellPipe[1,2]:=Data.Pipe[1,2]; {API internal }

           DrillCollarODData.Enabled:=True;
           DrillCollarODData.Text:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));  { inches }
           _WellPipe[1,3]:=Data.Pipe[1,3]; {API internal }

           DrillCollarWeightData.Enabled:=True;
           DrillCollarWeightData.Text:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }
           _WellPipe[1,4]:=Data.Pipe[1,4]; {API internal }


           HWDrillPipeLengthData.Enabled:=True;
           HWDrillPipeLengthData.Text:=FloatToStr(Round2(Data.Pipe[2,1]*UoMConverter[1],2));  { API->user depth }
           _WellPipe[2,1]:=Data.Pipe[2,1]; {API internal }

           HWDrillPipeIDData.Enabled:=True;
           HWDrillPipeIDData.Text:=FloatToStr(Round2(Data.Pipe[2,2]*UoMConverter[8],4));  { inches }
           _WellPipe[2,2]:=Data.Pipe[2,2]; {API internal }

           HWDrillPipeODData.Enabled:=True;
           HWDrillPipeODData.Text:=FloatToStr(Round2(Data.Pipe[2,3]*UoMConverter[8],4));  { inches }
           _WellPipe[2,3]:=Data.Pipe[2,3]; {API internal }

           HWDrillPipeWeightData.Enabled:=True;
           HWDrillPipeWeightData.Text:=FloatToStr(Round2(Data.Pipe[2,4],2));  { lbs per foot }
           _WellPipe[2,4]:=Data.Pipe[2,4]; {API internal }


           DrillPipeLengthData.Enabled:=False;
           //DrillPipeLengthData.Text:=FloatToStr(0);  { user depth }
           DrillPipeIDData.Enabled:=False;
           //DrillPipeIDData.Text:=FloatToStr(0);  { inches }
           DrillPipeODData.Enabled:=False;
           //DrillPipeODData.Text:=FloatToStr(0);  { inches }
           DrillPipeWeightData.Enabled:=False;
           //DrillPipeWeightData.Text:=FloatToStr(0);  { lbs/ft }
         end;

      3: Begin
           NumPipeSectionsComboBox.ItemIndex:=2;
           DrillCollarLengthData.Enabled:=True;
           DrillCollarLengthData.Text:=FloatToStr(Round2(Data.Pipe[1,1]*UoMConverter[1],2));  { API->user depth }
           _WellPipe[1,1]:=Data.Pipe[1,1]; { API internal }

           DrillCollarIDData.Enabled:=True;
           DrillCollarIDData.Text:=FloatToStr(Round2(Data.Pipe[1,2]*UoMConverter[8],4));  { inches }
           _WellPipe[1,2]:=Data.Pipe[1,2]; {API internal }

           DrillCollarODData.Enabled:=True;
           DrillCollarODData.Text:=FloatToStr(Round2(Data.Pipe[1,3]*UoMConverter[8],4));  { inches }
           _WellPipe[1,3]:=Data.Pipe[1,3]; {API internal }

           DrillCollarWeightData.Enabled:=True;
           DrillCollarWeightData.Text:=FloatToStr(Round2(Data.Pipe[1,4],2));  { lbs per foot }
           _WellPipe[1,4]:=Data.Pipe[1,4]; {API internal }


           HWDrillPipeLengthData.Enabled:=True;
           HWDrillPipeLengthData.Text:=FloatToStr(Round2(Data.Pipe[2,1]*UoMConverter[1],2));  { API->user depth }
           _WellPipe[2,1]:=Data.Pipe[2,1]; {API internal }

           HWDrillPipeIDData.Enabled:=True;
           HWDrillPipeIDData.Text:=FloatToStr(Round2(Data.Pipe[2,2]*UoMConverter[8],4));  { inches }
           _WellPipe[2,2]:=Data.Pipe[2,2]; {API internal }

           HWDrillPipeODData.Enabled:=True;
           HWDrillPipeODData.Text:=FloatToStr(Round2(Data.Pipe[2,3]*UoMConverter[8],4));  { inches }
           _WellPipe[2,3]:=Data.Pipe[2,3]; {API internal }

           HWDrillPipeWeightData.Enabled:=True;
           HWDrillPipeWeightData.Text:=FloatToStr(Round2(Data.Pipe[2,4],2));  { lbs per foot }
           _WellPipe[2,4]:=Data.Pipe[2,4]; {API internal }


           DrillPipeLengthData.Enabled:=True;
           DrillPipeLengthData.Text:=FloatToStr(Round2(Data.Pipe[3,1]*UoMConverter[1],2));  { API->user depth }
           _WellPipe[3,1]:=Data.Pipe[3,1]; {API internal }

           DrillPipeIDData.Enabled:=True;
           DrillPipeIDData.Text:=FloatToStr(Round2(Data.Pipe[3,2]*UoMConverter[8],4));  { inches }
           _WellPipe[3,2]:=Data.Pipe[3,2]; {API internal }

           DrillPipeODData.Enabled:=True;
           DrillPipeODData.Text:=FloatToStr(Round2(Data.Pipe[3,3]*UoMConverter[8],4));  { inches }
           _WellPipe[3,3]:=Data.Pipe[3,3]; {API internal }

           DrillPipeWeightData.Enabled:=True;
           DrillPipeWeightData.Text:=FloatToStr(Round2(Data.Pipe[3,4],2));  { lbs per foot }
           _WellPipe[3,4]:=Data.Pipe[3,4]; {API internal }

         end;
    end;

end;


procedure TPipeDataForm.FormCreate(Sender: TObject);
begin
  StringToMemo('FormPipeData : TPipeDataForm.FormCreate');

end;

procedure TPipeDataForm.QuitButtonClick(Sender: TObject);
begin
  StringToMemo('FormPipeData.Quit ..............................................');
  Close;
end;


procedure TPipeDataForm.FormDeactivate(Sender: TObject);
begin     { Also called on QuitButton }
  StringToMemo('FormPipeData.Deactivate ........................................');
end;

procedure TPipeDataForm.SaveButtonClick(Sender: TObject);
var Error : boolean;

  { Validate pipe section input : 3 functions }
  { ------------- Drill Collar Checks ----------------}
  Function DrillCollarsisOK : boolean;
  var
    LengthisOK : boolean;
    IDisOK : boolean;
    ODisOK : boolean;
    WeightisOK : boolean;
  Begin
    StringToMemo('Validating Drill Collars...');

    if (_WellPipe[1,1] <= 0) or                                               { length cannot be zero }
       ((_WellPipe[1,1] >= Data.CasingTD) and (Data.MaxHoles=0)) or           { total pipe length must not exceed Casing Shoe TD if no open hole section }
       ((_WellPipe[1,1] >= Data.Hole[Data.MaxHoles,1]) and (Data.MaxHoles>0)) { total pipe length must not exceed TD of lowest hole section if present }
    then
    Begin
      ShowMessage('Drill Collars length must be greater than zero, must not exceed Casing Shoe TD if no open hole section or TD of lowest hole section if present');
      StringToMemo('FormHoleData.Save: Error: Drill Collars length must be greater than zero, must not exceed Casing Shoe TD if no open hole section or TD of lowest hole section if present');
      DrillCollarLengthData.SetFocus;
      LengthisOK:=False;
    end
    else
    Begin
      Data.Pipe[1,1]:=_WellPipe[1,1];  { API depth }
      StringToMemo('FormPipeData.Save: Data.Pipe[1,1] = '+ DrillCollarLengthData.Text + ' ' + UoMLabel[1]); { Displayed depth }
      LengthisOK:=True;
    End;

    if (_WellPipe[1,2] >= _WellPipe[1,3]) or       { Drill Collar ID must be less than Drill Collar OD }
       (_WellPipe[1,2] <= 0)                       { ID cannot be zero }
    then
    Begin
      ShowMessage('Drill Collar ID must be less than Drill Collar OD and greater than zero');
      StringToMemo('FormPipeData.Save: Error: Drill Collar ID must be less than Drill Collar OD and greater than zero');
      DrillCollarIDData.SetFocus;
      IDisOK:=False;
    end
    else
    Begin
      Data.Pipe[1,2]:=_WellPipe[1,2];
      StringToMemo('FormPipeData.Save: Data.Pipe[1,2] = '+ DrillCollarIDData.Text + ' ' + UoMLabel[8]); { inches }
      IDisOK:=True;
    End;

    if ((_WellPipe[1,3] > Data.Hole[Data.MaxHoles,2]) and (Data.MaxHoles>0)) or { Drill Collar OD must be less than smallest hole ID }
       (_WellPipe[1,3] <= 0)                                                    { OD cannot be zero }
    then
    Begin
      ShowMessage('Drill Collar OD must be less than the smallest open hole ID and greater than zero');
      StringToMemo('FormPipeData.Save: Error: Drill Collar OD must be less than the smallest open hole ID and greater than zero');
      DrillCOllarODData.SetFocus;
      ODisOK:=False;
    end
    else
    Begin
      Data.Pipe[1,3]:=_WellPipe[1,3];
      StringToMemo('FormPipeData.Save: Data.Pipe[1,3] = '+ DrillCollarODData.Text + ' ' + UoMLabel[8]); { inches }
      ODisOK:=True;
    End;

    if (_WellPipe[1,4] <= 0)                                             { weight per foot cannot be zero }
    then
    Begin
      ShowMessage('Drill Collar weight per foot must be greater than zero');
      StringToMemo('FormPipeData.Save: Error: Drill Collar weight per foot must be greater than zero');
      DrillCollarWeightData.SetFocus;
      WeightisOK:=False;
    end
    else
    Begin
      Data.Pipe[1,4]:=_WellPipe[1,4];
      StringToMemo('FormPipeData.Save: Data.Pipe[1,4] = '+ DrillCollarWeightData.Text + ' lbs per foot'); { lbs per foot }
      WeightisOK:=True;
    End;

    if (LengthisOK and IDisOK and ODisOK and WeightisOK) then
    Begin
      DrillCollarsisOK:=True;
      StringToMemo('DrillCollarsisOK: Success');
    End
    else
    Begin
      DrillCollarsisOK:=False;
      StringToMemo('DrillCollarsisOK: Fail');
    End;
  end;

  { ------------- HW Drill Pipe Checks ----------------}
  Function HWDrillPipeisOK : boolean;
  var
    LengthisOK : boolean;
    IDisOK : boolean;
    ODisOK : boolean;
    WeightisOK : boolean;
  Begin
    StringToMemo('Validating HW Drill Pipes...');

    if (_WellPipe[2,1] <= 0) or                                                    { length cannot be zero }
       ((_WellPipe[1,1]+_WellPipe[2,1] >= Data.CasingTD) and (Data.MaxHoles=0)) or { total pipe length must not exceed Casing Shoe TD if no open hole section }
       ((_WellPipe[1,1]+_WellPipe[2,1] >= Data.Hole[Data.MaxHoles,1]) and (Data.MaxHoles>0))      { total pipe length must not exceed TD of lowest hole section if present }
    then
    Begin
      ShowMessage('HW Drill Pipe length must be greater than zero, and combined length with Drill Collars must not exceed Casing Shoe TD (if no open hole section) or TD of lowest hole section (if present)');
      StringToMemo('FormHoleData.Save: Error: HW Drill Pipe length must be greater than zero, and combined length with Drill Collars must not exceed Casing Shoe TD (if no open hole section) or TD of lowest hole section (if present)');
      HWDrillPipeLengthData.SetFocus;
      LengthisOK:=False;
    end
    else
    Begin
      Data.Pipe[2,1]:=_WellPipe[2,1];  { API depth }
      StringToMemo('FormPipeData.Save: Data.Pipe[2,1] = '+ HWDrillPipeLengthData.Text + ' ' + UoMLabel[1]); { Displayed depth }
      LengthisOK:=True;
    End;

    if (_WellPipe[2,2] >= _WellPipe[2,3]) or       { HW Drill Pipe ID must be less than OD }
       (_WellPipe[2,2] <= 0)                       { ID cannot be zero }
    then
    Begin
      ShowMessage('HW Drill Pipe ID must be less than HW Drill Pipe OD and greater than zero');
      StringToMemo('FormPipeData.Save: Error: HW Drill Pipe ID must be less than HW Drill Pipe OD and greater than zero');
      HWDrillPipeIDData.SetFocus;
      IDisOK:=False;
    end
    else
    Begin
      Data.Pipe[2,2]:=_WellPipe[2,2];
      StringToMemo('FormPipeData.Save: Data.Pipe[2,2] = '+ HWDrillPipeIDData.Text + ' ' + UoMLabel[8]); { inches }
      IDisOK:=True;
    End;

    if (_WellPipe[2,3] > _WellPipe[1,3]) or      { HW Drill Pipe OD must be less than or equeal to DC OD }
       (_WellPipe[1,3] <= 0)                     { OD cannot be zero }
    then
    Begin
      ShowMessage('HW Drill Pipe OD must be less than or equal to DC OD and greater than zero');
      StringToMemo('FormPipeData.Save: Error: HW Drill Pipe OD must be less than or equal to DC OD and greater than zero');
      HWDrillPipeODData.SetFocus;
      ODisOK:=False;
    end
    else
    Begin
      Data.Pipe[2,3]:=_WellPipe[2,3];
      StringToMemo('FormPipeData.Save: Data.Pipe[2,3] = '+ HWDrillPipeIDData.Text + ' ' + UoMLabel[8]); { inches }
      ODisOK:=True;
    End;

    if (_WellPipe[2,4] <= 0)                                             { weight per foot cannot be zero }
    then
    Begin
      ShowMessage('HW Drill Pipe weight per foot must be greater than zero');
      StringToMemo('FormPipeData.Save: Error: HW Drill Pipe weight per foot must be greater than zero');
      HWDrillPipeWeightData.SetFocus;
      WeightisOK:=False;
    end
    else
    Begin
      Data.Pipe[2,4]:=_WellPipe[2,4];
      StringToMemo('FormPipeData.Save: Data.Pipe[2,4] = '+ HWDrillPipeIDData.Text + ' lbs per foot'); { lbs per foot }
      WeightisOK:=True;
    End;

    if (LengthisOK and IDisOK and ODisOK and WeightisOK) then
    Begin
      HWDrillPipeisOK:=True;
      StringToMemo('HWDrillPipeisOK: Success');
    End
    else
    Begin
      HWDrillPipeisOK:=False;
      StringToMemo('HWDrillPipeisOK: Fail');
    End;
  end;

    { ------------- Drill Pipe Checks ----------------}
  Function DrillPipeisOK : boolean;
  var
    LengthisOK : boolean;
    IDisOK : boolean;
    ODisOK : boolean;
    WeightisOK : boolean;
  Begin
    StringToMemo('Validating Drill Pipe...');

    if (_WellPipe[3,1] <= 0) or                                                    { length cannot be zero }
       ((_WellPipe[1,1]+_WellPipe[2,1]+_WellPipe[3,1] > Data.CasingTD) and (Data.MaxHoles=0)) or { total pipe length must not exceed Casing Shoe TD if no open hole section }
       ((_WellPipe[1,1]+_WellPipe[2,1]+_WellPipe[3,1] > Data.Hole[Data.MaxHoles,1]) and (Data.MaxHoles>0))      { total pipe length must not exceed TD of lowest hole section if present }
    then
    Begin
      ShowMessage('Drill Pipe length must be greater than zero, and combined length with Drill Collars and HW Drill Pipe must not exceed Casing Shoe TD (if no open hole section) or TD of lowest hole section (if present)');
      StringToMemo('FormHoleData.Save: Error: Drill Pipe length must be greater than zero, and combined length with Drill Collars and HW Drill Pipe must not exceed Casing Shoe TD (if no open hole section) or TD of lowest hole section (if present)');
      DrillPipeLengthData.SetFocus;
      LengthisOK:=False;
    end
    else
    Begin
      Data.Pipe[3,1]:=_WellPipe[3,1];   { API depth }
      StringToMemo('FormPipeData.Save: Data.Pipe[3,1] = '+ DrillPipeLengthData.Text + ' ' + UoMLabel[1]); { displayed depth }
      LengthisOK:=True;
    End;

    if (_WellPipe[3,2] >= _WellPipe[3,3]) or       { Drill Pipe ID must be less than OD }
       (_WellPipe[3,2] <= 0)                       { ID cannot be zero }
    then
    Begin
      ShowMessage('Drill Pipe ID must be less than Drill Pipe OD and greater than zero');
      StringToMemo('FormPipeData.Save: Error: Drill Pipe ID must be less than Drill Pipe OD and greater than zero');
      DrillPipeIDData.SetFocus;
      IDisOK:=False;
    end
    else
    Begin
      Data.Pipe[3,2]:=_WellPipe[3,2];
      StringToMemo('FormPipeData.Save: Data.Pipe[3,2] = '+ DrillPipeIDData.Text + ' ' + UoMLabel[8]); { inches }
      IDisOK:=True;
    End;

    if (_WellPipe[3,3] > _WellPipe[2,3]) or      { Drill Pipe OD must be lessthan next lowest pipe OD }
       (_WellPipe[1,3] <= 0)                     { OD cannot be zero }
    then
    Begin
      ShowMessage('Drill Pipe OD must be more than the OD of the next lowest pipe section and greater than zero');
      StringToMemo('FormPipeData.Save: Error: Drill Pipe OD must be more than the OD of the next lowest pipe section and greater than zero');
      DrillPipeODData.SetFocus;
      ODisOK:=False;
    end
    else
    Begin
      Data.Pipe[3,3]:=_WellPipe[3,3];
      StringToMemo('FormPipeData.Save: Data.Pipe[3,3] = '+ DrillPipeIDData.Text + ' ' + UoMLabel[8]); { inches }
      ODisOK:=True;
    End;

    if (_WellPipe[3,4] <= 0)                                             { weight per foot cannot be zero }
    then
    Begin
      ShowMessage('Drill Pipe weight per foot must be greater than zero');
      StringToMemo('FormPipeData.Save: Error: Drill Pipe weight per foot must be greater than zero');
      DrillPipeWeightData.SetFocus;
      WeightisOK:=False;
    end
    else
    Begin
      Data.Pipe[3,4]:=_WellPipe[3,4];
      StringToMemo('FormPipeData.Save: Data.Pipe[3,4] = '+ DrillPipeIDData.Text + ' lbs per foot'); { lbs per foot }
      WeightisOK:=True;
    End;

    if (LengthisOK and IDisOK and ODisOK and WeightisOK) then
    Begin
      DrillPipeisOK:=True;
      StringToMemo('DrillPipeisOK: Success');
    End
    else
    Begin
      DrillPipeisOK:=False;
      StringToMemo('DrillPipeisOK: Fail');
    End;
  end;


begin

  StringToMemo('FormPipeData.Save: Data.MaxPipes = '+ IntToStr(Data.MaxPipes));
  Error:=False;
                           { call boolean functions to check drill string }
  Case _WellMaxPipes of    { very ugly...cant interate through objects, but it works...}
    1 : Begin
          StringToMemo('Checking Drill Collars...');
          if DrillCollarsisOK = False then Error:=True;
        End;
    2 : Begin
          StringToMemo('Checking HW Drill Pipe...');
          if (DrillCollarsisOK = False)
          or (HWDrillPipeisOK = False) then Error:=True;
        End;
    3 : Begin
          StringToMemo('Checking Drill Pipe...');
          if (DrillCollarsisOK = False)
          or (HWDrillPipeisOK = False)
          or (DrillPipeisOK = False) then Error:=True;
        End;
  End;
  if Error=False then StringToMemo('Drill String validation: Success') else
  Begin
    StringToMemo('Drill String validation: Fail');
    Exit;
  End;
  Data.MaxPipes:=_WellMaxPipes;
  Edited:=True;
  Close;
end;


end.

