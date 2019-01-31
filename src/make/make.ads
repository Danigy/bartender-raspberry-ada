with Pumps;    use Pumps;
with Draughts; use Draughts;
with Recipes;  use Recipes;
with Bottles;  use Bottles;

package Make is

    type Job is record
        P : Pump;
        T : Duration;
    end record;

    type Jobs is array (Integer range <>) of Job;

    type JobsAccess is Access Jobs;

    procedure BSort
        (J : in out Jobs);

    procedure Schedule
        (J : in out Jobs);

    procedure AddJob
        (Ing	: in Ingredient;
         Mach	: in Draught_Array;
         J	: in out JobsAccess);

    function GetJobs
        (Rec  	: Recipe;
         Mach	: Draught_Array)
         return JobsAccess;

    procedure RemoveVolumes
        (Rec	: Recipe;
	 Mach	: in out Draught_Array);

    function Groom
        (Rec	: Recipe;
         Mach	: in out Draught_Array)
         return JobsAccess;

    function MakeCocktail 
        (J : JobsAccess)
        return Boolean;

end Make;
