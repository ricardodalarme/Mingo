part of 'compose_cubit.dart';

enum DrawingTool() {
  pen,
  eraser,
}

final class const ComposeState({
  final Resource<List<SentMessage>> sent = const Loading(),
  final MessageKind kind = MessageKind.note,
  final bool isDrawing = false,
  final FormInput<String> text = const FormInput(''),
  final List<DrawingStroke> strokes = const [],
  final DrawingTool tool = DrawingTool.pen,
  final int penIndex = 0,
  final bool? isPaired,
  final Resource<void> sendAction = const Initial(),
  final Resource<void> deleteAction = const Initial(),
}) with Equatable {
  /// Whether the person is known to have no partner to send to.
  bool get isUnpaired => isPaired == false;

  ComposeState copyWith({
    Resource<List<SentMessage>>? sent,
    MessageKind? kind,
    bool? isDrawing,
    FormInput<String>? text,
    List<DrawingStroke>? strokes,
    DrawingTool? tool,
    int? penIndex,
    bool? isPaired,
    Resource<void>? sendAction,
    Resource<void>? deleteAction,
  }) {
    return ComposeState(
      sent: sent ?? this.sent,
      kind: kind ?? this.kind,
      isDrawing: isDrawing ?? this.isDrawing,
      text: text ?? this.text,
      strokes: strokes ?? this.strokes,
      tool: tool ?? this.tool,
      penIndex: penIndex ?? this.penIndex,
      isPaired: isPaired ?? this.isPaired,
      sendAction: sendAction ?? this.sendAction,
      deleteAction: deleteAction ?? this.deleteAction,
    );
  }

  @override
  List<Object?> get props => [
    sent,
    kind,
    isDrawing,
    text,
    strokes,
    tool,
    penIndex,
    isPaired,
    sendAction,
    deleteAction,
  ];
}
