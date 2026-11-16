import 'package:app/features/profile/data/models/partner_intent.dart';
import 'package:app/features/profile/data/models/pronoun.dart';
import 'package:app/features/profile/data/models/relationship_goal.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:design_system/design_system.dart';
import 'package:equatable/equatable.dart';

final class const AccountSettings({
  required final AppThemeVariant theme,
  final String profileId = '',
  final String timeZone = 'UTC',
  final String? partnerName,
  final Pronoun? partnerPronouns,
  final PartnerIntent? partnerIntent,
  final DateTime? togetherSince,
  final DateTime? onboardedAt,
  final bool shareReadReceipts = false,
  final RelationshipPhase? phase,
  final List<RelationshipGoal> goals = const [],
  final String locale = 'pt-BR',
}) with Equatable {
  /// Whether the person finished the first profile step.
  bool get isOnboarded => onboardedAt != null;

  @override
  List<Object?> get props => [
    theme,
    profileId,
    timeZone,
    partnerName,
    partnerPronouns,
    partnerIntent,
    togetherSince,
    onboardedAt,
    shareReadReceipts,
    phase,
    goals,
    locale,
  ];
}
