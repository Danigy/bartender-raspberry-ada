with Ada.Text_IO;		use Ada.Text_IO;
with Recipes;			use Recipes;
with Bottles;			use Bottles;
with Draughts;			use Draughts;

package Bartender_Utils is

	type RecipeArray is array(Positive range <>) of Recipes.Recipe;
	type RecipeArrAccess is access all RecipeArray;

	type BottleArray is array(Positive range <>) of Bottles.Bottle;
	type BottleArrAccess is access all BottleArray;

	type DraughtArrAccess is access all Draught_Array;

	procedure DumpBottleArrAccess(bottles : DraughtArrAccess);
	procedure DumpRecipeArrAccess(recipes : RecipeArrAccess);

end Bartender_Utils;
