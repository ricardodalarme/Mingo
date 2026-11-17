import 'package:app/features/memories/data/models/drawn_slip.dart';
import 'package:app/features/memories/data/repositories/memories_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jar_state.dart';

class JarCubit({required final MemoriesRepository _memoriesRepository}) extends Cubit<JarState> {
  this : super(const JarState());

  bool _isDrawing = false;

  /// Draws one slip from the jar; an empty jar says so instead of inventing something.
  Future<void> draw() async {
    if (_isDrawing) return;

    _isDrawing = true;
    emit(state.copyWith(slip: const Loading()));
    try {
      emit(state.copyWith(slip: Success(await _memoriesRepository.drawFromJar())));
    } catch (exception) {
      emit(state.copyWith(slip: Failure.fromObject(exception)));
    } finally {
      _isDrawing = false;
    }
  }
}
