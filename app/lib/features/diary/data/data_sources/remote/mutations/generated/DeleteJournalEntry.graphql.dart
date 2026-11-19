// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteJournalEntry {
  factory VariablesMutationDeleteJournalEntry({required String id}) =>
      VariablesMutationDeleteJournalEntry._({r'id': id});

  VariablesMutationDeleteJournalEntry._(this._$data);

  factory VariablesMutationDeleteJournalEntry.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteJournalEntry._(result$data);
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
    if (other is! VariablesMutationDeleteJournalEntry || runtimeType != other.runtimeType) {
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

class MutationDeleteJournalEntry {
  MutationDeleteJournalEntry({this.deleteJournalEntries, this.$__typename = 'mutation_root'});

  factory MutationDeleteJournalEntry.fromJson(Map<String, dynamic> json) {
    final l$deleteJournalEntries = json['deleteJournalEntries'];
    final l$$__typename = json['__typename'];
    return MutationDeleteJournalEntry(
      deleteJournalEntries: l$deleteJournalEntries == null
          ? null
          : MutationDeleteJournalEntrydeleteJournalEntries.fromJson(
              (l$deleteJournalEntries as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteJournalEntrydeleteJournalEntries? deleteJournalEntries;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteJournalEntries = deleteJournalEntries;
    _resultData['deleteJournalEntries'] = l$deleteJournalEntries?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteJournalEntries = deleteJournalEntries;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteJournalEntries, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteJournalEntry || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteJournalEntries = deleteJournalEntries;
    final lOther$deleteJournalEntries = other.deleteJournalEntries;
    if (l$deleteJournalEntries != lOther$deleteJournalEntries) {
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

const documentNodeMutationDeleteJournalEntry = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteJournalEntry'),
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
            name: NameNode(value: 'deleteJournalEntries'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'id')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'affected_rows'),
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
MutationDeleteJournalEntry _parserFnMutationDeleteJournalEntry(Map<String, dynamic> data) =>
    MutationDeleteJournalEntry.fromJson(data);
typedef OnMutationCompletedMutationDeleteJournalEntry = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteJournalEntry?,
);

class OptionsMutationDeleteJournalEntry
    extends graphql.MutationOptions<MutationDeleteJournalEntry> {
  OptionsMutationDeleteJournalEntry({
    String? operationName,
    required VariablesMutationDeleteJournalEntry variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteJournalEntry? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteJournalEntry? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteJournalEntry>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteJournalEntry',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationDeleteJournalEntry(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteJournalEntry,
         parserFn: _parserFnMutationDeleteJournalEntry,
       );

  final OnMutationCompletedMutationDeleteJournalEntry? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteJournalEntry
    extends graphql.WatchQueryOptions<MutationDeleteJournalEntry> {
  WatchOptionsMutationDeleteJournalEntry({
    String? operationName,
    required VariablesMutationDeleteJournalEntry variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteJournalEntry? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteJournalEntry',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteJournalEntry,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteJournalEntry,
       );
}

extension ClientExtensionMutationDeleteJournalEntry on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteJournalEntry>> mutateDeleteJournalEntry(
    OptionsMutationDeleteJournalEntry options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteJournalEntry> watchMutationDeleteJournalEntry(
    WatchOptionsMutationDeleteJournalEntry options,
  ) => this.watchMutation(options);
}

class MutationDeleteJournalEntrydeleteJournalEntries {
  MutationDeleteJournalEntrydeleteJournalEntries({
    required this.affected_rows,
    this.$__typename = 'journalEntries_mutation_response',
  });

  factory MutationDeleteJournalEntrydeleteJournalEntries.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationDeleteJournalEntrydeleteJournalEntries(
      affected_rows: (l$affected_rows as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int affected_rows;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$affected_rows = affected_rows;
    _resultData['affected_rows'] = l$affected_rows;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$affected_rows = affected_rows;
    final l$$__typename = $__typename;
    return Object.hashAll([l$affected_rows, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteJournalEntrydeleteJournalEntries ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$affected_rows = affected_rows;
    final lOther$affected_rows = other.affected_rows;
    if (l$affected_rows != lOther$affected_rows) {
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
