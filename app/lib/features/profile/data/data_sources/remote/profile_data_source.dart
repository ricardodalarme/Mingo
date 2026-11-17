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

  Future<void> saveIntroAnswers(VariablesMutationSaveIntroAnswers variables) async {
    final response = await _client.mutate(OptionsMutationSaveIntroAnswers(variables: variables));

    validateResponse(response);
  }

  Future<void> saveProfileSetup(VariablesMutationSaveProfileSetup variables) async {
    final response = await _client.mutate(OptionsMutationSaveProfileSetup(variables: variables));

    validateResponse(response);
  }

  Future<int> updateDisplayName(VariablesMutationUpdateDisplayName variables) async {
    final response = await _client.mutate(OptionsMutationUpdateDisplayName(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateProfilesByPk == null ? 0 : 1,
    );
  }

  Future<int> updatePronouns(VariablesMutationUpdatePronouns variables) async {
    final response = await _client.mutate(OptionsMutationUpdatePronouns(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateProfilesByPk == null ? 0 : 1,
    );
  }

  Future<int> updatePartnerIntent(VariablesMutationUpdatePartnerIntent variables) async {
    final response = await _client.mutate(OptionsMutationUpdatePartnerIntent(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }

  Future<int> updateTheme(VariablesMutationUpdateTheme variables) async {
    final response = await _client.mutate(OptionsMutationUpdateTheme(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }

  Future<int> updateTimeZone(VariablesMutationUpdateTimeZone variables) async {
    final response = await _client.mutate(OptionsMutationUpdateTimeZone(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateProfilesByPk == null ? 0 : 1,
    );
  }

  Future<int> updateRelationshipPhase(VariablesMutationUpdateRelationshipPhase variables) async {
    final response = await _client.mutate(
      OptionsMutationUpdateRelationshipPhase(variables: variables),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }

  Future<int> updateRelationshipStatus(VariablesMutationUpdateRelationshipStatus variables) async {
    final response = await _client.mutate(
      OptionsMutationUpdateRelationshipStatus(variables: variables),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }

  Future<int> updateTogetherSince(VariablesMutationUpdateTogetherSince variables) async {
    final response = await _client.mutate(OptionsMutationUpdateTogetherSince(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettingsByPk == null ? 0 : 1,
    );
  }
}
