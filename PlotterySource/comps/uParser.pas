unit uParser;

interface

uses SysUtils, Dialogs;

{
    Returns true if s contains float
}
function isFloat(s: String; var f: real): boolean;
{
    Returns true if s contains float
}
function isInt(s: String; var i: integer): boolean;
{
    Returns String containing trunc'ed float
}
function getNumR(f: real): String;
{
    Returns String containing float
}
function getNum(f: real): String; overload;
{
    Returns String containing int
}
function getNum(i: integer): String; overload;
{
    Returns String containing float + .##
}
function getNum2(f: real): String;
{
    Returns str containing bool
}
function getBool(b: boolean): String;


implementation


function isFloat(s: String; var f: real): boolean;
var c: integer;

begin
    val(s, f, c);

    if length(s) > 0 then begin
        if s[Length(s)] = '.' then
            isFloat := false
        else if c = 0 then
            isFloat := true
        else
            isFloat := false;
    end else
        isFloat := false;
end;


function isInt(s: String; var i: integer): boolean;
var c: integer;

begin
    val(s, i, c);

    if c = 0 then
        isInt := true
    else
        isInt := false;
end;


function getNumR(f: real): String;
var
    s: String;
    i: integer;

begin
    s := formatFloat('0', f);

    for i := 1 to length(s) do
        if s[i] = ',' then s[i] := '.';

    getNumR := s;
end;


function getNum(f: real): String;
var
    s: String;
    i: integer;

begin
    s := floatToStr(f);

    for i := 1 to length(s) do
        if s[i] = ',' then s[i] := '.';

    getNum := s;
end;


function getNum(i: integer): String;
begin
    getNum := intToStr(i);
end;


function getNum2(f: real): String;
var
    s: String;
    i: integer;

begin
    s := formatFloat('0.##', f);

    for i := 1 to length(s) do
        if s[i] = ',' then s[i] := '.';

    getNum2 := s;
end;


function getBool(b: boolean): String;
begin
    if b then
        getBool := 'true'
    else
        getBool := 'false';
end;


end.
