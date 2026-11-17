// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryJarSlips {
  QueryJarSlips({required this.slips, this.$__typename = 'query_root'});

  factory QueryJarSlips.fromJson(Map<String, dynamic> json) {
    final l$slips = json['slips'];
    final l$$__typename = json['__typename'];
    return QueryJarSlips(
      slips: (l$slips as List<dynamic>)
          .map((e) => QueryJarSlipsslips.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryJarSlipsslips> slips;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$slips = slips;
    _resultData['slips'] = l$slips.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$slips = slips;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$slips.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryJarSlips || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slips = slips;
    final lOther$slips = other.slips;
    if (l$slips.length != lOther$slips.length) {
      return false;
    }
    for (int i = 0; i < l$slips.length; i++) {
      final l$slips$entry = l$slips[i];
      final lOther$slips$entry = lOther$slips[i];
      if (l$slips$entry != lOther$slips$entry) {
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

const documentNodeQueryJarSlips = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'JarSlips'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'slips'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'inJar'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: BooleanValueNode(value: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'createdAt'),
                      value: EnumValueNode(name: NameNode(value: 'desc')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '50'),
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
QueryJarSlips _parserFnQueryJarSlips(Map<String, dynamic> data) => QueryJarSlips.fromJson(data);
typedef OnQueryCompleteQueryJarSlips = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryJarSlips?,
);

class OptionsQueryJarSlips extends graphql.QueryOptions<QueryJarSlips> {
  OptionsQueryJarSlips({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryJarSlips? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryJarSlips? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'JarSlips',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryJarSlips(data)),
         onError: onError,
         document: documentNodeQueryJarSlips,
         parserFn: _parserFnQueryJarSlips,
       );

  final OnQueryCompleteQueryJarSlips? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryJarSlips extends graphql.WatchQueryOptions<QueryJarSlips> {
  WatchOptionsQueryJarSlips({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryJarSlips? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'JarSlips',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryJarSlips,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryJarSlips,
       );
}

class FetchMoreOptionsQueryJarSlips extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryJarSlips({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryJarSlips);
}

extension ClientExtensionQueryJarSlips on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryJarSlips>> queryJarSlips([OptionsQueryJarSlips? options]) async =>
      await this.query(options ?? OptionsQueryJarSlips());

  graphql.ObservableQuery<QueryJarSlips> watchQueryJarSlips([WatchOptionsQueryJarSlips? options]) =>
      this.watchQuery(options ?? WatchOptionsQueryJarSlips());

  void writeQueryJarSlips({required QueryJarSlips data, bool broadcast = true}) => this.writeQuery(
    graphql.Request(operation: graphql.Operation(document: documentNodeQueryJarSlips)),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryJarSlips? readQueryJarSlips({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryJarSlips)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryJarSlips.fromJson(result);
  }
}

class QueryJarSlipsslips {
  QueryJarSlipsslips({required this.id, required this.body, this.$__typename = 'slips'});

  factory QueryJarSlipsslips.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$body = json['body'];
    final l$$__typename = json['__typename'];
    return QueryJarSlipsslips(
      id: (l$id as String),
      body: (l$body as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String body;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$body = body;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$body, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryJarSlipsslips || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
