package Bottles is
    subtype Volume is Integer range 0 .. Integer'Last;

    type String_Access is access String;

    type Bottle is tagged record
        Name : String_Access;
        Remaining_Vol : Volume; -- Remaining Volume in the bottle in ml
    end record
    with Dynamic_Predicate => Remaining_Vol > 0;

    procedure RemoveRemainingVolume (This: in out Bottle; Vol : Positive)
    with Pre => This.Remaining_Vol > Vol,
         Post => This.Remaining_vol >= 0 and then This.Remaining_Vol'Old = This.Remaining_Vol + Vol;

end Bottles;
