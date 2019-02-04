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
            Put_Line (File, Natural'Image(Tap(I).Pump.NB) & ","
                & Positive'Image(Tap(I).Pump.Flow) & ","
                & Tap(I).Bottle.Name.all & ","
                & Natural'Image(Tap(I).Bottle.Vol));
        end loop;
	Close(File);
    end Write_CSV;

end Pump_CSV_Writer;
