unit get_extended0;

interface

uses kernel;

procedure BoxGetExt0;
procedure ShowGetExt0;

var
  mpExt0Repeats,
  mpExt0Errors: array[0..4-1,0..48-1] of longword;

implementation

uses SysUtils, soutput, support, progress, box;

const
  quGetExt0: querys = (Action: acGetExt0; cwOut: 7+1; cwIn: 15+3+4*4*48+4*4*48+2; bNumber: $FF);

procedure QueryGetExt0;
begin
  InitPushCRC;
  Push(128);
  Query(quGetExt0);
end;

procedure BoxGetExt0;
begin
  AddInfo('');
  AddInfo('Статистика качества связи');
  AddInfo('');

  QueryGetExt0;
end;

procedure ShowGetExt0;
var
  p,h:  word;
  s:    string;
begin
  Stop;

  InitPop(15);
  AddInfo('Признак включения режима: '+PopBool2Str);
  AddInfo('Количество повторов:      '+IntToStr(Pop)+' из '+IntToStr(Pop));

  for p := 0 to 4-1 do
    for h := 0 to 48-1 do
      mpExt0Repeats[p,h] := PopLong;

  for p := 0 to 4-1 do
    for h := 0 to 48-1 do
      mpExt0Errors[p,h] := PopLong;


  AddInfo('');
  AddInfo('График повторов');
  s := PackStrR('',GetColWidth);
  for p := 0 to 4-1 do
    s := s + PackStrR('порт ' + IntToStr(p+1),GetColWidth);
  AddInfo(s);

  for h := 0 to 48-1 do begin
    s := PackStrR(Int2Str(h div 2)+':'+Int2Str((h mod 2)*30),GetColWidth);
    for p := 0 to 4-1 do
      s := s + PackStrR(IntToStr(mpExt0Repeats[p,h]),GetColWidth);
    AddInfo(s);
  end;

  AddInfo('');
  AddInfo('График ошибок');
  s := PackStrR('',GetColWidth);
  for p := 0 to 4-1 do
    s := s + PackStrR('порт ' + IntToStr(p+1),GetColWidth);
  AddInfo(s);
  
  for h := 0 to 48-1 do begin
    s := PackStrR(Int2Str(h div 2)+':'+Int2Str((h mod 2)*30),GetColWidth);
    for p := 0 to 4-1 do
      s := s + PackStrR(IntToStr(mpExt0Errors[p,h]),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

end.
