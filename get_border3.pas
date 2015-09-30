unit get_border3;

interface

uses kernel;

procedure BoxGetBorder3;
procedure ShowGetBorder3;

implementation

uses SysUtils, soutput, support, borders, progress, box;

const  
  quGetBorder3:   querys = (Action: acGetBorder3; cwOut: 7+1; cwIn: 5+64*2+2; bNumber: $FF);

procedure QueryGetBorder3;
begin
  InitPushCRC;
  Push(104);
  Query(quGetBorder3);
end;

procedure BoxGetBorder3;
begin
  AddInfo('');
  AddInfo('Границы опроса цифровых счетчиков 3');

  QueryGetBorder3;
end;

procedure ShowGetBorder3;
var
  Can:  word;
  a:    word;
  s:    string;
begin
  Stop;
  InitPopCRC;

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    a := PopInt;
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(IntToStr(a),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

end.
