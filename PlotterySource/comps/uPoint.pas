unit uPoint;

interface


{
    For serialization
}
type PointRecord = record
    x, y: real;
end;
type PointRecordList = Array of PointRecord;


{
    Provides containers for points
}
type Point = class(TObject)
    x, y: real;

    constructor Create(x, y: real);
end;
type PointList = Array of Point;


function pToClass(r: PointRecord): Point;
function pToRecord(p: Point): PointRecord;
function pCopy(p: Point): Point;


implementation


// Point
constructor Point.Create(x, y: real);
begin
    self.x := x;
    self.y := y;
end;


function pToRecord(p: Point): PointRecord;
var r: PointRecord;

begin
    r.x := p.x;
    r.y := p.y;
    pToRecord := r;
end;



function pToClass(r: PointRecord): Point;
begin
    pToClass := Point.Create(r.x, r.y);
end;


function pCopy(p: Point): Point;
begin
    pCopy := Point.Create(p.x, p.y);
end;


end.