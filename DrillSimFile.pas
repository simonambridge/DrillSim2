Unit DrillSimFile;

Interface

Uses Crt,
     sysutils,
     DrillSimVariables,
     DrillSimUnitsOfMeasure,
     DrillSimUtilities,
     DrillSimMessageToMemo,
     DrillSimDataResets,
     DrillSimDataInput,
     DrillSimHoleCalc;

Procedure LoadData;            { Entry : FullName = filename.WDF    }
Procedure SaveData;
Function  OK : boolean;


Implementation

Function OK : boolean;
Begin
  if IOResult <> Zero then OK:=False else OK:=True;
End;



{*********************** File Procedures ***************************}


Procedure LoadData;{ Entry : "CurrentFQFileName" contains FQFN of file to load }
                   {          e.g. /a/b/c/Offshore.wdf  }
Begin
  NoFileDefined:=True;
  StringToMemo('DrillSimFile.LoadData: Loading ' + CurrentFQFileName + '....');
  Assign(DataFile,CurrentFQFileName);
  Reset(DataFile);
  try
    Read(DataFile,Data);
    CloseFile(DataFile);

    StringToMemo('DrillSimFile.LoadData: Loaded ' + CurrentFQFileName);
    StringToMemo('DrillSimFile.LoadData: Operator ' + Data.WellOperator);
    StringToMemo('DrillSimFile.LoadData: Operator ' + Data.WellName);

  except
    on E: EInOutError do
    Begin
      StringToMemo('DrillSimFile.LoadData: File handling error occurred. Details: ' + E.Message);
      InitData;   // if load borks then clear all well data elements
      Exit;
    end;
  End;
  NoFileDefined:=False;
  Edited:=False;              { set this for entry into Simulate }
End;


Procedure SaveData;
Begin
  StringToMemo('DrillSimFile.SaveData: Saving ' + CurrentFQFileName);

  if CreateNewFile then
  Begin
    StringToMemo('DrillSimFile.SaveData: CreateNewFile=True');
    Assign(DataFile,CurrentFQFileName);
    rewrite(DataFile);
    write(DataFile,Data);
    Close(DataFile);
    CreateNewFile:=False;  {now reset it }
  End else
  Begin
    StringToMemo('DrillSimFile.SaveData: CreateNewFile=False');
    Reset(DataFile);
    try
      write(DataFile,Data);
      Close(DataFile);
    except
      on E: EInOutError do
      Begin
        StringToMemo('DrillSimFile.SaveData: File handling error occurred. Details: ' + E.Message);
        Exit;
      end;
    end;
  End;
  Edited:=False;                           { reset edit flag after save }
  StringToMemo('DrillSimFile.SaveData: ' + CurrentFQFileName + ' saved.');
End;

Begin
End.




