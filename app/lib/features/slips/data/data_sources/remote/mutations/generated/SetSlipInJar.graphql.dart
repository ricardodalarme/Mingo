// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSetSlipInJar {
  factory VariablesMutationSetSlipInJar({required String id, required bool inJar}) =>
      VariablesMutationSetSlipInJar._({r'id': id, r'inJar': inJar});

  VariablesMutationSetSlipInJar._(this._$data);

  factory VariablesMutationSetSlipInJar.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$inJar = data['inJar'];
    result$data['inJar'] = (l$inJar as bool);
    return VariablesMutationSetSlipInJar._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  bool get inJar => (_$data['inJar'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$inJar = inJar;
    result$data['inJar'] = l$inJar;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSetSlipInJar || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$inJar = inJar;
    final lOther$inJar = other.inJar;
    if (l$inJar != lOther$inJar) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$inJar = inJar;
    return Object.hashAll([l$id, l$inJar]);
  }
}

class MutationSetSlipInJar {
  MutationSetSlipInJar({this.updateSlipsByPk, this.$__typename = 'mutation_root'});

  factory MutationSetSlipInJar.fromJson(Map<String, dynamic> json) {
    final l$updateSlipsByPk = json['updateSlipsByPk'];
    final l$$__typename = json['__typename'];
    return MutationSetSlipInJar(
      updateSlipsByPk: l$updateSlipsByPk == null
          ? null
          : MutationSetSlipInJarupdateSlipsByPk.fromJson(
              (l$updateSlipsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSetSlipInJarupdateSlipsByPk? updateSlipsByPk;

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
    if (other is! MutationSetSlipInJar || runtimeType != other.runtimeType) {
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

const documentNodeMutationSetSlipInJar = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetSlipInJar'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'inJar')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: true),
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
                      name: NameNode(value: 'inJar'),
                      value: VariableNode(name: NameNode(value: 'inJar')),
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
                  name: NameNode(value: 'inJar'),
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
MutationSetSlipInJar _parserFnMutationSetSlipInJar(Map<String, dynamic> data) =>
    MutationSetSlipInJar.fromJson(data);
typedef OnMutationCompletedMutationSetSlipInJar = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSetSlipInJar?,
);

class OptionsMutationSetSlipInJar extends graphql.MutationOptions<MutationSetSlipInJar> {
  OptionsMutationSetSlipInJar({
    String? operationName,
    required VariablesMutationSetSlipInJar variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetSlipInJar? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSetSlipInJar? onCompleted,
    graphql.OnMutationUpdate<MutationSetSlipInJar>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetSlipInJar',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSetSlipInJar(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSetSlipInJar,
         parserFn: _parserFnMutationSetSlipInJar,
       );

  final OnMutationCompletedMutationSetSlipInJar? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSetSlipInJar extends graphql.WatchQueryOptions<MutationSetSlipInJar> {
  WatchOptionsMutationSetSlipInJar({
    String? operationName,
    required VariablesMutationSetSlipInJar variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetSlipInJar? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetSlipInJar',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSetSlipInJar,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSetSlipInJar,
       );
}

extension ClientExtensionMutationSetSlipInJar on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSetSlipInJar>> mutateSetSlipInJar(
    OptionsMutationSetSlipInJar options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSetSlipInJar> watchMutationSetSlipInJar(
    WatchOptionsMutationSetSlipInJar options,
  ) => this.watchMutation(options);
}

class MutationSetSlipInJarupdateSlipsByPk {
  MutationSetSlipInJarupdateSlipsByPk({
    required this.id,
    required this.inJar,
    this.$__typename = 'slips',
  });

  factory MutationSetSlipInJarupdateSlipsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$inJar = json['inJar'];
    final l$$__typename = json['__typename'];
    return MutationSetSlipInJarupdateSlipsByPk(
      id: (l$id as String),
      inJar: (l$inJar as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final bool inJar;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$inJar = inJar;
    _resultData['inJar'] = l$inJar;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$inJar = inJar;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$inJar, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSetSlipInJarupdateSlipsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$inJar = inJar;
    final lOther$inJar = other.inJar;
    if (l$inJar != lOther$inJar) {
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
