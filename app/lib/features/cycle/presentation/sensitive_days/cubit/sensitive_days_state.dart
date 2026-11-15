part of 'sensitive_days_cubit.dart';

final class const SensitiveDaysState({
  final Resource<SensitiveDays> days = const Loading(),
  final Resource<void> toggleAction = const Initial(),
}) with Equatable {
  SensitiveDays? get currentDays => switch (days) {
    Success(:final value) => value,
    _ => null,
  };

  SensitiveDaysState copyWith({Resource<SensitiveDays>? days, Resource<void>? toggleAction}) =>
      SensitiveDaysState(days: days ?? this.days, toggleAction: toggleAction ?? this.toggleAction);

  @override
  List<Object?> get props => [days, toggleAction];
}
