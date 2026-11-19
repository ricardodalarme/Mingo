// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryJournalEntries {
  QueryJournalEntries({required this.journalEntries, this.$__typename = 'query_root'});

  factory QueryJournalEntries.fromJson(Map<String, dynamic> json) {
    final l$journalEntries = json['journalEntries'];
    final l$$__typename = json['__typename'];
    return QueryJournalEntries(
      journalEntries: (l$journalEntries as List<dynamic>)
          .map((e) => QueryJournalEntriesjournalEntries.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryJournalEntriesjournalEntries> journalEntries;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$journalEntries = journalEntries;
    _resultData['journalEntries'] = l$journalEntries.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$journalEntries = journalEntries;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$journalEntries.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryJournalEntries || runtimeType != other.runtimeType) {
      return false;
    }
    final l$journalEntries = journalEntries;
    final lOther$journalEntries = other.journalEntries;
    if (l$journalEntries.length != lOther$journalEntries.length) {
      return false;
    }
    for (int i = 0; i < l$journalEntries.length; i++) {
      final l$journalEntries$entry = l$journalEntries[i];
      final lOther$journalEntries$entry = lOther$journalEntries[i];
      if (l$journalEntries$entry != lOther$journalEntries$entry) {
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

const documentNodeQueryJournalEntries = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'JournalEntries'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'journalEntries'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'entryDate'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
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
                value: IntValueNode(value: '100'),
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
                  name: NameNode(value: 'entryDate'),
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
                  name: NameNode(value: 'mood'),
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
QueryJournalEntries _parserFnQueryJournalEntries(Map<String, dynamic> data) =>
    QueryJournalEntries.fromJson(data);
typedef OnQueryCompleteQueryJournalEntries = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryJournalEntries?,
);

class OptionsQueryJournalEntries extends graphql.QueryOptions<QueryJournalEntries> {
  OptionsQueryJournalEntries({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryJournalEntries? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryJournalEntries? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'JournalEntries',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryJournalEntries(data)),
         onError: onError,
         document: documentNodeQueryJournalEntries,
         parserFn: _parserFnQueryJournalEntries,
       );

  final OnQueryCompleteQueryJournalEntries? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryJournalEntries extends graphql.WatchQueryOptions<QueryJournalEntries> {
  WatchOptionsQueryJournalEntries({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryJournalEntries? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'JournalEntries',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryJournalEntries,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryJournalEntries,
       );
}

class FetchMoreOptionsQueryJournalEntries extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryJournalEntries({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryJournalEntries);
}

extension ClientExtensionQueryJournalEntries on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryJournalEntries>> queryJournalEntries([
    OptionsQueryJournalEntries? options,
  ]) async => await this.query(options ?? OptionsQueryJournalEntries());

  graphql.ObservableQuery<QueryJournalEntries> watchQueryJournalEntries([
    WatchOptionsQueryJournalEntries? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryJournalEntries());

  void writeQueryJournalEntries({required QueryJournalEntries data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryJournalEntries)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryJournalEntries? readQueryJournalEntries({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryJournalEntries)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryJournalEntries.fromJson(result);
  }
}

class QueryJournalEntriesjournalEntries {
  QueryJournalEntriesjournalEntries({
    required this.id,
    required this.entryDate,
    required this.body,
    this.mood,
    this.$__typename = 'journalEntries',
  });

  factory QueryJournalEntriesjournalEntries.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$entryDate = json['entryDate'];
    final l$body = json['body'];
    final l$mood = json['mood'];
    final l$$__typename = json['__typename'];
    return QueryJournalEntriesjournalEntries(
      id: (l$id as String),
      entryDate: DateTime.parse((l$entryDate as String)),
      body: (l$body as String),
      mood: (l$mood as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime entryDate;

  final String body;

  final String? mood;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$entryDate = entryDate;
    _resultData['entryDate'] = ((v) => v.toIso8601String().substring(0, 10))(l$entryDate);
    final l$body = body;
    _resultData['body'] = l$body;
    final l$mood = mood;
    _resultData['mood'] = l$mood;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$entryDate = entryDate;
    final l$body = body;
    final l$mood = mood;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$entryDate, l$body, l$mood, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryJournalEntriesjournalEntries || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$entryDate = entryDate;
    final lOther$entryDate = other.entryDate;
    if (l$entryDate != lOther$entryDate) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$mood = mood;
    final lOther$mood = other.mood;
    if (l$mood != lOther$mood) {
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
