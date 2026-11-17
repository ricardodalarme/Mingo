import 'package:app/features/slips/data/models/drawn_slip.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jar_state.dart';

class JarCubit({required final SlipRepository _slipRepository}) extends Cubit<JarState> {
  this : super(const JarState());

  bool _isDrawing = false;

  /// Draws one slip from the jar; an empty jar says so instead of inventing something.
  Future<void> draw() async {
    if (_isDrawing) return;

    _isDrawing = true;
    emit(state.copyWith(slip: const Loading()));
    try {
      emit(state.copyWith(slip: Success(await _slipRepository.drawFromJar())));
    } catch (exception) {
      emit(state.copyWith(slip: Failure.fromObject(exception)));
    } finally {
      _isDrawing = false;
    }
  }
}
