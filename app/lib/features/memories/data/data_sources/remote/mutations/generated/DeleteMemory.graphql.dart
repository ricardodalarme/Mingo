// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteMemory {
  factory VariablesMutationDeleteMemory({required String id}) =>
      VariablesMutationDeleteMemory._({r'id': id});

  VariablesMutationDeleteMemory._(this._$data);

  factory VariablesMutationDeleteMemory.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteMemory._(result$data);
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
    if (other is! VariablesMutationDeleteMemory || runtimeType != other.runtimeType) {
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

class MutationDeleteMemory {
  MutationDeleteMemory({this.deleteMemories, this.$__typename = 'mutation_root'});

  factory MutationDeleteMemory.fromJson(Map<String, dynamic> json) {
    final l$deleteMemories = json['deleteMemories'];
    final l$$__typename = json['__typename'];
    return MutationDeleteMemory(
      deleteMemories: l$deleteMemories == null
          ? null
          : MutationDeleteMemorydeleteMemories.fromJson((l$deleteMemories as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteMemorydeleteMemories? deleteMemories;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteMemories = deleteMemories;
    _resultData['deleteMemories'] = l$deleteMemories?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteMemories = deleteMemories;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteMemories, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteMemory || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteMemories = deleteMemories;
    final lOther$deleteMemories = other.deleteMemories;
    if (l$deleteMemories != lOther$deleteMemories) {
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

const documentNodeMutationDeleteMemory = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteMemory'),
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
            name: NameNode(value: 'deleteMemories'),
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
MutationDeleteMemory _parserFnMutationDeleteMemory(Map<String, dynamic> data) =>
    MutationDeleteMemory.fromJson(data);
typedef OnMutationCompletedMutationDeleteMemory = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteMemory?,
);

class OptionsMutationDeleteMemory extends graphql.MutationOptions<MutationDeleteMemory> {
  OptionsMutationDeleteMemory({
    String? operationName,
    required VariablesMutationDeleteMemory variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteMemory? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteMemory? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteMemory>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteMemory',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationDeleteMemory(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteMemory,
         parserFn: _parserFnMutationDeleteMemory,
       );

  final OnMutationCompletedMutationDeleteMemory? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteMemory extends graphql.WatchQueryOptions<MutationDeleteMemory> {
  WatchOptionsMutationDeleteMemory({
    String? operationName,
    required VariablesMutationDeleteMemory variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteMemory? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteMemory',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteMemory,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteMemory,
       );
}

extension ClientExtensionMutationDeleteMemory on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteMemory>> mutateDeleteMemory(
    OptionsMutationDeleteMemory options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteMemory> watchMutationDeleteMemory(
    WatchOptionsMutationDeleteMemory options,
  ) => this.watchMutation(options);
}

class MutationDeleteMemorydeleteMemories {
  MutationDeleteMemorydeleteMemories({
    required this.affected_rows,
    this.$__typename = 'memories_mutation_response',
  });

  factory MutationDeleteMemorydeleteMemories.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationDeleteMemorydeleteMemories(
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
    if (other is! MutationDeleteMemorydeleteMemories || runtimeType != other.runtimeType) {
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
