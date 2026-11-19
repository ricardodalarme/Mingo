import 'package:app/features/connect/data/data_sources/remote/mutations/generated/SendMissUs.graphql.dart';
import 'package:network/network.dart';

class ConnectDataSource({required final GQLClient _client}) {
  Future<void> sendMissUs() async {
    final response = await _client.mutate(OptionsMutationSendMissUs());

    validateResponse(response);
  }
}
