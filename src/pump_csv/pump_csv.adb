with Ada.Text_IO; use Ada.Text_IO;
with Strings; use Strings;
with Draughts, Bottles, GPIO;
with GPIO.libsimpleio;
with CSV;

package body Pump_CSV is

    function ReadCSV (Filename : String) return Draughts.Draught_Array is
        File : File_Type;
        AvailableDraughts : Draughts.Draught_Array(1 .. 4);
        I : Natural := 1;
    begin
        Open (File => File,
              Mode => In_File,
              Name => Filename);
        while not End_Of_File (File) loop
            AvailableDraughts(I) := ParseDraughtCSV(Get_Line(File));
            I := I + 1;
        end loop;

        Close (File);
        return AvailableDraughts;
    end ReadCSV;

    function ParseDraughtCSV (Content : String) return Draughts.Draught is
        First : Integer := Content'First;
        Next : Integer := CSV.NextElement(Content, First);
	NB: Integer := Integer'Value(Content(First .. Next - 1));
        IO : GPIO.Pin := GPIO.libsimpleio.Create(0, NB, GPIO.Output);
        Flow : Integer := 0;

        Bottle_Name : String_Access := null;
        Vol : Integer := 0;
    begin
        First := Next + 1;
        Next := CSV.NextElement(Content, First);
        Flow := Integer'Value(Content(First .. Next - 1));
        First := Next + 1;
        Next := CSV.NextElement(Content, First);
        Bottle_Name := new String'(Content(First .. Next - 1));
        First := Next + 1;
        Next := CSV.NextElement(Content, First);
        Vol := Integer'Value(Content(First .. Next - 1));
        return ((Bottle_Name, Vol), (IO, Flow, NB));

    end ParseDraughtCSV;

end Pump_CSV;
