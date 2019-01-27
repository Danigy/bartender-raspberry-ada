with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Recipes;

procedure Test_Recipe is
    Re : Recipes.Recipe := (new String'("Whisky Coca"),
        new Recipes.Ingredients_Array'(Recipes.Ingredient'(new String'("Whisky"), 300), Recipes.Ingredient'(new String'("Coca"), 700)));
begin
    Put_line(Re.Name.all & " contains:");
    for I in Re.Ingredients.all'Range loop
        Put_line("- " & Integer'Image(Re.Ingredients.all(I).Vol) & "ml of " & Re.Ingredients.all(I).Name.all);
    end loop;
end Test_Recipe;
