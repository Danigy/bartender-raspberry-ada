package body CSV is

    function NextElement (Line : String; First : Integer) return Integer is
        Next : Integer := First;
    begin
        while Next <= Line'Last and then Line(Next) /= ',' loop
            Next := Next + 1;
        end loop;
        return Next; 
    end NextElement;

end CSV;
