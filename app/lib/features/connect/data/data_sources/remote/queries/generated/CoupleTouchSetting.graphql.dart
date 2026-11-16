// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryCoupleTouchSetting {
  factory VariablesQueryCoupleTouchSetting({required String userId}) =>
      VariablesQueryCoupleTouchSetting._({r'userId': userId});

  VariablesQueryCoupleTouchSetting._(this._$data);

  factory VariablesQueryCoupleTouchSetting.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryCoupleTouchSetting._(result$data);
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
    if (other is! VariablesQueryCoupleTouchSetting || runtimeType != other.runtimeType) {
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

class QueryCoupleTouchSetting {
  QueryCoupleTouchSetting({required this.couples, this.$__typename = 'query_root'});

  factory QueryCoupleTouchSetting.fromJson(Map<String, dynamic> json) {
    final l$couples = json['couples'];
    final l$$__typename = json['__typename'];
    return QueryCoupleTouchSetting(
      couples: (l$couples as List<dynamic>)
          .map((e) => QueryCoupleTouchSettingcouples.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryCoupleTouchSettingcouples> couples;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$couples = couples;
    _resultData['couples'] = l$couples.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$couples = couples;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$couples.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCoupleTouchSetting || runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

const documentNodeQueryCoupleTouchSetting = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'CoupleTouchSetting'),
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
                  name: NameNode(value: 'touchTopicsEnabled'),
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
);
QueryCoupleTouchSetting _parserFnQueryCoupleTouchSetting(Map<String, dynamic> data) =>
    QueryCoupleTouchSetting.fromJson(data);
typedef OnQueryCompleteQueryCoupleTouchSetting = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryCoupleTouchSetting?,
);

class OptionsQueryCoupleTouchSetting extends graphql.QueryOptions<QueryCoupleTouchSetting> {
  OptionsQueryCoupleTouchSetting({
    String? operationName,
    required VariablesQueryCoupleTouchSetting variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCoupleTouchSetting? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryCoupleTouchSetting? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CoupleTouchSetting',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryCoupleTouchSetting(data)),
         onError: onError,
         document: documentNodeQueryCoupleTouchSetting,
         parserFn: _parserFnQueryCoupleTouchSetting,
       );

  final OnQueryCompleteQueryCoupleTouchSetting? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryCoupleTouchSetting
    extends graphql.WatchQueryOptions<QueryCoupleTouchSetting> {
  WatchOptionsQueryCoupleTouchSetting({
    String? operationName,
    required VariablesQueryCoupleTouchSetting variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCoupleTouchSetting? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CoupleTouchSetting',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryCoupleTouchSetting,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryCoupleTouchSetting,
       );
}

class FetchMoreOptionsQueryCoupleTouchSetting extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryCoupleTouchSetting({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryCoupleTouchSetting variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryCoupleTouchSetting,
       );
}

extension ClientExtensionQueryCoupleTouchSetting on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryCoupleTouchSetting>> queryCoupleTouchSetting(
    OptionsQueryCoupleTouchSetting options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryCoupleTouchSetting> watchQueryCoupleTouchSetting(
    WatchOptionsQueryCoupleTouchSetting options,
  ) => this.watchQuery(options);

  void writeQueryCoupleTouchSetting({
    required QueryCoupleTouchSetting data,
    required VariablesQueryCoupleTouchSetting variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryCoupleTouchSetting),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryCoupleTouchSetting? readQueryCoupleTouchSetting({
    required VariablesQueryCoupleTouchSetting variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryCoupleTouchSetting),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryCoupleTouchSetting.fromJson(result);
  }
}

class QueryCoupleTouchSettingcouples {
  QueryCoupleTouchSettingcouples({
    required this.id,
    required this.touchTopicsEnabled,
    this.$__typename = 'couples',
  });

  factory QueryCoupleTouchSettingcouples.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$touchTopicsEnabled = json['touchTopicsEnabled'];
    final l$$__typename = json['__typename'];
    return QueryCoupleTouchSettingcouples(
      id: (l$id as String),
      touchTopicsEnabled: (l$touchTopicsEnabled as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final bool touchTopicsEnabled;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$touchTopicsEnabled = touchTopicsEnabled;
    _resultData['touchTopicsEnabled'] = l$touchTopicsEnabled;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$touchTopicsEnabled = touchTopicsEnabled;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$touchTopicsEnabled, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCoupleTouchSettingcouples || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$touchTopicsEnabled = touchTopicsEnabled;
    final lOther$touchTopicsEnabled = other.touchTopicsEnabled;
    if (l$touchTopicsEnabled != lOther$touchTopicsEnabled) {
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
