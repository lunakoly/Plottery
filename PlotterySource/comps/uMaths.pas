unit uMaths;

interface

uses uPoint;


{
    Returns random num of [min;max)
}
function getRand(min, max: real): real;
{
    Returns random num of range
}
function getRandPoint(minX, maxX, minY, maxY: real): Point;
{
    Returns angle between line specified by 2 points and OX
}
function getAngleOf2P(x1, y1, x2, y2: real): real;


implementation


function getRand(min, max: real): real;
begin
    getRand := random * (max - min) + min;
end;


function getRandPoint(minX, maxX, minY, maxY: real): Point;
var p: Point;

begin
    p := Point.Create(getRand(minX, maxX), getRand(minY, maxY));
    p.x := trunc(p.x * 100) / 100.0;
    p.y := trunc(p.y * 100) / 100.0;

    getRandPoint := p;
end;


function getAngleOf2P(x1, y1, x2, y2: real): real;
var
    dx, dy, angle, corrector: real;

begin
    dx := x2 - x1;
    dy := y2 - y1;
    angle     := 0;
    corrector := 0;

    if dx = 0 then
        begin if dy <> 0 then corrector := PI / 2; end
    else angle := arctan(dy / dx);

    if dx < 0 then corrector := PI;
    if dy < 0 then corrector := 2 * PI - corrector;

    getAngleOf2P := angle + corrector;
end;


begin
    randomize;
end.
