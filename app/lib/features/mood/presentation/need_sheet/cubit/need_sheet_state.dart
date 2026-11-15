part of 'need_sheet_cubit.dart';

/// The need the person chose, with the mood the day needs to store it.
final class const NeedDraft({required final MoodKind mood, final NeedKind? need});

final class const NeedSheetState({
  final MoodKind? mood,
  final NeedKind? need,
  final MoodShare share = MoodShare.none,
}) with Equatable {
  bool get canSave => mood != null;

  NeedSheetState copyWith({MoodKind? mood, NeedKind? need, bool clearNeed = false}) =>
      NeedSheetState(
        mood: mood ?? this.mood,
        need: clearNeed ? null : need ?? this.need,
        share: share,
      );

  @override
  List<Object?> get props => [mood, need, share];
}
