// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationInsertJournalEntry {
  factory VariablesMutationInsertJournalEntry({
    required DateTime entryDate,
    required String body,
    String? mood,
  }) => VariablesMutationInsertJournalEntry._({
    r'entryDate': entryDate,
    r'body': body,
    if (mood != null) r'mood': mood,
  });

  VariablesMutationInsertJournalEntry._(this._$data);

  factory VariablesMutationInsertJournalEntry.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$entryDate = data['entryDate'];
    result$data['entryDate'] = DateTime.parse((l$entryDate as String));
    final l$body = data['body'];
    result$data['body'] = (l$body as String);
    if (data.containsKey('mood')) {
      final l$mood = data['mood'];
      result$data['mood'] = (l$mood as String?);
    }
    return VariablesMutationInsertJournalEntry._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime get entryDate => (_$data['entryDate'] as DateTime);

  String get body => (_$data['body'] as String);

  String? get mood => (_$data['mood'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$entryDate = entryDate;
    result$data['entryDate'] = ((v) => v.toIso8601String().substring(0, 10))(l$entryDate);
    final l$body = body;
    result$data['body'] = l$body;
    if (_$data.containsKey('mood')) {
      final l$mood = mood;
      result$data['mood'] = l$mood;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationInsertJournalEntry || runtimeType != other.runtimeType) {
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
    if (_$data.containsKey('mood') != other._$data.containsKey('mood')) {
      return false;
    }
    if (l$mood != lOther$mood) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$entryDate = entryDate;
    final l$body = body;
    final l$mood = mood;
    return Object.hashAll([l$entryDate, l$body, _$data.containsKey('mood') ? l$mood : const {}]);
  }
}

class MutationInsertJournalEntry {
  MutationInsertJournalEntry({this.insertJournalEntriesOne, this.$__typename = 'mutation_root'});

  factory MutationInsertJournalEntry.fromJson(Map<String, dynamic> json) {
    final l$insertJournalEntriesOne = json['insertJournalEntriesOne'];
    final l$$__typename = json['__typename'];
    return MutationInsertJournalEntry(
      insertJournalEntriesOne: l$insertJournalEntriesOne == null
          ? null
          : MutationInsertJournalEntryinsertJournalEntriesOne.fromJson(
              (l$insertJournalEntriesOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationInsertJournalEntryinsertJournalEntriesOne? insertJournalEntriesOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertJournalEntriesOne = insertJournalEntriesOne;
    _resultData['insertJournalEntriesOne'] = l$insertJournalEntriesOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertJournalEntriesOne = insertJournalEntriesOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertJournalEntriesOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertJournalEntry || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertJournalEntriesOne = insertJournalEntriesOne;
    final lOther$insertJournalEntriesOne = other.insertJournalEntriesOne;
    if (l$insertJournalEntriesOne != lOther$insertJournalEntriesOne) {
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

const documentNodeMutationInsertJournalEntry = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InsertJournalEntry'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'entryDate')),
          type: NamedTypeNode(name: NameNode(value: 'date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'body')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'mood')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertJournalEntriesOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'entryDate'),
                      value: VariableNode(name: NameNode(value: 'entryDate')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'body'),
                      value: VariableNode(name: NameNode(value: 'body')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'mood'),
                      value: VariableNode(name: NameNode(value: 'mood')),
                    ),
                  ],
                ),
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
MutationInsertJournalEntry _parserFnMutationInsertJournalEntry(Map<String, dynamic> data) =>
    MutationInsertJournalEntry.fromJson(data);
typedef OnMutationCompletedMutationInsertJournalEntry = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationInsertJournalEntry?,
);

class OptionsMutationInsertJournalEntry
    extends graphql.MutationOptions<MutationInsertJournalEntry> {
  OptionsMutationInsertJournalEntry({
    String? operationName,
    required VariablesMutationInsertJournalEntry variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertJournalEntry? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationInsertJournalEntry? onCompleted,
    graphql.OnMutationUpdate<MutationInsertJournalEntry>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertJournalEntry',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationInsertJournalEntry(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationInsertJournalEntry,
         parserFn: _parserFnMutationInsertJournalEntry,
       );

  final OnMutationCompletedMutationInsertJournalEntry? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationInsertJournalEntry
    extends graphql.WatchQueryOptions<MutationInsertJournalEntry> {
  WatchOptionsMutationInsertJournalEntry({
    String? operationName,
    required VariablesMutationInsertJournalEntry variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertJournalEntry? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertJournalEntry',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationInsertJournalEntry,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationInsertJournalEntry,
       );
}

extension ClientExtensionMutationInsertJournalEntry on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationInsertJournalEntry>> mutateInsertJournalEntry(
    OptionsMutationInsertJournalEntry options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationInsertJournalEntry> watchMutationInsertJournalEntry(
    WatchOptionsMutationInsertJournalEntry options,
  ) => this.watchMutation(options);
}

class MutationInsertJournalEntryinsertJournalEntriesOne {
  MutationInsertJournalEntryinsertJournalEntriesOne({
    required this.id,
    required this.entryDate,
    required this.body,
    this.mood,
    this.$__typename = 'journalEntries',
  });

  factory MutationInsertJournalEntryinsertJournalEntriesOne.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$entryDate = json['entryDate'];
    final l$body = json['body'];
    final l$mood = json['mood'];
    final l$$__typename = json['__typename'];
    return MutationInsertJournalEntryinsertJournalEntriesOne(
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
    if (other is! MutationInsertJournalEntryinsertJournalEntriesOne ||
        runtimeType != other.runtimeType) {
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
