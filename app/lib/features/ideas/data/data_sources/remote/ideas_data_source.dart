import 'package:app/features/today/data/data_sources/remote/queries/generated/DailyIdeas.graphql.dart';
import 'package:network/network.dart';

class IdeasDataSource({required final GQLClient _client}) {
  Future<List<QueryDailyIdeascontentItems>> getIdeas(String locale) async {
    final response = await _client.query(
      OptionsQueryDailyIdeas(variables: VariablesQueryDailyIdeas(locale: locale)),
    );

    return validateResponseData(response, getData: (data) => data.contentItems);
  }
}
