import 'dart:async';
import 'dart:math';

import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'package:app/features/slips/data/data_sources/local/slip_local_data_source.dart';
import 'package:app/features/slips/data/data_sources/remote/queries/generated/MySlips.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/slip_data_source.dart';
import 'package:app/features/slips/data/mappers/slip_enum_mapper.dart';
import 'package:app/features/slips/data/models/drawn_slip.dart';
import 'package:app/features/slips/data/models/pending_slip.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_detail.dart';
import 'package:app/features/slips/data/models/slip_draft.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_work_area.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';
import 'package:network/network.dart';

/// How many slips one page holds.
const int slipPageSize = 20;

/// What happened when a slip was sent on its own.
enum SlipSendOutcome() {
  /// The partner has it.
  sent,

  /// The wording matched a rule, so the card was held instead of sent.
  held,

  /// Nothing was sent: no partner, or the slip may not be sent.
  notSent,
}

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
  final Random? _random,
}) {
  final Logger _logger = Logger('SlipRepository');

  /// How many slips are waiting on the device for a connection.
  int get pendingCount => _localDataSource.readPending().length;

  /// Saves a slip, or keeps it on the device when there is no connection.
  ///
  /// The client-generated [id] makes retries safe. A slip stays private unless [forCard] is set.
  Future<SlipSaveOutcome> saveQuick({
    required String id,
    required String body,
    required DateTime createdAt,
    SlipCategory? category,
    SlipKind kind = SlipKind.quick,
    String? feeling,
    String? planNote,
    SlipWorkArea? workArea,
    bool forCard = false,
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
      forCard: forCard,
    );
    try {
      await _send(slip);
      return SlipSaveOutcome.synced;
    } catch (e, stack) {
      if (!_isOffline(e)) {
        _logger.error('Failed to save a slip', error: e, stackTrace: stack);
        rethrow;
      }
      await _enqueue(slip);
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

  /// One random slip from the jar, or null when it is empty.
  Future<DrawnSlip?> drawFromJar() async {
    try {
      final slips = await _slipDataSource.getJarSlips();
      if (slips.isEmpty) return null;
      final slip = slips[(_random ?? Random()).nextInt(slips.length)];

      return DrawnSlip(id: slip.id, body: slip.body);
    } catch (e, stack) {
      _logger.error('Failed to draw from the jar', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> setArchived({required String id, required bool archived}) async {
    try {
      await _slipDataSource.archiveSlip(id: id, archived: archived);
    } catch (e, stack) {
      _logger.error('Failed to archive a slip', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> deleteSlip(String id) async {
    try {
      await _slipDataSource.deleteSlip(id);
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

  /// Reads a page of the person's slips that match [filter], newest first.
  Future<SlipPage> getSlips({
    int offset = 0,
    SlipFilter filter = const SlipFilter(),
    int pageSize = slipPageSize,
  }) async {
    try {
      final rows = await _slipDataSource.getSlips(
        limit: pageSize + 1,
        offset: offset,
        filter: filter,
      );

      return _page(rows, offset: offset, pageSize: pageSize);
    } catch (e, stack) {
      _logger.error('Failed to load slips', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Emits the first [count] slips that match [filter], newest first, now and again whenever one
  /// is saved, edited, archived or deleted by this person.
  ///
  /// A failure is logged and passed on, so a screen can show it when it has nothing yet.
  Stream<SlipPage> watchSlips({int count = slipPageSize, SlipFilter filter = const SlipFilter()}) {
    return _slipDataSource
        .watchSlips(limit: count + 1, offset: 0, filter: filter)
        .map((rows) => _page(rows, offset: 0, pageSize: count))
        .transform(
          StreamTransformer.fromHandlers(
            handleError: (error, stack, sink) {
              _logger.error('Failed to watch slips', error: error, stackTrace: stack);
              sink.addError(error, stack);
            },
          ),
        );
  }

  SlipPage _page(List<QueryMySlipsslips> rows, {required int offset, required int pageSize}) {
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
      return;
    }

    try {
      await _slipDataSource.deleteSlip(id);
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

  /// Sends one slip to the partner now, without waiting for Sunday.
  Future<SlipSendOutcome> sendNow(String slipId) async {
    try {
      final status = await _slipDataSource.sendSlipNow(slipId);

      return switch (status) {
        EnumCardStatus_enum.sent => SlipSendOutcome.sent,
        EnumCardStatus_enum.held => SlipSendOutcome.held,
        _ => SlipSendOutcome.notSent,
      };
    } catch (e, stack) {
      _logger.error('Failed to send a slip', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> clearDraft() => _localDataSource.clearDraft();

  /// Whether new slips go on the weekly card by default; private when it cannot be read.
  Future<bool> getForCardDefault() async {
    try {
      return await _slipDataSource.getForCardDefault();
    } catch (e, stack) {
      _logger.warning('Failed to read the slip card preference', error: e, stackTrace: stack);

      return false;
    }
  }

  Future<void> _send(PendingSlip slip) async {
    await _slipDataSource.saveSlip(
      id: slip.id,
      body: slip.body,
      createdAt: slip.createdAt,
      kind: slip.kind.toRemote(),
      feeling: slip.feeling,
      planNote: slip.planNote,
      forCard: slip.forCard,
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
