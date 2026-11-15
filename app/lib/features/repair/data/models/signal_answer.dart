import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:equatable/equatable.dart';

/// What the server stored when the person answered a message.
final class const SignalAnswer({
  final RepairResponse? response,
  final DateTime? respondedAt,
  final DateTime? seenAt,
}) with Equatable {
  @override
  List<Object?> get props => [response, respondedAt, seenAt];
}
