with Ada.Text_IO; use Ada.Text_IO;
with Recipes;

package body Recipe_CSV_Writer is
    
    procedure Add_To_CSV(Filename : String; Cocktail : Recipes.Recipe) is
        File : File_Type;
    begin
        begin
            Open ( File => File, Mode => Append_File, Name => Filename);
        exception
            when Name_Error => Create ( File => File, Mode => Out_File, Name => Filename);
        end;
        Put (File, Cocktail.Name.all & "," & Integer'Image(Cocktail.Ingredients.all'Last));
        declare
            Ingredients : Recipes.Ingredients_array := cocktail.Ingredients.all;
        begin
            for I in Ingredients'Range loop
                Put (File, "," & Ingredients(I).Name.all & "," & Integer'Image(Ingredients(I).vol));
            end loop;
        end;
	Close(File);
    end Add_To_CSV;

end Recipe_CSV_Writer;

