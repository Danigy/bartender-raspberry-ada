WITH GPIO.libsimpleio; USE GPIO.libsimpleio;

PACKAGE BODY Pumps IS

    FUNCTION GetTime
	    (P		: Pump;
	     Vol	: Integer)
	     RETURN Duration IS

	      Time : Duration;
    BEGIN
	    return Duration(Vol) / Duration(P.Flow);
    END GetTime;

END Pumps;
