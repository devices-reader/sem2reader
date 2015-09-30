unit get_hou_check;

interface

uses kernel;

procedure BoxGetHouCheck;
procedure ShowGetHouCheck;

implementation

uses SysUtils, soutput, support, progress, box, borders;

const  
  quGetHouCheck:   querys = (Action: acGetHouCheck; cwOut: 7+9; cwIn: 5+64+2; bNumber: $FF);

procedure QueryGetHouCheck;
begin
  InitPushCRC;
  Push(71);
  Query(quGetHouCheck);
end;

procedure BoxGetHouCheck;
begin
  AddInfo('');
  AddInfo('Количество повторов при опросе цифровых счетчиков');

  QueryGetHouCheck;
end;

procedure ShowGetHouCheck;
var
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(5);

  for Can := 0 to CANALS-1 do begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + IntToStr(Pop);
    AddInfo(s);
  end;

  RunBox;
end;

end. 
