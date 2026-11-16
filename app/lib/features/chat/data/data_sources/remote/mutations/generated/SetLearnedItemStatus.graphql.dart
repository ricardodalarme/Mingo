// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSetLearnedItemStatus {
  factory VariablesMutationSetLearnedItemStatus({
    required String id,
    required EnumLearnedItemStatus_enum status,
  }) => VariablesMutationSetLearnedItemStatus._({r'id': id, r'status': status});

  VariablesMutationSetLearnedItemStatus._(this._$data);

  factory VariablesMutationSetLearnedItemStatus.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$status = data['status'];
    result$data['status'] = fromJsonEnumLearnedItemStatus_enum((l$status as String));
    return VariablesMutationSetLearnedItemStatus._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  EnumLearnedItemStatus_enum get status => (_$data['status'] as EnumLearnedItemStatus_enum);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$status = status;
    result$data['status'] = toJsonEnumLearnedItemStatus_enum(l$status);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSetLearnedItemStatus || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$status = status;
    return Object.hashAll([l$id, l$status]);
  }
}

class MutationSetLearnedItemStatus {
  MutationSetLearnedItemStatus({this.updateLearnedItemsByPk, this.$__typename = 'mutation_root'});

  factory MutationSetLearnedItemStatus.fromJson(Map<String, dynamic> json) {
    final l$updateLearnedItemsByPk = json['updateLearnedItemsByPk'];
    final l$$__typename = json['__typename'];
    return MutationSetLearnedItemStatus(
      updateLearnedItemsByPk: l$updateLearnedItemsByPk == null
          ? null
          : MutationSetLearnedItemStatusupdateLearnedItemsByPk.fromJson(
              (l$updateLearnedItemsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSetLearnedItemStatusupdateLearnedItemsByPk? updateLearnedItemsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateLearnedItemsByPk = updateLearnedItemsByPk;
    _resultData['updateLearnedItemsByPk'] = l$updateLearnedItemsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateLearnedItemsByPk = updateLearnedItemsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateLearnedItemsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSetLearnedItemStatus || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateLearnedItemsByPk = updateLearnedItemsByPk;
    final lOther$updateLearnedItemsByPk = other.updateLearnedItemsByPk;
    if (l$updateLearnedItemsByPk != lOther$updateLearnedItemsByPk) {
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

const documentNodeMutationSetLearnedItemStatus = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetLearnedItemStatus'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'status')),
          type: NamedTypeNode(name: NameNode(value: 'LearnedItemStatus_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateLearnedItemsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: VariableNode(name: NameNode(value: 'id')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'status'),
                      value: VariableNode(name: NameNode(value: 'status')),
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
MutationSetLearnedItemStatus _parserFnMutationSetLearnedItemStatus(Map<String, dynamic> data) =>
    MutationSetLearnedItemStatus.fromJson(data);
typedef OnMutationCompletedMutationSetLearnedItemStatus = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSetLearnedItemStatus?,
);

class OptionsMutationSetLearnedItemStatus
    extends graphql.MutationOptions<MutationSetLearnedItemStatus> {
  OptionsMutationSetLearnedItemStatus({
    String? operationName,
    required VariablesMutationSetLearnedItemStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetLearnedItemStatus? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSetLearnedItemStatus? onCompleted,
    graphql.OnMutationUpdate<MutationSetLearnedItemStatus>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetLearnedItemStatus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationSetLearnedItemStatus(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationSetLearnedItemStatus,
         parserFn: _parserFnMutationSetLearnedItemStatus,
       );

  final OnMutationCompletedMutationSetLearnedItemStatus? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSetLearnedItemStatus
    extends graphql.WatchQueryOptions<MutationSetLearnedItemStatus> {
  WatchOptionsMutationSetLearnedItemStatus({
    String? operationName,
    required VariablesMutationSetLearnedItemStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetLearnedItemStatus? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetLearnedItemStatus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSetLearnedItemStatus,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSetLearnedItemStatus,
       );
}

extension ClientExtensionMutationSetLearnedItemStatus on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSetLearnedItemStatus>> mutateSetLearnedItemStatus(
    OptionsMutationSetLearnedItemStatus options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSetLearnedItemStatus> watchMutationSetLearnedItemStatus(
    WatchOptionsMutationSetLearnedItemStatus options,
  ) => this.watchMutation(options);
}

class MutationSetLearnedItemStatusupdateLearnedItemsByPk {
  MutationSetLearnedItemStatusupdateLearnedItemsByPk({
    required this.id,
    this.$__typename = 'learnedItems',
  });

  factory MutationSetLearnedItemStatusupdateLearnedItemsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationSetLearnedItemStatusupdateLearnedItemsByPk(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSetLearnedItemStatusupdateLearnedItemsByPk ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
