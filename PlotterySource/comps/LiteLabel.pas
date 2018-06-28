unit LiteLabel;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, uColorTheme;
     
{
    Lite Label
}
type TLiteLabel = class(TLabel, IUnknown, IThemeSupporter)
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
    RegisterComponents('Lite', [TLiteLabel]);
end;


// Override
constructor TLiteLabel.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);

    theme := CT_DEFAULT_THEME;
    updateColors();

    // other
    Font.Size := 15;
    Font.Name := 'Consolas';
    Autosize := false;
    Width := 160;
    Height := 24;
end;


// Override
procedure TLiteLabel.setTheme(theme: ColorTheme);
begin
    self.theme := theme;    // link
end;


// Override
function TLiteLabel.getTheme(): ColorTheme;
begin
    getTheme := theme;
end;


// Override
procedure TLiteLabel.updateColors();
begin
    Font.Color := theme.text;
    Color := theme.title;
end;


end.
