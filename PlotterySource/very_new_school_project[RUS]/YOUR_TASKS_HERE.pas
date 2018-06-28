//      Create your own task here
//      use type 'Task' to define a procedure
//      then add it at 'initialization' via
//           TMInstance.add('Your name', yourTaskProcedureName);
//

unit YOUR_TASKS_HERE;
interface
procedure initTasks();
implementation
uses uTasks, uPoint, uLine, Unit2, uMaths, Math, uUtils, uParser;


// EXAMPLE TASK
procedure TaskMoveAllUp(points: PointList);
var i: integer;

begin
    for i := 0 to length(points) - 1 do begin
        currentScene.getCurrentLayer().addPoint(
            Point.Create(points[i].x, points[i].y + 1)
        );
    end;
end;


// School Task #1
procedure TaskSchool1(points: PointList);
var
    i, j, l, left, right, dif, minDif: integer;
    k, b, d, yl, minK, minB: real;

begin
    d := 0.1;
    minK := 0;
    minB := 1;
    minDif := -1;       // will be reset, thats just for debugger

    for i := 0 to length(points) - 2 do begin
        for j := i + 1 to length(points) - 1 do begin
            left := 0;
            right := 0;

            k := tan(getAngleOf2P(points[i].x, points[i].y, points[j].x, points[j].y));
            b := points[i].y - points[i].x * k;

            for l := 0 to length(points) - 1 do begin
                if (l <> j) and (l <> i) then begin

                    yl := points[l].y - points[l].x * k - b;
                    if abs(yl) > d then begin
                        if yl > 0 then
                            left := left + 1
                        else
                            right := right + 1;
                    end

                end;
            end;

            dif := abs(left - right);
            if (i = 0) and (j = 1) or  // first
               (dif < minDif) then begin
                minDif := dif;
                minK := k;
                minB := b;
            end;
        end;
    end;


    currentScene.getCurrentLayer().addPoint(Point.Create(
        -128, -128 * minK + minB
    ));
    currentScene.getCurrentLayer().addPoint(Point.Create(
        128, 128 * minK + minB
    ));
    currentScene.getCurrentLayer().addLine(Line.Create(
        currentScene.getCurrentLayer().currentPoint,
        currentScene.getCurrentLayer().currentPoint - 1
    ));
end;


// REGISTER TASKS HERE
procedure initTasks();
begin
    // EXAMPLE TASK
    TMInstance.add('Все вверх', TaskMoveAllUp, 'Помещает копии всех точек чуть выше оригиналов');
    TMInstance.add('Задача #1', TaskSchool1,'Найти такую прямую, проходящую через 2 точки, что модуль разности количеств остальных точек по обе стороны от нее будет минимально возможным.');
end;


end.
