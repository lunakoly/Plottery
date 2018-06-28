unit uArrayListOfInt;

interface

uses uArrayList;


{
    Stores ints
}
type _Int = class(TObject)
    public
        num: integer;
end;
// parser
function TInt(i: integer): _Int;


{
    Automatic dynamic int array
}
type ArrayListOfInt = class(ArrayList)
    public
        procedure add(i: integer); overload;
        procedure put(i, index: integer); overload;
        function remove(index: integer): integer; overload;
        function get(index: integer): integer; overload;

        function find(i: integer): integer; overload;
end;


implementation


// _Int
function TInt(i: integer): _Int;
begin
    TInt := _Int.Create();
    TInt.num := i;
end;


// ArrayListOfInt
procedure ArrayListOfInt.add(i: integer);
begin
    inherited add(TInt(i));
end;


// ArrayListOfInt
procedure ArrayListOfInt.put(i, index: integer);
begin
    inherited put(TInt(i));
end;


// ArrayListOfInt
function ArrayListOfInt.remove(index: integer): integer;
begin
    remove := (inherited remove(index) as _Int).num;
end;


// ArrayListOfInt
function ArrayListOfInt.get(index: integer): integer;
begin
    get := (inherited get(index) as _Int).num;
end;


// ArrayListOfInt
function ArrayListOfInt.find(i: integer): integer;
var j: integer;

begin
    find := -1;

    for j := 0 to len - 1 do
        if i = get(j) then begin
            find := j;
            break;
        end;
end;


end.
