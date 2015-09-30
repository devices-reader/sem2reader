unit get_version;

interface

procedure BoxGetVersion;
procedure ShowGetVersion;

implementation

uses SysUtils, soutput, support, box;

const
  quGetVersion:   querys = (Action: acGetVersion; cwOut: 7+2; cwIn: 1073; bNumber: $F9);

procedure QueryGetVersion;
begin
  InitPushCRC;
  Push($FF);
  Push($FF);
  Query(quGetVersion);
end;

procedure BoxGetVersion;
begin
  QueryGetVersion;
end;

procedure ShowGetVersion;
begin
  Stop;

  InitPop(15);

  AddTerminal('');
  AddTerminal('Статистика');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при сигнале ''Занято''');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при сравнении');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при стирании страницы');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при чтении страницы');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при записи страницы');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при сравнении');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при стирании страницы');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при чтении страницы');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при записи страницы');

  InitPop(65);

  AddInfo('');
  AddInfo('Версия');
  AddInfo('контрольная сумма: '+IntToHex(PopInt,4));
  AddInfo('заводской номер:   '+IntToStr(PopInt));
  AddInfo('логический номер:  '+IntToStr(Pop));

  BoxRun;
end;

end.
