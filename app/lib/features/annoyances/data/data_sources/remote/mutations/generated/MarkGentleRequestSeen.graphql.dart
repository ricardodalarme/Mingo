// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationMarkGentleRequestSeen {
  factory VariablesMutationMarkGentleRequestSeen({required String id, required DateTime seenAt}) =>
      VariablesMutationMarkGentleRequestSeen._({r'id': id, r'seenAt': seenAt});

  VariablesMutationMarkGentleRequestSeen._(this._$data);

  factory VariablesMutationMarkGentleRequestSeen.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$seenAt = data['seenAt'];
    result$data['seenAt'] = DateTime.parse((l$seenAt as String));
    return VariablesMutationMarkGentleRequestSeen._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  DateTime get seenAt => (_$data['seenAt'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$seenAt = seenAt;
    result$data['seenAt'] = ((v) => v.toUtc().toIso8601String())(l$seenAt);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationMarkGentleRequestSeen || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$seenAt = seenAt;
    final lOther$seenAt = other.seenAt;
    if (l$seenAt != lOther$seenAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$seenAt = seenAt;
    return Object.hashAll([l$id, l$seenAt]);
  }
}

class MutationMarkGentleRequestSeen {
  MutationMarkGentleRequestSeen({
    this.updateGentleRequestsByPk,
    this.$__typename = 'mutation_root',
  });

  factory MutationMarkGentleRequestSeen.fromJson(Map<String, dynamic> json) {
    final l$updateGentleRequestsByPk = json['updateGentleRequestsByPk'];
    final l$$__typename = json['__typename'];
    return MutationMarkGentleRequestSeen(
      updateGentleRequestsByPk: l$updateGentleRequestsByPk == null
          ? null
          : MutationMarkGentleRequestSeenupdateGentleRequestsByPk.fromJson(
              (l$updateGentleRequestsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationMarkGentleRequestSeenupdateGentleRequestsByPk? updateGentleRequestsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateGentleRequestsByPk = updateGentleRequestsByPk;
    _resultData['updateGentleRequestsByPk'] = l$updateGentleRequestsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateGentleRequestsByPk = updateGentleRequestsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateGentleRequestsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationMarkGentleRequestSeen || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateGentleRequestsByPk = updateGentleRequestsByPk;
    final lOther$updateGentleRequestsByPk = other.updateGentleRequestsByPk;
    if (l$updateGentleRequestsByPk != lOther$updateGentleRequestsByPk) {
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

const documentNodeMutationMarkGentleRequestSeen = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MarkGentleRequestSeen'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'seenAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateGentleRequestsByPk'),
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
                      name: NameNode(value: 'seenAt'),
                      value: VariableNode(name: NameNode(value: 'seenAt')),
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
MutationMarkGentleRequestSeen _parserFnMutationMarkGentleRequestSeen(Map<String, dynamic> data) =>
    MutationMarkGentleRequestSeen.fromJson(data);
typedef OnMutationCompletedMutationMarkGentleRequestSeen = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationMarkGentleRequestSeen?,
);

class OptionsMutationMarkGentleRequestSeen
    extends graphql.MutationOptions<MutationMarkGentleRequestSeen> {
  OptionsMutationMarkGentleRequestSeen({
    String? operationName,
    required VariablesMutationMarkGentleRequestSeen variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationMarkGentleRequestSeen? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationMarkGentleRequestSeen? onCompleted,
    graphql.OnMutationUpdate<MutationMarkGentleRequestSeen>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MarkGentleRequestSeen',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationMarkGentleRequestSeen(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationMarkGentleRequestSeen,
         parserFn: _parserFnMutationMarkGentleRequestSeen,
       );

  final OnMutationCompletedMutationMarkGentleRequestSeen? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationMarkGentleRequestSeen
    extends graphql.WatchQueryOptions<MutationMarkGentleRequestSeen> {
  WatchOptionsMutationMarkGentleRequestSeen({
    String? operationName,
    required VariablesMutationMarkGentleRequestSeen variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationMarkGentleRequestSeen? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MarkGentleRequestSeen',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationMarkGentleRequestSeen,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationMarkGentleRequestSeen,
       );
}

extension ClientExtensionMutationMarkGentleRequestSeen on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationMarkGentleRequestSeen>> mutateMarkGentleRequestSeen(
    OptionsMutationMarkGentleRequestSeen options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationMarkGentleRequestSeen> watchMutationMarkGentleRequestSeen(
    WatchOptionsMutationMarkGentleRequestSeen options,
  ) => this.watchMutation(options);
}

class MutationMarkGentleRequestSeenupdateGentleRequestsByPk {
  MutationMarkGentleRequestSeenupdateGentleRequestsByPk({
    required this.id,
    this.$__typename = 'gentleRequests',
  });

  factory MutationMarkGentleRequestSeenupdateGentleRequestsByPk.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationMarkGentleRequestSeenupdateGentleRequestsByPk(
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
    if (other is! MutationMarkGentleRequestSeenupdateGentleRequestsByPk ||
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
