unit get_ace;

interface

procedure BoxGetAce;
procedure ShowGetAce;

implementation

uses SysUtils, soutput, support, box;

const
  quGetAce:   querys = (Action: acGetAce; cwOut: 7+1; cwIn: 5+13+18+2; bNumber: $FF);

procedure QueryGetAce;
begin
  InitPushCRC;
  Push(58);
  Query(quGetAce);
end;

procedure BoxGetAce;
begin
  QueryGetAce;
end;

procedure ShowGetAce;
var
  i:  byte;
begin
  Stop;
  InitPopCRC();

  AddInfo('');
  AddInfo('Контроллер');
  AddInfo(PackStrR('EXIF',GetColWidth)+PopBits2Str);
  
  AddInfo('');
  AddInfo('Порт 2');
  AddInfo(PackStrR('1',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('2',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('3',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('4',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('5',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('6',GetColWidth)+PopBits2Str);
  
  AddInfo('');
  AddInfo('Порт 4');
  AddInfo(PackStrR('1',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('2',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('3',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('4',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('5',GetColWidth)+PopBits2Str);
  AddInfo(PackStrR('6',GetColWidth)+PopBits2Str);

  AddInfo('');
  for i := 1 to 4 do AddInfo(PackStrR('порт ' +IntToStr(i),GetColWidth)+IntToStr(PopInt));

  BoxRun;
end;

end.
