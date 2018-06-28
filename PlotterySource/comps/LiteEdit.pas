unit LiteEdit;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, uColorTheme, uParser;


{
    Used to specify behavior for Lite Edit
}
type VT = (VT_NONE, VT_NOT_EMPTY_TEXT, VT_FLOAT, VT_INT);


{
    Lite Edit
}
type TLiteEdit = class(TEdit, IUnknown, IThemeSupporter)
    private
        theme: ColorTheme;
        isActive, warn: boolean;
        valueType: VT;

        procedure DoEnter(); override;
        procedure DoExit(); override;
        procedure Change(); override;

    protected

    public
        constructor Create(AOwner: TComponent); override;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();

        {
            Specifies the behaviour of isValid function
        }
        procedure setValueType(valueType: VT);
        {
            Returns true if Edit if empty
        }
        function isEmpty(): boolean;
        {
            Returns true if Edit value is valid according to current behaviour
        }
        function isValid(): boolean;
        {
            Updates state of edit
        }
        procedure validateState();

    published

end;


procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('Lite', [TLiteEdit]);
end;


// Override
constructor TLiteEdit.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    isActive := false;
    warn := false;
    valueType := VT_NONE;

    theme := CT_DEFAULT_THEME;
    updateColors();

    // other
    BorderStyle := bsNone;
    Font.Size := 15;
    Font.Name := 'Consolas';
    Autosize := false;
    Width := 160;
    Height := 24;
end;


// Override
procedure TLiteEdit.DoEnter();
begin
    inherited DoEnter();
    isActive := true;
    updateColors();
end;


// Override
procedure TLiteEdit.DoExit();
begin
    inherited DoExit();
    isActive := false;
    updateColors();
end;


// Override
procedure TLiteEdit.Change();
begin
    validateState();
    inherited Change();
    updateColors();
end;


// Override
procedure TLiteEdit.setTheme(theme: ColorTheme);
begin
    self.theme := theme;    // link
end;


// Override
function TLiteEdit.getTheme(): ColorTheme;
begin
    getTheme := theme;
end;


// Override
procedure TLiteEdit.updateColors();
begin
    Font.Color := theme.text;

    if ReadOnly then
        Color := theme.textfield
    else if warn then
        Color := theme.warn
    else if isActive then
        Color := theme.active
    else
        Color := theme.interact;
end;


// TLiteEdit
procedure TLiteEdit.validateState();
var
    i: integer;
    f: real;

begin
    if valueType = VT_NOT_EMPTY_TEXT then begin
        if isEmpty() then
            warn := true
        else
            warn := false;
    end else if valueType = VT_FLOAT then begin
        if not isFloat(Text, f) then
            warn := true
        else
            warn := false;
    end else if valueType = VT_INT then begin
        if not isInt(Text, i) then
            warn := true
        else
            warn := false;
    end;
end;


// TLiteEdit
procedure TLiteEdit.setValueType(valueType: VT);
begin
    self.valueType := valueType;
    validateState();
    updateColors();
end;


// TLiteEdit
function TLiteEdit.isEmpty(): boolean;
begin
    isEmpty := Length(Text) = 0;
end;


// TLiteEdit
function TLiteEdit.isValid(): boolean;
begin
    isValid := not warn;
end;


end.
