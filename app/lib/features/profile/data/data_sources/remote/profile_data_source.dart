import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/fragments/generated/ProfileFragment.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/SaveIntroAnswers.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/SaveProfileSetup.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/UpdateDisplayName.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/UpdatePartnerIntent.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/UpdatePronouns.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/UpdateRelationshipPhase.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/UpdateRelationshipStatus.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/UpdateTheme.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/UpdateTimeZone.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/mutations/generated/UpdateTogetherSince.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/queries/generated/MyProfile.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/queries/generated/MySettings.graphql.dart';
import 'package:network/network.dart';

class ProfileDataSource({required final GQLClient _client}) {
  Future<FragmentProfileFragment> getMyProfile(String userId) async {
    final response = await _client.query(
      OptionsQueryMyProfile(
        variables: VariablesQueryMyProfile(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return validateResponseData(response, getData: (data) => data.profilesByPk);
  }

  Future<QueryMySettingsuserSettingsByPk> getMySettings(String userId) async {
    final response = await _client.query(
      OptionsQueryMySettings(
        variables: VariablesQueryMySettings(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return validateResponseData(response, getData: (data) => data.userSettingsByPk);
  }

  /// Emits the person's profile, then again when it changes or a mutation succeeds.
  Stream<FragmentProfileFragment> watchMyProfile(String userId) {
    return _client
        .watch(
          WatchOptionsQueryMyProfile(
            variables: VariablesQueryMyProfile(userId: userId),
            fetchPolicy: FetchPolicy.cacheAndNetwork,
          ),
        )
        .mapResponseData((data) => data.profilesByPk);
  }

  /// Emits the person's settings, then again when they change or a mutation succeeds.
  Stream<QueryMySettingsuserSettingsByPk> watchMySettings(String userId) {
    return _client
        .watch(
          WatchOptionsQueryMySettings(
            variables: VariablesQueryMySettings(userId: userId),
            fetchPolicy: FetchPolicy.cacheAndNetwork,
          ),
        )
        .mapResponseData((data) => data.userSettingsByPk);
  }

  Future<void> saveIntroAnswers({
    required String profileId,
    EnumRelationshipPhase_enum? phase,
    EnumRelationshipGoal_enum? goal,
    List<String>? goals,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSaveIntroAnswers(
        variables: VariablesMutationSaveIntroAnswers(
          profileId: profileId,
          phase: phase,
          goal: goal,
          goals: goals,
        ),
      ),
    );

    validateResponse(response);
  }

  Future<void> saveProfileSetup({
    required String profileId,
    required String displayName,
    required EnumAppTheme_enum theme,
    required DateTime onboardedAt,
    EnumPronoun_enum? pronouns,
    String? partnerName,
    EnumPronoun_enum? partnerPronouns,
    DateTime? togetherSince,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSaveProfileSetup(
        variables: VariablesMutationSaveProfileSetup(
          profileId: profileId,
          displayName: displayName,
          pronouns: pronouns,
          theme: theme,
          partnerName: partnerName,
          partnerPronouns: partnerPronouns,
          togetherSince: togetherSince,
          onboardedAt: onboardedAt,
        ),
      ),
    );

    validateResponse(response);
  }

  /// Returns how many rows changed: one, or none when the person has no such row.
  Future<int> updateDisplayName({required String profileId, required String displayName}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateDisplayName(
        variables: VariablesMutationUpdateDisplayName(
          profileId: profileId,
          displayName: displayName,
        ),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateProfilesByPk == null ? 0 : 1,
    );
  }

  Future<int> updatePronouns({
    required String profileId,
    required EnumPronoun_enum? pronouns,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdatePronouns(
        variables: VariablesMutationUpdatePronouns(profileId: profileId, pronouns: pronouns),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateProfilesByPk == null ? 0 : 1,
    );
  }

  Future<int> updatePartnerIntent({
    required String profileId,
    required EnumPartnerIntent_enum? intent,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdatePartnerIntent(
        variables: VariablesMutationUpdatePartnerIntent(profileId: profileId, intent: intent),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }

  Future<int> updateTheme({required String profileId, required EnumAppTheme_enum theme}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateTheme(
        variables: VariablesMutationUpdateTheme(profileId: profileId, theme: theme),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }

  Future<int> updateTimeZone({required String profileId, required String timeZone}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateTimeZone(
        variables: VariablesMutationUpdateTimeZone(profileId: profileId, timeZone: timeZone),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateProfilesByPk == null ? 0 : 1,
    );
  }

  Future<int> updateRelationshipPhase({
    required String profileId,
    required EnumRelationshipPhase_enum? phase,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateRelationshipPhase(
        variables: VariablesMutationUpdateRelationshipPhase(profileId: profileId, phase: phase),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }

  Future<int> updateRelationshipStatus({
    required String profileId,
    required EnumRelationshipStatus_enum status,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateRelationshipStatus(
        variables: VariablesMutationUpdateRelationshipStatus(profileId: profileId, status: status),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }

  Future<int> updateTogetherSince({
    required String profileId,
    required DateTime? togetherSince,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateTogetherSince(
        variables: VariablesMutationUpdateTogetherSince(
          profileId: profileId,
          togetherSince: togetherSince,
        ),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }
}
