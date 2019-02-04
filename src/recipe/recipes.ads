with Ada.Strings.Unbounded;
with Strings; use Strings;

package Recipes is

    type Ingredient is record
        Name : String_Access;
        Vol : Natural;        -- Required volume in ml
    end record;

    type Ingredients_Array is array(Positive range <>) of Ingredient;
    type Ingredients_Access is access Ingredients_Array;

    type Recipe is record
        Name : String_Access;
        Ingredients : Ingredients_Access;
    end record;

end Recipes;

