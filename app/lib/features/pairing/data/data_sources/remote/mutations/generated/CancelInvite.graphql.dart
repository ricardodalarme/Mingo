// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationCancelInvite {
  factory VariablesMutationCancelInvite({
    required String inviteId,
    required DateTime cancelledAt,
  }) => VariablesMutationCancelInvite._({r'inviteId': inviteId, r'cancelledAt': cancelledAt});

  VariablesMutationCancelInvite._(this._$data);

  factory VariablesMutationCancelInvite.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$inviteId = data['inviteId'];
    result$data['inviteId'] = (l$inviteId as String);
    final l$cancelledAt = data['cancelledAt'];
    result$data['cancelledAt'] = DateTime.parse((l$cancelledAt as String));
    return VariablesMutationCancelInvite._(result$data);
  }

  Map<String, dynamic> _$data;

  String get inviteId => (_$data['inviteId'] as String);

  DateTime get cancelledAt => (_$data['cancelledAt'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$inviteId = inviteId;
    result$data['inviteId'] = l$inviteId;
    final l$cancelledAt = cancelledAt;
    result$data['cancelledAt'] = ((v) => v.toUtc().toIso8601String())(l$cancelledAt);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationCancelInvite || runtimeType != other.runtimeType) {
      return false;
    }
    final l$inviteId = inviteId;
    final lOther$inviteId = other.inviteId;
    if (l$inviteId != lOther$inviteId) {
      return false;
    }
    final l$cancelledAt = cancelledAt;
    final lOther$cancelledAt = other.cancelledAt;
    if (l$cancelledAt != lOther$cancelledAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$inviteId = inviteId;
    final l$cancelledAt = cancelledAt;
    return Object.hashAll([l$inviteId, l$cancelledAt]);
  }
}

class MutationCancelInvite {
  MutationCancelInvite({this.updateInvitesByPk, this.$__typename = 'mutation_root'});

  factory MutationCancelInvite.fromJson(Map<String, dynamic> json) {
    final l$updateInvitesByPk = json['updateInvitesByPk'];
    final l$$__typename = json['__typename'];
    return MutationCancelInvite(
      updateInvitesByPk: l$updateInvitesByPk == null
          ? null
          : MutationCancelInviteupdateInvitesByPk.fromJson(
              (l$updateInvitesByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationCancelInviteupdateInvitesByPk? updateInvitesByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateInvitesByPk = updateInvitesByPk;
    _resultData['updateInvitesByPk'] = l$updateInvitesByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateInvitesByPk = updateInvitesByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateInvitesByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationCancelInvite || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateInvitesByPk = updateInvitesByPk;
    final lOther$updateInvitesByPk = other.updateInvitesByPk;
    if (l$updateInvitesByPk != lOther$updateInvitesByPk) {
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

const documentNodeMutationCancelInvite = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CancelInvite'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'inviteId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cancelledAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateInvitesByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: VariableNode(name: NameNode(value: 'inviteId')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'cancelledAt'),
                      value: VariableNode(name: NameNode(value: 'cancelledAt')),
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
                  name: NameNode(value: 'cancelledAt'),
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
MutationCancelInvite _parserFnMutationCancelInvite(Map<String, dynamic> data) =>
    MutationCancelInvite.fromJson(data);
typedef OnMutationCompletedMutationCancelInvite = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationCancelInvite?,
);

class OptionsMutationCancelInvite extends graphql.MutationOptions<MutationCancelInvite> {
  OptionsMutationCancelInvite({
    String? operationName,
    required VariablesMutationCancelInvite variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationCancelInvite? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationCancelInvite? onCompleted,
    graphql.OnMutationUpdate<MutationCancelInvite>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CancelInvite',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationCancelInvite(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationCancelInvite,
         parserFn: _parserFnMutationCancelInvite,
       );

  final OnMutationCompletedMutationCancelInvite? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationCancelInvite extends graphql.WatchQueryOptions<MutationCancelInvite> {
  WatchOptionsMutationCancelInvite({
    String? operationName,
    required VariablesMutationCancelInvite variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationCancelInvite? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CancelInvite',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationCancelInvite,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationCancelInvite,
       );
}

extension ClientExtensionMutationCancelInvite on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationCancelInvite>> mutateCancelInvite(
    OptionsMutationCancelInvite options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationCancelInvite> watchMutationCancelInvite(
    WatchOptionsMutationCancelInvite options,
  ) => this.watchMutation(options);
}

class MutationCancelInviteupdateInvitesByPk {
  MutationCancelInviteupdateInvitesByPk({
    required this.id,
    this.cancelledAt,
    this.$__typename = 'invites',
  });

  factory MutationCancelInviteupdateInvitesByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$cancelledAt = json['cancelledAt'];
    final l$$__typename = json['__typename'];
    return MutationCancelInviteupdateInvitesByPk(
      id: (l$id as String),
      cancelledAt: l$cancelledAt == null ? null : DateTime.parse((l$cancelledAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime? cancelledAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$cancelledAt = cancelledAt;
    _resultData['cancelledAt'] = l$cancelledAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$cancelledAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$cancelledAt = cancelledAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$cancelledAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationCancelInviteupdateInvitesByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$cancelledAt = cancelledAt;
    final lOther$cancelledAt = other.cancelledAt;
    if (l$cancelledAt != lOther$cancelledAt) {
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
