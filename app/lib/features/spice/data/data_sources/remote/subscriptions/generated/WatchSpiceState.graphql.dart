// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchSpiceState {
  SubscriptionWatchSpiceState({required this.spiceState});

  factory SubscriptionWatchSpiceState.fromJson(Map<String, dynamic> json) {
    final l$spiceState = json['spiceState'];
    return SubscriptionWatchSpiceState(
      spiceState: (l$spiceState as List<dynamic>)
          .map((e) => SubscriptionWatchSpiceStatespiceState.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<SubscriptionWatchSpiceStatespiceState> spiceState;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceState = spiceState;
    _resultData['spiceState'] = l$spiceState.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceState = spiceState;
    return Object.hashAll([Object.hashAll(l$spiceState.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchSpiceState || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceState = spiceState;
    final lOther$spiceState = other.spiceState;
    if (l$spiceState.length != lOther$spiceState.length) {
      return false;
    }
    for (int i = 0; i < l$spiceState.length; i++) {
      final l$spiceState$entry = l$spiceState[i];
      final lOther$spiceState$entry = lOther$spiceState[i];
      if (l$spiceState$entry != lOther$spiceState$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchSpiceState = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchSpiceState'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'state'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'myLevel'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'coupleLevel'),
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
SubscriptionWatchSpiceState _parserFnSubscriptionWatchSpiceState(Map<String, dynamic> data) =>
    SubscriptionWatchSpiceState.fromJson(data);

class OptionsSubscriptionWatchSpiceState
    extends graphql.SubscriptionOptions<SubscriptionWatchSpiceState> {
  OptionsSubscriptionWatchSpiceState({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchSpiceState? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchSpiceState',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchSpiceState,
         parserFn: _parserFnSubscriptionWatchSpiceState,
       );
}

class WatchOptionsSubscriptionWatchSpiceState
    extends graphql.WatchQueryOptions<SubscriptionWatchSpiceState> {
  WatchOptionsSubscriptionWatchSpiceState({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchSpiceState? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchSpiceState',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchSpiceState,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchSpiceState,
       );
}

class FetchMoreOptionsSubscriptionWatchSpiceState extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchSpiceState({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchSpiceState);
}

extension ClientExtensionSubscriptionWatchSpiceState on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchSpiceState>> subscribeWatchSpiceState([
    OptionsSubscriptionWatchSpiceState? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchSpiceState());

  graphql.ObservableQuery<SubscriptionWatchSpiceState> watchSubscriptionWatchSpiceState([
    WatchOptionsSubscriptionWatchSpiceState? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchSpiceState());
}

class SubscriptionWatchSpiceStatespiceState {
  SubscriptionWatchSpiceStatespiceState({
    required this.state,
    this.myLevel,
    this.coupleLevel,
    this.$__typename = 'spiceStates',
  });

  factory SubscriptionWatchSpiceStatespiceState.fromJson(Map<String, dynamic> json) {
    final l$state = json['state'];
    final l$myLevel = json['myLevel'];
    final l$coupleLevel = json['coupleLevel'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchSpiceStatespiceState(
      state: (l$state as String),
      myLevel: (l$myLevel as int?),
      coupleLevel: (l$coupleLevel as int?),
      $__typename: (l$$__typename as String),
    );
  }

  final String state;

  final int? myLevel;

  final int? coupleLevel;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$state = state;
    _resultData['state'] = l$state;
    final l$myLevel = myLevel;
    _resultData['myLevel'] = l$myLevel;
    final l$coupleLevel = coupleLevel;
    _resultData['coupleLevel'] = l$coupleLevel;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$state = state;
    final l$myLevel = myLevel;
    final l$coupleLevel = coupleLevel;
    final l$$__typename = $__typename;
    return Object.hashAll([l$state, l$myLevel, l$coupleLevel, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchSpiceStatespiceState || runtimeType != other.runtimeType) {
      return false;
    }
    final l$state = state;
    final lOther$state = other.state;
    if (l$state != lOther$state) {
      return false;
    }
    final l$myLevel = myLevel;
    final lOther$myLevel = other.myLevel;
    if (l$myLevel != lOther$myLevel) {
      return false;
    }
    final l$coupleLevel = coupleLevel;
    final lOther$coupleLevel = other.coupleLevel;
    if (l$coupleLevel != lOther$coupleLevel) {
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
