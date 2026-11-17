// dart format width=100
import '../../fragments/generated/GentleRequestFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryGentleRequestById {
  factory VariablesQueryGentleRequestById({required String id}) =>
      VariablesQueryGentleRequestById._({r'id': id});

  VariablesQueryGentleRequestById._(this._$data);

  factory VariablesQueryGentleRequestById.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesQueryGentleRequestById._(result$data);
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
    if (other is! VariablesQueryGentleRequestById || runtimeType != other.runtimeType) {
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

class QueryGentleRequestById {
  QueryGentleRequestById({this.gentleRequestsByPk, this.$__typename = 'query_root'});

  factory QueryGentleRequestById.fromJson(Map<String, dynamic> json) {
    final l$gentleRequestsByPk = json['gentleRequestsByPk'];
    final l$$__typename = json['__typename'];
    return QueryGentleRequestById(
      gentleRequestsByPk: l$gentleRequestsByPk == null
          ? null
          : FragmentGentleRequestFragment.fromJson((l$gentleRequestsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentGentleRequestFragment? gentleRequestsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$gentleRequestsByPk = gentleRequestsByPk;
    _resultData['gentleRequestsByPk'] = l$gentleRequestsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$gentleRequestsByPk = gentleRequestsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$gentleRequestsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGentleRequestById || runtimeType != other.runtimeType) {
      return false;
    }
    final l$gentleRequestsByPk = gentleRequestsByPk;
    final lOther$gentleRequestsByPk = other.gentleRequestsByPk;
    if (l$gentleRequestsByPk != lOther$gentleRequestsByPk) {
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

const documentNodeQueryGentleRequestById = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GentleRequestById'),
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
            name: NameNode(value: 'gentleRequestsByPk'),
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
                FragmentSpreadNode(
                  name: NameNode(value: 'GentleRequestFragment'),
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
    fragmentDefinitionGentleRequestFragment,
  ],
);
QueryGentleRequestById _parserFnQueryGentleRequestById(Map<String, dynamic> data) =>
    QueryGentleRequestById.fromJson(data);
typedef OnQueryCompleteQueryGentleRequestById = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryGentleRequestById?,
);

class OptionsQueryGentleRequestById extends graphql.QueryOptions<QueryGentleRequestById> {
  OptionsQueryGentleRequestById({
    String? operationName,
    required VariablesQueryGentleRequestById variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGentleRequestById? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryGentleRequestById? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'GentleRequestById',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryGentleRequestById(data)),
         onError: onError,
         document: documentNodeQueryGentleRequestById,
         parserFn: _parserFnQueryGentleRequestById,
       );

  final OnQueryCompleteQueryGentleRequestById? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryGentleRequestById extends graphql.WatchQueryOptions<QueryGentleRequestById> {
  WatchOptionsQueryGentleRequestById({
    String? operationName,
    required VariablesQueryGentleRequestById variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGentleRequestById? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'GentleRequestById',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGentleRequestById,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryGentleRequestById,
       );
}

class FetchMoreOptionsQueryGentleRequestById extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryGentleRequestById({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryGentleRequestById variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGentleRequestById,
       );
}

extension ClientExtensionQueryGentleRequestById on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryGentleRequestById>> queryGentleRequestById(
    OptionsQueryGentleRequestById options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryGentleRequestById> watchQueryGentleRequestById(
    WatchOptionsQueryGentleRequestById options,
  ) => this.watchQuery(options);

  void writeQueryGentleRequestById({
    required QueryGentleRequestById data,
    required VariablesQueryGentleRequestById variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGentleRequestById),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryGentleRequestById? readQueryGentleRequestById({
    required VariablesQueryGentleRequestById variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGentleRequestById),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryGentleRequestById.fromJson(result);
  }
}
