WITH GPIO.libsimpleio; USE GPIO.libsimpleio;

package Pumps is

    type Pump is record
        IO 	: GPIO.Pin;
        Flow 	: Integer;
	NB	: Integer;
    end record;

     FUNCTION GetTime
            (P       : Pump;
             Vol     : Integer)
             RETURN Duration;

end Pumps;
