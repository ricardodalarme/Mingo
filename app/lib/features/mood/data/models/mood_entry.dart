import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:equatable/equatable.dart';

/// One person's mood for one day.
final class const MoodEntry({
  required final String id,
  required final DateTime day,
  final MoodKind? mood,
  final NeedKind? need,
  final MoodShare share = MoodShare.none,
}) with Equatable {
  @override
  List<Object?> get props => [id, day, mood, need, share];
}
