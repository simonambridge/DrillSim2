Unit SimulateSurfaceControls;

Interface

Uses DrillSimVariables,
     SimulateRAMs,
     DrillSimMessageToMemo;

Procedure SetSurfControls;
Procedure CloseChoke;
Procedure OpenChoke;

Implementation

{ ---------------- FLow line maintenance ---------------- }


Procedure CloseChoke;
Begin
  MessageToMemo(65);
  Data.Flowline:=False;
  //FlowlineWindow;
End;

Procedure OpenChoke;
Begin
  MessageToMemo(64);
  if (Data.Pumping) and (Data.ShutIn) then MessageToMemo(14);
  Data.Flowline:=True;
  //FlowlineWindow;
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