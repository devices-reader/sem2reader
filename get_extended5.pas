unit get_extended5;

interface

uses kernel;

procedure BoxGetExt50;
procedure ShowGetExt50;

procedure BoxGetExt51;
procedure ShowGetExt51;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress;

const
  quGetExt50: querys = (Action: acGetExt50; cwOut: 7+9; cwIn: 0; bNumber: $FF);
  quGetExt51: querys = (Action: acGetExt51; cwOut: 7+9; cwIn: 0; bNumber: $FF);
  
procedure QueryGetExt50;
begin
  InitPushCRC;
  Push(49);
  if PushCanMask then Query(quGetExt50);
end;

procedure QueryGetExt51;
begin
  InitPushCRC;
  Push(50);
  if PushCanMask then Query(quGetExt51);
end;

procedure BoxGetExt50;
begin
  AddInfo('');
  AddInfo('Значения счетчиков текущие по тарифам 1');
  QueryGetExt50;
end;

procedure BoxGetExt51;
begin
  AddInfo('');
  AddInfo('Значения счетчиков текущие по тарифам 2');
  QueryGetExt51;
end;
                          
procedure ShowGetExt50;
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
    for i := 1 to 4 do s := s + PackStrR(Reals2StrR(PopReals),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(PopBool2Str,GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig)+' - '+IntToStr(PopIntBig),GetColWidth);
    AddInfo(s);
  end;
  
  RunBox;
end;

procedure ShowGetExt51;
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
    for i := 1 to 4 do s := s + PackStrR(Reals2StrR(PopReals),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth);
    AddInfo(s);
  end;
  
  RunBox;
end;

end.
