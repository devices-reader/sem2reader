unit get_queryCF;

interface

procedure BoxGetQueryCF;
procedure ShowGetQueryCF;

implementation

uses SysUtils, soutput, support, realz, borders, kernel, box;

var
  mpeT: array[0..CANALS-1] of extended;

const
  quGetQueryCF:   querys = (Action: acGetQueryCF; cwOut: 7; cwIn: 15+4*64+2; bNumber: $CF);

procedure QueryGetQueryCF;
begin
  Query(quGetQueryCF);
end;

procedure BoxGetQueryCF;
begin
   QueryGetQueryCF;
end;
                          
procedure ShowGetQueryCF;
var
  Can:  byte;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do
    mpeT[Can] := PopReals;
  
  AddInfo('');
  AddInfo('Запрос 0xCF (значения счётчиков из буфера)');
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    AddInfo(PackStrR('канал '+IntToStr(Can+1),GetColWidth)+Reals2StrR(mpeT[Can]));

  BoxRun;    
end;

end.
