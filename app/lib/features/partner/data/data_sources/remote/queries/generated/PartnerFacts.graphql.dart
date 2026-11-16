// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryPartnerFacts {
  QueryPartnerFacts({required this.partnerFacts, this.$__typename = 'query_root'});

  factory QueryPartnerFacts.fromJson(Map<String, dynamic> json) {
    final l$partnerFacts = json['partnerFacts'];
    final l$$__typename = json['__typename'];
    return QueryPartnerFacts(
      partnerFacts: (l$partnerFacts as List<dynamic>)
          .map((e) => QueryPartnerFactspartnerFacts.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryPartnerFactspartnerFacts> partnerFacts;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$partnerFacts = partnerFacts;
    _resultData['partnerFacts'] = l$partnerFacts.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$partnerFacts = partnerFacts;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$partnerFacts.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryPartnerFacts || runtimeType != other.runtimeType) {
      return false;
    }
    final l$partnerFacts = partnerFacts;
    final lOther$partnerFacts = other.partnerFacts;
    if (l$partnerFacts.length != lOther$partnerFacts.length) {
      return false;
    }
    for (int i = 0; i < l$partnerFacts.length; i++) {
      final l$partnerFacts$entry = l$partnerFacts[i];
      final lOther$partnerFacts$entry = lOther$partnerFacts[i];
      if (l$partnerFacts$entry != lOther$partnerFacts$entry) {
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

const documentNodeQueryPartnerFacts = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'PartnerFacts'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'partnerFacts'),
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
                  name: NameNode(value: 'label'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'value'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'category'),
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
QueryPartnerFacts _parserFnQueryPartnerFacts(Map<String, dynamic> data) =>
    QueryPartnerFacts.fromJson(data);
typedef OnQueryCompleteQueryPartnerFacts = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryPartnerFacts?,
);

class OptionsQueryPartnerFacts extends graphql.QueryOptions<QueryPartnerFacts> {
  OptionsQueryPartnerFacts({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryPartnerFacts? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryPartnerFacts? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'PartnerFacts',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryPartnerFacts(data)),
         onError: onError,
         document: documentNodeQueryPartnerFacts,
         parserFn: _parserFnQueryPartnerFacts,
       );

  final OnQueryCompleteQueryPartnerFacts? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryPartnerFacts extends graphql.WatchQueryOptions<QueryPartnerFacts> {
  WatchOptionsQueryPartnerFacts({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryPartnerFacts? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'PartnerFacts',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryPartnerFacts,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryPartnerFacts,
       );
}

class FetchMoreOptionsQueryPartnerFacts extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryPartnerFacts({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryPartnerFacts);
}

extension ClientExtensionQueryPartnerFacts on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryPartnerFacts>> queryPartnerFacts([
    OptionsQueryPartnerFacts? options,
  ]) async => await this.query(options ?? OptionsQueryPartnerFacts());

  graphql.ObservableQuery<QueryPartnerFacts> watchQueryPartnerFacts([
    WatchOptionsQueryPartnerFacts? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryPartnerFacts());

  void writeQueryPartnerFacts({required QueryPartnerFacts data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryPartnerFacts)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryPartnerFacts? readQueryPartnerFacts({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryPartnerFacts)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryPartnerFacts.fromJson(result);
  }
}

class QueryPartnerFactspartnerFacts {
  QueryPartnerFactspartnerFacts({
    required this.id,
    required this.label,
    required this.value,
    this.category,
    this.$__typename = 'partnerFacts',
  });

  factory QueryPartnerFactspartnerFacts.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$label = json['label'];
    final l$value = json['value'];
    final l$category = json['category'];
    final l$$__typename = json['__typename'];
    return QueryPartnerFactspartnerFacts(
      id: (l$id as String),
      label: (l$label as String),
      value: (l$value as String),
      category: l$category == null
          ? null
          : fromJsonEnumPartnerFactCategory_enum((l$category as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String label;

  final String value;

  final EnumPartnerFactCategory_enum? category;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$label = label;
    _resultData['label'] = l$label;
    final l$value = value;
    _resultData['value'] = l$value;
    final l$category = category;
    _resultData['category'] = l$category == null
        ? null
        : toJsonEnumPartnerFactCategory_enum(l$category);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$label = label;
    final l$value = value;
    final l$category = category;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$label, l$value, l$category, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryPartnerFactspartnerFacts || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$label = label;
    final lOther$label = other.label;
    if (l$label != lOther$label) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
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
