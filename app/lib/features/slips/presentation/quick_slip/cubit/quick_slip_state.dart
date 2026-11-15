part of 'quick_slip_cubit.dart';

final class const QuickSlipState({
  final FormInput<String> text = const FormInput(''),
  final SlipCategory? category,
  final SlipPolarity polarity = SlipPolarity.liked,
  final Resource<SlipSaveOutcome> saveAction = const Initial(),
  final Resource<void> undoAction = const Initial(),
  final bool canUndo = false,
}) with Equatable {
  /// Whether the saved confirmation is showing.
  bool get isSaved => saveAction is Success;

  /// Whether there is text, a category or a bothered slip to lose.
  bool get hasDraft =>
      text.value.trim().isNotEmpty || category != null || polarity == SlipPolarity.bothered;

  QuickSlipState copyWith({
    FormInput<String>? text,
    SlipCategory? category,
    bool clearCategory = false,
    SlipPolarity? polarity,
    Resource<SlipSaveOutcome>? saveAction,
    Resource<void>? undoAction,
    bool? canUndo,
  }) {
    return QuickSlipState(
      text: text ?? this.text,
      category: clearCategory ? null : category ?? this.category,
      polarity: polarity ?? this.polarity,
      saveAction: saveAction ?? this.saveAction,
      undoAction: undoAction ?? this.undoAction,
      canUndo: canUndo ?? this.canUndo,
    );
  }

  @override
  List<Object?> get props => [text, category, polarity, saveAction, undoAction, canUndo];
}
