unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, LiteButton, StdCtrls, LiteLabel, jpeg, uColorTheme, FileData, uUtils;

type
  TForm3 = class(TForm)
    Image1: TImage;
    LiteLabel1: TLiteLabel;
    LiteLabel2: TLiteLabel;
    LiteLabel3: TLiteLabel;
    LiteLabel4: TLiteLabel;
    LiteLabel5: TLiteLabel;
    LiteButton1: TLiteButton;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();

    procedure LiteButton1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  appdir: String;   // app directory
  settings: TSettings;

implementation

uses Unit1;

{$R *.DFM}


// Override
procedure TForm3.setTheme(theme: ColorTheme);
var
    i: integer;
    supporter: IThemeSupporter;

begin
    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.setTheme(theme);
end;


// Override
function TForm3.getTheme(): ColorTheme;
begin
    getTheme := settings.theme;
end;


// Override
procedure TForm3.updateColors();
var
    i: integer;
    supporter: IThemeSupporter;

begin
    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.updateColors();
end;


procedure nextForm();
begin
    Form1.show();
    Form3.hide();
end;


procedure TForm3.LiteButton1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    nextForm();
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    // data
    settings := restoreSettings(appdir + 'plottery.set');

    if settings = nil then
        settings := TSettings.Create();

    setTheme(settings.theme);
    updateColors();
end;

procedure TForm3.FormPaint(Sender: TObject);
begin
    if not settings.showBanner then
        nextForm();
end;

end.
