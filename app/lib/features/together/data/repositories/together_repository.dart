import 'dart:async';

import 'package:app/features/_shared/data/mappers/content_kind_mapper.dart';
import 'package:app/features/_shared/data/models/content_kind.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/together/data/data_sources/remote/together_data_source.dart';
import 'package:app/features/together/data/mappers/date_idea_mapper.dart';
import 'package:app/features/together/data/mappers/logistic_item_mapper.dart';
import 'package:app/features/together/data/mappers/ritual_mapper.dart';
import 'package:app/features/together/data/mappers/together_enum_mapper.dart';
import 'package:app/features/together/data/models/date_idea.dart';
import 'package:app/features/together/data/models/date_idea_status.dart';
import 'package:app/features/together/data/models/logistic_item.dart';
import 'package:app/features/together/data/models/ritual.dart';
import 'package:clock/clock.dart';
import 'package:logger/logger.dart';

class TogetherRepository({
  required final TogetherDataSource _dataSource,
  required final AuthenticationRepository _authenticationRepository,
}) {
  final Logger _logger = Logger('TogetherRepository');
  StreamSubscription<String?>? _couple;
  Future<String?>? _firstCoupleId;
  ({String? id})? _knownCouple;
  // ignore: cancel_subscriptions, the repository lives as long as the app
  StreamSubscription<bool>? _authState;

  /// The id of the couple the person is in, or null when they are on their own.
  ///
  /// It follows a subscription, so it stays right when the partner joins or leaves, and costs no
  /// request after the first one.
  Future<String?> getCoupleId() async {
    _authState ??= _authenticationRepository.isAuthenticatedStream
        .where((isAuthenticated) => !isAuthenticated)
        .listen((_) => _forgetCouple());
    final known = _knownCouple;
    if (known != null) return known.id;

    return _firstCoupleId ??= _followCouple();
  }

  /// The id of the signed-in person, read from the session; null when signed out.
  Future<String?> getCurrentUserId() async => _authenticationRepository.currentUserId;

  Future<String?> _followCouple() {
    final first = Completer<String?>();
    _couple = _dataSource.watchCoupleId().listen(
      (id) {
        _knownCouple = (id: id);
        if (!first.isCompleted) first.complete(id);
      },
      onError: (Object e, StackTrace stack) {
        _logger.error('Failed to follow the couple', error: e, stackTrace: stack);
        if (first.isCompleted) return;
        _forgetCouple();
        first.completeError(e, stack);
      },
    );

    return first.future;
  }

  void _forgetCouple() {
    unawaited(_couple?.cancel());
    _couple = null;
    _firstCoupleId = null;
    _knownCouple = null;
  }

  Future<List<LogisticItem>> getLogisticItems() async {
    try {
      return [for (final node in await _dataSource.getLogisticItems()) node.toModel()];
    } catch (e, stack) {
      _logger.error('Failed to read logistics', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Emits the shared list now and each time the partner or the person changes it.
  ///
  /// A failed event is logged and skipped, so a screen keeps what it shows.
  Stream<List<LogisticItem>> watchLogisticItems() {
    return _dataSource
        .watchLogisticItems()
        .map((nodes) => [for (final node in nodes) node.toModel()])
        .handleError((Object e, StackTrace stack) {
          _logger.error('The logistics subscription failed', error: e, stackTrace: stack);
        });
  }

  /// Adds an item shared with the partner when there is one; the client [id] makes retries safe.
  Future<void> addLogisticItem({
    required String id,
    required String title,
    String? assigneeId,
  }) async {
    try {
      final coupleId = await getCoupleId();
      await _dataSource.addLogisticItem(
        id: id,
        title: title.trim(),
        assigneeId: assigneeId,
        coupleId: coupleId,
      );
    } catch (e, stack) {
      _logger.error('Failed to add a logistic item', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> setLogisticItemDone({required String id, required bool isDone, DateTime? now}) =>
      _run(
        'update a logistic item',
        () => _dataSource.setLogisticItemDone(id: id, doneAt: isDone ? (now ?? clock.now()) : null),
      );

  Future<void> setLogisticItemAssignee({required String id, String? assigneeId}) => _run(
    'assign a logistic item',
    () => _dataSource.setLogisticItemAssignee(id: id, assigneeId: assigneeId),
  );

  /// Confirms an item the partner proposed, which turns it into something both agreed on.
  Future<void> confirmLogisticItem(String id) =>
      _run('confirm a logistic item', () => _dataSource.confirmLogisticItem(id));

  Future<void> deleteLogisticItem(String id) =>
      _run('delete a logistic item', () => _dataSource.deleteLogisticItem(id));

  Future<List<Ritual>> getRituals() async {
    try {
      return [for (final node in await _dataSource.getRituals()) node.toModel()];
    } catch (e, stack) {
      _logger.error('Failed to read rituals', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Creates a new ritual shared with the partner, or saves the changes of an existing one.
  Future<void> saveRitual(Ritual ritual, {required bool isNew}) async {
    try {
      final time = '${ritual.hour.toString().padLeft(2, '0')}:00:00';
      final weekday = ritual.needsWeekday ? ritual.weekday : null;
      if (isNew) {
        await _dataSource.addRitual(
          id: ritual.id,
          title: ritual.title.trim(),
          cadence: ritual.cadence.toRemote(),
          weekday: weekday,
          atTime: time,
          reminder: ritual.hasReminder,
          coupleId: await getCoupleId(),
          plannerId: ritual.plannerId,
        );
      } else {
        await _dataSource.updateRitual(
          id: ritual.id,
          title: ritual.title.trim(),
          cadence: ritual.cadence.toRemote(),
          weekday: weekday,
          atTime: time,
          reminder: ritual.hasReminder,
          plannerId: ritual.plannerId,
        );
      }
    } catch (e, stack) {
      _logger.error('Failed to save a ritual', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Hides a ritual; its history stays on the server.
  Future<void> archiveRitual(String id, {required DateTime now}) =>
      _run('archive a ritual', () => _dataSource.archiveRitual(id: id, at: now));

  /// Records that the ritual happened today.
  Future<void> completeRitual(String id, {required DateTime now}) => _run(
    'complete a ritual',
    () => _dataSource.completeRitual(id: id, day: DateTime(now.year, now.month, now.day)),
  );

  Future<List<DateIdea>> getDateIdeas() async {
    try {
      return [for (final node in await _dataSource.getDateIdeas()) node.toModel()];
    } catch (e, stack) {
      _logger.error('Failed to read date ideas', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// The editorial ideas offered when the couple has none of its own.
  Future<List<DateIdeaSuggestion>> getDateIdeaSuggestions(String locale) async {
    try {
      return [for (final node in await _dataSource.getDateIdeaSuggestions(locale)) node.toModel()];
    } catch (e, stack) {
      _logger.error('Failed to read date suggestions', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Saves an idea shared with the partner; [slug] names an editorial idea it came from.
  Future<void> addDateIdea({required String id, required String title, String? slug}) async {
    try {
      await _dataSource.addDateIdea(
        id: id,
        title: title.trim(),
        slug: slug,
        coupleId: await getCoupleId(),
      );
    } catch (e, stack) {
      _logger.error('Failed to save a date idea', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Plans [idea] for [day] and adds the shared date that reminds both people.
  Future<void> planDateIdea(DateIdea idea, {required DateTime day}) async {
    try {
      await _dataSource.planDateIdea(id: idea.id, day: day);
      await _dataSource.addSharedDate(title: idea.title, day: day, coupleId: await getCoupleId());
    } catch (e, stack) {
      _logger.error('Failed to plan a date', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> setDateIdeaDone({required String id, required bool isDone}) => _run(
    'update a date idea',
    () => _dataSource.setDateIdeaStatus(
      id: id,
      status: (isDone ? DateIdeaStatus.done : DateIdeaStatus.saved).toRemote(),
    ),
  );

  Future<void> deleteDateIdea(String id) =>
      _run('delete a date idea', () => _dataSource.deleteDateIdea(id));

  /// Editorial help content of a [kind], such as [ContentKind.moodTip], in editorial order.
  Future<List<HelpItem>> getHelpContent({required ContentKind kind, required String locale}) async {
    try {
      return [
        for (final node in await _dataSource.getHelpContent(kind: kind.toRemote(), locale: locale))
          HelpItem(slug: node.slug, title: node.title, body: node.body),
      ];
    } catch (e, stack) {
      _logger.error('Failed to read help content', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> _run(String what, Future<void> Function() action) async {
    try {
      await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
