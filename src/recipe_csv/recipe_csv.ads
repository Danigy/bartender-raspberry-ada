with Recipes, Recipe_Lists; use Recipe_Lists;

package Recipe_CSV is

    function ReadCSV (Filename : String) return Recipe_List;
    function ParseRecipeCSV (Content : String) return Recipes.Recipe;

end Recipe_CSV;
