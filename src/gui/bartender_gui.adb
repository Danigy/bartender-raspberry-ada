package body Bartender_GUI is

	procedure DoRecipeErrorVolume is
	begin
		Put_Line("ERROR: remaining volume is not sufficient");
	end;

	-- Hardcoded for tests
	function ReadRecipes return RecipeArrAccess is
		ret : RecipeArrAccess;
	begin
		-- TODO call Coco's function to read from CSV
		ret := New RecipeArray'(
			(Name => new String'("Whiskey Coca"),
			 Ingredients => new Ingredients_Array'(
				(Name => new String'("Whiskey"), Vol => 200), 
				(Name => new String'("Coca"), Vol => 300))), 
			(Name => new String'("Vodka Redbull"),
			 Ingredients => new Ingredients_Array'(
				(Name => new String'("Vodka"), Vol => 200),
				(Name => new String'("Redbull"), Vol => 300))), 
			(Name => new String'("Vodka Pomme"), 
			 Ingredients => new Ingredients_Array'(
				(Name => new String'("Vodka"), Vol => 200),
				(Name => new String'("Pomme"), Vol => 300))), 
			(Name => new String'("Thé"), 
			 Ingredients => new Ingredients_Array'(
				(Name => new String'("Whiskey"), Vol => 200),
				(Name => new String'("Vodka"), Vol => 300)))
		);
		return ret;

	end; 

	-- hardcoded for tests
	function ReadBottles return BottleArrAccess is
		ret : BottleArrAccess;
	begin
		-- TODO call Coco's function to read from CSV
		ret := new BottleArray'(
			(Name => new String'("Whiskey"), Remaining_Vol => 750),
			(Name => new String'("Vodka"), Remaining_Vol => 750),
			(Name => new String'("Redbull"), Remaining_Vol => 1000),
			(Name => new String'("Pomme"), Remaining_Vol => 1500),
			(Name => new String'("Coca"), Remaining_Vol => 1500)
		);
		return ret;
	end;

	procedure callbackDoRecipe(from : access Gtk_Button_Record'class; cb : CallbackRecord) is
		pragma Unreferenced (from);
	begin
		Put("LOG: preparing "); Put_Line(cb.Rec.name.all);
		for i in cb.Rec.Ingredients'First .. cb.Rec.Ingredients'Last loop
			for j in cb.bottles'First .. cb.Bottles'Last loop
				if cb.Rec.Ingredients(i).Name.all = cb.Bottles(j).name.all then
					if cb.Rec.Ingredients(i).Vol < cb.Bottles(j).Remaining_Vol then
						-- TODO call to the good GPIO / pump
						RemoveRemainingVolume(cb.Bottles(j), cb.Rec.Ingredients(i).Vol);
					else
						DoRecipeErrorVolume;
						DumpBottleArrAccess(cb.bottles);
						return;
					end if;
				end if;
			end loop;
		end loop;
		DumpBottleArrAccess(cb.bottles);
	end;

	function BartenderwinBasic return BarWinAccess is
		ret 		: BarWinAccess;
		bartenderObj 	: BartenderWindow;
		addBottle 	: Gtk_Menu_Item;
		addRecipe 	: Gtk_Menu_Item;
		recipes 	: RecipeArrAccess := ReadRecipes;
		bottles		: BottleArrAccess := ReadBottles;	
		butts 		: ButtonArray(recipes'First..recipes'Last);
		title : String := "Ada Bartender";
	begin
		-- setting up bartenderObj.Windowdow object
		Gtk_New(bartenderObj.Window);
		bartenderObj.Window.Set_Title(title);
		bartenderObj.Window.set_default_size(400,400);
		
		-- setting up main box object
		Gtk_New_VBox(bartenderObj.MainBox);

		-- setting up bartenderObj.MenuBar bar
		Gtk_New(bartenderObj.MenuBar);
		bartenderObj.MenuBar.set_pack_direction(Pack_Direction_LTR);
		bartenderObj.MainBox.pack_start(bartenderObj.MenuBar, Expand => false, Fill => true);
		-- setting up bartenderObj.MenuBar items
		Gtk_New(addBottle, "Add Bottle");
		Gtk_New(addRecipe, "Add Recipe");
		bartenderObj.MenuBar.Append(addRecipe);
		bartenderObj.MenuBar.Append(addBottle);	

		-- setting up buttons for tests
		Gtk_New_VBox(bartenderObj.RecipeBox);
		for i in butts'First..butts'Last loop
			Gtk_New(butts(i).Button, recipes(i).Name.all);
			butts(i).Rec := recipes(i);
			Connect (butts(i).Button, "clicked", callbackDoRecipe'access, 
				(Rec => recipes(i), bottles => bottles));
			bartenderObj.RecipeBox.Pack_End(butts(i).Button);
		end loop;

		-- setting up Scroll
		Gtk_New(bartenderObj.Scroll);
		bartenderObj.Scroll.Set_Policy(Policy_Automatic, Policy_Automatic);
		bartenderObj.Scroll.add_with_viewport(bartenderObj.RecipeBox);
		bartenderObj.MainBox.pack_start(bartenderObj.Scroll, Expand => true, Fill => true);

		bartenderObj.Window.Add(bartenderObj.MainBox);
		bartenderObj.RecipesButts := new ButtonArray'(butts);

		ret := new BartenderWindow'(bartenderObj);
		DumpBottleArrAccess(bottles);
		return ret;
	end BartenderWinBasic;

end Bartender_GUI;
