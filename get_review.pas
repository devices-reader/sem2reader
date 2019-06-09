unit get_review;

interface

procedure BoxGetReview;
procedure ShowGetReview;

implementation

uses SysUtils, soutput, support, box, kernel, timez, get_memory12, get_records;

const
  quGetReview:   querys = (Action: acGetReview; cwOut: 7+1; cwIn: 146; bNumber: 252);

procedure QueryGetReview;
begin
  InitPushCRC;
  Push(25);
  Query(quGetReview);
end;

procedure BoxGetReview;
begin
  TestVersion4;
  QueryGetReview;
end;

procedure ShowGetReview;
var
  i,c: byte;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Статистика проверки при чтении профилей');
  AddInfo('');
  i := Pop;
    AddInfo('ревизия:                            ' + IntToStr(i));

    if i = 0 then begin
      AddInfo('');
      AddInfo('флаг проверки:                      ' + PopBool2Str);
      AddInfo('чтение логических номеров:          ' + PopBool2Str);
      AddInfo('количество повторов:                ' + IntToStr(Pop));
      AddInfo('проверочное количество повторов:    ' + IntToStr(Pop));
      AddInfo('максимальное количество повторов:   ' + IntToStr(Pop));
      AddInfo('максимальный % отклонения значений: ' + IntToStr(PopInt));
      AddInfo('максимальные значения:              ' + IntToStr(PopInt));

      AddInfo('');
      AddInfo('используемые каналы');
      for c := 0 to CANALS-1 do
        AddInfo(PackStrR('канал '+IntToStr(c+1),GetColWidth) + PopBool2Str);

      AddInfo('');
      AddInfo('REPEAT:                             ' + IntToStr(PopInt));
      AddInfo('ID_REPEAT:                          ' + IntToStr(PopInt));
      AddInfo('SUCCESS:                            ' + IntToStr(PopInt));
      AddInfo('ERROR:                              ' + IntToStr(PopInt));
      AddInfo('счетчик 5:                          ' + IntToStr(PopInt));
      AddInfo('счетчик 6:                          ' + IntToStr(PopInt));
      AddInfo('счетчик 7:                          ' + IntToStr(PopInt));
      AddInfo('счетчик 8:                          ' + IntToStr(PopInt));
      AddInfo('счетчик 9:                          ' + IntToStr(PopInt));
      AddInfo('счетчик 10:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 11:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 12:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 13:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 14:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 15:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 16:                         ' + IntToStr(PopInt));

      AddInfo('');
      AddInfo('WRN_OK:                             ' + IntToStr(PopInt));
      AddInfo('WRN_ZERO:                           ' + IntToStr(PopInt));
      AddInfo('WRN_REPEAT:                         ' + IntToStr(PopInt));
      AddInfo('WRN_TOP:                            ' + IntToStr(PopInt));
      AddInfo('WRN_TREND_TOP:                      ' + IntToStr(PopInt));
      AddInfo('WRN_TREND_BOTTOM:                   ' + IntToStr(PopInt));
      AddInfo('счетчик 7:                          ' + IntToStr(PopInt));
      AddInfo('счетчик 8:                          ' + IntToStr(PopInt));
      AddInfo('счетчик 9:                          ' + IntToStr(PopInt));
      AddInfo('счетчик 10:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 11:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 12:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 13:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 14:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 15:                         ' + IntToStr(PopInt));
      AddInfo('счетчик 16:                         ' + IntToStr(PopInt));

      AddInfo('');
      AddInfo('флаг чтения профилей СС-301 х1/x6:  ' + PopBool2Str);
    end
    else
      AddInfo('неизвестная ревизия !');

  BoxRun;
end;

end.
