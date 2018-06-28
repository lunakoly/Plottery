unit LitePathSelector;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ExtCtrls, LiteButton, uUtils;

type PathSelectEvent = procedure(path, name: String) of object;


{
    Lite Path selector
}
type TLitePathSelector = class(TLiteButton)
    private
        opener: TOpenDialog;
        pathList: StringList;
        pathSelected: PathSelectEvent;

    protected

    public
        path: String;
        name: String;
        
        constructor Create(AOwner: TComponent); override;
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

        {
            Opens selection dialog
        }
        function select(): boolean;
        {
            Returns true if file hasbeen selected
        }
        function isSelected(): boolean;

    published
        property OnPathSelected: PathSelectEvent read pathSelected write pathSelected;

end;

procedure Register;

implementation


procedure Register;
begin
    RegisterComponents('Lite', [TLitePathSelector]);
end;


// Override
procedure TLitePathSelector.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    inherited MouseDown(Button, Shift, X, Y);
    if select() then
        Caption := path;
    MouseUp(Button, Shift, X, Y);

    if Assigned(pathSelected) then
        pathSelected(path, name);
end;


// Override
constructor TLitePathSelector.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    opener := TOpenDialog.Create(nil);

    Alignment := taRightJustify;
    Height := 24;
    Width := 160;
    Font.Size := 12;

    path := '';
    name := '';
    SetLength(pathList, 0);
end;


// TLitePathSelector
function TLitePathSelector.select(): boolean;
begin
    if opener.Execute then begin
        select := true;
        path := opener.FileName;
        pathList := split(path, '\');
        name := extractFileName(path);

    end else
        select := false;

end;


// TLitePathSelector
function TLitePathSelector.isSelected(): boolean;
begin
    isSelected := Length(name) > 0;
end;


end.
