// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMySpiceSettings {
  factory VariablesQueryMySpiceSettings({required String userId}) =>
      VariablesQueryMySpiceSettings._({r'userId': userId});

  VariablesQueryMySpiceSettings._(this._$data);

  factory VariablesQueryMySpiceSettings.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryMySpiceSettings._(result$data);
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
    if (other is! VariablesQueryMySpiceSettings || runtimeType != other.runtimeType) {
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

class QueryMySpiceSettings {
  QueryMySpiceSettings({this.userSettingsByPk, this.$__typename = 'query_root'});

  factory QueryMySpiceSettings.fromJson(Map<String, dynamic> json) {
    final l$userSettingsByPk = json['userSettingsByPk'];
    final l$$__typename = json['__typename'];
    return QueryMySpiceSettings(
      userSettingsByPk: l$userSettingsByPk == null
          ? null
          : QueryMySpiceSettingsuserSettingsByPk.fromJson(
              (l$userSettingsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryMySpiceSettingsuserSettingsByPk? userSettingsByPk;

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
    if (other is! QueryMySpiceSettings || runtimeType != other.runtimeType) {
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

const documentNodeQueryMySpiceSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MySpiceSettings'),
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
                  name: NameNode(value: 'spiceMaxLevel'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'spiceNotifications'),
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
QueryMySpiceSettings _parserFnQueryMySpiceSettings(Map<String, dynamic> data) =>
    QueryMySpiceSettings.fromJson(data);
typedef OnQueryCompleteQueryMySpiceSettings = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMySpiceSettings?,
);

class OptionsQueryMySpiceSettings extends graphql.QueryOptions<QueryMySpiceSettings> {
  OptionsQueryMySpiceSettings({
    String? operationName,
    required VariablesQueryMySpiceSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMySpiceSettings? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMySpiceSettings? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MySpiceSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryMySpiceSettings(data)),
         onError: onError,
         document: documentNodeQueryMySpiceSettings,
         parserFn: _parserFnQueryMySpiceSettings,
       );

  final OnQueryCompleteQueryMySpiceSettings? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMySpiceSettings extends graphql.WatchQueryOptions<QueryMySpiceSettings> {
  WatchOptionsQueryMySpiceSettings({
    String? operationName,
    required VariablesQueryMySpiceSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMySpiceSettings? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MySpiceSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMySpiceSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMySpiceSettings,
       );
}

class FetchMoreOptionsQueryMySpiceSettings extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMySpiceSettings({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMySpiceSettings variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMySpiceSettings,
       );
}

extension ClientExtensionQueryMySpiceSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMySpiceSettings>> queryMySpiceSettings(
    OptionsQueryMySpiceSettings options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryMySpiceSettings> watchQueryMySpiceSettings(
    WatchOptionsQueryMySpiceSettings options,
  ) => this.watchQuery(options);

  void writeQueryMySpiceSettings({
    required QueryMySpiceSettings data,
    required VariablesQueryMySpiceSettings variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMySpiceSettings),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMySpiceSettings? readQueryMySpiceSettings({
    required VariablesQueryMySpiceSettings variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMySpiceSettings),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMySpiceSettings.fromJson(result);
  }
}

class QueryMySpiceSettingsuserSettingsByPk {
  QueryMySpiceSettingsuserSettingsByPk({
    required this.userId,
    required this.spiceMaxLevel,
    required this.spiceNotifications,
    this.$__typename = 'userSettings',
  });

  factory QueryMySpiceSettingsuserSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$spiceMaxLevel = json['spiceMaxLevel'];
    final l$spiceNotifications = json['spiceNotifications'];
    final l$$__typename = json['__typename'];
    return QueryMySpiceSettingsuserSettingsByPk(
      userId: (l$userId as String),
      spiceMaxLevel: (l$spiceMaxLevel as int),
      spiceNotifications: (l$spiceNotifications as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final int spiceMaxLevel;

  final bool spiceNotifications;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$spiceMaxLevel = spiceMaxLevel;
    _resultData['spiceMaxLevel'] = l$spiceMaxLevel;
    final l$spiceNotifications = spiceNotifications;
    _resultData['spiceNotifications'] = l$spiceNotifications;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$spiceMaxLevel = spiceMaxLevel;
    final l$spiceNotifications = spiceNotifications;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$spiceMaxLevel, l$spiceNotifications, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMySpiceSettingsuserSettingsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$spiceMaxLevel = spiceMaxLevel;
    final lOther$spiceMaxLevel = other.spiceMaxLevel;
    if (l$spiceMaxLevel != lOther$spiceMaxLevel) {
      return false;
    }
    final l$spiceNotifications = spiceNotifications;
    final lOther$spiceNotifications = other.spiceNotifications;
    if (l$spiceNotifications != lOther$spiceNotifications) {
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
