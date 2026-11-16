import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/CompleteRepairSession.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/DeleteLearning.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/RecordTemperature.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/RespondToSignal.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/SaveLearning.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/SaveRepairProgress.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/SendRepairSignal.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/StartRepairSession.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/queries/generated/MyLearnings.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/queries/generated/OpenGuidedSession.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/queries/generated/ReceivedSignals.graphql.dart';
import 'package:network/network.dart';

class RepairDataSource({required final GQLClient _client}) {
  Future<void> recordTemperature(EnumTemperatureLevel_enum level) async {
    final response = await _client.mutate(
      OptionsMutationRecordTemperature(variables: VariablesMutationRecordTemperature(level: level)),
    );

    validateResponse(response);
  }

  /// Sends the partner a repair message; fails with `NOT_PAIRED` when there is none.
  Future<void> sendRepair({required String body, String? value}) async {
    final response = await _client.mutate(
      OptionsMutationSendRepairSignal(
        variables: VariablesMutationSendRepairSignal(value: value, body: body),
      ),
    );

    validateResponse(response);
  }

  Future<QueryOpenGuidedSessionrepairSessions?> openGuidedSession() async {
    final response = await _client.query(
      OptionsQueryOpenGuidedSession(fetchPolicy: FetchPolicy.networkOnly),
    );
    final sessions = validateResponseData(response, getData: (data) => data.repairSessions);

    return sessions.firstOrNull;
  }

  Future<void> saveProgress({required String id, required int step, String? draft}) async {
    final response = await _client.mutate(
      OptionsMutationSaveRepairProgress(
        variables: VariablesMutationSaveRepairProgress(id: id, step: step, draft: draft),
      ),
    );

    validateResponse(response);
  }

  Future<void> completeSession({
    required String id,
    required DateTime completedAt,
    EnumRepairFeeling_enum? feeling,
  }) async {
    final response = await _client.mutate(
      OptionsMutationCompleteRepairSession(
        variables: VariablesMutationCompleteRepairSession(
          id: id,
          feeling: feeling,
          completedAt: completedAt,
        ),
      ),
    );

    validateResponse(response);
  }

  Future<List<QueryMyLearningsrepairLearnings>> getLearnings() async {
    final response = await _client.query(
      OptionsQueryMyLearnings(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.repairLearnings);
  }

  Future<void> saveLearning({
    required String id,
    required EnumRepairLearningKind_enum kind,
    required String note,
    String? sessionId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSaveLearning(
        variables: VariablesMutationSaveLearning(
          id: id,
          sessionId: sessionId,
          kind: kind,
          note: note,
        ),
      ),
    );

    validateResponse(response);
  }

  Future<void> deleteLearning(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteLearning(variables: VariablesMutationDeleteLearning(id: id)),
    );

    validateResponse(response);
  }

  Future<List<QueryReceivedSignalssignals>> getReceivedSignals(String recipientId) async {
    final response = await _client.query(
      OptionsQueryReceivedSignals(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: VariablesQueryReceivedSignals(recipientId: recipientId),
      ),
    );

    return validateResponseData(response, getData: (data) => data.signals);
  }

  /// Marks the signal seen and stores the answer, when there is one.
  Future<MutationRespondToSignalupdateSignalsByPk> respondToSignal({
    required String signalId,
    required DateTime at,
    EnumSignalResponse_enum? response,
  }) async {
    final result = await _client.mutate(
      OptionsMutationRespondToSignal(
        variables: VariablesMutationRespondToSignal(
          signalId: signalId,
          response: response,
          seenAt: at,
        ),
      ),
    );

    return validateResponseData(result, getData: (data) => data.updateSignalsByPk);
  }

  Future<void> startSession({
    required String id,
    required EnumRepairPath_enum path,
    int? intensity,
  }) async {
    final response = await _client.mutate(
      OptionsMutationStartRepairSession(
        variables: VariablesMutationStartRepairSession(id: id, intensity: intensity, path: path),
      ),
    );

    validateResponse(response);
  }
}
