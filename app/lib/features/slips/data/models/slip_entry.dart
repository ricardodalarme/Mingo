import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:equatable/equatable.dart';

/// A slip as shown in the list.
final class const SlipEntry({
  required final String id,
  required final String body,
  required final DateTime createdAt,
  final SlipKind kind = SlipKind.quick,
  final SlipCategory? category,
  final bool forCard = true,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => SlipEntry(id: 'fake', body: 'Fez café sem eu pedir', createdAt: DateTime(2026));

  /// Whether the slip stays out of the weekly card.
  bool get isPrivate => !forCard;

  @override
  List<Object?> get props => [id, body, createdAt, kind, category, forCard];
}
