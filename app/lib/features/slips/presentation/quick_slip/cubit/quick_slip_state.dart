part of 'quick_slip_cubit.dart';

/// What the person is writing: something good, or something that bothered them.
enum QuickSlipMode() {
  liked,
  annoyance,
}

final class const QuickSlipState({
  final QuickSlipMode mode = QuickSlipMode.liked,
  final FormInput<String> text = const FormInput(''),
  final SlipCategory? category,
  final bool forCardByDefault = false,
  final Resource<SlipSaveOutcome> saveAction = const Initial(),
  final Resource<void> undoAction = const Initial(),
  final bool canUndo = false,
}) with Equatable {
  /// Whether the saved confirmation is showing.
  bool get isSaved => saveAction is Success;

  /// Whether there is text or a category to lose.
  bool get hasDraft => text.value.trim().isNotEmpty || category != null;

  QuickSlipState copyWith({
    QuickSlipMode? mode,
    FormInput<String>? text,
    SlipCategory? category,
    bool? forCardByDefault,
    bool clearCategory = false,
    Resource<SlipSaveOutcome>? saveAction,
    Resource<void>? undoAction,
    bool? canUndo,
  }) {
    return QuickSlipState(
      mode: mode ?? this.mode,
      text: text ?? this.text,
      category: clearCategory ? null : category ?? this.category,
      forCardByDefault: forCardByDefault ?? this.forCardByDefault,
      saveAction: saveAction ?? this.saveAction,
      undoAction: undoAction ?? this.undoAction,
      canUndo: canUndo ?? this.canUndo,
    );
  }

  @override
  List<Object?> get props => [
    mode,
    text,
    category,
    forCardByDefault,
    saveAction,
    undoAction,
    canUndo,
  ];
}
