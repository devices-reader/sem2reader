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
  AddInfo('���������� �������� ��� ������ ��������');
  AddInfo('');
  i := Pop;
    AddInfo('�������:                            ' + IntToStr(i));

    if i = 0 then begin
      AddInfo('');
      AddInfo('���� ��������:                      ' + PopBool2Str);
      AddInfo('������ ���������� �������:          ' + PopBool2Str);
      AddInfo('���������� ��������:                ' + IntToStr(Pop));
      AddInfo('����������� ���������� ��������:    ' + IntToStr(Pop));
      AddInfo('������������ ���������� ��������:   ' + IntToStr(Pop));
      AddInfo('������������ % ���������� ��������: ' + IntToStr(PopInt));
      AddInfo('������������ ��������:              ' + IntToStr(PopInt));

      AddInfo('');
      AddInfo('������������ ������');
      for c := 0 to CANALS-1 do
        AddInfo(PackStrR('����� '+IntToStr(c+1),GetColWidth) + PopBool2Str);

      AddInfo('');
      AddInfo('REPEAT:                             ' + IntToStr(PopInt));
      AddInfo('ID_REPEAT:                          ' + IntToStr(PopInt));
      AddInfo('SUCCESS:                            ' + IntToStr(PopInt));
      AddInfo('ERROR:                              ' + IntToStr(PopInt));
      AddInfo('������� 5:                          ' + IntToStr(PopInt));
      AddInfo('������� 6:                          ' + IntToStr(PopInt));
      AddInfo('������� 7:                          ' + IntToStr(PopInt));
      AddInfo('������� 8:                          ' + IntToStr(PopInt));
      AddInfo('������� 9:                          ' + IntToStr(PopInt));
      AddInfo('������� 10:                         ' + IntToStr(PopInt));
      AddInfo('������� 11:                         ' + IntToStr(PopInt));
      AddInfo('������� 12:                         ' + IntToStr(PopInt));
      AddInfo('������� 13:                         ' + IntToStr(PopInt));
      AddInfo('������� 14:                         ' + IntToStr(PopInt));
      AddInfo('������� 15:                         ' + IntToStr(PopInt));
      AddInfo('������� 16:                         ' + IntToStr(PopInt));

      AddInfo('');
      AddInfo('WRN_OK:                             ' + IntToStr(PopInt));
      AddInfo('WRN_ZERO:                           ' + IntToStr(PopInt));
      AddInfo('WRN_REPEAT:                         ' + IntToStr(PopInt));
      AddInfo('WRN_TOP:                            ' + IntToStr(PopInt));
      AddInfo('WRN_TREND_TOP:                      ' + IntToStr(PopInt));
      AddInfo('WRN_TREND_BOTTOM:                   ' + IntToStr(PopInt));
      AddInfo('������� 7:                          ' + IntToStr(PopInt));
      AddInfo('������� 8:                          ' + IntToStr(PopInt));
      AddInfo('������� 9:                          ' + IntToStr(PopInt));
      AddInfo('������� 10:                         ' + IntToStr(PopInt));
      AddInfo('������� 11:                         ' + IntToStr(PopInt));
      AddInfo('������� 12:                         ' + IntToStr(PopInt));
      AddInfo('������� 13:                         ' + IntToStr(PopInt));
      AddInfo('������� 14:                         ' + IntToStr(PopInt));
      AddInfo('������� 15:                         ' + IntToStr(PopInt));
      AddInfo('������� 16:                         ' + IntToStr(PopInt));

      AddInfo('');
      AddInfo('���� ������ �������� ��-301 �1/x6:  ' + PopBool2Str);
    end
    else
      AddInfo('����������� ������� !');

  BoxRun;
end;

end.
