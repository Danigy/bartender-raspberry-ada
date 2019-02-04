with Pumps;    use Pumps;
with Draughts; use Draughts;
with Recipes;  use Recipes;
with Bottles;  use Bottles;

package Make is

    type Job is record
        P : Pump;
        T : Duration;
    end record;

    type Jobs is array (Positive range <>) of Job;

    type JobsAccess is Access Jobs;

    procedure BSort
        (J : in out Jobs)
    with
        Post => (
            for all I in J'First + 1 .. J'Last => J(I).T >= J(I -1).T); 

    procedure Schedule
        (J : in out Jobs)
    with
       Pre => (
             for all I in J'First + 1 .. J'Last => J(I).T >= J(I - 1).T),
       Post => (
             for all I in J'Range => J(I).T >= J'old(I).T);

    procedure AddJob
        (Ing	: in Ingredient;
         Mach	: in Draught_Array;
         J	: in out JobsAccess)
    with
        Post => (J.all'Length > J'old.all'Length);

    function GetJobs
        (Rec  	: Recipe;
         Mach	: Draught_Array)
         return JobsAccess
    with
        Post => (GetJobs'Result.all'Length = Rec.Ingredients.all'Length);

    procedure RemoveVolumes
        (Rec	: Recipe;
	 Mach	: in out Draught_Array)
    with
       Post => (
             for all I in Mach'Range => Mach'old(I).Bottle.Vol >= Mach(I).Bottle.Vol);

    function Groom
        (Rec	: Recipe;
         Mach	: in out Draught_Array)
         return JobsAccess
    with
        Post => (Groom'Result.all'Length = Rec.Ingredients.all'Length);

    function MakeCocktail 
        (J : JobsAccess)
        return Boolean;

end Make;
