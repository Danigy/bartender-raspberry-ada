with Ada.Text_IO; use Ada.Text_IO;
with Draughts, Pump_CSV;

procedure Test_CSV is
    Filename : String := "test.csv";
    Machine : Draughts.Draught_Array := Pump_CSV.ReadCSV(Filename);
begin
    for I in Machine'Range loop
        declare
            D : Draughts.Draught := Machine(I);
        begin
                Put_Line(Integer'Image(I) & ": GPIO=" & Integer'Image(D.Pump.GPIO) & ", Flow=" & Float'Image(D.Pump.Flow) & ", Bottle=" & D.Bottle.Name.all & ", Vol=" & Integer'Image(D.Bottle.Remaining_Vol));
        end;
    end loop;
end Test_CSV;
