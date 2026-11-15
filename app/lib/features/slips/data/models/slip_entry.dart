import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_polarity.dart';
import 'package:equatable/equatable.dart';

/// A slip as shown in the list.
final class const SlipEntry({
  required final String id,
  required final String body,
  required final DateTime createdAt,
  final SlipKind kind = SlipKind.quick,
  final SlipCategory? category,
  final SlipPolarity polarity = SlipPolarity.liked,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => SlipEntry(id: 'fake', body: 'Fez café sem eu pedir', createdAt: DateTime(2026));

  /// Whether the slip is one of the bothered ones, kept private.
  bool get isPrivate => polarity == SlipPolarity.bothered;

  @override
  List<Object?> get props => [id, body, createdAt, kind, category, polarity];
}

/// One page of slips and where the next one starts.
final class const SlipPage({
  required final List<SlipEntry> items,
  required final bool hasNext,
  final String? cursor,
}) with Equatable {
  @override
  List<Object?> get props => [items, hasNext, cursor];
}
