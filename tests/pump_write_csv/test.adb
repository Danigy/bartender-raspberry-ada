with Draughts, Pump_CSV_Writer;

procedure Test is
    Filename : String := "test.csv";
    Tap : Draughts.Draught_Array := (((new String'("Whisky"), 700), (5, 5.2)),
                                     ((new String'("Coca"), 1000), (13, 3.5)),
                                     ((new String'("Vodka"), 350), (12, 4.2)),
                                     ((new String'("Pomme"), 1500), (15, 1.0)));
begin
    Pump_CSV_Writer.Write_CSV(Filename, Tap);
end;
