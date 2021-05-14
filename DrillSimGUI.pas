unit DrillSimGUI;

{$mode objfpc}{$H+}

interface

uses
  {$ifdef unix}
    cthreads,
    // cmem, // the c memory manager is on some systems much faster for multi-threading
  {$endif}
  crt,      // for Readkey
  SysUtils, // for FileExists
  Forms,
  Graphics, bcbutton, BCListBox,
  FileUtil, CheckBoxThemed,
  Controls,
  Dialogs,
  StdCtrls,
  Menus,
  ExtCtrls,
  LCLType,
  Classes,
  blcksock,
  usplashabout,

  DrillSimVariables,
  DrillSimStartup,
  DrillSimFile,
  DrillSimDataResets,
  DrillSimUtilities,
  DrillSimHoleChecks,
  DrillSimMessageToMemo,

  FormConfigDefaults,
  FormUnitsOfMeasure,
  FormDisplayWellData,
  FormGeneralData,
  FormHoleData,
  FormPipeData,
  FormBitData,
  FormMudData,
  FormPumpData,
  FormSurfaceEquipmentData,
  FormWellTestData,
  FormGeologyData,

  SimulateCommandProcessor,
  SimulateUpdate,
  SimulateRAMs,
  SimulateHoleCalcs,
  SimulateHydraulicCalcs,
  SimulateDrillingCalcs,
  SimulateKick;

