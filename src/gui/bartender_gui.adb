package body Bartender_GUI is
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
		Gtk_New(dialog, Title => "Refill Bottle", Parent => Gtk_Window(Get_Toplevel(from)),
			Flags => Use_Header_Bar_From_Settings(from));
		dialog.Set_Parent(GUI.Window);
		btnOK := Gtk_Button(dialog.Add_Button("OK", GTK_Response_OK));
		btnKO := Gtk_Button(dialog.Add_Button("Cancel", GTK_Response_Cancel));

		Gtk_New_VBox(box, Homogeneous => false);
		Gtk_New(combo);
		Gtk_New(name);
		Gtk_New(vol);
		for i in bottles'first .. bottles'last loop
			Append_Text(combo, bottles(i).Name.all);
		end loop;
		Pack_Start(box, combo, Expand => false);
		Pack_Start(box, name);
		Pack_Start(box, vol);
		Pack_Start(dialog.Get_Content_Area, box);

		dialog.Show_All;

		if dialog.run = GTK_Response_OK then
			idx := Integer(Get_Active(combo)) + 1;
			bottles(idx).Name := new String'(Get_Text(name));
			bottles(idx).Remaining_Vol := Integer'Value(Get_Text(vol));
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
		for i in bottles'first .. bottles'last loop
			Append_Text(combo, bottles(i).Name.all);
		end loop;
		Pack_Start(box, combo, Expand => false);
		Pack_Start(box, vol);
		Pack_Start(dialog.Get_Content_Area, box);

		dialog.Show_All;

		if dialog.run = GTK_Response_OK then
			idx := Integer(Get_Active(combo)) + 1;
			bottles(idx).Remaining_Vol := Integer'Value(Get_Text(vol));
		else
			Put_Line("Cancel bottle refill");
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
		bot 	: Bottle;
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
			bottles := new BottleArray'(bottles.all & bot);
			Put("Added new bottle of "); Put(bot.Name.all);
			
		else
			Put_Line("Cancel bottle refill");
		end if;
		dialog.destroy;
		DumpBottleArrAccess(bottles);
	end;

	procedure DoRecipeErrorVolume is
	begin
		Put_Line("ERROR: remaining volume is not sufficient");
	end;

	procedure callbackDoRecipe(from : access Gtk_Button_Record'class; rec : Recipe) is
		pragma Unreferenced (from);
	begin
		Put("LOG: preparing "); Put_Line(rec.name.all);
		for i in rec.Ingredients'First .. rec.Ingredients'Last loop
			for j in bottles'First .. bottles'Last loop
				if rec.Ingredients(i).Name.all = bottles(j).name.all then
					if rec.Ingredients(i).Vol < bottles(j).Remaining_Vol then
						-- TODO call to the good GPIO / pump
						RemoveRemainingVolume(bottles(j), rec.Ingredients(i).Vol);
					else
						DoRecipeErrorVolume;
						DumpBottleArrAccess(bottles);
					end if;
				end if;
			end loop;
		end loop;
		DumpBottleArrAccess(bottles);
	end;

	procedure InitGUI is
		menuBottle 	: Gtk_Menu;
		bottle		: Gtk_Menu_Item;
		replaceBottle	: Gtk_Menu_Item;
		refillBottle	: Gtk_Menu_Item;
		addBottle	: Gtk_Menu_Item;
		addRecipe 	: Gtk_Menu_Item;
		butts 		: ButtonArray(recipes'First..recipes'Last);
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

		-- setting up buttons for tests
		Gtk_New_VBox(GUI.RecipeBox);
		for i in butts'First..butts'Last loop
			Gtk_New(butts(i).Button, recipes(i).Name.all);
			butts(i).Rec := recipes(i);
			Connect (butts(i).Button, "clicked", callbackDoRecipe'access, recipes(i));
			GUI.RecipeBox.Pack_End(butts(i).Button);
		end loop;

		-- setting up Scroll
		Gtk_New(GUI.Scroll);
		GUI.Scroll.Set_Policy(Policy_Automatic, Policy_Automatic);
		GUI.Scroll.add_with_viewport(GUI.RecipeBox);
		GUI.MainBox.pack_start(GUI.Scroll, Expand => true, Fill => true);

		GUI.Window.Add(GUI.MainBox);
		GUI.RecipesButts := new ButtonArray'(butts);

		DumpBottleArrAccess(bottles);
	end InitGUI;

	procedure RunGUI is
	begin
		recipes	:= ReadRecipes;
		bottles := ReadBottles;

		Gtk.Main.Init;
		InitGUI;
		Gui.Window.Show_All;
		Gtk.Main.Main;
		
	end RunGUI;

end Bartender_GUI;
