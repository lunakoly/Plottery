unit LiteScrollBox;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uColorTheme,
    ExtCtrls, LiteScrollbar, LiteToggleLabel;


// Used to hide scrollbar if visibility is changed.
type VisibilityChangedEvent = procedure(Sender: TObject; isVisible: boolean) of object;


{
    Lite Label
}
type TLiteScrollBox = class(TScrollBox, IUnknown, IThemeSupporter)
    private
        theme: ColorTheme;
        barHandle: TLiteScrollbar;
        doAlign: boolean;
        visibilityChanged: VisibilityChangedEvent;


        procedure updateSelfColors();

        // bar event
        procedure barStateChanged(Shift: TShiftState; X, Y: Integer);

        // toggles events
        procedure notifyToggleChanged(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

        // visibility event
        procedure setVisibility(b: boolean);
        function getVisibility(): boolean;

    protected

    public
        constructor Create(AOwner: TComponent); override;
        procedure Loaded; override;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();

        procedure validateState();
        {
            Must be of [0;1]
        }
        procedure setState(state: real);
        function getState(): real;

        procedure setScrollBar(b: TLiteScrollbar);
        function getScrollBar(): TLiteScrollbar;

    published
        // if True all childrent will be aligned vertically
        property DoAlignToogles: boolean read doAlign write doAlign;
        property OnVisibilityChanged: VisibilityChangedEvent read visibilityChanged write visibilityChanged;
        // Used to hide scrollbar if visibility is changed.
        property Visible: boolean read getVisibility write setVisibility;
end;

procedure Register;

implementation


procedure Register;
begin
    RegisterComponents('Lite', [TLiteScrollBox]);
end;


// bar event
procedure TLiteScrollBox.barStateChanged(Shift: TShiftState; X, Y: Integer);
begin
    setState(barHandle.getState());
end;


// toggles event
procedure TLiteScrollBox.notifyToggleChanged(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    validateState();
end;


// visibility event
procedure TLiteScrollBox.setVisibility(b: boolean);
begin
    inherited Visible := b;

    if Assigned(visibilityChanged) then
        visibilityChanged(self, b);
end;


// visibility event
function TLiteScrollBox.getVisibility(): boolean;
begin
    getVisibility := inherited Visible;
end;



// Override
constructor TLiteScrollBox.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);

    theme := CT_DEFAULT_THEME;
    updateSelfColors();

    BorderStyle := bsNone;
    validateState();
end;


// Override
procedure TLiteScrollBox.Loaded();
var i: integer;

begin
    if doAlign then
        for i := 0 to ControlCount - 1 do
            if controls[i] is TLiteToggleLabel then
                TLiteToggleLabel (controls[i]).OnToggle := notifyToggleChanged;

    validateState();  // retrieves last wh from resizes
    setVisibility(Visible);  // call event listener
end;


// Override
procedure TLiteScrollBox.setTheme(theme: ColorTheme);
var
    i: integer;
    supporter: IThemeSupporter;

begin
    self.theme := theme;    // link

    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.setTheme(theme);
end;


// Override
function TLiteScrollBox.getTheme(): ColorTheme;
begin
    getTheme := theme;
end;


// Override
procedure TLiteScrollBox.updateColors();
var
    i: integer;
    supporter: IThemeSupporter;

begin
    updateSelfColors();

    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.updateColors();
end;


// Override
procedure TLiteScrollBox.updateSelfColors();
begin
    Color := theme.background;
end;


procedure TLiteScrollBox.validateState();
var i, top: integer;

begin
    if doAlign then begin
        top := -VertScrollBar.Position;

        for i := 0 to ControlCount - 1 do begin
            controls[i].Top := top;
            top := top + controls[i].Height;
        end;
    end;
    
    if Assigned(barHandle) then begin
        if VertScrollbar.Range = 0 then
            barHandle.setSize(1)
        else
            barHandle.setSize((0.0 + ClientHeight) / VertScrollbar.Range);
            
        barHandle.setState(getState());
    end;
end;


// TLiteScrollBox
procedure TLiteScrollBox.setState(state: real);
var y: integer;

begin
    y := round((VertScrollBar.Range - ClientHeight) * state);

    if y < 0 then y := 0;
    VertScrollBar.Position := y;
end;


// TLiteScrollBox
function TLiteScrollBox.getState(): real;
begin
    if VertScrollBar.Range > Clientheight then
        getState := VertScrollBar.Position / (VertScrollBar.Range - ClientHeight)
    else
        getState := 1;
end;


// TLiteScrollBox
procedure TLiteScrollBox.setScrollBar(b: TLiteScrollbar);
begin
    barHandle := b;
    b.OnThumbMove := barStateChanged;
    validateState();
end;


// TLiteScrollBox
function TLiteScrollBox.getScrollBar(): TLiteScrollbar;
begin
    getScrollBar := barHandle;
end;


end.
 