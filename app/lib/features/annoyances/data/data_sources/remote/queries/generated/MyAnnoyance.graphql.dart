// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMyAnnoyance {
  factory VariablesQueryMyAnnoyance({required String id}) =>
      VariablesQueryMyAnnoyance._({r'id': id});

  VariablesQueryMyAnnoyance._(this._$data);

  factory VariablesQueryMyAnnoyance.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesQueryMyAnnoyance._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryMyAnnoyance || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

class QueryMyAnnoyance {
  QueryMyAnnoyance({this.annoyancesByPk, this.$__typename = 'query_root'});

  factory QueryMyAnnoyance.fromJson(Map<String, dynamic> json) {
    final l$annoyancesByPk = json['annoyancesByPk'];
    final l$$__typename = json['__typename'];
    return QueryMyAnnoyance(
      annoyancesByPk: l$annoyancesByPk == null
          ? null
          : QueryMyAnnoyanceannoyancesByPk.fromJson((l$annoyancesByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryMyAnnoyanceannoyancesByPk? annoyancesByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$annoyancesByPk = annoyancesByPk;
    _resultData['annoyancesByPk'] = l$annoyancesByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$annoyancesByPk = annoyancesByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$annoyancesByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyAnnoyance || runtimeType != other.runtimeType) {
      return false;
    }
    final l$annoyancesByPk = annoyancesByPk;
    final lOther$annoyancesByPk = other.annoyancesByPk;
    if (l$annoyancesByPk != lOther$annoyancesByPk) {
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

const documentNodeQueryMyAnnoyance = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyAnnoyance'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'annoyancesByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
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
                  name: NameNode(value: 'body'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'createdAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'expiresAt'),
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
QueryMyAnnoyance _parserFnQueryMyAnnoyance(Map<String, dynamic> data) =>
    QueryMyAnnoyance.fromJson(data);
typedef OnQueryCompleteQueryMyAnnoyance = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyAnnoyance?,
);

class OptionsQueryMyAnnoyance extends graphql.QueryOptions<QueryMyAnnoyance> {
  OptionsQueryMyAnnoyance({
    String? operationName,
    required VariablesQueryMyAnnoyance variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyAnnoyance? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyAnnoyance? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyAnnoyance',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyAnnoyance(data)),
         onError: onError,
         document: documentNodeQueryMyAnnoyance,
         parserFn: _parserFnQueryMyAnnoyance,
       );

  final OnQueryCompleteQueryMyAnnoyance? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyAnnoyance extends graphql.WatchQueryOptions<QueryMyAnnoyance> {
  WatchOptionsQueryMyAnnoyance({
    String? operationName,
    required VariablesQueryMyAnnoyance variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyAnnoyance? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyAnnoyance',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyAnnoyance,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyAnnoyance,
       );
}

class FetchMoreOptionsQueryMyAnnoyance extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyAnnoyance({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMyAnnoyance variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMyAnnoyance,
       );
}

extension ClientExtensionQueryMyAnnoyance on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyAnnoyance>> queryMyAnnoyance(
    OptionsQueryMyAnnoyance options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryMyAnnoyance> watchQueryMyAnnoyance(
    WatchOptionsQueryMyAnnoyance options,
  ) => this.watchQuery(options);

  void writeQueryMyAnnoyance({
    required QueryMyAnnoyance data,
    required VariablesQueryMyAnnoyance variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMyAnnoyance),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyAnnoyance? readQueryMyAnnoyance({
    required VariablesQueryMyAnnoyance variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMyAnnoyance),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyAnnoyance.fromJson(result);
  }
}

class QueryMyAnnoyanceannoyancesByPk {
  QueryMyAnnoyanceannoyancesByPk({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.expiresAt,
    this.$__typename = 'annoyances',
  });

  factory QueryMyAnnoyanceannoyancesByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$body = json['body'];
    final l$createdAt = json['createdAt'];
    final l$expiresAt = json['expiresAt'];
    final l$$__typename = json['__typename'];
    return QueryMyAnnoyanceannoyancesByPk(
      id: (l$id as String),
      body: (l$body as String),
      createdAt: DateTime.parse((l$createdAt as String)),
      expiresAt: DateTime.parse((l$expiresAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String body;

  final DateTime createdAt;

  final DateTime expiresAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$expiresAt = expiresAt;
    _resultData['expiresAt'] = ((v) => v.toUtc().toIso8601String())(l$expiresAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$body = body;
    final l$createdAt = createdAt;
    final l$expiresAt = expiresAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$body, l$createdAt, l$expiresAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyAnnoyanceannoyancesByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$expiresAt = expiresAt;
    final lOther$expiresAt = other.expiresAt;
    if (l$expiresAt != lOther$expiresAt) {
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
