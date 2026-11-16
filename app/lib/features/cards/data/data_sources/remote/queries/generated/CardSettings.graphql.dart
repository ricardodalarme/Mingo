// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryCardSettings {
  factory VariablesQueryCardSettings({required String userId}) =>
      VariablesQueryCardSettings._({r'userId': userId});

  VariablesQueryCardSettings._(this._$data);

  factory VariablesQueryCardSettings.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryCardSettings._(result$data);
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
    if (other is! VariablesQueryCardSettings || runtimeType != other.runtimeType) {
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

class QueryCardSettings {
  QueryCardSettings({this.userSettingsByPk, this.$__typename = 'query_root'});

  factory QueryCardSettings.fromJson(Map<String, dynamic> json) {
    final l$userSettingsByPk = json['userSettingsByPk'];
    final l$$__typename = json['__typename'];
    return QueryCardSettings(
      userSettingsByPk: l$userSettingsByPk == null
          ? null
          : QueryCardSettingsuserSettingsByPk.fromJson(
              (l$userSettingsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryCardSettingsuserSettingsByPk? userSettingsByPk;

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
    if (other is! QueryCardSettings || runtimeType != other.runtimeType) {
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

const documentNodeQueryCardSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'CardSettings'),
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
                  name: NameNode(value: 'slipsDefaultForCard'),
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
QueryCardSettings _parserFnQueryCardSettings(Map<String, dynamic> data) =>
    QueryCardSettings.fromJson(data);
typedef OnQueryCompleteQueryCardSettings = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryCardSettings?,
);

class OptionsQueryCardSettings extends graphql.QueryOptions<QueryCardSettings> {
  OptionsQueryCardSettings({
    String? operationName,
    required VariablesQueryCardSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCardSettings? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryCardSettings? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CardSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryCardSettings(data)),
         onError: onError,
         document: documentNodeQueryCardSettings,
         parserFn: _parserFnQueryCardSettings,
       );

  final OnQueryCompleteQueryCardSettings? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryCardSettings extends graphql.WatchQueryOptions<QueryCardSettings> {
  WatchOptionsQueryCardSettings({
    String? operationName,
    required VariablesQueryCardSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCardSettings? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CardSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryCardSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryCardSettings,
       );
}

class FetchMoreOptionsQueryCardSettings extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryCardSettings({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryCardSettings variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryCardSettings,
       );
}

extension ClientExtensionQueryCardSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryCardSettings>> queryCardSettings(
    OptionsQueryCardSettings options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryCardSettings> watchQueryCardSettings(
    WatchOptionsQueryCardSettings options,
  ) => this.watchQuery(options);

  void writeQueryCardSettings({
    required QueryCardSettings data,
    required VariablesQueryCardSettings variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryCardSettings),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryCardSettings? readQueryCardSettings({
    required VariablesQueryCardSettings variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryCardSettings),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryCardSettings.fromJson(result);
  }
}

class QueryCardSettingsuserSettingsByPk {
  QueryCardSettingsuserSettingsByPk({
    required this.userId,
    required this.slipsDefaultForCard,
    this.$__typename = 'userSettings',
  });

  factory QueryCardSettingsuserSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$slipsDefaultForCard = json['slipsDefaultForCard'];
    final l$$__typename = json['__typename'];
    return QueryCardSettingsuserSettingsByPk(
      userId: (l$userId as String),
      slipsDefaultForCard: (l$slipsDefaultForCard as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final bool slipsDefaultForCard;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$slipsDefaultForCard = slipsDefaultForCard;
    _resultData['slipsDefaultForCard'] = l$slipsDefaultForCard;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$slipsDefaultForCard = slipsDefaultForCard;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$slipsDefaultForCard, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCardSettingsuserSettingsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$slipsDefaultForCard = slipsDefaultForCard;
    final lOther$slipsDefaultForCard = other.slipsDefaultForCard;
    if (l$slipsDefaultForCard != lOther$slipsDefaultForCard) {
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
