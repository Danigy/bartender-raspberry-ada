with Ada.Text_IO; use Ada.Text_IO;
with Bottles;

procedure Test_Bottle is
    Bo : Bottles.Bottle := (new String'("Whisky"), 750);
begin
    Put_line(Bo.Name.all & " contains " & Integer'Image(Bo.Remaining_Vol));
    Bo.RemoveRemainingVolume(50);
    Put_line(Bo.Name.all & " contains " & Integer'Image(Bo.Remaining_Vol));
end Test_Bottle;
    
