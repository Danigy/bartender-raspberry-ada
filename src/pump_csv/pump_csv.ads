with Draughts;

package Pump_CSV is

    function ReadCSV (Filename : String) return Draughts.Draught_Array;
    function ParseDraughtCSV (Content : String) return Draughts.Draught;

end Pump_CSV;
