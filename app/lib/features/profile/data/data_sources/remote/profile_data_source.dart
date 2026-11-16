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
      getData: (data) => data.updateProfiles?.affected_rows ?? 0,
    );
  }

  Future<int> updatePronouns(VariablesMutationUpdatePronouns variables) async {
    final response = await _client.mutate(OptionsMutationUpdatePronouns(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateProfiles?.affected_rows ?? 0,
    );
  }

  Future<int> updatePartnerIntent(VariablesMutationUpdatePartnerIntent variables) async {
    final response = await _client.mutate(OptionsMutationUpdatePartnerIntent(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettings?.affected_rows ?? 0,
    );
  }

  Future<int> updateTheme(VariablesMutationUpdateTheme variables) async {
    final response = await _client.mutate(OptionsMutationUpdateTheme(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettings?.affected_rows ?? 0,
    );
  }

  Future<int> updateTimeZone(VariablesMutationUpdateTimeZone variables) async {
    final response = await _client.mutate(OptionsMutationUpdateTimeZone(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateProfiles?.affected_rows ?? 0,
    );
  }

  Future<int> updateRelationshipPhase(VariablesMutationUpdateRelationshipPhase variables) async {
    final response = await _client.mutate(
      OptionsMutationUpdateRelationshipPhase(variables: variables),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettings?.affected_rows ?? 0,
    );
  }

  Future<int> updateRelationshipStatus(VariablesMutationUpdateRelationshipStatus variables) async {
    final response = await _client.mutate(
      OptionsMutationUpdateRelationshipStatus(variables: variables),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettings?.affected_rows ?? 0,
    );
  }

  Future<int> updateTogetherSince(VariablesMutationUpdateTogetherSince variables) async {
    final response = await _client.mutate(OptionsMutationUpdateTogetherSince(variables: variables));

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettings?.affected_rows ?? 0,
    );
  }
}
