WITH GPIO.libsimpleio; USE GPIO.libsimpleio;

package Pumps is

    type Pump is record
        IO 	: GPIO.Pin;
        Flow 	: Positive;
        NB	: Natural;
    end record;

     FUNCTION GetTime
            (P       : Pump;
             Vol     : Positive)
             RETURN Duration;

end Pumps;
