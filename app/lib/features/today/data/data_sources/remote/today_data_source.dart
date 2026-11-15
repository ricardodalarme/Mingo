import 'package:app/features/today/data/data_sources/remote/queries/generated/TodayHome.graphql.dart';
import 'package:network/network.dart';

class TodayDataSource({required final GQLClient _client}) {
  Future<QueryTodayHome> getHome() async {
    final response = await _client.query(
      OptionsQueryTodayHome(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response);
  }
}
