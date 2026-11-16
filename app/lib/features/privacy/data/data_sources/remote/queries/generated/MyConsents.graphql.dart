// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryMyConsents {
  QueryMyConsents({required this.consents, this.$__typename = 'query_root'});

  factory QueryMyConsents.fromJson(Map<String, dynamic> json) {
    final l$consents = json['consents'];
    final l$$__typename = json['__typename'];
    return QueryMyConsents(
      consents: (l$consents as List<dynamic>)
          .map((e) => QueryMyConsentsconsents.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMyConsentsconsents> consents;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$consents = consents;
    _resultData['consents'] = l$consents.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$consents = consents;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$consents.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyConsents || runtimeType != other.runtimeType) {
      return false;
    }
    final l$consents = consents;
    final lOther$consents = other.consents;
    if (l$consents.length != lOther$consents.length) {
      return false;
    }
    for (int i = 0; i < l$consents.length; i++) {
      final l$consents$entry = l$consents[i];
      final lOther$consents$entry = lOther$consents[i];
      if (l$consents$entry != lOther$consents$entry) {
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

const documentNodeQueryMyConsents = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyConsents'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'consents'),
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
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'kind'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'granted'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'version'),
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
QueryMyConsents _parserFnQueryMyConsents(Map<String, dynamic> data) =>
    QueryMyConsents.fromJson(data);
typedef OnQueryCompleteQueryMyConsents = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyConsents?,
);

class OptionsQueryMyConsents extends graphql.QueryOptions<QueryMyConsents> {
  OptionsQueryMyConsents({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyConsents? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyConsents? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'MyConsents',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyConsents(data)),
         onError: onError,
         document: documentNodeQueryMyConsents,
         parserFn: _parserFnQueryMyConsents,
       );

  final OnQueryCompleteQueryMyConsents? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyConsents extends graphql.WatchQueryOptions<QueryMyConsents> {
  WatchOptionsQueryMyConsents({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyConsents? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'MyConsents',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyConsents,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyConsents,
       );
}

class FetchMoreOptionsQueryMyConsents extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyConsents({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryMyConsents);
}

extension ClientExtensionQueryMyConsents on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyConsents>> queryMyConsents([
    OptionsQueryMyConsents? options,
  ]) async => await this.query(options ?? OptionsQueryMyConsents());

  graphql.ObservableQuery<QueryMyConsents> watchQueryMyConsents([
    WatchOptionsQueryMyConsents? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryMyConsents());

  void writeQueryMyConsents({required QueryMyConsents data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryMyConsents)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryMyConsents? readQueryMyConsents({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryMyConsents)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyConsents.fromJson(result);
  }
}

class QueryMyConsentsconsents {
  QueryMyConsentsconsents({
    required this.kind,
    required this.granted,
    required this.version,
    required this.createdAt,
    this.$__typename = 'consents',
  });

  factory QueryMyConsentsconsents.fromJson(Map<String, dynamic> json) {
    final l$kind = json['kind'];
    final l$granted = json['granted'];
    final l$version = json['version'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return QueryMyConsentsconsents(
      kind: fromJsonEnumConsentKind_enum((l$kind as String)),
      granted: (l$granted as bool),
      version: (l$version as String),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumConsentKind_enum kind;

  final bool granted;

  final String version;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumConsentKind_enum(l$kind);
    final l$granted = granted;
    _resultData['granted'] = l$granted;
    final l$version = version;
    _resultData['version'] = l$version;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$kind = kind;
    final l$granted = granted;
    final l$version = version;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$kind, l$granted, l$version, l$createdAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyConsentsconsents || runtimeType != other.runtimeType) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$granted = granted;
    final lOther$granted = other.granted;
    if (l$granted != lOther$granted) {
      return false;
    }
    final l$version = version;
    final lOther$version = other.version;
    if (l$version != lOther$version) {
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
