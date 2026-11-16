// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteLearning {
  factory VariablesMutationDeleteLearning({required String id}) =>
      VariablesMutationDeleteLearning._({r'id': id});

  VariablesMutationDeleteLearning._(this._$data);

  factory VariablesMutationDeleteLearning.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteLearning._(result$data);
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
    if (other is! VariablesMutationDeleteLearning || runtimeType != other.runtimeType) {
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

class MutationDeleteLearning {
  MutationDeleteLearning({this.deleteRepairLearnings, this.$__typename = 'mutation_root'});

  factory MutationDeleteLearning.fromJson(Map<String, dynamic> json) {
    final l$deleteRepairLearnings = json['deleteRepairLearnings'];
    final l$$__typename = json['__typename'];
    return MutationDeleteLearning(
      deleteRepairLearnings: l$deleteRepairLearnings == null
          ? null
          : MutationDeleteLearningdeleteRepairLearnings.fromJson(
              (l$deleteRepairLearnings as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteLearningdeleteRepairLearnings? deleteRepairLearnings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteRepairLearnings = deleteRepairLearnings;
    _resultData['deleteRepairLearnings'] = l$deleteRepairLearnings?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteRepairLearnings = deleteRepairLearnings;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteRepairLearnings, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteLearning || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteRepairLearnings = deleteRepairLearnings;
    final lOther$deleteRepairLearnings = other.deleteRepairLearnings;
    if (l$deleteRepairLearnings != lOther$deleteRepairLearnings) {
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

const documentNodeMutationDeleteLearning = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteLearning'),
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
            name: NameNode(value: 'deleteRepairLearnings'),
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
MutationDeleteLearning _parserFnMutationDeleteLearning(Map<String, dynamic> data) =>
    MutationDeleteLearning.fromJson(data);
typedef OnMutationCompletedMutationDeleteLearning = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteLearning?,
);

class OptionsMutationDeleteLearning extends graphql.MutationOptions<MutationDeleteLearning> {
  OptionsMutationDeleteLearning({
    String? operationName,
    required VariablesMutationDeleteLearning variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteLearning? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteLearning? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteLearning>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteLearning',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationDeleteLearning(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteLearning,
         parserFn: _parserFnMutationDeleteLearning,
       );

  final OnMutationCompletedMutationDeleteLearning? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteLearning extends graphql.WatchQueryOptions<MutationDeleteLearning> {
  WatchOptionsMutationDeleteLearning({
    String? operationName,
    required VariablesMutationDeleteLearning variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteLearning? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteLearning',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteLearning,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteLearning,
       );
}

extension ClientExtensionMutationDeleteLearning on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteLearning>> mutateDeleteLearning(
    OptionsMutationDeleteLearning options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteLearning> watchMutationDeleteLearning(
    WatchOptionsMutationDeleteLearning options,
  ) => this.watchMutation(options);
}

class MutationDeleteLearningdeleteRepairLearnings {
  MutationDeleteLearningdeleteRepairLearnings({
    required this.affected_rows,
    this.$__typename = 'repairLearnings_mutation_response',
  });

  factory MutationDeleteLearningdeleteRepairLearnings.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationDeleteLearningdeleteRepairLearnings(
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
    if (other is! MutationDeleteLearningdeleteRepairLearnings || runtimeType != other.runtimeType) {
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
