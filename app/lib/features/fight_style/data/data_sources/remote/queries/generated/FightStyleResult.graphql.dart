// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryFightStyleResult {
  QueryFightStyleResult({required this.quizResults, this.$__typename = 'query_root'});

  factory QueryFightStyleResult.fromJson(Map<String, dynamic> json) {
    final l$quizResults = json['quizResults'];
    final l$$__typename = json['__typename'];
    return QueryFightStyleResult(
      quizResults: (l$quizResults as List<dynamic>)
          .map((e) => QueryFightStyleResultquizResults.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryFightStyleResultquizResults> quizResults;

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
    if (other is! QueryFightStyleResult || runtimeType != other.runtimeType) {
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

const documentNodeQueryFightStyleResult = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'FightStyleResult'),
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
                            value: EnumValueNode(name: NameNode(value: 'conflict_style')),
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
QueryFightStyleResult _parserFnQueryFightStyleResult(Map<String, dynamic> data) =>
    QueryFightStyleResult.fromJson(data);
typedef OnQueryCompleteQueryFightStyleResult = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryFightStyleResult?,
);

class OptionsQueryFightStyleResult extends graphql.QueryOptions<QueryFightStyleResult> {
  OptionsQueryFightStyleResult({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryFightStyleResult? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryFightStyleResult? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'FightStyleResult',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryFightStyleResult(data)),
         onError: onError,
         document: documentNodeQueryFightStyleResult,
         parserFn: _parserFnQueryFightStyleResult,
       );

  final OnQueryCompleteQueryFightStyleResult? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryFightStyleResult extends graphql.WatchQueryOptions<QueryFightStyleResult> {
  WatchOptionsQueryFightStyleResult({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryFightStyleResult? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'FightStyleResult',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryFightStyleResult,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryFightStyleResult,
       );
}

class FetchMoreOptionsQueryFightStyleResult extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryFightStyleResult({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryFightStyleResult);
}

extension ClientExtensionQueryFightStyleResult on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryFightStyleResult>> queryFightStyleResult([
    OptionsQueryFightStyleResult? options,
  ]) async => await this.query(options ?? OptionsQueryFightStyleResult());

  graphql.ObservableQuery<QueryFightStyleResult> watchQueryFightStyleResult([
    WatchOptionsQueryFightStyleResult? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryFightStyleResult());

  void writeQueryFightStyleResult({required QueryFightStyleResult data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryFightStyleResult)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryFightStyleResult? readQueryFightStyleResult({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryFightStyleResult)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryFightStyleResult.fromJson(result);
  }
}

class QueryFightStyleResultquizResults {
  QueryFightStyleResultquizResults({
    required this.id,
    required this.ranked,
    this.$__typename = 'quizResults',
  });

  factory QueryFightStyleResultquizResults.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$ranked = json['ranked'];
    final l$$__typename = json['__typename'];
    return QueryFightStyleResultquizResults(
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
    if (other is! QueryFightStyleResultquizResults || runtimeType != other.runtimeType) {
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
