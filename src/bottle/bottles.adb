package body Bottles is

    procedure RemoveVolume (bot: in out Bottle; Vol : Natural) is
    begin
        bot.Vol := bot.Vol - Vol;
    end RemoveVolume;

end Bottles;
