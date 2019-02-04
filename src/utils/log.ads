With Strings; use Strings;
With Recipes; use Recipes;
With Draughts; use Draughts;
With Recipe_lists; use Recipe_lists;

package Log is
        procedure MissingQuantity(Name: in String_Access; Vol: in Natural);

        procedure MissingBottle(Name: in String_Access);

        procedure PrepareCocktail(Name: in String_Access);

        procedure FailedMake(Name: in String_Access);

        procedure CocktailDone(Name: in String_Access);

        procedure CannotAddRecipe(Reason: in String);

        procedure AddRecipe(rec : in Recipes.Recipe; recs: in RecipeArrAccess);

        procedure RefillBottle(Name: in String_Access; Vol: in Natural);

        procedure CannotRefillBottle;

	procedure ReplaceBottle(NameOld: in String_Access; NameNew: in String_Access);

	procedure CannotReplaceBottle;

	procedure DumpBottleArr(bottles : DraughtArrAccess);

	procedure DumpRecipeArr(recipes : RecipeArrAccess);

	procedure AddJob(Name: in String_Access);
end Log;
