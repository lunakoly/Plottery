unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uUtils,
  ExtCtrls, LiteScrollbar, LiteScrollBox, LiteToggleLabel, StdCtrls,
  LiteMemo, uMaths, LiteEdit, LiteButton, LiteLabel, uParser, CoordNet,
  uColorTheme, uScene, uLayer, uPoint, uLine, LiteBackground, FileData;

type
  TForm2 = class(TForm)
    ToolsHandle: TLiteScrollBox;
    ToolsHandleScroll: TLiteScrollbar;
    LiteToggleLabel1: TLiteToggleLabel;
    LiteMemo1: TLiteMemo;
    LayersTool: TLiteToggleLabel;
    LiteEdit1: TLiteEdit;
    LayersToolButtonUp: TLiteButton;
    LayersToolButtonDown: TLiteButton;
    LayersToolButtonAdd: TLiteButton;
    LayersToolButtonRemove: TLiteButton;
    PointsTool: TLiteToggleLabel;
    LiteLabel1: TLiteLabel;
    PointsToolCurrentPoint: TLiteEdit;
    PointsToolPrev: TLiteButton;
    LiteButton2: TLiteButton;
    LiteLabel2: TLiteLabel;
    PointsToolCurrentX: TLiteEdit;
    LiteLabel3: TLiteLabel;
    LiteLabel4: TLiteLabel;
    PointsToolCurrentY: TLiteEdit;
    PointsToolCurrentXi: TLiteLabel;
    PointsToolCurrentYi: TLiteLabel;
    LiteButton3: TLiteButton;
    LiteButton4: TLiteButton;
    RandomizePointsTool: TLiteToggleLabel;
    RandomizeToolMinX: TLiteEdit;
    LiteLabel5: TLiteLabel;
    RandomizeToolMaxX: TLiteEdit;
    RandomizeToolMinY: TLiteEdit;
    LiteLabel6: TLiteLabel;
    RandomizeToolMaxY: TLiteEdit;
    RandomizeToolRandomizeCurrent: TLiteButton;
    LiteLabel7: TLiteLabel;
    RandomizeToolAmount: TLiteEdit;
    LiteLabel8: TLiteLabel;
    RandomizeToolThisLayer: TLiteButton;
    RandomizeToolNewLayer: TLiteButton;
    CutTool: TLiteToggleLabel;
    LiteLabel9: TLiteLabel;
    LiteLabel10: TLiteLabel;
    CutToolFrom: TLiteEdit;
    LiteLabel11: TLiteLabel;
    CutToolTo: TLiteEdit;
    LiteLabel12: TLiteLabel;
    CutToolCut: TLiteButton;
    TranslationTool: TLiteToggleLabel;
    LiteLabel13: TLiteLabel;
    LiteLabel14: TLiteLabel;
    LiteLabel15: TLiteLabel;
    LiteLabel16: TLiteLabel;
    TranslateFrom: TLiteEdit;
    TranslateTo: TLiteEdit;
    TranslateDo: TLiteButton;
    CoordNet1: TCoordNet;
    TranslateDXTitle: TLiteLabel;
    TranslateDX: TLiteEdit;
    TranslateDY: TLiteEdit;
    TranslateDYTitle: TLiteLabel;
    FuncBordTool: TLiteToggleLabel;
    LiteLabel17: TLiteLabel;
    FuncBordFrom: TLiteEdit;
    FuncBordStep: TLiteEdit;
    FuncBordTo: TLiteEdit;
    LiteLabel18: TLiteLabel;
    LiteLabel19: TLiteLabel;
    LinearFuncTool: TLiteToggleLabel;
    LiteLabel20: TLiteLabel;
    LinFuncB: TLiteEdit;
    LinFuncK: TLiteEdit;
    LiteLabel21: TLiteLabel;
    LinFuncGet: TLiteButton;
    FuncBordNewLayer: TLiteButton;
    LiteLabel22: TLiteLabel;
    FuncBordThisLayer: TLiteButton;
    LiteToggleLabel2: TLiteToggleLabel;
    LiteLabel23: TLiteLabel;
    QuadFuncA: TLiteEdit;
    QuadFuncButton: TLiteButton;
    LiteLabel24: TLiteLabel;
    QuadFuncB: TLiteEdit;
    LiteLabel25: TLiteLabel;
    QuadFuncC: TLiteEdit;
    LiteLabel26: TLiteLabel;
    TasksBar: TLiteScrollBox;
    LinesTool: TLiteToggleLabel;
    LiteLabel27: TLiteLabel;
    LiteLabel28: TLiteLabel;
    LiteLabel29: TLiteLabel;
    LinesToolP1i: TLiteLabel;
    LinesToolP2i: TLiteLabel;
    LinesToolCurrent: TLiteEdit;
    LinesToolPrev: TLiteButton;
    LinesToolNext: TLiteButton;
    LinesToolFrom: TLiteEdit;
    LinesToolTo: TLiteEdit;
    LinesToolAdd: TLiteButton;
    LinesToolRemove: TLiteButton;
    CutLinesTool: TLiteToggleLabel;
    LiteLabel32: TLiteLabel;
    LiteLabel33: TLiteLabel;
    LiteLabel34: TLiteLabel;
    LiteLabel35: TLiteLabel;
    CutLinesToolFrom: TLiteEdit;
    CutLinesToolTo: TLiteEdit;
    CutLinesToolCut: TLiteButton;
    LiteBackground1: TLiteBackground;
    LiteButton1: TLiteButton;
    LiteButton5: TLiteButton;
    LiteButton6: TLiteButton;
    TasksBarScroll: TLiteScrollbar;
    TasksBarLabel: TLiteLabel;
    LiteToggleLabel3: TLiteToggleLabel;
    LiteLabel30: TLiteLabel;
    LiteLabel31: TLiteLabel;
    LiteLabel36: TLiteLabel;
    LiteLabel37: TLiteLabel;
    AddTriangleX: TLiteEdit;
    AddTriangleY: TLiteEdit;
    LiteButton7: TLiteButton;
    LiteToggleLabel4: TLiteToggleLabel;
    LiteLabel38: TLiteLabel;
    LiteLabel39: TLiteLabel;
    LiteLabel40: TLiteLabel;
    LiteLabel41: TLiteLabel;
    AddSquareX: TLiteEdit;
    AddSquareY: TLiteEdit;
    AddSquareAdd: TLiteButton;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();
    procedure FormShow(Sender: TObject);
    procedure updateLayersTool();
    procedure updateTools();
    procedure AddLayer(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure renameLayer(Sender: TObject);
    procedure removeLayer(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure selectLayer(Sender: TObject);
    procedure MoveLayerUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MoveLayerDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure updatePointsTool();
    procedure AddPoint(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SelectPrevPoint(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SelectNextPoint(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PointsToolCurrentPointChange(Sender: TObject);
    procedure SetXValue(Sender: TObject);
    procedure SetYValue(Sender: TObject);
    procedure removePoint(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure randomizeCurrent(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AddRandomPoints(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AddRandomPointsToNewLayer(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CutPoints(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TranslatePoints(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LinFuncGetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FuncBordThisLayerMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FuncBordNewLayerMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure QuadFuncGet(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CoordNet1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CoordNet1PointMove(Sender: TObject);
    procedure initTasks();
    procedure execTask(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure getTaskInfo(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure updateLinesTool();
    procedure SelectPrevLine(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SelectNextLine(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AddLine(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure removeLine(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetLineP1(Sender: TObject);
    procedure SetLineP2(Sender: TObject);
    procedure CutLines(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure hideAllTools();
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure LiteButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LiteButton5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AddTriangleAdd(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; Xi, Yi: Integer);
    procedure AddSquareAddMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; Xi, Yi: Integer);
    procedure SaveProjectButton(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CurrentLineChanged(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  currentScene: Scene;

implementation

uses Unit1, Unit3, uTasks, Unit4;

var
    funcLayerSelection: ButtonDiscarder;

{$R *.DFM}

// Override
procedure TForm2.setTheme(theme: ColorTheme);
var
    i: integer;
    supporter: IThemeSupporter;

begin
    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.setTheme(theme);
end;


// Override
function TForm2.getTheme(): ColorTheme;
begin
    getTheme := settings.theme;
end;


// Override
procedure TForm2.updateColors();
var
    i: integer;
    supporter: IThemeSupporter;

begin
    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.updateColors();
end;


procedure TForm2.FormShow(Sender: TObject);
begin
    randomize;
    Width := 1191;
    Height := 666;

    ToolsHandle.setScrollBar(ToolsHandleScroll);
    TasksBar.setScrollBar(TasksBarScroll);

    PointsToolCurrentPoint.setValueType(VT_INT);
    PointsToolCurrentX.setValueType(VT_FLOAT);
    PointsToolCurrentY.setValueType(VT_FLOAT);
    RandomizeToolMinX.setValueType(VT_FLOAT);
    RandomizeToolMaxX.setValueType(VT_FLOAT);
    RandomizeToolMinY.setValueType(VT_FLOAT);
    RandomizeToolMaxY.setValueType(VT_FLOAT);
    RandomizeToolAmount.setValueType(VT_INT);
    CutToolFrom.setValueType(VT_INT);
    CutToolTo.setValueType(VT_INT);

    TranslateFrom.setValueType(VT_INT);
    TranslateTo.setValueType(VT_INT);
    TranslateDX.setValueType(VT_FLOAT);
    TranslateDY.setValueType(VT_FLOAT);

    FuncBordFrom.setValueType(VT_FLOAT);
    FuncBordTo.setValueType(VT_FLOAT);
    FuncBordStep.setValueType(VT_FLOAT);

    LinFuncK.setValueType(VT_FLOAT);
    LinFuncB.setValueType(VT_FLOAT);

    QuadFuncA.setValueType(VT_FLOAT);
    QuadFuncB.setValueType(VT_FLOAT);
    QuadFuncC.setValueType(VT_FLOAT);

    LinesToolCurrent.setValueType(VT_INT);
    LinesToolFrom.setValueType(VT_INT);
    LinesToolTo.setValueType(VT_INT);

    CutLinesToolFrom.setValueType(VT_INT);
    CutLinesToolTo.setValueType(VT_INT);

    AddTriangleX.setValueType(VT_FLOAT);
    AddTriangleY.setValueType(VT_FLOAT);

    AddSquareX.setValueType(VT_FLOAT);
    AddSquareY.setValueType(VT_FLOAT);

    updateTools();
    hideAllTools();
    ToolsHandle.validateState();

    initTasks();

    setTheme(Form1.getTheme());
    updateColors();
end;


procedure TForm2.execTask(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    executeTask(TMInstance.get( (Sender as TLiteButton).Tag ));
end;


procedure TForm2.getTaskInfo(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    Form4.LiteMemo1.Lines.Clear;
    Form4.LiteMemo1.Lines.Add(TMInstance.getDescription( (Sender as TLiteButton).Tag ));
    Form4.showModal;
end;


procedure TForm2.initTasks();
var
    i, top: integer;
    b, q: TLiteButton;
    h: TLiteBackground;

begin
    top := 16;

    for i := 0 to TMInstance.size() - 1 do begin
        h := TLiteBackground.Create(TasksBar);
        h.Parent := TasksBar;
        h.Width := 240;
        h.Left := 8;
        h.Top := top;
        top := top + h.Height + 8;

        b := TLiteButton.Create(h);
        b.Parent := h;
        b.Width := 240 - b.Height; // make the next button square

        b.Caption := TMInstance.getName(i);
        b.Tag := i;
        b.OnMouseDown := execTask;

        b.ShowHint := true;
        b.Hint := 'Выполнить задачу';

        q := TLiteButton.Create(h);
        q.Parent := h;
        q.Width := b.Height - 1;
        q.Left := b.Width + 1;

        q.Caption := '?';
        q.Tag := i;
        q.OnMouseDown := getTaskInfo;
        q.AutoReact := false;

        q.ShowHint := true;
        q.Hint := 'Инфо';
    end;
end;


procedure TForm2.hideAllTools();
var i: integer;

begin
    for i := 0 to ToolsHandle.ControlCount - 1 do
        if ToolsHandle.controls[i] is TLiteToggleLabel then
            (ToolsHandle.controls[i] as TLiteToggleLabel).close();
end;


procedure TForm2.updateTools();
begin
    updateLayersTool();
    updatePointsTool();
    updateLinesTool();

    ToolsHandle.validateState();
end;


procedure TForm2.updateLayersTool();
var
    layerHandle: TLiteEdit;
    i, top: integer;

begin
    i := 0;
    while i < LayersTool.ControlCount do
        if LayersTool.controls[i] is TLiteEdit then
            LayersTool.controls[i].Free
        else
            i := i + 1;

    top := 40;
    for i := 0 to currentScene.layers.size() - 1 do begin
        layerHandle := TLiteEdit.Create(LayersTool);
        layerHandle.Parent := LayersTool;
        layerHandle.Top := top;
        top := top + layerHandle.Height + 8;
        layerHandle.Width := 249;
        layerHandle.Text := currentScene.layers.get(i).name;

        layerHandle.Tag := i;
        layerHandle.setValueType(VT_NOT_EMPTY_TEXT);
        layerHandle.OnChange := renameLayer;
        layerHandle.OnEnter := selectLayer;

        if i = currentScene.currentLayer then
            layerHandle.SetFocus;
    end;

    top := top + 8;
    LayersToolButtonUp.Top := top;
    LayersToolButtonDown.Top := top;

    top := top + LayersToolButtonUp.Height + 8;
    LayersToolButtonAdd.Top := top;
    LayersToolButtonRemove.Top := top;

    LayersTool.MaxHeight := top + LayersToolButtonRemove.Height + 8;
    if LayersTool.isOpen() then
        LayersTool.Height := LayersTool.MaxHeight;
    LayersTool.validateState();
end;


procedure TForm2.updatePointsTool();
begin
    PointsTool.Caption := 'Точки (' + getNum(currentScene.getCurrentLayer().points.size()) + ')';
    PointsToolCurrentPoint.Text := getNum(currentScene.getCurrentLayer().currentPoint);
    PointsToolCurrentXi.Caption := PointsToolCurrentPoint.Text;
    PointsToolCurrentYi.Caption := PointsToolCurrentPoint.Text;

    if currentScene.getCurrentLayer().currentPoint <> -1 then begin
        PointsToolCurrentX.Text := getNum2(currentScene.getCurrentLayer().getCurrentPoint().x);
        PointsToolCurrentY.Text := getNum2(currentScene.getCurrentLayer().getCurrentPoint().y);
    end else begin
        PointsToolCurrentX.Text := 'N/A';
        PointsToolCurrentY.Text := 'N/A';
    end;
end;


procedure TForm2.updateLinesTool();
begin
    LinesTool.Caption := 'Отрезки (' + getNum(currentScene.getCurrentLayer().lines.size()) + ')';
    LinesToolCurrent.Text := getNum(currentScene.getCurrentLayer().currentLine);
    LinesToolP1i.Caption := LinesToolCurrent.Text;
    LinesToolP2i.Caption := LinesToolCurrent.Text;

    if currentScene.getCurrentLayer().currentLine <> -1 then begin
        LinesToolFrom.Text := getNum2(currentScene.getCurrentLayer().getCurrentLine().p1);
        LinesToolTo.Text   := getNum2(currentScene.getCurrentLayer().getCurrentLine().p2);
    end else begin
        LinesToolFrom.Text := 'N/A';
        LinesToolTo.Text   := 'N/A';
    end;
end;


procedure TForm2.AddLayer(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.addLayer(Layer.Create('Новый слой')) then begin
        updateTools();
        CoordNet1.updateColors();
    end;
end;


procedure TForm2.renameLayer(Sender: TObject);
begin
    if (Sender as TLiteEdit).isValid then
        currentScene.layers.get((Sender as TLiteEdit).Tag).name := (Sender as TLiteEdit).Text;
end;


procedure TForm2.removeLayer(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.layers.size() > 1 then begin
        currentScene.removeLayer(currentScene.currentLayer);
        updateTools();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.selectLayer(Sender: TObject);
begin
    currentScene.currentLayer := (Sender as TLiteEdit).Tag;
    updatePointsTool();
end;

procedure TForm2.MoveLayerUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    sub: Layer;

begin
    if currentScene.currentLayer > 0 then begin
        sub := currentScene.layers.get(currentScene.currentLayer - 1);
        currentScene.layers.put(currentScene.layers.get(currentScene.currentLayer), currentScene.currentlayer - 1);
        currentScene.layers.put(sub, currentScene.currentLayer);
        dec(currentScene.currentLayer, 1);
        updateLayersTool();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.MoveLayerDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    sub: Layer;

begin
    if currentScene.currentLayer < currentScene.layers.size() - 1 then begin
        sub := currentScene.layers.get(currentScene.currentLayer);
        currentScene.layers.put(currentScene.layers.get(currentScene.currentLayer + 1), currentScene.currentLayer);
        currentScene.layers.put(sub, currentScene.currentLayer + 1);
        inc(currentScene.currentLayer, 1);
        updateLayersTool();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.AddPoint(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.getCurrentLayer().addPoint(Point.Create(0, 0)) then begin
        updatePointsTool();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.SelectPrevPoint(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.getCurrentLayer().selectPrevPoint() then
        updatePointsTool();
end;

procedure TForm2.SelectNextPoint(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.getCurrentLayer().selectNextPoint() then
        updatePointsTool();
end;

procedure TForm2.PointsToolCurrentPointChange(Sender: TObject);
var i: integer;

begin
    if (Sender as TLiteEdit).isValid() then begin
        i := StrToInt((Sender as TLiteEdit).Text);

        if (i >= 0) and (i < currentScene.getCurrentLayer().points.size()) then begin
            currentScene.getCurrentLayer().currentPoint := i;
            updatePointsTool();
            CoordNet1.updateColors();
        end;
    end;
end;

procedure TForm2.SetXValue(Sender: TObject);
var f: real;

begin
    if (currentScene.getCurrentLayer().currentPoint <> -1) and
       isFloat(PointsToolCurrentX.Text, f) then begin
        currentScene.getCurrentLayer().getCurrentPoint.x := f;
        updatePointsTool();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.SetYValue(Sender: TObject);
var f: real;

begin
    if (currentScene.getCurrentLayer().currentPoint <> -1) and
       isFloat(PointsToolCurrentY.Text, f) then begin
        currentScene.getCurrentLayer().getCurrentPoint.y := f;
        updatePointsTool();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.removePoint(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.getCurrentLayer().removePoint(currentScene.getCurrentLayer().currentPoint) then begin
        updatePointsTool();
        updateLinesTool();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.randomizeCurrent(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    minX, maxX, minY, maxY: real;

begin
    if currentScene.getCurrentLayer().currentPoint <> -1 then
        if isFloat(RandomizeToolMinX.Text, minX) and
           isFloat(RandomizeToolMaxX.Text, maxX) and
           isFloat(RandomizeToolMinY.Text, minY) and
           isFloat(RandomizeToolMaxY.Text, maxY) then begin
            currentScene.getCurrentLayer().getCurrentPoint().x := getRand(minX, maxX);
            currentScene.getCurrentLayer().getCurrentPoint().y := getRand(minY, maxY);
            updatePointsTool();
            CoordNet1.updateColors();
        end;
end;

procedure TForm2.AddRandomPoints(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    a, rest, i: integer;
    proceed: boolean;
    minX, maxX, minY, maxY: real;

begin
    if isInt(RandomizeToolAmount.Text, a) then begin
        if a < 0 then a := 0;

        rest := MAX_POINTS - currentScene.getCurrentLayer().points.size();

        proceed := true;
        if a > rest then
            if customMessagedlg('Только ' + IntToStr(rest) + ' точек можно добавить',
                'Перекресток, где нажи дороги расходятся', mtCustom,
                [mbYes, mbNo, mbOK], ['Продолжить', 'Аборт', 'Я против абортов!']) = mrNo then begin
                proceed := false;
            end;

        if proceed then begin
            if isFloat(RandomizeToolMinX.Text, minX) and
               isFloat(RandomizeToolMaxX.Text, maxX) and
               isFloat(RandomizeToolMinY.Text, minY) and
               isFloat(RandomizeToolMaxY.Text, maxY) then begin
                for i := 1 to a do begin
                    currentScene.getCurrentLayer().AddPoint(getRandPoint(minX, maxX, minY, maxY));
                end;
                updatePointsTool();
                CoordNet1.updateColors();
            end;
        end;
    end;
end;

procedure TForm2.AddRandomPointsToNewLayer(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    currentScene.addLayer(Layer.Create('Новый слой'));
    AddRandomPoints(Sender, Button, Shift, X, Y);
    updateTools();
    CoordNet1.updateColors();
end;

procedure TForm2.CutPoints(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    min, max: integer;
    ask, proceed: boolean;

begin
    ask := false;
    proceed := true;

    if isInt(CutToolFrom.Text, min) and
       isInt(CutToolTo.Text, max) then begin
        if min < 0 then begin
            min := 0;
            ask := true;
        end;

        if max > currentScene.getCurrentLayer().points.size() - 1 then begin
            max := currentScene.getCurrentLayer().points.size() - 1;
            ask := true;
        end;

        if min > max then
            min := max;

        if ask then
            if customMessagedlg('Только [' + IntToStr(min) + ',' + IntToStr(max) + '] доступно',
                'Выбор', mtCustom,
                [mbYes, mbNo], ['Продолжить', 'Прервать']) = mrNo then begin
                proceed := false;
            end;

        if proceed then begin
            currentScene.getCurrentLayer().cutPoints(min, max);
            updatePointsTool();
            updateLinesTool();
            CoordNet1.updateColors();
        end;
    end;
end;

procedure TForm2.TranslatePoints(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    min, max: integer;
    ask, proceed: boolean;
    dx, dy: real;

begin
    ask := false;
    proceed := true;

    if isInt(TranslateFrom.Text, min) and
       isInt(TranslateTo.Text, max) and
       isFloat(TranslateDX.Text, dx) and
       isFloat(TranslateDY.Text, dy) then begin
        if min < 0 then begin
            min := 0;
            ask := true;
        end;

        if max > currentScene.getCurrentLayer().points.size() - 1 then begin
            max := currentScene.getCurrentLayer().points.size() - 1;
            ask := true;
        end;

        if ask then
            if customMessagedlg('Только [' + IntToStr(min) + ',' + IntToStr(max) + '] доступно',
                'Выбор', mtCustom,
                [mbYes, mbNo], ['Продолжить', 'Прервать']) = mrNo then begin
                proceed := false;
            end;

        if proceed then begin
            currentScene.getCurrentLayer().translatePoints(min, max, dx, dy);
            updatePointsTool();
            CoordNet1.updateColors();
        end;
    end;
end;

procedure TForm2.LinFuncGetMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    xi, yi, k, b, min, max, step: real;
    i: integer;

begin
    if isFloat(FuncBordFrom.Text, min) and
       isFloat(FuncBordTo.Text, max) and
       isFloat(FuncBordStep.Text, step) and
       isFloat(LinFuncK.Text, k) and
       isFloat(LinFuncB.Text, b) then begin

        if FuncBordNewLayer.isActive = true then
            currentScene.addLayer(Layer.Create('New Layer'));

        i := 0;
        xi := min;
        while xi <= max do begin
            yi := xi * k + b;
            currentScene.getCurrentLayer().addPoint(Point.Create(xi, yi));

            if (currentScene.getCurrentLayer().currentPoint > 0) and
               (xi <> min) then
                currentScene.getCurrentLayer().addLine(Line.Create(
                    currentScene.getCurrentLayer().currentPoint,
                    currentScene.getCurrentLayer().currentPoint - 1
                ));
                
            xi := xi + step;
            i := i + 1;

            if i >= 50 then
                break;
        end;

        updateTools();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
    funcLayerSelection := ButtonDiscarder.Create();
    funcLayerSelection.objects.add('this', FuncBordThisLayer);
    funcLayerSelection.objects.add('new', FuncBordNewLayer);
    funcLayerSelection.switch('this');
end;

procedure TForm2.FuncBordThisLayerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    funcLayerSelection.switch('this');
end;

procedure TForm2.FuncBordNewLayerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    funcLayerSelection.switch('new');
end;

procedure TForm2.QuadFuncGet(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    xi, yi, a, b, c, min, max, step: real;
    i: integer;

begin
    if isFloat(FuncBordFrom.Text, min) and
       isFloat(FuncBordTo.Text, max) and
       isFloat(FuncBordStep.Text, step) and
       isFloat(QuadFuncA.Text, a) and
       isFloat(QuadFuncB.Text, b) and
       isFloat(QuadFuncC.Text, c) then begin

        if FuncBordNewLayer.isActive = true then
            currentScene.addLayer(Layer.Create('Новый слой'));

        i := 0;
        xi := min;
        while xi <= max do begin
            yi := xi * xi * a + b * xi + c;
            currentScene.getCurrentLayer().addPoint(Point.Create(xi, yi));

            if (currentScene.getCurrentLayer().currentPoint > 0) and
               (xi <> min) then
                currentScene.getCurrentLayer().addLine(Line.Create(
                    currentScene.getCurrentLayer().currentPoint,
                    currentScene.getCurrentLayer().currentPoint - 1
                ));

            xi := xi + step;
            i := i + 1;

            if i >= 50 then
                break;
        end;

        updateTools();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.CoordNet1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    // update currents
    updateLayersTool();
    updatePointsTool();
    updateLinesTool();
end;

procedure TForm2.CoordNet1PointMove(Sender: TObject);
begin
    updatePointsTool();
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
    selected: integer;
    closeApp: boolean;

begin
    closeApp := false; // for the compiler not to tell bullshit

    if settings.exitAction = 'ask' then begin

        selected := customMessagedlg('Выйти или закрыть приложение?', 'Выход', mtCustom,
            [mbYes, mbNo, mbOK, mbAll], ['Сейчас: Меню', 'Меню', 'Выход', 'Сейчас: Выход']);

        if selected = mrYes then
            closeApp := false
        else if selected = mrNo then begin
            settings.exitAction := 'menu';
            settingsCloseAction.switch('menu');
            closeApp := false;
        end else if selected = mrOK then begin
            settings.exitAction := 'close';
            settingsCloseAction.switch('close');
            closeApp := true;
        end else if selected = mrAll then
            closeApp := true
        else
            CanClose := false;

    end else if settings.exitAction = 'menu' then
        closeApp := false
    else
        closeApp := true;

    if not CanClose then begin
        // NOTHING
    end else if closeApp then begin
        Application.Terminate();
    end else begin
        Form2.hide();
        Form1.show();
    end;
end;

procedure TForm2.SelectPrevLine(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.getCurrentLayer().selectPrevLine() then
        updateLinesTool();
end;

procedure TForm2.SelectNextLine(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.getCurrentLayer().selectNextLine() then
        updateLinesTool();
end;

procedure TForm2.AddLine(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.getCurrentLayer().hasCurrentPoint() then
        if currentScene.getCurrentLayer().addLine(Line.Create(0, 0)) then begin
            updateLinesTool();
            CoordNet1.updateColors();
        end;
end;

procedure TForm2.removeLine(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if currentScene.getCurrentLayer().removeLine(currentScene.getCurrentLayer().currentLine) then begin
        updateLinesTool();
        CoordNet1.updateColors();
    end;
end;


procedure TForm2.SetLineP1(Sender: TObject);
var
    p: integer;

begin
    if (currentScene.getCurrentLayer().currentLine <> -1) and
       isInt(LinesToolFrom.Text, p) then begin
        currentScene.getCurrentLayer().getCurrentLine().p1 := p;
        currentScene.getCurrentLayer().updateLines();
        updateLinesTool();
        CoordNet1.updateColors();
    end;
end;


procedure TForm2.SetLineP2(Sender: TObject);
var
    p: integer;

begin
    if (currentScene.getCurrentLayer().currentLine <> -1) and
       isInt(LinesToolTo.Text, p) then begin
        currentScene.getCurrentLayer().getCurrentLine().p2 := p;
        currentScene.getCurrentLayer().updateLines();
        updateLinesTool();
        CoordNet1.updateColors();
    end;
end;


procedure TForm2.CutLines(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    min, max: integer;
    ask, proceed: boolean;

begin
    ask := false;
    proceed := true;

    if isInt(CutLinesToolFrom.Text, min) and
       isInt(CutLinesToolTo.Text, max) then begin
        if min < 0 then begin
            min := 0;
            ask := true;
        end;

        if max > currentScene.getCurrentLayer().lines.size() - 1 then begin
            max := currentScene.getCurrentLayer().lines.size() - 1;
            ask := true;
        end;

        if min > max then
            min := max;

        if ask then
            if customMessagedlg('Только [' + IntToStr(min) + ',' + IntToStr(max) + '] доступно',
                'Выбор', mtCustom,
                [mbYes, mbNo], ['Продолжить', 'Прервать']) = mrNo then begin
                proceed := false;
            end;

        if proceed then begin
            currentScene.getCurrentLayer().cutLines(min, max);
            updateLinesTool();
            CoordNet1.updateColors();
        end;
    end;
end;

procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
    case key of
        '-': begin
            CoordNet1.setScale(CoordNet1.getScale() * 2);
            CoordNet1.updateColors();
        end;
        '+': begin
            CoordNet1.setScale(CoordNet1.getScale() / 2);
            CoordNet1.updateColors();
        end;
    end;
end;

procedure TForm2.LiteButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    CoordNet1.setScale(CoordNet1.getScale() / 2);
    CoordNet1.updateColors();
end;

procedure TForm2.LiteButton5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    CoordNet1.setScale(CoordNet1.getScale() * 2);
    CoordNet1.updateColors();
end;

procedure TForm2.AddTriangleAdd(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; Xi, Yi: Integer);
var
    x, y, l: real;
    p: PointList;

begin
    l := 2;

    if isFloat(AddTriangleX.Text, x) and
       isFloat(AddTriangleY.Text, y) then begin
        SetLength(p, 3);
        p[0] := Point.Create(x, y + l * 2 / 3);
        p[1] := Point.Create(x - l / 2, y - l * 1 / 3);
        p[2] := Point.Create(x + l / 2, y - l * 1 / 3);

        poligon(p, currentScene.getCurrentLayer());
        updateTools();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.AddSquareAddMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; Xi, Yi: Integer);
var
    x, y, l: real;
    p: PointList;

begin
    l := 2;

    if isFloat(AddSquareX.Text, x) and
       isFloat(AddSquareY.Text, y) then begin
        SetLength(p, 4);
        p[0] := Point.Create(x + l / 2, y + l / 2);
        p[1] := Point.Create(x - l / 2, y + l / 2);
        p[2] := Point.Create(x - l / 2, y - l / 2);
        p[3] := Point.Create(x + l / 2, y - l / 2);

        poligon(p, currentScene.getCurrentLayer());
        updateTools();
        CoordNet1.updateColors();
    end;
end;

procedure TForm2.SaveProjectButton(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    saveProject(projectPath, currentScene);
end;

procedure TForm2.CurrentLineChanged(Sender: TObject);
var
    i: integer;

begin
    if (Sender as TLiteEdit).isValid() then begin
        i := StrToInt((Sender as TLiteEdit).Text);

        if (i >= 0) and (i < currentScene.getCurrentLayer().lines.size()) then begin
            currentScene.getCurrentLayer().currentLine := i;
            updateLinesTool();
            CoordNet1.updateColors();
        end;
    end;
end;

end.
