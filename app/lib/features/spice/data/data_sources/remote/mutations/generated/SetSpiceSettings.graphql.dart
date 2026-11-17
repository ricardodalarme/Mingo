// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSetSpiceSettings {
  factory VariablesMutationSetSpiceSettings({
    required String userId,
    required int level,
    required bool notifications,
  }) => VariablesMutationSetSpiceSettings._({
    r'userId': userId,
    r'level': level,
    r'notifications': notifications,
  });

  VariablesMutationSetSpiceSettings._(this._$data);

  factory VariablesMutationSetSpiceSettings.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$level = data['level'];
    result$data['level'] = (l$level as int);
    final l$notifications = data['notifications'];
    result$data['notifications'] = (l$notifications as bool);
    return VariablesMutationSetSpiceSettings._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  int get level => (_$data['level'] as int);

  bool get notifications => (_$data['notifications'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$level = level;
    result$data['level'] = l$level;
    final l$notifications = notifications;
    result$data['notifications'] = l$notifications;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSetSpiceSettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$level = level;
    final lOther$level = other.level;
    if (l$level != lOther$level) {
      return false;
    }
    final l$notifications = notifications;
    final lOther$notifications = other.notifications;
    if (l$notifications != lOther$notifications) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$level = level;
    final l$notifications = notifications;
    return Object.hashAll([l$userId, l$level, l$notifications]);
  }
}

class MutationSetSpiceSettings {
  MutationSetSpiceSettings({this.updateUserSettingsByPk, this.$__typename = 'mutation_root'});

  factory MutationSetSpiceSettings.fromJson(Map<String, dynamic> json) {
    final l$updateUserSettingsByPk = json['updateUserSettingsByPk'];
    final l$$__typename = json['__typename'];
    return MutationSetSpiceSettings(
      updateUserSettingsByPk: l$updateUserSettingsByPk == null
          ? null
          : MutationSetSpiceSettingsupdateUserSettingsByPk.fromJson(
              (l$updateUserSettingsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSetSpiceSettingsupdateUserSettingsByPk? updateUserSettingsByPk;

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
    if (other is! MutationSetSpiceSettings || runtimeType != other.runtimeType) {
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

const documentNodeMutationSetSpiceSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetSpiceSettings'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'level')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'notifications')),
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
                      name: NameNode(value: 'spiceMaxLevel'),
                      value: VariableNode(name: NameNode(value: 'level')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'spiceNotifications'),
                      value: VariableNode(name: NameNode(value: 'notifications')),
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
MutationSetSpiceSettings _parserFnMutationSetSpiceSettings(Map<String, dynamic> data) =>
    MutationSetSpiceSettings.fromJson(data);
typedef OnMutationCompletedMutationSetSpiceSettings = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSetSpiceSettings?,
);

class OptionsMutationSetSpiceSettings extends graphql.MutationOptions<MutationSetSpiceSettings> {
  OptionsMutationSetSpiceSettings({
    String? operationName,
    required VariablesMutationSetSpiceSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetSpiceSettings? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSetSpiceSettings? onCompleted,
    graphql.OnMutationUpdate<MutationSetSpiceSettings>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetSpiceSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSetSpiceSettings(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSetSpiceSettings,
         parserFn: _parserFnMutationSetSpiceSettings,
       );

  final OnMutationCompletedMutationSetSpiceSettings? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSetSpiceSettings
    extends graphql.WatchQueryOptions<MutationSetSpiceSettings> {
  WatchOptionsMutationSetSpiceSettings({
    String? operationName,
    required VariablesMutationSetSpiceSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetSpiceSettings? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetSpiceSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSetSpiceSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSetSpiceSettings,
       );
}

extension ClientExtensionMutationSetSpiceSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSetSpiceSettings>> mutateSetSpiceSettings(
    OptionsMutationSetSpiceSettings options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSetSpiceSettings> watchMutationSetSpiceSettings(
    WatchOptionsMutationSetSpiceSettings options,
  ) => this.watchMutation(options);
}

class MutationSetSpiceSettingsupdateUserSettingsByPk {
  MutationSetSpiceSettingsupdateUserSettingsByPk({
    required this.userId,
    this.$__typename = 'userSettings',
  });

  factory MutationSetSpiceSettingsupdateUserSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$$__typename = json['__typename'];
    return MutationSetSpiceSettingsupdateUserSettingsByPk(
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
    if (other is! MutationSetSpiceSettingsupdateUserSettingsByPk ||
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
