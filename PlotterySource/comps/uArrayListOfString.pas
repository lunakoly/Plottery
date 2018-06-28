unit uArrayListOfString;

interface

uses uArrayList;


{
    Stores strs
}
type _Str = class(TObject)
    public
        str: String;
end;

function TStr(str: String): _Str;


{
    Automatic dynamic string array
}
type ArrayListOfString = class(ArrayList)
    public
        procedure add(str: String); overload;
        procedure put(str: String; index: integer); overload;
        function remove(index: integer): String; overload;
        procedure remove(str: String); overload;
        function get(index: integer): String; overload;

        function find(str: String): integer; overload;
end;


implementation


// _Str
function TStr(str: String): _Str;
begin
    TStr :=_Str.Create();
    TStr.str := str;
end;


// ArrayListOfString
procedure ArrayListOfString.add(str: String);
begin
    inherited add(TStr(str));
end;


// ArrayListOfString
procedure ArrayListOfString.put(str: String; index: integer);
begin
    inherited put(TStr(str), index);
end;


// ArrayListOfString
function ArrayListOfString.remove(index: integer): String;
begin
    remove := (inherited remove(index) as _Str).str;
end;


// ArrayListOfString
procedure ArrayListOfString.remove(str: String);
var i: integer;

begin
    for i := 0 to size() - 1 do begin
        if (arr[i] as _Str).str = str then begin
            remove(i);
            break;
        end;
    end;
end;


// ArrayListOfString
function ArrayListOfString.get(index: integer): String;
begin
    get := (inherited get(index) as _Str).str;
end;


// ArrayListOfString
function ArrayListOfString.find(str: String): integer;
var i: integer;

begin
    find := -1;

    for i := 0 to len - 1 do
        if str = get(i) then begin
            find := i;
            break;
        end;
end;


end.
