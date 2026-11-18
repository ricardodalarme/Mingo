// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryHomeWidgetCardStatus {
  factory VariablesQueryHomeWidgetCardStatus({required String cardId}) =>
      VariablesQueryHomeWidgetCardStatus._({r'cardId': cardId});

  VariablesQueryHomeWidgetCardStatus._(this._$data);

  factory VariablesQueryHomeWidgetCardStatus.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$cardId = data['cardId'];
    result$data['cardId'] = (l$cardId as String);
    return VariablesQueryHomeWidgetCardStatus._(result$data);
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
    if (other is! VariablesQueryHomeWidgetCardStatus || runtimeType != other.runtimeType) {
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

class QueryHomeWidgetCardStatus {
  QueryHomeWidgetCardStatus({this.cardsByPk, this.$__typename = 'query_root'});

  factory QueryHomeWidgetCardStatus.fromJson(Map<String, dynamic> json) {
    final l$cardsByPk = json['cardsByPk'];
    final l$$__typename = json['__typename'];
    return QueryHomeWidgetCardStatus(
      cardsByPk: l$cardsByPk == null
          ? null
          : QueryHomeWidgetCardStatuscardsByPk.fromJson((l$cardsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryHomeWidgetCardStatuscardsByPk? cardsByPk;

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
    if (other is! QueryHomeWidgetCardStatus || runtimeType != other.runtimeType) {
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

const documentNodeQueryHomeWidgetCardStatus = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'HomeWidgetCardStatus'),
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
QueryHomeWidgetCardStatus _parserFnQueryHomeWidgetCardStatus(Map<String, dynamic> data) =>
    QueryHomeWidgetCardStatus.fromJson(data);
typedef OnQueryCompleteQueryHomeWidgetCardStatus = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryHomeWidgetCardStatus?,
);

class OptionsQueryHomeWidgetCardStatus extends graphql.QueryOptions<QueryHomeWidgetCardStatus> {
  OptionsQueryHomeWidgetCardStatus({
    String? operationName,
    required VariablesQueryHomeWidgetCardStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryHomeWidgetCardStatus? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryHomeWidgetCardStatus? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'HomeWidgetCardStatus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryHomeWidgetCardStatus(data)),
         onError: onError,
         document: documentNodeQueryHomeWidgetCardStatus,
         parserFn: _parserFnQueryHomeWidgetCardStatus,
       );

  final OnQueryCompleteQueryHomeWidgetCardStatus? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryHomeWidgetCardStatus
    extends graphql.WatchQueryOptions<QueryHomeWidgetCardStatus> {
  WatchOptionsQueryHomeWidgetCardStatus({
    String? operationName,
    required VariablesQueryHomeWidgetCardStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryHomeWidgetCardStatus? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'HomeWidgetCardStatus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryHomeWidgetCardStatus,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryHomeWidgetCardStatus,
       );
}

class FetchMoreOptionsQueryHomeWidgetCardStatus extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryHomeWidgetCardStatus({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryHomeWidgetCardStatus variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryHomeWidgetCardStatus,
       );
}

extension ClientExtensionQueryHomeWidgetCardStatus on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryHomeWidgetCardStatus>> queryHomeWidgetCardStatus(
    OptionsQueryHomeWidgetCardStatus options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryHomeWidgetCardStatus> watchQueryHomeWidgetCardStatus(
    WatchOptionsQueryHomeWidgetCardStatus options,
  ) => this.watchQuery(options);

  void writeQueryHomeWidgetCardStatus({
    required QueryHomeWidgetCardStatus data,
    required VariablesQueryHomeWidgetCardStatus variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryHomeWidgetCardStatus),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryHomeWidgetCardStatus? readQueryHomeWidgetCardStatus({
    required VariablesQueryHomeWidgetCardStatus variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryHomeWidgetCardStatus),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryHomeWidgetCardStatus.fromJson(result);
  }
}

class QueryHomeWidgetCardStatuscardsByPk {
  QueryHomeWidgetCardStatuscardsByPk({required this.status, this.$__typename = 'cards'});

  factory QueryHomeWidgetCardStatuscardsByPk.fromJson(Map<String, dynamic> json) {
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return QueryHomeWidgetCardStatuscardsByPk(
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
    if (other is! QueryHomeWidgetCardStatuscardsByPk || runtimeType != other.runtimeType) {
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
