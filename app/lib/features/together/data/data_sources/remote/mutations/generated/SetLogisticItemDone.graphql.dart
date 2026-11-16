// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSetLogisticItemDone {
  factory VariablesMutationSetLogisticItemDone({required String id, DateTime? doneAt}) =>
      VariablesMutationSetLogisticItemDone._({r'id': id, if (doneAt != null) r'doneAt': doneAt});

  VariablesMutationSetLogisticItemDone._(this._$data);

  factory VariablesMutationSetLogisticItemDone.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    if (data.containsKey('doneAt')) {
      final l$doneAt = data['doneAt'];
      result$data['doneAt'] = l$doneAt == null ? null : DateTime.parse((l$doneAt as String));
    }
    return VariablesMutationSetLogisticItemDone._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  DateTime? get doneAt => (_$data['doneAt'] as DateTime?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('doneAt')) {
      final l$doneAt = doneAt;
      result$data['doneAt'] = l$doneAt == null
          ? null
          : ((v) => v.toUtc().toIso8601String())(l$doneAt);
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSetLogisticItemDone || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$doneAt = doneAt;
    final lOther$doneAt = other.doneAt;
    if (_$data.containsKey('doneAt') != other._$data.containsKey('doneAt')) {
      return false;
    }
    if (l$doneAt != lOther$doneAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$doneAt = doneAt;
    return Object.hashAll([l$id, _$data.containsKey('doneAt') ? l$doneAt : const {}]);
  }
}

class MutationSetLogisticItemDone {
  MutationSetLogisticItemDone({this.updateLogisticItemsByPk, this.$__typename = 'mutation_root'});

  factory MutationSetLogisticItemDone.fromJson(Map<String, dynamic> json) {
    final l$updateLogisticItemsByPk = json['updateLogisticItemsByPk'];
    final l$$__typename = json['__typename'];
    return MutationSetLogisticItemDone(
      updateLogisticItemsByPk: l$updateLogisticItemsByPk == null
          ? null
          : MutationSetLogisticItemDoneupdateLogisticItemsByPk.fromJson(
              (l$updateLogisticItemsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSetLogisticItemDoneupdateLogisticItemsByPk? updateLogisticItemsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateLogisticItemsByPk = updateLogisticItemsByPk;
    _resultData['updateLogisticItemsByPk'] = l$updateLogisticItemsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateLogisticItemsByPk = updateLogisticItemsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateLogisticItemsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSetLogisticItemDone || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateLogisticItemsByPk = updateLogisticItemsByPk;
    final lOther$updateLogisticItemsByPk = other.updateLogisticItemsByPk;
    if (l$updateLogisticItemsByPk != lOther$updateLogisticItemsByPk) {
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

const documentNodeMutationSetLogisticItemDone = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetLogisticItemDone'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'doneAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateLogisticItemsByPk'),
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
                      name: NameNode(value: 'doneAt'),
                      value: VariableNode(name: NameNode(value: 'doneAt')),
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
MutationSetLogisticItemDone _parserFnMutationSetLogisticItemDone(Map<String, dynamic> data) =>
    MutationSetLogisticItemDone.fromJson(data);
typedef OnMutationCompletedMutationSetLogisticItemDone = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSetLogisticItemDone?,
);

class OptionsMutationSetLogisticItemDone
    extends graphql.MutationOptions<MutationSetLogisticItemDone> {
  OptionsMutationSetLogisticItemDone({
    String? operationName,
    required VariablesMutationSetLogisticItemDone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetLogisticItemDone? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSetLogisticItemDone? onCompleted,
    graphql.OnMutationUpdate<MutationSetLogisticItemDone>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetLogisticItemDone',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationSetLogisticItemDone(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationSetLogisticItemDone,
         parserFn: _parserFnMutationSetLogisticItemDone,
       );

  final OnMutationCompletedMutationSetLogisticItemDone? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSetLogisticItemDone
    extends graphql.WatchQueryOptions<MutationSetLogisticItemDone> {
  WatchOptionsMutationSetLogisticItemDone({
    String? operationName,
    required VariablesMutationSetLogisticItemDone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetLogisticItemDone? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetLogisticItemDone',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSetLogisticItemDone,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSetLogisticItemDone,
       );
}

extension ClientExtensionMutationSetLogisticItemDone on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSetLogisticItemDone>> mutateSetLogisticItemDone(
    OptionsMutationSetLogisticItemDone options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSetLogisticItemDone> watchMutationSetLogisticItemDone(
    WatchOptionsMutationSetLogisticItemDone options,
  ) => this.watchMutation(options);
}

class MutationSetLogisticItemDoneupdateLogisticItemsByPk {
  MutationSetLogisticItemDoneupdateLogisticItemsByPk({
    required this.id,
    this.$__typename = 'logisticItems',
  });

  factory MutationSetLogisticItemDoneupdateLogisticItemsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationSetLogisticItemDoneupdateLogisticItemsByPk(
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
    if (other is! MutationSetLogisticItemDoneupdateLogisticItemsByPk ||
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
