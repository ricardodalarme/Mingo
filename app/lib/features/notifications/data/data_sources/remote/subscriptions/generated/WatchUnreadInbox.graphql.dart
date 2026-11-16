// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchUnreadInbox {
  SubscriptionWatchUnreadInbox({required this.inboxItemsAggregate});

  factory SubscriptionWatchUnreadInbox.fromJson(Map<String, dynamic> json) {
    final l$inboxItemsAggregate = json['inboxItemsAggregate'];
    return SubscriptionWatchUnreadInbox(
      inboxItemsAggregate: SubscriptionWatchUnreadInboxinboxItemsAggregate.fromJson(
        (l$inboxItemsAggregate as Map<String, dynamic>),
      ),
    );
  }

  final SubscriptionWatchUnreadInboxinboxItemsAggregate inboxItemsAggregate;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$inboxItemsAggregate = inboxItemsAggregate;
    _resultData['inboxItemsAggregate'] = l$inboxItemsAggregate.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$inboxItemsAggregate = inboxItemsAggregate;
    return Object.hashAll([l$inboxItemsAggregate]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchUnreadInbox || runtimeType != other.runtimeType) {
      return false;
    }
    final l$inboxItemsAggregate = inboxItemsAggregate;
    final lOther$inboxItemsAggregate = other.inboxItemsAggregate;
    if (l$inboxItemsAggregate != lOther$inboxItemsAggregate) {
      return false;
    }
    return true;
  }
}

const documentNodeSubscriptionWatchUnreadInbox = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchUnreadInbox'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'inboxItemsAggregate'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'readAt'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_is_null'),
                            value: BooleanValueNode(value: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'aggregate'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'count'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
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
  ],
);
SubscriptionWatchUnreadInbox _parserFnSubscriptionWatchUnreadInbox(Map<String, dynamic> data) =>
    SubscriptionWatchUnreadInbox.fromJson(data);

class OptionsSubscriptionWatchUnreadInbox
    extends graphql.SubscriptionOptions<SubscriptionWatchUnreadInbox> {
  OptionsSubscriptionWatchUnreadInbox({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchUnreadInbox? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchUnreadInbox',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchUnreadInbox,
         parserFn: _parserFnSubscriptionWatchUnreadInbox,
       );
}

class WatchOptionsSubscriptionWatchUnreadInbox
    extends graphql.WatchQueryOptions<SubscriptionWatchUnreadInbox> {
  WatchOptionsSubscriptionWatchUnreadInbox({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchUnreadInbox? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchUnreadInbox',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchUnreadInbox,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchUnreadInbox,
       );
}

class FetchMoreOptionsSubscriptionWatchUnreadInbox extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchUnreadInbox({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchUnreadInbox);
}

extension ClientExtensionSubscriptionWatchUnreadInbox on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchUnreadInbox>> subscribeWatchUnreadInbox([
    OptionsSubscriptionWatchUnreadInbox? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchUnreadInbox());

  graphql.ObservableQuery<SubscriptionWatchUnreadInbox> watchSubscriptionWatchUnreadInbox([
    WatchOptionsSubscriptionWatchUnreadInbox? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchUnreadInbox());
}

class SubscriptionWatchUnreadInboxinboxItemsAggregate {
  SubscriptionWatchUnreadInboxinboxItemsAggregate({
    this.aggregate,
    this.$__typename = 'inboxItems_aggregate',
  });

  factory SubscriptionWatchUnreadInboxinboxItemsAggregate.fromJson(Map<String, dynamic> json) {
    final l$aggregate = json['aggregate'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchUnreadInboxinboxItemsAggregate(
      aggregate: l$aggregate == null
          ? null
          : SubscriptionWatchUnreadInboxinboxItemsAggregateaggregate.fromJson(
              (l$aggregate as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final SubscriptionWatchUnreadInboxinboxItemsAggregateaggregate? aggregate;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$aggregate = aggregate;
    _resultData['aggregate'] = l$aggregate?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$aggregate = aggregate;
    final l$$__typename = $__typename;
    return Object.hashAll([l$aggregate, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchUnreadInboxinboxItemsAggregate ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$aggregate = aggregate;
    final lOther$aggregate = other.aggregate;
    if (l$aggregate != lOther$aggregate) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

class SubscriptionWatchUnreadInboxinboxItemsAggregateaggregate {
  SubscriptionWatchUnreadInboxinboxItemsAggregateaggregate({
    required this.count,
    this.$__typename = 'inboxItems_aggregate_fields',
  });

  factory SubscriptionWatchUnreadInboxinboxItemsAggregateaggregate.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$count = json['count'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchUnreadInboxinboxItemsAggregateaggregate(
      count: (l$count as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int count;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$count = count;
    _resultData['count'] = l$count;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$count = count;
    final l$$__typename = $__typename;
    return Object.hashAll([l$count, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchUnreadInboxinboxItemsAggregateaggregate ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$count = count;
    final lOther$count = other.count;
    if (l$count != lOther$count) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}
