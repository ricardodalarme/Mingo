// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateLoveStyleManualEntry {
  factory VariablesMutationUpdateLoveStyleManualEntry({
    required String id,
    required String value,
  }) => VariablesMutationUpdateLoveStyleManualEntry._({r'id': id, r'value': value});

  VariablesMutationUpdateLoveStyleManualEntry._(this._$data);

  factory VariablesMutationUpdateLoveStyleManualEntry.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$value = data['value'];
    result$data['value'] = (l$value as String);
    return VariablesMutationUpdateLoveStyleManualEntry._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String get value => (_$data['value'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$value = value;
    result$data['value'] = l$value;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateLoveStyleManualEntry || runtimeType != other.runtimeType) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$value = value;
    return Object.hashAll([l$id, l$value]);
  }
}

class MutationUpdateLoveStyleManualEntry {
  MutationUpdateLoveStyleManualEntry({
    this.updateManualEntries,
    this.$__typename = 'mutation_root',
  });

  factory MutationUpdateLoveStyleManualEntry.fromJson(Map<String, dynamic> json) {
    final l$updateManualEntries = json['updateManualEntries'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLoveStyleManualEntry(
      updateManualEntries: l$updateManualEntries == null
          ? null
          : MutationUpdateLoveStyleManualEntryupdateManualEntries.fromJson(
              (l$updateManualEntries as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateLoveStyleManualEntryupdateManualEntries? updateManualEntries;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateManualEntries = updateManualEntries;
    _resultData['updateManualEntries'] = l$updateManualEntries?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateManualEntries = updateManualEntries;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateManualEntries, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateLoveStyleManualEntry || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateManualEntries = updateManualEntries;
    final lOther$updateManualEntries = other.updateManualEntries;
    if (l$updateManualEntries != lOther$updateManualEntries) {
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

const documentNodeMutationUpdateLoveStyleManualEntry = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateLoveStyleManualEntry'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'value')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateManualEntries'),
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
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'value'),
                      value: VariableNode(name: NameNode(value: 'value')),
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
MutationUpdateLoveStyleManualEntry _parserFnMutationUpdateLoveStyleManualEntry(
  Map<String, dynamic> data,
) => MutationUpdateLoveStyleManualEntry.fromJson(data);
typedef OnMutationCompletedMutationUpdateLoveStyleManualEntry = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateLoveStyleManualEntry?,
);

class OptionsMutationUpdateLoveStyleManualEntry
    extends graphql.MutationOptions<MutationUpdateLoveStyleManualEntry> {
  OptionsMutationUpdateLoveStyleManualEntry({
    String? operationName,
    required VariablesMutationUpdateLoveStyleManualEntry variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLoveStyleManualEntry? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateLoveStyleManualEntry? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateLoveStyleManualEntry>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLoveStyleManualEntry',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateLoveStyleManualEntry(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateLoveStyleManualEntry,
         parserFn: _parserFnMutationUpdateLoveStyleManualEntry,
       );

  final OnMutationCompletedMutationUpdateLoveStyleManualEntry? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateLoveStyleManualEntry
    extends graphql.WatchQueryOptions<MutationUpdateLoveStyleManualEntry> {
  WatchOptionsMutationUpdateLoveStyleManualEntry({
    String? operationName,
    required VariablesMutationUpdateLoveStyleManualEntry variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLoveStyleManualEntry? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLoveStyleManualEntry',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateLoveStyleManualEntry,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateLoveStyleManualEntry,
       );
}

extension ClientExtensionMutationUpdateLoveStyleManualEntry on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateLoveStyleManualEntry>> mutateUpdateLoveStyleManualEntry(
    OptionsMutationUpdateLoveStyleManualEntry options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateLoveStyleManualEntry>
  watchMutationUpdateLoveStyleManualEntry(WatchOptionsMutationUpdateLoveStyleManualEntry options) =>
      this.watchMutation(options);
}

class MutationUpdateLoveStyleManualEntryupdateManualEntries {
  MutationUpdateLoveStyleManualEntryupdateManualEntries({
    required this.affected_rows,
    this.$__typename = 'manualEntries_mutation_response',
  });

  factory MutationUpdateLoveStyleManualEntryupdateManualEntries.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLoveStyleManualEntryupdateManualEntries(
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
    if (other is! MutationUpdateLoveStyleManualEntryupdateManualEntries ||
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
