unit t_tariff;

interface

const
  TARIFFS_BREAKS  = 6;
  TARIFFS_MONTHS  = 12;

type
  tariff = record
    bHour:      byte;
    bMinute:    byte;
    bTariff:    byte;
  end;

  zones = record
    bSize:      byte;
    mpTariffs:  array[1..TARIFFS_BREAKS] of tariff;
  end;

var
  ibMon:    byte;
  Zone:     zones;
  mpZonesM: array[0..TARIFFS_MONTHS-1] of zones;

implementation

end.
