unit get_version2;

interface

procedure BoxGetVersion2;
procedure ShowGetVersion2;

implementation

uses SysUtils, soutput, support, box, kernel, timez, get_memory12, get_records;

const
  quGetVersion2:   querys = (Action: acGetVersion2; cwOut: 7+1; cwIn: 5+100+2; bNumber: $FF);

procedure QueryGetVersion2;
begin
  InitPushCRC;
  Push(53);
  Query(quGetVersion2);
end;

procedure BoxGetVersion2;
begin
  QueryGetVersion2;
end;

procedure ShowGetVersion2;
var
  i,j: byte;
  k:   word;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Расширенная версия');
  AddInfo('');
  i := Pop;
    AddInfo('ревизия:              ' + IntToStr(i));
  if i = 0 then begin
    j := Pop;

    if j = 4 then begin
      wPageSize := 528;
      wFreePageSize := 512;
    end
    else begin
      wPageSize := 1056;
      wFreePageSize := 1040;
    end;
    InitGetRecords(wFreePageSize);

    AddInfo('версия:               ' + IntToStr(j) +'.' + IntToStr(Pop) + '.' + IntToHex(PopInt,4));
    AddInfo('номер сборки:         ' + IntToStr(PopInt));
    AddInfo('дата сборки:          ' + PopTimes2Str);
    AddInfo('заводской номер:      ' + IntToStr(PopInt));
    AddInfo('логический номер:     ' + IntToStr(Pop));

    if (j > 2) then begin
      AddInfo('');
      AddInfo('количество каналов:   ' + IntToStr(Pop));
      AddInfo('количество групп:     ' + IntToStr(Pop));
      AddInfo('количество трехминут: ' + IntToStr(PopInt));
      k := PopInt;
      AddInfo('количество получасов: ' + IntToStr(k)+' ('+IntToStr(k div 48)+' суток)');
      AddInfo('количество суток:     ' + IntToStr(PopInt));
      AddInfo('количество месяцев:   ' + IntToStr(PopInt));
    end;
  end
  else
    AddInfo('неизвестная ревизия !');

  BoxGetMemory12;
end;

end.
