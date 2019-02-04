with Recipes; use Recipes;
with Strings; use Strings;

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

    type RecipeArray is array(Positive range <>) of Recipes.Recipe;
    type RecipeArrAccess is access all RecipeArray;

    function Init return Recipe_List
        with Post => Init'Result.Length = 0 and then Init'Result.Tail = null;
    procedure Insert(This : in out Recipe_List; Cocktail : Recipes.Recipe; Available : Boolean := false)
        with Post => This.Length >  This'Old.Length and then This'Old.Tail = This.Tail.Next and then This.Tail.all.Cocktail.Name = Cocktail.Name and then This.Tail.all.Cocktail.Ingredients = Cocktail.Ingredients;
    function Get(This : Recipe_List; Elt : Natural) return Available_Recipe
        with Pre => Elt < This.Length;

end Recipe_lists;
