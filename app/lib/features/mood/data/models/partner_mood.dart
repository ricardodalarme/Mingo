import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:equatable/equatable.dart';

/// The mood the partner chose to share today; [need] arrives only when shared.
final class const PartnerMood({final DateTime? day, final MoodKind? mood, final NeedKind? need})
    with Equatable {
  /// Whether there is a mood worth showing; an unknown server value stays hidden.
  bool get isVisible => mood != null;

  @override
  List<Object?> get props => [day, mood, need];
}
