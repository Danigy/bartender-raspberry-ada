package body Bottles is
    procedure RemoveRemainingVolume (bot: in out Bottle; Vol : Positive) is
    begin
        bot.Remaining_Vol := bot.Remaining_Vol - Vol;
    end RemoveRemainingVolume;
end Bottles;
