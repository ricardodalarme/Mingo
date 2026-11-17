import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'card_encounter_widget_state.dart';

class CardEncounterWidgetCubit({required final WidgetsRepository _repository})
    extends Cubit<CardEncounterWidgetState> {
  this : super(const CardEncounterWidgetState());

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
}
