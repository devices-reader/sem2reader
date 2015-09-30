unit get_defcanmon2;

interface

uses kernel;

procedure BoxGetDefCanMon2;
procedure ShowGetDefCanMon2;

var
  mpDefCanMon2:  array[0..CANALS-1,0..MONTHS-1] of byte;

implementation

uses SysUtils, soutput, borders, progress, support, realz, box, timez, calendar, main, get_defcanhou;


const
  quGetDefCanMon2: querys = (Action: acGetDefCanMon2; cwOut: 7+10; cwIn: 15+CANALS+2; bNumber: $FF);

var
  bMon:   byte;
  
procedure QueryGetDefCanMon2;
begin
  InitPushCRC;
  Push(82);
  Push(bMon);
  if PushCanMask then Query(quGetDefCanMon2);
end;

procedure BoxGetDefCanMon2;
begin  
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetDefCanMon2;
  end;
end;

procedure ShowGetDefCanMon2;
var
  Can,x:word;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do begin
    mpDefCanMon2[Can,bMon] := Pop;
  end;

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);

  Inc(bMon);
  if bMon <= ibMaxMon then
    QueryGetDefCanMon2
  else begin

    AddInfo('');
    AddInfo(' ратка€ достоверность по каналам за мес€ц');

    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
      for x := ibMinMon to ibMaxMon do begin
        s := s + PackStrR(Bool2Str(mpDefCanMon2[Can,x]),GetColWidth);
      end;
      AddInfo(s);
    end;


    BoxRun;
  end;
end;

end.
