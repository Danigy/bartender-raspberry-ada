with Ada.Strings.Unbounded;

package Recipes is

    subtype Positive is Integer range 1 .. Integer'Last;

    type String_Access is access all String;

    type Ingredient is record
        Name : String_Access;
        Vol : Positive;        -- Required volume in ml
    end record;

    type Ingredients_Array is array(Positive range <>) of Ingredient;
    type Ingredients_Access is access Ingredients_Array;

    type Recipe is record
        Name : String_Access;
        Ingredients : Ingredients_Access;
    end record;

end Recipes;

