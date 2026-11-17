import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lock_screen_widget_state.dart';

class LockScreenWidgetCubit({required final WidgetsRepository _repository})
    extends Cubit<LockScreenWidgetState> {
  this : super(const LockScreenWidgetState());

  Future<void> load() async {
    emit(state.copyWith(overview: const Loading()));
    try {
      final overview = await _repository.loadAndSync();
      if (isClosed) return;
      emit(state.copyWith(overview: Success(overview)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed || state.overview is Success) return;
      emit(state.copyWith(overview: Failure.fromObject(exception)));
    }
  }
}
