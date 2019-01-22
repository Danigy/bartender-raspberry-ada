with Ada.text_IO, Recipe_CSV; use Ada.Text_IO;

procedure Test_CSV is
    Filename : String := "test.txt";
    Ret : Integer; 
begin
    Ret := Recipe_CSV.ReadCSV(Filename);

end Test_CSV;
