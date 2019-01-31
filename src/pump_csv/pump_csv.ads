with Ada.Directories; use Ada.Directories;
with Draughts;

package Pump_CSV is

    function ReadCSV (Filename : String) return Draughts.Draught_Array
        with Pre => Exists(Filename);
    function ParseDraughtCSV (Content : String) return Draughts.Draught;

end Pump_CSV;
