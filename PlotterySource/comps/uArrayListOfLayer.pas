unit uArrayListOfLayer;

interface

uses uArrayList, uLayer;


{
    Automatic dynamic layers array
}
type ArrayListOfLayer = class(ArrayList)
    public
        procedure add(l: Layer); overload;
        procedure put(l: Layer; index: integer); overload;
        function remove(index: integer): Layer; overload;
        procedure remove(l: Layer); overload;
        function get(index: integer): Layer; overload;

        function find(l: Layer): integer; overload;
end;


implementation


// ArrayListOfLayer
procedure ArrayListOfLayer.add(l: Layer);
begin
    inherited add(l);
end;


// ArrayListOfLayer
procedure ArrayListOfLayer.put(l: Layer; index: integer);
begin
    inherited put(l, index);
end;


// ArrayListOfLayer
function ArrayListOfLayer.remove(index: integer): Layer;
begin
    remove := inherited remove(index) as Layer;
end;


// ArrayListOfLayer
procedure ArrayListOfLayer.remove(l: Layer);
var i: integer;

begin
    for i := 0 to size() - 1 do begin
        if (arr[i] as Layer) = l then begin
            remove(i);
            break;
        end;
    end;
end;


// ArrayListOfLayer
function ArrayListOfLayer.get(index: integer): Layer;
begin
    get := inherited get(index) as Layer;
end;


// ArrayListOfLayer
function ArrayListOfLayer.find(l: Layer): integer;
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

