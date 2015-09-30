unit get_group;

interface

uses kernel;

procedure BoxGetGroup;
procedure ShowGetGroup;

var
  mpgrGroups: array[0..GROUPS] of group;

implementation

uses SysUtils, soutput, support, borders, progress, box;

const
  quGetGroup:     querys = (Action:
                            acGetGroup;
                            cwOut: 7+1;
                            cwIn: 8+64;
                            bNumber: 9);

var
  bGrp:       byte;

procedure QueryGetGroup;
begin
  InitPushCRC;
  Push(bGrp);
  if PushGrpMask then Query(quGetGroup);
end;
  
procedure BoxGetGroup;
begin
  if TestGroups then begin
    AddInfo('');    
    AddInfo('Группы');

    bGrp := MinGrp;
    QueryGetGroup;
  end;
end;

procedure ShowGetGroup;
var
  Can,Grp:  word;
  s:  string; 
begin 
  Stop;
  InitPopCRC;

  with mpgrGroups[bGrp] do begin
    bSize := Pop;
    for Can := 0 to CANALS-1 do mpnoNodes[Can].ibCanal := Pop;
  end;

  ShowProgress(bGrp-MinGrp, MaxGrp-MinGrp+1);  
  
  Inc(bGrp);
  while (bGrp <= MaxGrp) and (not GroupChecked(bGrp)) do begin
    Inc(bGrp);
    if bGrp >= MaxGrp then break;
  end;
  
  if bGrp <= MaxGrp then begin
    QueryGetGroup;
  end  
  else begin
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
    
    RunBox;
  end;
end;

end.
