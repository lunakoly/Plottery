unit uArrayList;

interface

type List = Array of TObject;


{
    Automatic dynamic array
}
type ArrayList = class
    protected
        arr: List;
        len: integer;

    public
        constructor Create(); overload;
        constructor Create(amount: integer); overload;

        function enlargeBy(arr: List; amount: integer): List;
        function enlarge(arr: List): List;

        procedure add(obj: TObject);
        procedure put(obj: TObject; index: integer);
        function remove(index: integer): TObject; overload;
        procedure remove(obj: TObject); overload;
        function size(): integer;
        function get(index: integer): TObject;

        function find(obj: TObject): integer;
end;


implementation


// ArrayList
constructor ArrayList.Create(amount: integer);
begin
    SetLength(arr, amount);
    len := 0;
end;


// ArrayList
constructor ArrayList.Create();
begin
    Create(10);
end;


// ArrayList
function ArrayList.enlargeBy(arr: List; amount: integer): List;
var
    sub: List;
    i, len: integer;

begin
    len := Length(arr) + amount;
    SetLength(sub, len);

    for i := 0 to len - 1 do
        sub[i] := arr[i];

    enlargeBy := sub;
end;


// ArrayList
function ArrayList.enlarge(arr: List): List;
begin
    enlarge := enlargeBy(arr, Length(arr) + 1);
end;


// ArrayList
procedure ArrayList.add(obj: TObject);
begin
    if len >= length(arr) then
        arr := enlarge(arr);

    arr[len] := obj;
    len := len + 1;
end;


// ArrayList
procedure ArrayList.put(obj: TObject; index: integer);
begin
    arr[index] := obj;
end;


// ArrayList
function ArrayList.remove(index: integer): TObject;
var i: integer;

begin
    remove := nil;

    if arr[index] <> nil then begin
        remove := arr[index];

        for i := index + 1 to len - 1 do begin
            arr[i - 1] := arr[i];
        end;

        arr[len - 1] := nil;

        len := len - 1;
    end;
end;


// ArrayList
procedure ArrayList.remove(obj: TObject);
var i: integer;

begin
    for i := 0 to len - 1 do begin
        if arr[i] = obj then begin
            remove(i);
            break;
        end;
    end;
end;


// ArrayList
function ArrayList.size(): integer;
begin
    size := len;
end;


// ArrayList
function ArrayList.get(index: integer): TObject;
begin
    get := arr[index];
end;


// ArrayList
function ArrayList.find(obj: TObject): integer;
var i: integer;

begin
    find := -1;

    for i := 0 to len - 1 do
        if obj = get(i) then begin
            find := i;
            break;
        end;
end;


end.
