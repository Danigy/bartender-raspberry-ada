with Pumps;

procedure Test_Pump is
    Pu : Pumps.Pump := (GPIO.libsimpleio.Create(0, 15, GPIO.Output), 10);
begin
    null;
end Test_Pump;

