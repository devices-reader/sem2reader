unit get_trans_eng;

interface

uses kernel;

procedure BoxGetTransEng;
procedure ShowGetTransEng;

var
  mpeTransEng:     array[0..CANALS-1] of extended;

implementation

uses SysUtils, soutput, support, realz, borders, box;

const
  quGetTransEng:   querys = (Action: acGetTransEng; cwOut: 7; cwIn: 5+4*64+2; bNumber: 30);

procedure QueryGetTransEng;
begin
  Query(quGetTransEng);
end;

procedure BoxGetTransEng;
begin
  if TestCanals then
    QueryGetTransEng;
end;
                          
procedure ShowGetTransEng;
var
  Can:  word;
begin
  Stop;

  InitPopCRC;
  for Can := 0 to CANALS-1 do mpeTransEng[Can] := PopReals;

  AddInfo('');
  AddInfo('К. трансформации для энергии');
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    AddInfo(PackStrR('канал '+IntToStr(Can+1),GetColWidth)+Reals2StrR(mpeTransEng[Can]));
    
  BoxRun;
end;

end.
