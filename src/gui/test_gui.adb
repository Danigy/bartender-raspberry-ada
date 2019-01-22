with Gtk.Main;
with Bartender_GUI; use Bartender_GUI;

procedure Test_GUI is 
	win : BarWinAccess;
begin
	Gtk.Main.Init;
	win := BartenderWinBasic;
	win.Window.Show_All;
	Gtk.Main.Main;

end Test_GUI;
