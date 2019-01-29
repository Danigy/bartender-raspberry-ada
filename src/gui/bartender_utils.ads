with Ada.Text_IO;		use Ada.Text_IO;
with Recipes;			use Recipes;
with Bottles;			use Bottles;

package Bartender_Utils is

	type RecipeArray is array(Positive range <>) of Recipes.Recipe;
	type RecipeArrAccess is access all RecipeArray;

	type BottleArray is array(Positive range <>) of Bottles.Bottle;
	type BottleArrAccess is access all BottleArray;

	-- I can pass only 1 object to a callback function
	type DoRecipeRecord is record
		Rec : Recipes.Recipe;
		Bottles : BottleArrAccess;
	end record;

	procedure DumpBottleArrAccess(bottles : BottleArrAccess);
	procedure DumpRecipeArrAccess(recipes : RecipeArrAccess);

end Bartender_Utils;
