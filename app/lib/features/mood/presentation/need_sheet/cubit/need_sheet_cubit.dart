import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'need_sheet_state.dart';

class NeedSheetCubit() extends Cubit<NeedSheetState> {
  this : super(const NeedSheetState());

  void start({required MoodKind? mood, required NeedKind? need, required MoodShare share}) {
    emit(NeedSheetState(mood: mood, need: need, share: share));
  }

  void selectMood(MoodKind mood) => emit(state.copyWith(mood: mood));

  /// Tapping the selected need clears it, because a day carries one need.
  void selectNeed(NeedKind need) {
    final isSame = state.need == need;
    emit(state.copyWith(need: isSame ? null : need, clearNeed: isSame));
  }

  /// The choice to save, or null when the person has not picked a mood yet.
  NeedDraft? submit() {
    final mood = state.mood;

    return mood == null ? null : NeedDraft(mood: mood, need: state.need);
  }
}
