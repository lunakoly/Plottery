unit uLayer;

interface

uses uPoint, uLine, uMaths, uArrayListOfPoint, uArrayListOfLine, uUtils;

const MAX_POINTS = 300;
const MAX_LINES  = 300;


{
    For serialization
}
type layerRecord = record
    name: String[255];
    points: PointRecordList;
    lines: LineRecordList;
    currentPoint, currentLine: integer;
end;
type LayerRecordList = Array of LayerRecord;


{
    Provides containers for containers of points
}
type Layer = class(TObject)
    name: String[255];
    points: ArrayListOfPoint;
    currentPoint: integer;

    lines: ArrayListOfLine;
    currentLine: integer;

    constructor Create(name: String);
    function hasCurrentPoint(): boolean;
    function getCurrentPoint(): Point;
    procedure setCurrentPoint(p: Point);

    function selectPrevPoint(): boolean;
    function selectNextPoint(): boolean;
    function addPoint(p: Point): boolean;
    function removePoint(i: integer): boolean;

    procedure addRandomPoints(n: integer; minX, maxX, minY, maxY: real);
    procedure translatePoints(b, e: integer; dx, dy: real);
    procedure cutPoints(b, e: integer);

    function hasCurrentLine(): boolean;
    function getCurrentLine(): Line;
    procedure setCurrentLine(l: Line);

    function selectPrevLine(): boolean;
    function selectNextLine(): boolean;
    function addLine(l: Line): boolean;
    function removeLine(i: integer): boolean;

    procedure cutLines(b, e: integer);
    procedure updateLines();
end;
type LayerList = Array of Layer;


{
    Draws poligon
}
procedure poligon(p: PointList; l: Layer);
function lyToClass(r: layerRecord): Layer;
function lyToRecord(l: Layer): LayerRecord;


implementation


// Layer
constructor Layer.Create(name: String);
begin
    self.name := name;

    points := ArrayListOfPoint.Create(50);
    currentPoint := -1;

    lines := ArrayListOfLine.Create(50);
    currentLine := -1;
end;


// Layer
function Layer.hasCurrentPoint(): boolean;
begin
    hasCurrentPoint := currentPoint <> -1;
end;


// Layer
function Layer.getCurrentPoint(): Point;
begin
    getCurrentPoint := points.get(currentPoint);
end;


// Layer
procedure Layer.setCurrentPoint(p: Point);
begin
    points.put(p, currentPoint);
end;


// Layer
function Layer.selectPrevPoint(): boolean;
begin
    selectPrevPoint := false;

    if currentPoint > 0 then begin
        dec(currentPoint, 1);
        selectPrevPoint := true;       // success
    end;
end;


// Layer
function Layer.selectNextPoint(): boolean;
begin
    selectNextPoint := false;

    if currentPoint < points.size() - 1 then begin
        inc(currentPoint, 1);
        selectNextPoint := true;       // success
    end;
end;


// Layer
function Layer.addPoint(p: Point): boolean;
begin
    addPoint := false;

    if points.size() < MAX_POINTS then begin
        currentPoint := points.size();
        points.add(p);
        addPoint := true;       // success
    end;
end;


// Layer
procedure Layer.addRandomPoints(n: integer; minX, maxX, minY, maxY: real);
var
    i, rest, req: integer;

begin
    rest := MAX_POINTS - points.size();
    req := n;

    if (req > rest) then
        req := rest;

    for i := 1 to req do
        addPoint(getRandPoint(minX, maxX, minY, maxY));
end;


// Layer
function Layer.removePoint(i: integer): boolean;
var j: integer;

begin
    removePoint := false;

    if (i > -1) and (i < points.size()) then
        if (points.get(i) <> nil) then begin
            points.remove(i);

            if currentPoint = points.size() then
                dec(currentPoint, 1);

            updateLines();
            removePoint := true;
        end;
end;


// Layer
procedure Layer.cutPoints(b, e: integer);
var
    i: integer;

begin
    if b < 0 then
        b := 0;

    if b > points.size() - 1 then
        b := points.size() - 1;

    if e < 0 then
        e := 0;

    if e > points.size() - 1 then
        e := points.size() - 1;

    if b >= 0 then
        for i := b to e do
            removePoint(b);
end;


