unit uTasks;

interface

uses uMaths, uPoint, YOUR_TASKS_HERE;


type Task = procedure(points: PointList);
type TaskList = Array of Task;
type StringList = Array of String;

type TaskManager = class
    private
        tasks: TaskList;
        names: StringList;
        descriptions: StringList;
        len: integer;

    public
        constructor Create();

        procedure enlarge();
        procedure add(name: String; t: Task; description: String);
        function size(): integer;
        function get(i: integer): Task;
        function getName(i: integer): String;
        function getDescription(i: integer): String;
end;


procedure executeTask(t: Task);


var
    TMInstance: TaskManager;


implementation

uses Unit2;


// TaskManager
constructor TaskManager.Create();
begin
    SetLength(tasks, 10);
    SetLength(names, 10);
    SetLength(descriptions, 10);
    len := 0;
end;


// TaskManager
procedure TaskManager.enlarge();
var
    sub: TaskList;
    sub2, sub3: StringList;
    i: integer;

begin
    SetLength(sub, Length(tasks) * 2 + 1);
    SetLength(sub2, Length(sub));
    SetLength(sub3, Length(sub));

    for i := 0 to Length(tasks) - 1 do begin
        sub[i] := tasks[i];
        sub2[i] := names[i];
        sub3[i] := descriptions[i];
    end;

    tasks := sub;
    names := sub2;
    descriptions := sub3;
end;


// TaskManager
procedure TaskManager.add(name: String; t: Task; description: String);
begin
    if len >= length(tasks) then begin
        enlarge();
    end;

    tasks[len] := t;
    names[len] := name;
    descriptions[len] := description;
    len := len + 1;
end;


// TaskManager
function TaskManager.size(): integer;
begin
    size := len;
end;


// TaskManager
function TaskManager.get(i: integer): Task;
begin
    get := tasks[i];
end;


// TaskManager
function TaskManager.getName(i: integer): String;
begin
    getName := names[i];
end;


// TaskManager
function TaskManager.getDescription(i: integer): String;
begin
    getDescription := descriptions[i];
end;


procedure executeTask(t: Task);
var
    pl: PointList;
    i, j, k, total: integer;

begin
    total := 0;
    for i := 0 to currentScene.layers.size() - 1 do
        total := total + currentScene.layers.get(i).points.size();

    SetLength(pl, total);
    j := 0;

    for i := 0 to currentScene.layers.size() - 1 do
        for k := 0 to currentScene.layers.get(i).points.size() - 1 do begin
            pl[j] := currentScene.layers.get(i).points.get(k);
            j := j + 1;
        end;

    t(pl);
    Form2.updateTools();
    Form2.CoordNet1.updateColors();
end;


initialization
    TMInstance := TaskManager.Create();
    initTasks();
end.
