part of 'together_cubit.dart';

final class const TogetherState({
  final bool hasPartner = true,
  final bool showCheckin = true,
  final int listCount = 0,
  final int sharedGiftCount = 0,
  final String? questionTitle,
  final RelationshipPhase? phase,
  final DateTime? togetherSince,
}) with Equatable {
  TogetherState copyWith({
    bool? hasPartner,
    bool? showCheckin,
    int? listCount,
    int? sharedGiftCount,
    String? questionTitle,
    RelationshipPhase? phase,
    DateTime? togetherSince,
  }) {
    return TogetherState(
      hasPartner: hasPartner ?? this.hasPartner,
      showCheckin: showCheckin ?? this.showCheckin,
      listCount: listCount ?? this.listCount,
      sharedGiftCount: sharedGiftCount ?? this.sharedGiftCount,
      questionTitle: questionTitle ?? this.questionTitle,
      phase: phase ?? this.phase,
      togetherSince: togetherSince ?? this.togetherSince,
    );
  }

  @override
  List<Object?> get props => [
    hasPartner,
    showCheckin,
    listCount,
    sharedGiftCount,
    questionTitle,
    phase,
    togetherSince,
  ];
}
