import 'package:app/features/repair/data/data_sources/remote/mutations/generated/RespondToSignal.graphql.dart';
import 'package:app/features/repair/data/mappers/repair_enum_mapper.dart';
import 'package:app/features/repair/data/models/signal_answer.dart';

extension SignalAnswerMapper on MutationRespondToSignalupdateSignalsByPk {
  SignalAnswer toModel() =>
      SignalAnswer(response: response?.toModel(), respondedAt: respondedAt, seenAt: seenAt);
}
