import 'dart:async';

import 'package:app/features/dates/data/data_sources/remote/dates_data_source.dart';
import 'package:app/features/dates/data/mappers/holiday_mapper.dart';
import 'package:app/features/dates/data/mappers/important_date_enum_mapper.dart';
import 'package:app/features/dates/data/mappers/important_date_mapper.dart';
import 'package:app/features/dates/data/models/dates_models.dart';
import 'package:app/features/dates/data/models/important_date_kind.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';

class DatesRepository({
  required final DatesDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
  final Future<void> Function()? _onDatesChanged,
}) {
  Future<List<ImportantDate>> getDates() async => [
    for (final node in await _dataSource.getDates()) node.toModel(),
  ];

  /// Adds a date shared with the partner when there is one, reminded 7 and 1 days before.
  Future<void> addDate({
    required String id,
    required String title,
    required ImportantDateKind kind,
    required int month,
    required int day,
    int? year,
    bool isYearly = true,
    List<int> remindDays = const [7, 1],
    String? holidayKey,
  }) async {
    await _dataSource.addDate(
      id: id,
      title: title.trim(),
      kind: kind.toRemote(),
      month: month,
      day: day,
      year: year,
      yearly: isYearly,
      remindDays: remindDays,
      origin: (holidayKey == null ? ImportantDateOrigin.manual : ImportantDateOrigin.auto)
          .toRemote(),
      holidayKey: holidayKey,
      coupleId: await _togetherRepository.getCoupleId(),
    );
    unawaited(_onDatesChanged?.call() ?? Future<void>.value());
  }

  Future<void> deleteDate(String id) async {
    await _dataSource.deleteDate(id);
    unawaited(_onDatesChanged?.call() ?? Future<void>.value());
  }

  Future<List<Holiday>> getHolidays(String locale) async => [
    for (final node in await _dataSource.getHolidays(locale)) ?node.toModel(),
  ];
}
