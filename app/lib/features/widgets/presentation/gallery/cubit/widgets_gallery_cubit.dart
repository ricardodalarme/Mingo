import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets_gallery_state.dart';

class WidgetsGalleryCubit({required final WidgetsRepository _repository})
    extends Cubit<WidgetsGalleryState> {
  this : super(const WidgetsGalleryState());

  Future<void> load() async {
    if (state.overview is! Success) emit(state.copyWith(overview: const Loading()));
    try {
      final overview = await _repository.loadAndSync();
      if (isClosed) return;
      emit(state.copyWith(overview: Success(overview)));
    } catch (exception) {
      if (isClosed || state.overview is Success) return;
      emit(state.copyWith(overview: Failure.fromObject(exception)));
    }
  }

  /// Saves the two widget privacy toggles and refreshes the payload.
  Future<void> savePrivacy({required bool showNames, required bool allowPartnerNotes}) async {
    if (state.saveAction is Loading) return;

    emit(state.copyWith(saveAction: const Loading()));
    try {
      final overview = await _repository.savePrivacy(
        showNames: showNames,
        allowPartnerNotes: allowPartnerNotes,
      );
      if (isClosed) return;
      emit(state.copyWith(overview: Success(overview), saveAction: const Success(null)));
      emit(state.copyWith(saveAction: const Initial()));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));
    }
  }
}
