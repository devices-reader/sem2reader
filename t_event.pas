unit t_event;

interface

uses Classes;

procedure InitEvents;
procedure AddEvent(bRecCode: byte);
function ResultEvents(): TStringList;

implementation

uses SysUtils, System.Generics.Collections, support, kernel, calendar;

var
  mbRecord: array[0..$FF] of byte;
  mdwCount: array[0..$FF] of longword;

procedure InitEvents;
var
  i: byte;
begin
  for i := 0 to $FF do begin
    mbRecord[i] := 0;
    mdwCount[i] := 0;
  end;
end;

procedure AddEvent(bRecCode: byte);
begin
  mbRecord[bRecCode] := bRecCode;
  mdwCount[bRecCode] := mdwCount[bRecCode]+1;
end;

function ResultEvents(): TStringList;
var
  i,j: word;
  r: byte;
  c: longword;
begin
  Result := TStringList.Create;

  for i := 0 to $FF do begin
    for j := 0 to $FF do begin
      if (mdwCount[j] < mdwCount[i]) then begin
        r := mbRecord[i];
        c := mdwCount[i];
        mbRecord[i] := mbRecord[j];
        mdwCount[i] := mdwCount[j];
        mbRecord[j] := r;
        mdwCount[j] := c;
      end;
    end;
  end;

  Result.add('');
  Result.add('—писок наиболее частых событий (количество/код)');
  for i := 0 to $FF do begin
    if (mdwCount[i] > 1) then
      Result.add(PackStrR(IntToStr(mdwCount[i]), GetColWidth) + IntToStr(mbRecord[i]));
  end;
end;

end.
