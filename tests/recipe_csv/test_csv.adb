with Ada.text_IO, Recipe_CSV; use Ada.Text_IO;
with Recipe_Lists; use Recipe_Lists;
with Recipes;

procedure Test_CSV is
    Filename : String := "test.csv";
    List : Recipe_List := Recipe_CSV.ReadCSV(Filename);
    procedure Print_Recipe(Recipe : Available_Recipe) is
        Cocktail : Recipes.Recipe := Recipe.Cocktail;
    begin
        Put_Line(Cocktail.Name.all & ":");
        for I in Cocktail.Ingredients.all'Range loop
            Put_Line(" - " & Cocktail.Ingredients.all(I).Vol'Image & "ml of " & Cocktail.Ingredients.all(I).Name.all);
        end loop;
    end Print_Recipe;
begin
    for I in 0 .. List.Length - 1 loop
        Print_Recipe(List.Get(I));
    end loop;
end Test_CSV;
