with Recipes, Recipe_Lists; use Recipe_Lists;

package Recipe_CSV is

    function ReadCSV (Filename : String) return Recipe_List;
    function ParseRecipeCSV (Content : String) return Recipes.Recipe;
    function CSVNextElement (Line : String; First : Integer) return Integer;

end Recipe_CSV;
