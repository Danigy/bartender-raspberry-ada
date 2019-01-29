WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Ada.Strings; USE Ada.Strings;
WITH GPIO.libsimpleio; USE GPIO.libsimpleio;
WITH Pumps; USE Pumps;
WITH Recipes; USE Recipes;

PACKAGE BODY MAKE IS
       
PROCEDURE BSort (J : in out Jobs) IS

	Temp : Job;
BEGIN
	for I in reverse J'Range loop
		for K in J'First .. I loop
			if J(I).T < J(K).T then
				Temp := J(K);
				J(K) := J(I);
				J(I) := Temp;
			end if;
		end loop;
	end loop;
END BSort;

PROCEDURE Schedule (J : in out Jobs) IS
BEGIN
	for I in J'First .. J'Last - 1 loop
		for K in I + 1 .. J'Last loop
			J(K).T := J(K).T - J(I).T;
		end loop;
	end loop;
END Schedule;

PROCEDURE AddJob
	(Ing 	: in Ingredient;
	 Mach	: in Draught_Array;
	 J 	: in out JobsAccess) IS
	
	Ret : Job;
BEGIN
	for I in Mach'Range loop
		if Ing.Name.all = Mach(I).Bottle.Name.all then
			Ret := (Mach(I).Pump, GetTime(Mach(I).Pump, Ing.Vol));
		end if;
	end loop;
	J := new Jobs'(J.all & Ret);
END AddJob;

FUNCTION GetJobs
	(Rec	: Recipe; 
	 Mach	: Draught_Array)
	RETURN JobsAccess IS

	J : JobsAccess;
BEGIN
	for I in Rec.Ingredients.all'Range loop
		AddJob(Rec.Ingredients.all(I), Mach, J);
	end loop;
	return J;
END GetJobs;

FUNCTION Groom
	(Rec	: Recipe;
	 Mach	: Draught_Array)
	 RETURN JobsAccess IS

	 J : JobsAccess;
BEGIN
	J := GetJobs(Rec, Mach);
	BSort(J.all);
	Schedule(J.all);
	return J;
END Groom;

FUNCTION MakeCocktail (J : JobsAccess) RETURN Boolean IS
BEGIN
	for I in J.all'Range loop
		J.all(I).P.IO.Put(True);
	end loop;
	for I in J.all'Range loop
		delay J(I).T;
		J.all(I).P.IO.Put(False);
	end loop;
	return True;
END MakeCocktail;

END MAKE;
