import 'package:app/features/cycle/data/data_sources/remote/cycle_data_source.dart';
import 'package:app/features/cycle/data/models/sensitive_day.dart';

extension SensitiveDaysRecordMapper on SensitiveDaysRecord {
  SensitiveDays toModel() => SensitiveDays(
    today: today,
    days: [for (final day in days) SensitiveDay(day: day)],
  );
}
