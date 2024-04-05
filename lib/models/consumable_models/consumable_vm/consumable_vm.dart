enum Measurement {
  m,
  stk,
  cm,
  l,
  mm,
  qm,
  qcm,
}

extension MeasurementExtension on Measurement {
  String getTitle() => switch (this) {
        Measurement.m => 'Meter',
        Measurement.stk => 'Stück',
        Measurement.cm => 'Centimeter',
        Measurement.l => 'Liter',
        Measurement.mm => 'MilliMeter',
        Measurement.qm => 'Quadrat Meter',
        Measurement.qcm => 'Quadrat Centimeter',
      };
}

class ConsumableVM {
  final String title;
  final String? kuID;
  final Measurement measurement;
  final int amount;
  final int priceInCents;
  const ConsumableVM({
    this.amount = 1,
    this.kuID,
    required this.measurement,
    required this.priceInCents,
    required this.title,
  });
}
