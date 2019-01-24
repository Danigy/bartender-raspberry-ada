with Ada.Text_IO;		use Ada.Text_IO;
with Recipes;			use Recipes;
with Bottles;			use Bottles;

package Bartender_Utils is

	type RecipeArray is array(Positive range <>) of Recipe;
	type RecipeArrAccess is access RecipeArray;

	type BottleArray is array(Positive range <>) of Bottle;
	type BottleArrAccess is access BottleArray;

	-- I can pass only 1 object to a callback function
	type CallbackRecord is record
		Rec : Recipe;
		Bottles : BottleArrAccess;
	end record;

	procedure DumpBottleArrAccess(bottles : BottleArrAccess);
	procedure DumpRecipeArrAccess(recipes : RecipeArrAccess);

end Bartender_Utils;
