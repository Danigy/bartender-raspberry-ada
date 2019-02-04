with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Strings;      use Ada.Strings;
with GPIO.libsimpleio; use GPIO.libsimpleio;
with Pumps;            use Pumps;
with Recipes;          use Recipes;
with Bottles;          use Bottles;
with Draughts;         use Draughts;

package body Make is
       
    procedure BSort (J : in out Jobs) is
        Temp : Job;

    begin
        for I in reverse J'Range loop
            for K in J'First .. I loop
                if J(I).T < J(K).T then
                    Temp := J(K);
                    J(K) := J(I);
                    J(I) := Temp;
                end if;
            end loop;
        end loop;
    end BSort;

    procedure Schedule (J : in out Jobs) is
    begin
        for I in J'First .. J'Last - 1 loop
            for K in I + 1 .. J'Last loop
                J(K).T := J(K).T - J(I).T;
            end loop;
        end loop;
    end Schedule;

    procedure AddJob
        (Ing 	: in Ingredient;
         Mach	: in Draught_Array;
         J 	: in out JobsAccess) is
        Ret : Job;
        TmpArr : Jobs(1..1);

    begin
        for I in Mach'Range loop
            if Ing.Name.all = Mach(I).Bottle.Name.all then
                Ret := (Mach(I).Pump, GetTime(Mach(I).Pump, Ing.Vol));
            end if;
        end loop;
        Put("Add Job of ");
        Put_Line(Ing.Name.all);
        if J = null then
            TmpArr := (others => Ret);
            J := new Jobs'(TmpArr);
        else
            J := new Jobs'(J.all & Ret);
        end if;
    end AddJob;

    function GetJobs
        (Rec	: Recipe; 
         Mach	: Draught_Array)
        return JobsAccess is
        J : JobsAccess := null;

    begin
        for I in Rec.Ingredients.all'Range loop
            AddJob(Rec.Ingredients.all(I), Mach, J);
        end loop;
        return J;
    end GetJobs;

    procedure RemoveVolumes
        (Rec	: in Recipe; 
         Mach	: in out Draught_Array) is

    begin
        for I in Rec.Ingredients.all'Range loop
            for J in Mach'Range loop
                if Rec.Ingredients.all(I).Name.all = Mach(I).Bottle.Name.all then
                    RemoveVolume(Mach(I).Bottle,  Rec.Ingredients.all(I).Vol);
                end if;
            end loop;
        end loop;
    end RemoveVolumes;

    function Groom
        (Rec	: Recipe;
         Mach	: in out Draught_Array)
        return JobsAccess is
        J : JobsAccess;

    begin
        J := GetJobs(Rec, Mach);
        BSort(J.all);
        Schedule(J.all);
	RemoveVolumes(Rec, Mach);
        return J;
    end Groom;

    function MakeCocktail (J : JobsAccess)
                          return Boolean is
    begin
        for I in J.all'Range loop
            J.all(I).P.IO.Put(True);
        end loop;
        for I in J.all'Range loop
            delay J(I).T;
            J.all(I).P.IO.Put(False);
        end loop;
        return True;
    end MakeCocktail;

end Make;
