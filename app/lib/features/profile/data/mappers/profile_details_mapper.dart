import 'package:app/features/profile/data/data_sources/remote/fragments/generated/ProfileFragment.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/queries/generated/MySettings.graphql.dart';
import 'package:app/features/profile/data/mappers/account_settings_mapper.dart';
import 'package:app/features/profile/data/mappers/pronoun_mapper.dart';
import 'package:app/features/profile/data/models/profile_details.dart';

extension ProfileDetailsMapper on FragmentProfileFragment {
  /// The profile with the time zone and theme kept in the person's [settings].
  ProfileDetails toDetails({required QueryMySettingsuserSettingsByPk settings}) => ProfileDetails(
    profileId: id,
    displayName: displayName ?? '',
    pronouns: pronouns?.toModel(),
    timeZone: settings.profile.timeZone,
    theme: settings.theme.toVariant(),
  );
}
