unit get_canal_spec;

interface

uses kernel;

procedure BoxGetTransEng_;
procedure BoxGetTransCnt_;
procedure BoxGetPulseHou_;
procedure BoxGetPulseMnt_;
procedure BoxGetValueEngHou_;
procedure BoxGetValueCntHou_;
procedure BoxGetValueEngMnt_;
procedure BoxGetValueCntMnt_;
procedure BoxGetCount_;
procedure BoxGetLosse_;
procedure BoxGetLevel_;
procedure ShowGetCanalsSpec;

implementation

uses SysUtils, soutput, support, progress, box, borders, realz;

const  
  quGetTransEng:    querys = (Action: acGetTransEng_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 30);
  quGetTransCnt:    querys = (Action: acGetTransCnt_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 32);
  quGetPulseHou:    querys = (Action: acGetPulseHou_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 34);
  quGetPulseMnt:    querys = (Action: acGetPulseMnt_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 234);
  
  quGetValueEngHou: querys = (Action: acGetValueEngHou_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 36);
  quGetValueCntHou: querys = (Action: acGetValueCntHou_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 37);
  quGetValueEngMnt: querys = (Action: acGetValueEngMnt_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 236);
  quGetValueCntMnt: querys = (Action: acGetValueCntMnt_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 237);

  quGetCount:       querys = (Action: acGetCount_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 38);
  quGetLosse:       querys = (Action: acGetLosse_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 40);
  quGetLevel:       querys = (Action: acGetLevel_; cwOut: 7; cwIn: 7+4*CANALS;  bNumber: 180);
    
procedure BoxGetTransEng_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты трансформации (для энергии)');
  Query(quGetTransEng);
end;

procedure BoxGetTransCnt_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты трансформации (для счетчиков)');    
  Query(quGetTransCnt);
end;

procedure BoxGetPulseHou_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты преобразования (для получасов)');    
  Query(quGetPulseHou);
end;

procedure BoxGetPulseMnt_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты преобразования (для трехминут)');    
  Query(quGetPulseMnt);
end;

procedure BoxGetValueEngHou_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты эквивалентности EH');    
  Query(quGetValueEngHou);
end;

procedure BoxGetValueCntHou_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты эквивалентности CH');    
  Query(quGetValueCntHou);
end;

procedure BoxGetValueEngMnt_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты эквивалентности EM');    
  Query(quGetValueEngMnt);
end;

procedure BoxGetValueCntMnt_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты эквивалентности CM');    
  Query(quGetValueCntMnt);
end;

procedure BoxGetCount_;
begin
  AddInfo('');    
  AddInfo('*Начальные показания счетчиков');    
  Query(quGetCount);
end;

procedure BoxGetLosse_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты потерь');    
  Query(quGetLosse);
end;

procedure BoxGetLevel_;
begin
  AddInfo('');    
  AddInfo('*Коэффициенты отношения');    
  Query(quGetLevel);
end;

procedure ShowGetCanalsSpec;
var
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(5);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + Reals2Str(PopReals);
    AddInfo(s);
  end;

  RunBox;
end;

end.
