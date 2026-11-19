import 'dart:async';

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
    return [for (final node in await _dataSource.getLogisticItems()) node.toModel()];
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
    final coupleId = await getCoupleId();
    await _dataSource.addLogisticItem(
      id: id,
      title: title.trim(),
      assigneeId: assigneeId,
      coupleId: coupleId,
    );
  }

  Future<void> setLogisticItemDone({required String id, required bool isDone, DateTime? now}) =>
      _dataSource.setLogisticItemDone(id: id, doneAt: isDone ? (now ?? clock.now()) : null);

  Future<void> setLogisticItemAssignee({required String id, String? assigneeId}) =>
      _dataSource.setLogisticItemAssignee(id: id, assigneeId: assigneeId);

  /// Confirms an item the partner proposed, which turns it into something both agreed on.
  Future<void> confirmLogisticItem(String id) => _dataSource.confirmLogisticItem(id);

  Future<void> deleteLogisticItem(String id) => _dataSource.deleteLogisticItem(id);

  Future<List<Ritual>> getRituals() async {
    return [for (final node in await _dataSource.getRituals()) node.toModel()];
  }

  /// Creates a new ritual shared with the partner, or saves the changes of an existing one.
  Future<void> saveRitual(Ritual ritual, {required bool isNew}) async {
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
  }

  /// Hides a ritual; its history stays on the server.
  Future<void> archiveRitual(String id, {required DateTime now}) =>
      _dataSource.archiveRitual(id: id, at: now);

  /// Records that the ritual happened today.
  Future<void> completeRitual(String id, {required DateTime now}) =>
      _dataSource.completeRitual(id: id, day: DateTime(now.year, now.month, now.day));

  Future<List<DateIdea>> getDateIdeas() async {
    return [for (final node in await _dataSource.getDateIdeas()) node.toModel()];
  }

  /// The editorial ideas offered when the couple has none of its own.
  Future<List<DateIdeaSuggestion>> getDateIdeaSuggestions(String locale) async {
    return [for (final node in await _dataSource.getDateIdeaSuggestions(locale)) node.toModel()];
  }

  /// Saves an idea shared with the partner; [slug] names an editorial idea it came from.
  Future<void> addDateIdea({required String id, required String title, String? slug}) async {
    await _dataSource.addDateIdea(
      id: id,
      title: title.trim(),
      slug: slug,
      coupleId: await getCoupleId(),
    );
  }

  /// Plans [idea] for [day] and adds the shared date that reminds both people.
  Future<void> planDateIdea(DateIdea idea, {required DateTime day}) async {
    await _dataSource.planDateIdea(id: idea.id, day: day);
    await _dataSource.addSharedDate(title: idea.title, day: day, coupleId: await getCoupleId());
  }

  Future<void> setDateIdeaDone({required String id, required bool isDone}) =>
      _dataSource.setDateIdeaStatus(
        id: id,
        status: (isDone ? DateIdeaStatus.done : DateIdeaStatus.saved).toRemote(),
      );

  Future<void> deleteDateIdea(String id) => _dataSource.deleteDateIdea(id);
}
