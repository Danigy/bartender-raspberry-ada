package body Bartender_GUI is
	GUI : GUIAccess;
	bots : BottleArrAccess;
	recs	: RecipeArrAccess;

	-- Hardcoded for tests
	function CheckAvailableRecipe(rec : Recipes.Recipe) return Recipes.String_Access is
		found : Boolean := false;
	begin
		for i in rec.Ingredients'First .. rec.Ingredients'Last loop
			found := false;
			for j in bots'First .. bots'Last loop
				if rec.Ingredients(i).Name.all = bots(j).Name.all then
					found := true;
				elsif not found and rec.Ingredients(i).Name.all /= bots(j).Name.all and j = bots'Last then
					return rec.Ingredients(i).Name;
				end if;
			end loop;
		end loop;
		return null;
	end;

	function ReadRecipes return RecipeArrAccess is
		ret : RecipeArrAccess;
	begin
		-- TODO call Coco's function to read from CSV
		ret := New RecipeArray'(
			(Name => new String'("Whiskey Coca"),
			 Ingredients => new Recipes.Ingredients_Array'(
				(Name => new String'("Whiskey"), Vol => 200), 
				(Name => new String'("Coca"), Vol => 300))), 
			(Name => new String'("Vodka Redbull"),
			 Ingredients => new Recipes.Ingredients_Array'(
				(Name => new String'("Vodka"), Vol => 200),
				(Name => new String'("Redbull"), Vol => 300))), 
			(Name => new String'("Vodka Pomme"), 
			 Ingredients => new Recipes.Ingredients_Array'(
				(Name => new String'("Vodka"), Vol => 200),
				(Name => new String'("Pomme"), Vol => 300))), 
			(Name => new String'("Thé"), 
			 Ingredients => new Recipes.Ingredients_Array'(
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

	procedure callbackAddIngredients(from : access Gtk_Menu_Item_Record'Class; name : Recipes.String_Access; nb : Positive) is
		dialog   : Gtk_Dialog;
		btnOK    : Gtk_Button; pragma unreferenced(btnOK);
		btnKO    : Gtk_Button; pragma unreferenced(btnKO);
		EntryArr : GEntryArray(1..nb * 2);
		ret	 : Recipes.Recipe;
		box	 : Gtk_VBox;
		ings	 : Ingredients_Access;
	begin
		ings := new Ingredients_Array(1 .. nb);
		Gtk_New(dialog, Title => "Add Ingredients", Parent => Gtk_Window(Get_Toplevel(from)),
			Flags => Use_Header_Bar_From_Settings(from));
		dialog.Set_Parent(GUI.Window);
		btnOK := Gtk_Button(dialog.Add_Button("OK", GTK_Response_OK));
		btnKO := Gtk_Button(dialog.Add_Button("Cancel", GTK_Response_Cancel));

		Gtk_New_VBox(box, Homogeneous => false);
		for i in 1 .. nb * 2 loop
			Gtk_New(EntryArr(i));
			Pack_Start(box, EntryArr(i));
		end loop;

		Pack_Start(dialog.Get_Content_Area, box);
		dialog.Show_All;

		if dialog.run = Gtk_Response_OK then
			-- create recipe
			for i in 1 .. nb * 2 loop
				if i mod 2 = 0 then
					ings((i / 2) + i mod 2).Vol := Integer'Value(Get_Text(EntryArr(i)));
				else
					ings((i / 2) + i mod 2).Name := new String'(Get_Text(EntryArr(i)));
				end if;
				ret := (Name => name, Ingredients => ings);
				recs := new RecipeArray'(recs.all & ret);
			end loop;
			-- for logs and tests
			Put("LOG: Added new recipe: ");
			Put(ret.Name.all);
			Put(", Ingredients are: ");
			for i in 1 .. nb loop
				Put(ings(i).Name.all);
				Put("=> ");
				Put(ings(i).Vol'Image);
				Put("ml; ");
			end loop;
			Put_Line("");
		else
			Put_Line("Cancel Add recipe");
		end if;
		dialog.destroy;
	end;

	procedure callbackAddRecipe(from : access Gtk_Menu_Item_Record'Class) is
		dialog 		: Gtk_Dialog;
		box		: Gtk_VBox;
		btnOK		: Gtk_Button; pragma unreferenced(btnOK);
		btnKO		: Gtk_Button; pragma unreferenced(btnKO);
		name		: Gtk_Gentry;
		nbentry		: Gtk_Gentry;
		nbing		: Integer;
	begin
		Gtk_New(dialog, Title => "Add Recipe", Parent => Gtk_Window(Get_Toplevel(from)),
			Flags => Use_Header_Bar_From_Settings(from));
		dialog.Set_Parent(GUI.Window);
		btnOK := Gtk_Button(dialog.Add_Button("OK", GTK_Response_OK));
		btnKO := Gtk_Button(dialog.Add_Button("Cancel", GTK_Response_Cancel));

		Gtk_New_VBox(box, Homogeneous => false);
		Gtk_New(name);
		Gtk_New(nbentry);
		Pack_Start(box, name);
		Pack_Start(box, nbentry);
		Pack_Start(dialog.Get_Content_Area, box);
		
		dialog.Show_All;

		if dialog.run = Gtk_Response_OK then
			
			nbing := Integer'Value(Get_Text(nbentry));
			if nbing > 0 then
				callbackAddIngredients(from, new String'(Get_Text(name)), nbing);
			else
				Put_Line("Bad nb of ingredients");
			end if;
		else
			Put_Line("Cancel Add recipe");
		end if;
		dialog.destroy;
	end;


	procedure callbackReplaceBottle(from : access Gtk_Menu_Item_Record'Class) is
		dialog 	: Gtk_Dialog;
		box	: Gtk_VBox;
		combo	: Gtk_Combo_Box_Text;
		btnOK	: Gtk_Button; pragma unreferenced(btnOK);
		btnKO	: Gtk_Button; pragma unreferenced(btnKO);
		name	: Gtk_Gentry;
		vol	: Gtk_GEntry;
		idx	: Integer;
	begin
		Gtk_New(dialog, Title => "Replace Bottle", Parent => Gtk_Window(Get_Toplevel(from)),
			Flags => Use_Header_Bar_From_Settings(from));
		dialog.Set_Parent(GUI.Window);
		btnOK := Gtk_Button(dialog.Add_Button("OK", GTK_Response_OK));
		btnKO := Gtk_Button(dialog.Add_Button("Cancel", GTK_Response_Cancel));

		Gtk_New_VBox(box, Homogeneous => false);
		Gtk_New(combo);
		Gtk_New(name);
		Gtk_New(vol);
		for i in bots'first .. bots'last loop
			Append_Text(combo, bots(i).Name.all);
		end loop;
		Pack_Start(box, combo, Expand => false);
		Pack_Start(box, name);
		Pack_Start(box, vol);
		Pack_Start(dialog.Get_Content_Area, box);

		dialog.Show_All;

		if dialog.run = GTK_Response_OK then
			idx := Integer(Get_Active(combo)) + 1;
			Put("LOG: Replacing bottle of ");
			Put(bots(idx).Name.all);
			Put(" by a Bottle of ");
			bots(idx).Name := new String'(Get_Text(name));
			bots(idx).Remaining_Vol := Integer'Value(Get_Text(vol));
			Put_Line(bots(idx).Name.all);
		else
			Put_Line("Cancel bottle replacement");
		end if;
		dialog.destroy;

	end;

	procedure callbackRefillBottle(from : access Gtk_Menu_Item_Record'Class) is
		dialog 	: Gtk_Dialog;
		box	: Gtk_VBox;
		combo	: Gtk_Combo_Box_Text;
		btnOK	: Gtk_Button; pragma unreferenced(btnOK);
		btnKO	: Gtk_Button; pragma unreferenced(btnKO);
		vol	: Gtk_GEntry;
		idx	: Integer;
	begin
		Gtk_New(dialog, Title => "Refill Bottle", Parent => Gtk_Window(Get_Toplevel(from)),
			Flags => Use_Header_Bar_From_Settings(from));
		dialog.Set_Parent(GUI.Window);
		btnOK := Gtk_Button(dialog.Add_Button("OK", GTK_Response_OK));
		btnKO := Gtk_Button(dialog.Add_Button("Cancel", GTK_Response_Cancel));

		Gtk_New_VBox(box, Homogeneous => false);
		Gtk_New(combo);
		Gtk_New(vol);
		for i in bots'first .. bots'last loop
			Append_Text(combo, bots(i).Name.all);
		end loop;
		Pack_Start(box, combo, Expand => false);
		Pack_Start(box, vol);
		Pack_Start(dialog.Get_Content_Area, box);

		dialog.Show_All;

		if dialog.run = GTK_Response_OK then
			idx := Integer(Get_Active(combo)) + 1;
			bots(idx).Remaining_Vol := Integer'Value(Get_Text(vol));
			Put("LOG: Refilling bottle of ");
			Put(bots(idx).Name.all);
			Put(", new volume is ");
			Put(bots(idx).Remaining_Vol'Image);
			Put("ml");
		else
			Put_Line("LOG: Cancel bottle refill");
		end if;
		dialog.destroy;
	end;

	procedure callbackAddBottle(from : access Gtk_Menu_Item_Record'Class) is 	
		dialog 	: Gtk_Dialog;
		box	: Gtk_VBox;
		btnOK	: Gtk_Button; pragma unreferenced(btnOK);
		btnKO	: Gtk_Button; pragma unreferenced(btnKO);
		name	: Gtk_Gentry;
		vol	: Gtk_GEntry;
		bot 	: Bottles.Bottle;
	begin
		Put_Line("LOG: adding bottle");
		Gtk_New(dialog, Title => "Add New Bottle", Parent => Gtk_Window(Get_Toplevel(from)),
			Flags => Use_Header_Bar_From_Settings(from));
		dialog.Set_Parent(GUI.Window);
		btnOK := Gtk_Button(dialog.Add_Button("OK", GTK_Response_OK));
		btnKO := Gtk_Button(dialog.Add_Button("Cancel", GTK_Response_Cancel));

		Gtk_New_VBox(box, Homogeneous => false);
		Gtk_New(name);
		Gtk_New(vol);
		Pack_Start(box, name);
		Pack_Start(box, vol);
		Pack_Start(dialog.Get_Content_Area, box);

		dialog.Show_All;

		if dialog.run = GTK_Response_OK then
			bot := (Name => new String'(Get_Text(name)),
				Remaining_Vol => Integer'Value(Get_Text(vol)));
			bots := new BottleArray'(bots.all & bot);
			Put("LOG: Added new bottle of ");
			Put(bot.Name.all);
			Put(", Vol is ");
			Put(bot.Remaining_Vol'Image);
			Put_Line("ml");
		else
			Put_Line("LOG Cancel bottle refill");
		end if;
		dialog.destroy;
		DumpBottleArrAccess(bots);
	end;

	procedure DoRecipeErrorVolume(rec : Recipes.Recipe; bot : Bottles.Bottle) is
		ing : Recipes.Ingredient;
	begin
		for i in rec.Ingredients'First .. rec.Ingredients'Last loop
			if rec.Ingredients(i).Name.all = bot.Name.all then
				ing := rec.Ingredients(i);
			end if;
		end loop;
		Put("Error: ");
		Put(rec.Name.all);
		Put(" needs ");
		Put(ing.Vol'Image);
		Put("ml of ");
		Put(ing.Name.all);
		Put(" but the remaining volume is ");
		Put(bot.Remaining_Vol'Image);
		Put_Line("ml");
		--Put_Line("ERROR: remaining volume is not sufficient");
	end;

	procedure callbackDoRecipe(from : access Gtk_Button_Record'class; rec : Recipes.Recipe) is
		pragma Unreferenced (from);
		check : Recipes.String_Access := checkAvailableRecipe(rec);
	begin
		if check = null then
			Put("LOG: preparing "); Put_Line(rec.name.all);
			for i in rec.Ingredients'First .. rec.Ingredients'Last loop
				for j in bots'First .. bots'Last loop
					if rec.Ingredients(i).Name.all = bots(j).name.all then
						if rec.Ingredients(i).Vol < bots(j).Remaining_Vol then
							-- TODO call to the good GPIO / pump
							Put("Pouring ");
							Put(rec.Ingredients(i).Name.all);
							Put(" from bottle of ");
							Put_Line(bots(j).Name.all);
							Bottles.RemoveRemainingVolume(bots(j), rec.Ingredients(i).Vol);
						else
							DoRecipeErrorVolume(rec, bots(j));
						end if;
					end if;
				end loop;
			end loop;
		else
			Put("ERROR: Unable to prepare a ");
			Put(rec.Name.all);
			Put(": Missing bottle of ");
			Put_Line(check.all);
		end if;
		DumpBottleArrAccess(bots);
	end;

	procedure InitGUI is
		menuBottle 	: Gtk_Menu;
		bottle		: Gtk_Menu_Item;
		replaceBottle	: Gtk_Menu_Item;
		refillBottle	: Gtk_Menu_Item;
		addBottle	: Gtk_Menu_Item;
		addRecipe 	: Gtk_Menu_Item;
		--GUI.AllRecButts 	: ButtonArray(recs'First..recs'Last);
		title : String := "Ada Bartender";
	begin

		-- setting up global variables
		GUI := new BartenderGUI;

		-- setting up GUI.Window object
		Gtk_New(GUI.Window);
		GUI.Window.Set_Title(title);
		GUI.Window.set_default_size(400,400);
		
		-- setting up main box object
		Gtk_New_VBox(GUI.MainBox);

		-- setting up Menu bar
		Gtk_New(GUI.MenuBar);
		GUI.MenuBar.set_pack_direction(Pack_Direction_LTR);
		GUI.MainBox.pack_start(GUI.MenuBar, Expand => false, Fill => true);

		-- setting up Menu Bar items
		Gtk_New(bottle, "Bottles");
		Gtk_New(menuBottle);
		bottle.Set_Submenu(menuBottle);
		Gtk_New(refillBottle, "Refill Bottle");
		Gtk_New(replaceBottle, "Replace Bottle by Another");
		Gtk_New(addBottle, "Add Bottle");
		Gtk_New(addRecipe, "Add Recipe");
		menuBottle.append(replaceBottle);
		menuBottle.append(refillBottle);
		menuBottle.append(addBottle);
		GUI.MenuBar.Append(addRecipe);
		GUI.MenuBar.Append(bottle);	
		Connect(addBottle, "activate", callbackAddBottle'access); 
		Connect(refillBottle, "activate", callbackRefillBottle'access);
		Connect(replaceBottle, "activate", callbackReplaceBottle'access);
		Connect(addRecipe, "activate", callbackAddRecipe'access);


		-- setting up all recipes tab
		Gtk_New(GUI.AllRecPage, "All Recipes");
		Gtk_New_VBox(GUI.AllRecBox);
		GUI.AllRecButts := new RecButtonArray(recs'First..recs'Last);
		for i in GUI.AllRecButts'First..GUI.AllRecButts'Last loop
			Gtk_New(GUI.AllRecButts(i).Button, recs(i).Name.all);
			GUI.AllRecButts(i).Rec := recs(i);
			Connect (GUI.AllRecButts(i).Button, "clicked", callbackDoRecipe'access, recs(i));
			GUI.AllRecBox.Pack_End(GUI.AllRecButts(i).Button);
		end loop;
		Gtk_New(GUI.AllRecScroll);
		GUI.AllRecScroll.Set_Policy(Policy_Automatic, Policy_Automatic);
		GUI.AllRecScroll.add_with_viewport(GUI.AllRecBox);

		-- setting up bottles tab
		Gtk_New(GUI.BottlePage, "Bottles");
		Gtk_New_VBox(GUI.BottleBox);
		GUI.BottleButts := new BotButtonArray(bots'first.. bots'last);
		for i in bots'first .. bots'last loop
			Gtk_New(GUI.BottleButts(i).Button, bots(i).Name.all);
			GUI.BottleButts(i).Bot := bots(i);
			-- no connection needed
			GUI.BottleBox.Pack_End(GUI.BottleButts(i).Button);
		end loop;
		Gtk_New(GUI.BottleScroll);
		GUI.BottleScroll.Set_Policy(Policy_Automatic, Policy_Automatic);
		GUI.BottleScroll.add_with_viewport(GUI.BottleBox);

		-- setting up notebook / tabs
		Gtk_New(GUI.Tabs);
		GUI.Tabs.Append_Page(GUI.AllRecScroll, GUI.AllRecPage);
		GUI.Tabs.Append_Page(GUI.BottleScroll, GUI.BottlePage);

		-- setting up main box
		GUI.MainBox.pack_start(GUI.Tabs, Expand => true, Fill => true);

		GUI.Window.Add(GUI.MainBox);
		--GUI.AllRecButts := new ButtonArray'(GUI.AllRecButts);

		DumpBottleArrAccess(bots);
	end InitGUI;

	procedure RunGUI is
	begin
		recs := ReadRecipes;
		bots := ReadBottles;

		Gtk.Main.Init;
		InitGUI;
		Gui.Window.Show_All;
		Gtk.Main.Main;
		
	end RunGUI;

end Bartender_GUI;
