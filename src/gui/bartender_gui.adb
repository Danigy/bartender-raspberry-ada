package body Bartender_GUI is
	procedure callbackDoRecipe(from : access Gtk_Button_Record'class; rec : Recipe) is
		pragma Unreferenced (from);
	begin
		Put("LOG: preparing "); Put_Line(rec.name.all);
		Put_Line("");
	end;

	function BartenderwinBasic return BarWinAccess is
		ret 		: BarWinAccess;
		bartenderObj 	: BartenderWindow;
		addBottle 	: Gtk_Menu_Item;
		addRecipe 	: Gtk_Menu_Item;
		butts 		: ButtonArray(1..4);
		recipes 	: RecipeArray(1..4);
	
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

		-- setting up hardcoded recipes for tests
		recipes(1) := (Name => new String'("Whiskey Coca"),  Ingredients => 
			new Ingredients_Array'((Name => new String'("Whiskey"), Vol => 200), 
					(Name => new String'("Coca"), Vol => 300)));

		recipes(2) := (Name => new String'("Vodka Redbull"), Ingredients =>
			new Ingredients_Array'((Name => new String'("Vodka"), Vol => 200),
					(Name => new String'("Redbull"), Vol => 300)));

		recipes(3) := (Name => new String'("Vodka Pomme"), Ingredients =>
			new Ingredients_Array'((Name => new String'("Vodka"), Vol => 200),
					(Name => new String'("Pomme"), Vol => 300)));

		recipes(4) := (Name => new String'("Thé"), Ingredients =>
			new Ingredients_Array'((Name => new String'("Whiskey"), Vol => 200),
					(Name => new String'("Vodka"), Vol => 300)));
		-- setting up hardcoded recipes buttons, connecting them to callback function
		Gtk_New_VBox(bartenderObj.RecipeBox);
		for i in 1..4 loop
			Gtk_New(butts(i).Button, recipes(i).Name.all);
			butts(i).Rec := recipes(i);
			Connect (butts(i).Button, "clicked", callbackDoRecipe'access, butts(i).Rec);
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
		return ret;
	end BartenderWinBasic;

end Bartender_GUI;
