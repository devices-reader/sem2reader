unit t_entry;

interface

uses Classes, timez;

procedure InitEntry;
procedure AddEntry(c: byte; tm: times);
function ResultEntry(): TStringList;
implementation

uses SysUtils, System.Generics.Collections, support, kernel, calendar;

const
  WIDTH = 8;

type
  canal_t = record
    imp: array[0..CANALS-1] of word;
  end;

  half_t = record
    val: canal_t;
  end;

  day_t = record
    halfs: array[0..47] of half_t;
    flags: array[0..CANALS-1] of boolean;
  end;

var
  flags: array[0..CANALS-1] of boolean;
  days:  TDictionary<longword,day_t>;
  sum:   day_t;

procedure InitEntry;
var
  c,d,h,m:  byte;
begin
  for c := 0 to CANALS-1 do begin
    flags[c] := false;
    for h := 0 to 47 do begin
      sum.halfs[h].val.imp[c] := 0;
    end;
  end;
  days := TDictionary<longword,day_t>.Create;
end;

function CreateDay: day_t;
var
  c,d,h,m:  byte;
  day:      day_t;
begin
  for c := 0 to CANALS-1 do begin
    day.flags[c] := false;
    for h := 0 to 47 do begin
      day.halfs[h].val.imp[c] := 0;
    end;
  end;
  Result := day;
end;

procedure AddEntry(c: byte; tm: times);
var
  d,h,m:  byte;
  day:    day_t;
  idx:    longword;
begin
  h := tm.bHour*2 + tm.bMinute div 30;
  d := tm.bDay;
  m := tm.bMonth;

  idx := DateToDayIndex(tm);
  if days.ContainsKey(idx) then
    day := days[idx]
  else
    day := CreateDay;

  day.flags[c] := true;
  flags[c] := true;

  Inc(day.halfs[h].val.imp[c]);
  Inc(sum.halfs[h].val.imp[c]);

  days.AddOrSetValue(idx, day);
end;

function sort(keys: TEnumerable<longword>): TArray<longword>;
begin
  Result := keys.ToArray;
  TArray.Sort<longword>(Result);
end;

function ResultEntry(): TStringList;
var
  c,h,d,m:byte;
  idx:    longword;
  day:    day_t;
  s:      string;
begin
  Result := TStringList.Create;


  Result.Add('');
  Result.Add('все время');
  s := PackStrR('',WIDTH);
  for c := 0 to CANALS-1 do begin
  if flags[c] then
    s := s + PackStrR(IntToStr(c+1),WIDTH);
  end;
  Result.Add(s);

  for h := 0 to 47 do begin
    s := PackStrR(Int2Str(h div 2,2)+'.'+Int2Str((h mod 2)*30,2),WIDTH);
    for c := 0 to CANALS-1 do begin
      if flags[c] then
        s := s + PackStrR(IntToStr(sum.halfs[h].val.imp[c]),WIDTH);
    end;
    Result.Add(s);
  end;


  Result.Add('');
  for idx in sort(days.Keys) do begin
    day := days[idx];
    Result.Add('');
    Result.Add(Times2Str(DayIndexToDate(idx)));

    s := PackStrR('',WIDTH);
    for c := 0 to CANALS-1 do begin
      if flags[c] then
        s := s + PackStrR(IntToStr(c+1),WIDTH);
    end;
    Result.Add(s);

    for h := 0 to 47 do begin
      s := PackStrR(Int2Str(h div 2,2)+'.'+Int2Str((h mod 2)*30,2),WIDTH);
      for c := 0 to CANALS-1 do begin
        if flags[c] then begin
          if day.flags[c] then
            s := s + PackStrR(IntToStr(day.halfs[h].val.imp[c]),WIDTH)
          else
            s := s + PackStrR('',WIDTH);
        end;
      end;
      Result.Add(s);
    end;
  end;

end;

end.
