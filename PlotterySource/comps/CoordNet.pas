unit CoordNet;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, uColorTheme, uMaths, uPoint, uLine, uLayer, uScene, uParser, Math, uUtils;


const CN_DEFAULT_GRID_SIZE = 40;
const CN_POINT_RAD = 5;


type PointMoveEvent = procedure(Sender: TObject) of object;


{
    Coord Net
}
type TCoordNet = class(TImage, IUnknown, IThemeSupporter)
    private
        theme: ColorTheme;
        // zoom - global zoom as 2^n
        // incr - increments numbers
        zoom, incr: real;
        // size of one cell
        cell: integer;

        // about positions
        center, translate, saved, mousePos, mouseBorder: TPoint;
        isMoving, isPointMoving,
        DoShowCursorCoord, DoTrackCursor: boolean;

        CN_MAX_ZOOM, CN_MIN_ZOOM,
        CN_MAX_TRANSLATION_X, CN_MAX_TRANSLATION_Y: real;

        pointMoveHandle: PointMoveEvent;

        // Crutch
        userValidateStateTrigger: boolean;


        procedure drawNet();
        procedure drawCursor();
        procedure drawContent();
        procedure drawLayer(l: Layer);
        procedure drawPoint(p: Point; isSelected: boolean);
        procedure drawContentLine(l: Line; context: Layer);
        procedure drawLine(x1, y1, x2, y2: integer);
        function mouseInBounds(): boolean;

        function findMouseCurrentPoint(sub: real; x, y: integer): boolean;
        procedure noShiftLMB(sub: real; x, y: integer);
        procedure noShiftMMB(sub: real; x, y: integer);

        // Crutch
        procedure userValidateStateWrite(b: boolean);

    protected
        procedure Loaded(); override;
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    public
        theScene: Scene;

        constructor Create(AOwner: TComponent); override;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();

        {
            Takes mouse Position and returns point if actual grid
        }
        function toInnerCoord(x, y: integer): Point;
        procedure setScale(scale: real);
        function getScale(): real;

        procedure setMinScale(scale: real);
        procedure setMaxScale(scale: real);
        function getMinScale(): real;
        function getMaxScale(): real;

        procedure setTranslationX(t: real);
        procedure setTranslationY(t: real);
        function getTranslationX(): real;
        function getTranslationY(): real;

        procedure setMaxTranslationX(t: real);
        procedure setMaxTranslationY(t: real);
        function getMaxTranslationX(): real;
        function getMaxTranslationY(): real;

    published
        property Scale: real read getScale write setScale;
        property TranslationX: real read getTranslationX write setTranslationX;
        property TranslationY: real read getTranslationY write setTranslationY;
        property MouseX: integer read mousePos.x write mousePos.x;
        property MouseY: integer read mousePos.y write mousePos.y;
        property ShowCursorCoord: boolean read DoShowCursorCoord write DoShowCursorCoord;
        property TrackCursor: boolean read DoTrackCursor write DoTrackCursor;
        property OnPointMove: PointMoveEvent read pointMoveHandle write pointMoveHandle;
        property __UpdateState: boolean read userValidateStateTrigger write userValidateStateWrite;

end;

procedure Register;

implementation


procedure Register;
begin
    RegisterComponents('Lite', [TCoordNet]);
end;


// event
procedure TCoordNet.noShiftLMB(sub: real; x, y: integer);
begin
    // enter translation mode
    isMoving := true;

    mouseBorder.x := round(CN_MAX_TRANSLATION_X * sub);
    mouseBorder.y := round(CN_MAX_TRANSLATION_Y * sub);

    // save old x and y with the old tarslation
    saved.X := translate.X - x;
    saved.Y := translate.Y - y;
end;


// event
procedure TCoordNet.noShiftMMB(sub: real; x, y: integer);
var
    c: integer;

begin
    c := theScene.getCurrentLayer().currentPoint;

        if findMouseCurrentPoint(sub, x, y) then
            if c <> theScene.getCurrentLayer().currentPoint then begin
                theScene.getCurrentLayer().addLine(Line.Create(
                    theScene.getCurrentLayer().currentPoint,
                    c
                ));
                theScene.getCurrentLayer().currentPoint := c;
            end;
end;


// events
procedure TCoordNet.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    sub: real;
    c: integer;

begin
    sub := cell / incr;

    if not (ssShift in Shift) then begin
        if Button = mbLeft then begin
            noShiftLMB(sub, x, y);
        end else if Button = mbRight then begin
            theScene.getCurrentLayer().addPoint(toInnerCoord(x, y));
        end else begin
            noShiftMMB(sub, x, y);
        end;

    end else begin
        if Button = mbLeft then begin
            if findMouseCurrentPoint(sub, x, y) then begin
                isPointMoving := true;
            end;
        end else if Button = mbRight then begin
            if findMouseCurrentPoint(sub, x, y) then
                theScene.getCurrentLayer().removePoint(theScene.getCurrentLayer().currentPoint);
        end;
    end;

    inherited MouseDown(Button, Shift, x, y);