// Layer
procedure Layer.translatePoints(b, e: integer; dx, dy: real);
var
    i: integer;

begin
    if b < 0 then
        b := 0;

    if b > points.size() - 1 then
        b := points.size() - 1;

    if e < 0 then
        e := 0;

    if e > points.size() - 1 then
        e := points.size() - 1;

    if b >= 0 then
        for i := b to e do begin
            points.get(i).x := points.get(i).x + dx;
            points.get(i).y := points.get(i).y + dy;
        end;
end;


// Layer
function Layer.hasCurrentLine(): boolean;
begin
    hasCurrentLine := currentLine <> -1;
end;


// Layer
function Layer.getCurrentLine(): Line;
begin
    getCurrentLine := lines.get(currentLine);
end;


// Layer
procedure Layer.setCurrentLine(l: Line);
begin
    lines.put(l, currentLine);
end;


// Layer
function Layer.selectPrevLine(): boolean;
begin
    selectPrevLine := false;

    if currentLine > 0 then begin
        dec(currentLine, 1);
        selectPrevLine := true;       // success
    end;
end;


// Layer
function Layer.selectNextLine(): boolean;
begin
    selectNextLine := false;

    if currentLine < lines.size() - 1 then begin
        inc(currentLine, 1);
        selectNextLine := true;       // success
    end;
end;


// Layer
function Layer.addLine(l: Line): boolean;
begin
    addLine := false;

    if lines.size() < MAX_LINES then begin
        currentLine := lines.size();
        lines.add(l);
        addLine := true;       // success
    end;
end;


// Layer
function Layer.removeLine(i: integer): boolean;
var j: integer;

begin
    removeLine := false;

    if (i > -1) and (i < lines.size()) then
        if (lines.get(i) <> nil) then begin
            lines.remove(i);

            if currentLine = lines.size() then
                dec(currentLine, 1);
            removeLine := true;
        end;
end;


// Layer
procedure Layer.cutLines(b, e: integer);
var
    i: integer;

begin
    if b < 0 then
        b := 0;

    if b > lines.size() - 1 then
        b := lines.size() - 1;

    if e < 0 then
        e := 0;

    if e > lines.size() - 1 then
        e := lines.size() - 1;

    if b >= 0 then
        for i := b to e do
            removeLine(b);
end;


// Layer
procedure Layer.updateLines();
var i: integer;

begin
    i := 0;

    while i < lines.size() do begin
        if (points.get(lines.get(i).p1) = nil) or (points.get(lines.get(i).p2) = nil) then
            removeLine(i)
        else
            i := i + 1;
    end;
end;


procedure poligon(p: PointList; l: Layer);
var
    i, c: integer;

begin
    c := 0;

    for i := 0 to length(p) - 1 do begin
        l.addPoint(p[i]);

        if i > 0 then
            l.addLine(Line.Create(l.currentPoint - 1, l.currentPoint))
        else
            c := l.currentPoint;
    end;

    if length(p) > 1 then
        l.addLine(Line.Create(c, l.currentPoint));
end;


function lyToClass(r: layerRecord): Layer;
var
    i: integer;
    l: Layer;

begin
    l := Layer.Create(r.name);

    for i := 0 to length(r.points) - 1 do
        l.addPoint(Point.Create(r.points[i].x, r.points[i].y));

    for i := 0 to length(r.lines) - 1 do
        l.addLine(Line.Create(r.lines[i].p1, r.lines[i].p2));

    l.currentPoint := r.currentPoint;
    l.currentLine  := r.currentLine;
    l.name := r.name;
    lyToClass := l;
end;


function lyToRecord(l: Layer): LayerRecord;
var
    i: integer;
    r: LayerRecord;

begin
    SetLength(r.points, l.points.size());
    for i := 0 to l.points.size() - 1 do begin
        r.points[i].x := l.points.get(i).x;
        r.points[i].y := l.points.get(i).y;
    end;

    SetLength(r.lines, l.lines.size());
    for i := 0 to l.lines.size() - 1 do begin
        r.lines[i].p1 := l.lines.get(i).p1;
        r.lines[i].p2 := l.lines.get(i).p2;
    end;

    r.currentPoint := l.currentPoint;
    r.currentLine  := l.currentLine;
    r.name := l.name;
    lyToRecord := r;
end;


end.
