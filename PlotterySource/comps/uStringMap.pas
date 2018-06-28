unit uStringMap;

interface

uses uMap, uArrayListOfString, uArrayList;


{
    Automatic dynamic str map
}
type StringMap = class(Map)
    public
        constructor Create(); override;

        function find(key: String): integer; overload;

        procedure add(key: String; value: TObject); overload;
        function remove(key: String): TObject; overload;
        function get(key: String): TObject; overload;

        function getKeys(): ArrayListOfString; overload;
end;


implementation


// StringMap
constructor StringMap.Create();
begin
    keys := ArrayListOfString.Create();
    vals := ArrayList.Create();
end;


// StringMap
function StringMap.find(key: String): integer;
var i: integer;

begin
    find := -1;

    for i := 0 to keys.size() - 1 do
        if key = (keys as ArrayListOfString).get(i) then begin
            find := i;
            break;
        end;
end;


// StringMap
procedure StringMap.add(key: String; value: TObject);
begin
    (keys as ArrayListOfString).add(key);
    vals.add(value);
end;


// StringMap
function StringMap.remove(key: String): TObject;
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


// StringMap
function StringMap.get(key: String): TObject;
var index: integer;

begin
    get := nil;
    index := find(key);

    if index > -1 then
        get := vals.get(index);
end;


// StringMap
function StringMap.getKeys(): ArrayListOfString;
begin
    getKeys := (keys as ArrayListOfString);
end;


end.
