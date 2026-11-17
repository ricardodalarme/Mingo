import 'dart:async';
import 'dart:math';

import 'package:app/features/_shared/data/mappers/page_info_mapper.dart';
import 'package:app/features/_shared/data/models/page_info.dart';
import 'package:app/features/slips/data/data_sources/local/slip_local_data_source.dart';
import 'package:app/features/slips/data/data_sources/remote/slip_data_source.dart';
import 'package:app/features/slips/data/mappers/drawn_slip_mapper.dart';
import 'package:app/features/slips/data/mappers/slip_detail_mapper.dart';
import 'package:app/features/slips/data/mappers/slip_entry_mapper.dart';
import 'package:app/features/slips/data/mappers/slip_enum_mapper.dart';
import 'package:app/features/slips/data/mappers/slip_send_outcome_mapper.dart';
import 'package:app/features/slips/data/models/drawn_slip.dart';
import 'package:app/features/slips/data/models/pending_slip.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_detail.dart';
import 'package:app/features/slips/data/models/slip_draft.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_send_outcome.dart';
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
    } catch (e) {
      if (!_isOffline(e)) rethrow;
      await _enqueue(slip);
      return SlipSaveOutcome.queued;
    }
  }

  /// Reads one slip; returns null when it is deleted or not the person's.
  Future<SlipDetail?> getSlip(String id) async {
    final row = await _slipDataSource.getSlip(id);
    if (row == null) return null;

    return row.toModel();
  }

  /// Saves the edited text and card choice of an existing slip.
  Future<void> updateSlip(SlipDetail slip) async {
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
  }

  /// Puts the slip in the jar of good moments, or takes it out.
  Future<void> setInJar({required String id, required bool inJar}) async {
    await _slipDataSource.setInJar(id: id, inJar: inJar);
  }

  /// One random slip from the jar, or null when it is empty.
  Future<DrawnSlip?> drawFromJar() async {
    final slips = await _slipDataSource.getJarSlips();
    if (slips.isEmpty) return null;
    final slip = slips[(_random ?? Random()).nextInt(slips.length)];

    return slip.toModel();
  }

  Future<void> setArchived({required String id, required bool archived}) async {
    await _slipDataSource.archiveSlip(id: id, archived: archived);
  }

  Future<void> deleteSlip(String id) async {
    await _slipDataSource.deleteSlip(id);
  }

  /// Tells the partner something gentle, such as a need; throws when there is no partner.
  Future<void> sendNeed(String need) async {
    await _slipDataSource.sendNeed(value: need);
  }

  /// Sends the partner a one-tap hug, the reaction to a good shared mood.
  Future<void> sendHug() async {
    await _slipDataSource.sendHug();
  }

  /// Asks the partner if they want to talk, arriving as the need they can answer.
  Future<void> askToTalk() async {
    await _slipDataSource.sendNeed(value: 'talk');
  }

  /// Sends the partner a hug carrying [body], a short message of a line or two.
  Future<void> sendSweetMessage(String body) async {
    await _slipDataSource.sendHug(body: body);
  }

  /// Reads a page of the person's slips that match [filter], newest first.
  Future<PageInfo<SlipEntry>> getSlips({
    int offset = 0,
    SlipFilter filter = const SlipFilter(),
    int pageSize = slipPageSize,
  }) async {
    final rows = await _slipDataSource.getSlips(
      limit: pageSize + 1,
      offset: offset,
      filter: filter,
    );

    return rows.toPageInfo(offset: offset, pageSize: pageSize, map: (row) => row.toModel());
  }

  /// Emits the first [count] slips that match [filter], newest first, now and again whenever one
  /// is saved, edited, archived or deleted by this person.
  ///
  /// A failure is passed on, so a screen can show it when it has nothing yet.
  Stream<PageInfo<SlipEntry>> watchSlips({
    int count = slipPageSize,
    SlipFilter filter = const SlipFilter(),
  }) {
    return _slipDataSource
        .watchSlips(limit: count + 1, offset: 0, filter: filter)
        .map((rows) => rows.toPageInfo(offset: 0, pageSize: count, map: (row) => row.toModel()));
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

    await _slipDataSource.deleteSlip(id);
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
    final status = await _slipDataSource.sendSlipNow(slipId);

    return status.toSlipSendOutcome();
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
