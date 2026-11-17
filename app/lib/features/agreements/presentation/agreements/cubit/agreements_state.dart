part of 'agreements_cubit.dart';

final class const AgreementsState({
  final Resource<List<Agreement>> agreements = const Loading(),
  final String? coupleId,
  final Resource<void> changeAction = const Initial(),
}) with Equatable {
  /// The agreements on screen, or none while they are not read.
  List<Agreement> get current => switch (agreements) {
    Success(:final value) => value,
    _ => const [],
  };

  AgreementsState copyWith({
    Resource<List<Agreement>>? agreements,
    String? coupleId,
    Resource<void>? changeAction,
  }) {
    return AgreementsState(
      agreements: agreements ?? this.agreements,
      coupleId: coupleId ?? this.coupleId,
      changeAction: changeAction ?? this.changeAction,
    );
  }

  @override
  List<Object?> get props => [agreements, coupleId, changeAction];
}
