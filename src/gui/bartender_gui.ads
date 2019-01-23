with Gtk.Window;		use Gtk.Window;
with Gtk.Scrolled_Window; 	use Gtk.Scrolled_Window;
with Gtk.Button; 		use Gtk.Button;
with Gtk.Widget; 		use Gtk.widget;
with Gtk.Menu_Bar;		use Gtk.Menu_bar;
with Gtk.Box;			use Gtk.Box;
with Gtk.Menu_Item;		use Gtk.Menu_Item;
with Gtk.Enums;			use Gtk.Enums;
with Gtk.Bin;			use Gtk.Bin;
with Gtk.Handlers;		use Gtk.Handlers;
with Ada.Text_IO;		use Ada.Text_IO;
with Recipes;			use Recipes;
with Bottles;			use Bottles;
with p_callback;		use p_callback;

package Bartender_GUI is

	subtype Positive is Integer range 0 .. Integer'Last;
	type Button is record
		Button : Gtk_Button;
		Rec : Recipe;
	end record;

	type RecipeArray is array(Positive range <>) of Recipe;
	type RecipeArrAccess is access RecipeArray;

	type BottleArray is array(Positive range <>) of Bottle;
	type BottleArrAccess is access BottleArray;

	type ButtonArray is array(Positive range <>) of Button;
	type ButtArrAccess is access ButtonArray;

	type BartenderWindow is record
		Window 		: Gtk_Window;
		MainBox 	: Gtk_VBox;
		MenuBar 	: Gtk_Menu_bar;
		Scroll 		: Gtk_Scrolled_Window;
		RecipeBox 	: Gtk_VBox;
		RecipesButts 	: ButtArrAccess;
		Bottles		: BottleArrAccess;
	end record;

	type BarWinAccess is access BartenderWindow;

	function BartenderWinBasic return BarWinAccess;

end Bartender_GUI;
