unit uUtils;

interface

uses Dialogs, Forms, StdCtrls, SysUtils, uParser, Controls, uArrayList, uStringMap;

type StringList = Array of String;


{
    Used to switch objects
}
type Discarder = class
    public
        objects: StringMap;

        constructor Create();
        procedure switch(name: String);

        procedure OnSelect(o: TObject); virtual; abstract;
        procedure OnUnselect(o: TObject); virtual; abstract;
end;


{
    Like messageDLG but better
}
function customMessageDLG(const msg, title: String; dlgType: TMsgDlgType; Buttons: TMsgDlgButtons; captions: Array of String): integer;
{
    showMessage
}
procedure pout(v: String); overload;
procedure pout(v: integer); overload;
procedure pout(v: real); overload;
procedure pout(v: boolean); overload;
procedure pout2(v: real);
{
    Splits str into array of str
}
function split(str: String; t: String): StringList;
{
    Removes all controls
}
procedure clearChildren(c: TWinControl);
{
    Creates a new file if it does not exist
}
procedure newFile(path: String);


implementation


// Discarder
constructor Discarder.Create();
begin
    objects := StringMap.Create();
end;


// Discarder
procedure Discarder.switch(name: String);
var
    i: integer;
    arr: ArrayList;
    o: TObject;

begin
    arr := objects.getValues();

    for i := 0 to arr.size() - 1 do
        OnUnselect(arr.get(i));

    o := objects.get(name);
    OnSelect(o);
end;


function customMessageDLG(const msg, title: String; dlgType: TMsgDlgType; Buttons: TMsgDlgButtons; captions: Array of String): integer;
var
    aMsgDlg: TForm;
    i: integer;
    dlgButton: TButton;
    captionIndex, left: integer;
begin
    aMsgDlg := CreateMessageDialog(msg, dlgType, buttons);
    captionIndex := 0;
    left := 15;

    for i := 0 to aMsgDlg.componentCount - 1 do begin
        if aMsgDlg.components[i] is TButton then begin
            dlgButton := TButton (aMsgDlg.components[i]);
            if captionIndex > High(captions) then break;

            dlgButton.Caption := captions[captionIndex];
            dlgButton.Width := 40 + length(dlgButton.Caption) * 5;
            dlgButton.Left := left;
            left := left + dlgButton.Width + 15;
            inc(captionIndex);
        end;
    end;
    aMsgDlg.Width := left;
    aMsgDlg.Caption := title;

    customMessageDlg := aMsgDlg.showModal();
end;


procedure pout(v: String); overload;
begin
    showMessage(v);
end;


procedure pout(v: integer); overload;
begin
    showMessage(intToStr(v));
end;


procedure pout(v: real); overload;
begin
    showMessage(getNum(v));
end;


procedure pout(v: boolean); overload;
begin
    showMessage(getBool(v));
end;



procedure pout2(v: real);
begin
    showMessage(getNum2(v));
end;


function split(str: String; t: String): StringList;
var
    n, i: integer;
    sub: String;
    l: StringList;

begin
    // find amount
    sub := str;
    n := 1;
    while pos(t, sub) > 0 do begin
        delete(sub, 1, pos(t, sub) + length(t) - 1);
        n := n + 1;
    end;

    // fill
    SetLength(l, n);
    for i := 0 to n - 1 do begin
        if pos(t, str) > 0 then begin
            l[i] := copy(str, 1, pos(t, str) - 1);
            delete(str, 1, pos(t, str) + length(t) - 1);
        end else
            l[i] := str;
    end;

    split := l;
end;


procedure clearChildren(c: TWinControl);
var i: integer;

begin
    for i := 0 to c.ControlCount - 1 do
        c.controls[0].Free;
end;


procedure newFile(path: String);
var f: TextFile;

begin
    AssignFile(f, path);
    rewrite(f);
    close(f);
end;


end.
