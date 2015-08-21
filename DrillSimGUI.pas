unit DrillSimGUI;

{$mode objfpc}{$H+}

interface

uses
  cthreads,
  crt,      // for Readkey
  SysUtils, // for FileExists
  Forms,
  Graphics,
  FileUtil,
  Controls,
  Dialogs,
  StdCtrls,
  Menus,
  ExtCtrls,
  LCLType,
  Classes,
  usplashabout,
  DrillSimVariables,
  DrillSimStartup,
  DrillSimFile,
  DrillSimDataResets,
  DrillSimDataInput,
  DrillSimUtilities,
  DrillSimHoleCalc,
  DrillSimMessageToMemo,
  DrillSimUnitsOfMeasure,
  FormDisplayWellData,
  FormGeneralData,
  FormHoleData,
  FormConfigDefaults,
  FormUnitsOfMeasure,
    SimulateCommandProcessor,
  SimulateUpdate,
  SimulateSurfaceControls,
  SimulateFile,
  SimulateHoleCalcs,
  SimulateControl;


type

  { TDrillSim }

  TDrillSim = class(TForm)

    BitData: TGroupBox;
    BitDepthValue: TLabel;
    BitDepthUoM: TStaticText;
    AutoDrillCheckBox: TCheckBox;
    HydrilValue: TLabel;
    BlindRAMsValue: TLabel;
    FlowInValue: TLabel;
    FlowOutValue: TLabel;
    DiffFlowValue: TLabel;
    MenuItem2Geology: TMenuItem;
    MenuItem2Defaults: TMenuItem;
    MenuItem2Units: TMenuItem;
    MenuItem2DisplayWellData: TMenuItem;
    MenuItem2HoleProfile: TMenuItem;
    MenuItem2GeneralData: TMenuItem;
    MenuItem2Preferences: TMenuItem;
    MenuItem3Pause: TMenuItem;
    MenuItem3Stop: TMenuItem;
    MenuItem3Start: TMenuItem;
    MenuItem3Simulate: TMenuItem;
    MenuItem1CreateFile: TMenuItem;
    MenuItem2DrillString: TMenuItem;
    MenuItem2BitData: TMenuItem;
    MenuItem2SurfaceEquipment: TMenuItem;
    MenuItem2PumpData: TMenuItem;
    MenuItem2MudData: TMenuItem;
    MenuItem2WellTestData: TMenuItem;

    FileOpenDialog1: TOpenDialog;
    FileSaveDialog1: TSaveDialog;

    SelectDirectoryDialog1: TSelectDirectoryDialog;
    StandPipePressureValue: TLabel;
    ReturnPitValue: TLabel;
    PipeRamsValue: TLabel;
    ChokeValue: TLabel;
    StandPipePressureUoM: TStaticText;
    CommandLine: TEdit;
    Commands: TGroupBox;
    FlowOutUoM: TStaticText;
    DiffFlowUoM: TStaticText;
    ReturnPitUoM: TStaticText;
    PipeMinus: TButton;
    PipePlus: TButton;
    ChokeMinus: TButton;
    ChokePlus: TButton;
    BOPBox1: TGroupBox;
    FlowBox: TGroupBox;
    KellyDown: TButton;
    KellyUp: TButton;
    KellyHeightText: TLabel;
    DrillingStatusText: TLabel;
    KellyHeightValue: TLabel;
    DrillingStatusValue: TLabel;
    ECDValue: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    MenuItem1Quit: TMenuItem;
    MenuItem4ShowHelp: TMenuItem;
    MenuItem4About: TMenuItem;
    MenuItem4Help: TMenuItem;
    MenuItem1SaveAs: TMenuItem;
    MenuItem1SaveFile: TMenuItem;
    MenuItem2Edit: TMenuItem;
    MenuItem1OpenFile: TMenuItem;
    MenuItem2EditFile: TMenuItem;
    MenuItem1File: TMenuItem;
    MudWeightOutValue: TLabel;
    MudWeightInValue: TLabel;
    MudWeifghtInUoM: TStaticText;
    MudWeightOutUoM: TStaticText;
    MudWeightInText: TStaticText;
    MudWeightOutText: TStaticText;
    ECDText: TStaticText;
    ECDUoM: TStaticText;
    PowerLawRadioButton: TRadioButton;
    BinghamRadioButton: TRadioButton;
    HydrilText: TStaticText;
    BlindRAMsText: TStaticText;
    PipeRAMsText: TStaticText;
    ChokeLineText: TStaticText;
    FlowInText: TStaticText;
    FlowOutText: TStaticText;
    ReturnPitText: TStaticText;
    DiffFlowText: TStaticText;
    StandPipePressureText: TStaticText;
    ROPUoM: TStaticText;
    ChokeUoM: TStaticText;
    FlowInUoM: TStaticText;
    TimeValue: TLabel;
    ROPValue: TLabel;
    ROPText: TLabel;
    PumpStrokesTotalText: TStaticText;
    KellyHeightUoM: TStaticText;
    TimeText: TLabel;
    WOBUoM: TStaticText;
    TotalDepthUoM: TStaticText;
    WOBValue: TLabel;
    TotalDepthValue: TLabel;
    Pump3Plus: TButton;
    Pump3Minus: TButton;
    Pump2Plus: TButton;
    Pump2Minus: TButton;
    PumpStrokesValue: TLabel;
    Pump3Value: TLabel;
    Pump2Value: TLabel;
    Pump1Minus: TButton;
    Pump1Plus: TButton;
    DrillFloor: TGroupBox;
    Pump1Value: TLabel;
    PumpData: TGroupBox;
    DrillingFluids: TGroupBox;
    Messages: TGroupBox;
    BitDepthText: TStaticText;
    PumpStrokesText: TStaticText;
    Pump1Text: TStaticText;
    Pump2Text: TStaticText;
    Pump3Text: TStaticText;
    WeightOnBitText: TStaticText;
    TotalDepthText: TStaticText;
    RPMminus: TButton;
    RPMplus: TButton;
    RPMvalue: TLabel;
    RotaryRPMText: TStaticText;

    procedure AutoDrillCheckBoxChange(Sender: TObject);
    procedure ChokeMinusClick(Sender: TObject);
    procedure ChokePlusClick(Sender: TObject);
    procedure CommandLineClick(Sender: TObject);
    procedure CommandLineKeyPress(Sender: TObject; var Key: char);
    procedure FormActivate(Sender: TObject);
    procedure MenuItem1OpenFileClick(Sender: TObject);
    procedure MenuItem1SaveAsClick(Sender: TObject);
    procedure MenuItem1SaveFileClick(Sender: TObject);
    procedure MenuItem2DefaultsClick(Sender: TObject);
    procedure MenuItem2DisplayWellDataClick(Sender: TObject);
    procedure MenuItem2GeneralDataClick(Sender: TObject);
    procedure MenuItem2GeologyClick(Sender: TObject);
    procedure MenuItem2HoleProfileClick(Sender: TObject);
    procedure MenuItem1CreateFileClick(Sender: TObject);
    procedure MenuItem1QuitClick(Sender: TObject);

    procedure KellyDownClick(Sender: TObject);
    procedure KellyUpClick(Sender: TObject);

    procedure BinghamRadioButtonChange(Sender: TObject);
    procedure MenuItem3StartClick(Sender: TObject);
    procedure MenuItem2DrillStringClick(Sender: TObject);
    procedure MenuItem2BitDataClick(Sender: TObject);
    procedure MenuItem2MudDataClick(Sender: TObject);
    procedure MenuItem2PumpDataClick(Sender: TObject);
    procedure MenuItem2SurfaceEquipmentClick(Sender: TObject);
    procedure MenuItem2WellTestDataClick(Sender: TObject);
    procedure MenuItem2UnitsClick(Sender: TObject);
    procedure PipeMinusClick(Sender: TObject);
    procedure PipePlusClick(Sender: TObject);
    procedure PowerLawRadioButtonChange(Sender: TObject);

    procedure Pump1MinusClick(Sender: TObject);
    procedure Pump1PlusClick(Sender: TObject);
    procedure Pump2MinusClick(Sender: TObject);
    procedure Pump2PlusClick(Sender: TObject);
    procedure Pump3MinusClick(Sender: TObject);
    procedure Pump3PlusClick(Sender: TObject);

    procedure RPMminusClick(Sender: TObject);
    procedure RPMplusClick(Sender: TObject);

    Procedure OnClose(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
    splash:TSplashAbout;
    procedure SetDefaultValues;

  public
    { public declarations }
  end;

  TMyThread = class(TThread)
    private
      ThreadStatus : string;
      procedure ShowStatus;
    protected
      procedure Execute; override;
    public
      Constructor Create(CreateSuspended : boolean);
    end;
var
  DrillSim            : TDrillSim;
  MyThread            : TMyThread;
  DisplayWellDataForm : TDisplayWellDataForm;
  GeneralDataForm     : TGeneralDataForm;
  HoleDataForm        : THoleDataForm;
  UnitsOfMeasureForm  : TUnitsOfMeasureForm;
  SystemDefaultsForm  : TSystemDefaultsForm;

implementation

{$R *.lfm}

{ TDrillSim }

procedure TDrillSim.SetDefaultValues;
begin
  // The splashunit optional properties are normally set in the FormCreate method
  splash.DelaySeconds := 1;
  splash.Title := 'DrillSim3';
  splash.IconFilePath := 'ambersoft-icon.ico';
  splash.BackGroundImageFilePath := 'rig.jpg';
  splash.MaskImageFilePath := 'roundedrect.bmp';
  // Must be .bmp file to make a shaped window
  // Note: if MaskImageFilePath is specified as a .jpg file, the jpg will
  // be automatically converted to a bmp file on first run.
  // Use a graphics app to reduce the bmp's color depth and thus - its file size
  splash.BackGroundColor := clSkyBlue;
  splash.LicenseFilePath := 'dsl.txt';
  splash.LicenseType := 'Copyright';
  splash.CreditString := 'Do Not Distribute';
  splash.Author := 'Simon Ambridge';
  splash.SupportContact := 'simon@ntier-db.com';
end;

Procedure CheckPumps;  { check to see if pumping when adding or }
Begin                  { subtracting pipe }
  if Data.Pumping then
  Begin
    MessageToMemo(68);
    {* LowBeep;
    PumpsOff:=False;       <<<<<<<<<< ERROR MESSAGE REQUIRED *}
    ShowMessage('Oooops');
  End else PumpsOff:=True;
End;

Procedure StringWtCalc;  { recalculate string weight when }
Var i : integer;         { adding or subtracting pipe }
Begin                    { then recalculate pipe displacement }
  With Data do
  Begin
    StrWt:=Zero;
    for i:=1 to MaxPipes do StrWt:=StrWt + (Pipe[i,1] * Pipe[i,4] / 1000);
  End;
End;


{* ========================================================================== *}
procedure TDrillSim.RPMminusClick(Sender: TObject);
begin
  With Data do
  Begin
    RPM:=RPM-1;
    if RPM<Zero then RPM:=Zero;
    RPMValue.Caption:=FloatToStr(RPM);
  end;
end;

procedure TDrillSim.RPMplusClick(Sender: TObject);
begin
  With Data do
  Begin
    //ShowMessage(FloatToStr(KelHt));
    if (KelHt < 33) then
    Begin
      RPM:=RPM+1;
      if RPM>160 then RPM:=160;
      RPMValue.Caption:=FloatToStr(RPM);
    End else
    Begin
      MessageToMemo(52);
    End;
  end;
end;

Procedure TDrillSim.Pump1MinusClick(Sender: TObject);
begin
  With Data do
  Begin
    Pump[1,3]:=Pump[1,3]-1;
    if Pump[1,3]<Zero then Pump[1,3]:=Zero;
    Pump1Value.Caption:=FloatToStr(Pump[1,3]);
  end;
end;

procedure TDrillSim.Pump1PlusClick(Sender: TObject);
begin
  With Data do
  Begin
    Pump[1,3]:=Pump[1,3]+1;
    Pump1Value.Caption:=FloatToStr(Pump[1,3]);
    Memo1.Lines.Add('Pump [1,3]Value ' + FloatToStr(Pump[1,3]));
    Memo1.SelStart:=Length(Memo1.Text);
  end;
 end;

procedure TDrillSim.Pump2MinusClick(Sender: TObject);
begin
    With Data do
    Begin
      Pump[2,3]:=Pump[2,3]-1;
      if Pump[2,3]<Zero then Pump[2,3]:=Zero;
      Pump2Value.Caption:=FloatToStr(Pump[2,3]);
    end;
end;

procedure TDrillSim.Pump2PlusClick(Sender: TObject);
begin
    With Data do
    Begin
      Pump[2,3]:=Pump[2,3]+1;
      Pump2Value.Caption:=FloatToStr(Pump[2,3]);
      Memo1.Lines.Add('Pump [2,3]Value ' + FloatToStr(Pump[2,3]));
      Memo1.SelStart:=Length(Memo1.Text);
    end;
end;

procedure TDrillSim.Pump3MinusClick(Sender: TObject);
begin
    With Data do
    Begin
      Pump[3,3]:=Pump[3,3]-1;
      if Pump[3,3]<Zero then Pump[3,3]:=Zero;
      Pump3Value.Caption:=FloatToStr(Pump[3,3]);
    end;
end;

procedure TDrillSim.Pump3PlusClick(Sender: TObject);
begin
    With Data do
    Begin
      Pump[3,3]:=Pump[3,3]+1;
      Pump3Value.Caption:=FloatToStr(Pump[3,3]);
      Memo1.Lines.Add('Pump [3,3]Value ' + FloatToStr(Pump[3,3]));
      Memo1.SelStart:=Length(Memo1.Text);
    end;
end;

procedure TDrillSim.KellyUpClick(Sender: TObject);
begin
  With Data do
  Begin
    if not ShutIn then  { cannot move kelly if shut in }
    Begin
      if abs(Hole[MaxHoles,1]-BitTD) >= 1
        then KelHt:=KelHt - 0.1
        else KelHt:=KelHt-0.01;
      if KelHt<3 then KelHt:=3;
      DrawKelly;
    End;
  end;
end;

procedure TDrillSim.KellyDownClick(Sender: TObject);
begin
  With Data do
  Begin
    if not ShutIn then  { cannot move kelly if shut in }
    Begin
      if abs(Hole[MaxHoles,1]-BitTD) >= 1
        then KelHt:=KelHt + 0.1
        else KelHt:=KelHt+0.01;
      if KelHt>33 then KelHt:=33;
      DrawKelly;
    End;
  End;

end;

procedure TDrillSim.ChokeMinusClick(Sender: TObject);
begin
  With Data do
  Begin
    Choke:=Choke - 1;
    if Choke=4 then CloseChoke;
    if Choke < 5 then Choke:=Zero;
    if Choke = Zero then
    Begin
      DeltaCsgPr:=DeltaCsgPr + PlChoke;
      PlChoke:=Zero;
    End;
  End;
end;

procedure TDrillSim.ChokePlusClick(Sender: TObject);
begin
  With Data do
  Begin
    Choke:=Choke + 1;
    if Choke < 5 then Choke:=5;
    if Choke = 5 then OpenChoke;
    if Choke>100 then Choke:=100;
  End;
End;

procedure TDrillSim.PipeMinusClick(Sender: TObject);
begin
  With Data do
  Begin
  if (KelHt=33) and (Pipe[MaxPipes,1] >27) then
  Begin
    CheckPumps;
    if PumpsOff then Pipe[MaxPipes,1]:=Pipe[MaxPipes,1] - 27;
    StringWtCalc;
  End;
End;

end;

procedure TDrillSim.PipePlusClick(Sender: TObject);
begin
  With Data do
  Begin
  if (KelHt=33) and (Hole[MaxHoles,1] - BitTD >=27) then
  Begin
    CheckPumps;
    if PumpsOff then
    Begin
      Pipe[MaxPipes,1]:=Pipe[MaxPipes,1] + 27;
      LastKD:=Hole[MaxHoles,1];
      StringWtCalc;
    End;
  End;
End;

end;

procedure TDrillSim.PowerLawRadioButtonChange(Sender: TObject);
begin

end;

procedure TDrillSim.BinghamRadioButtonChange(Sender: TObject);
begin

end;

procedure TDrillSim.AutoDrillCheckBoxChange(Sender: TObject);
begin
  With Data do
  Begin
  AutoDrill:=not AutoDrill;
  if AutoDrill then MessageToMemo(1) else MessageToMemo(2);
  End;
end;


{* ======================= Memo Input ======================================= *}

procedure TDrillSim.CommandLineKeyPress(Sender: TObject; var Key: char);
begin
  if Key=^M then      // if ENTER
  Begin
    if length(InputString) > Zero then   // display it
    Begin
      Memo1.Lines.Add('>' + InputString);
      Memo1.SelStart:=Length(Memo1.Text);
      CommandProcessor;        { Command - process it          }
      InputString:='';
    End;
  End else
  if Key=#8 then                // if BACKSPACE
  Begin
    InputString:=copy(InputString,1,length(InputString)-1);
  end else
  Begin                         // else add to InputString
    InputString:=InputString + Key;
  End;

  CommandLine.Text := InputString;    // update text entry
  CommandLine.SelStart:=Length(CommandLine.Text);
  writeln(InputString);
  Key:=#0;
end;

procedure TDrillSim.CommandLineClick(Sender: TObject);
begin
  InputString:='';
  CommandLine.Text := InputString;
  CommandLine.SelStart:=Length(CommandLine.Text);
//  writeln('Clicked in TEdit');

end;

{* ======================== Form Controls =========================== *}

procedure TDrillSim.FormActivate(Sender: TObject);
begin
  StringToMemo('Running DrillSimGUI FormActivate...'); // please wait....
  // get paths etc
  //ChDir(LoggedDirectory); currentdirectory, default directory?
  Edited:=False;  { start clean }

  StringToMemo('DrillSimGUI.FormaActivate: Running DrillSim start up sequence');
  StartUp;     { call DrillSim StartUp }
end;


procedure TDrillSim.FormCreate(Sender: TObject);
begin
  Memo1.SelStart:=Length(Memo1.Text);
  StringToMemo('DrillSimGUI.FormaCreate:Running DrillSimGUI FormCreate...');

  splash := TSplashAbout.Create(nil);
  SetDefaultValues; // splash - optional
  splash.ShowSplash;
end;

Procedure TDrillSim.OnClose(Sender: TObject);
var Reply, BoxStyle: Integer;
begin
  if Edited then StringToMemo('Edited') else StringToMemo('Not Edited');
  BoxStyle := MB_ICONQUESTION + MB_YESNO;
  Reply := Application.MessageBox('Are you sure?', 'Exit Check', BoxStyle);
  if Reply = IDYES then
  Begin
    if Edited then
    Begin
      BoxStyle := MB_ICONQUESTION + MB_YESNO;
      Reply := Application.MessageBox('File has been edited. Do you want to save?', 'Save Check', BoxStyle);
      if Reply = IDYES then
      Begin
        SaveData;
        StringToMemo('DrillSimGUI.OnClose: File ' + CurrentFQFileName + ' saved');
      end;
    end;
    Application.Terminate;
  end;
end;

procedure TDrillSim.MenuItem1QuitClick(Sender: TObject);
var Reply, BoxStyle: Integer;
begin
  if Edited then StringToMemo('Edited') else StringToMemo('Not Edited');
  BoxStyle := MB_ICONQUESTION + MB_YESNO;
  Reply := Application.MessageBox('Are you sure?', 'Exit Check', BoxStyle);
  if Reply = IDYES then
  Begin
    if Edited then
    Begin
      BoxStyle := MB_ICONQUESTION + MB_YESNO;
      Reply := Application.MessageBox('File has been edited. Do you want to save?', 'Save Check', BoxStyle);
      if Reply = IDYES then
      Begin
        SaveData;
        StringToMemo('DrillSimGUI.OnClose: File ' + CurrentFQFileName + ' saved');
      end;
    end;
    Application.Terminate;
  end;
end;


{* ======================== Menus =========================== *}

{ ---------------- File Menu Operations ------------------------ }

procedure TDrillSim.MenuItem1OpenFileClick(Sender: TObject);
var
  openDialog : TOpenDialog;    // Open dialog variable
  Reply: Integer;
  BoxStyle: Integer;
begin
  if Edited then
  Begin
    BoxStyle := MB_ICONQUESTION + MB_YESNO;
    Reply := Application.MessageBox('File has been edited. Do you want to save?', 'Save Check', BoxStyle);
    if Reply = IDYES then
    Begin
      SaveData;
      StringToMemo('DrillSimGUI.MenuItem1OpenFileClick: File ' + CurrentFQFileName + ' saved');
    end;
  end;
  CreateNewFile:=False;    { we dont know what sort of file we'll load... }

    // Create the open dialog object - assign to our open dialog variable
  openDialog := TOpenDialog.Create(self);

    // Set up the starting directory to be the current one
  openDialog.InitialDir := GetCurrentDir;

    // Only allow existing files to be selected
  openDialog.Options := [ofFileMustExist];

    // Allow only .dpr and .pas files to be selected
  openDialog.Filter :=
      'DrillSim Well files|*.wdf';

    // Select pascal files as the starting filter type
  openDialog.FilterIndex := 2;

    // Display the open file dialog
  if openDialog.Execute then
  Begin
    CurrentFQFileName:=openDialog.FileName;  // set global active file name variable
    if FileExists(CurrentFQFileName) then
    Begin
        LoadData;
        if not NoFileDefined
          then ShowMessage('File loaded: '+ CurrentFQFileName)
          else ShowMessage('File '+ CurrentFQFileName + ' failed to load successfully!');
    end
    else ShowMessage('File not found!');
      // Free up the dialog
      openDialog.Free;
  end;
end;


procedure TDrillSim.MenuItem1CreateFileClick(Sender: TObject);
begin
  CreateNewFile:=True;
  InitData;                             { Set NeverSimulated }
  APIUnits;                             { Default to API units    }
//  UpdateGen;
  CheckHoleData;         { get hole data and redo pipe/hole screens if error }
  CheckPipeData;         { get pipe data and redo hole/pipe screens if error }
  UpdateBit;
  UpdateMud;
  UpdatePump;
  UpdateSurf;
  UpDateWellTests;
  SaveData;
  CreateNewFile:=False;
end;


procedure TDrillSim.MenuItem1SaveFileClick(Sender: TObject);
begin
  SaveData;
  ShowMessage('File saved: '+CurrentFQFileName);

end;

procedure TDrillSim.MenuItem1SaveAsClick(Sender: TObject);
var
  saveDialog : TSaveDialog;    // Save dialog variable
  Reply, BoxStyle: Integer;
begin
  // Create the save dialog object - assign to our save dialog variable
  saveDialog := TSaveDialog.Create(self);

  // Give the dialog a title
  saveDialog.Title := 'Save Well Data File';

  // Set up the starting directory to be the current one
  saveDialog.InitialDir := GetCurrentDir;

  // Allow only filtered file types to be saved
  saveDialog.Filter := 'DrillSim file|*.wdf|All Files|*.*';

  // Set the default extension
  saveDialog.DefaultExt := 'wdf';

  // Select text files as the starting filter type
  saveDialog.FilterIndex := 1;

  // Display the open file dialog
  if saveDialog.Execute then
  Begin
    CurrentFQFileName:=saveDialog.FileName;  // set global active file name variable
    if FileExists(CurrentFQFileName) then
    Begin
      BoxStyle := MB_ICONQUESTION + MB_YESNO;
      Reply := Application.MessageBox(pchar('Overwrite '+CurrentFQFileName + '?'), 'File Exists!', BoxStyle);
      if Reply = IDYES then
      Begin
        CreateNewFile:=False;
        SaveData;
      end else
      Begin
        StringToMemo('DrillSimGUI.MenuItem1SaveAsClick: File exists, save cancelled');
        ShowMessage('File exists, save cancelled');
      end;
    end else
    Begin
      CreateNewFile:=True;
      SaveData;
    end;
  end else
  Begin
    StringToMemo('DrillSimGUI.MenuItem1SaveAsClick: Save cancelled');
    ShowMessage('Save cancelled');
  end;
  saveDialog.Free; // Free up the dialog
end;


{ --------------- Edit Well Menu Options ------------------------ }

procedure TDrillSim.MenuItem2DisplayWellDataClick(Sender: TObject);
begin
  try
    DisplayWellDataForm:=TDisplayWellDataForm.Create(Nil);  //DisplayWellData is created
    DisplayWellDataForm.ShowModal;
  finally
    DisplayWellDataForm.Free;
end;

end;

procedure TDrillSim.MenuItem2GeneralDataClick(Sender: TObject);
begin
  try
    GeneralDataForm:=TGeneralDataForm.Create(Nil);  //General Data Input is created
    GeneralDataForm.ShowModal;
  finally
    GeneralDataForm.Free;
  end;

end;

procedure TDrillSim.MenuItem2HoleProfileClick(Sender: TObject);
begin
  try
    HoleDataForm:=THoleDataForm.Create(Nil);  //Hole Data Input is created
    HoleDataForm.ShowModal;
  finally
    HoleDataForm.Free;
  end;

end;

procedure TDrillSim.MenuItem2DrillStringClick(Sender: TObject);
begin
  CheckPipeData;
end;

procedure TDrillSim.MenuItem2BitDataClick(Sender: TObject);
begin
  UpdateBit;
end;

procedure TDrillSim.MenuItem2MudDataClick(Sender: TObject);
begin
  UpdateMud;
end;

procedure TDrillSim.MenuItem2PumpDataClick(Sender: TObject);
begin
  UpdatePump;
end;

procedure TDrillSim.MenuItem2SurfaceEquipmentClick(Sender: TObject);
begin
  UpdateSurf;
end;

procedure TDrillSim.MenuItem2WellTestDataClick(Sender: TObject);
begin
  UpdateWellTests;
end;

procedure TDrillSim.MenuItem2GeologyClick(Sender: TObject);
begin

end;

{ ---------- Preferences Menu Options -------------------------- }

procedure TDrillSim.MenuItem2DefaultsClick(Sender: TObject);
begin
  try
    SystemDefaultsForm:=TSystemDefaultsForm.Create(Nil);  //Hole Data Input is created
    SystemDefaultsForm.ShowModal;
  finally
    SystemDefaultsForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2UnitsClick(Sender: TObject);  // UoM
begin
  try
    UnitsOfMeasureForm:=TUnitsOfMeasureForm.Create(Nil);
    UnitsOfMeasureForm.ShowModal;
  finally
    UnitsOfMeasureForm.Free;
  end;

end;

{ ----------- Simulate Menu Options ---------------------------- }

procedure TDrillSim.MenuItem3StartClick(Sender: TObject);
begin
  MessageToMemo(100);               { courtesy message         }
  if NoFileDefined=false then
  Begin
    if NoFileDefined then           { check for no file in use               }
    Begin
      CurrentFQFileName:='no file';          { set file name for load window          }
      MenuItem1OpenFileClick(nil);                     { and go prompt for one                  }
    End;

    if not NoFileDefined then       { if file defined, continue into Simulator }
    Begin
      InitMud;                      { set the system OriginalMudWt etc.      }

      InitDepth;                    { depths used for reset are the current  }
                                   { depths at the start of this session    }
                                   { which may not be the original depths   }

      InitKick;                     { Set up and initialise if NeverSimulated }

      InitGeology;                  { find current position within geological}
                                   { table. Also done on Load and Clear     }
      GetCurrentTime (t);
      Data.t2:=t.Seconds;             { initialize time                    }

      SimHoleCalc;                    { calculate volumes                  }

      FlowUpdate;                     { set up flow in                     }
      //InitialiseKelly;                { draw it at the top                 }
      SetKelly;                       { move kelly to drilling position    }
      SetSurfControls;                { set RAMs and choke line            }


      // THIS GOES IN THE THREAD !!!
      //Control;                        { Call simulater controller, fall    }
                                     { through to SelectMenu when Quit=T  }

    End;                              { still no file, then return to DrillSim }
  End;

                                   { Edited set to FALSE when a file is     }
                                   { loaded. Therefore the start up file    }
                                   { and any subsequently loaded will be    }
                                   { able to detect if the data is altered  }
                                   { even when going in and out of DrillSim }
   // StartUp;                { convert back to DrillSim units and load help     }
End;



{* ============================ Threads ================================= *}

constructor TMyThread.Create(CreateSuspended : boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
  writeln('Thread created');
end;

procedure TMyThread.ShowStatus;
// this method is executed by the mainthread and can therefore access all GUI elements.
begin
  DrillSim.Memo1.Lines.Add('Thread Interrupted because '+ ThreadStatus);
  writeln ('Thread Interrupted'+ ThreadStatus);

end;

procedure TMyThread.Execute;
var
  NewStatus : string;
begin
  ThreadStatus := 'TMyThread Starting...';
  //writeln ('TMyThread Starting...');
  Synchronize(@Showstatus);
  ThreadStatus := 'TMyThread Running...';
  //writeln ('TMyThread running...');
  Synchronize(@Showstatus);
  while (not Terminated) do
    begin

      {*...
      here goes the code of the main thread loop - loop through calcs as required
      ... *}

      NewStatus:=FloatToStr(Data.Pump[3,3]);

      if NewStatus <> ThreadStatus then
        begin
          ThreadStatus := NewStatus;
          Synchronize(@Showstatus);
        end;
    end;
end;


Initialization
 writeln('DrillSimGUI : Initialization - creating Thread before FormCreate is run');

 MyThread := TMyThread.Create(True); // set True = it doesn't start automatically

 {* Here initialise anything required before the threads starts executing *}

 //MyThread.Start;

end.