type

  { TDrillSim }

  TDrillSim = class(TForm)
    ChokePLText: TStaticText;
    BitPLText: TStaticText;
    BitHPText: TStaticText;
    AnnularPressureText: TStaticText;
    AnnularPressureUoMLabel: TStaticText;
    AnnularPressureValue: TLabel;
    CirculatingPLText: TStaticText;
    AnnularBHPText: TStaticText;
    MudVolUoM: TStaticText;
    DiffFlowUoMLabel10: TStaticText;
    DiffFlowUoMLabel11: TStaticText;
    DiffFlowUoMLabel12: TStaticText;
    LagUpStrokesUoM: TStaticText;
    PipeDisplacementUoM: TStaticText;
    DiffFlowUoMLabel4: TStaticText;
    DiffFlowUoMLabel5: TStaticText;
    DiffFlowUoMLabel6: TStaticText;
    DiffFlowUoMLabel7: TStaticText;
    DiffFlowUoMLabel8: TStaticText;
    DiffFlowUoMLabel9: TStaticText;
    MudVol: TLabel;
    DiffFlowValue10: TLabel;
    DiffFlowValue11: TLabel;
    DiffFlowValue12: TLabel;
    LagUpStrokes: TLabel;
    PipeDisplacement: TLabel;
    DiffFlowValue4: TLabel;
    DiffFlowValue5: TLabel;
    DiffFlowValue6: TLabel;
    DiffFlowValue7: TLabel;
    DiffFlowValue8: TLabel;
    DiffFlowValue9: TLabel;
    AnnVolUoM: TStaticText;
    LagDownTimeUoM: TStaticText;
    FlowInUoMLabel3: TStaticText;
    FlowInUoMLabel4: TStaticText;
    FlowInUoMLabel5: TStaticText;
    FlowInUoMLabel6: TStaticText;
    FlowInUoMLabel7: TStaticText;
    FlowInUoMLabel8: TStaticText;
    AnnVol: TLabel;
    LagDownTime: TLabel;
    FlowInValue3: TLabel;
    FlowInValue4: TLabel;
    FlowInValue5: TLabel;
    FlowInValue6: TLabel;
    FlowInValue7: TLabel;
    FlowInValue8: TLabel;
    WellVolUoM: TStaticText;
    LagDownStrokesUoM: TStaticText;
    FlowOutUoMLabel3: TStaticText;
    FlowOutUoMLabel4: TStaticText;
    FlowOutUoMLabel5: TStaticText;
    FlowOutUoMLabel6: TStaticText;
    FlowOutUoMLabel7: TStaticText;
    FlowOutUoMLabel8: TStaticText;
    WellVol: TLabel;
    LagDownStrokes: TLabel;
    FlowOutValue3: TLabel;
    FlowOutValue4: TLabel;
    FlowOutValue5: TLabel;
    FlowOutValue6: TLabel;
    FlowOutValue7: TLabel;
    FlowOutValue8: TLabel;
    FormationPressureGradientText: TStaticText;
    BitEffText: TStaticText;
    AverageHhdText: TStaticText;
    PressureLossesText: TStaticText;
    JetVelocityText: TStaticText;
    AnnulusPLText: TStaticText;
    HoleVolUoM: TStaticText;
    ReturnPitUoMLabel10: TStaticText;
    ReturnPitUoMLabel11: TStaticText;
    ReturnPitUoMLabel12: TStaticText;
    ReturnPitUoMLabel13: TStaticText;
    LagUpTimUoM: TStaticText;
    PipeCapacityUoM: TStaticText;
    ReturnPitUoMLabel4: TStaticText;
    ReturnPitUoMLabel5: TStaticText;
    ReturnPitUoMLabel6: TStaticText;
    ReturnPitUoMLabel7: TStaticText;
    ReturnPitUoMLabel8: TStaticText;
    ReturnPitUoMLabel9: TStaticText;
    HoleVol: TLabel;
    ReturnPitValue10: TLabel;
    ReturnPitValue11: TLabel;
    ReturnPitValue12: TLabel;
    ReturnPitValue13: TLabel;
    LagUpTime: TLabel;
    PipeCapacity: TLabel;
    ReturnPitValue4: TLabel;
    ReturnPitValue5: TLabel;
    ReturnPitValue6: TLabel;
    ReturnPitValue7: TLabel;
    ReturnPitValue8: TLabel;
    ReturnPitValue9: TLabel;
    TotalHPText: TStaticText;
    Panel4: TPanel;
    Panel5: TPanel;
    PipePLText: TStaticText;
    ImpactForceText: TStaticText;
    MACPText1: TStaticText;
    PipeHhdText: TStaticText;
    AnulusHhdText: TStaticText;
    SurfaceEquipmentPLText: TStaticText;
    WOHText: TStaticText;
    TotCircStrksText: TStaticText;
    ExcessMudText: TStaticText;
    StringWeightText: TStaticText;
    WellText: TStaticText;
    MudWtInText: TStaticText;
    PipeMudWtText: TStaticText;
    StrokeCounterText: TStaticText;
    AnnularMudWtText: TStaticText;
    AnnularYPText: TStaticText;
    AnnularPVText: TStaticText;
    PipeYPText: TStaticText;
    PipePVText: TStaticText;
    MudWtOutText: TStaticText;
    Panel3: TPanel;
    PipeDisplacementText: TStaticText;
    HoleVolumeText: TStaticText;
    LagDownStrokeText: TStaticText;
    LagUpStrokeText: TStaticText;
    LagUpTimeText: TStaticText;
    MudVolumeText: TStaticText;
    LagDownTimeText: TStaticText;
    PipeCapacityText: TStaticText;
    AutoDrillCheckBox: TCheckBoxThemed;
    CasingPressureText: TStaticText;
    CasingPressureUoMLabel: TStaticText;
    CasingPressureValue: TLabel;
    DataBox: TGroupBox;
    AnnularVolumeText: TStaticText;
    Panel1: TPanel;
    Panel2: TPanel;
    TotStrksText: TStaticText;
    PressureBox: TGroupBox;
    FlowInText: TStaticText;
    PipeMinus: TBCButton;
    KellyUp: TBCButton;
    PipePlus: TBCButton;


    BitData: TGroupBox;
    BitDepthValue: TLabel;
    BitDepthUoMLabel: TStaticText;
    HydrilValue: TLabel;
    BlindRAMsValue: TLabel;
    FlowInValue: TLabel;
    FlowOutValue: TLabel;
    DiffFlowValue: TLabel;
    BushingImage: TImage;
    KellyScale: TImage;
    KellyImage: TImage;

    MainMenu1: TMainMenu;

    MenuItem1File: TMenuItem;
    MenuItem1OpenFile: TMenuItem;
    MenuItem1SaveFile: TMenuItem;
    MenuItem1SaveAs: TMenuItem;
    MenuItem1Quit: TMenuItem;
    MenuItem1CreateFile: TMenuItem;

    MenuItem2Edit: TMenuItem;
    MenuItem2DrillString: TMenuItem;
    MenuItem2BitData: TMenuItem;
    MenuItem2SurfaceEquipment: TMenuItem;
    MenuItem2PumpData: TMenuItem;
    MenuItem2MudData: TMenuItem;
    MenuItem2WellTestData: TMenuItem;
    MenuItem2EditFile: TMenuItem;
    MenuItem2Geology: TMenuItem;
    MenuItem2Defaults: TMenuItem;
    MenuItem2Units: TMenuItem;
    MenuItem2DisplayWellData: TMenuItem;
    MenuItem2HoleProfile: TMenuItem;
    MenuItem2GeneralData: TMenuItem;
    MenuItem2Preferences: TMenuItem;

    MenuItem3Simulate: TMenuItem;
    MenuItem3Pause: TMenuItem;
    MenuItem3Stop: TMenuItem;
    MenuItem3Start: TMenuItem;

    MenuItem4Help: TMenuItem;
    MenuItem4About: TMenuItem;
    MenuItem4ShowHelp: TMenuItem;

    FileOpenDialog1: TOpenDialog;
    FileSaveDialog1: TSaveDialog;
    KellyDown: TBCButton;
    RPMminus: TButton;

    SelectDirectoryDialog1: TSelectDirectoryDialog;
    StandPipePressureText: TStaticText;
    StandPipePressureUoMLabel: TStaticText;
    ReturnPitValue: TLabel;
    PipeRAMsValue: TLabel;
    ChokeValue: TLabel;
    CommandLine: TEdit;
    Commands: TGroupBox;
    FlowOutUoMLabel: TStaticText;
    DiffFlowUoMLabel: TStaticText;
    ReturnPitUoMLabel: TStaticText;


    ChokeMinus: TButton;
    ChokePlus: TButton;
    BOPBox: TGroupBox;
    FlowBox: TGroupBox;
    KellyHeightText: TLabel;
    DrillingStatusText: TLabel;
    KellyHeightValue: TLabel;
    DrillingStatusValue: TLabel;
    ECDValue: TLabel;
    Memo1: TMemo;
    MudWeightOutValue: TLabel;
    MudWeightInValue: TLabel;
    MudWeightInUoMLabel: TStaticText;
    MudWeightOutUoMLabel: TStaticText;
    MudWeightInText: TStaticText;
    MudWeightOutText: TStaticText;
    ECDText: TStaticText;
    ECDUoMLabel: TStaticText;
    PowerLawRadioButton: TRadioButton;
    BinghamRadioButton: TRadioButton;
    HydrilText: TStaticText;
    BlindRAMsText: TStaticText;
    PipeRAMsText: TStaticText;
    ChokeLineText: TStaticText;
    FlowOutText: TStaticText;
    ReturnPitText: TStaticText;
    DiffFlowText: TStaticText;
    ROPUoMLabel: TStaticText;
    ChokeUoM: TStaticText;
    FlowInUoMLabel: TStaticText;
    StandPipePressureValue: TLabel;
    TimeValue: TLabel;
    ROPValue: TLabel;
    ROPText: TLabel;
    PumpStrokesTotalText: TStaticText;
    KellyHeightUoMLabel: TStaticText;
    TimeText: TLabel;
    WOBUoMLabel: TStaticText;
    TotalDepthUoMLabel: TStaticText;
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
    RPMplus: TButton;
    RPMvalue: TLabel;
    RotaryRPMText: TStaticText;

    procedure AutoDrillCheckBoxChange(Sender: TObject);
    procedure ChokeMinusClick(Sender: TObject);
    procedure ChokePlusClick(Sender: TObject);
    procedure CommandLineClick(Sender: TObject);
    procedure CommandLineKeyPress(Sender: TObject; var Key: char);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
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
    procedure MenuItem3PauseClick(Sender: TObject);
    procedure MenuItem3StartClick(Sender: TObject);
    procedure MenuItem2DrillStringClick(Sender: TObject);
    procedure MenuItem2BitDataClick(Sender: TObject);
    procedure MenuItem2MudDataClick(Sender: TObject);
    procedure MenuItem2PumpDataClick(Sender: TObject);
    procedure MenuItem2SurfaceEquipmentClick(Sender: TObject);
    procedure MenuItem2WellTestDataClick(Sender: TObject);
    procedure MenuItem2UnitsClick(Sender: TObject);
    procedure MenuItem3StopClick(Sender: TObject);
    procedure MenuItem4AboutClick(Sender: TObject);
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
      procedure UpdateGUI;
      procedure WriteToSocket;
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

  {$IFDEF DARWIN}
  AppMenu     : TMenuItem;
  {$ENDIF}

