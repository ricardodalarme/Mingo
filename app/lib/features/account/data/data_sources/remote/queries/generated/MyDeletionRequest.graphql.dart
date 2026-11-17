// dart format width=100
import '../../fragments/generated/DeletionRequestFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMyDeletionRequest {
  factory VariablesQueryMyDeletionRequest({required String userId}) =>
      VariablesQueryMyDeletionRequest._({r'userId': userId});

  VariablesQueryMyDeletionRequest._(this._$data);

  factory VariablesQueryMyDeletionRequest.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryMyDeletionRequest._(result$data);
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
    if (other is! VariablesQueryMyDeletionRequest || runtimeType != other.runtimeType) {
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

class QueryMyDeletionRequest {
  QueryMyDeletionRequest({this.deletionRequestsByPk, this.$__typename = 'query_root'});

  factory QueryMyDeletionRequest.fromJson(Map<String, dynamic> json) {
    final l$deletionRequestsByPk = json['deletionRequestsByPk'];
    final l$$__typename = json['__typename'];
    return QueryMyDeletionRequest(
      deletionRequestsByPk: l$deletionRequestsByPk == null
          ? null
          : FragmentDeletionRequestFragment.fromJson(
              (l$deletionRequestsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentDeletionRequestFragment? deletionRequestsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deletionRequestsByPk = deletionRequestsByPk;
    _resultData['deletionRequestsByPk'] = l$deletionRequestsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deletionRequestsByPk = deletionRequestsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deletionRequestsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyDeletionRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deletionRequestsByPk = deletionRequestsByPk;
    final lOther$deletionRequestsByPk = other.deletionRequestsByPk;
    if (l$deletionRequestsByPk != lOther$deletionRequestsByPk) {
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

const documentNodeQueryMyDeletionRequest = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyDeletionRequest'),
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
            name: NameNode(value: 'deletionRequestsByPk'),
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
                FragmentSpreadNode(
                  name: NameNode(value: 'DeletionRequestFragment'),
                  directives: [],
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
    fragmentDefinitionDeletionRequestFragment,
  ],
);
QueryMyDeletionRequest _parserFnQueryMyDeletionRequest(Map<String, dynamic> data) =>
    QueryMyDeletionRequest.fromJson(data);
typedef OnQueryCompleteQueryMyDeletionRequest = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyDeletionRequest?,
);

class OptionsQueryMyDeletionRequest extends graphql.QueryOptions<QueryMyDeletionRequest> {
  OptionsQueryMyDeletionRequest({
    String? operationName,
    required VariablesQueryMyDeletionRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyDeletionRequest? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyDeletionRequest? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyDeletionRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryMyDeletionRequest(data)),
         onError: onError,
         document: documentNodeQueryMyDeletionRequest,
         parserFn: _parserFnQueryMyDeletionRequest,
       );

  final OnQueryCompleteQueryMyDeletionRequest? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyDeletionRequest extends graphql.WatchQueryOptions<QueryMyDeletionRequest> {
  WatchOptionsQueryMyDeletionRequest({
    String? operationName,
    required VariablesQueryMyDeletionRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyDeletionRequest? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyDeletionRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyDeletionRequest,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyDeletionRequest,
       );
}

class FetchMoreOptionsQueryMyDeletionRequest extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyDeletionRequest({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMyDeletionRequest variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMyDeletionRequest,
       );
}

extension ClientExtensionQueryMyDeletionRequest on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyDeletionRequest>> queryMyDeletionRequest(
    OptionsQueryMyDeletionRequest options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryMyDeletionRequest> watchQueryMyDeletionRequest(
    WatchOptionsQueryMyDeletionRequest options,
  ) => this.watchQuery(options);

  void writeQueryMyDeletionRequest({
    required QueryMyDeletionRequest data,
    required VariablesQueryMyDeletionRequest variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMyDeletionRequest),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyDeletionRequest? readQueryMyDeletionRequest({
    required VariablesQueryMyDeletionRequest variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMyDeletionRequest),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyDeletionRequest.fromJson(result);
  }
}
