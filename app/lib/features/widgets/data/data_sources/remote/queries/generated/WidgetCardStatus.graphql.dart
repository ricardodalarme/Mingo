// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryWidgetCardStatus {
  factory VariablesQueryWidgetCardStatus({required String cardId}) =>
      VariablesQueryWidgetCardStatus._({r'cardId': cardId});

  VariablesQueryWidgetCardStatus._(this._$data);

  factory VariablesQueryWidgetCardStatus.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$cardId = data['cardId'];
    result$data['cardId'] = (l$cardId as String);
    return VariablesQueryWidgetCardStatus._(result$data);
  }

  Map<String, dynamic> _$data;

  String get cardId => (_$data['cardId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$cardId = cardId;
    result$data['cardId'] = l$cardId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryWidgetCardStatus || runtimeType != other.runtimeType) {
      return false;
    }
    final l$cardId = cardId;
    final lOther$cardId = other.cardId;
    if (l$cardId != lOther$cardId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$cardId = cardId;
    return Object.hashAll([l$cardId]);
  }
}

class QueryWidgetCardStatus {
  QueryWidgetCardStatus({this.cardsByPk, this.$__typename = 'query_root'});

  factory QueryWidgetCardStatus.fromJson(Map<String, dynamic> json) {
    final l$cardsByPk = json['cardsByPk'];
    final l$$__typename = json['__typename'];
    return QueryWidgetCardStatus(
      cardsByPk: l$cardsByPk == null
          ? null
          : QueryWidgetCardStatuscardsByPk.fromJson((l$cardsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryWidgetCardStatuscardsByPk? cardsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$cardsByPk = cardsByPk;
    _resultData['cardsByPk'] = l$cardsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$cardsByPk = cardsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$cardsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetCardStatus || runtimeType != other.runtimeType) {
      return false;
    }
    final l$cardsByPk = cardsByPk;
    final lOther$cardsByPk = other.cardsByPk;
    if (l$cardsByPk != lOther$cardsByPk) {
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

const documentNodeQueryWidgetCardStatus = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'WidgetCardStatus'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cardId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'cardsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'cardId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'status'),
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
QueryWidgetCardStatus _parserFnQueryWidgetCardStatus(Map<String, dynamic> data) =>
    QueryWidgetCardStatus.fromJson(data);
typedef OnQueryCompleteQueryWidgetCardStatus = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryWidgetCardStatus?,
);

class OptionsQueryWidgetCardStatus extends graphql.QueryOptions<QueryWidgetCardStatus> {
  OptionsQueryWidgetCardStatus({
    String? operationName,
    required VariablesQueryWidgetCardStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryWidgetCardStatus? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryWidgetCardStatus? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'WidgetCardStatus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryWidgetCardStatus(data)),
         onError: onError,
         document: documentNodeQueryWidgetCardStatus,
         parserFn: _parserFnQueryWidgetCardStatus,
       );

  final OnQueryCompleteQueryWidgetCardStatus? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryWidgetCardStatus extends graphql.WatchQueryOptions<QueryWidgetCardStatus> {
  WatchOptionsQueryWidgetCardStatus({
    String? operationName,
    required VariablesQueryWidgetCardStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryWidgetCardStatus? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'WidgetCardStatus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryWidgetCardStatus,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryWidgetCardStatus,
       );
}

class FetchMoreOptionsQueryWidgetCardStatus extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryWidgetCardStatus({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryWidgetCardStatus variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryWidgetCardStatus,
       );
}

extension ClientExtensionQueryWidgetCardStatus on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryWidgetCardStatus>> queryWidgetCardStatus(
    OptionsQueryWidgetCardStatus options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryWidgetCardStatus> watchQueryWidgetCardStatus(
    WatchOptionsQueryWidgetCardStatus options,
  ) => this.watchQuery(options);

  void writeQueryWidgetCardStatus({
    required QueryWidgetCardStatus data,
    required VariablesQueryWidgetCardStatus variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryWidgetCardStatus),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryWidgetCardStatus? readQueryWidgetCardStatus({
    required VariablesQueryWidgetCardStatus variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryWidgetCardStatus),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryWidgetCardStatus.fromJson(result);
  }
}

class QueryWidgetCardStatuscardsByPk {
  QueryWidgetCardStatuscardsByPk({required this.status, this.$__typename = 'cards'});

  factory QueryWidgetCardStatuscardsByPk.fromJson(Map<String, dynamic> json) {
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return QueryWidgetCardStatuscardsByPk(
      status: fromJsonEnumCardStatus_enum((l$status as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumCardStatus_enum status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$status = status;
    _resultData['status'] = toJsonEnumCardStatus_enum(l$status);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([l$status, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetCardStatuscardsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
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
