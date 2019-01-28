with Ada.Text_IO; use Ada.Text_IO;
with Recipes, Recipe_Lists; use Recipe_Lists;

package body Recipe_CSV is

    function ReadCSV (Filename : String) return Recipe_List is
        File : File_Type;
        RecipeList : Recipe_List := Recipe_Lists.Init;
    begin
        Open (File => File,
              Mode => In_File,
              Name => Filename);
        while not End_Of_File (File) loop
            RecipeList.Insert(ParseRecipeCSV(Get_Line(File)));
        end loop;

        Close (File);
        return RecipeList;
    end ReadCSV;

    function ParseRecipeCSV (Content : String) return Recipes.Recipe is
        Cocktail : Recipes.Recipe := (null, null);
        First : Integer := Content'First;
        Next : Integer := CSVNextElement(Content, First);
        Ingredients_Nb : Integer := 0;
    begin
        Cocktail.Name := new String'(Content(Content'First .. Next - 1));
        First := Next + 1;
        Next := CSVNextElement(Content, First);
        Ingredients_Nb := Integer'Value(Content(First .. Next - 1));
        Cocktail.Ingredients := new Recipes.Ingredients_Array(1 .. Ingredients_Nb);
        for I in Cocktail.Ingredients'Range loop
            First := Next + 1;
            Next := CSVNextElement(Content, First);
            Cocktail.Ingredients.all(I).Name := new String'(Content(First .. Next - 1));
            First := Next + 1;
            Next := CSVNextElement(Content, First);
            Cocktail.Ingredients.all(I).Vol := Integer'Value(Content(First .. Next - 1));
        end loop;
        return cocktail;
    end ParseRecipeCSV;

    function CSVNextElement (Line : String; First : Integer) return Integer is
        Next : Integer := First;
    begin
        while Next <= Line'Last and then Line(Next) /= ',' loop
            Next := Next + 1;
        end loop;
        return Next; 
    end CSVNextElement;



end Recipe_CSV;
