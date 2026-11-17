// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchMyCoupleId {
  SubscriptionWatchMyCoupleId({required this.today});

  factory SubscriptionWatchMyCoupleId.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    return SubscriptionWatchMyCoupleId(
      today: (l$today as List<dynamic>)
          .map((e) => SubscriptionWatchMyCoupleIdtoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<SubscriptionWatchMyCoupleIdtoday> today;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$today = today;
    _resultData['today'] = l$today.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$today = today;
    return Object.hashAll([Object.hashAll(l$today.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchMyCoupleId || runtimeType != other.runtimeType) {
      return false;
    }
    final l$today = today;
    final lOther$today = other.today;
    if (l$today.length != lOther$today.length) {
      return false;
    }
    for (int i = 0; i < l$today.length; i++) {
      final l$today$entry = l$today[i];
      final lOther$today$entry = lOther$today[i];
      if (l$today$entry != lOther$today$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchMyCoupleId = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchMyCoupleId'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'today'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '1'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'coupleId'),
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
        ],
      ),
    ),
  ],
);
SubscriptionWatchMyCoupleId _parserFnSubscriptionWatchMyCoupleId(Map<String, dynamic> data) =>
    SubscriptionWatchMyCoupleId.fromJson(data);

class OptionsSubscriptionWatchMyCoupleId
    extends graphql.SubscriptionOptions<SubscriptionWatchMyCoupleId> {
  OptionsSubscriptionWatchMyCoupleId({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchMyCoupleId? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchMyCoupleId',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchMyCoupleId,
         parserFn: _parserFnSubscriptionWatchMyCoupleId,
       );
}

class WatchOptionsSubscriptionWatchMyCoupleId
    extends graphql.WatchQueryOptions<SubscriptionWatchMyCoupleId> {
  WatchOptionsSubscriptionWatchMyCoupleId({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchMyCoupleId? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchMyCoupleId',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchMyCoupleId,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchMyCoupleId,
       );
}

class FetchMoreOptionsSubscriptionWatchMyCoupleId extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchMyCoupleId({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchMyCoupleId);
}

extension ClientExtensionSubscriptionWatchMyCoupleId on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchMyCoupleId>> subscribeWatchMyCoupleId([
    OptionsSubscriptionWatchMyCoupleId? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchMyCoupleId());

  graphql.ObservableQuery<SubscriptionWatchMyCoupleId> watchSubscriptionWatchMyCoupleId([
    WatchOptionsSubscriptionWatchMyCoupleId? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchMyCoupleId());
}

class SubscriptionWatchMyCoupleIdtoday {
  SubscriptionWatchMyCoupleIdtoday({this.coupleId, this.$__typename = 'today'});

  factory SubscriptionWatchMyCoupleIdtoday.fromJson(Map<String, dynamic> json) {
    final l$coupleId = json['coupleId'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchMyCoupleIdtoday(
      coupleId: (l$coupleId as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? coupleId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$coupleId = coupleId;
    final l$$__typename = $__typename;
    return Object.hashAll([l$coupleId, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchMyCoupleIdtoday || runtimeType != other.runtimeType) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
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
