with Ada.Text_IO; use Ada.Text_IO;
with Recipes;

package body Recipe_CSV is

    function ReadCSV (Filename : String) return Integer is
        File : File_Type;
        Cocktail : Recipes.Recipe;

    begin
        Open (File => File,
              Mode => In_File,
              Name => Filename);
        while not End_Of_File (File) loop
            Cocktail := ParseRecipeCSV(Get_Line(File));
            Put_Line(Cocktail.Name.all);
            --Put_Line (Get_Line(File));
        end loop;

        Close (File);
        return 3;
    end ReadCSV;

    function ParseRecipeCSV (Content : String) return Recipes.Recipe is
        Cocktail : Recipes.Recipe := (null, null);
        First : Integer := Content'First;
        Next : Integer := Content'First;
    begin
        Next := CSVNextElement(Content, First);
        declare
            Name : Recipes.String_Access := new String'(Content(Content'First .. Content'First + Next - 1));
        begin
            Cocktail.Name := Name;
        end;
        --return (null, null);
        return cocktail;
    end ParseRecipeCSV;

    function CSVNextElement (Line : String; First : Integer) return Integer is
        Next : Integer := Line'First;
    begin
        while Next <= Line'Last and then Line(Next) /= ',' loop
            Next := Next + 1;
        end loop;
        return Next  - 1; 
    end CSVNextElement;



end Recipe_CSV;
