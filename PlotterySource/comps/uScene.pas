unit uScene;

interface

uses uLayer, uArrayListOfLayer;

const MIN_LAYERS = 1;
const MAX_LAYERS = 10;


{
    For serialization
}
type SceneRecord = record
    layers: LayerRecordList;
    currentLayer: integer;
end;


{
    Provides containers for containers of containers of points
}
type Scene = class(TObject)
    layers: ArrayListOfLayer;
    currentLayer: integer;

    constructor Create();
    function hasCurrentLayer(): boolean;
    function getCurrentLayer(): Layer;

    function selectPrevLayer(): boolean;
    function selectNextLayer(): boolean;
    function addLayer(l: Layer): boolean;
    function removeLayer(i: integer): boolean;
end;


function snToClass(r: SceneRecord): Scene;
function snToRecord(s: Scene): SceneRecord;


implementation



// Scene
constructor Scene.Create();
begin
    layers := ArrayListOfLayer.Create(10);
    layers.add(Layer.Create('Some layer'));
    currentLayer := 0;
end;


// Scene
function Scene.hasCurrentLayer(): boolean;
begin
    hasCurrentLayer := currentLayer <> -1;
end;


// Scene
function Scene.getCurrentLayer(): Layer;
begin
    getCurrentLayer := layers.get(currentLayer);
end;


// Scene
function Scene.selectPrevLayer(): boolean;
begin
    selectPrevLayer := false;

    if currentLayer > 0 then begin
        dec(currentLayer, 1);
        selectPrevLayer := true;       // success
    end;
end;


// Scene
function Scene.selectNextLayer(): boolean;
begin
    selectNextLayer := false;

    if currentLayer < layers.size() - 1 then begin
        inc(currentLayer, 1);
        selectNextLayer := true;       // success
    end;
end;


// Scene
function Scene.addLayer(l: Layer): boolean;
begin
    addLayer := false;

    if layers.size() < MAX_LAYERS then begin
        currentLayer := layers.size();
        layers.add(l);
        addLayer := true;       // success
    end;
end;


// Scene
function Scene.removeLayer(i: integer): boolean;
var j: integer;

begin
    removeLayer := false;
    layers := layers;

    if (layers.get(i) <> nil) and (i > -1) and
       (i < layers.size()) and (layers.size() > 1) then begin
        layers.remove(i);

        if currentLayer = layers.size() then
            dec(currentLayer, 1);

        removeLayer := true;
    end;
end;


function snToClass(r: SceneRecord): Scene;
var
    i: integer;
    s: Scene;

begin
    s := Scene.Create();

    s.layers.put(lyToClass(r.layers[0]), 0);

    for i := 1 to length(r.layers) - 1 do
        s.addLayer(lyToClass(r.layers[i]));

    s.currentLayer := r.currentLayer;
    snToClass := s;
end;


function snToRecord(s: Scene): SceneRecord;
var
    i: integer;
    r: SceneRecord;

begin
    SetLength(r.layers, s.layers.size());

    for i := 0 to s.layers.size() - 1 do
        r.layers[i] := lyToRecord(s.layers.get(i));

    r.currentLayer := s.currentLayer;
    snToRecord := r;
end;


end.
