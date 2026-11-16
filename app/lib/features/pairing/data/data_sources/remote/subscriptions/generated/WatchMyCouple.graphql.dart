// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesSubscriptionWatchMyCouple {
  factory VariablesSubscriptionWatchMyCouple({required String userId}) =>
      VariablesSubscriptionWatchMyCouple._({r'userId': userId});

  VariablesSubscriptionWatchMyCouple._(this._$data);

  factory VariablesSubscriptionWatchMyCouple.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesSubscriptionWatchMyCouple._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesSubscriptionWatchMyCouple || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

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
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'couples'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'members'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: 'userId'),
                            value: ObjectValueNode(
                              fields: [
                                ObjectFieldNode(
                                  name: NameNode(value: '_eq'),
                                  value: VariableNode(name: NameNode(value: 'userId')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
    required VariablesSubscriptionWatchMyCouple variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchMyCouple? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         variables: variables.toJson(),
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
    required VariablesSubscriptionWatchMyCouple variables,
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
         variables: variables.toJson(),
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
  FetchMoreOptionsSubscriptionWatchMyCouple({
    required graphql.UpdateQuery updateQuery,
    required VariablesSubscriptionWatchMyCouple variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeSubscriptionWatchMyCouple,
       );
}

extension ClientExtensionSubscriptionWatchMyCouple on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchMyCouple>> subscribeWatchMyCouple(
    OptionsSubscriptionWatchMyCouple options,
  ) => this.subscribe(options);

  graphql.ObservableQuery<SubscriptionWatchMyCouple> watchSubscriptionWatchMyCouple(
    WatchOptionsSubscriptionWatchMyCouple options,
  ) => this.watchQuery(options);
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
