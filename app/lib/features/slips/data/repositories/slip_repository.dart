import 'dart:async';

import 'package:app/features/slips/data/data_sources/local/slip_local_data_source.dart';
import 'package:app/features/slips/data/data_sources/remote/slip_data_source.dart';
import 'package:app/features/slips/data/mappers/slip_enum_mapper.dart';
import 'package:app/features/slips/data/models/pending_slip.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_detail.dart';
import 'package:app/features/slips/data/models/slip_draft.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_work_area.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';
import 'package:network/network.dart';

/// How many slips one page holds.
const int slipPageSize = 20;

/// Where a saved slip ended up.
enum SlipSaveOutcome() {
  /// The server has it.
  synced,

  /// Kept on the device and sent when the connection is back.
  queued,
}

class SlipRepository({
  required final SlipDataSource _slipDataSource,
  required final SlipLocalDataSource _localDataSource,
}) {
  final Logger _logger = Logger('SlipRepository');
  final StreamController<void> _changes = StreamController<void>.broadcast();

  /// How many slips are waiting on the device for a connection.
  int get pendingCount => _localDataSource.readPending().length;

  /// Emits whenever a slip is saved, undone or sent, so lists can read again.
  Stream<void> get onChanged => _changes.stream;

  /// Saves a slip, or keeps it on the device when there is no connection.
  ///
  /// The client-generated [id] makes retries safe.
  Future<SlipSaveOutcome> saveQuick({
    required String id,
    required String body,
    required DateTime createdAt,
    SlipCategory? category,
    SlipKind kind = SlipKind.quick,
    String? feeling,
    String? planNote,
    SlipWorkArea? workArea,
  }) async {
    final slip = PendingSlip(
      id: id,
      body: body,
      createdAt: createdAt,
      category: category,
      kind: kind,
      feeling: feeling,
      planNote: planNote,
      workArea: workArea,
    );
    try {
      await _send(slip);
      _changes.add(null);
      return SlipSaveOutcome.synced;
    } catch (e, stack) {
      if (!_isOffline(e)) {
        _logger.error('Failed to save a slip', error: e, stackTrace: stack);
        rethrow;
      }
      await _enqueue(slip);
      _changes.add(null);
      return SlipSaveOutcome.queued;
    }
  }

  /// Reads one slip; returns null when it is deleted or not the person's.
  Future<SlipDetail?> getSlip(String id) async {
    try {
      final row = await _slipDataSource.getSlip(id);
      if (row == null) return null;
      final node = row.slip;

      return SlipDetail(
        id: node.id,
        body: node.body,
        kind: node.kind.toModel() ?? SlipKind.quick,
        createdAt: node.createdAt,
        forCard: node.forCard,
        feeling: node.feeling,
        planNote: node.planNote,
        category: node.category?.toModel(),
        workArea: node.workArea?.toModel(),
        isArchived: node.archivedAt != null,
        isInJar: node.inJar,
        wasInCard: row.wasInCard,
      );
    } catch (e, stack) {
      _logger.error('Failed to load a slip', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Saves the edited text and card choice of an existing slip.
  Future<void> updateSlip(SlipDetail slip) async {
    try {
      await _slipDataSource.saveSlip(
        id: slip.id,
        body: slip.body.trim(),
        createdAt: slip.createdAt,
        kind: slip.kind.toRemote(),
        feeling: slip.feeling,
        planNote: slip.planNote,
        forCard: slip.forCard && slip.canGoInCard,
        category: slip.category?.toRemote(),
        workArea: slip.workArea?.toRemote(),
      );
      _changes.add(null);
    } catch (e, stack) {
      _logger.error('Failed to update a slip', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Puts the slip in the jar of good moments, or takes it out.
  Future<void> setInJar({required String id, required bool inJar}) async {
    try {
      await _slipDataSource.setInJar(id: id, inJar: inJar);
    } catch (e, stack) {
      _logger.error('Failed to update the jar', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> setArchived({required String id, required bool archived}) async {
    try {
      await _slipDataSource.archiveSlip(id: id, archived: archived);
      _changes.add(null);
    } catch (e, stack) {
      _logger.error('Failed to archive a slip', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> deleteSlip(String id) async {
    try {
      await _slipDataSource.deleteSlip(id);
      _changes.add(null);
    } catch (e, stack) {
      _logger.error('Failed to delete a slip', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Tells the partner something gentle, such as a need; throws when there is no partner.
  Future<void> sendNeed(String need) async {
    try {
      await _slipDataSource.sendNeed(value: need);
    } catch (e, stack) {
      _logger.error('Failed to send a need', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Sends the partner a one-tap hug, the reaction to a good shared mood.
  Future<void> sendHug() async {
    try {
      await _slipDataSource.sendHug();
    } catch (e, stack) {
      _logger.error('Failed to send a hug', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Asks the partner if they want to talk, arriving as the need they can answer.
  Future<void> askToTalk() async {
    try {
      await _slipDataSource.sendNeed(value: 'talk');
    } catch (e, stack) {
      _logger.error('Failed to ask the partner to talk', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Sends the partner a hug carrying [body], a short message of a line or two.
  Future<void> sendSweetMessage(String body) async {
    try {
      await _slipDataSource.sendHug(body: body);
    } catch (e, stack) {
      _logger.error('Failed to send a sweet message', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Reads a page of the person's slips, newest first; [since] limits it to recent ones.
  ///
  /// [archived] reads the slips taken out of the timeline instead.
  Future<SlipPage> getSlips({
    int offset = 0,
    DateTime? since,
    bool archived = false,
    int pageSize = slipPageSize,
  }) async {
    try {
      final rows = await _slipDataSource.getSlips(
        limit: pageSize + 1,
        offset: offset,
        since: since,
        archived: archived,
      );
      final pageRows = rows.take(pageSize).toList();

      return SlipPage(
        items: [
          for (final row in pageRows)
            SlipEntry(
              id: row.id,
              body: row.body,
              kind: row.kind.toModel() ?? SlipKind.quick,
              category: row.category?.toModel(),
              forCard: row.forCard,
              createdAt: row.createdAt,
            ),
        ],
        hasNext: rows.length > pageSize,
        offset: offset + pageRows.length,
      );
    } catch (e, stack) {
      _logger.error('Failed to load slips', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Keeps a slip only on the device; it is sent once there is a signed-in session.
  Future<void> keepOnDevice({
    required String id,
    required String body,
    required DateTime createdAt,
  }) => _enqueue(PendingSlip(id: id, body: body, createdAt: createdAt));

  /// Removes a slip that was just saved, whether or not it reached the server.
  Future<void> undo(String id) async {
    final pending = _localDataSource.readPending();
    if (pending.any((slip) => slip.id == id)) {
      await _localDataSource.writePending(pending.where((slip) => slip.id != id).toList());
      _changes.add(null);
      return;
    }

    try {
      await _slipDataSource.deleteSlip(id);
      _changes.add(null);
    } catch (e, stack) {
      _logger.error('Failed to undo a slip', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Sends every slip kept on the device; stops at the first one that still cannot go.
  Future<void> flushPending() async {
    for (final slip in _localDataSource.readPending()) {
      try {
        await _send(slip);
      } catch (e, stack) {
        _logger.warning('A pending slip is still waiting', error: e, stackTrace: stack);
        return;
      }
      final remaining = _localDataSource.readPending().where((item) => item.id != slip.id);
      await _localDataSource.writePending(remaining.toList());
      _changes.add(null);
    }
  }

  SlipDraft? readDraft(DateTime now) {
    final draft = _localDataSource.readDraft();

    return draft != null && draft.isFresh(now) ? draft : null;
  }

  Future<void> saveDraft({required String text, required DateTime now, SlipCategory? category}) {
    if (text.trim().isEmpty && category == null) return _localDataSource.clearDraft();

    return _localDataSource.writeDraft(SlipDraft(text: text, savedAt: now, category: category));
  }

  Future<void> clearDraft() => _localDataSource.clearDraft();

  Future<void> _send(PendingSlip slip) async {
    await _slipDataSource.saveSlip(
      id: slip.id,
      body: slip.body,
      createdAt: slip.createdAt,
      kind: slip.kind.toRemote(),
      feeling: slip.feeling,
      planNote: slip.planNote,
      category: slip.category?.toRemote(),
      workArea: slip.workArea?.toRemote(),
    );
  }

  Future<void> _enqueue(PendingSlip slip) async {
    final pending = _localDataSource.readPending();
    await _localDataSource.writePending([...pending.where((item) => item.id != slip.id), slip]);
  }

  bool _isOffline(Object error) => error is LocalizedException && error.l10nKey == networkErrorCode;
}
