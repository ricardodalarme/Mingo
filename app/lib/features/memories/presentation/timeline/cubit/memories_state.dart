part of 'memories_cubit.dart';

final class const MemoriesState({
  final Resource<List<Memory>> memories = const Loading(),
  final Resource<void> saveAction = const Initial(),
}) with Equatable {
  MemoriesState copyWith({Resource<List<Memory>>? memories, Resource<void>? saveAction}) {
    return MemoriesState(
      memories: memories ?? this.memories,
      saveAction: saveAction ?? this.saveAction,
    );
  }

  @override
  List<Object?> get props => [memories, saveAction];
}
