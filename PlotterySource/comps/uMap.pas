unit uMap;

interface

uses uArrayList;


{
    Automatic dynamic map
}
type Map = class
    protected
        vals: ArrayList;
        keys: ArrayList;

    public
        constructor Create(); virtual;

        function find(key: TObject): integer;

        procedure add(key, value: TObject);
        function remove(key: TObject): TObject;
        function size(): integer;
        function get(key: TObject): TObject;

        function getKeys(): ArrayList;
        function getValues(): ArrayList;
end;



implementation


// Map
constructor Map.Create();
begin
    keys := ArrayList.Create();
    vals := ArrayList.Create();
end;


// Map
procedure Map.add(key, value: TObject);
begin
    keys.add(key);
    vals.add(value);
end;


// Map
function Map.find(key: TObject): integer;
var i: integer;

begin
    find := -1;

    for i := 0 to keys.size() - 1 do
        if key = keys.get(i) then begin
            find := i;
            break;
        end;
end;


// Map
function Map.remove(key: TObject): TObject;
var
    index: integer;

begin
    remove := nil;
    index := find(key);

    if index > -1 then begin
        keys.remove(index);
        remove := vals.remove(index);
    end;
end;


// Map
function Map.size(): integer;
begin
    size := keys.size();
end;


// Map
function Map.get(key: TObject): TObject;
var index: integer;

begin
    get := nil;
    index := find(key);

    if index > -1 then
        get := vals.get(index);
end;


// Map
function Map.getKeys(): ArrayList;
begin
    getKeys := keys;
end;


// Map
function Map.getValues(): ArrayList;
begin
    getValues := vals;
end;


end.
