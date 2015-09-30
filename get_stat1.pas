unit get_stat1;

interface

procedure BoxGetStat1;
procedure ShowGetStat1;

implementation

uses SysUtils, Classes, soutput, support, progress, box, kernel;

const
  quGetStat1: querys = (Action: acGetStat1; cwOut: 5+3+2; cwIn: 5+2*500+2; bNumber: $FF);

const
  MAX_BLOCK = 16+1;
  PAGES     = 8192;

var
  ibBlock:  byte;
  mpbStat1: array[0..PAGES-1] of word;

  mpbPage:  array[0..PAGES-1] of word;
  mpbValue: array[0..PAGES-1] of word;

procedure QueryGetStat1;
begin
  AddInfo('');
//  AddInfo('#'+IntToStr(ibBlock));

  InitPushCRC;
  Push(250);
  Push(ibBlock);
  Query(quGetStat1);
end;

procedure BoxGetStat1;
var
  i:  word;
begin
  AddInfo('');
  AddInfo('*Cтатистика использовани€ пам€ти 1');

  for i := 0 to PAGES-1 do begin
    mpbPage[i] := 0;
    mpbValue[i] := 0;
  end;

  ibBlock := 0;
  QueryGetStat1;
end;

procedure ShowGetStat1;
var
  p,w:  word;
  i,j:  word;
  s,z:  string;
  l:    TStringList;
begin
  Stop;
  InitPop(5);

  l := TStringList.Create;
  s := PackStrR(IntToStr(ibBlock*500), GetColWidth);
  for i := 0 to 500-1 do begin
    j := PopInt;
    if (ibBlock*500+i < PAGES) then mpbStat1[ibBlock*500+i] := j;

    if (j = $FFFF) then z := '-' else z := IntToStr(j);
    s := s + PackStrR(z, 6);
    if (i mod 10 = 10-1) then begin
      l.add(s);
      s := PackStrR(IntToStr(ibBlock*500+i+1), GetColWidth);
    end;
  end;
  //AddInfo(s);
  AddInfoAll(l);

  ShowProgress(ibBlock, MAX_BLOCK+1);

  Inc(ibBlock);
  if ibBlock < MAX_BLOCK then
    QueryGetStat1
  else begin
    for i := 0 to PAGES-1 do begin
      mpbPage[i] := i;
      mpbValue[i] := mpbStat1[i];
    end;

    for i := 0 to PAGES-1 do begin
      for j := 0 to PAGES-1 do begin
        if (mpbValue[j] < mpbValue[i]) then begin
          p := mpbPage[i];
          w := mpbValue[i];
          mpbPage[i] := mpbPage[j];
          mpbValue[i] := mpbValue[j];
          mpbPage[j] := p;
          mpbValue[j] := w;
        end;
      end;
    end;

    l := TStringList.Create;
    l.add('');
    l.add('—писок наиболее используемых страниц (количество/страница)');
    for i := 0 to PAGES-1 do begin
      if (mpbValue[i] > 1) then
      l.add(PackStrR(IntToStr(mpbValue[i]), GetColWidth) + IntToStr(mpbPage[i]));
    end;
    AddInfoAll(l);

    BoxRun;
  end;

end;

end.
