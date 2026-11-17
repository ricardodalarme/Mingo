import 'package:app/features/repair/data/data_sources/remote/queries/generated/ReceivedSignals.graphql.dart';
import 'package:app/features/repair/data/mappers/repair_enum_mapper.dart';
import 'package:app/features/repair/data/models/received_signal.dart';

extension ReceivedSignalMapper on QueryReceivedSignalssignals {
  ReceivedSignal toModel() => ReceivedSignal(
    id: id,
    kind: kind.toModel(),
    createdAt: createdAt,
    value: value,
    body: body,
    response: response?.toModel(),
    respondedAt: respondedAt,
    seenAt: seenAt,
  );
}
