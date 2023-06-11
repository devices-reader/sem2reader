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
      AddInfo('������������ % ���������� ��������: ' + IntToStr(PopIntBig));
      AddInfo('������������ ��������:              ' + IntToStr(PopIntBig));

      AddInfo('');
      AddInfo('������������ ������');
      for c := 0 to CANALS-1 do
        AddInfo(PackStrR('����� '+IntToStr(c+1),GetColWidth) + PopBool2Str);

      AddInfo('');
      AddInfo('REPEAT:                             ' + IntToStr(PopIntBig));
      AddInfo('ID_REPEAT:                          ' + IntToStr(PopIntBig));
      AddInfo('SUCCESS:                            ' + IntToStr(PopIntBig));
      AddInfo('ERROR:                              ' + IntToStr(PopIntBig));
      AddInfo('������� 5:                          ' + IntToStr(PopIntBig));
      AddInfo('������� 6:                          ' + IntToStr(PopIntBig));
      AddInfo('������� 7:                          ' + IntToStr(PopIntBig));
      AddInfo('������� 8:                          ' + IntToStr(PopIntBig));
      AddInfo('������� 9:                          ' + IntToStr(PopIntBig));
      AddInfo('������� 10:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 11:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 12:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 13:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 14:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 15:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 16:                         ' + IntToStr(PopIntBig));

      AddInfo('');
      AddInfo('WRN_OK:                             ' + IntToStr(PopIntBig));
      AddInfo('WRN_ZERO:                           ' + IntToStr(PopIntBig));
      AddInfo('WRN_REPEAT:                         ' + IntToStr(PopIntBig));
      AddInfo('WRN_TOP:                            ' + IntToStr(PopIntBig));
      AddInfo('WRN_TREND_TOP:                      ' + IntToStr(PopIntBig));
      AddInfo('WRN_TREND_BOTTOM:                   ' + IntToStr(PopIntBig));
      AddInfo('������� 7:                          ' + IntToStr(PopIntBig));
      AddInfo('������� 8:                          ' + IntToStr(PopIntBig));
      AddInfo('������� 9:                          ' + IntToStr(PopIntBig));
      AddInfo('������� 10:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 11:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 12:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 13:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 14:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 15:                         ' + IntToStr(PopIntBig));
      AddInfo('������� 16:                         ' + IntToStr(PopIntBig));

      AddInfo('');
      AddInfo('���� ������ �������� ��-301 �1/x6:  ' + PopBool2Str);
    end
    else
      AddInfo('����������� ������� !');

  BoxRun;
end;

end.
