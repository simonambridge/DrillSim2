Unit SimulateRAMs;

Interface

Uses DrillSimVariables,
     SimulateVolumes;

Procedure RamCheck;  { called from BOPCommands and SetSurfControls }
Procedure CloseChoke;
Procedure OpenChoke;
Procedure SetSurfControls;

Implementation

{ ---------------- FLow line maintenance ---------------- }

Procedure CloseChoke;
Begin
  Data.Flowline:=False;
End;

Procedure OpenChoke;
Begin                                             { "Circulating through choke" }
  if (Data.Pumping) and (Data.ShutIn) then SimulateMessageCode:=14;
  Data.Flowline:=True;
End;

Procedure RamCheck;  { called from BOPCommands and here }
Begin
  With Data do
  Begin
    if Hydril then SimulateMessageCode:=11  { message# }
              else SimulateMessageCode:=12;  { message# }
    if PipeRam then SimulateMessageCode:=8  { message# }
               else SimulateMessageCode:=9;  { message# }

    if not (Hydril or BlindRam or PipeRam) then
    Begin
      SimulateMessageCode:=67;      { "BOPs are OPEN" }
      if ShutIn then        { change status to open if not already open }
      Begin
        ShutIn:=False;      { change to shut-in                   }
        VolCalc;            { calculate volumes and include riser }

      { add the circulating volume in the riser to MudVol.
        If well had been pressured up then MainCalc will calculate
        net flow as normal. Setting ExcessMud to 0 keeps it in one of
        2 states (valid or zero) depending upon whether the well is
        shut-in or not. }

        MudVol:=MudVol + ExcessMud;
        ExcessMud:=Zero;              { clear it for next time }
      End;
    End else
    Begin
      SimulateMessageCode:=101;  { "BOPS are closed" }
      if not ShutIn then   { change status to shut in if not already shut in }
      Begin                { ie only do this if rams have just been closed   }
        ShutIn:=True;
        VolCalc;            { calculate volumes and exclude riser }

      { HoleVol is now reduced if sub-sea wellhead in use. MudVol
        minus holevol = riser circulating volume, so store it in
        ExcessMud for when well is opened up again. This assumes that
        MudVol cannot be less than hole minus riser circ. volume. }

        ExcessMud:=MudVol - HoleVol;
        MudVol:=HoleVol;
      End;
    End;
  End;
End;

Procedure SetSurfControls;
Begin
  With Data do
  Begin
    RamCheck;                     { display Hydril, Pipe Rams, set ShutIn, }
                                  { display appropriate window, set MudVol }
                                  { and ExcessMud                          }
    if Choke>Zero then OpenChoke else CloseChoke;
  End;
End;


Begin
End.