implementation

{$R *.lfm}

{ TDrillSim }

procedure TDrillSim.SetDefaultValues;
begin
  // The splashunit optional properties are normally set in the FormCreate method
  splash.DelaySeconds := 3;
  splash.Title := 'DrillSim3';
  splash.IconFilePath := OriginDirectory + 'Resources/ambersoft-icon.ico';

  splash.BackGroundImageFilePath := OriginDirectory + 'Resources/rig.jpg';
  //splash.MaskImageFilePath := 'roundedrect.bmp';
  // Must be .bmp file to make a shaped window
  // Note: if MaskImageFilePath is specified as a .jpg file, the jpg will
  // be automatically converted to a bmp file on first run.
  // Use a graphics app to reduce the bmp's color depth and thus - its file size
  splash.BackGroundColor := clWhite;
  splash.LicenseFilePath := 'dsl.txt';
  splash.LicenseType := 'Copyright';
  splash.CreditString := 'Do Not Distribute';
  splash.Author := 'Simon Ambridge';
  splash.SupportContact := 'simon@ntier-db.com';
end;

{* =========================== GUI Input Controls ================================ *}

{ ------------------------------ checks -----------------------------------------}

Procedure CheckPumps;  { called by PipeMinus and PipePlus}
Begin                  {check to see if pumping when adding or subtracting pipe }
  if Data.Pumping then
  Begin
    MessageToMemo(68);

    PumpsOff:=False;      { !!! ERROR MESSAGE REQUIRED ? }
    ShowMessage('Oooops');
  End else PumpsOff:=True;
End;

{ ------------------------------ pumps -----------------------------------------}

Procedure TDrillSim.Pump1MinusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - strokes per minute }
  Begin
    Pump[1,3]:=Pump[1,3]-1;
    if Pump[1,3]<Zero then Pump[1,3]:=Zero;
    Pump1Value.Caption:=FloatToStr(Pump[1,3]);
    StringToMemo('Pump 1 : ' + FloatToStr(Pump[1,3]));
  end;
end;

procedure TDrillSim.Pump1PlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { + strokes per minute }
  Begin
    Pump[1,3]:=Pump[1,3]+1;
    Pump1Value.Caption:=FloatToStr(Pump[1,3]);
    StringToMemo('Pump 1 : ' + FloatToStr(Pump[1,3]));
  end;
 end;

Procedure TDrillSim.Pump2MinusClick(Sender: TObject);
Begin
  if Simulating then With Data do              { - strokes per minute }
  Begin
    Pump[2,3]:=Pump[2,3]-1;
    if Pump[2,3]<Zero then Pump[2,3]:=Zero;
    Pump2Value.Caption:=FloatToStr(Pump[2,3]);
    StringToMemo('Pump 2 : ' + FloatToStr(Pump[2,3]));
  end;
end;

