// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationArchiveAgreement {
  factory VariablesMutationArchiveAgreement({required String id, required DateTime archivedAt}) =>
      VariablesMutationArchiveAgreement._({r'id': id, r'archivedAt': archivedAt});

  VariablesMutationArchiveAgreement._(this._$data);

  factory VariablesMutationArchiveAgreement.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$archivedAt = data['archivedAt'];
    result$data['archivedAt'] = DateTime.parse((l$archivedAt as String));
    return VariablesMutationArchiveAgreement._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  DateTime get archivedAt => (_$data['archivedAt'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$archivedAt = archivedAt;
    result$data['archivedAt'] = ((v) => v.toUtc().toIso8601String())(l$archivedAt);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationArchiveAgreement || runtimeType != other.runtimeType) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$archivedAt = archivedAt;
    return Object.hashAll([l$id, l$archivedAt]);
  }
}

class MutationArchiveAgreement {
  MutationArchiveAgreement({this.updateAgreementsByPk, this.$__typename = 'mutation_root'});

  factory MutationArchiveAgreement.fromJson(Map<String, dynamic> json) {
    final l$updateAgreementsByPk = json['updateAgreementsByPk'];
    final l$$__typename = json['__typename'];
    return MutationArchiveAgreement(
      updateAgreementsByPk: l$updateAgreementsByPk == null
          ? null
          : MutationArchiveAgreementupdateAgreementsByPk.fromJson(
              (l$updateAgreementsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationArchiveAgreementupdateAgreementsByPk? updateAgreementsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateAgreementsByPk = updateAgreementsByPk;
    _resultData['updateAgreementsByPk'] = l$updateAgreementsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateAgreementsByPk = updateAgreementsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateAgreementsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationArchiveAgreement || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateAgreementsByPk = updateAgreementsByPk;
    final lOther$updateAgreementsByPk = other.updateAgreementsByPk;
    if (l$updateAgreementsByPk != lOther$updateAgreementsByPk) {
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

const documentNodeMutationArchiveAgreement = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ArchiveAgreement'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'archivedAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateAgreementsByPk'),
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
MutationArchiveAgreement _parserFnMutationArchiveAgreement(Map<String, dynamic> data) =>
    MutationArchiveAgreement.fromJson(data);
typedef OnMutationCompletedMutationArchiveAgreement = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationArchiveAgreement?,
);

class OptionsMutationArchiveAgreement extends graphql.MutationOptions<MutationArchiveAgreement> {
  OptionsMutationArchiveAgreement({
    String? operationName,
    required VariablesMutationArchiveAgreement variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationArchiveAgreement? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationArchiveAgreement? onCompleted,
    graphql.OnMutationUpdate<MutationArchiveAgreement>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ArchiveAgreement',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationArchiveAgreement(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationArchiveAgreement,
         parserFn: _parserFnMutationArchiveAgreement,
       );

  final OnMutationCompletedMutationArchiveAgreement? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationArchiveAgreement
    extends graphql.WatchQueryOptions<MutationArchiveAgreement> {
  WatchOptionsMutationArchiveAgreement({
    String? operationName,
    required VariablesMutationArchiveAgreement variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationArchiveAgreement? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ArchiveAgreement',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationArchiveAgreement,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationArchiveAgreement,
       );
}

extension ClientExtensionMutationArchiveAgreement on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationArchiveAgreement>> mutateArchiveAgreement(
    OptionsMutationArchiveAgreement options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationArchiveAgreement> watchMutationArchiveAgreement(
    WatchOptionsMutationArchiveAgreement options,
  ) => this.watchMutation(options);
}

class MutationArchiveAgreementupdateAgreementsByPk {
  MutationArchiveAgreementupdateAgreementsByPk({required this.id, this.$__typename = 'agreements'});

  factory MutationArchiveAgreementupdateAgreementsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationArchiveAgreementupdateAgreementsByPk(
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
    if (other is! MutationArchiveAgreementupdateAgreementsByPk ||
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
