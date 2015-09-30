unit get_params;

interface

procedure BoxGetParams;
procedure ShowGetParams;

implementation

uses SysUtils, kernel, soutput, support, borders, progress, get_digit, timez, realz, box;

const
  quGetParams:    querys = (Action: acGetParams;    
                            cwOut: 7+1;   
                            cwIn: 129;      
                            bNumber: 52;
                            fLong: true);

var
  bCan:      byte;  
  
procedure QueryGetParams;
begin  
  InitPushCRC;
  Push(bCan);
  Query(quGetParams);
end;

procedure BoxGetParams;
begin  
  if TestCanals then begin
    AddInfo('');    
    AddInfo('Мгновенные параметры');
  
    bCan := MinCan;
    QueryGetParams;
  end;
end;

procedure ShowGetParams;
var
  x,y:  word;
  s,z:  string;
begin
  Stop;
  InitPopCRC;

  with mpDigits[bCan] do begin
    AddInfo('');
    s := PackStrR('Канал '+IntToStr(bCan+1)+':',GetColWidth);    
    s := s + Int2Str(ibPort+1)+'.'+
             Int2Str(ibPhone)+'.'+
             Int2Str(bDevice)+'.'+
             Int2Str(bAddress,3)+'.'+
             Int2Str(ibLine+1)+'  '+GetDeviceName(bDevice);
    AddInfo(s);          
  end;
    
  AddInfo('Время опроса: '+PopTimes2Str);

  s := '';
  for x := 0 to 4 do begin
    case x of
      0: z := '';
      1: z := 'всего';
      2: z := 'фаза 1';
      3: z := 'фаза 2';
      4: z := 'фаза 3';
      else z := '?';
    end;      
    s := s + PackStrR(z,GetColWidth);
  end;
  AddInfo(s);
    
  for y := 1 to 7 do begin
    case y of
      1: s := 'P, Вт';
      2: s := 'Q, ВАР';
      3: s := 'S, ВА';
      4: s := 'U, В';
      5: s := 'I, мА';
      6: s := 'cos Ф';
      7: s := 'f, Гц';
      else s := '?';
    end;
    s := PackStrR(s,GetColWidth);
      
    for x := 1 to 4 do s := s + Reals2StrR(PopReals);
    AddInfo(s);
  end;
          
  ShowProgress(bCan-MinCan, MaxCan-MinCan+1);  

  if bCan < MaxCan then begin
    Inc(bCan);

    while (bCan <= MaxCan) and (not CanalChecked(bCan)) do begin
      Inc(bCan);
      if bCan >= MaxCan then break;
    end;

    while not mpDigits[bCan].boActive do begin
      Inc(bCan);
      if bCan >= MaxCan then break;
    end;
      
    if bCan < MaxCan then 
      QueryGetParams
    else 
      RunBox;  
  end
  else RunBox;
end;

end.
