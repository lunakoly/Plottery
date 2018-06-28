unit uColorTheme;

interface

uses Graphics, uUtils, Classes, SysUtils;


{
    For serialization
}
type ColorThemeRecord = record
    interact, active, text,
    textfield, warn, title,
    background,
    coordBG, coordGrid, coordPoint, coordOutline,
    coordLine, coordText, coordAxis, scrollbarBG: TColor;
    name: String[255];
end;


{
    Represents common theme instance
}
type ColorTheme = class
    interact, active, text,
    textfield, warn, title,
    background,
    coordBG, coordGrid, coordPoint, coordOutline,
    coordLine, coordText, coordAxis, scrollbarBG: TColor;
    name: String[255];

    constructor Create(name: String);
end;
// used by default
var CT_DEFAULT_THEME: ColorTheme;


{
    Generic behavior for ColorTheme supporters
}
type IThemeSupporter = interface
    ['{7CCBBBE9-45F9-4AD4-836C-1F4023526034}'] // ctrl-shift-g
    
    procedure setTheme(theme: ColorTheme);
    function getTheme(): ColorTheme;
    procedure updateColors();
end;

{
    Returns class instance
}
function ctToClass(r: ColorThemeRecord): ColorTheme;
{
    Returns record instance
}
function ctToRecord(ct: ColorTheme): ColorThemeRecord;
{
    Returns new class instance
}
function ctCopy(r: ColorTheme): ColorTheme;
{
    Reads file into class instance
}
function ctImport(path: String): ColorTheme;
{
    Saves class instance into file
}
procedure ctExport(path: String; ct: ColorTheme);


implementation


// ColorTheme
constructor ColorTheme.Create(name: String);
begin
    title := clHighLight;
    active := $009b9b69; //TColor(RGB(105, 155, 155));
    interact := cl3DDkShadow;
    textfield := $00888888;
    text := clWhite;
    background := clBtnShadow;
    warn := $0055aaaa;
    coordBG := $00dddddd;
    coordGrid := $00cccccc0;
    coordPoint := clWhite;
    coordOutline := interact;

    coordLine := coordOutline;
    coordText := background;
    coordAxis := interact;
    scrollbarBG := textfield;

    self.name := name;
end;


function ctToRecord(ct: ColorTheme): ColorThemeRecord;
var r: ColorThemeRecord;

begin
    r.title := ct.title;
    r.active := ct.active;
    r.interact := ct.interact;
    r.textfield := ct.textfield;
    r.text := ct.text;
    r.background := ct.background;
    r.warn := ct.warn;
    r.coordBG := ct.coordBG;
    r.coordGrid := ct.coordGrid;
    r.coordPoint := ct.coordPoint;
    r.coordOutline := ct.coordOutline;
    r.name := ct.name;

    r.coordLine := ct.coordLine;
    r.coordText := ct.coordText;
    r.coordAxis := ct.coordAxis;
    r.scrollbarBG := ct.scrollbarBG;

    ctToRecord := r;
end;



function ctToClass(r: ColorThemeRecord): ColorTheme;
var ct: ColorTheme;

begin
    ct := ColorTheme.Create('Some theme');

    ct.title := r.title;
    ct.active := r.active;
    ct.interact := r.interact;
    ct.textfield := r.textfield;
    ct.text := r.text;
    ct.background := r.background;
    ct.warn := r.warn;
    ct.coordBG := r.coordBG;
    ct.coordGrid := r.coordGrid;
    ct.coordPoint := r.coordPoint;
    ct.coordOutline := r.coordOutline;
    ct.name := r.name;

    ct.coordLine := r.coordLine;
    ct.coordText := r.coordText;
    ct.coordAxis := r.coordAxis;
    ct.scrollbarBG := r.scrollbarBG;

    ctToClass := ct;
end;


function ctCopy(r: ColorTheme): ColorTheme;
var ct: ColorTheme;

begin
    ct := ColorTheme.Create('Copy of ' + r.name);

    ct.title := r.title;
    ct.active := r.active;
    ct.interact := r.interact;
    ct.textfield := r.textfield;
    ct.text := r.text;
    ct.background := r.background;
    ct.warn := r.warn;
    ct.coordBG := r.coordBG;
    ct.coordGrid := r.coordGrid;
    ct.coordPoint := r.coordPoint;
    ct.coordOutline := r.coordOutline;
    ct.name := r.name;

    ct.coordLine := r.coordLine;
    ct.coordText := r.coordText;
    ct.coordAxis := r.coordAxis;
    ct.scrollbarBG := r.scrollbarBG;

    ctCopy := ct;
end;


procedure ctExport(path: String; ct: ColorTheme);
var
    fs: TFileStream;
    r: ColorThemeRecord;

begin
    newFile(path);
    fs := TFileStream.Create(path, fmOpenWrite);
    r := ctToRecord(ct);
    fs.Write(r, sizeOf(ColorThemeRecord));           // req
    fs.Free;
end;


function ctImport(path: String): ColorTheme;
var
    fs: TFileStream;
    r: ColorThemeRecord;

begin
    ctImport := nil;

    if FileExists(path) then begin
        fs := TFileStream.Create(path, fmOpenRead);
        fs.Read(r, sizeOf(ColorThemeRecord));
        ctImport := ctToClass(r);
        fs.Free;
    end;
end;


initialization
    // init default theme
    CT_DEFAULT_THEME := ColorTheme.Create('Default');
end.
