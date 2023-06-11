unit get_device23;

interface

uses kernel;

procedure BoxGetDevice23;
procedure ShowGetDevice23;

var
  mpcwErrors1,
  mpcwErrors2,
  mpcwErrors3:     array[0..CANALS-1] of word;

implementation

uses SysUtils, soutput, support, borders, box;

const
  quGetDevice23:   querys = (Action: acGetDevice23; cwOut: 7+1; cwIn: 5+2+3*2*64+2; bNumber: $FF);

procedure QueryGetDevice23;
begin
  InitPushCRC;
  Push(102);
  Query(quGetDevice23);
end;

procedure BoxGetDevice23;
begin
  if TestCanals then
    QueryGetDevice23;
end;
                          
procedure ShowGetDevice23;
var
  a,b:  byte;
  Can:  word;
  s:    string;
begin
  Stop;

  InitPopCRC;
  
  a := Pop;
  b := Pop;
  for Can := 0 to CANALS-1 do mpcwErrors1[Can] := PopIntBig;
  for Can := 0 to CANALS-1 do mpcwErrors2[Can] := PopIntBig;
  for Can := 0 to CANALS-1 do mpcwErrors3[Can] := PopIntBig;

  AddInfo('');
  AddInfo('Cтатистика РСВУ-1400');
  AddInfo('счетчики: '+IntToStr(a)+'-'+IntToStr(b));  
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(IntToStr(mpcwErrors1[Can]),GetColWidth);
    s := s + PackStrR(IntToStr(mpcwErrors2[Can]),GetColWidth);
    s := s + PackStrR(IntToStr(mpcwErrors3[Can]),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
