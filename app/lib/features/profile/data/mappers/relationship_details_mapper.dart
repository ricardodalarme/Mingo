import 'package:app/features/profile/data/data_sources/remote/queries/generated/MySettings.graphql.dart';
import 'package:app/features/profile/data/mappers/relationship_phase_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_status_mapper.dart';
import 'package:app/features/profile/data/models/relationship_details.dart';

extension RelationshipDetailsMapper on QueryMySettingsuserSettingsByPk {
  RelationshipDetails toRelationshipDetails() => RelationshipDetails(
    profileId: userId,
    phase: phase?.toModel(),
    togetherSince: togetherSince,
    relationshipStatus: relationshipStatus.toModel(),
  );
}
