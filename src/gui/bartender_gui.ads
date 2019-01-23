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
with p_callback;		use p_callback;

package Bartender_GUI is

	subtype Positive is Integer range 0 .. Integer'Last;
	type ButtonArray is array(Positive range <>) of Gtk_Button;
	type ButtArrAccess is access ButtonArray;

	type BartenderWindow is record
		Window : Gtk_Window;
		MainBox : Gtk_VBox;
		MenuBar : Gtk_Menu_bar;
		Scroll : Gtk_Scrolled_Window;
		RecipeBox : Gtk_VBox;
		RecipesButts : ButtArrAccess;
	end record;

	type BarWinAccess is access BartenderWindow;

	function BartenderWinBasic return BarWinAccess;

end Bartender_GUI;
