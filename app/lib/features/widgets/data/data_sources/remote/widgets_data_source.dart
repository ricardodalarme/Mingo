import 'package:app/features/widgets/data/data_sources/remote/queries/generated/WidgetOverview.graphql.dart';
import 'package:network/network.dart';

class WidgetsDataSource({required final GQLClient _client}) {
  Future<QueryWidgetOverview> getOverview() async {
    final response = await _client.query(
      OptionsQueryWidgetOverview(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response);
  }
}
