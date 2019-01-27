with Bottles, Pumps;

package Draughts is

    type Draught is record
        Bottle : Bottles.Bottle;
        Pump : Pumps.Pump;
    end record;

    type Draught_Array is array(Positive range <>) of Draught;

end Draughts;
