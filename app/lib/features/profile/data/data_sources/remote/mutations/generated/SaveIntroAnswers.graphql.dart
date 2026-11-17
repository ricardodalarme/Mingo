// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSaveIntroAnswers {
  factory VariablesMutationSaveIntroAnswers({
    required String profileId,
    EnumRelationshipPhase_enum? phase,
    required List<InputuserGoals_insert_input> goals,
  }) => VariablesMutationSaveIntroAnswers._({
    r'profileId': profileId,
    if (phase != null) r'phase': phase,
    r'goals': goals,
  });

  VariablesMutationSaveIntroAnswers._(this._$data);

  factory VariablesMutationSaveIntroAnswers.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$profileId = data['profileId'];
    result$data['profileId'] = (l$profileId as String);
    if (data.containsKey('phase')) {
      final l$phase = data['phase'];
      result$data['phase'] = l$phase == null
          ? null
          : fromJsonEnumRelationshipPhase_enum((l$phase as String));
    }
    final l$goals = data['goals'];
    result$data['goals'] = (l$goals as List<dynamic>)
        .map((e) => InputuserGoals_insert_input.fromJson((e as Map<String, dynamic>)))
        .toList();
    return VariablesMutationSaveIntroAnswers._(result$data);
  }

  Map<String, dynamic> _$data;

  String get profileId => (_$data['profileId'] as String);

  EnumRelationshipPhase_enum? get phase => (_$data['phase'] as EnumRelationshipPhase_enum?);

  List<InputuserGoals_insert_input> get goals =>
      (_$data['goals'] as List<InputuserGoals_insert_input>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$profileId = profileId;
    result$data['profileId'] = l$profileId;
    if (_$data.containsKey('phase')) {
      final l$phase = phase;
      result$data['phase'] = l$phase == null ? null : toJsonEnumRelationshipPhase_enum(l$phase);
    }
    final l$goals = goals;
    result$data['goals'] = l$goals.map((e) => e.toJson()).toList();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSaveIntroAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$profileId = profileId;
    final lOther$profileId = other.profileId;
    if (l$profileId != lOther$profileId) {
      return false;
    }
    final l$phase = phase;
    final lOther$phase = other.phase;
    if (_$data.containsKey('phase') != other._$data.containsKey('phase')) {
      return false;
    }
    if (l$phase != lOther$phase) {
      return false;
    }
    final l$goals = goals;
    final lOther$goals = other.goals;
    if (l$goals.length != lOther$goals.length) {
      return false;
    }
    for (int i = 0; i < l$goals.length; i++) {
      final l$goals$entry = l$goals[i];
      final lOther$goals$entry = lOther$goals[i];
      if (l$goals$entry != lOther$goals$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$profileId = profileId;
    final l$phase = phase;
    final l$goals = goals;
    return Object.hashAll([
      l$profileId,
      _$data.containsKey('phase') ? l$phase : const {},
      Object.hashAll(l$goals.map((v) => v)),
    ]);
  }
}

class MutationSaveIntroAnswers {
  MutationSaveIntroAnswers({
    this.updateUserSettingsByPk,
    this.deleteUserGoals,
    this.insertUserGoals,
    this.$__typename = 'mutation_root',
  });

  factory MutationSaveIntroAnswers.fromJson(Map<String, dynamic> json) {
    final l$updateUserSettingsByPk = json['updateUserSettingsByPk'];
    final l$deleteUserGoals = json['deleteUserGoals'];
    final l$insertUserGoals = json['insertUserGoals'];
    final l$$__typename = json['__typename'];
    return MutationSaveIntroAnswers(
      updateUserSettingsByPk: l$updateUserSettingsByPk == null
          ? null
          : MutationSaveIntroAnswersupdateUserSettingsByPk.fromJson(
              (l$updateUserSettingsByPk as Map<String, dynamic>),
            ),
      deleteUserGoals: l$deleteUserGoals == null
          ? null
          : MutationSaveIntroAnswersdeleteUserGoals.fromJson(
              (l$deleteUserGoals as Map<String, dynamic>),
            ),
      insertUserGoals: l$insertUserGoals == null
          ? null
          : MutationSaveIntroAnswersinsertUserGoals.fromJson(
              (l$insertUserGoals as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSaveIntroAnswersupdateUserSettingsByPk? updateUserSettingsByPk;

  final MutationSaveIntroAnswersdeleteUserGoals? deleteUserGoals;

  final MutationSaveIntroAnswersinsertUserGoals? insertUserGoals;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateUserSettingsByPk = updateUserSettingsByPk;
    _resultData['updateUserSettingsByPk'] = l$updateUserSettingsByPk?.toJson();
    final l$deleteUserGoals = deleteUserGoals;
    _resultData['deleteUserGoals'] = l$deleteUserGoals?.toJson();
    final l$insertUserGoals = insertUserGoals;
    _resultData['insertUserGoals'] = l$insertUserGoals?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateUserSettingsByPk = updateUserSettingsByPk;
    final l$deleteUserGoals = deleteUserGoals;
    final l$insertUserGoals = insertUserGoals;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateUserSettingsByPk,
      l$deleteUserGoals,
      l$insertUserGoals,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSaveIntroAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateUserSettingsByPk = updateUserSettingsByPk;
    final lOther$updateUserSettingsByPk = other.updateUserSettingsByPk;
    if (l$updateUserSettingsByPk != lOther$updateUserSettingsByPk) {
      return false;
    }
    final l$deleteUserGoals = deleteUserGoals;
    final lOther$deleteUserGoals = other.deleteUserGoals;
    if (l$deleteUserGoals != lOther$deleteUserGoals) {
      return false;
    }
    final l$insertUserGoals = insertUserGoals;
    final lOther$insertUserGoals = other.insertUserGoals;
    if (l$insertUserGoals != lOther$insertUserGoals) {
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

const documentNodeMutationSaveIntroAnswers = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SaveIntroAnswers'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'profileId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'phase')),
          type: NamedTypeNode(name: NameNode(value: 'RelationshipPhase_enum'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'goals')),
          type: ListTypeNode(
            type: NamedTypeNode(name: NameNode(value: 'userGoals_insert_input'), isNonNull: true),
            isNonNull: true,
          ),
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
                      value: VariableNode(name: NameNode(value: 'profileId')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'phase'),
                      value: VariableNode(name: NameNode(value: 'phase')),
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
            name: NameNode(value: 'deleteUserGoals'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'userId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'profileId')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'affected_rows'),
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
            name: NameNode(value: 'insertUserGoals'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'objects'),
                value: VariableNode(name: NameNode(value: 'goals')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'affected_rows'),
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
MutationSaveIntroAnswers _parserFnMutationSaveIntroAnswers(Map<String, dynamic> data) =>
    MutationSaveIntroAnswers.fromJson(data);
typedef OnMutationCompletedMutationSaveIntroAnswers = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSaveIntroAnswers?,
);

class OptionsMutationSaveIntroAnswers extends graphql.MutationOptions<MutationSaveIntroAnswers> {
  OptionsMutationSaveIntroAnswers({
    String? operationName,
    required VariablesMutationSaveIntroAnswers variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSaveIntroAnswers? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSaveIntroAnswers? onCompleted,
    graphql.OnMutationUpdate<MutationSaveIntroAnswers>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SaveIntroAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSaveIntroAnswers(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSaveIntroAnswers,
         parserFn: _parserFnMutationSaveIntroAnswers,
       );

  final OnMutationCompletedMutationSaveIntroAnswers? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSaveIntroAnswers
    extends graphql.WatchQueryOptions<MutationSaveIntroAnswers> {
  WatchOptionsMutationSaveIntroAnswers({
    String? operationName,
    required VariablesMutationSaveIntroAnswers variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSaveIntroAnswers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SaveIntroAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSaveIntroAnswers,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSaveIntroAnswers,
       );
}

extension ClientExtensionMutationSaveIntroAnswers on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSaveIntroAnswers>> mutateSaveIntroAnswers(
    OptionsMutationSaveIntroAnswers options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSaveIntroAnswers> watchMutationSaveIntroAnswers(
    WatchOptionsMutationSaveIntroAnswers options,
  ) => this.watchMutation(options);
}

class MutationSaveIntroAnswersupdateUserSettingsByPk {
  MutationSaveIntroAnswersupdateUserSettingsByPk({
    required this.userId,
    this.$__typename = 'userSettings',
  });

  factory MutationSaveIntroAnswersupdateUserSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$$__typename = json['__typename'];
    return MutationSaveIntroAnswersupdateUserSettingsByPk(
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
    if (other is! MutationSaveIntroAnswersupdateUserSettingsByPk ||
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

class MutationSaveIntroAnswersdeleteUserGoals {
  MutationSaveIntroAnswersdeleteUserGoals({
    required this.affected_rows,
    this.$__typename = 'userGoals_mutation_response',
  });

  factory MutationSaveIntroAnswersdeleteUserGoals.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationSaveIntroAnswersdeleteUserGoals(
      affected_rows: (l$affected_rows as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int affected_rows;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$affected_rows = affected_rows;
    _resultData['affected_rows'] = l$affected_rows;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$affected_rows = affected_rows;
    final l$$__typename = $__typename;
    return Object.hashAll([l$affected_rows, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSaveIntroAnswersdeleteUserGoals || runtimeType != other.runtimeType) {
      return false;
    }
    final l$affected_rows = affected_rows;
    final lOther$affected_rows = other.affected_rows;
    if (l$affected_rows != lOther$affected_rows) {
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

class MutationSaveIntroAnswersinsertUserGoals {
  MutationSaveIntroAnswersinsertUserGoals({
    required this.affected_rows,
    this.$__typename = 'userGoals_mutation_response',
  });

  factory MutationSaveIntroAnswersinsertUserGoals.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationSaveIntroAnswersinsertUserGoals(
      affected_rows: (l$affected_rows as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int affected_rows;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$affected_rows = affected_rows;
    _resultData['affected_rows'] = l$affected_rows;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$affected_rows = affected_rows;
    final l$$__typename = $__typename;
    return Object.hashAll([l$affected_rows, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSaveIntroAnswersinsertUserGoals || runtimeType != other.runtimeType) {
      return false;
    }
    final l$affected_rows = affected_rows;
    final lOther$affected_rows = other.affected_rows;
    if (l$affected_rows != lOther$affected_rows) {
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
