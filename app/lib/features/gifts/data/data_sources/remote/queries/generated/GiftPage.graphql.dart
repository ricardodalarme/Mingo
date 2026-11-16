// dart format width=100
import '../../fragments/generated/GiftWishFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryGiftPage {
  QueryGiftPage({required this.giftIdeas, this.$__typename = 'query_root'});

  factory QueryGiftPage.fromJson(Map<String, dynamic> json) {
    final l$giftIdeas = json['giftIdeas'];
    final l$$__typename = json['__typename'];
    return QueryGiftPage(
      giftIdeas: (l$giftIdeas as List<dynamic>)
          .map((e) => FragmentGiftWishFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<FragmentGiftWishFragment> giftIdeas;

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
    if (other is! QueryGiftPage || runtimeType != other.runtimeType) {
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

const documentNodeQueryGiftPage = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GiftPage'),
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
                            value: EnumValueNode(name: NameNode(value: 'wish')),
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
                FragmentSpreadNode(
                  name: NameNode(value: 'GiftWishFragment'),
                  directives: [],
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
    fragmentDefinitionGiftWishFragment,
  ],
);
QueryGiftPage _parserFnQueryGiftPage(Map<String, dynamic> data) => QueryGiftPage.fromJson(data);
typedef OnQueryCompleteQueryGiftPage = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryGiftPage?,
);

class OptionsQueryGiftPage extends graphql.QueryOptions<QueryGiftPage> {
  OptionsQueryGiftPage({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGiftPage? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryGiftPage? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'GiftPage',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryGiftPage(data)),
         onError: onError,
         document: documentNodeQueryGiftPage,
         parserFn: _parserFnQueryGiftPage,
       );

  final OnQueryCompleteQueryGiftPage? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryGiftPage extends graphql.WatchQueryOptions<QueryGiftPage> {
  WatchOptionsQueryGiftPage({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGiftPage? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'GiftPage',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGiftPage,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryGiftPage,
       );
}

class FetchMoreOptionsQueryGiftPage extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryGiftPage({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryGiftPage);
}

extension ClientExtensionQueryGiftPage on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryGiftPage>> queryGiftPage([OptionsQueryGiftPage? options]) async =>
      await this.query(options ?? OptionsQueryGiftPage());

  graphql.ObservableQuery<QueryGiftPage> watchQueryGiftPage([WatchOptionsQueryGiftPage? options]) =>
      this.watchQuery(options ?? WatchOptionsQueryGiftPage());

  void writeQueryGiftPage({required QueryGiftPage data, bool broadcast = true}) => this.writeQuery(
    graphql.Request(operation: graphql.Operation(document: documentNodeQueryGiftPage)),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryGiftPage? readQueryGiftPage({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryGiftPage)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryGiftPage.fromJson(result);
  }
}
