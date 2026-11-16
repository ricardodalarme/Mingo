import 'package:equatable/equatable.dart';

/// Which of the person's slips a list or a search wants.
final class const SlipFilter({
  final DateTime? since,
  final bool? inCard,
  final bool onlyInvisible = false,
  final String text = '',
}) with Equatable {
  SlipFilter copyWith({DateTime? since, bool? inCard, bool? onlyInvisible, String? text}) =>
      SlipFilter(
        since: since ?? this.since,
        inCard: inCard ?? this.inCard,
        onlyInvisible: onlyInvisible ?? this.onlyInvisible,
        text: text ?? this.text,
      );

  @override
  List<Object?> get props => [since, inCard, onlyInvisible, text];
}
