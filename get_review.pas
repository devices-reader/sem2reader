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
      AddInfo('максимальный % отклонения значений: ' + IntToStr(PopIntBig));
      AddInfo('максимальные значения:              ' + IntToStr(PopIntBig));

      AddInfo('');
      AddInfo('используемые каналы');
      for c := 0 to CANALS-1 do
        AddInfo(PackStrR('канал '+IntToStr(c+1),GetColWidth) + PopBool2Str);

      AddInfo('');
      AddInfo('REPEAT:                             ' + IntToStr(PopIntBig));
      AddInfo('ID_REPEAT:                          ' + IntToStr(PopIntBig));
      AddInfo('SUCCESS:                            ' + IntToStr(PopIntBig));
      AddInfo('ERROR:                              ' + IntToStr(PopIntBig));
      AddInfo('счетчик 5:                          ' + IntToStr(PopIntBig));
      AddInfo('счетчик 6:                          ' + IntToStr(PopIntBig));
      AddInfo('счетчик 7:                          ' + IntToStr(PopIntBig));
      AddInfo('счетчик 8:                          ' + IntToStr(PopIntBig));
      AddInfo('счетчик 9:                          ' + IntToStr(PopIntBig));
      AddInfo('счетчик 10:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 11:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 12:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 13:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 14:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 15:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 16:                         ' + IntToStr(PopIntBig));

      AddInfo('');
      AddInfo('WRN_OK:                             ' + IntToStr(PopIntBig));
      AddInfo('WRN_ZERO:                           ' + IntToStr(PopIntBig));
      AddInfo('WRN_REPEAT:                         ' + IntToStr(PopIntBig));
      AddInfo('WRN_TOP:                            ' + IntToStr(PopIntBig));
      AddInfo('WRN_TREND_TOP:                      ' + IntToStr(PopIntBig));
      AddInfo('WRN_TREND_BOTTOM:                   ' + IntToStr(PopIntBig));
      AddInfo('счетчик 7:                          ' + IntToStr(PopIntBig));
      AddInfo('счетчик 8:                          ' + IntToStr(PopIntBig));
      AddInfo('счетчик 9:                          ' + IntToStr(PopIntBig));
      AddInfo('счетчик 10:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 11:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 12:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 13:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 14:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 15:                         ' + IntToStr(PopIntBig));
      AddInfo('счетчик 16:                         ' + IntToStr(PopIntBig));

      AddInfo('');
      AddInfo('флаг чтения профилей СС-301 х1/x6:  ' + PopBool2Str);
    end
    else
      AddInfo('неизвестная ревизия !');

  BoxRun;
end;

end.
