unit uStringMapOfString;

interface

uses uStringMap, uArrayListOfString;

{
    Automatic dynamic str map that contains strs
}
type StringMapOfString = class(StringMap)
    public
        constructor Create(); override;

        procedure add(key, value: String); overload;
        function remove(key: String): String; overload;
        function get(key: String): String; overload;

        function getValues(): ArrayListOfString; overload;
end;


implementation


// StringMapOfString
constructor StringMapOfString.Create();
begin
    keys := ArrayListOfString.Create();
    vals := ArrayListOfString.Create();
end;


// StringMapOfString
procedure StringMapOfString.add(key, value: String);
begin
    (keys as ArrayListOfString).add(key);
    (vals as ArrayListOfString).add(value);
end;


// StringMapOfString
function StringMapOfString.remove(key: String): String;
var
    index: integer;

begin
    remove := '';
    index := find(key);

    if index > -1 then begin
        keys.remove(index);
        remove := (vals as ArrayListOfString).remove(index);
    end;
end;


// StringMapOfString
function StringMapOfString.get(key: String): String;
var index: integer;

begin
    get := '';
    index := find(key);

    if index > -1 then
        get := (vals as ArrayListOfString).get(index);
end;


// StringMapOfString
function StringMapOfString.getValues(): ArrayListOfString;
begin
    getValues := (vals as ArrayListOfString);
end;


end.
