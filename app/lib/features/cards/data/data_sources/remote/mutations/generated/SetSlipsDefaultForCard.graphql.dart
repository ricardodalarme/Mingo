// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSetSlipsDefaultForCard {
  factory VariablesMutationSetSlipsDefaultForCard({required String userId, required bool value}) =>
      VariablesMutationSetSlipsDefaultForCard._({r'userId': userId, r'value': value});

  VariablesMutationSetSlipsDefaultForCard._(this._$data);

  factory VariablesMutationSetSlipsDefaultForCard.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$value = data['value'];
    result$data['value'] = (l$value as bool);
    return VariablesMutationSetSlipsDefaultForCard._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  bool get value => (_$data['value'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$value = value;
    result$data['value'] = l$value;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSetSlipsDefaultForCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$value = value;
    return Object.hashAll([l$userId, l$value]);
  }
}

class MutationSetSlipsDefaultForCard {
  MutationSetSlipsDefaultForCard({this.updateUserSettingsByPk, this.$__typename = 'mutation_root'});

  factory MutationSetSlipsDefaultForCard.fromJson(Map<String, dynamic> json) {
    final l$updateUserSettingsByPk = json['updateUserSettingsByPk'];
    final l$$__typename = json['__typename'];
    return MutationSetSlipsDefaultForCard(
      updateUserSettingsByPk: l$updateUserSettingsByPk == null
          ? null
          : MutationSetSlipsDefaultForCardupdateUserSettingsByPk.fromJson(
              (l$updateUserSettingsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSetSlipsDefaultForCardupdateUserSettingsByPk? updateUserSettingsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateUserSettingsByPk = updateUserSettingsByPk;
    _resultData['updateUserSettingsByPk'] = l$updateUserSettingsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateUserSettingsByPk = updateUserSettingsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateUserSettingsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSetSlipsDefaultForCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateUserSettingsByPk = updateUserSettingsByPk;
    final lOther$updateUserSettingsByPk = other.updateUserSettingsByPk;
    if (l$updateUserSettingsByPk != lOther$updateUserSettingsByPk) {
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

const documentNodeMutationSetSlipsDefaultForCard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetSlipsDefaultForCard'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'value')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateUserSettingsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'userId'),
                      value: VariableNode(name: NameNode(value: 'userId')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'slipsDefaultForCard'),
                      value: VariableNode(name: NameNode(value: 'value')),
                    ),
                  ],
                ),
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
MutationSetSlipsDefaultForCard _parserFnMutationSetSlipsDefaultForCard(Map<String, dynamic> data) =>
    MutationSetSlipsDefaultForCard.fromJson(data);
typedef OnMutationCompletedMutationSetSlipsDefaultForCard = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSetSlipsDefaultForCard?,
);

class OptionsMutationSetSlipsDefaultForCard
    extends graphql.MutationOptions<MutationSetSlipsDefaultForCard> {
  OptionsMutationSetSlipsDefaultForCard({
    String? operationName,
    required VariablesMutationSetSlipsDefaultForCard variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetSlipsDefaultForCard? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSetSlipsDefaultForCard? onCompleted,
    graphql.OnMutationUpdate<MutationSetSlipsDefaultForCard>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetSlipsDefaultForCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationSetSlipsDefaultForCard(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationSetSlipsDefaultForCard,
         parserFn: _parserFnMutationSetSlipsDefaultForCard,
       );

  final OnMutationCompletedMutationSetSlipsDefaultForCard? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSetSlipsDefaultForCard
    extends graphql.WatchQueryOptions<MutationSetSlipsDefaultForCard> {
  WatchOptionsMutationSetSlipsDefaultForCard({
    String? operationName,
    required VariablesMutationSetSlipsDefaultForCard variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetSlipsDefaultForCard? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetSlipsDefaultForCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSetSlipsDefaultForCard,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSetSlipsDefaultForCard,
       );
}

extension ClientExtensionMutationSetSlipsDefaultForCard on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSetSlipsDefaultForCard>> mutateSetSlipsDefaultForCard(
    OptionsMutationSetSlipsDefaultForCard options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSetSlipsDefaultForCard> watchMutationSetSlipsDefaultForCard(
    WatchOptionsMutationSetSlipsDefaultForCard options,
  ) => this.watchMutation(options);
}

class MutationSetSlipsDefaultForCardupdateUserSettingsByPk {
  MutationSetSlipsDefaultForCardupdateUserSettingsByPk({
    required this.userId,
    this.$__typename = 'userSettings',
  });

  factory MutationSetSlipsDefaultForCardupdateUserSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$$__typename = json['__typename'];
    return MutationSetSlipsDefaultForCardupdateUserSettingsByPk(
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
    if (other is! MutationSetSlipsDefaultForCardupdateUserSettingsByPk ||
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
