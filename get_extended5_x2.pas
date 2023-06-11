unit get_extended5_x2;

interface

uses kernel;

procedure BoxGetExt50X2;
procedure ShowGetExt50X2;

procedure BoxGetExt51X2;
procedure ShowGetExt51X2;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress;

const
  quGetExt50X2: querys = (Action: acGetExt50X2; cwOut: 7+9; cwIn: 0; bNumber: $FF-2);
  quGetExt51X2: querys = (Action: acGetExt51X2; cwOut: 7+9; cwIn: 0; bNumber: $FF-2);
  
procedure QueryGetExt50X2;
begin
  InitPushCRC;
  Push(49);
  if PushCanMask then Query(quGetExt50X2);
end;

procedure QueryGetExt51X2;
begin
  InitPushCRC;
  Push(50);
  if PushCanMask then Query(quGetExt51X2);
end;

procedure BoxGetExt50X2;
begin
  TestVersion4;

  AddInfo('');
  AddInfo('Значения счетчиков текущие по тарифам 1 (двойная точность)');
  QueryGetExt50X2;
end;

procedure BoxGetExt51X2;
begin
  TestVersion4;

  AddInfo('');
  AddInfo('Значения счетчиков текущие по тарифам 2 (двойная точность)');
  QueryGetExt51X2;
end;
                          
procedure ShowGetExt50X2;
var
  i:    byte;
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(15);
  AddInfo('Признак включения режима: '+PopBool2Str);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
    for i := 1 to 4 do s := s + PackStrR(Double2StrR(PopDouble),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(PopBool2Str,GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig)+' - '+IntToStr(PopIntBig),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

procedure ShowGetExt51X2;
var
  i:    byte;
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(15);
  AddInfo('Признак включения режима: '+PopBool2Str);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
    for i := 1 to 4 do s := s + PackStrR(Double2StrR(PopDouble),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth);
    AddInfo(s);
  end;
  
  RunBox;
end;

end.