end;


function TCoordNet.findMouseCurrentPoint(sub: real; x, y: integer): boolean;
var
    i, j: integer;
    p: Point;
    b: boolean;

begin
    b := false;

    // for all layers
    for i := theScene.layers.size() - 1 downto 0 do begin
        // for all points
        for j := theScene.layers.get(i).points.size() - 1 downto 0 do begin
            p := theScene.layers.get(i).points.get(j);

            saved.X := round(p.x * sub - x);      // coord * sub = to pixel coord
            saved.Y := round(-p.y * sub - y);     // get rid of old x and y according to point position
                                                  // ill put there + new x and y
                                                  // but i need sub to make point and mouse compatible
            // if in radius
            if (abs(saved.x + center.x + translate.x) < CN_POINT_RAD) and
               (abs(saved.y + center.y + translate.y) < CN_POINT_RAD) then begin

                // save
                theScene.currentLayer := i;
                theScene.layers.get(i).currentPoint := j;
                b := true;

                // exit
                break;
            end;
        end;

        if b then
            break;
    end;

    findMouseCurrentPoint := b;
end;


// events
procedure TCoordNet.MouseMove(Shift: TShiftState; X, Y: Integer);
var dx, dy: integer;

begin
    inherited MouseMove(Shift, x, y);

    if isMoving then begin
        // restore old translation with new x and y
        dx := saved.X + x;
        dy := saved.Y + y;

        // prevent too big translation
        if dx > mouseBorder.x then
            dx := mouseBorder.x
        else if dx < -mouseBorder.x then
            dx := -mouseBorder.x;

        if dy > mouseBorder.y then
            dy := mouseBorder.y
        else if dy < -mouseBorder.y then
            dy := -mouseBorder.y;

        translate.X := dx;          // apply
        translate.Y := dy;
    end else if isPointMoving then begin
        dx := saved.X + x;
        dy := saved.Y + y;

        theScene.getCurrentLayer().getCurrentPoint().x := dx / cell * incr;
        theScene.getCurrentLayer().getCurrentPoint().y := -dy / cell * incr;

        if Assigned(pointMoveHandle) then
            pointMoveHandle(self);
    end;

    mousePos.X := x;
    mousePos.Y := y;
    updateColors();
end;


// events
procedure TCoordNet.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    inherited MouseUp(Button, Shift, x, y);
    isMoving := false;
    isPointMoving := false;
end;


// Override
constructor TCoordNet.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);

    CN_MAX_ZOOM := 140737488355328;
    CN_MIN_ZOOM := 0.0001220703125;
    CN_MAX_TRANSLATION_X := 120;
    CN_MAX_TRANSLATION_Y := 120;

    zoom := 1.0;
    incr := 1.0;
    cell := CN_DEFAULT_GRID_SIZE;
    Width := 360;
    Height := 360;
    isMoving := false;
    translate.x := 0;
    translate.y := 0;
    mousePos.x := Width - Width div 4;
    mousePos.y := Height div 4;

    DoShowCursorCoord := true;
    DoTrackCursor := true;

    theScene := Scene.Create();

    theme := CT_DEFAULT_THEME;
    updateColors();
end;


// Override
procedure TCoordNet.Loaded();
begin
    updateColors();
end;


// Override
procedure TCoordNet.setTheme(theme: ColorTheme);
begin
    self.theme := theme;    // link
end;


// Override
function TCoordNet.getTheme(): ColorTheme;
begin
    getTheme := theme;
end;


// Override
procedure TCoordNet.updateColors();
begin
    drawNet();
    drawContent();
    drawCursor();
end;


procedure TCoordNet.setMinScale(scale: real);
begin
    if scale > 0 then
        CN_MIN_ZOOM := scale;
end;


procedure TCoordNet.setMaxScale(scale: real);
begin
    CN_MAX_ZOOM := scale;
end;


function TCoordNet.getMinScale(): real;
begin
    getMinScale := CN_MIN_ZOOM;
end;


function TCoordNet.getMaxScale(): real;
begin
    getMaxScale := CN_MAX_ZOOM;
end;


procedure TCoordNet.userValidateStateWrite(b: boolean);
begin
    updateColors();
end;


procedure TCoordNet.drawLine(x1, y1, x2, y2: integer);
begin
    Canvas.moveTo(x1, y1);
    Canvas.lineTo(x2, y2);
end;


