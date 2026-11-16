// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryCapsules {
  QueryCapsules({required this.capsules, this.$__typename = 'query_root'});

  factory QueryCapsules.fromJson(Map<String, dynamic> json) {
    final l$capsules = json['capsules'];
    final l$$__typename = json['__typename'];
    return QueryCapsules(
      capsules: (l$capsules as List<dynamic>)
          .map((e) => QueryCapsulescapsules.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryCapsulescapsules> capsules;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$capsules = capsules;
    _resultData['capsules'] = l$capsules.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$capsules = capsules;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$capsules.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCapsules || runtimeType != other.runtimeType) {
      return false;
    }
    final l$capsules = capsules;
    final lOther$capsules = other.capsules;
    if (l$capsules.length != lOther$capsules.length) {
      return false;
    }
    for (int i = 0; i < l$capsules.length; i++) {
      final l$capsules$entry = l$capsules[i];
      final lOther$capsules$entry = lOther$capsules[i];
      if (l$capsules$entry != lOther$capsules$entry) {
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

const documentNodeQueryCapsules = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Capsules'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'capsules'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'opensOn'),
                      value: EnumValueNode(name: NameNode(value: 'asc')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '100'),
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
                  name: NameNode(value: 'coupleId'),
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
                  name: NameNode(value: 'opensOn'),
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
QueryCapsules _parserFnQueryCapsules(Map<String, dynamic> data) => QueryCapsules.fromJson(data);
typedef OnQueryCompleteQueryCapsules = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryCapsules?,
);

class OptionsQueryCapsules extends graphql.QueryOptions<QueryCapsules> {
  OptionsQueryCapsules({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCapsules? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryCapsules? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'Capsules',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryCapsules(data)),
         onError: onError,
         document: documentNodeQueryCapsules,
         parserFn: _parserFnQueryCapsules,
       );

  final OnQueryCompleteQueryCapsules? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryCapsules extends graphql.WatchQueryOptions<QueryCapsules> {
  WatchOptionsQueryCapsules({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCapsules? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'Capsules',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryCapsules,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryCapsules,
       );
}

class FetchMoreOptionsQueryCapsules extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryCapsules({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryCapsules);
}

extension ClientExtensionQueryCapsules on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryCapsules>> queryCapsules([OptionsQueryCapsules? options]) async =>
      await this.query(options ?? OptionsQueryCapsules());

  graphql.ObservableQuery<QueryCapsules> watchQueryCapsules([WatchOptionsQueryCapsules? options]) =>
      this.watchQuery(options ?? WatchOptionsQueryCapsules());

  void writeQueryCapsules({required QueryCapsules data, bool broadcast = true}) => this.writeQuery(
    graphql.Request(operation: graphql.Operation(document: documentNodeQueryCapsules)),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryCapsules? readQueryCapsules({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryCapsules)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryCapsules.fromJson(result);
  }
}

class QueryCapsulescapsules {
  QueryCapsulescapsules({
    required this.id,
    required this.authorId,
    this.coupleId,
    required this.body,
    required this.opensOn,
    this.$__typename = 'capsules',
  });

  factory QueryCapsulescapsules.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$body = json['body'];
    final l$opensOn = json['opensOn'];
    final l$$__typename = json['__typename'];
    return QueryCapsulescapsules(
      id: (l$id as String),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      body: (l$body as String),
      opensOn: DateTime.parse((l$opensOn as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String authorId;

  final String? coupleId;

  final String body;

  final DateTime opensOn;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$opensOn = opensOn;
    _resultData['opensOn'] = ((v) => v.toIso8601String().substring(0, 10))(l$opensOn);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$body = body;
    final l$opensOn = opensOn;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$authorId, l$coupleId, l$body, l$opensOn, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCapsulescapsules || runtimeType != other.runtimeType) {
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
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$opensOn = opensOn;
    final lOther$opensOn = other.opensOn;
    if (l$opensOn != lOther$opensOn) {
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
