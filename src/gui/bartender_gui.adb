package body Bartender_GUI is
	procedure callbackDoRecipe(from : access Gtk_Button_Record'class) is
		pragma Unreferenced (from);
	begin
		Put_Line("LOG: DO_RECIPE");
	end;

	function BartenderwinBasic return BarWinAccess is
		ret : BarWinAccess;
		bartenderObj : BartenderWindow;
		addBottle : Gtk_Menu_Item;
		addRecipe : Gtk_Menu_Item;
		butts : ButtonArray(1..100);
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


		-- setting up recipes box / buttons, connecting them to callback function
		Gtk_New_VBox(bartenderObj.RecipeBox);
		for i in 1..100 loop
			Gtk_New(butts(i), "recipe ");
			butts(i).On_Clicked(callbackDoRecipe'access);
			bartenderObj.RecipeBox.Pack_End(butts(i));
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
