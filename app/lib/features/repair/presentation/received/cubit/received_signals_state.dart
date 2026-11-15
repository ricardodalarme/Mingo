part of 'received_signals_cubit.dart';

final class const ReceivedSignalsState({
  final Resource<List<ReceivedSignal>> signals = const Loading(),
  final Resource<void> respondAction = const Initial(),
  final int answeredCount = 0,
}) with Equatable {
  ReceivedSignalsState copyWith({
    Resource<List<ReceivedSignal>>? signals,
    Resource<void>? respondAction,
    int? answeredCount,
  }) {
    return ReceivedSignalsState(
      signals: signals ?? this.signals,
      respondAction: respondAction ?? this.respondAction,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }

  /// Whether another message waits behind the one on top.
  bool get hasNext => switch (signals) {
    Success(:final value) => value.length > 1,
    _ => false,
  };

  @override
  List<Object?> get props => [signals, respondAction, answeredCount];
}
