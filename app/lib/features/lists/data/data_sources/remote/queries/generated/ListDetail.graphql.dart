// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';
import '../../fragments/generated/ListFragment.graphql.dart';
import '../../fragments/generated/ListItemFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryListDetail {
  factory VariablesQueryListDetail({required String id}) => VariablesQueryListDetail._({r'id': id});

  VariablesQueryListDetail._(this._$data);

  factory VariablesQueryListDetail.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesQueryListDetail._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryListDetail || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

class QueryListDetail {
  QueryListDetail({this.listsByPk, this.$__typename = 'query_root'});

  factory QueryListDetail.fromJson(Map<String, dynamic> json) {
    final l$listsByPk = json['listsByPk'];
    final l$$__typename = json['__typename'];
    return QueryListDetail(
      listsByPk: l$listsByPk == null
          ? null
          : QueryListDetaillistsByPk.fromJson((l$listsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryListDetaillistsByPk? listsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$listsByPk = listsByPk;
    _resultData['listsByPk'] = l$listsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$listsByPk = listsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$listsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryListDetail || runtimeType != other.runtimeType) {
      return false;
    }
    final l$listsByPk = listsByPk;
    final lOther$listsByPk = other.listsByPk;
    if (l$listsByPk != lOther$listsByPk) {
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

const documentNodeQueryListDetail = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'ListDetail'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'listsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ListFragment'),
                  directives: [],
                ),
                FieldNode(
                  name: NameNode(value: 'items'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'order_by'),
                      value: ListValueNode(
                        values: [
                          ObjectValueNode(
                            fields: [
                              ObjectFieldNode(
                                name: NameNode(value: 'position'),
                                value: EnumValueNode(name: NameNode(value: 'asc_nulls_last')),
                              ),
                            ],
                          ),
                          ObjectValueNode(
                            fields: [
                              ObjectFieldNode(
                                name: NameNode(value: 'createdAt'),
                                value: EnumValueNode(name: NameNode(value: 'asc_nulls_last')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'limit'),
                      value: IntValueNode(value: '500'),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'ListItemFragment'),
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
    fragmentDefinitionListFragment,
    fragmentDefinitionListItemFragment,
  ],
);
QueryListDetail _parserFnQueryListDetail(Map<String, dynamic> data) =>
    QueryListDetail.fromJson(data);
typedef OnQueryCompleteQueryListDetail = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryListDetail?,
);

class OptionsQueryListDetail extends graphql.QueryOptions<QueryListDetail> {
  OptionsQueryListDetail({
    String? operationName,
    required VariablesQueryListDetail variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryListDetail? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryListDetail? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ListDetail',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryListDetail(data)),
         onError: onError,
         document: documentNodeQueryListDetail,
         parserFn: _parserFnQueryListDetail,
       );

  final OnQueryCompleteQueryListDetail? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryListDetail extends graphql.WatchQueryOptions<QueryListDetail> {
  WatchOptionsQueryListDetail({
    String? operationName,
    required VariablesQueryListDetail variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryListDetail? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ListDetail',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryListDetail,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryListDetail,
       );
}

class FetchMoreOptionsQueryListDetail extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryListDetail({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryListDetail variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryListDetail,
       );
}

extension ClientExtensionQueryListDetail on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryListDetail>> queryListDetail(
    OptionsQueryListDetail options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryListDetail> watchQueryListDetail(
    WatchOptionsQueryListDetail options,
  ) => this.watchQuery(options);

  void writeQueryListDetail({
    required QueryListDetail data,
    required VariablesQueryListDetail variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryListDetail),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryListDetail? readQueryListDetail({
    required VariablesQueryListDetail variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryListDetail),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryListDetail.fromJson(result);
  }
}

class QueryListDetaillistsByPk implements FragmentListFragment {
  QueryListDetaillistsByPk({
    required this.id,
    required this.title,
    required this.kind,
    required this.authorId,
    this.coupleId,
    this.$__typename = 'lists',
    required this.items,
  });

  factory QueryListDetaillistsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$kind = json['kind'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$$__typename = json['__typename'];
    final l$items = json['items'];
    return QueryListDetaillistsByPk(
      id: (l$id as String),
      title: (l$title as String),
      kind: fromJsonEnumListKind_enum((l$kind as String)),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      $__typename: (l$$__typename as String),
      items: (l$items as List<dynamic>)
          .map((e) => FragmentListItemFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final String id;

  final String title;

  final EnumListKind_enum kind;

  final String authorId;

  final String? coupleId;

  final String $__typename;

  final List<FragmentListItemFragment> items;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumListKind_enum(l$kind);
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$items = items;
    _resultData['items'] = l$items.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$kind = kind;
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$$__typename = $__typename;
    final l$items = items;
    return Object.hashAll([
      l$id,
      l$title,
      l$kind,
      l$authorId,
      l$coupleId,
      l$$__typename,
      Object.hashAll(l$items.map((v) => v)),
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryListDetaillistsByPk || runtimeType != other.runtimeType) {
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
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$items = items;
    final lOther$items = other.items;
    if (l$items.length != lOther$items.length) {
      return false;
    }
    for (int i = 0; i < l$items.length; i++) {
      final l$items$entry = l$items[i];
      final lOther$items$entry = lOther$items[i];
      if (l$items$entry != lOther$items$entry) {
        return false;
      }
    }
    return true;
  }
}
