// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryGiftIdeas {
  QueryGiftIdeas({required this.giftIdeas, this.$__typename = 'query_root'});

  factory QueryGiftIdeas.fromJson(Map<String, dynamic> json) {
    final l$giftIdeas = json['giftIdeas'];
    final l$$__typename = json['__typename'];
    return QueryGiftIdeas(
      giftIdeas: (l$giftIdeas as List<dynamic>)
          .map((e) => QueryGiftIdeasgiftIdeas.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryGiftIdeasgiftIdeas> giftIdeas;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$giftIdeas = giftIdeas;
    _resultData['giftIdeas'] = l$giftIdeas.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$giftIdeas = giftIdeas;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$giftIdeas.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGiftIdeas || runtimeType != other.runtimeType) {
      return false;
    }
    final l$giftIdeas = giftIdeas;
    final lOther$giftIdeas = other.giftIdeas;
    if (l$giftIdeas.length != lOther$giftIdeas.length) {
      return false;
    }
    for (int i = 0; i < l$giftIdeas.length; i++) {
      final l$giftIdeas$entry = l$giftIdeas[i];
      final lOther$giftIdeas$entry = lOther$giftIdeas[i];
      if (l$giftIdeas$entry != lOther$giftIdeas$entry) {
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

const documentNodeQueryGiftIdeas = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GiftIdeas'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'giftIdeas'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'kind'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: EnumValueNode(name: NameNode(value: 'idea')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                  name: NameNode(value: 'status'),
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
QueryGiftIdeas _parserFnQueryGiftIdeas(Map<String, dynamic> data) => QueryGiftIdeas.fromJson(data);
typedef OnQueryCompleteQueryGiftIdeas = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryGiftIdeas?,
);

class OptionsQueryGiftIdeas extends graphql.QueryOptions<QueryGiftIdeas> {
  OptionsQueryGiftIdeas({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGiftIdeas? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryGiftIdeas? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'GiftIdeas',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryGiftIdeas(data)),
         onError: onError,
         document: documentNodeQueryGiftIdeas,
         parserFn: _parserFnQueryGiftIdeas,
       );

  final OnQueryCompleteQueryGiftIdeas? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryGiftIdeas extends graphql.WatchQueryOptions<QueryGiftIdeas> {
  WatchOptionsQueryGiftIdeas({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGiftIdeas? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'GiftIdeas',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGiftIdeas,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryGiftIdeas,
       );
}

class FetchMoreOptionsQueryGiftIdeas extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryGiftIdeas({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryGiftIdeas);
}

extension ClientExtensionQueryGiftIdeas on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryGiftIdeas>> queryGiftIdeas([
    OptionsQueryGiftIdeas? options,
  ]) async => await this.query(options ?? OptionsQueryGiftIdeas());

  graphql.ObservableQuery<QueryGiftIdeas> watchQueryGiftIdeas([
    WatchOptionsQueryGiftIdeas? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryGiftIdeas());

  void writeQueryGiftIdeas({required QueryGiftIdeas data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryGiftIdeas)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryGiftIdeas? readQueryGiftIdeas({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryGiftIdeas)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryGiftIdeas.fromJson(result);
  }
}

class QueryGiftIdeasgiftIdeas {
  QueryGiftIdeasgiftIdeas({
    required this.id,
    required this.title,
    required this.status,
    required this.authorId,
    this.$__typename = 'giftIdeas',
  });

  factory QueryGiftIdeasgiftIdeas.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$status = json['status'];
    final l$authorId = json['authorId'];
    final l$$__typename = json['__typename'];
    return QueryGiftIdeasgiftIdeas(
      id: (l$id as String),
      title: (l$title as String),
      status: fromJsonEnumGiftIdeaStatus_enum((l$status as String)),
      authorId: (l$authorId as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final EnumGiftIdeaStatus_enum status;

  final String authorId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$status = status;
    _resultData['status'] = toJsonEnumGiftIdeaStatus_enum(l$status);
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$status = status;
    final l$authorId = authorId;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$title, l$status, l$authorId, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGiftIdeasgiftIdeas || runtimeType != other.runtimeType) {
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
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
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
