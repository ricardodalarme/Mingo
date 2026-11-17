// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchMyCouple {
  SubscriptionWatchMyCouple({required this.couples});

  factory SubscriptionWatchMyCouple.fromJson(Map<String, dynamic> json) {
    final l$couples = json['couples'];
    return SubscriptionWatchMyCouple(
      couples: (l$couples as List<dynamic>)
          .map((e) => SubscriptionWatchMyCouplecouples.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<SubscriptionWatchMyCouplecouples> couples;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$couples = couples;
    _resultData['couples'] = l$couples.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$couples = couples;
    return Object.hashAll([Object.hashAll(l$couples.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchMyCouple || runtimeType != other.runtimeType) {
      return false;
    }
    final l$couples = couples;
    final lOther$couples = other.couples;
    if (l$couples.length != lOther$couples.length) {
      return false;
    }
    for (int i = 0; i < l$couples.length; i++) {
      final l$couples$entry = l$couples[i];
      final lOther$couples$entry = lOther$couples[i];
      if (l$couples$entry != lOther$couples$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchMyCouple = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchMyCouple'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'couples'),
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
                  name: NameNode(value: 'id'),
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
SubscriptionWatchMyCouple _parserFnSubscriptionWatchMyCouple(Map<String, dynamic> data) =>
    SubscriptionWatchMyCouple.fromJson(data);

class OptionsSubscriptionWatchMyCouple
    extends graphql.SubscriptionOptions<SubscriptionWatchMyCouple> {
  OptionsSubscriptionWatchMyCouple({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchMyCouple? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchMyCouple',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchMyCouple,
         parserFn: _parserFnSubscriptionWatchMyCouple,
       );
}

class WatchOptionsSubscriptionWatchMyCouple
    extends graphql.WatchQueryOptions<SubscriptionWatchMyCouple> {
  WatchOptionsSubscriptionWatchMyCouple({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchMyCouple? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchMyCouple',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchMyCouple,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchMyCouple,
       );
}

class FetchMoreOptionsSubscriptionWatchMyCouple extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchMyCouple({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchMyCouple);
}

extension ClientExtensionSubscriptionWatchMyCouple on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchMyCouple>> subscribeWatchMyCouple([
    OptionsSubscriptionWatchMyCouple? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchMyCouple());

  graphql.ObservableQuery<SubscriptionWatchMyCouple> watchSubscriptionWatchMyCouple([
    WatchOptionsSubscriptionWatchMyCouple? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchMyCouple());
}

class SubscriptionWatchMyCouplecouples {
  SubscriptionWatchMyCouplecouples({required this.id, this.$__typename = 'couples'});

  factory SubscriptionWatchMyCouplecouples.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchMyCouplecouples(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchMyCouplecouples || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
