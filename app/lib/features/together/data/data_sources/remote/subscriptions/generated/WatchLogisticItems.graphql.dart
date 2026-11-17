// dart format width=100
import '../../fragments/generated/LogisticItemFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchLogisticItems {
  SubscriptionWatchLogisticItems({required this.logisticItems});

  factory SubscriptionWatchLogisticItems.fromJson(Map<String, dynamic> json) {
    final l$logisticItems = json['logisticItems'];
    return SubscriptionWatchLogisticItems(
      logisticItems: (l$logisticItems as List<dynamic>)
          .map((e) => FragmentLogisticItemFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<FragmentLogisticItemFragment> logisticItems;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$logisticItems = logisticItems;
    _resultData['logisticItems'] = l$logisticItems.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$logisticItems = logisticItems;
    return Object.hashAll([Object.hashAll(l$logisticItems.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchLogisticItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$logisticItems = logisticItems;
    final lOther$logisticItems = other.logisticItems;
    if (l$logisticItems.length != lOther$logisticItems.length) {
      return false;
    }
    for (int i = 0; i < l$logisticItems.length; i++) {
      final l$logisticItems$entry = l$logisticItems[i];
      final lOther$logisticItems$entry = lOther$logisticItems[i];
      if (l$logisticItems$entry != lOther$logisticItems$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchLogisticItems = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchLogisticItems'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'logisticItems'),
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
                value: IntValueNode(value: '200'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'LogisticItemFragment'),
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
    fragmentDefinitionLogisticItemFragment,
  ],
);
SubscriptionWatchLogisticItems _parserFnSubscriptionWatchLogisticItems(Map<String, dynamic> data) =>
    SubscriptionWatchLogisticItems.fromJson(data);

class OptionsSubscriptionWatchLogisticItems
    extends graphql.SubscriptionOptions<SubscriptionWatchLogisticItems> {
  OptionsSubscriptionWatchLogisticItems({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchLogisticItems? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchLogisticItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchLogisticItems,
         parserFn: _parserFnSubscriptionWatchLogisticItems,
       );
}

class WatchOptionsSubscriptionWatchLogisticItems
    extends graphql.WatchQueryOptions<SubscriptionWatchLogisticItems> {
  WatchOptionsSubscriptionWatchLogisticItems({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchLogisticItems? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchLogisticItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchLogisticItems,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchLogisticItems,
       );
}

class FetchMoreOptionsSubscriptionWatchLogisticItems extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchLogisticItems({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchLogisticItems);
}

extension ClientExtensionSubscriptionWatchLogisticItems on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchLogisticItems>> subscribeWatchLogisticItems([
    OptionsSubscriptionWatchLogisticItems? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchLogisticItems());

  graphql.ObservableQuery<SubscriptionWatchLogisticItems> watchSubscriptionWatchLogisticItems([
    WatchOptionsSubscriptionWatchLogisticItems? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchLogisticItems());
}
