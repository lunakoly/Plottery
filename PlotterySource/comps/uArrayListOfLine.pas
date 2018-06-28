unit uArrayListOfLine;

interface

uses uArrayList, uLine;


{
    Automatic dynamic lines array
}
type ArrayListOfLine = class(ArrayList)
    public
        procedure add(l: Line); overload;
        procedure put(l: Line; index: integer); overload;
        function remove(index: integer): Line; overload;
        procedure remove(l: Line); overload;
        function get(index: integer): Line; overload;

        function find(l: Line): integer; overload;
end;


implementation


// ArrayListOfLine
procedure ArrayListOfLine.add(l: Line);
begin
    inherited add(l);
end;


// ArrayListOfLine
procedure ArrayListOfLine.put(l: Line; index: integer);
begin
    inherited put(l, index);
end;


// ArrayListOfLine
function ArrayListOfLine.remove(index: integer): Line;
begin
    remove := inherited remove(index) as Line;
end;


// ArrayListOfLine
procedure ArrayListOfLine.remove(l: Line);
var i: integer;

begin
    for i := 0 to size() - 1 do begin
        if (arr[i] as Line) = l then begin
            remove(i);
            break;
        end;
    end;
end;


// ArrayListOfLine
function ArrayListOfLine.get(index: integer): Line;
begin
    get := inherited get(index) as Line;
end;


// ArrayListOfLine
function ArrayListOfLine.find(l: Line): integer;
var i: integer;

begin
    find := -1;

    for i := 0 to len - 1 do
        if l = get(i) then begin
            find := i;
            break;
        end;
end;


end.

