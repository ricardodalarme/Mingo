// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteAnnoyance {
  factory VariablesMutationDeleteAnnoyance({required String id}) =>
      VariablesMutationDeleteAnnoyance._({r'id': id});

  VariablesMutationDeleteAnnoyance._(this._$data);

  factory VariablesMutationDeleteAnnoyance.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteAnnoyance._(result$data);
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
    if (other is! VariablesMutationDeleteAnnoyance || runtimeType != other.runtimeType) {
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

class MutationDeleteAnnoyance {
  MutationDeleteAnnoyance({this.deleteAnnoyancesByPk, this.$__typename = 'mutation_root'});

  factory MutationDeleteAnnoyance.fromJson(Map<String, dynamic> json) {
    final l$deleteAnnoyancesByPk = json['deleteAnnoyancesByPk'];
    final l$$__typename = json['__typename'];
    return MutationDeleteAnnoyance(
      deleteAnnoyancesByPk: l$deleteAnnoyancesByPk == null
          ? null
          : MutationDeleteAnnoyancedeleteAnnoyancesByPk.fromJson(
              (l$deleteAnnoyancesByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteAnnoyancedeleteAnnoyancesByPk? deleteAnnoyancesByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteAnnoyancesByPk = deleteAnnoyancesByPk;
    _resultData['deleteAnnoyancesByPk'] = l$deleteAnnoyancesByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteAnnoyancesByPk = deleteAnnoyancesByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteAnnoyancesByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteAnnoyance || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteAnnoyancesByPk = deleteAnnoyancesByPk;
    final lOther$deleteAnnoyancesByPk = other.deleteAnnoyancesByPk;
    if (l$deleteAnnoyancesByPk != lOther$deleteAnnoyancesByPk) {
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

const documentNodeMutationDeleteAnnoyance = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteAnnoyance'),
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
            name: NameNode(value: 'deleteAnnoyancesByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
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
MutationDeleteAnnoyance _parserFnMutationDeleteAnnoyance(Map<String, dynamic> data) =>
    MutationDeleteAnnoyance.fromJson(data);
typedef OnMutationCompletedMutationDeleteAnnoyance = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteAnnoyance?,
);

class OptionsMutationDeleteAnnoyance extends graphql.MutationOptions<MutationDeleteAnnoyance> {
  OptionsMutationDeleteAnnoyance({
    String? operationName,
    required VariablesMutationDeleteAnnoyance variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteAnnoyance? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteAnnoyance? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteAnnoyance>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteAnnoyance',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationDeleteAnnoyance(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteAnnoyance,
         parserFn: _parserFnMutationDeleteAnnoyance,
       );

  final OnMutationCompletedMutationDeleteAnnoyance? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteAnnoyance
    extends graphql.WatchQueryOptions<MutationDeleteAnnoyance> {
  WatchOptionsMutationDeleteAnnoyance({
    String? operationName,
    required VariablesMutationDeleteAnnoyance variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteAnnoyance? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteAnnoyance',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteAnnoyance,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteAnnoyance,
       );
}

extension ClientExtensionMutationDeleteAnnoyance on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteAnnoyance>> mutateDeleteAnnoyance(
    OptionsMutationDeleteAnnoyance options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteAnnoyance> watchMutationDeleteAnnoyance(
    WatchOptionsMutationDeleteAnnoyance options,
  ) => this.watchMutation(options);
}

class MutationDeleteAnnoyancedeleteAnnoyancesByPk {
  MutationDeleteAnnoyancedeleteAnnoyancesByPk({required this.id, this.$__typename = 'annoyances'});

  factory MutationDeleteAnnoyancedeleteAnnoyancesByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationDeleteAnnoyancedeleteAnnoyancesByPk(
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
    if (other is! MutationDeleteAnnoyancedeleteAnnoyancesByPk || runtimeType != other.runtimeType) {
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
