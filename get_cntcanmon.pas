unit get_cntcanmon;

interface

procedure BoxGetCntCanMon;
procedure ShowGetCntCanMon;

implementation

uses SysUtils, borders, soutput, kernel, support, progress, realz, box, get_extended44, get_extended6;

const
  quGetCntCanMon: querys = (Action: acGetCntCanMon; 
                            cwOut: 7+3;   
                            cwIn: 15+5+2;   
                            bNumber: $FF;
                            fLong: true);

var
  bCan,                            
  bMon:   byte;
                            
procedure QueryGetCntCanMon;
begin
  InitPushCRC;
  Push(37);
  Push(bCan);
  Push(bMon);
  Query(quGetCntCanMon);
end;
                            
procedure BoxGetCntCanMon;
begin
  if TestCanals and TestMonths then begin    
    AddInfo('');    
    AddInfo('«начени€ счетчиков по мес€цам (мгновенные)');

    if IsChecked(Ord(acGetExt44)) and IsChecked(Ord(acGetExt6)) then begin end
    else if IsChecked(Ord(acGetExt44)) then AddInfo('*по сравнению с значени€ми счетчиков по мес€цам (из буфера с дозапросом)')
    else if IsChecked(Ord(acGetExt6)) then AddInfo('*по сравнению с значени€ми счетчиков по мес€цам (из буфера пр€мого опроса)');
    
    AddInfo('');

    bCan := MinCan;
    bMon := ibMinMon;

    QueryGetCntCanMon;
  end;
end;

procedure ShowGetCntCanMon;
var
  x:  word;
  e,c:  extended;
  s:  string;
begin
  Stop;
  InitPop(15);

  x := Pop;
  e := PopReals;
  s := PackStrR('канал: '+IntToStr(bCan+1)+ ', мес€ц '+IntToStr(bMon+1) + ' (' +LongMonthNames[bMon+1]+')',35);

  case x of 
    0: s := s + Reals2Str(e);
    1: s := s + 'канал: нет ответа';
    2: s := s + 'канал запрещен';
    3: s := s + 'модемный канал';
    else s := s + 'код ' + IntToStr(x);      
  end;    
  
  if IsChecked(Ord(acGetExt44)) and IsChecked(Ord(acGetExt6)) then begin end
  else if IsChecked(Ord(acGetExt44)) then begin
    c := mpValue44[bMon,bCan].eValue;
    s := s + PackStrR('',GetColWidth) + PackStrR(Reals2StrR(c),GetColWidth);
    if c <> 0 then s := s + Reals2Str(100*(e-c)/c) + ' %' else s := s + '?';
  end
  else if IsChecked(Ord(acGetExt6)) then begin
    c := mpValue6[bMon,bCan].eValue;
    s := s + PackStrR('',GetColWidth) + PackStrR(Reals2StrR(c),GetColWidth);
    if c <> 0 then s := s + Reals2Str(100*(e-c)/c) + ' %' else s := s + '?';
  end;
  
  AddInfo(s);
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetCntCanMon
  else begin
    AddInfo(' ');
    bMon := ibMinMon;
    
    Inc(bCan);
    while (bCan <= MaxCan) and (not CanalChecked(bCan)) do begin
      Inc(bCan);
      if bCan >= MaxCan then break;
    end;
  
    if bCan <= MaxCan then
      QueryGetCntCanMon
    else 
      RunBox;
  end;
end;

end.
 