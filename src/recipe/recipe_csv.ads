with Recipes;

package Recipe_CSV is

    function ReadCSV (Filename : String) return Integer;
    function ParseRecipeCSV (Content : String) return Recipes.Recipe;
    function CSVNextElement (Line : String; First : Integer) return Integer;

end Recipe_CSV;
