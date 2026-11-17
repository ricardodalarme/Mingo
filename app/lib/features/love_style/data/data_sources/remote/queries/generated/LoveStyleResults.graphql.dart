// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryLoveStyleResults {
  QueryLoveStyleResults({
    required this.today,
    required this.quizResults,
    this.$__typename = 'query_root',
  });

  factory QueryLoveStyleResults.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    final l$quizResults = json['quizResults'];
    final l$$__typename = json['__typename'];
    return QueryLoveStyleResults(
      today: (l$today as List<dynamic>)
          .map((e) => QueryLoveStyleResultstoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      quizResults: (l$quizResults as List<dynamic>)
          .map((e) => QueryLoveStyleResultsquizResults.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryLoveStyleResultstoday> today;

  final List<QueryLoveStyleResultsquizResults> quizResults;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$today = today;
    _resultData['today'] = l$today.map((e) => e.toJson()).toList();
    final l$quizResults = quizResults;
    _resultData['quizResults'] = l$quizResults.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$today = today;
    final l$quizResults = quizResults;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$today.map((v) => v)),
      Object.hashAll(l$quizResults.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLoveStyleResults || runtimeType != other.runtimeType) {
      return false;
    }
    final l$today = today;
    final lOther$today = other.today;
    if (l$today.length != lOther$today.length) {
      return false;
    }
    for (int i = 0; i < l$today.length; i++) {
      final l$today$entry = l$today[i];
      final lOther$today$entry = lOther$today[i];
      if (l$today$entry != lOther$today$entry) {
        return false;
      }
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

const documentNodeQueryLoveStyleResults = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'LoveStyleResults'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'today'),
            alias: null,
            arguments: [],
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
                value: IntValueNode(value: '2'),
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
                  name: NameNode(value: 'authorId'),
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
                  name: NameNode(value: 'sharedAt'),
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
QueryLoveStyleResults _parserFnQueryLoveStyleResults(Map<String, dynamic> data) =>
    QueryLoveStyleResults.fromJson(data);
typedef OnQueryCompleteQueryLoveStyleResults = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryLoveStyleResults?,
);

class OptionsQueryLoveStyleResults extends graphql.QueryOptions<QueryLoveStyleResults> {
  OptionsQueryLoveStyleResults({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLoveStyleResults? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryLoveStyleResults? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'LoveStyleResults',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryLoveStyleResults(data)),
         onError: onError,
         document: documentNodeQueryLoveStyleResults,
         parserFn: _parserFnQueryLoveStyleResults,
       );

  final OnQueryCompleteQueryLoveStyleResults? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryLoveStyleResults extends graphql.WatchQueryOptions<QueryLoveStyleResults> {
  WatchOptionsQueryLoveStyleResults({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLoveStyleResults? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'LoveStyleResults',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryLoveStyleResults,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryLoveStyleResults,
       );
}

class FetchMoreOptionsQueryLoveStyleResults extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryLoveStyleResults({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryLoveStyleResults);
}

extension ClientExtensionQueryLoveStyleResults on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryLoveStyleResults>> queryLoveStyleResults([
    OptionsQueryLoveStyleResults? options,
  ]) async => await this.query(options ?? OptionsQueryLoveStyleResults());

  graphql.ObservableQuery<QueryLoveStyleResults> watchQueryLoveStyleResults([
    WatchOptionsQueryLoveStyleResults? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryLoveStyleResults());

  void writeQueryLoveStyleResults({required QueryLoveStyleResults data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryLoveStyleResults)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryLoveStyleResults? readQueryLoveStyleResults({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryLoveStyleResults)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryLoveStyleResults.fromJson(result);
  }
}

class QueryLoveStyleResultstoday {
  QueryLoveStyleResultstoday({this.userId, this.$__typename = 'today'});

  factory QueryLoveStyleResultstoday.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$$__typename = json['__typename'];
    return QueryLoveStyleResultstoday(
      userId: (l$userId as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? userId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLoveStyleResultstoday || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
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

class QueryLoveStyleResultsquizResults {
  QueryLoveStyleResultsquizResults({
    required this.id,
    required this.authorId,
    required this.ranked,
    this.sharedAt,
    this.$__typename = 'quizResults',
  });

  factory QueryLoveStyleResultsquizResults.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$authorId = json['authorId'];
    final l$ranked = json['ranked'];
    final l$sharedAt = json['sharedAt'];
    final l$$__typename = json['__typename'];
    return QueryLoveStyleResultsquizResults(
      id: (l$id as String),
      authorId: (l$authorId as String),
      ranked: (l$ranked as List<dynamic>).map((e) => (e as String)).toList(),
      sharedAt: l$sharedAt == null ? null : DateTime.parse((l$sharedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String authorId;

  final List<String> ranked;

  final DateTime? sharedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$ranked = ranked;
    _resultData['ranked'] = l$ranked.map((e) => e).toList();
    final l$sharedAt = sharedAt;
    _resultData['sharedAt'] = l$sharedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$sharedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$authorId = authorId;
    final l$ranked = ranked;
    final l$sharedAt = sharedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$authorId,
      Object.hashAll(l$ranked.map((v) => v)),
      l$sharedAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLoveStyleResultsquizResults || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
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
    final l$sharedAt = sharedAt;
    final lOther$sharedAt = other.sharedAt;
    if (l$sharedAt != lOther$sharedAt) {
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