function TCoordNet.mouseInBounds(): boolean;
begin
    if (mousePos.X <= 10) or
       (mousePos.X >= Width - 10) or
       (mousePos.Y <= 10) or
       (mousePos.Y >= Height - 10) then
       mouseInBounds := false
    else
        mouseInBounds := true;

end;


function TCoordNet.toInnerCoord(x, y: integer): Point;
var sub: real;

begin
    sub := cell / incr;
    toInnerCoord := Point.Create(           // coord - (center + translate) = mouse coord according to grid center
        (x - center.X - translate.X) / sub, // /cell = get current step of changing numbers
        -(y - center.Y - translate.Y) / sub // *incr = get current number according to zoom
    );
end;


procedure TCoordNet.setScale(scale: real);
var tx, ty: real;

begin
    if scale > CN_MAX_ZOOM then scale := CN_MAX_ZOOM
    else if scale < CN_MIN_ZOOM then scale := CN_MIN_ZOOM;

    // save translation
    tx := translate.X * zoom;         // if i dont do this then zoom will be changed according to global center
    ty := translate.Y * zoom;         // but not to the point im looking at
    zoom := scale;                    // translation - pixel value, so it depends on zoom
    translate.X := round(tx / zoom);
    translate.Y := round(ty / zoom);
end;


function TCoordNet.getScale(): real;
begin
    getScale := zoom;
end;


{
    This func cuts n of N to k of [minstep; maxstep]
    if x is 4 -> we got zoom of 4 (2^4)
    returns 1; just like if x is 1 -> returns 1
    for x  -7 -6 -5 -4 -3 -2 -1 0 1 2  3  4 5 6  7
    got     1  2 -1  0  1  2 -1 0 1 2 -1  0 1 2 -1
}
function getGridIncrementor(x: real): real;
begin
    if x >= 0 then
        getGridIncrementor := x - round(x + 1) div 4 * 4
    else
        getGridIncrementor := x - round(x - 2) div 4 * 4;
end;


function getNumIncrementor(z: real): real;
var
    l: real;
    st: integer;

begin
    l := Log2(1 / z);          // get zoom state

    if l >= 0 then             //
        st := round(Log2(1 / z) + 1) div 4  // we increment numbers only if after we changed big incrementation step
    else                                    // so we do div 4
        st := round(Log2(1 / z) - 2) div 4;

    getNumIncrementor := 1 / power(2, st);
end;


procedure TCoordNet.drawNet();
var
    sub, subCenterX, subCenterY, i: integer;

begin
    // resize validation
    Picture.Bitmap.Width := Width;
    Picture.Bitmap.Height := Height;

    // grid nums incrementions
    incr := getNumIncrementor(zoom);

    // grid states!
    // i grab the state of zoom via log2(1/zoom)
    // i use the grid incrementer to get a value of step
    cell := round(CN_DEFAULT_GRID_SIZE + 10 * getGridIncrementor(Log2(1 / zoom)));

    Canvas.Brush.Color := theme.coordBG;
    center.X := Width div 2;
    center.Y := Height div 2;

    Canvas.FillRect(Rect(0, 0, Width, Height));

    // grid
    Canvas.Pen.Color := theme.coordGrid;
    Canvas.Pen.Width := 1;
    // text
    Canvas.Font.Color := theme.coordText;

    // center
    subCenterY := center.Y + translate.Y;
    subCenterX := center.X + translate.X;

    // ->
    i := center.X + translate.X mod cell;
    sub := -translate.X div cell;
    while i < Width do begin
        drawLine(i, 0, i, Height);
        Canvas.TextOut(i + 3, subCenterY - 15, getNum2(sub * incr));
        sub := sub + 1;
        i := i + cell;
    end;

    // <-
    i := center.X + translate.X mod cell;
    sub := -translate.X div cell;
    while i >= 0 do begin
        drawLine(i, 0, i, Height);
        Canvas.TextOut(i + 3, subCenterY - 15, getNum2(sub * incr));
        sub := sub - 1;
        i := i - cell;
    end;

    // down
    i := center.Y + translate.Y mod cell;
    sub := translate.Y div cell;
    while i < Height do begin
        drawLine(0, i, Width, i);
        Canvas.TextOut(subCenterX + 3, i - 15, getNum2(sub * incr));
        sub := sub - 1;
        i := i + cell;
    end;

    // Up
    i := center.Y + translate.Y mod cell;
    sub := translate.Y div cell;
    while i >= 0 do begin
        drawLine(0, i, Width, i);
        Canvas.TextOut(subCenterX + 3, i - 15, getNum2(sub * incr));
        sub := sub + 1;
        i := i - cell;
    end;

    // main
    Canvas.Pen.Color := theme.coordAxis;
    Canvas.Pen.Width := 2;

    drawLine(0, subCenterY, Width, subCenterY);
    drawLine(subCenterX, 0, subCenterX, Height);

    // arrows
    Canvas.Pen.Width := 3;

    drawLine(Width - 1, subCenterY, Width - 7, subCenterY - 5);
    drawLine(Width - 1, subCenterY, Width - 7, subCenterY + 5);

    drawLine(subCenterX, 0, subCenterX - 6, 7);
    drawLine(subCenterX, 0, subCenterX + 6, 7);
