unit get_defgrpmon2;

interface

uses kernel;

procedure BoxGetDefGrpMon2;
procedure ShowGetDefGrpMon2;

var
  mpDefGrpMon2:  array[0..GROUPS-1,0..MONTHS-1] of byte;
  
implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box, main, get_defcanhou;

const
  quGetDefGrpMon2: querys = (Action: acGetDefGrpMon2; cwOut: 7+6; cwIn: 15+GROUPS+2; bNumber: $FF);
                            
var
  bMon: byte;

procedure QueryGetDefGrpMon2;
begin
  InitPushCRC;
  Push(84);
  Push(bMon);
  if PushGrpMask then Query(quGetDefGrpMon2);
end;

procedure BoxGetDefGrpMon2;
begin
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetDefGrpMon2;
  end;
end;

procedure ShowGetDefGrpMon2;
var
  Grp,x:word;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Grp := 0 to GROUPS-1 do begin
    mpDefGrpMon2[Grp,bMon] := Pop;
  end;  

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetDefGrpMon2
  else begin
    AddInfo('');
    AddInfo(' ратка€ достоверность по группам за мес€ц');

    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2Strmon(monIndexToDate(DateTomonIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin 
      s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
      for x := ibMinMon to ibMaxMon do begin
        s := s + PackStrR(Bool2Str(mpDefGrpMon2[Grp,x]),GetColWidth);
      end;
      AddInfo(s);
    end;
    
    
    BoxRun;
  end;
end;

end.
