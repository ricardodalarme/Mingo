// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMySpiceSetting {
  factory VariablesQueryMySpiceSetting({required String userId}) =>
      VariablesQueryMySpiceSetting._({r'userId': userId});

  VariablesQueryMySpiceSetting._(this._$data);

  factory VariablesQueryMySpiceSetting.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryMySpiceSetting._(result$data);
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
    if (other is! VariablesQueryMySpiceSetting || runtimeType != other.runtimeType) {
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

class QueryMySpiceSetting {
  QueryMySpiceSetting({this.userSettingsByPk, this.$__typename = 'query_root'});

  factory QueryMySpiceSetting.fromJson(Map<String, dynamic> json) {
    final l$userSettingsByPk = json['userSettingsByPk'];
    final l$$__typename = json['__typename'];
    return QueryMySpiceSetting(
      userSettingsByPk: l$userSettingsByPk == null
          ? null
          : QueryMySpiceSettinguserSettingsByPk.fromJson(
              (l$userSettingsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryMySpiceSettinguserSettingsByPk? userSettingsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userSettingsByPk = userSettingsByPk;
    _resultData['userSettingsByPk'] = l$userSettingsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userSettingsByPk = userSettingsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userSettingsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMySpiceSetting || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userSettingsByPk = userSettingsByPk;
    final lOther$userSettingsByPk = other.userSettingsByPk;
    if (l$userSettingsByPk != lOther$userSettingsByPk) {
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

const documentNodeQueryMySpiceSetting = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MySpiceSetting'),
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
            name: NameNode(value: 'userSettingsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'userId'),
                value: VariableNode(name: NameNode(value: 'userId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'userId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'spiceEnabled'),
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
QueryMySpiceSetting _parserFnQueryMySpiceSetting(Map<String, dynamic> data) =>
    QueryMySpiceSetting.fromJson(data);
typedef OnQueryCompleteQueryMySpiceSetting = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMySpiceSetting?,
);

class OptionsQueryMySpiceSetting extends graphql.QueryOptions<QueryMySpiceSetting> {
  OptionsQueryMySpiceSetting({
    String? operationName,
    required VariablesQueryMySpiceSetting variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMySpiceSetting? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMySpiceSetting? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MySpiceSetting',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMySpiceSetting(data)),
         onError: onError,
         document: documentNodeQueryMySpiceSetting,
         parserFn: _parserFnQueryMySpiceSetting,
       );

  final OnQueryCompleteQueryMySpiceSetting? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMySpiceSetting extends graphql.WatchQueryOptions<QueryMySpiceSetting> {
  WatchOptionsQueryMySpiceSetting({
    String? operationName,
    required VariablesQueryMySpiceSetting variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMySpiceSetting? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MySpiceSetting',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMySpiceSetting,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMySpiceSetting,
       );
}

class FetchMoreOptionsQueryMySpiceSetting extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMySpiceSetting({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMySpiceSetting variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMySpiceSetting,
       );
}

extension ClientExtensionQueryMySpiceSetting on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMySpiceSetting>> queryMySpiceSetting(
    OptionsQueryMySpiceSetting options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryMySpiceSetting> watchQueryMySpiceSetting(
    WatchOptionsQueryMySpiceSetting options,
  ) => this.watchQuery(options);

  void writeQueryMySpiceSetting({
    required QueryMySpiceSetting data,
    required VariablesQueryMySpiceSetting variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMySpiceSetting),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMySpiceSetting? readQueryMySpiceSetting({
    required VariablesQueryMySpiceSetting variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMySpiceSetting),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMySpiceSetting.fromJson(result);
  }
}

class QueryMySpiceSettinguserSettingsByPk {
  QueryMySpiceSettinguserSettingsByPk({
    required this.userId,
    required this.spiceEnabled,
    this.$__typename = 'userSettings',
  });

  factory QueryMySpiceSettinguserSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$spiceEnabled = json['spiceEnabled'];
    final l$$__typename = json['__typename'];
    return QueryMySpiceSettinguserSettingsByPk(
      userId: (l$userId as String),
      spiceEnabled: (l$spiceEnabled as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final bool spiceEnabled;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$spiceEnabled = spiceEnabled;
    _resultData['spiceEnabled'] = l$spiceEnabled;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$spiceEnabled = spiceEnabled;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$spiceEnabled, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMySpiceSettinguserSettingsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$spiceEnabled = spiceEnabled;
    final lOther$spiceEnabled = other.spiceEnabled;
    if (l$spiceEnabled != lOther$spiceEnabled) {
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
