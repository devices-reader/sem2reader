unit get_groups;

interface

procedure BoxGetGroups;
procedure ShowGetGroups;

implementation

uses SysUtils, soutput, support, kernel, borders, progress, box;

const
  quGetGroups:  querys = (Action: acGetGroups; cwOut: 7+5; cwIn: 0; bNumber: $FF);

var  
  mpgrGroups:   array[0..GROUPS] of group;

procedure QueryGetGroups;
begin
  InitPushCRC;
  Push(7);
  if PushGrpMask then Query(quGetGroups);
end;
  
procedure BoxGetGroups;
begin
  if TestGroups then
    QueryGetGroups;
end;

procedure ShowGetGroups;
var
  Can,Grp:  word;
  s:  string; 
begin 
  Stop;
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then 
    with mpgrGroups[Grp] do begin
      bSize := Pop;
      for Can := 0 to CANALS-1 do mpnoNodes[Can].ibCanal := Pop;
    end;

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then with mpgrGroups[Grp] do begin
    s := PackStrR('группа '+IntToStr(Grp+1),GetColWidth);
    if (bSize = 0) then
      s := s + 'нет'
    else for Can := 0 to bSize-1 do with mpnoNodes[Can] do begin
      if (ibCanal and $80) = 0 then
        s := s + '+' + IntToStr(ibCanal+1)
      else
        s := s + '-' + IntToStr((ibCanal and $7F)+1);
    end;
    AddInfo(s);
  end;      
  
  BoxRun;
end;

end.
