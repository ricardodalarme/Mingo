import 'package:app/features/notifications/data/data_sources/remote/mutations/generated/MarkInboxRead.graphql.dart';
import 'package:app/features/notifications/data/data_sources/remote/queries/generated/MyInbox.graphql.dart';
import 'package:app/features/notifications/data/data_sources/remote/subscriptions/generated/WatchUnreadInbox.graphql.dart';
import 'package:network/network.dart';

class InboxDataSource({required final GQLClient _client}) {
  /// The newest items first, at most [limit].
  Future<List<QueryMyInboxinboxItems>> getItems(int limit) async {
    final response = await _client.query(
      OptionsQueryMyInbox(
        variables: VariablesQueryMyInbox(limit: limit),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return validateResponseData(response, getData: (data) => data.inboxItems);
  }

  Future<void> markAllRead(DateTime readAt) async {
    final response = await _client.mutate(
      OptionsMutationMarkInboxRead(variables: VariablesMutationMarkInboxRead(readAt: readAt)),
    );

    validateResponse(response);
  }

  /// Emits how many items are unread, now and each time that changes.
  Stream<int> watchUnreadCount() {
    return _client
        .subscribe(OptionsSubscriptionWatchUnreadInbox())
        .mapResponseData((data) => data.inboxItemsAggregate.aggregate?.count ?? 0);
  }
}
