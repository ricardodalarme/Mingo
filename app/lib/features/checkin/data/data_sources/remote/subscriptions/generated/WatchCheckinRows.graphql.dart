// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesSubscriptionWatchCheckinRows {
  factory VariablesSubscriptionWatchCheckinRows({required DateTime weekStart}) =>
      VariablesSubscriptionWatchCheckinRows._({r'weekStart': weekStart});

  VariablesSubscriptionWatchCheckinRows._(this._$data);

  factory VariablesSubscriptionWatchCheckinRows.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$weekStart = data['weekStart'];
    result$data['weekStart'] = DateTime.parse((l$weekStart as String));
    return VariablesSubscriptionWatchCheckinRows._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime get weekStart => (_$data['weekStart'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$weekStart = weekStart;
    result$data['weekStart'] = ((v) => v.toIso8601String().substring(0, 10))(l$weekStart);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesSubscriptionWatchCheckinRows || runtimeType != other.runtimeType) {
      return false;
    }
    final l$weekStart = weekStart;
    final lOther$weekStart = other.weekStart;
    if (l$weekStart != lOther$weekStart) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$weekStart = weekStart;
    return Object.hashAll([l$weekStart]);
  }
}

class SubscriptionWatchCheckinRows {
  SubscriptionWatchCheckinRows({required this.checkins});

  factory SubscriptionWatchCheckinRows.fromJson(Map<String, dynamic> json) {
    final l$checkins = json['checkins'];
    return SubscriptionWatchCheckinRows(
      checkins: (l$checkins as List<dynamic>)
          .map((e) => SubscriptionWatchCheckinRowscheckins.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<SubscriptionWatchCheckinRowscheckins> checkins;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$checkins = checkins;
    _resultData['checkins'] = l$checkins.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$checkins = checkins;
    return Object.hashAll([Object.hashAll(l$checkins.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchCheckinRows || runtimeType != other.runtimeType) {
      return false;
    }
    final l$checkins = checkins;
    final lOther$checkins = other.checkins;
    if (l$checkins.length != lOther$checkins.length) {
      return false;
    }
    for (int i = 0; i < l$checkins.length; i++) {
      final l$checkins$entry = l$checkins[i];
      final lOther$checkins$entry = lOther$checkins[i];
      if (l$checkins$entry != lOther$checkins$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchCheckinRows = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchCheckinRows'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'weekStart')),
          type: NamedTypeNode(name: NameNode(value: 'date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'checkins'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'weekStart'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'weekStart')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '10'),
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
                  name: NameNode(value: 'completed'),
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
SubscriptionWatchCheckinRows _parserFnSubscriptionWatchCheckinRows(Map<String, dynamic> data) =>
    SubscriptionWatchCheckinRows.fromJson(data);

class OptionsSubscriptionWatchCheckinRows
    extends graphql.SubscriptionOptions<SubscriptionWatchCheckinRows> {
  OptionsSubscriptionWatchCheckinRows({
    String? operationName,
    required VariablesSubscriptionWatchCheckinRows variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchCheckinRows? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'WatchCheckinRows',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchCheckinRows,
         parserFn: _parserFnSubscriptionWatchCheckinRows,
       );
}

class WatchOptionsSubscriptionWatchCheckinRows
    extends graphql.WatchQueryOptions<SubscriptionWatchCheckinRows> {
  WatchOptionsSubscriptionWatchCheckinRows({
    String? operationName,
    required VariablesSubscriptionWatchCheckinRows variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchCheckinRows? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'WatchCheckinRows',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchCheckinRows,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchCheckinRows,
       );
}

class FetchMoreOptionsSubscriptionWatchCheckinRows extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchCheckinRows({
    required graphql.UpdateQuery updateQuery,
    required VariablesSubscriptionWatchCheckinRows variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeSubscriptionWatchCheckinRows,
       );
}

extension ClientExtensionSubscriptionWatchCheckinRows on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchCheckinRows>> subscribeWatchCheckinRows(
    OptionsSubscriptionWatchCheckinRows options,
  ) => this.subscribe(options);

  graphql.ObservableQuery<SubscriptionWatchCheckinRows> watchSubscriptionWatchCheckinRows(
    WatchOptionsSubscriptionWatchCheckinRows options,
  ) => this.watchQuery(options);
}

class SubscriptionWatchCheckinRowscheckins {
  SubscriptionWatchCheckinRowscheckins({
    required this.id,
    this.completed,
    this.$__typename = 'checkins',
  });

  factory SubscriptionWatchCheckinRowscheckins.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$completed = json['completed'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchCheckinRowscheckins(
      id: (l$id as String),
      completed: (l$completed as bool?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final bool? completed;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$completed = completed;
    _resultData['completed'] = l$completed;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$completed = completed;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$completed, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchCheckinRowscheckins || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$completed = completed;
    final lOther$completed = other.completed;
    if (l$completed != lOther$completed) {
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
