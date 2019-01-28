package body Recipe_lists is

    function Init return Recipe_list is
    begin
        return (0, null);
    end Init;

    procedure Insert(This: in out Recipe_List; Cocktail : Recipes.Recipe; Available : Boolean := false) is
    begin
        This.Tail := new Available_Recipe'(Cocktail, Available, This.Tail);
        This.Length := This.Length + 1;
    end Insert;

    function Get(This : Recipe_List; Elt : Natural) return Available_Recipe is
        It : Available_Recipe_Access := This.Tail;
    begin
        for I in 0 .. Elt - 1 loop

           It := It.all.Next; 
        end loop;
        return It.all;
    end Get;
end Recipe_Lists;
