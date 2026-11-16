import 'package:app/features/connect/data/data_sources/remote/mutations/generated/SendMissUs.graphql.dart';
import 'package:app/features/connect/data/data_sources/remote/mutations/generated/SetTouchTopics.graphql.dart';
import 'package:app/features/connect/data/data_sources/remote/queries/generated/CoupleTouchSetting.graphql.dart';
import 'package:network/network.dart';

/// The couple and whether touch topics are on for both.
typedef CoupleTouchRecord = ({String coupleId, bool touchTopicsEnabled});

class ConnectDataSource({required final GQLClient _client}) {
  /// The person's couple; null when they are not in one.
  Future<CoupleTouchRecord?> getTouchSetting(String userId) async {
    final response = await _client.query(
      OptionsQueryCoupleTouchSetting(
        variables: VariablesQueryCoupleTouchSetting(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final couple = validateResponseData(response, getData: (data) => data.couples.firstOrNull);

    return (coupleId: couple.id, touchTopicsEnabled: couple.touchTopicsEnabled);
  }

  Future<void> setTouchTopics({required String coupleId, required bool enabled}) async {
    final response = await _client.mutate(
      OptionsMutationSetTouchTopics(
        variables: VariablesMutationSetTouchTopics(coupleId: coupleId, enabled: enabled),
      ),
    );

    validateResponse(response);
  }

  Future<void> sendMissUs() async {
    final response = await _client.mutate(OptionsMutationSendMissUs());

    validateResponse(response);
  }
}
