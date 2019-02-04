With Strings; use Strings;
With Recipes; use Recipes;
With Recipe_lists; use Recipe_lists;
With Bartender_utils; use Bartender_utils;

package Log is
        procedure MissingQuantity(Name: in String_Access; Vol: in Positive);

        procedure MissingBottle(Name: in String_Access);

        procedure PrepareCocktail(Name: in String_Access);

        procedure FailedMake(Name: in String_Access);

        procedure CocktailDone(Name: in String_Access);

        procedure CannotAddRecipe(Reason: in String);

        procedure AddRecipe(rec : in Recipes.Recipe; recs: in RecipeArrAccess);

        procedure RefillBottle(Name: in String_Access; Vol: in Positive);

        procedure CannotRefillBottle;

	procedure ReplaceBottle(NameOld: in String_Access; NameNew: in String_Access);

	procedure CannotReplaceBottle;

	procedure DumpBottleArr(bottles : DraughtArrAccess);

	procedure DumpRecipeArr(recipes : RecipeArrAccess);
end Log;
