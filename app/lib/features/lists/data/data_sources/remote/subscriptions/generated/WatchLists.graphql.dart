// dart format width=100
import '../../fragments/generated/ListFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchLists {
  SubscriptionWatchLists({required this.lists});

  factory SubscriptionWatchLists.fromJson(Map<String, dynamic> json) {
    final l$lists = json['lists'];
    return SubscriptionWatchLists(
      lists: (l$lists as List<dynamic>)
          .map((e) => FragmentListFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<FragmentListFragment> lists;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$lists = lists;
    _resultData['lists'] = l$lists.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$lists = lists;
    return Object.hashAll([Object.hashAll(l$lists.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchLists || runtimeType != other.runtimeType) {
      return false;
    }
    final l$lists = lists;
    final lOther$lists = other.lists;
    if (l$lists.length != lOther$lists.length) {
      return false;
    }
    for (int i = 0; i < l$lists.length; i++) {
      final l$lists$entry = l$lists[i];
      final lOther$lists$entry = lOther$lists[i];
      if (l$lists$entry != lOther$lists$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchLists = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchLists'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'lists'),
            alias: null,
            arguments: [
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
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '100'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ListFragment'),
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
    fragmentDefinitionListFragment,
  ],
);
SubscriptionWatchLists _parserFnSubscriptionWatchLists(Map<String, dynamic> data) =>
    SubscriptionWatchLists.fromJson(data);

class OptionsSubscriptionWatchLists extends graphql.SubscriptionOptions<SubscriptionWatchLists> {
  OptionsSubscriptionWatchLists({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchLists? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchLists',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchLists,
         parserFn: _parserFnSubscriptionWatchLists,
       );
}

class WatchOptionsSubscriptionWatchLists extends graphql.WatchQueryOptions<SubscriptionWatchLists> {
  WatchOptionsSubscriptionWatchLists({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchLists? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchLists',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchLists,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchLists,
       );
}

class FetchMoreOptionsSubscriptionWatchLists extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchLists({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchLists);
}

extension ClientExtensionSubscriptionWatchLists on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchLists>> subscribeWatchLists([
    OptionsSubscriptionWatchLists? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchLists());

  graphql.ObservableQuery<SubscriptionWatchLists> watchSubscriptionWatchLists([
    WatchOptionsSubscriptionWatchLists? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchLists());
}
