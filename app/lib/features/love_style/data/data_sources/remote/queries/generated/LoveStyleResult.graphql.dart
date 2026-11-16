// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryLoveStyleResult {
  QueryLoveStyleResult({required this.quizResults, this.$__typename = 'query_root'});

  factory QueryLoveStyleResult.fromJson(Map<String, dynamic> json) {
    final l$quizResults = json['quizResults'];
    final l$$__typename = json['__typename'];
    return QueryLoveStyleResult(
      quizResults: (l$quizResults as List<dynamic>)
          .map((e) => QueryLoveStyleResultquizResults.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryLoveStyleResultquizResults> quizResults;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$quizResults = quizResults;
    _resultData['quizResults'] = l$quizResults.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$quizResults = quizResults;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$quizResults.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLoveStyleResult || runtimeType != other.runtimeType) {
      return false;
    }
    final l$quizResults = quizResults;
    final lOther$quizResults = other.quizResults;
    if (l$quizResults.length != lOther$quizResults.length) {
      return false;
    }
    for (int i = 0; i < l$quizResults.length; i++) {
      final l$quizResults$entry = l$quizResults[i];
      final lOther$quizResults$entry = lOther$quizResults[i];
      if (l$quizResults$entry != lOther$quizResults$entry) {
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

const documentNodeQueryLoveStyleResult = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'LoveStyleResult'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'quizResults'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'quizKey'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: EnumValueNode(name: NameNode(value: 'loved')),
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
                  name: NameNode(value: 'ranked'),
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
QueryLoveStyleResult _parserFnQueryLoveStyleResult(Map<String, dynamic> data) =>
    QueryLoveStyleResult.fromJson(data);
typedef OnQueryCompleteQueryLoveStyleResult = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryLoveStyleResult?,
);

class OptionsQueryLoveStyleResult extends graphql.QueryOptions<QueryLoveStyleResult> {
  OptionsQueryLoveStyleResult({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLoveStyleResult? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryLoveStyleResult? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'LoveStyleResult',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryLoveStyleResult(data)),
         onError: onError,
         document: documentNodeQueryLoveStyleResult,
         parserFn: _parserFnQueryLoveStyleResult,
       );

  final OnQueryCompleteQueryLoveStyleResult? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryLoveStyleResult extends graphql.WatchQueryOptions<QueryLoveStyleResult> {
  WatchOptionsQueryLoveStyleResult({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLoveStyleResult? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'LoveStyleResult',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryLoveStyleResult,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryLoveStyleResult,
       );
}

class FetchMoreOptionsQueryLoveStyleResult extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryLoveStyleResult({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryLoveStyleResult);
}

extension ClientExtensionQueryLoveStyleResult on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryLoveStyleResult>> queryLoveStyleResult([
    OptionsQueryLoveStyleResult? options,
  ]) async => await this.query(options ?? OptionsQueryLoveStyleResult());

  graphql.ObservableQuery<QueryLoveStyleResult> watchQueryLoveStyleResult([
    WatchOptionsQueryLoveStyleResult? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryLoveStyleResult());

  void writeQueryLoveStyleResult({required QueryLoveStyleResult data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryLoveStyleResult)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryLoveStyleResult? readQueryLoveStyleResult({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryLoveStyleResult)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryLoveStyleResult.fromJson(result);
  }
}

class QueryLoveStyleResultquizResults {
  QueryLoveStyleResultquizResults({
    required this.id,
    required this.ranked,
    this.$__typename = 'quizResults',
  });

  factory QueryLoveStyleResultquizResults.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$ranked = json['ranked'];
    final l$$__typename = json['__typename'];
    return QueryLoveStyleResultquizResults(
      id: (l$id as String),
      ranked: (l$ranked as List<dynamic>).map((e) => (e as String)).toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final List<String> ranked;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$ranked = ranked;
    _resultData['ranked'] = l$ranked.map((e) => e).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$ranked = ranked;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, Object.hashAll(l$ranked.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLoveStyleResultquizResults || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$ranked = ranked;
    final lOther$ranked = other.ranked;
    if (l$ranked.length != lOther$ranked.length) {
      return false;
    }
    for (int i = 0; i < l$ranked.length; i++) {
      final l$ranked$entry = l$ranked[i];
      final lOther$ranked$entry = lOther$ranked[i];
      if (l$ranked$entry != lOther$ranked$entry) {
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