procedure TDrillSim.Pump2PlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { + strokes per minute }
  Begin
    Pump[2,3]:=Pump[2,3]+1;
    Pump2Value.Caption:=FloatToStr(Pump[2,3]);
    StringToMemo('Pump 2 : ' + FloatToStr(Pump[2,3]));
  end;
end;

procedure TDrillSim.Pump3MinusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - strokes per minute }
  Begin
    Pump[3,3]:=Pump[3,3]-1;
    if Pump[3,3]<Zero then Pump[3,3]:=Zero;
    Pump3Value.Caption:=FloatToStr(Pump[3,3]);
    StringToMemo('Pump 3 : ' + FloatToStr(Pump[3,3]));
  end;
end;

procedure TDrillSim.Pump3PlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { + strokes per minute }
  Begin
    Pump[3,3]:=Pump[3,3]+1;
    Pump3Value.Caption:=FloatToStr(Pump[3,3]);
    StringToMemo('Pump 3 : ' + FloatToStr(Pump[3,3]));
  end;
end;

{ ------------------------------ RPM -----------------------------------------}

procedure TDrillSim.RPMminusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - revolutions per minute }
  Begin
    RPM:=RPM-1;
    if RPM<Zero then RPM:=Zero;
    RPMValue.Caption:=FloatToStr(RPM);
    StringToMemo('RPM : ' + FloatToStr(RPM));
  end;
end;

procedure TDrillSim.RPMplusClick(Sender: TObject);
begin
  if Simulating then With Data do              { + revolutions per minute }
  Begin
    if (KellyHeight < 33) then
    Begin
      RPM:=RPM+1;
      if RPM>160 then RPM:=160;
      RPMValue.Caption:=FloatToStr(RPM);
      StringToMemo('RPM : ' + FloatToStr(RPM));
    End else
    Begin
      MessageToMemo(52);
    End;
  end;
end;

{ ------------------------------ kelly -----------------------------------------}

procedure TDrillSim.KellyDownClick(Sender: TObject);
begin
  if Simulating then With Data do              { lower Kelly }
  Begin
    if not ShutIn then  { cannot move kelly if shut in }
    Begin
      if abs(Hole[MaxHoles,1]-BitTD) >= 1
        then KellyHeight:=KellyHeight - 0.5
        else KellyHeight:=KellyHeight - 0.05;    { max decrement when less than 1 foot off bottom }

      if KellyHeight<3 then KellyHeight:=3;      { kelly cannot go below 3 ft }

      DrawKelly;                     { display it in SimulateUpdate }
    End;
    //KellyHeightValue.Caption:=FloatToStr(Round2(KellyHeight/UoMConverter[1],2));   { API -> displayed }
    KellyHeightValue.Caption:=FloatToStrF(Round2(Data.KellyHeight/UoMConverter[1],2), ffNumber, 4, 2); { API -> displayed }
  end;
end;

procedure TDrillSim.KellyUpClick(Sender: TObject);
begin
  if Simulating then With Data do              { raise Kelly }
  Begin
    if not ShutIn then  { cannot move kelly if shut in }
    Begin
      if abs(Hole[MaxHoles,1]-BitTD) >= 1
        then KellyHeight:=KellyHeight + 0.5
        else KellyHeight:=KellyHeight + 0.05;    { max increment when less than 1 foot off bottom }

      if KellyHeight>33 then KellyHeight:=33;    { kelly cannot go above 33 ft }

      DrawKelly;                     { display it in SimulateUpdate }
    End;
    //KellyHeightValue.Caption:=FloatToStr(Round2(KellyHeight/UoMConverter[1],2));  { API -> displayed }
    KellyHeightValue.Caption:=FloatToStrF(Round2(Data.KellyHeight/UoMConverter[1],2), ffNumber, 4, 2); { API -> displayed }
  End;
end;

{ ------------------------------ pipe ------------------------------------------}

procedure TDrillSim.PipeMinusClick(Sender: TObject);
begin
  if Simulating then With Data do              { only allowed when on slips }
  Begin
    if (KellyHeight=33) and (Pipe[MaxPipes,1] >27) then
    Begin
      CheckPumps;
      if PumpsOff then Pipe[MaxPipes,1]:=Pipe[MaxPipes,1] - 27;
      StringWtCalc;
    End;
  End;
end;

procedure TDrillSim.PipePlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { only allowed when on slips }
  Begin
    if (KellyHeight=33) and (Hole[MaxHoles,1] - BitTD >=27) then
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

{ ------------------------------ choke -----------------------------------------}

procedure TDrillSim.ChokeMinusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - choke aperture }
  Begin
    Choke:=Choke - 1;
    if Choke < 5 then
    Begin
      if Choke=4 then CloseChoke;
      MessageToMemo(65);
      Choke:=Zero;
      DeltaCsgPr:=DeltaCsgPr + PlChoke;
      PlChoke:=Zero;
    End;
    ChokeValue.Caption:=FloatToStr(Choke);
    StringToMemo('Choke : ' + FloatToStr(Choke));
  end;
End;

procedure TDrillSim.ChokePlusClick(Sender: TObject);
begin
  if Simulating then With Data do              { - choke aperture }
  Begin
    Choke:=Choke + 1;
    if Choke < 5 then
    Begin
      MessageToMemo(64);
      Choke:=5;
      OpenChoke;
    end;
    if Choke>100 then Choke:=100;
    ChokeValue.Caption:=FloatToStr(Choke);
    StringToMemo('Choke : ' + FloatToStr(Choke));
  End;
