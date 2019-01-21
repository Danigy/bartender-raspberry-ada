package body Bottles is
    procedure RemoveRemainingVolume (This: in out Bottle; Vol : Positive) is
    begin
        This.Remaining_Vol := This.Remaining_Vol - Vol;
    end RemoveRemainingVolume;
end Bottles;
