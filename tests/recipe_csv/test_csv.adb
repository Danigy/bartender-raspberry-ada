with Ada.text_IO, Recipe_CSV; use Ada.Text_IO;
with Recipe_Lists; use Recipe_Lists;
with Recipes;

procedure Test_CSV is
    List1 : Recipe_List := Recipe_CSV.ReadCSV("test1.csv");
    List2 : Recipe_List := Recipe_CSV.ReadCSV("test2.csv");
    List3 : Recipe_List := Recipe_CSV.ReadCSV("test3.csv");
    List4 : Recipe_List := Recipe_CSV.ReadCSV("test4.csv");
    List5 : Recipe_List := Recipe_CSV.ReadCSV("donotexist.csv");
    procedure Print_Recipe(Recipe : Available_Recipe) is
        Cocktail : Recipes.Recipe := Recipe.Cocktail;
    begin
        Put_Line(Cocktail.Name.all & ":");
        for I in Cocktail.Ingredients.all'Range loop
            Put_Line(" - " & Cocktail.Ingredients.all(I).Vol'Image & "ml of " & Cocktail.Ingredients.all(I).Name.all);
        end loop;
    end Print_Recipe;
begin
    for I in 0 .. List1.Length - 1 loop
        Print_Recipe(List1.Get(I));
    end loop;
    for I in 0 .. List2.Length - 1 loop
        Print_Recipe(List2.Get(I));
    end loop;
    for I in 0 .. List3.Length - 1 loop
        Print_Recipe(List3.Get(I));
    end loop;
    for I in 0 .. List4.Length - 1 loop
        Print_Recipe(List4.Get(I));
    end loop;
    for I in 0 .. List5.Length - 1 loop
        Print_Recipe(List5.Get(I));
    end loop;
end Test_CSV;
