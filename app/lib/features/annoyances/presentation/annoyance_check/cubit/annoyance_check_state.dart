part of 'annoyance_check_cubit.dart';

final class const AnnoyanceCheckState({
  final Resource<Annoyance?> annoyance = const Loading(),
  final Resource<void> letGoAction = const Initial(),
}) with Equatable {
  AnnoyanceCheckState copyWith({Resource<Annoyance?>? annoyance, Resource<void>? letGoAction}) {
    return AnnoyanceCheckState(
      annoyance: annoyance ?? this.annoyance,
      letGoAction: letGoAction ?? this.letGoAction,
    );
  }

  @override
  List<Object?> get props => [annoyance, letGoAction];
}
