with Ada.Text_IO; use Ada.Text_IO;
with Draughts, Bottles, GPIO;

package body Pump_CSV is

    function ReadCSV (Filename : String) return Draughts.Draught_Array is
        File : File_Type;
        AvailableDraughts : Draughts.Draught_Array(1 .. 4);
        I : Integer := 1;
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
        Next : Integer := CSVNextElement(Content, First);
        IO : Integer := GPIO.libsimpleio.Create(0, Integer'Value(Content(First .. Next - 1)), GPIO.Output);
        Flow : Integer := 0;

        Bottle_Name : Bottles.String_Access := null;
        Remaining_Vol : Integer := 0;
    begin
        First := Next + 1;
        Next := CSVNextElement(Content, First);
        Flow := Integer'Value(Content(First .. Next - 1));
        First := Next + 1;
        Next := CSVNextElement(Content, First);
        Bottle_Name := new String'(Content(First .. Next - 1));
        First := Next + 1;
        Next := CSVNextElement(Content, First);
        Remaining_Vol := Integer'Value(Content(First .. Next - 1));
        return ((Bottle_Name,  Remaining_Vol), (IO, Flow));
    end ParseDraughtCSV;

    function CSVNextElement (Line : String; First : Integer) return Integer is
        Next : Integer := First;
    begin
        while Next <= Line'Last and then Line(Next) /= ',' loop
            Next := Next + 1;
        end loop;
        return Next; 
    end CSVNextElement;

end Pump_CSV;
