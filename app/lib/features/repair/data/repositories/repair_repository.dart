import 'dart:async';

import 'package:app/features/repair/data/data_sources/remote/repair_data_source.dart';
import 'package:app/features/repair/data/mappers/learning_mapper.dart';
import 'package:app/features/repair/data/mappers/received_signal_mapper.dart';
import 'package:app/features/repair/data/mappers/repair_enum_mapper.dart';
import 'package:app/features/repair/data/mappers/signal_answer_mapper.dart';
import 'package:app/features/repair/data/models/guided_session.dart';
import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:app/features/repair/data/models/repair_path.dart';
import 'package:app/features/repair/data/models/signal_answer.dart';
import 'package:app/features/repair/data/models/temperature_history.dart';
import 'package:clock/clock.dart';

class RepairRepository({required final RepairDataSource _dataSource}) {
  /// Stores the private temperature answer.
  Future<void> recordTemperature(Temperature level) async {
    await _dataSource.recordTemperature(level.toRemote());
  }

  /// The person's own temperature answers from the last weeks, newest first.
  Future<List<TemperatureCheck>> getTemperatureChecks() => _readTemperatureChecks(limit: 200);

  /// Whether the last answer was a fight in the past [conflictWindow].
  Future<bool> isInConflict() async {
    final latest = (await _readTemperatureChecks(limit: 1)).firstOrNull;

    return latest != null &&
        latest.level == Temperature.fight &&
        clock.now().difference(latest.at) < conflictWindow;
  }

  Future<List<TemperatureCheck>> _readTemperatureChecks({required int limit}) async {
    return [
      for (final node in await _dataSource.getTemperatureChecks(limit: limit))
        TemperatureCheck(level: node.level.toModel(), at: node.createdAt),
    ];
  }

  /// Sends the partner a short repair message; [preset] names a ready-made one, if used.
  Future<void> sendRepair({required String message, String? preset}) async {
    await _dataSource.sendRepair(body: message.trim(), value: preset);
  }

  /// The guided repair the person left unfinished, if any.
  Future<GuidedSession?> openGuidedSession() async {
    final node = await _dataSource.openGuidedSession();

    return node == null
        ? null
        : GuidedSession.fromStored(id: node.id, step: node.step, draft: node.draft);
  }

  /// Saves where the person is in the guided repair, so it can be resumed later.
  Future<void> saveProgress(GuidedSession session) async {
    await _dataSource.saveProgress(id: session.id, step: session.step, draft: session.draft);
  }

  /// Closes the guided repair with how the person feels now.
  Future<void> completeSession({
    required String id,
    required DateTime now,
    RepairFeeling? feeling,
  }) async {
    await _dataSource.completeSession(id: id, completedAt: now, feeling: feeling?.toRemote());
  }

  Future<List<Learning>> getLearnings() async {
    return [for (final node in await _dataSource.getLearnings()) node.toModel()];
  }

  Future<void> saveLearning({
    required String id,
    required RepairLearningKind kind,
    required String note,
    String? sessionId,
  }) async {
    await _dataSource.saveLearning(
      id: id,
      kind: kind.toRemote(),
      note: note.trim(),
      sessionId: sessionId,
    );
  }

  Future<void> deleteLearning(String id) async {
    await _dataSource.deleteLearning(id);
  }

  /// The partner's messages the person has not answered yet, newest first.
  Future<List<ReceivedSignal>> getReceivedSignals(String recipientId) async {
    return [for (final node in await _dataSource.getReceivedSignals(recipientId)) node.toModel()];
  }

  /// Answers a message from the partner; a null [response] only marks it seen.
  Future<SignalAnswer> respondToSignal({required String signalId, RepairResponse? response}) async {
    final node = await _dataSource.respondToSignal(
      signalId: signalId,
      at: clock.now(),
      response: response?.toRemote(),
    );

    return node.toModel();
  }

  /// Starts a private repair session with the chosen [path]; the client [id] makes retries safe.
  Future<void> startSession({required String id, required RepairPath path, int? intensity}) async {
    await _dataSource.startSession(id: id, path: path.toRemote(), intensity: intensity);
  }
}
