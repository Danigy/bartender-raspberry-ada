package Bottles is
    subtype Volume is Integer range 0 .. Integer'Last;

    type String_Access is access String;

    type Bottle is tagged record
        Name : String_Access;
        Remaining_Vol : Volume; -- Remaining Volume in the bottle in ml
    end record;
    -- with Dynamic_Predicate => This.Remaining_Vol > 0;

    procedure RemoveRemainingVolume (bot: in out Bottle; Vol : Positive);
    --with Pre => bot.Remaining_Vol > Vol,
    --     Post => bot.Remaining_vol >= 0 and then bot'old.Remaining_Vol - Vol > 0;

end Bottles;
