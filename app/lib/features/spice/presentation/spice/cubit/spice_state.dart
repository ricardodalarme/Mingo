part of 'spice_cubit.dart';

final class const SpiceState({
  final Resource<SpiceView> view = const Loading(),
  final int index = 0,
  final bool shouldExit = false,
  final Resource<void> toggleAction = const Initial(),
}) with Equatable {
  SpiceState copyWith({
    Resource<SpiceView>? view,
    int? index,
    bool? shouldExit,
    Resource<void>? toggleAction,
  }) {
    return SpiceState(
      view: view ?? this.view,
      index: index ?? this.index,
      shouldExit: shouldExit ?? this.shouldExit,
      toggleAction: toggleAction ?? this.toggleAction,
    );
  }

  @override
  List<Object?> get props => [view, index, shouldExit, toggleAction];
}
