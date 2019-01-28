with Ada.Text_IO; use Ada.Text_IO;

package body Pump_CSV_Writer is

    procedure Write_CSV (Filename : String; Tap : Draughts.Draught_Array) is
        File : File_Type;
    begin
        begin
            Open (File, Mode => Out_File, Name => Filename);
        exception
            when Name_Error => Create (File, Mode => Out_File, Name => Filename);
        end;
        for I in Tap'Range loop
            Put_Line (File, Integer'Image(Tap(I).Pump.GPIO) & ","
                & Float'Image(Tap(I).Pump.Flow) & ","
                & Tap(I).Bottle.Name.all & ","
                & Integer'Image(Tap(I).Bottle.Remaining_Vol));
        end loop;
    end Write_CSV;

end Pump_CSV_Writer;
