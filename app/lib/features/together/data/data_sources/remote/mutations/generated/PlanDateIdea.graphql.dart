// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationPlanDateIdea {
  factory VariablesMutationPlanDateIdea({required String id, required DateTime day}) =>
      VariablesMutationPlanDateIdea._({r'id': id, r'day': day});

  VariablesMutationPlanDateIdea._(this._$data);

  factory VariablesMutationPlanDateIdea.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$day = data['day'];
    result$data['day'] = DateTime.parse((l$day as String));
    return VariablesMutationPlanDateIdea._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  DateTime get day => (_$data['day'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$day = day;
    result$data['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationPlanDateIdea || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$day = day;
    final lOther$day = other.day;
    if (l$day != lOther$day) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$day = day;
    return Object.hashAll([l$id, l$day]);
  }
}

class MutationPlanDateIdea {
  MutationPlanDateIdea({this.updateSavedDateIdeasByPk, this.$__typename = 'mutation_root'});

  factory MutationPlanDateIdea.fromJson(Map<String, dynamic> json) {
    final l$updateSavedDateIdeasByPk = json['updateSavedDateIdeasByPk'];
    final l$$__typename = json['__typename'];
    return MutationPlanDateIdea(
      updateSavedDateIdeasByPk: l$updateSavedDateIdeasByPk == null
          ? null
          : MutationPlanDateIdeaupdateSavedDateIdeasByPk.fromJson(
              (l$updateSavedDateIdeasByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationPlanDateIdeaupdateSavedDateIdeasByPk? updateSavedDateIdeasByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateSavedDateIdeasByPk = updateSavedDateIdeasByPk;
    _resultData['updateSavedDateIdeasByPk'] = l$updateSavedDateIdeasByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateSavedDateIdeasByPk = updateSavedDateIdeasByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateSavedDateIdeasByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationPlanDateIdea || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateSavedDateIdeasByPk = updateSavedDateIdeasByPk;
    final lOther$updateSavedDateIdeasByPk = other.updateSavedDateIdeasByPk;
    if (l$updateSavedDateIdeasByPk != lOther$updateSavedDateIdeasByPk) {
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

const documentNodeMutationPlanDateIdea = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'PlanDateIdea'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'day')),
          type: NamedTypeNode(name: NameNode(value: 'date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateSavedDateIdeasByPk'),
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
                      value: EnumValueNode(name: NameNode(value: 'planned')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'plannedFor'),
                      value: VariableNode(name: NameNode(value: 'day')),
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
MutationPlanDateIdea _parserFnMutationPlanDateIdea(Map<String, dynamic> data) =>
    MutationPlanDateIdea.fromJson(data);
typedef OnMutationCompletedMutationPlanDateIdea = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationPlanDateIdea?,
);

class OptionsMutationPlanDateIdea extends graphql.MutationOptions<MutationPlanDateIdea> {
  OptionsMutationPlanDateIdea({
    String? operationName,
    required VariablesMutationPlanDateIdea variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationPlanDateIdea? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationPlanDateIdea? onCompleted,
    graphql.OnMutationUpdate<MutationPlanDateIdea>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'PlanDateIdea',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationPlanDateIdea(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationPlanDateIdea,
         parserFn: _parserFnMutationPlanDateIdea,
       );

  final OnMutationCompletedMutationPlanDateIdea? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationPlanDateIdea extends graphql.WatchQueryOptions<MutationPlanDateIdea> {
  WatchOptionsMutationPlanDateIdea({
    String? operationName,
    required VariablesMutationPlanDateIdea variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationPlanDateIdea? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'PlanDateIdea',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationPlanDateIdea,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationPlanDateIdea,
       );
}

extension ClientExtensionMutationPlanDateIdea on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationPlanDateIdea>> mutatePlanDateIdea(
    OptionsMutationPlanDateIdea options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationPlanDateIdea> watchMutationPlanDateIdea(
    WatchOptionsMutationPlanDateIdea options,
  ) => this.watchMutation(options);
}

class MutationPlanDateIdeaupdateSavedDateIdeasByPk {
  MutationPlanDateIdeaupdateSavedDateIdeasByPk({
    required this.id,
    this.$__typename = 'savedDateIdeas',
  });

  factory MutationPlanDateIdeaupdateSavedDateIdeasByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationPlanDateIdeaupdateSavedDateIdeasByPk(
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
    if (other is! MutationPlanDateIdeaupdateSavedDateIdeasByPk ||
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
