{ Simple Component Counter Script for Altium Designer
  Language: DelphiScript
  Purpose: Count components on the PCB
  
  How to use:
  1. Open a PCB document in Altium
  2. File -> Run Script -> Browse to this file
  3. Run the CountComponents procedure
}

procedure CountComponents;
var
    Board : IPCB_Board;
    Component : IPCB_Component;
    Iterator : IPCB_BoardIterator;
    Count : Integer;
begin
    // Get the current PCB board
    Board := PCBServer.GetCurrentPCBBoard;
    
    // Check if PCB is open
    if Board = nil then 
    begin
        ShowMessage('Please open a PCB document first');
        Exit;
    end;
    
    // Initialize counter
    Count := 0;
    
    // Create iterator for board objects
    Iterator := Board.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
    Iterator.AddFilter_Method(eProcessAll);
    
    // Count components
    Component := Iterator.FirstPCBObject;
    while Component <> nil do
    begin
        Count := Count + 1;
        Component := Iterator.NextPCBObject;
    end;
    
    // Clean up
    Board.BoardIterator_Destroy(Iterator);
    
    // Show result
    ShowMessage('Total Components: ' + IntToStr(Count));
end;
