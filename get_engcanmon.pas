unit get_engcanmon;

interface

uses kernel;

procedure BoxGetEngCanMon;
procedure ShowGetEngCanMOn;

implementation

uses SysUtils, soutput, support, borders, progress, realz, box, timez, calendar;

const
  quGetEngCanMon: querys = (Action: acGetEngCanMon; cwOut: 7+10; cwIn: 0; bNumber: $FF);

var
  mpEngCanMon:  array[0..CANALS-1,0..MONTHS-1,0..TARIFFS-1] of extended;
  
var
  bMon:   byte;

procedure QueryGetEngCanMon;
begin
  InitPushCRC;
  Push(66);
  Push(bMon);
  if PushCanMask then Query(quGetEngCanMon);
end;

procedure BoxGetEngCanMon;
begin
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetEngCanMon;
  end;  
end;

procedure ShowGetEngCanMon;
var
  Can,Tar,x:  word;
  e:  extended;
  s:  string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then   
    for Tar := 0 to TARIFFS-1 do mpEngCanMon[Can,bMon,Tar] := PopReals;

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetEngCanMon
  else begin
    AddInfo('');
    AddInfo('Ёнерги€ по каналам за мес€ц');

    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);    
    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
      for x := ibMinMon to ibMaxMon do begin
        e := 0;
        for Tar := 0 to TARIFFS-1 do e := e + mpEngCanMon[Can,x,Tar];
        s := s + Reals2StrR(e);
      end;
      AddInfo(s);

      for Tar := 0 to TARIFFS-1 do begin
        s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
        for x := ibMinMon to ibMaxMon do s := s + PackStrR(Reals2StrR(mpEngCanMon[Can,x,Tar]),GetColWidth);
        AddInfo(s);      
      end;            
    end;
    
    BoxRun;
  end;
end;

end. 
