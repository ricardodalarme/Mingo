// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryLearnedItems {
  QueryLearnedItems({required this.learnedItems, this.$__typename = 'query_root'});

  factory QueryLearnedItems.fromJson(Map<String, dynamic> json) {
    final l$learnedItems = json['learnedItems'];
    final l$$__typename = json['__typename'];
    return QueryLearnedItems(
      learnedItems: (l$learnedItems as List<dynamic>)
          .map((e) => QueryLearnedItemslearnedItems.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryLearnedItemslearnedItems> learnedItems;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$learnedItems = learnedItems;
    _resultData['learnedItems'] = l$learnedItems.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$learnedItems = learnedItems;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$learnedItems.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLearnedItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$learnedItems = learnedItems;
    final lOther$learnedItems = other.learnedItems;
    if (l$learnedItems.length != lOther$learnedItems.length) {
      return false;
    }
    for (int i = 0; i < l$learnedItems.length; i++) {
      final l$learnedItems$entry = l$learnedItems[i];
      final lOther$learnedItems$entry = lOther$learnedItems[i];
      if (l$learnedItems$entry != lOther$learnedItems$entry) {
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

const documentNodeQueryLearnedItems = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'LearnedItems'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'learnedItems'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '50'),
              ),
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
                  name: NameNode(value: 'target'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'text'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'excerpt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'status'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'createdAt'),
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
QueryLearnedItems _parserFnQueryLearnedItems(Map<String, dynamic> data) =>
    QueryLearnedItems.fromJson(data);
typedef OnQueryCompleteQueryLearnedItems = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryLearnedItems?,
);

class OptionsQueryLearnedItems extends graphql.QueryOptions<QueryLearnedItems> {
  OptionsQueryLearnedItems({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLearnedItems? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryLearnedItems? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'LearnedItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryLearnedItems(data)),
         onError: onError,
         document: documentNodeQueryLearnedItems,
         parserFn: _parserFnQueryLearnedItems,
       );

  final OnQueryCompleteQueryLearnedItems? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryLearnedItems extends graphql.WatchQueryOptions<QueryLearnedItems> {
  WatchOptionsQueryLearnedItems({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLearnedItems? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'LearnedItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryLearnedItems,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryLearnedItems,
       );
}

class FetchMoreOptionsQueryLearnedItems extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryLearnedItems({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryLearnedItems);
}

extension ClientExtensionQueryLearnedItems on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryLearnedItems>> queryLearnedItems([
    OptionsQueryLearnedItems? options,
  ]) async => await this.query(options ?? OptionsQueryLearnedItems());

  graphql.ObservableQuery<QueryLearnedItems> watchQueryLearnedItems([
    WatchOptionsQueryLearnedItems? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryLearnedItems());

  void writeQueryLearnedItems({required QueryLearnedItems data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryLearnedItems)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryLearnedItems? readQueryLearnedItems({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryLearnedItems)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryLearnedItems.fromJson(result);
  }
}

class QueryLearnedItemslearnedItems {
  QueryLearnedItemslearnedItems({
    required this.id,
    required this.target,
    required this.text,
    this.excerpt,
    required this.status,
    required this.createdAt,
    this.$__typename = 'learnedItems',
  });

  factory QueryLearnedItemslearnedItems.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$target = json['target'];
    final l$text = json['text'];
    final l$excerpt = json['excerpt'];
    final l$status = json['status'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return QueryLearnedItemslearnedItems(
      id: (l$id as String),
      target: fromJsonEnumLearnedItemTarget_enum((l$target as String)),
      text: (l$text as String),
      excerpt: (l$excerpt as String?),
      status: fromJsonEnumLearnedItemStatus_enum((l$status as String)),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumLearnedItemTarget_enum target;

  final String text;

  final String? excerpt;

  final EnumLearnedItemStatus_enum status;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$target = target;
    _resultData['target'] = toJsonEnumLearnedItemTarget_enum(l$target);
    final l$text = text;
    _resultData['text'] = l$text;
    final l$excerpt = excerpt;
    _resultData['excerpt'] = l$excerpt;
    final l$status = status;
    _resultData['status'] = toJsonEnumLearnedItemStatus_enum(l$status);
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$target = target;
    final l$text = text;
    final l$excerpt = excerpt;
    final l$status = status;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$target,
      l$text,
      l$excerpt,
      l$status,
      l$createdAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLearnedItemslearnedItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$target = target;
    final lOther$target = other.target;
    if (l$target != lOther$target) {
      return false;
    }
    final l$text = text;
    final lOther$text = other.text;
    if (l$text != lOther$text) {
      return false;
    }
    final l$excerpt = excerpt;
    final lOther$excerpt = other.excerpt;
    if (l$excerpt != lOther$excerpt) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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
