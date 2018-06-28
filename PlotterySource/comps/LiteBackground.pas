unit LiteBackground;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, uColorTheme;


{
    Lite Label
}
type TLiteBackground = class(Tpanel, IUnknown, IThemeSupporter)
    private
        theme: ColorTheme;

    protected

    public
        constructor Create(AOwner: TComponent); override;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();

    published

end;

procedure Register;

implementation


procedure Register;
begin
    RegisterComponents('Lite', [TLiteBackground]);
end;


// Override
constructor TLiteBackground.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);

    theme := CT_DEFAULT_THEME;
    updateColors();

    BevelOuter := bvNone;
end;


// Override
procedure TLiteBackground.setTheme(theme: ColorTheme);
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
function TLiteBackground.getTheme(): ColorTheme;
begin
    getTheme := theme;
end;


// Override
procedure TLiteBackground.updateColors();
var
    i: integer;
    supporter: IThemeSupporter;
    
begin
    Color := theme.background;

    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.updateColors();
end;


end.
