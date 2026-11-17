import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/profile/data/data_sources/remote/profile_data_source.dart';
import 'package:app/features/profile/data/mappers/account_settings_mapper.dart';
import 'package:app/features/profile/data/mappers/partner_intent_mapper.dart';
import 'package:app/features/profile/data/mappers/profile_details_mapper.dart';
import 'package:app/features/profile/data/mappers/profile_mapper.dart';
import 'package:app/features/profile/data/mappers/pronoun_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_details_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_goal_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_phase_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_status_mapper.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/models/partner_intent.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/models/profile_details.dart';
import 'package:app/features/profile/data/models/pronoun.dart';
import 'package:app/features/profile/data/models/relationship_details.dart';
import 'package:app/features/profile/data/models/relationship_goal.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/profile/data/models/relationship_status.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';

class ProfileRepository({
  required final ProfileDataSource _profileDataSource,
  required final AuthenticationRepository _authenticationRepository,
}) {
  String get _userId {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) throw const LocalizedException(l10nKey: 'UNAUTHENTICATED');

    return userId;
  }

  Future<Profile> getMyProfile() async {
    return (await _profileDataSource.getMyProfile(_userId)).toModel();
  }

  /// The profile row the backend keeps for the signed-in user.
  Future<Profile> ensureProfile() => getMyProfile();

  Future<ProfileDetails> getProfileDetails() async {
    final userId = _userId;
    final profile = await _profileDataSource.getMyProfile(userId);
    final settings = await _profileDataSource.getMySettings(userId);
    return profile.toDetails(settings: settings);
  }

  Future<RelationshipDetails> getRelationshipDetails() async {
    final settings = await _profileDataSource.getMySettings(_userId);
    return settings.toRelationshipDetails();
  }

  Future<void> updateDisplayName({required String profileId, required String displayName}) async {
    final affected = await _profileDataSource.updateDisplayName(
      profileId: profileId,
      displayName: displayName,
    );
    _ensureUpdated(affected);
  }

  Future<void> updatePronouns({required String profileId, required Pronoun? pronouns}) async {
    final affected = await _profileDataSource.updatePronouns(
      profileId: profileId,
      pronouns: pronouns?.toRemote(),
    );
    _ensureUpdated(affected);
  }

  Future<void> updatePartnerIntent({
    required String profileId,
    required PartnerIntent? intent,
  }) async {
    final affected = await _profileDataSource.updatePartnerIntent(
      profileId: profileId,
      intent: intent?.toRemote(),
    );
    _ensureUpdated(affected);
  }

  Future<void> updateTheme({required String profileId, required AppThemeVariant theme}) async {
    final affected = await _profileDataSource.updateTheme(
      profileId: profileId,
      theme: theme.toServerTheme(),
    );
    _ensureUpdated(affected);
  }

  Future<void> updateTimeZone({required String profileId, required String timeZone}) async {
    final affected = await _profileDataSource.updateTimeZone(
      profileId: profileId,
      timeZone: timeZone,
    );
    _ensureUpdated(affected);
  }

  Future<void> updateRelationshipPhase({
    required String profileId,
    required RelationshipPhase? phase,
  }) async {
    final affected = await _profileDataSource.updateRelationshipPhase(
      profileId: profileId,
      phase: phase?.toRemote(),
    );
    _ensureUpdated(affected);
  }

  Future<void> updateTogetherSince({
    required String profileId,
    required DateTime? togetherSince,
  }) async {
    final affected = await _profileDataSource.updateTogetherSince(
      profileId: profileId,
      togetherSince: togetherSince,
    );
    _ensureUpdated(affected);
  }

  Future<void> updateRelationshipStatus({
    required String profileId,
    required RelationshipStatus status,
  }) async {
    final affected = await _profileDataSource.updateRelationshipStatus(
      profileId: profileId,
      status: status.toRemote(),
    );
    _ensureUpdated(affected);
  }

  void _ensureUpdated(int affected) {
    if (affected != 1) throw const LocalizedException(l10nKey: 'UPDATE_FAILED');
  }

  /// Emits the person's profile now and each time it changes, from any screen.
  ///
  /// Empty while signed out. A failure is passed on.
  Stream<Profile> watchMyProfile() {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) return const Stream.empty();

    return _profileDataSource.watchMyProfile(userId).map((node) => node.toModel());
  }

  /// Emits the person's settings now and each time they change, from any screen.
  ///
  /// Empty while signed out. A failure is passed on.
  Stream<AccountSettings> watchMySettings() {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) return const Stream.empty();

    return _profileDataSource.watchMySettings(userId).map((node) => node.toModel());
  }

  Future<AccountSettings> getMySettings() async {
    return (await _profileDataSource.getMySettings(_userId)).toModel();
  }

  /// Sends the answers given in the first-use introduction; the goals replace any saved before.
  Future<void> saveIntroAnswers({
    required String profileId,
    RelationshipPhase? phase,
    List<RelationshipGoal> goals = const [],
  }) async {
    await _profileDataSource.saveIntroAnswers(
      profileId: profileId,
      phase: phase?.toRemote(),
      goals: [for (final goal in goals) goal.toRemote()],
    );
  }

  /// Saves the names, how each person is addressed, the theme and the relationship date, and marks
  /// the person as onboarded.
  Future<void> saveProfileSetup({
    required String profileId,
    required String displayName,
    required AppThemeVariant theme,
    Pronoun? pronouns,
    String? partnerName,
    Pronoun? partnerPronouns,
    DateTime? togetherSince,
  }) async {
    await _profileDataSource.saveProfileSetup(
      profileId: profileId,
      displayName: displayName,
      pronouns: pronouns?.toRemote(),
      theme: theme.toServerTheme(),
      partnerName: partnerName,
      partnerPronouns: partnerPronouns?.toRemote(),
      togetherSince: togetherSince,
      onboardedAt: clock.now().toUtc(),
    );
  }
}
