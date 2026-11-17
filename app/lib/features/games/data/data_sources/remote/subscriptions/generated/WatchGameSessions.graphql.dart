// dart format width=100
import '../../fragments/generated/GameSessionFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchGameSessions {
  SubscriptionWatchGameSessions({required this.gameSessions});

  factory SubscriptionWatchGameSessions.fromJson(Map<String, dynamic> json) {
    final l$gameSessions = json['gameSessions'];
    return SubscriptionWatchGameSessions(
      gameSessions: (l$gameSessions as List<dynamic>)
          .map((e) => FragmentGameSessionFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<FragmentGameSessionFragment> gameSessions;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$gameSessions = gameSessions;
    _resultData['gameSessions'] = l$gameSessions.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$gameSessions = gameSessions;
    return Object.hashAll([Object.hashAll(l$gameSessions.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchGameSessions || runtimeType != other.runtimeType) {
      return false;
    }
    final l$gameSessions = gameSessions;
    final lOther$gameSessions = other.gameSessions;
    if (l$gameSessions.length != lOther$gameSessions.length) {
      return false;
    }
    for (int i = 0; i < l$gameSessions.length; i++) {
      final l$gameSessions$entry = l$gameSessions[i];
      final lOther$gameSessions$entry = lOther$gameSessions[i];
      if (l$gameSessions$entry != lOther$gameSessions$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchGameSessions = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchGameSessions'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'gameSessions'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '40'),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'createdAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'GameSessionFragment'),
                  directives: [],
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionGameSessionFragment,
  ],
);
SubscriptionWatchGameSessions _parserFnSubscriptionWatchGameSessions(Map<String, dynamic> data) =>
    SubscriptionWatchGameSessions.fromJson(data);

class OptionsSubscriptionWatchGameSessions
    extends graphql.SubscriptionOptions<SubscriptionWatchGameSessions> {
  OptionsSubscriptionWatchGameSessions({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchGameSessions? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchGameSessions',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchGameSessions,
         parserFn: _parserFnSubscriptionWatchGameSessions,
       );
}

class WatchOptionsSubscriptionWatchGameSessions
    extends graphql.WatchQueryOptions<SubscriptionWatchGameSessions> {
  WatchOptionsSubscriptionWatchGameSessions({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchGameSessions? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchGameSessions',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchGameSessions,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchGameSessions,
       );
}

class FetchMoreOptionsSubscriptionWatchGameSessions extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchGameSessions({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchGameSessions);
}

extension ClientExtensionSubscriptionWatchGameSessions on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchGameSessions>> subscribeWatchGameSessions([
    OptionsSubscriptionWatchGameSessions? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchGameSessions());

  graphql.ObservableQuery<SubscriptionWatchGameSessions> watchSubscriptionWatchGameSessions([
    WatchOptionsSubscriptionWatchGameSessions? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchGameSessions());
}
