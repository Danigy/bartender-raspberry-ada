with Recipes;

package Recipe_lists is
    type Available_Recipe;
    type Available_Recipe_Access is access Available_Recipe;

    type Available_Recipe is record
        Cocktail : Recipes.Recipe;
        Available : Boolean;
        Next : Available_Recipe_Access;
    end record;

    type Recipe_List is tagged record
        Length : Natural;
        Tail : Available_Recipe_Access;
    end record;

    function Init return Recipe_List;
    procedure Insert(This : in out Recipe_List; Cocktail : Recipes.Recipe; Available : Boolean := false);
    function Get(This : Recipe_List; Elt : Natural) return Available_Recipe
        with Pre => Elt < This.Length;

end Recipe_lists;
