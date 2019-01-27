with Draughts;

package Pump_CSV is

    function ReadCSV (Filename : String) return Draughts.Draught_Array;
    function ParseDraughtCSV (Content : String) return Draughts.Draught;
    function CSVNextElement (Line : String; First : Integer) return Integer;

end Pump_CSV;
