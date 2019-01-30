package body Bartender_Utils is

	procedure DumpBottleArrAccess(bottles : DraughtArrAccess) is
	begin
		Put_Line("BOTTLES DUMP :");
		Put_Line("==============");
		for i in bottles'First .. bottles'Last loop
			Put(bottles(i).Bottle.Name.all); Put(": "); 
			Put(bottles(i).Bottle.Remaining_Vol'Image); 
			Put_Line("ml");
		end loop;
		Put_Line("");
	end;

	procedure DumpRecipeArrAccess(recipes : RecipeArrAccess) is
	begin
		Put_Line("RECIPES DUMP :");
		Put_Line("==============");
		for i in recipes'First .. recipes'Last loop
			Put(recipes(i).Name.all);
			Put(": "); 
			for j in recipes(i).Ingredients'First .. recipes(i).Ingredients'Last loop
				Put(recipes(i).Ingredients(j).Vol'Image); 
				Put_Line("ml");
			end loop;
		end loop;
		Put_Line("");
	end;

end Bartender_Utils;
