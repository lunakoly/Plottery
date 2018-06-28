unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LiteLabel, LiteMemo, ExtCtrls, LiteBackground, uColorTheme;

type
  TForm4 = class(TForm)
    LiteBackground1: TLiteBackground;
    LiteMemo1: TLiteMemo;
    LiteLabel1: TLiteLabel;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.DFM}

uses
    Unit3;


// Override
procedure TForm4.setTheme(theme: ColorTheme);
var
    i: integer;
    supporter: IThemeSupporter;

begin
    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.setTheme(theme);
end;


// Override
function TForm4.getTheme(): ColorTheme;
begin
    getTheme := settings.theme;
end;


// Override
procedure TForm4.updateColors();
var
    i: integer;
    supporter: IThemeSupporter;

begin
    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.updateColors();
end;


end.
