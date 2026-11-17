// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QuerySpiceMatches {
  QuerySpiceMatches({required this.spiceMatches, this.$__typename = 'query_root'});

  factory QuerySpiceMatches.fromJson(Map<String, dynamic> json) {
    final l$spiceMatches = json['spiceMatches'];
    final l$$__typename = json['__typename'];
    return QuerySpiceMatches(
      spiceMatches: (l$spiceMatches as List<dynamic>)
          .map((e) => QuerySpiceMatchesspiceMatches.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QuerySpiceMatchesspiceMatches> spiceMatches;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceMatches = spiceMatches;
    _resultData['spiceMatches'] = l$spiceMatches.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceMatches = spiceMatches;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$spiceMatches.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySpiceMatches || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceMatches = spiceMatches;
    final lOther$spiceMatches = other.spiceMatches;
    if (l$spiceMatches.length != lOther$spiceMatches.length) {
      return false;
    }
    for (int i = 0; i < l$spiceMatches.length; i++) {
      final l$spiceMatches$entry = l$spiceMatches[i];
      final lOther$spiceMatches$entry = lOther$spiceMatches[i];
      if (l$spiceMatches$entry != lOther$spiceMatches$entry) {
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

const documentNodeQuerySpiceMatches = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SpiceMatches'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceMatches'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'slug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'title'),
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
QuerySpiceMatches _parserFnQuerySpiceMatches(Map<String, dynamic> data) =>
    QuerySpiceMatches.fromJson(data);
typedef OnQueryCompleteQuerySpiceMatches = FutureOr<void> Function(
  Map<String, dynamic>?,
  QuerySpiceMatches?,
);

class OptionsQuerySpiceMatches extends graphql.QueryOptions<QuerySpiceMatches> {
  OptionsQuerySpiceMatches({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySpiceMatches? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQuerySpiceMatches? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'SpiceMatches',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQuerySpiceMatches(data)),
         onError: onError,
         document: documentNodeQuerySpiceMatches,
         parserFn: _parserFnQuerySpiceMatches,
       );

  final OnQueryCompleteQuerySpiceMatches? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQuerySpiceMatches extends graphql.WatchQueryOptions<QuerySpiceMatches> {
  WatchOptionsQuerySpiceMatches({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySpiceMatches? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'SpiceMatches',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQuerySpiceMatches,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQuerySpiceMatches,
       );
}

class FetchMoreOptionsQuerySpiceMatches extends graphql.FetchMoreOptions {
  FetchMoreOptionsQuerySpiceMatches({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQuerySpiceMatches);
}

extension ClientExtensionQuerySpiceMatches on graphql.GraphQLClient {
  Future<graphql.QueryResult<QuerySpiceMatches>> querySpiceMatches([
    OptionsQuerySpiceMatches? options,
  ]) async => await this.query(options ?? OptionsQuerySpiceMatches());

  graphql.ObservableQuery<QuerySpiceMatches> watchQuerySpiceMatches([
    WatchOptionsQuerySpiceMatches? options,
  ]) => this.watchQuery(options ?? WatchOptionsQuerySpiceMatches());

  void writeQuerySpiceMatches({required QuerySpiceMatches data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQuerySpiceMatches)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QuerySpiceMatches? readQuerySpiceMatches({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQuerySpiceMatches)),
      optimistic: optimistic,
    );
    return result == null ? null : QuerySpiceMatches.fromJson(result);
  }
}

class QuerySpiceMatchesspiceMatches {
  QuerySpiceMatchesspiceMatches({
    required this.slug,
    required this.title,
    this.body,
    this.$__typename = 'catalogItems',
  });

  factory QuerySpiceMatchesspiceMatches.fromJson(Map<String, dynamic> json) {
    final l$slug = json['slug'];
    final l$title = json['title'];
    final l$body = json['body'];
    final l$$__typename = json['__typename'];
    return QuerySpiceMatchesspiceMatches(
      slug: (l$slug as String),
      title: (l$title as String),
      body: (l$body as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String slug;

  final String title;

  final String? body;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$slug = slug;
    final l$title = title;
    final l$body = body;
    final l$$__typename = $__typename;
    return Object.hashAll([l$slug, l$title, l$body, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySpiceMatchesspiceMatches || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
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
