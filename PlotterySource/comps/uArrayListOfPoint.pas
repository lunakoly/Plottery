unit uArrayListOfPoint;

interface

uses uArrayList, uPoint;


{
    Automatic dynamic points array
}
type ArrayListOfPoint = class(ArrayList)
    public
        procedure add(p: Point); overload;
        procedure put(p: Point; index: integer); overload;
        function remove(index: integer): Point; overload;
        procedure remove(p: Point); overload;
        function get(index: integer): Point; overload;

        function find(p: Point): integer; overload;
end;


implementation


// ArrayListOfPoint
procedure ArrayListOfPoint.add(p: Point);
begin
    inherited add(p);
end;


// ArrayListOfPoint
procedure ArrayListOfPoint.put(p: Point; index: integer);
begin
    inherited put(p, index);
end;


// ArrayListOfPoint
function ArrayListOfPoint.remove(index: integer): Point;
begin
    remove := inherited remove(index) as Point;
end;


// ArrayListOfPoint
procedure ArrayListOfPoint.remove(p: Point);
var i: integer;

begin
    for i := 0 to size() - 1 do begin
        if (arr[i] as Point) = p then begin
            remove(i);
            break;
        end;
    end;
end;


// ArrayListOfPoint
function ArrayListOfPoint.get(index: integer): Point;
begin
    get := inherited get(index) as Point;
end;


// ArrayListOfPoint
function ArrayListOfPoint.find(p: Point): integer;
var i: integer;

begin
    find := -1;

    for i := 0 to len - 1 do
        if p = get(i) then begin
            find := i;
            break;
        end;
end;


end.
