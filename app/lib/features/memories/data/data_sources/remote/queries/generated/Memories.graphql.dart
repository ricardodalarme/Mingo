// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryMemories {
  QueryMemories({required this.memories, this.$__typename = 'query_root'});

  factory QueryMemories.fromJson(Map<String, dynamic> json) {
    final l$memories = json['memories'];
    final l$$__typename = json['__typename'];
    return QueryMemories(
      memories: (l$memories as List<dynamic>)
          .map((e) => QueryMemoriesmemories.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMemoriesmemories> memories;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$memories = memories;
    _resultData['memories'] = l$memories.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$memories = memories;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$memories.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMemories || runtimeType != other.runtimeType) {
      return false;
    }
    final l$memories = memories;
    final lOther$memories = other.memories;
    if (l$memories.length != lOther$memories.length) {
      return false;
    }
    for (int i = 0; i < l$memories.length; i++) {
      final l$memories$entry = l$memories[i];
      final lOther$memories$entry = lOther$memories[i];
      if (l$memories$entry != lOther$memories$entry) {
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

const documentNodeQueryMemories = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Memories'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'memories'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'happenedOn'),
                      value: EnumValueNode(name: NameNode(value: 'desc')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '200'),
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
                  name: NameNode(value: 'happenedOn'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'place'),
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
QueryMemories _parserFnQueryMemories(Map<String, dynamic> data) => QueryMemories.fromJson(data);
typedef OnQueryCompleteQueryMemories = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMemories?,
);

class OptionsQueryMemories extends graphql.QueryOptions<QueryMemories> {
  OptionsQueryMemories({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMemories? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMemories? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'Memories',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMemories(data)),
         onError: onError,
         document: documentNodeQueryMemories,
         parserFn: _parserFnQueryMemories,
       );

  final OnQueryCompleteQueryMemories? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMemories extends graphql.WatchQueryOptions<QueryMemories> {
  WatchOptionsQueryMemories({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMemories? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'Memories',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMemories,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMemories,
       );
}

class FetchMoreOptionsQueryMemories extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMemories({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryMemories);
}

extension ClientExtensionQueryMemories on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMemories>> queryMemories([OptionsQueryMemories? options]) async =>
      await this.query(options ?? OptionsQueryMemories());

  graphql.ObservableQuery<QueryMemories> watchQueryMemories([WatchOptionsQueryMemories? options]) =>
      this.watchQuery(options ?? WatchOptionsQueryMemories());

  void writeQueryMemories({required QueryMemories data, bool broadcast = true}) => this.writeQuery(
    graphql.Request(operation: graphql.Operation(document: documentNodeQueryMemories)),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMemories? readQueryMemories({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryMemories)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMemories.fromJson(result);
  }
}

class QueryMemoriesmemories {
  QueryMemoriesmemories({
    required this.id,
    required this.title,
    this.body,
    required this.happenedOn,
    this.place,
    this.$__typename = 'memories',
  });

  factory QueryMemoriesmemories.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$body = json['body'];
    final l$happenedOn = json['happenedOn'];
    final l$place = json['place'];
    final l$$__typename = json['__typename'];
    return QueryMemoriesmemories(
      id: (l$id as String),
      title: (l$title as String),
      body: (l$body as String?),
      happenedOn: DateTime.parse((l$happenedOn as String)),
      place: (l$place as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String? body;

  final DateTime happenedOn;

  final String? place;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$happenedOn = happenedOn;
    _resultData['happenedOn'] = ((v) => v.toIso8601String().substring(0, 10))(l$happenedOn);
    final l$place = place;
    _resultData['place'] = l$place;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$body = body;
    final l$happenedOn = happenedOn;
    final l$place = place;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$title, l$body, l$happenedOn, l$place, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMemoriesmemories || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
    final l$happenedOn = happenedOn;
    final lOther$happenedOn = other.happenedOn;
    if (l$happenedOn != lOther$happenedOn) {
      return false;
    }
    final l$place = place;
    final lOther$place = other.place;
    if (l$place != lOther$place) {
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
