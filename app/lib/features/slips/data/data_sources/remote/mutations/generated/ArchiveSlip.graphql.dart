// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationArchiveSlip {
  factory VariablesMutationArchiveSlip({required String id, DateTime? archivedAt}) =>
      VariablesMutationArchiveSlip._({
        r'id': id,
        if (archivedAt != null) r'archivedAt': archivedAt,
      });

  VariablesMutationArchiveSlip._(this._$data);

  factory VariablesMutationArchiveSlip.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    if (data.containsKey('archivedAt')) {
      final l$archivedAt = data['archivedAt'];
      result$data['archivedAt'] = l$archivedAt == null
          ? null
          : DateTime.parse((l$archivedAt as String));
    }
    return VariablesMutationArchiveSlip._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  DateTime? get archivedAt => (_$data['archivedAt'] as DateTime?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('archivedAt')) {
      final l$archivedAt = archivedAt;
      result$data['archivedAt'] = l$archivedAt == null
          ? null
          : ((v) => v.toUtc().toIso8601String())(l$archivedAt);
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationArchiveSlip || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$archivedAt = archivedAt;
    final lOther$archivedAt = other.archivedAt;
    if (_$data.containsKey('archivedAt') != other._$data.containsKey('archivedAt')) {
      return false;
    }
    if (l$archivedAt != lOther$archivedAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$archivedAt = archivedAt;
    return Object.hashAll([l$id, _$data.containsKey('archivedAt') ? l$archivedAt : const {}]);
  }
}

class MutationArchiveSlip {
  MutationArchiveSlip({this.updateSlipsByPk, this.$__typename = 'mutation_root'});

  factory MutationArchiveSlip.fromJson(Map<String, dynamic> json) {
    final l$updateSlipsByPk = json['updateSlipsByPk'];
    final l$$__typename = json['__typename'];
    return MutationArchiveSlip(
      updateSlipsByPk: l$updateSlipsByPk == null
          ? null
          : MutationArchiveSlipupdateSlipsByPk.fromJson(
              (l$updateSlipsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationArchiveSlipupdateSlipsByPk? updateSlipsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateSlipsByPk = updateSlipsByPk;
    _resultData['updateSlipsByPk'] = l$updateSlipsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateSlipsByPk = updateSlipsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateSlipsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationArchiveSlip || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateSlipsByPk = updateSlipsByPk;
    final lOther$updateSlipsByPk = other.updateSlipsByPk;
    if (l$updateSlipsByPk != lOther$updateSlipsByPk) {
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

const documentNodeMutationArchiveSlip = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ArchiveSlip'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'archivedAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateSlipsByPk'),
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
                      name: NameNode(value: 'archivedAt'),
                      value: VariableNode(name: NameNode(value: 'archivedAt')),
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
                  name: NameNode(value: 'archivedAt'),
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
MutationArchiveSlip _parserFnMutationArchiveSlip(Map<String, dynamic> data) =>
    MutationArchiveSlip.fromJson(data);
typedef OnMutationCompletedMutationArchiveSlip = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationArchiveSlip?,
);

class OptionsMutationArchiveSlip extends graphql.MutationOptions<MutationArchiveSlip> {
  OptionsMutationArchiveSlip({
    String? operationName,
    required VariablesMutationArchiveSlip variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationArchiveSlip? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationArchiveSlip? onCompleted,
    graphql.OnMutationUpdate<MutationArchiveSlip>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ArchiveSlip',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationArchiveSlip(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationArchiveSlip,
         parserFn: _parserFnMutationArchiveSlip,
       );

  final OnMutationCompletedMutationArchiveSlip? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationArchiveSlip extends graphql.WatchQueryOptions<MutationArchiveSlip> {
  WatchOptionsMutationArchiveSlip({
    String? operationName,
    required VariablesMutationArchiveSlip variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationArchiveSlip? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ArchiveSlip',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationArchiveSlip,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationArchiveSlip,
       );
}

extension ClientExtensionMutationArchiveSlip on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationArchiveSlip>> mutateArchiveSlip(
    OptionsMutationArchiveSlip options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationArchiveSlip> watchMutationArchiveSlip(
    WatchOptionsMutationArchiveSlip options,
  ) => this.watchMutation(options);
}

class MutationArchiveSlipupdateSlipsByPk {
  MutationArchiveSlipupdateSlipsByPk({
    required this.id,
    this.archivedAt,
    this.$__typename = 'slips',
  });

  factory MutationArchiveSlipupdateSlipsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$archivedAt = json['archivedAt'];
    final l$$__typename = json['__typename'];
    return MutationArchiveSlipupdateSlipsByPk(
      id: (l$id as String),
      archivedAt: l$archivedAt == null ? null : DateTime.parse((l$archivedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime? archivedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$archivedAt = archivedAt;
    _resultData['archivedAt'] = l$archivedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$archivedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$archivedAt = archivedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$archivedAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationArchiveSlipupdateSlipsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$archivedAt = archivedAt;
    final lOther$archivedAt = other.archivedAt;
    if (l$archivedAt != lOther$archivedAt) {
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
