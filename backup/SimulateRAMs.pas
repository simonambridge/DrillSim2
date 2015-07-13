Unit SimulateRAMs;

Interface

Uses DrillSimVariables,
     SimulateMessageToMemo,
     SimulateScreen,
     SimulateVolumes;

Procedure RamCheck;  { called from BOPCommands and SetSurfControls }

Implementation

Procedure CloseWell(x,z : integer);   { ypos, message # }
Begin
  //Disp(70,x,'Shut');
  MessageToMemo(z);
End;

Procedure OpenWell(x,z : integer);    { ypos, message # }
Begin
  //Disp(70,x,'Open');
  MessageToMemo(z);
End;


Procedure RamCheck;  { called from BOPCommands and SetSurfControls }
Begin
  With Data do
  Begin
    if Hydril then CloseWell(3,11)
              else OpenWell(3,12);
    if PipeRam then CloseWell(7,8)  { ypos, message# }
               else OpenWell(7,9);  { ypos, message# }

    if not (Hydril or BlindRam or PipeRam) then
    Begin
      DrillingWindow;       { display drilling parameters               }
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
      ShutInWindow;
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

Begin
End.