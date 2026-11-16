import 'package:app/features/plus/data/data_sources/remote/queries/generated/MyPlus.graphql.dart';
import 'package:network/network.dart';

class PlusDataSource({required final GQLClient _client}) {
  Future<QueryMyPlusplusStates> getPlus(String userId) async {
    final response = await _client.query(
      OptionsQueryMyPlus(
        variables: VariablesQueryMyPlus(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return validateResponseData(response, getData: (data) => data.plusStates.firstOrNull);
  }
}
