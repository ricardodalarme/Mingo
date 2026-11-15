part of 'mood_cubit.dart';

final class const MoodState({
  final Resource<MoodEntry?> entry = const Loading(),
  final PartnerMood? partnerMood,
  final MoodKind? mood,
  final NeedKind? need,
  final MoodShare share = MoodShare.none,
  final String? partnerName,
  final Resource<void> saveAction = const Initial(),
  final Resource<void> needAction = const Initial(),
  final Resource<void> reactAction = const Initial(),
  final Resource<void> talkAction = const Initial(),
  final Resource<void> messageAction = const Initial(),
}) with Equatable {
  /// Whether a mood is chosen and a need is present when the need is shared.
  bool get canSave =>
      mood != null && !saveAction.isLoading && (share != MoodShare.moodNeed || need != null);

  MoodState copyWith({
    Resource<MoodEntry?>? entry,
    PartnerMood? partnerMood,
    MoodKind? mood,
    NeedKind? need,
    MoodShare? share,
    String? partnerName,
    Resource<void>? saveAction,
    Resource<void>? needAction,
    Resource<void>? reactAction,
    Resource<void>? talkAction,
    Resource<void>? messageAction,
    bool clearMood = false,
    bool clearNeed = false,
    bool clearPartnerMood = false,
    bool clearPartnerName = false,
  }) {
    return MoodState(
      entry: entry ?? this.entry,
      partnerMood: clearPartnerMood ? null : partnerMood ?? this.partnerMood,
      mood: clearMood ? null : mood ?? this.mood,
      need: clearNeed ? null : need ?? this.need,
      share: share ?? this.share,
      partnerName: clearPartnerName ? partnerName : partnerName ?? this.partnerName,
      saveAction: saveAction ?? this.saveAction,
      needAction: needAction ?? this.needAction,
      reactAction: reactAction ?? this.reactAction,
      talkAction: talkAction ?? this.talkAction,
      messageAction: messageAction ?? this.messageAction,
    );
  }

  @override
  List<Object?> get props => [
    entry,
    partnerMood,
    mood,
    need,
    share,
    partnerName,
    saveAction,
    needAction,
    reactAction,
    talkAction,
    messageAction,
  ];
}
