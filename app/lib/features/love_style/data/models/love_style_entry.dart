import 'package:app/features/love_style/data/models/love_pattern.dart';
import 'package:equatable/equatable.dart';

/// One person's saved result: the ordered patterns and whether they shared it.
final class const LoveStyleEntry({
  required final String id,
  required final List<String> ranked,
  final DateTime? sharedAt,
}) with Equatable {
  /// The stored ranking without keys this version does not know.
  List<String> get knownRanked => [
    for (final pattern in ranked)
      if (lovePatternKeys.contains(pattern)) pattern,
  ];

  bool get isShared => sharedAt != null;

  /// The leading pattern, or null when the stored ranking is empty.
  String? get topPattern => knownRanked.firstOrNull;

  @override
  List<Object?> get props => [id, ranked, sharedAt];
}

/// The person's own result and the partner's result when it was shared.
final class const LoveStyleOverview({final LoveStyleEntry? own, final LoveStyleEntry? partner})
    with Equatable {
  /// Whether both results are visible, which the comparison needs.
  bool get canCompare => own != null && partner != null;

  @override
  List<Object?> get props => [own, partner];
}

/// The two shared results side by side.
final class const LoveStyleComparison({
  required final List<String> own,
  required final List<String> partner,
}) with Equatable {
  /// The pattern that ranks highest for both people, so there is always a common one.
  String? get commonPattern {
    String? best;
    var bestScore = 0;
    for (final pattern in lovePatternKeys) {
      final ownIndex = own.indexOf(pattern);
      final partnerIndex = partner.indexOf(pattern);
      if (ownIndex < 0 || partnerIndex < 0) continue;
      final score = ownIndex + partnerIndex;
      if (best == null || score < bestScore) {
        best = pattern;
        bestScore = score;
      }
    }

    return best;
  }

  @override
  List<Object?> get props => [own, partner];
}
