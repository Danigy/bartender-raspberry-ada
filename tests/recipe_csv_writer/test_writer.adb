with Recipes, Recipe_CSV_Writer;

procedure Test_Writer is
    Filename : String := "test.csv";
    R : Recipes.Recipe := (new String'("Whisky coca"), new Recipes.Ingredients_Array'(
            (new String'("Whisky"), 30),
            (new String'("Coca"), 70)));
begin
    Recipe_CSV_Writer.Add_To_CSV(Filename, R);
end Test_Writer;
