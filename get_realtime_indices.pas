unit get_realtime_indices;

interface

procedure BoxGetRealtimeIndices;
procedure ShowGetRealtimeIndices;

implementation

uses SysUtils, Classes, soutput, support, box, progress, timez, calendar2, get_start;

const
  quGetRealtimeIndices: querys = (Action: acGetRealtimeIndices; cwOut: 9; cwIn: 5 + 1+2+2 + 8*48*1{4} + 2; bNumber: 252);

var
  bDay: byte;

procedure QueryGetRealtimeIndices;
begin
  InitPushCRC;
  Push(40);
  Push(bDay);
  Query(quGetRealtimeIndices);
end;

procedure BoxGetRealtimeIndices;
begin
  bDay := 0;
  QueryGetRealtimeIndices;
end;

procedure ShowGetRealtimeIndices;
var
  i,j: word;
  days: byte;
  current,total: word;
  dw1,dw2: longword;
  tm: times;
  sh: byte;
  hh: word;
  sd: byte;
  hd: byte;
  sm: byte;
  hm: byte;
  s: string;
  sl: TStringList;
begin
  Stop;
  InitPopCRC;

  if bDay = 0 then begin
    AddInfo('');
    AddInfo('*Журнал календарных индексов');
  end;

  days := Pop;
  current := PopIntLtl;
  total := PopIntLtl;

  if bDay = 0 then begin
    AddInfo('Количество: '+IntToStr(current)+'/'+IntToStr(total));
    AddInfo('');
  end;

  sl := TStringList.Create;

  for i := 0 to 48-1 do begin
    j := i + 48*bDay;
    s := IntToStr(j) + ' ';
    if j = current then s := s + '*' else s := s + ' ';

    dw1 := PopLongLtl;

    with tm do begin
      bSecond := $3F and (dw1);
      bMinute := $3F and (dw1 shr 6);
      bHour   := $1F and (dw1 shr (6+6));

      bDay    := $1F and (dw1 shr (6+6+5));
      bMonth  := $0F and (dw1 shr (6+6+5+5));
      bYear   := ($3F and (dw1 shr (6+6+5+5+4))) + 20;
    end;

    dw2 := PopLongLtl;

    sh := $03 and (dw2);
    hh := $FFF and (dw2 shr 2);

    sd := $03 and (dw2 shr (2+12));
    hd := $1F and (dw2 shr (2+12+2));

    sm := $03 and (dw2 shr (2+12+2+5));
    hm := $1F and (dw2 shr (2+12+2+5+2));

    if ((dw1 <> 0) and (dw2 <> 0)) then
      sl.Add(PackStrR(s,GetColWidth)
        + PackStrR(Times2Str(tm),GetColWidth*2)

        + PackStrR(IntToStr(sh),3)
        + PackStrR(IntToStr(hh),GetColWidth)

        + PackStrR(IntToStr(sd),3)
        + PackStrR(IntToStr(hd),GetColWidth)

        + PackStrR(IntToStr(sm),3)
        + PackStrR(IntToStr(hm),GetColWidth)
      );
  end;

  if (sl.count > 0) then
    AddInfoAll(sl);

  ShowProgress(bDay, days+1);

  Inc(bDay);
  if bDay < days then
    QueryGetRealtimeIndices
  else begin
    BoxRun;
  end;
end;

end.
