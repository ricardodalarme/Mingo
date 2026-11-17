// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryQuizResultsOverview {
  QueryQuizResultsOverview({
    required this.today,
    required this.quizResults,
    this.$__typename = 'query_root',
  });

  factory QueryQuizResultsOverview.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    final l$quizResults = json['quizResults'];
    final l$$__typename = json['__typename'];
    return QueryQuizResultsOverview(
      today: (l$today as List<dynamic>)
          .map((e) => QueryQuizResultsOverviewtoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      quizResults: (l$quizResults as List<dynamic>)
          .map((e) => QueryQuizResultsOverviewquizResults.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryQuizResultsOverviewtoday> today;

  final List<QueryQuizResultsOverviewquizResults> quizResults;

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
    if (other is! QueryQuizResultsOverview || runtimeType != other.runtimeType) {
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

const documentNodeQueryQuizResultsOverview = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'QuizResultsOverview'),
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
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '6'),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'updatedAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'authorId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'quizKey'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'updatedAt'),
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
QueryQuizResultsOverview _parserFnQueryQuizResultsOverview(Map<String, dynamic> data) =>
    QueryQuizResultsOverview.fromJson(data);
typedef OnQueryCompleteQueryQuizResultsOverview = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryQuizResultsOverview?,
);

class OptionsQueryQuizResultsOverview extends graphql.QueryOptions<QueryQuizResultsOverview> {
  OptionsQueryQuizResultsOverview({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryQuizResultsOverview? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryQuizResultsOverview? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'QuizResultsOverview',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryQuizResultsOverview(data)),
         onError: onError,
         document: documentNodeQueryQuizResultsOverview,
         parserFn: _parserFnQueryQuizResultsOverview,
       );

  final OnQueryCompleteQueryQuizResultsOverview? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryQuizResultsOverview
    extends graphql.WatchQueryOptions<QueryQuizResultsOverview> {
  WatchOptionsQueryQuizResultsOverview({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryQuizResultsOverview? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'QuizResultsOverview',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryQuizResultsOverview,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryQuizResultsOverview,
       );
}

class FetchMoreOptionsQueryQuizResultsOverview extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryQuizResultsOverview({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryQuizResultsOverview);
}

extension ClientExtensionQueryQuizResultsOverview on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryQuizResultsOverview>> queryQuizResultsOverview([
    OptionsQueryQuizResultsOverview? options,
  ]) async => await this.query(options ?? OptionsQueryQuizResultsOverview());

  graphql.ObservableQuery<QueryQuizResultsOverview> watchQueryQuizResultsOverview([
    WatchOptionsQueryQuizResultsOverview? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryQuizResultsOverview());

  void writeQueryQuizResultsOverview({
    required QueryQuizResultsOverview data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(operation: graphql.Operation(document: documentNodeQueryQuizResultsOverview)),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryQuizResultsOverview? readQueryQuizResultsOverview({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryQuizResultsOverview)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryQuizResultsOverview.fromJson(result);
  }
}

class QueryQuizResultsOverviewtoday {
  QueryQuizResultsOverviewtoday({this.userId, this.$__typename = 'today'});

  factory QueryQuizResultsOverviewtoday.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$$__typename = json['__typename'];
    return QueryQuizResultsOverviewtoday(
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
    if (other is! QueryQuizResultsOverviewtoday || runtimeType != other.runtimeType) {
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

class QueryQuizResultsOverviewquizResults {
  QueryQuizResultsOverviewquizResults({
    required this.authorId,
    required this.quizKey,
    required this.updatedAt,
    this.$__typename = 'quizResults',
  });

  factory QueryQuizResultsOverviewquizResults.fromJson(Map<String, dynamic> json) {
    final l$authorId = json['authorId'];
    final l$quizKey = json['quizKey'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return QueryQuizResultsOverviewquizResults(
      authorId: (l$authorId as String),
      quizKey: fromJsonEnumQuizKey_enum((l$quizKey as String)),
      updatedAt: DateTime.parse((l$updatedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String authorId;

  final EnumQuizKey_enum quizKey;

  final DateTime updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$quizKey = quizKey;
    _resultData['quizKey'] = toJsonEnumQuizKey_enum(l$quizKey);
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = ((v) => v.toUtc().toIso8601String())(l$updatedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$authorId = authorId;
    final l$quizKey = quizKey;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$authorId, l$quizKey, l$updatedAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryQuizResultsOverviewquizResults || runtimeType != other.runtimeType) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
      return false;
    }
    final l$quizKey = quizKey;
    final lOther$quizKey = other.quizKey;
    if (l$quizKey != lOther$quizKey) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
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