End;

{ ------------------------------ Mud Mode---------------------------------------}

procedure TDrillSim.PowerLawRadioButtonChange(Sender: TObject);
begin

end;

procedure TDrillSim.BinghamRadioButtonChange(Sender: TObject);
begin
  With Data do
  Begin
  Bingham:=not Bingham;
  if Bingham then MessageToMemo(31) else MessageToMemo(32);
  End;

end;

{ ------------------------------ Autodrill -------------------------------------}

procedure TDrillSim.AutoDrillCheckBoxChange(Sender: TObject);
begin
  With Data do
  Begin
  AutoDrill:=not AutoDrill;
  if AutoDrill then MessageToMemo(1) else MessageToMemo(2);
  End;
end;




{* ======================= Memo Text Input =============================== *}

procedure TDrillSim.CommandLineKeyPress(Sender: TObject; var Key: char);
begin
  if Key=^M then      // if ENTER
  Begin
    if length(InputString) > Zero then   // display it
    Begin
      //Memo1.Lines.Add('>' + InputString);
      //Memo1.SelStart:=Length(Memo1.Text);
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
  Key:=#0;
end;


procedure TDrillSim.CommandLineClick(Sender: TObject);
begin
  InputString:='';
  CommandLine.Text := InputString;
  CommandLine.SelStart:=Length(CommandLine.Text);
//  writeln('Clicked in TEdit');

end;

procedure TDrillSim.Memo1Change(Sender: TObject);

begin
end;
{* ======================== Form Controls =========================== *}

procedure TDrillSim.FormActivate(Sender: TObject);

begin
  StringToMemo('DrillSimGUI.FormActivate...............................');
  Edited:=False;  { start clean }
  Simulating:=False;
  SimulateMessageCode:=0;
  Paused:=False;

  StringToMemo('DrillSimGUI.FormaActivate: Running DrillSim start up sequence');
  { ***************************************** }
  StartUp;     { call DrillSim StartUp }
  { ***************************************** }

  DrillingStatusValue.Caption:='Checking...';

  KellyScale.Picture.LoadFromFile(OriginDirectory + 'Resources/kellyscale.png');  { draw kelly starting position }
  KellyImage.Picture.LoadFromFile(OriginDirectory + 'Resources/kellyup-0.png');
  BushingImage.Picture.LoadFromFile(OriginDirectory + 'Resources/kellybushingup.png');

  KellyHeightValue.Caption:=FloatToStrF(Round2(Data.KellyHeight/UoMConverter[1],2), ffNumber, 4, 2); { API -> displayed }
  StringToMemo('Initial kelly height = ' + FloatToStr(Data.KellyHeight));

  BitDepthValue.Caption:=FloatToStrF(Round2(Data.BitTD/UoMConverter[1],2), ffNumber, 4, 2); { API -> displayed }
  TotalDepthValue.Caption:=FloatToStrF(Round2(Data.TD/UoMConverter[1],2), ffNumber, 4, 2); { API -> displayed }
  WOBValue.Caption:=FloatToStrF(Round2(Data.WOB/UoMConverter[7],2), ffNumber, 4, 2); { API -> displayed }
  RPMValue.Caption:=FloatToStr(Round2(Data.RPM,2));
  ROPValue.Caption:=FloatToStr(Round2(Data.ROP/UoMConverter[1],2)); { API -> displayed }

  MudWeightInValue.Caption:=FloatToStrF(Round2(Data.MwIn/UoMConverter[2],2), ffNumber, 4, 2); { ppg API -> displayed }
  MudWeightOutValue.Caption:=FloatToStrF(Round2(Data.MwOut/UoMConverter[2],2), ffNumber, 4, 2); { ppg API -> displayed }
  ECDValue.Caption:=FloatToStrF(Round2(Data.ECD/UoMConverter[2],2), ffNumber, 4, 2); { ppg API -> displayed }

  Pump1Value.Caption:=FloatToStr(Round2(Data.Pump[1,3],0));
  Pump2Value.Caption:=FloatToStr(Round2(Data.Pump[2,3],0));
  Pump3Value.Caption:=FloatToStr(Round2(Data.Pump[3,3],0));
  PumpStrokesValue.Caption:=FloatToStr(Round2(Data.StrokeCounter,0));

  FlowInValue.Caption:=FloatToStr(Round2(Data.FlowIn/UoMConverter[5],2)); { API -> displayed }
  FlowOutValue.Caption:=FloatToStr(Round2(Data.FlowOut/UoMConverter[5],2)); { API -> displayed }
  StandPipePressureValue.Caption:=FloatToStr(Round2(Data.PlCirc/UoMConverter[3],2)); { API -> displayed }
  ReturnPitValue.Caption:=FloatToStr(Round2(Data.RetPitVol/UoMConverter[4],2)); { API -> displayed }
  DiffFlowValue.Caption:=FloatToStr(Round2(PitGain/UoMConverter[4],2)); { API -> displayed }

  ChokeValue.Caption:=FloatToStr(Data.Choke);

  AnnularPressureValue.Caption:=FloatToStr(Round2(Data.BHPAnn/UoMConverter[3],2)); { API -> displayed }
  CasingPressureValue.Caption:=FloatToStr(Round2(Data.CasingPressure/UoMConverter[3],2)); { API -> displayed }
  if Data.ShutIn then
  Begin
    HydrilValue.Caption:='Closed';
    PipeRAMsValue.Caption:='Closed';
    BlindRAMsValue.Caption:='Closed';
  End else
  Begin
    HydrilValue.Caption:='Open';
    PipeRAMsValue.Caption:='Open';
    BlindRAMsValue.Caption:='Open';
  End;

  AnnVol.Caption:=FloatToStrF(Round2(Data.AnnVol/UoMConverter[4],2), ffNumber, 8, 2); { bbl/m3 -> displayed }
  WellVol.Caption:=FloatToStrF(Round2(Data.WellVol/UoMConverter[4],2), ffNumber, 8, 2); { bbl/m3 -> displayed }
  HoleVol.Caption:=FloatToStrF(Round2(Data.HoleVol/UoMConverter[4],2), ffNumber, 8, 2); { bbl/m3 -> displayed }
  MudVol.Caption:=FloatToStrF(Round2(Data.MudVol/UoMConverter[4],2), ffNumber, 8, 2); { bbl/m3 -> displayed }

  LagDownTime.Caption:=FloatToStrF(Round2(Data.LagDT,2), ffNumber, 8, 2); { time }
  LagDownStrokes.Caption:=FloatToStrF(Round2(Data.LagDS,2), ffNumber, 8, 2); { num }
  LagUpTime.Caption:=FloatToStrF(Round2(Data.LagUT,2), ffNumber, 8, 2); { time }
  LagUpStrokes.Caption:=FloatToStrF(Round2(Data.LagUS,2), ffNumber, 8, 2); { num }

  PipeCapacity.Caption:=FloatToStrF(Round2(Data.PipeCap/UoMConverter[4],2), ffNumber, 8, 2); { bbl/m3 -> displayed }
  PipeDisplacement.Caption:=FloatToStrF(Round2(Data.PipeDis/UoMConverter[4],2), ffNumber, 8, 2); { bbl/m3 -> displayed }



   CommandLine.SetFocus;
