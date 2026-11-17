// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryLogisticItems {
  QueryLogisticItems({required this.logisticItems, this.$__typename = 'query_root'});

  factory QueryLogisticItems.fromJson(Map<String, dynamic> json) {
    final l$logisticItems = json['logisticItems'];
    final l$$__typename = json['__typename'];
    return QueryLogisticItems(
      logisticItems: (l$logisticItems as List<dynamic>)
          .map((e) => QueryLogisticItemslogisticItems.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryLogisticItemslogisticItems> logisticItems;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$logisticItems = logisticItems;
    _resultData['logisticItems'] = l$logisticItems.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$logisticItems = logisticItems;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$logisticItems.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLogisticItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$logisticItems = logisticItems;
    final lOther$logisticItems = other.logisticItems;
    if (l$logisticItems.length != lOther$logisticItems.length) {
      return false;
    }
    for (int i = 0; i < l$logisticItems.length; i++) {
      final l$logisticItems$entry = l$logisticItems[i];
      final lOther$logisticItems$entry = lOther$logisticItems[i];
      if (l$logisticItems$entry != lOther$logisticItems$entry) {
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

const documentNodeQueryLogisticItems = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'LogisticItems'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'logisticItems'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'createdAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
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
                  name: NameNode(value: 'assigneeId'),
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
                  name: NameNode(value: 'doneAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'confirmedAt'),
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
QueryLogisticItems _parserFnQueryLogisticItems(Map<String, dynamic> data) =>
    QueryLogisticItems.fromJson(data);
typedef OnQueryCompleteQueryLogisticItems = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryLogisticItems?,
);

class OptionsQueryLogisticItems extends graphql.QueryOptions<QueryLogisticItems> {
  OptionsQueryLogisticItems({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLogisticItems? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryLogisticItems? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'LogisticItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryLogisticItems(data)),
         onError: onError,
         document: documentNodeQueryLogisticItems,
         parserFn: _parserFnQueryLogisticItems,
       );

  final OnQueryCompleteQueryLogisticItems? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryLogisticItems extends graphql.WatchQueryOptions<QueryLogisticItems> {
  WatchOptionsQueryLogisticItems({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLogisticItems? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'LogisticItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryLogisticItems,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryLogisticItems,
       );
}

class FetchMoreOptionsQueryLogisticItems extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryLogisticItems({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryLogisticItems);
}

extension ClientExtensionQueryLogisticItems on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryLogisticItems>> queryLogisticItems([
    OptionsQueryLogisticItems? options,
  ]) async => await this.query(options ?? OptionsQueryLogisticItems());

  graphql.ObservableQuery<QueryLogisticItems> watchQueryLogisticItems([
    WatchOptionsQueryLogisticItems? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryLogisticItems());

  void writeQueryLogisticItems({required QueryLogisticItems data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryLogisticItems)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryLogisticItems? readQueryLogisticItems({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryLogisticItems)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryLogisticItems.fromJson(result);
  }
}

class QueryLogisticItemslogisticItems {
  QueryLogisticItemslogisticItems({
    required this.id,
    required this.title,
    this.assigneeId,
    required this.authorId,
    this.coupleId,
    this.doneAt,
    this.confirmedAt,
    this.$__typename = 'logisticItems',
  });

  factory QueryLogisticItemslogisticItems.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$assigneeId = json['assigneeId'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$doneAt = json['doneAt'];
    final l$confirmedAt = json['confirmedAt'];
    final l$$__typename = json['__typename'];
    return QueryLogisticItemslogisticItems(
      id: (l$id as String),
      title: (l$title as String),
      assigneeId: (l$assigneeId as String?),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      doneAt: l$doneAt == null ? null : DateTime.parse((l$doneAt as String)),
      confirmedAt: l$confirmedAt == null ? null : DateTime.parse((l$confirmedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String? assigneeId;

  final String authorId;

  final String? coupleId;

  final DateTime? doneAt;

  final DateTime? confirmedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$assigneeId = assigneeId;
    _resultData['assigneeId'] = l$assigneeId;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$doneAt = doneAt;
    _resultData['doneAt'] = l$doneAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$doneAt);
    final l$confirmedAt = confirmedAt;
    _resultData['confirmedAt'] = l$confirmedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$confirmedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$assigneeId = assigneeId;
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$doneAt = doneAt;
    final l$confirmedAt = confirmedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$assigneeId,
      l$authorId,
      l$coupleId,
      l$doneAt,
      l$confirmedAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLogisticItemslogisticItems || runtimeType != other.runtimeType) {
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
    final l$assigneeId = assigneeId;
    final lOther$assigneeId = other.assigneeId;
    if (l$assigneeId != lOther$assigneeId) {
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
    final l$doneAt = doneAt;
    final lOther$doneAt = other.doneAt;
    if (l$doneAt != lOther$doneAt) {
      return false;
    }
    final l$confirmedAt = confirmedAt;
    final lOther$confirmedAt = other.confirmedAt;
    if (l$confirmedAt != lOther$confirmedAt) {
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
