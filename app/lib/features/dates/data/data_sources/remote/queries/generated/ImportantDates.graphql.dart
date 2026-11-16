// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryImportantDates {
  QueryImportantDates({required this.importantDates, this.$__typename = 'query_root'});

  factory QueryImportantDates.fromJson(Map<String, dynamic> json) {
    final l$importantDates = json['importantDates'];
    final l$$__typename = json['__typename'];
    return QueryImportantDates(
      importantDates: (l$importantDates as List<dynamic>)
          .map((e) => QueryImportantDatesimportantDates.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryImportantDatesimportantDates> importantDates;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$importantDates = importantDates;
    _resultData['importantDates'] = l$importantDates.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$importantDates = importantDates;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$importantDates.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryImportantDates || runtimeType != other.runtimeType) {
      return false;
    }
    final l$importantDates = importantDates;
    final lOther$importantDates = other.importantDates;
    if (l$importantDates.length != lOther$importantDates.length) {
      return false;
    }
    for (int i = 0; i < l$importantDates.length; i++) {
      final l$importantDates$entry = l$importantDates[i];
      final lOther$importantDates$entry = lOther$importantDates[i];
      if (l$importantDates$entry != lOther$importantDates$entry) {
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

const documentNodeQueryImportantDates = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'ImportantDates'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'importantDates'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'hidden'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: BooleanValueNode(value: false),
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
                          name: NameNode(value: 'month'),
                          value: EnumValueNode(name: NameNode(value: 'asc_nulls_last')),
                        ),
                      ],
                    ),
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'day'),
                          value: EnumValueNode(name: NameNode(value: 'asc_nulls_last')),
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
                  name: NameNode(value: 'kind'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'month'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'day'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'year'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'yearly'),
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
QueryImportantDates _parserFnQueryImportantDates(Map<String, dynamic> data) =>
    QueryImportantDates.fromJson(data);
typedef OnQueryCompleteQueryImportantDates = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryImportantDates?,
);

class OptionsQueryImportantDates extends graphql.QueryOptions<QueryImportantDates> {
  OptionsQueryImportantDates({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryImportantDates? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryImportantDates? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'ImportantDates',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryImportantDates(data)),
         onError: onError,
         document: documentNodeQueryImportantDates,
         parserFn: _parserFnQueryImportantDates,
       );

  final OnQueryCompleteQueryImportantDates? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryImportantDates extends graphql.WatchQueryOptions<QueryImportantDates> {
  WatchOptionsQueryImportantDates({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryImportantDates? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'ImportantDates',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryImportantDates,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryImportantDates,
       );
}

class FetchMoreOptionsQueryImportantDates extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryImportantDates({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryImportantDates);
}

extension ClientExtensionQueryImportantDates on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryImportantDates>> queryImportantDates([
    OptionsQueryImportantDates? options,
  ]) async => await this.query(options ?? OptionsQueryImportantDates());

  graphql.ObservableQuery<QueryImportantDates> watchQueryImportantDates([
    WatchOptionsQueryImportantDates? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryImportantDates());

  void writeQueryImportantDates({required QueryImportantDates data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryImportantDates)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryImportantDates? readQueryImportantDates({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryImportantDates)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryImportantDates.fromJson(result);
  }
}

class QueryImportantDatesimportantDates {
  QueryImportantDatesimportantDates({
    required this.id,
    required this.title,
    required this.kind,
    required this.month,
    required this.day,
    this.year,
    required this.yearly,
    this.$__typename = 'importantDates',
  });

  factory QueryImportantDatesimportantDates.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$kind = json['kind'];
    final l$month = json['month'];
    final l$day = json['day'];
    final l$year = json['year'];
    final l$yearly = json['yearly'];
    final l$$__typename = json['__typename'];
    return QueryImportantDatesimportantDates(
      id: (l$id as String),
      title: (l$title as String),
      kind: fromJsonEnumImportantDateKind_enum((l$kind as String)),
      month: (l$month as int),
      day: (l$day as int),
      year: (l$year as int?),
      yearly: (l$yearly as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final EnumImportantDateKind_enum kind;

  final int month;

  final int day;

  final int? year;

  final bool yearly;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumImportantDateKind_enum(l$kind);
    final l$month = month;
    _resultData['month'] = l$month;
    final l$day = day;
    _resultData['day'] = l$day;
    final l$year = year;
    _resultData['year'] = l$year;
    final l$yearly = yearly;
    _resultData['yearly'] = l$yearly;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$kind = kind;
    final l$month = month;
    final l$day = day;
    final l$year = year;
    final l$yearly = yearly;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$title, l$kind, l$month, l$day, l$year, l$yearly, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryImportantDatesimportantDates || runtimeType != other.runtimeType) {
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
    final l$month = month;
    final lOther$month = other.month;
    if (l$month != lOther$month) {
      return false;
    }
    final l$day = day;
    final lOther$day = other.day;
    if (l$day != lOther$day) {
      return false;
    }
    final l$year = year;
    final lOther$year = other.year;
    if (l$year != lOther$year) {
      return false;
    }
    final l$yearly = yearly;
    final lOther$yearly = other.yearly;
    if (l$yearly != lOther$yearly) {
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
