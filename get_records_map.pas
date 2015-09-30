unit get_records_map;

interface

procedure BoxGetRecordsMap;
procedure ShowGetRecordsMap;

implementation

uses SysUtils, soutput, support, box;

const
  quGetRecordsMap:   querys = (Action: acGetRecordsMap; cwOut: 7+1; cwIn: 5+256+2; bNumber: $FF);

procedure QueryGetRecordsMap;
begin
  InitPushCRC;
  Push(109);
  Query(quGetRecordsMap);
end;

procedure BoxGetRecordsMap;
begin
  QueryGetRecordsMap;
end;

function _Bool2Str(i: byte): string;
begin
  case i of
    255:  Result := 'нет';
    0:    Result := 'да';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

function _PopBool2Str: string;
begin
  Result := _Bool2Str(Pop);
end;

procedure ShowGetRecordsMap;
var
  i:  word;
  s:  string;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Разрешенные события');

  s := PackStrR('',12);
  for i := 0 to 9 do s := s + PackStrR(IntToStr(i),10);
  AddInfo(s);

  s := '';
  for i := 0 to 256-1 do begin
    if i mod 10 = 0 then s := PackStrR(IntToStr(i),12);
    s := s + PackStrR(_PopBool2Str,10);
    if i mod 10 = 9 then begin AddInfo(s); s := ''; end;
  end;
  AddInfo(s);


  BoxRun;
end;

end.
