// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryLoveStyleManualEntry {
  factory VariablesQueryLoveStyleManualEntry({required String authorId}) =>
      VariablesQueryLoveStyleManualEntry._({r'authorId': authorId});

  VariablesQueryLoveStyleManualEntry._(this._$data);

  factory VariablesQueryLoveStyleManualEntry.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$authorId = data['authorId'];
    result$data['authorId'] = (l$authorId as String);
    return VariablesQueryLoveStyleManualEntry._(result$data);
  }

  Map<String, dynamic> _$data;

  String get authorId => (_$data['authorId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$authorId = authorId;
    result$data['authorId'] = l$authorId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryLoveStyleManualEntry || runtimeType != other.runtimeType) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$authorId = authorId;
    return Object.hashAll([l$authorId]);
  }
}

class QueryLoveStyleManualEntry {
  QueryLoveStyleManualEntry({required this.manualEntries, this.$__typename = 'query_root'});

  factory QueryLoveStyleManualEntry.fromJson(Map<String, dynamic> json) {
    final l$manualEntries = json['manualEntries'];
    final l$$__typename = json['__typename'];
    return QueryLoveStyleManualEntry(
      manualEntries: (l$manualEntries as List<dynamic>)
          .map((e) => QueryLoveStyleManualEntrymanualEntries.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryLoveStyleManualEntrymanualEntries> manualEntries;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$manualEntries = manualEntries;
    _resultData['manualEntries'] = l$manualEntries.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$manualEntries = manualEntries;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$manualEntries.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLoveStyleManualEntry || runtimeType != other.runtimeType) {
      return false;
    }
    final l$manualEntries = manualEntries;
    final lOther$manualEntries = other.manualEntries;
    if (l$manualEntries.length != lOther$manualEntries.length) {
      return false;
    }
    for (int i = 0; i < l$manualEntries.length; i++) {
      final l$manualEntries$entry = l$manualEntries[i];
      final lOther$manualEntries$entry = lOther$manualEntries[i];
      if (l$manualEntries$entry != lOther$manualEntries$entry) {
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

const documentNodeQueryLoveStyleManualEntry = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'LoveStyleManualEntry'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'authorId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'manualEntries'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'key'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: StringValueNode(value: 'loved', isBlock: false),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'authorId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'authorId')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '1'),
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
                  name: NameNode(value: 'value'),
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
QueryLoveStyleManualEntry _parserFnQueryLoveStyleManualEntry(Map<String, dynamic> data) =>
    QueryLoveStyleManualEntry.fromJson(data);
typedef OnQueryCompleteQueryLoveStyleManualEntry = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryLoveStyleManualEntry?,
);

class OptionsQueryLoveStyleManualEntry extends graphql.QueryOptions<QueryLoveStyleManualEntry> {
  OptionsQueryLoveStyleManualEntry({
    String? operationName,
    required VariablesQueryLoveStyleManualEntry variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLoveStyleManualEntry? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryLoveStyleManualEntry? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'LoveStyleManualEntry',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryLoveStyleManualEntry(data)),
         onError: onError,
         document: documentNodeQueryLoveStyleManualEntry,
         parserFn: _parserFnQueryLoveStyleManualEntry,
       );

  final OnQueryCompleteQueryLoveStyleManualEntry? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryLoveStyleManualEntry
    extends graphql.WatchQueryOptions<QueryLoveStyleManualEntry> {
  WatchOptionsQueryLoveStyleManualEntry({
    String? operationName,
    required VariablesQueryLoveStyleManualEntry variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryLoveStyleManualEntry? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'LoveStyleManualEntry',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryLoveStyleManualEntry,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryLoveStyleManualEntry,
       );
}

class FetchMoreOptionsQueryLoveStyleManualEntry extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryLoveStyleManualEntry({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryLoveStyleManualEntry variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryLoveStyleManualEntry,
       );
}

extension ClientExtensionQueryLoveStyleManualEntry on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryLoveStyleManualEntry>> queryLoveStyleManualEntry(
    OptionsQueryLoveStyleManualEntry options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryLoveStyleManualEntry> watchQueryLoveStyleManualEntry(
    WatchOptionsQueryLoveStyleManualEntry options,
  ) => this.watchQuery(options);

  void writeQueryLoveStyleManualEntry({
    required QueryLoveStyleManualEntry data,
    required VariablesQueryLoveStyleManualEntry variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryLoveStyleManualEntry),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryLoveStyleManualEntry? readQueryLoveStyleManualEntry({
    required VariablesQueryLoveStyleManualEntry variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryLoveStyleManualEntry),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryLoveStyleManualEntry.fromJson(result);
  }
}

class QueryLoveStyleManualEntrymanualEntries {
  QueryLoveStyleManualEntrymanualEntries({
    required this.id,
    required this.value,
    this.$__typename = 'manualEntries',
  });

  factory QueryLoveStyleManualEntrymanualEntries.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return QueryLoveStyleManualEntrymanualEntries(
      id: (l$id as String),
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryLoveStyleManualEntrymanualEntries || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
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
