part of 'temperature_history_cubit.dart';

final class const TemperatureHistoryState({
  final Resource<List<TemperatureCheck>> checks = const Loading(),
}) with Equatable {
  TemperatureHistoryState copyWith({Resource<List<TemperatureCheck>>? checks}) =>
      TemperatureHistoryState(checks: checks ?? this.checks);

  @override
  List<Object?> get props => [checks];
}
