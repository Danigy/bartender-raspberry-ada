With Pumps; 	USE Pumps;
With Draughts; 	USE Draughts;
WITH Recipes; 	USE Recipes;
WITH Bottles;	USE Bottles;

PACKAGE MAKE IS

type Job is record
        P : Pump;
        T : Duration;
end record;

type Jobs is array (Integer range <>) of Job;

type JobsAccess is Access Jobs;

PROCEDURE BSort
	(J : in out Jobs);

PROCEDURE Schedule
	(J : in out Jobs);

PROCEDURE AddJob
        (Ing	: in Ingredient;
         Mach	: in out Draught_Array;
         J	: in out JobsAccess);

FUNCTION GetJobs
	(Rec  	: Recipe;
	 Mach	: in out Draught_Array)
        RETURN JobsAccess;

FUNCTION Groom
	(Rec	: Recipe;
	 Mach	: in out Draught_Array)
	 RETURN JobsAccess;

FUNCTION MakeCocktail 
	(J : JobsAccess)
	RETURN Boolean;

END MAKE;
