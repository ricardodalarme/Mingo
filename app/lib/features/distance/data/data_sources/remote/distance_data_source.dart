import 'package:app/features/distance/data/data_sources/remote/queries/generated/PartnerTimeZone.graphql.dart';
import 'package:network/network.dart';

class DistanceDataSource({required final GQLClient _client}) {
  /// The partner's IANA time zone, or null when there is no partner.
  Future<String?> getPartnerTimeZone(String userId) async {
    final response = await _client.query(
      OptionsQueryPartnerTimeZone(
        variables: VariablesQueryPartnerTimeZone(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final couples = validateResponseData(response, getData: (data) => data.couples);

    return couples.firstOrNull?.members.firstOrNull?.profile.timeZone;
  }
}
