// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryMyTemperatureChecks {
  QueryMyTemperatureChecks({required this.temperatureChecks, this.$__typename = 'query_root'});

  factory QueryMyTemperatureChecks.fromJson(Map<String, dynamic> json) {
    final l$temperatureChecks = json['temperatureChecks'];
    final l$$__typename = json['__typename'];
    return QueryMyTemperatureChecks(
      temperatureChecks: (l$temperatureChecks as List<dynamic>)
          .map(
            (e) => QueryMyTemperatureCheckstemperatureChecks.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMyTemperatureCheckstemperatureChecks> temperatureChecks;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$temperatureChecks = temperatureChecks;
    _resultData['temperatureChecks'] = l$temperatureChecks.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$temperatureChecks = temperatureChecks;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$temperatureChecks.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyTemperatureChecks || runtimeType != other.runtimeType) {
      return false;
    }
    final l$temperatureChecks = temperatureChecks;
    final lOther$temperatureChecks = other.temperatureChecks;
    if (l$temperatureChecks.length != lOther$temperatureChecks.length) {
      return false;
    }
    for (int i = 0; i < l$temperatureChecks.length; i++) {
      final l$temperatureChecks$entry = l$temperatureChecks[i];
      final lOther$temperatureChecks$entry = lOther$temperatureChecks[i];
      if (l$temperatureChecks$entry != lOther$temperatureChecks$entry) {
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

const documentNodeQueryMyTemperatureChecks = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyTemperatureChecks'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'temperatureChecks'),
            alias: null,
            arguments: [
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
                  name: NameNode(value: 'level'),
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
QueryMyTemperatureChecks _parserFnQueryMyTemperatureChecks(Map<String, dynamic> data) =>
    QueryMyTemperatureChecks.fromJson(data);
typedef OnQueryCompleteQueryMyTemperatureChecks = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyTemperatureChecks?,
);

class OptionsQueryMyTemperatureChecks extends graphql.QueryOptions<QueryMyTemperatureChecks> {
  OptionsQueryMyTemperatureChecks({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyTemperatureChecks? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyTemperatureChecks? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'MyTemperatureChecks',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryMyTemperatureChecks(data)),
         onError: onError,
         document: documentNodeQueryMyTemperatureChecks,
         parserFn: _parserFnQueryMyTemperatureChecks,
       );

  final OnQueryCompleteQueryMyTemperatureChecks? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyTemperatureChecks
    extends graphql.WatchQueryOptions<QueryMyTemperatureChecks> {
  WatchOptionsQueryMyTemperatureChecks({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyTemperatureChecks? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'MyTemperatureChecks',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyTemperatureChecks,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyTemperatureChecks,
       );
}

class FetchMoreOptionsQueryMyTemperatureChecks extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyTemperatureChecks({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryMyTemperatureChecks);
}

extension ClientExtensionQueryMyTemperatureChecks on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyTemperatureChecks>> queryMyTemperatureChecks([
    OptionsQueryMyTemperatureChecks? options,
  ]) async => await this.query(options ?? OptionsQueryMyTemperatureChecks());

  graphql.ObservableQuery<QueryMyTemperatureChecks> watchQueryMyTemperatureChecks([
    WatchOptionsQueryMyTemperatureChecks? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryMyTemperatureChecks());

  void writeQueryMyTemperatureChecks({
    required QueryMyTemperatureChecks data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(operation: graphql.Operation(document: documentNodeQueryMyTemperatureChecks)),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyTemperatureChecks? readQueryMyTemperatureChecks({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryMyTemperatureChecks)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyTemperatureChecks.fromJson(result);
  }
}

class QueryMyTemperatureCheckstemperatureChecks {
  QueryMyTemperatureCheckstemperatureChecks({
    required this.id,
    required this.level,
    required this.createdAt,
    this.$__typename = 'temperatureChecks',
  });

  factory QueryMyTemperatureCheckstemperatureChecks.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$level = json['level'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return QueryMyTemperatureCheckstemperatureChecks(
      id: (l$id as String),
      level: fromJsonEnumTemperatureLevel_enum((l$level as String)),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumTemperatureLevel_enum level;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$level = level;
    _resultData['level'] = toJsonEnumTemperatureLevel_enum(l$level);
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$level = level;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$level, l$createdAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyTemperatureCheckstemperatureChecks || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$level = level;
    final lOther$level = other.level;
    if (l$level != lOther$level) {
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