end;

procedure TDrillSim.FormCreate(Sender: TObject);

function slash(value:string):string;
begin
  if (value='')
    then result:=''
    else begin
      {$IFDEF WINDOWS}
      if (value[length(value)]<>'\')
        then result:=value+'\'
      {$ELSE}
      if (value[length(value)]<>'/')
        then result:=value+'/'
      {$ENDIF}
    else result:=value;
  end;
end;

function GetInstallDir:string;
begin
  StringToMemo('DrillSimGUI.FormCreate - paramstr = ' + paramstr(0));
  result:=slash(extractfiledir(paramstr(0)));
end;

function GetBaseDir:string;
Begin
  {$IFDEF WINDOWS}
    result:=GetInstallDir;
  {$ELSE}
    result:=copy(GetInstallDir,1,pos(extractfilename(paramstr(0))+'.app/Contents/MacOS',GetInstallDir)-1);
  {$ENDIF}
end;

begin

  Memo1.SelStart:=Length(Memo1.Text);
  StringToMemo('DrillSimGUI.FormCreate - Running DrillSimGUI FormCreate...');

  OriginDirectory:=GetInstallDir();
  StringToMemo('DrillSimGUI.FormActivate - Current directory is ' + OriginDirectory);

  splash := TSplashAbout.Create(nil);
  SetDefaultValues; // splash
  splash.ShowSplash;

  {$IFDEF DARWIN}
  AppMenu := TMenuItem.Create(Self);  {Application menu}
  AppMenu.Caption := #$EF#$A3#$BF;  {Unicode Apple logo char}
  DrillSim.MainMenu1.Items.Insert(0, AppMenu);
  {$ENDIF}

end;

Procedure CheckExit;
var Reply, BoxStyle: Integer;
Begin
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
        StringToMemo('DrillSimGUI.CheckExit - File ' + CurrentFQFileName + ' saved');
      end;
    end;
    if Simulating then
    Begin
      StringToMemo('DrillSimGUI.CheckExit - Terminating simulation thread');
      MyThread.Terminate;
      StringToMemo('DrillSimGUI.CheckExit - Waiting for simulation thread to terminate.....');
      MyThread.WaitFor;
      StringToMemo('DrillSimGUI.CheckExit - Simulation thread terminated');
    end;
    StringToMemo('DrillSimGUI.CheckExit - Terminating application');
    Application.Terminate;
  end
  else
    Exit;
End;

Procedure TDrillSim.FormDeActivate(Sender: TObject);
Begin { Also called on Quit Button }
  StringToMemo('DrillSimGUI.Deactivate ........................................');
  CheckExit;
End;

procedure TDrillSim.FormClose(Sender: TObject);
begin { Kill the app using window controls }
  StringToMemo('DrillSimGUI.Close .............................................');
  CheckExit;
end;

Procedure TDrillSim.MenuItem1QuitClick(Sender: TObject);
Begin { Kill the app from the menu }
  StringToMemo('DrillSimGUI:Menu 1: Quit ......................................');
  CheckExit;
End;


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
//  CreateNewFile:=True;
//  InitData;                             { Set NeverSimulated }
//  APIUnits;                             { Default to API units    }
//  UpdateGen;
//  CheckHoleData;         { get hole data and redo pipe/hole screens if error }
//  CheckPipeData;         { get pipe data and redo hole/pipe screens if error }
//  UpdateBit;
//  UpdateMud;
//  UpdatePump;
//  UpdateSurf;
//  UpDateWellTests;
//  SaveData;
//  CreateNewFile:=False;
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
  { call DrillSimHoleChecks:CheckHoleData - calls DSHoleCalc - check hole and pipe data }
  CheckHoleData;
  if HoleError then StringToMemo('DrillSimFile.LoadData: Hole Error !!!! ');

end;

procedure TDrillSim.MenuItem2DrillStringClick(Sender: TObject);
begin
  try
    PipeDataForm:=TPipeDataForm.Create(Nil);  //Pipe Data Input is created
    PipeDataForm.ShowModal;
  finally
    PipeDataForm.Free;
  end;
    { call DrillSimHoleChecks:CheckHoleData - calls DSHoleCalc - check hole and pipe data }
    CheckHoleData;
    if HoleError then StringToMemo('DrillSimFile.LoadData: Hole Error !!!! ');

end;

procedure TDrillSim.MenuItem2BitDataClick(Sender: TObject);
begin
  try
    BitDataForm:=TBitDataForm.Create(Nil);  //Bit Data Input is created
    BitDataForm.ShowModal;
  finally
    BitDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2MudDataClick(Sender: TObject);
begin
  try
    MudDataForm:=TMudDataForm.Create(Nil);  //Mud Data Input is created
    MudDataForm.ShowModal;
  finally
    MudDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2PumpDataClick(Sender: TObject);
begin
  try
    PumpDataForm:=TPumpDataForm.Create(Nil);  //Pump Data Input is created
    PumpDataForm.ShowModal;
  finally
    PumpDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2SurfaceEquipmentClick(Sender: TObject);
begin
  try
    SurfaceEquipmentDataForm:=TSurfaceEquipmentDataForm.Create(Nil);  //Pump Data Input is created
    SurfaceEquipmentDataForm.ShowModal;
  finally
    SurfaceEquipmentDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2WellTestDataClick(Sender: TObject);
begin
  try
    WellTestDataForm:=TWellTestDataForm.Create(Nil);  //Pump Data Input is created
    WellTestDataForm.ShowModal;
  finally
    WellTestDataForm.Free;
  end;
end;

procedure TDrillSim.MenuItem2GeologyClick(Sender: TObject);
begin
  try
    GeologyDataForm:=TGeologyDataForm.Create(Nil);  //Pump Data Input is created
    GeologyDataForm.ShowModal;
  finally
    GeologyDataForm.Free;
  end;
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


{ ----------- Help, About Menu Options ---------------------------- }

procedure TDrillSim.MenuItem4AboutClick(Sender: TObject);
begin
    splash.ShowAbout;
end;


{ ----------- Simulate Menu Options ---------------------------- }

procedure TDrillSim.MenuItem3StopClick(Sender: TObject);
begin
  Simulating:=False;
end;

procedure TDrillSim.MenuItem3PauseClick(Sender: TObject);
begin
  if (not Simulating) and (not Paused) then
  Begin
    ShowMessage('Cannot pause a non-running simulation');
    Exit;
  end;

  Paused:=not Paused;
  if Paused=True then
  Begin
    StringToMemo('Simulation Paused');
    Simulating:=False;
  end
  else
  Begin
    StringToMemo('Simulation Un-paused');
    Simulating:=True;
  end;
end;

procedure TDrillSim.MenuItem3StartClick(Sender: TObject);
begin
  StringToMemo('DrillSImGui.TDrillSim.MenuItem3StartClick - starting simulation');
  MessageToMemo(100);               { Please wait...  }
  if not Simulating then
  Begin
    if NoFileDefined=True then
    Begin
      CurrentFQFileName:='no file';          { set file name for load window          }
      MenuItem1OpenFileClick(nil);           { and go prompt for one                  }
    End else
    Begin                           { call inits in DrillSimDataResets }
      InitMud;                      { set the system OriginalMudWt etc.      }

      InitDepth;                    { depths used for reset are the current  }
                                    { depths at the start of this session    }
                                    { which may not be the original depths   }
      InitKick;                     { Set up and initialise if NeverSimulated }

      InitGeology;                  { find current position within geological}
                                    { table. Also done on Load and Clear     }
      GetCurrentTime (t);
      Data.t2:=t.Seconds;             { initialize time                    }



      SimHoleCalc;                    { SimulateHoleCalcs - calculate volumes }

      MudUpdate;                      { SimulateUpdate - set up mud, display it  }

      FlowUpdate;                     { SimulateUpdate - set up flow, display it }

      SetKelly;                       { SimulateUpdate - move kelly to drilling position    }

      SetSurfControls;                { set RAMs and choke line            }

      SimulateMessageCode:=0;
      Paused:=False;
      Simulating:=True;               { ACTIVATE THE THREAD !!!            }

      TimeUpdate;                     { SimulateHydraulicCalcs:HyCalc }
    End;
  end;
End;



{* ============================ Threads ================================= *}

constructor TMyThread.Create(CreateSuspended : boolean);
begin
  writeln('DrillSImGUI.TMyThread.Create - create suspended Simulation Thread');
  inherited Create(CreateSuspended);
  FreeOnTerminate := True;
end;

procedure TMyThread.ShowStatus;
// this method is executed by the mainthread and can therefore access all GUI elements.
begin
  writeln('DrillSimGUI.ShowStatus - Simulation Thread Status Change - '+ ThreadStatus);
end;

Procedure TMyThread.WriteToSocket;
var TimeStamp : String20;
Begin
  //writeln('DrillSImGui.TMyThread.WriteToSocket');
  //writeln(t.seconds);  { about 1000 updates/sec }
  TimeStamp:=IntToStr(Trunc((Now - EncodeDate(1970, 1 ,1)) * 24 * 60 * 60));
  GetCurrentTime (t);
  if t.Seconds <> LastSocketSeconds then
  With Data do
  Begin
    sock.SendString('1,'+FloatToStrF(Round2(TD,2), ffFixed, 8, 2)+','+ TimeStamp+#13#10);
    sock.SendString('2,'+FloatToStrF(Round2(BitTD,2), ffFixed, 8, 2)+','+ TimeStamp+#13#10);
    sock.SendString('3,'+FloatToStrF(Round2(WOB,2), ffNumber, 8, 2)+','+ TimeStamp+#13#10);
    sock.SendString('4,'+FloatToStr(Round2(RPM,2))+','+ TimeStamp+#13#10);
    sock.SendString('5,'+FloatToStrF(Round2(ROP,2), ffNumber, 8, 2)+','+ TimeStamp+#13#10);
    sock.SendString('6,'+FloatToStrF(Round2(FlowIn,2), ffNumber, 8, 2)+','+ TimeStamp+#13#10);
    sock.SendString('7,'+FloatToStrF(Round2(FlowOut,2), ffNumber, 8, 2)+','+ TimeStamp+#13#10);
    sock.SendString('8,'+FloatToStrF(Round2(PlCirc,2), ffNumber, 8, 2)+','+ TimeStamp+#13#10);
    sock.SendString('9,'+FloatToStrF(Round2(MWIn,2), ffNumber, 8, 2)+','+ TimeStamp+#13#10);
    sock.SendString('10,'+FloatToStrF(Round2(MWOut,2), ffNumber, 8, 2)+','+ TimeStamp+#13#10);
    LastSocketSeconds:=t.Seconds;
  End;
  if sock.lasterror<>0 then writeln(sock.LastErrorDesc);

end;

procedure TMyThread.UpdateGUI;
// this method is executed by the mainthread and can therefore access all GUI elements.
begin
  if SimulateMessageCode<>0 then   { use SimulateMessageCode to pass messages from the thread }
     MessageToMemo(SimulateMessageCode);

  SimulateMessageCode:=0;           { reset it }

  ScreenService;                    { update screen }
end;

procedure TMyThread.Execute;
var
  NewStatus : string;
begin
  // Do not use StringToMemo until after thread initialisation is complete and the main form is created
  writeln('DrillSimGUI.TMyThread.Execute - Simulation Thread starting...');
  ThreadStatus := 'TMyThread Starting...';
  writeln('DrillSimGUI.TMyThread.Execute - syncing Showstatus...');
  Synchronize(@Showstatus);
  writeln('DrillSimGUI.TMyThread.Execute   - sync complete');
  ThreadStatus := 'TMyThread Running...';
  writeln('DrillSimGUI.TMyThread.Execute - Simulation Thread running...');
  writeln('DrillSimGUI.TMyThread.Execute - syncing UpdateGUI...');
  Synchronize(@UpdateGUI);

  while (not Terminated) do
    begin
       if Simulating then
       Begin
         NewStatus:=('Simulating');  { can be either 'Simulating' or 'Not Simulating' }

         FlowRateCalc;               { SimulateHydraulicCalcs:FlowRateCalc }

         HydraulicCalc;              { SimulateHydraulicCalcs:HyCalc }

         Synchronize(@UpdateGUI);

         { check for hole deeper then next horizon          }
         { if yes, check if next horizon data is valid (>0) }
         { if yes, advance RockPointer and calculate new    }
         { formation pressure gradient                      }

         FormationPressureCalc;

         TwistOffCalc;

         DrillCalc;

         //sock.SendString('DrillSim calling....'#13#10#13#10);
         //if sock.lasterror<>0 then StringToMemo(sock.LastErrorDesc);

         //?? Synchronize(@WriteToSocket);

         KickCalc;

         Synchronize(@UpdateGUI);

       end else
       Begin
         NewStatus:=('Not Simulating');
       end;

      if NewStatus <> ThreadStatus then
        begin
          ThreadStatus := NewStatus;
          Synchronize(@Showstatus);
        end;
    end;
end;


Initialization
 writeln('DrillSimGUI.Initialization - calling MyThread.Create, creating Simulation Thread before FormCreate is run');
 MyThread := TMyThread.Create(True); // set True = it doesn't start automatically
 writeln('DrillSimGUI.Initialization   - Simulation Thread created');
 {* Here initialise anything required before the threads starts executing *}
 writeln('DrillSimGUI.Initialization - init complete, calling MyThread.Start');
 MyThread.Start;

end.

