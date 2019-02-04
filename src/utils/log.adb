With Ada.Text_IO; use Ada.Text_IO;

package body Log is
	procedure MissingQuantity(Name: in String_Access; Vol: in Positive) is
	begin
		Put_line("Missing Quantity: " & Name.all & " has " &
			 Positive'Image(Vol) & " ml left.");
	end MissingQuantity;

	procedure MissingBottle(Name: in String_Access) is
	begin
		Put_line("Missing Bottle: " & Name.all & " not found.");
	end MissingBottle;

	procedure PrepareCocktail(Name: in String_Access) is
	begin
		Put_line("Prepare Cocktail: " & Name.all & ".");
	end PrepareCocktail;

	procedure FailedMake(Name: in String_Access) is
	begin
		Put_line("Failed Make: unable to make cocktail" & Name.all & ".");
	end FailedMake;

	procedure CocktailDone(Name: in String_Access) is
	begin
		Put_line("Cocktail Done: finished preparing" & Name.all & ".");
	end CocktailDone;

	procedure CannotAddRecipe(Reason: in String) is
	begin
		Put_line("Cannot Add Recipe: " & Reason & ".");
	end CannotAddRecipe;

	procedure AddRecipe(rec : in Recipes.Recipe; recs: in RecipeArrAccess) is
	begin
		Put_line("Add Recipe: " & rec.Name.all);
		for I in rec.Ingredients.all'Range loop
			Put_line (rec.Ingredients.all(I).Name.all & "=> " & 
				  Integer'Image(rec.Ingredients.all(I).Vol) & "ml.");
		end loop;
		DumpRecipeArrAccess(recs);
	end AddRecipe;

	procedure RefillBottle(Name: in String_Access; Vol: in Positive) is
	begin
		Put_line("Refill Bottle: " & Positive'Image(Vol) & " ml in " &
			 Name.all & "bottle.");
	end RefillBottle;

	procedure CannotRefillBottle is
	begin
		Put_line("Cannot Refill Bottle: Canceled");
	end CannotRefillBottle;

	procedure ReplaceBottle(NameOld: in String_Access; NameNew: in String_Access) is
	begin
		Put_line("Replace Bottle: " & NameOld.all & " replaced with " &
                         NameNew.all & ".");
	end ReplaceBottle;

	procedure CannotReplaceBottle is
	begin
		Put_line("Cannot Replace Bottle: Canceled");
	end CannotReplaceBottle;
end Log;
