import 'dart:async';

import 'package:app/features/dates/data/data_sources/remote/dates_data_source.dart';
import 'package:app/features/dates/data/mappers/important_date_enum_mapper.dart';
import 'package:app/features/dates/data/models/dates_models.dart';
import 'package:app/features/dates/data/models/important_date_kind.dart';
import 'package:app/features/gifts/data/mappers/gift_enum_mapper.dart';
import 'package:app/features/gifts/data/models/gift_idea_status.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:logger/logger.dart';

class DatesRepository({
  required final DatesDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
  final Future<void> Function()? _onDatesChanged,
}) {
  final Logger _logger = Logger('DatesRepository');

  Future<List<ImportantDate>> getDates() => _run(
    'read dates',
    () async => [
      for (final node in await _dataSource.getDates())
        ImportantDate(
          id: node.id,
          title: node.title,
          kind: node.kind.toModel(),
          month: node.month,
          day: node.day,
          year: node.year,
          isYearly: node.yearly,
        ),
    ],
  );

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
  }) => _run('add a date', () async {
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
  });

  Future<void> deleteDate(String id) => _run('delete a date', () async {
    await _dataSource.deleteDate(id);
    unawaited(_onDatesChanged?.call() ?? Future<void>.value());
  });

  Future<List<GiftIdea>> getGiftIdeas() => _run('read gift ideas', () async {
    final currentUserId = await _togetherRepository.getCurrentUserId();
    final nodes = await _dataSource.getGiftIdeas();

    return [
      for (final node in nodes)
        if (node.authorId == currentUserId)
          GiftIdea(id: node.id, title: node.title, status: node.status.toModel()),
    ];
  });

  Future<void> addGiftIdea({required String id, required String title}) =>
      _run('add a gift idea', () => _dataSource.addGiftIdea(id: id, title: title.trim()));

  Future<void> setGiftGiven({required String id, required bool isGiven}) => _run(
    'update a gift idea',
    () => _dataSource.setGiftIdeaStatus(
      id: id,
      status: (isGiven ? GiftIdeaStatus.given : GiftIdeaStatus.idea).toRemote(),
    ),
  );

  Future<void> deleteGiftIdea(String id) =>
      _run('delete a gift idea', () => _dataSource.deleteGiftIdea(id));

  Future<List<Holiday>> getHolidays(String locale) => _run(
    'read holidays',
    () async => [
      for (final node in await _dataSource.getHolidays(locale))
        if (node.month != null && node.day != null)
          Holiday(slug: node.slug, title: node.title, month: node.month!, day: node.day!),
    ],
  );

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