end;


procedure TCoordNet.drawCursor();
var mouse: Point;

begin
    if mouseInBounds() then begin
        Canvas.Brush.Color := theme.coordBG;
        Canvas.Pen.Color := theme.active;
        Canvas.Pen.Width := 1;

        if DoTrackCursor then begin
            drawLine(0, mousePos.Y, Width, mousePos.Y);
            drawLine(mousePos.X, 0, mousePos.X, Height);
        end;

        if DoShowCursorCoord then begin
            mouse := toInnerCoord(mousePos.X, mousePos.Y);
            Canvas.TextOut(mousePos.X + 3, mousePos.Y - 15,
                '(' + getNumR(mouse.x) + ',' + getNumR(mouse.y) + ')');
        end;
    end;
end;


procedure TCoordNet.setTranslationX(t: real);
begin
    if t > CN_MAX_TRANSLATION_X then t := CN_MAX_TRANSLATION_X
    else if t < -CN_MAX_TRANSLATION_X then t := -CN_MAX_TRANSLATION_X;

    translate.X := -round(t * CN_DEFAULT_GRID_SIZE * zoom);
end;


procedure TCoordNet.setTranslationY(t: real);
begin
    if t > CN_MAX_TRANSLATION_Y then t := CN_MAX_TRANSLATION_Y
    else if t < -CN_MAX_TRANSLATION_Y then t := -CN_MAX_TRANSLATION_Y;

    translate.Y := round(t * CN_DEFAULT_GRID_SIZE * zoom);
end;


function TCoordNet.getTranslationX(): real;
begin
    getTranslationX := -translate.X / CN_DEFAULT_GRID_SIZE / zoom;
end;


function TCoordNet.getTranslationY(): real;
begin
    getTranslationY := translate.Y / CN_DEFAULT_GRID_SIZE / zoom;
end;


procedure TCoordNet.setMaxTranslationX(t: real);
begin
    CN_MAX_TRANSLATION_X := t;
end;


procedure TCoordNet.setMaxTranslationY(t: real);
begin
    CN_MAX_TRANSLATION_Y := t;
end;


function TCoordNet.getMaxTranslationX(): real;
begin
    getMaxTranslationX := CN_MAX_TRANSLATION_X;
end;


function TCoordNet.getMaxTranslationY(): real;
begin
    getMaxTranslationY := CN_MAX_TRANSLATION_Y;
end;


procedure TCoordNet.drawPoint(p: Point; isSelected: boolean);
var sub: real;

begin
    sub := cell / incr;

    if isSelected then
        Canvas.Brush.Color := theme.active
    else
        Canvas.Brush.Color := theme.coordPoint;

    Canvas.Ellipse(
        round(center.X + translate.x + p.x * sub - CN_POINT_RAD),
        round(center.y + translate.y - p.y * sub - CN_POINT_RAD),
        round(center.X + translate.x + p.x * sub + CN_POINT_RAD),
        round(center.y + translate.y - p.y * sub + CN_POINT_RAD));
end;


procedure TCoordNet.drawContentLine(l: Line; context: Layer);
var sub: real;

begin
    sub := cell / incr;

    Canvas.moveTo(
        round(center.X + translate.x + context.points.get(l.p1).x * sub),
        round(center.y + translate.y - context.points.get(l.p1).y * sub));

    Canvas.lineTo(
        round(center.X + translate.x + context.points.get(l.p2).x * sub),
        round(center.y + translate.y - context.points.get(l.p2).y * sub));
end;


procedure TCoordNet.drawLayer(l: Layer);
var i: integer;

begin
    Canvas.Pen.Color := theme.coordLine;
    Canvas.Pen.Width := 2;

    for i := 0 to l.lines.size() - 1 do
        drawContentLine(l.lines.get(i), l);

    Canvas.Brush.Color := theme.coordPoint;
    Canvas.Pen.Color := theme.coordOutline;
    Canvas.Pen.Width := 1;

    for i := 0 to l.points.size() - 1 do
        drawPoint(l.points.get(i), (i = l.currentPoint) and (l = theScene.getCurrentLayer()));
end;


procedure TCoordNet.drawContent();
var i: integer;

begin
    for i := 0 to theScene.layers.size() - 1 do
        drawLayer(theScene.layers.get(i));
end;


end.
