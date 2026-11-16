// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationCancelAccountDeletion {
  factory VariablesMutationCancelAccountDeletion({required String userId}) =>
      VariablesMutationCancelAccountDeletion._({r'userId': userId});

  VariablesMutationCancelAccountDeletion._(this._$data);

  factory VariablesMutationCancelAccountDeletion.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesMutationCancelAccountDeletion._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationCancelAccountDeletion || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

class MutationCancelAccountDeletion {
  MutationCancelAccountDeletion({
    this.deleteDeletionRequestsByPk,
    this.$__typename = 'mutation_root',
  });

  factory MutationCancelAccountDeletion.fromJson(Map<String, dynamic> json) {
    final l$deleteDeletionRequestsByPk = json['deleteDeletionRequestsByPk'];
    final l$$__typename = json['__typename'];
    return MutationCancelAccountDeletion(
      deleteDeletionRequestsByPk: l$deleteDeletionRequestsByPk == null
          ? null
          : MutationCancelAccountDeletiondeleteDeletionRequestsByPk.fromJson(
              (l$deleteDeletionRequestsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationCancelAccountDeletiondeleteDeletionRequestsByPk? deleteDeletionRequestsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteDeletionRequestsByPk = deleteDeletionRequestsByPk;
    _resultData['deleteDeletionRequestsByPk'] = l$deleteDeletionRequestsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteDeletionRequestsByPk = deleteDeletionRequestsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteDeletionRequestsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationCancelAccountDeletion || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteDeletionRequestsByPk = deleteDeletionRequestsByPk;
    final lOther$deleteDeletionRequestsByPk = other.deleteDeletionRequestsByPk;
    if (l$deleteDeletionRequestsByPk != lOther$deleteDeletionRequestsByPk) {
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

const documentNodeMutationCancelAccountDeletion = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CancelAccountDeletion'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'deleteDeletionRequestsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'userId'),
                value: VariableNode(name: NameNode(value: 'userId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'userId'),
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
MutationCancelAccountDeletion _parserFnMutationCancelAccountDeletion(Map<String, dynamic> data) =>
    MutationCancelAccountDeletion.fromJson(data);
typedef OnMutationCompletedMutationCancelAccountDeletion = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationCancelAccountDeletion?,
);

class OptionsMutationCancelAccountDeletion
    extends graphql.MutationOptions<MutationCancelAccountDeletion> {
  OptionsMutationCancelAccountDeletion({
    String? operationName,
    required VariablesMutationCancelAccountDeletion variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationCancelAccountDeletion? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationCancelAccountDeletion? onCompleted,
    graphql.OnMutationUpdate<MutationCancelAccountDeletion>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CancelAccountDeletion',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationCancelAccountDeletion(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationCancelAccountDeletion,
         parserFn: _parserFnMutationCancelAccountDeletion,
       );

  final OnMutationCompletedMutationCancelAccountDeletion? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationCancelAccountDeletion
    extends graphql.WatchQueryOptions<MutationCancelAccountDeletion> {
  WatchOptionsMutationCancelAccountDeletion({
    String? operationName,
    required VariablesMutationCancelAccountDeletion variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationCancelAccountDeletion? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CancelAccountDeletion',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationCancelAccountDeletion,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationCancelAccountDeletion,
       );
}

extension ClientExtensionMutationCancelAccountDeletion on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationCancelAccountDeletion>> mutateCancelAccountDeletion(
    OptionsMutationCancelAccountDeletion options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationCancelAccountDeletion> watchMutationCancelAccountDeletion(
    WatchOptionsMutationCancelAccountDeletion options,
  ) => this.watchMutation(options);
}

class MutationCancelAccountDeletiondeleteDeletionRequestsByPk {
  MutationCancelAccountDeletiondeleteDeletionRequestsByPk({
    required this.userId,
    this.$__typename = 'deletionRequests',
  });

  factory MutationCancelAccountDeletiondeleteDeletionRequestsByPk.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$userId = json['userId'];
    final l$$__typename = json['__typename'];
    return MutationCancelAccountDeletiondeleteDeletionRequestsByPk(
      userId: (l$userId as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationCancelAccountDeletiondeleteDeletionRequestsByPk ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
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
