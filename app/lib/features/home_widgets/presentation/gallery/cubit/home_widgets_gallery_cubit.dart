import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/data/repositories/home_widgets_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_widgets_gallery_state.dart';

class HomeWidgetsGalleryCubit({required final HomeWidgetsRepository _repository})
    extends Cubit<HomeWidgetsGalleryState> {
  this : super(const HomeWidgetsGalleryState());

  Future<void> load() async {
    if (state.payload is! Success) emit(state.copyWith(payload: const Loading()));
    try {
      final payload = await _repository.loadAndSync();
      if (isClosed) return;
      emit(state.copyWith(payload: Success(payload)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed || state.payload is Success) return;
      emit(state.copyWith(payload: Failure.fromObject(exception)));
    }
  }
}
