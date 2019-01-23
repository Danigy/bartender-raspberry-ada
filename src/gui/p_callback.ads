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
with Recipes;			use Recipes;

package p_callback is new Gtk.Handlers.User_Callback(Gtk_Button_Record, Recipe);
