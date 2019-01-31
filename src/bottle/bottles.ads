with Strings; use Strings;

package Bottles is

    type Bottle is tagged record
        Name : String_Access;
        Remaining_Vol : Positive; -- Remaining Volume in the bottle in ml
    end record;

    procedure RemoveRemainingVolume (bot: in out Bottle; Vol : Positive)
        with Pre => bot.Remaining_Vol > Vol,
             Post => bot.Remaining_vol >= 0 and then bot'old.Remaining_Vol - Vol = bot.Remaining_Vol and then bot'Old.Name = bot.Name;

end Bottles;
