unit LiteToggleLabel;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, uColorTheme, LiteLabel;

type ToggleEvent = procedure(Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;


const TL_DEFAULT_HEIGHT = 160;


{
    Lite Label
}
type TLiteToggleLabel = class(TPanel, IUnknown, IThemeSupporter)
    private
        theme: ColorTheme;
        isContentOpen, leaveOpenOnStart: boolean;
        triggerButton, title: TLiteLabel;
        openHeight, closeHeight: integer;

        toggledEvent: ToggleEvent;

        // Crutch
        userValidateStateTrigger: boolean;


        procedure updateSelfColors();

        // trigger events
        procedure triggerPressed(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

        // Crutch
        procedure userValidateStateWrite(b: boolean);

    protected
        procedure Loaded(); override;
        procedure Resize(); override;

    public
        constructor Create(AOwner: TComponent); override;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();

        procedure SetTitleCaption(s: String);
        function GetTitleCaption(): String;
        procedure validateState();

        procedure open();
        procedure close();
        function isOpen(): boolean;
        {
            Opens/Closes label according to current state
        }
        procedure toggle();
        {
            Sets min and max values of closed and opened states
        }
        procedure setAmplitude(close, open: integer);

    published
        property Caption: String read GetTitleCaption write SetTitleCaption;
        // if false then label will be closed when app starts
        property LeaveOpen: boolean read leaveOpenOnStart write leaveOpenOnStart;
        // Uset to set Open hight at design time
        property MaxHeight: integer read openHeight write openHeight;
        property OnToggle: ToggleEvent read toggledEvent write toggledEvent;
        property __UpdateState: boolean read userValidateStateTrigger write userValidateStateWrite;

end;

procedure Register;

implementation


procedure Register;
begin
    RegisterComponents('Lite', [TLiteToggleLabel]);
end;


// trigger event
procedure TLiteToggleLabel.triggerPressed(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    toggle();
    
    if Assigned(toggledEvent) then
        toggledEvent(Button, Shift, X, Y);
end;


// Override
constructor TLiteToggleLabel.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    triggerButton := TLiteLabel.Create(self);
    title := TLiteLabel.Create(self);
    triggerButton.Parent := self;
    title.Parent := self;

    theme := CT_DEFAULT_THEME;
    updateSelfColors();

    // default styles
    BevelOuter := bvNone;
    Height := TL_DEFAULT_HEIGHT;
    MaxHeight := TL_DEFAULT_HEIGHT;

    validateState();

    // subactions
    triggerButton.OnMouseDown := triggerPressed;
end;


// Override
procedure TLiteToggleLabel.Loaded();
begin
    validateState();  // retrieves last wh from resizes

    if leaveOpenOnStart then
        open()
    else
        close();
end;


// Override
procedure TLiteToggleLabel.setTheme(theme: ColorTheme);
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
function TLiteToggleLabel.getTheme(): ColorTheme;
begin
    getTheme := theme;
end;


// Override
procedure TLiteToggleLabel.updateColors();
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
procedure TLiteToggleLabel.Resize();
begin
    inherited Resize;
    validateState();
end;


// TLiteToggleLabel
procedure TLiteToggleLabel.userValidateStateWrite(b: boolean);
begin
    validateState();
end;


// TLiteToggleLabel
procedure TLiteToggleLabel.updateSelfColors();
begin
    Color := theme.background;
end;


// TLiteToggleLabel
procedure TLiteToggleLabel.SetTitleCaption(s: String);
begin
    title.Caption := s;
end;


// TLiteToggleLabel
function TLiteToggleLabel.GetTitleCaption(): String;
begin
    GetTitleCaption := title.Caption;
end;


// TLiteToggleLabel
procedure TLiteToggleLabel.setAmplitude(close, open: integer);
begin
    closeHeight := close;
    openHeight  := open;
end;


// TLiteToggleLabel
procedure TLiteToggleLabel.validateState();
begin
    triggerButton.Width  := title.Height;
    triggerButton.Height := title.Height;
    triggerButton.Alignment := taCenter;
    title.Left := triggerButton.Width;
    title.Width := Width - triggerButton.Width;

    if Height > title.Height then begin
        MaxHeight := Height;
        setAmplitude(title.Height, Height);
        open();
    end else begin
        setAmplitude(title.Height, MaxHeight);
        close();
    end;
end;


// TLiteToggleLabel
procedure TLiteToggleLabel.open();
begin
    Height := openHeight;
    triggerButton.Caption := '-';
    isContentOpen := true;
end;


// TLiteToggleLabel
procedure TLiteToggleLabel.close();
begin
    Height := closeHeight;
    triggerButton.Caption := '+';
    isContentOpen := false;
end;


// TLiteToggleLabel
function TLiteToggleLabel.isOpen(): boolean;
begin
    isOpen := isContentOpen;
end;


// TLiteToggleLabel
procedure TLiteToggleLabel.toggle();
begin
    if isContentOpen then
        close()
    else
        open();
end;


end.