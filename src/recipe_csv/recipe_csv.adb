with Ada.Text_IO; use Ada.Text_IO;
with Recipes, Recipe_Lists; use Recipe_Lists;
with CSV;

package body Recipe_CSV is

    function ReadCSV (Filename : String) return Recipe_List is
        File : File_Type;
        RecipeList : Recipe_List := Recipe_Lists.Init;
        Counter : Integer := 1;
    begin
        begin
            Open (File => File,
                  Mode => In_File,
                  Name => Filename);
        exception
            when others => 
                Put_Line("Warning: Configuration file " & Filename & " not found");
                return RecipeList;
        end;
        while not End_Of_File (File) loop
            begin
                RecipeList.Insert(ParseRecipeCSV(Get_Line(File)));
                Counter := Counter + 1;
            exception
                when others =>
                    Put_Line("Warning: Format error in the configuration file " & Filename & " at line " & Integer'Image(Counter));
                    Counter := Counter + 1;
            end;
        end loop;

        Close (File);
        return RecipeList;
    end ReadCSV;

    function ParseRecipeCSV (Content : String) return Recipes.Recipe is
        Cocktail : Recipes.Recipe := (null, null);
        First : Integer := Content'First;
        Next : Integer := CSV.NextElement(Content, First);
        Ingredients_Nb : Integer := 0;
    begin
        Cocktail.Name := new String'(Content(Content'First .. Next - 1));
        First := Next + 1;
        Next := CSV.NextElement(Content, First);
        Ingredients_Nb := Integer'Value(Content(First .. Next - 1));
        Cocktail.Ingredients := new Recipes.Ingredients_Array(1 .. Ingredients_Nb);
        for I in Cocktail.Ingredients'Range loop
            First := Next + 1;
            Next := CSV.NextElement(Content, First);
            Cocktail.Ingredients.all(I).Name := new String'(Content(First .. Next - 1));
            First := Next + 1;
            Next := CSV.NextElement(Content, First);
            Cocktail.Ingredients.all(I).Vol := Integer'Value(Content(First .. Next - 1));
        end loop;
        return cocktail;
    end ParseRecipeCSV;

end Recipe_CSV;
