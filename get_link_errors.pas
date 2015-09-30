unit get_link_errors;

interface

uses kernel;

procedure BoxGetLinkErrors;
procedure ShowGetLinkErrors;

var
  mpeLinkErrorsZ: array[0..CANALS-1] of word;
  mpeLinkErrorsC: array[0..CANALS-1] of word;
  mpeLinkErrors0: array[0..CANALS-1] of word;
  mpeLinkErrors1: array[0..CANALS-1] of word;
  mpeLinkErrors2: array[0..CANALS-1] of word;
  mpeLinkErrors3: array[0..CANALS-1] of word;

implementation

uses SysUtils, soutput, support, realz, borders, box;

const
  quGetLinkErrors:   querys = (Action: acGetLinkErrors; cwOut: 8; cwIn: 5+6*64*2+2; bNumber: $FF);

procedure QueryGetLinkErrors;
begin
  InitPushCRC;
  Push(70);
  Query(quGetLinkErrors);
end;

procedure BoxGetLinkErrors;
begin
  QueryGetLinkErrors;
end;
                          
procedure ShowGetLinkErrors;
var
  c:  word;
  s:  string;
begin
  Stop;

  InitPopCRC;
  for c := 0 to CANALS-1 do mpeLinkErrorsZ[c] := PopInt;
  for c := 0 to CANALS-1 do mpeLinkErrorsC[c] := PopInt;
  for c := 0 to CANALS-1 do mpeLinkErrors0[c] := PopInt;
  for c := 0 to CANALS-1 do mpeLinkErrors1[c] := PopInt;
  for c := 0 to CANALS-1 do mpeLinkErrors2[c] := PopInt;
  for c := 0 to CANALS-1 do mpeLinkErrors3[c] := PopInt;

  AddInfo('');    
  AddInfo('Статистика получасового опроса');

  AddInfo('');
  AddInfo('(1) резерв');
  AddInfo('(2) ошибки контрольной суммы');
  AddInfo('(3) ошибки в ответном пакете');
  AddInfo('(4) ошибки потока');
  AddInfo('(5) резерв');
  AddInfo('(6) резерв');

  s := PackStrR('',GetColWidth);
  for c := 1 to 6 do begin
    s := s + PackStrR('('+IntToStr(c)+')',GetColWidth);
  end;
  AddInfo(s);

  for c := 0 to CANALS-1 do if CanalChecked(c) then begin
    s := PackStrR('канал '+IntToStr(c+1),GetColWidth);
    s := s + PackStrR(IntToStr(mpeLinkErrorsZ[c]),GetColWidth);
    s := s + PackStrR(IntToStr(mpeLinkErrorsC[c]),GetColWidth);
    s := s + PackStrR(IntToStr(mpeLinkErrors0[c]),GetColWidth);
    s := s + PackStrR(IntToStr(mpeLinkErrors1[c]),GetColWidth);
    s := s + PackStrR(IntToStr(mpeLinkErrors2[c]),GetColWidth);
    s := s + PackStrR(IntToStr(mpeLinkErrors3[c]),GetColWidth);
    AddInfo(s);
  end;
    
  BoxRun;
end;

end.
