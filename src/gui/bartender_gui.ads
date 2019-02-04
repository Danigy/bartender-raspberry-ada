with Gtk.Window;		use Gtk.Window;
with Gtk.Scrolled_Window;	use Gtk.Scrolled_Window;
with Gtk.Button;		use Gtk.Button;
with Gtk.Widget;		use Gtk.widget;
with Gtk.Menu_Bar;		use Gtk.Menu_bar;
with Gtk.Menu;			use Gtk.Menu;
with Gtk.Box;			use Gtk.Box;
with Gtk.Menu_Item;		use Gtk.Menu_Item;
with Gtk.Enums;			use Gtk.Enums;
with Gtk.Bin;			use Gtk.Bin;
with Gtk.Handlers;		use Gtk.Handlers;
with Gtk.Combo_Box;		use Gtk.Combo_Box;
with Gtk.Combo_Box_Text;	use Gtk.Combo_Box_Text;
with Ada.Text_IO;		use Ada.Text_IO;
with Gtk.Dialog;		use Gtk.Dialog;
with Gtk.Dialog;		use Gtk.Dialog;
with Gtk.Message_Dialog;	use Gtk.Message_Dialog;
with Gtk.About_Dialog;		use Gtk.About_Dialog;
with Gtk.GEntry;		use Gtk.GEntry;
with Gtk.Notebook;		use Gtk.Notebook;
with Gtk.Main;			use Gtk.Main;
with Gtk.Label;			use Gtk.Label;

with Recipes;			use Recipes;
with Recipe_lists;		use Recipe_lists;
with Recipe_CSV;		use Recipe_CSV;
with Recipe_CSV_Writer;		use Recipe_CSV_Writer;
with Pump_CSV;			use Pump_CSV;
with Pump_CSV_Writer;		use Pump_CSV_Writer;
with Draughts;			use Draughts;
with Bottles;			use Bottles;
with Make;			use Make;

package Bartender_GUI is

	package  ItemHandler is new Gtk.Handlers.Callback(Gtk_Menu_Item_Record);
	use ItemHandler;

	
	package ButtonHandler is new Gtk.Handlers.User_Callback(Gtk_Button_Record, Recipes.Recipe);
	use ButtonHandler;

	type GEntryArray is array(Positive range<>) of Gtk_GEntry;
	type GEntryArrAccess is access GEntryArray;

	type RecButton is record
		Button	: Gtk_Button;
		Rec 	: Recipes.Recipe;
	end record;

	type BotButton is record
		Button 	: Gtk_Button;
		Bot	: Bottles.Bottle;
	end record;

	type DraughtButton is record
		Button	: Gtk_Button;
		Draught	: Draughts.Draught;
	end record;

	type RecButtonArray is array(Positive range <>) of RecButton;
	type RecButtArrAccess is access RecButtonArray;
	type BotButtonArray is array(Positive range <>) of BotButton;
	type BotButtArrAccess is access BotButtonArray;
	type DraughtButtonArray is array(Positive range<>) of DraughtButton;
	type DraughtButtArrAccess is access DraughtButtonArray;

	type BartenderGUI is record
		Window 			: Gtk_Window;
		MainBox 		: Gtk_VBox;
		MenuBar 		: Gtk_Menu_bar;

		Tabs			: Gtk_Notebook;

		-- objects for tab listing all recipes
		AllRecPage		: Gtk_Label;
		AllRecBox		: Gtk_VBox;
		AllRecScroll 		: Gtk_Scrolled_Window;
		AllRecButts 		: RecButtArrAccess;

		-- objetcs for tab listing bottles
		BottlePage		: Gtk_Label;
		BottleBox		: Gtk_VBox;
		BottleButts		: DraughtButtArrAccess;
		BottleScroll		: Gtk_Scrolled_Window;

		-- objects for tab listing available recipes
		AvailableRecPage	: Gtk_Label;
		AvailableRecBox 	: Gtk_VBox;
		AvailableRecButts	: RecButtArrAccess;
		AvailableRecScroll	: Gtk_Scrolled_Window;

	end record;

	type GUIAccess is access BartenderGUI;

	procedure callbackDoRecipe(from : access Gtk_Button_Record'class; rec : Recipes.Recipe);

	procedure RunGUI;

end Bartender_GUI;
