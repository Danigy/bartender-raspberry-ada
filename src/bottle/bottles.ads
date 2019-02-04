with Strings; use Strings;

package Bottles is

    type Bottle is tagged record
        Name : String_Access;
        Remaining_Vol : Positive; -- Remaining Volume in the bottle in ml
    end record;

    type BottleArray is array(Positive range <>) of Bottles.Bottle;
    type BottleArrAccess is access all BottleArray;

    procedure RemoveVolume (bot: in out Bottle; Vol : Natural)
        with Pre => bot.Vol > Vol,
             Post => bot.Vol >= 0 and then bot'Old.Vol - Vol = bot.Vol and then
                     bot'Old.Name = bot.Name;

end Bottles;
