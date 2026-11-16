// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateNotificationSettings {
  factory VariablesMutationUpdateNotificationSettings({
    required String userId,
    required bool enabled,
    required int cardDay,
    required int cardHour,
    required List<InputnotificationMutes_insert_input> mutes,
  }) => VariablesMutationUpdateNotificationSettings._({
    r'userId': userId,
    r'enabled': enabled,
    r'cardDay': cardDay,
    r'cardHour': cardHour,
    r'mutes': mutes,
  });

  VariablesMutationUpdateNotificationSettings._(this._$data);

  factory VariablesMutationUpdateNotificationSettings.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$enabled = data['enabled'];
    result$data['enabled'] = (l$enabled as bool);
    final l$cardDay = data['cardDay'];
    result$data['cardDay'] = (l$cardDay as int);
    final l$cardHour = data['cardHour'];
    result$data['cardHour'] = (l$cardHour as int);
    final l$mutes = data['mutes'];
    result$data['mutes'] = (l$mutes as List<dynamic>)
        .map((e) => InputnotificationMutes_insert_input.fromJson((e as Map<String, dynamic>)))
        .toList();
    return VariablesMutationUpdateNotificationSettings._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  bool get enabled => (_$data['enabled'] as bool);

  int get cardDay => (_$data['cardDay'] as int);

  int get cardHour => (_$data['cardHour'] as int);

  List<InputnotificationMutes_insert_input> get mutes =>
      (_$data['mutes'] as List<InputnotificationMutes_insert_input>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$enabled = enabled;
    result$data['enabled'] = l$enabled;
    final l$cardDay = cardDay;
    result$data['cardDay'] = l$cardDay;
    final l$cardHour = cardHour;
    result$data['cardHour'] = l$cardHour;
    final l$mutes = mutes;
    result$data['mutes'] = l$mutes.map((e) => e.toJson()).toList();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateNotificationSettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$enabled = enabled;
    final lOther$enabled = other.enabled;
    if (l$enabled != lOther$enabled) {
      return false;
    }
    final l$cardDay = cardDay;
    final lOther$cardDay = other.cardDay;
    if (l$cardDay != lOther$cardDay) {
      return false;
    }
    final l$cardHour = cardHour;
    final lOther$cardHour = other.cardHour;
    if (l$cardHour != lOther$cardHour) {
      return false;
    }
    final l$mutes = mutes;
    final lOther$mutes = other.mutes;
    if (l$mutes.length != lOther$mutes.length) {
      return false;
    }
    for (int i = 0; i < l$mutes.length; i++) {
      final l$mutes$entry = l$mutes[i];
      final lOther$mutes$entry = lOther$mutes[i];
      if (l$mutes$entry != lOther$mutes$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$enabled = enabled;
    final l$cardDay = cardDay;
    final l$cardHour = cardHour;
    final l$mutes = mutes;
    return Object.hashAll([
      l$userId,
      l$enabled,
      l$cardDay,
      l$cardHour,
      Object.hashAll(l$mutes.map((v) => v)),
    ]);
  }
}

class MutationUpdateNotificationSettings {
  MutationUpdateNotificationSettings({
    this.updateNotificationSettings,
    this.deleteNotificationMutes,
    this.insertNotificationMutes,
    this.$__typename = 'mutation_root',
  });

  factory MutationUpdateNotificationSettings.fromJson(Map<String, dynamic> json) {
    final l$updateNotificationSettings = json['updateNotificationSettings'];
    final l$deleteNotificationMutes = json['deleteNotificationMutes'];
    final l$insertNotificationMutes = json['insertNotificationMutes'];
    final l$$__typename = json['__typename'];
    return MutationUpdateNotificationSettings(
      updateNotificationSettings: l$updateNotificationSettings == null
          ? null
          : MutationUpdateNotificationSettingsupdateNotificationSettings.fromJson(
              (l$updateNotificationSettings as Map<String, dynamic>),
            ),
      deleteNotificationMutes: l$deleteNotificationMutes == null
          ? null
          : MutationUpdateNotificationSettingsdeleteNotificationMutes.fromJson(
              (l$deleteNotificationMutes as Map<String, dynamic>),
            ),
      insertNotificationMutes: l$insertNotificationMutes == null
          ? null
          : MutationUpdateNotificationSettingsinsertNotificationMutes.fromJson(
              (l$insertNotificationMutes as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateNotificationSettingsupdateNotificationSettings? updateNotificationSettings;

  final MutationUpdateNotificationSettingsdeleteNotificationMutes? deleteNotificationMutes;

  final MutationUpdateNotificationSettingsinsertNotificationMutes? insertNotificationMutes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateNotificationSettings = updateNotificationSettings;
    _resultData['updateNotificationSettings'] = l$updateNotificationSettings?.toJson();
    final l$deleteNotificationMutes = deleteNotificationMutes;
    _resultData['deleteNotificationMutes'] = l$deleteNotificationMutes?.toJson();
    final l$insertNotificationMutes = insertNotificationMutes;
    _resultData['insertNotificationMutes'] = l$insertNotificationMutes?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateNotificationSettings = updateNotificationSettings;
    final l$deleteNotificationMutes = deleteNotificationMutes;
    final l$insertNotificationMutes = insertNotificationMutes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateNotificationSettings,
      l$deleteNotificationMutes,
      l$insertNotificationMutes,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateNotificationSettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateNotificationSettings = updateNotificationSettings;
    final lOther$updateNotificationSettings = other.updateNotificationSettings;
    if (l$updateNotificationSettings != lOther$updateNotificationSettings) {
      return false;
    }
    final l$deleteNotificationMutes = deleteNotificationMutes;
    final lOther$deleteNotificationMutes = other.deleteNotificationMutes;
    if (l$deleteNotificationMutes != lOther$deleteNotificationMutes) {
      return false;
    }
    final l$insertNotificationMutes = insertNotificationMutes;
    final lOther$insertNotificationMutes = other.insertNotificationMutes;
    if (l$insertNotificationMutes != lOther$insertNotificationMutes) {
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

const documentNodeMutationUpdateNotificationSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateNotificationSettings'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'enabled')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cardDay')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cardHour')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'mutes')),
          type: ListTypeNode(
            type: NamedTypeNode(
              name: NameNode(value: 'notificationMutes_insert_input'),
              isNonNull: true,
            ),
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
            name: NameNode(value: 'updateNotificationSettings'),
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
                            value: VariableNode(name: NameNode(value: 'userId')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'enabled'),
                      value: VariableNode(name: NameNode(value: 'enabled')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'cardDay'),
                      value: VariableNode(name: NameNode(value: 'cardDay')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'cardHour'),
                      value: VariableNode(name: NameNode(value: 'cardHour')),
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
            name: NameNode(value: 'deleteNotificationMutes'),
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
                            value: VariableNode(name: NameNode(value: 'userId')),
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
            name: NameNode(value: 'insertNotificationMutes'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'objects'),
                value: VariableNode(name: NameNode(value: 'mutes')),
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
MutationUpdateNotificationSettings _parserFnMutationUpdateNotificationSettings(
  Map<String, dynamic> data,
) => MutationUpdateNotificationSettings.fromJson(data);
typedef OnMutationCompletedMutationUpdateNotificationSettings = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateNotificationSettings?,
);

class OptionsMutationUpdateNotificationSettings
    extends graphql.MutationOptions<MutationUpdateNotificationSettings> {
  OptionsMutationUpdateNotificationSettings({
    String? operationName,
    required VariablesMutationUpdateNotificationSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateNotificationSettings? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateNotificationSettings? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateNotificationSettings>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateNotificationSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateNotificationSettings(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateNotificationSettings,
         parserFn: _parserFnMutationUpdateNotificationSettings,
       );

  final OnMutationCompletedMutationUpdateNotificationSettings? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateNotificationSettings
    extends graphql.WatchQueryOptions<MutationUpdateNotificationSettings> {
  WatchOptionsMutationUpdateNotificationSettings({
    String? operationName,
    required VariablesMutationUpdateNotificationSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateNotificationSettings? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateNotificationSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateNotificationSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateNotificationSettings,
       );
}

extension ClientExtensionMutationUpdateNotificationSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateNotificationSettings>> mutateUpdateNotificationSettings(
    OptionsMutationUpdateNotificationSettings options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateNotificationSettings>
  watchMutationUpdateNotificationSettings(WatchOptionsMutationUpdateNotificationSettings options) =>
      this.watchMutation(options);
}

class MutationUpdateNotificationSettingsupdateNotificationSettings {
  MutationUpdateNotificationSettingsupdateNotificationSettings({
    required this.affected_rows,
    this.$__typename = 'notificationSettings_mutation_response',
  });

  factory MutationUpdateNotificationSettingsupdateNotificationSettings.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateNotificationSettingsupdateNotificationSettings(
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
    if (other is! MutationUpdateNotificationSettingsupdateNotificationSettings ||
        runtimeType != other.runtimeType) {
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

class MutationUpdateNotificationSettingsdeleteNotificationMutes {
  MutationUpdateNotificationSettingsdeleteNotificationMutes({
    required this.affected_rows,
    this.$__typename = 'notificationMutes_mutation_response',
  });

  factory MutationUpdateNotificationSettingsdeleteNotificationMutes.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateNotificationSettingsdeleteNotificationMutes(
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
    if (other is! MutationUpdateNotificationSettingsdeleteNotificationMutes ||
        runtimeType != other.runtimeType) {
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

class MutationUpdateNotificationSettingsinsertNotificationMutes {
  MutationUpdateNotificationSettingsinsertNotificationMutes({
    required this.affected_rows,
    this.$__typename = 'notificationMutes_mutation_response',
  });

  factory MutationUpdateNotificationSettingsinsertNotificationMutes.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateNotificationSettingsinsertNotificationMutes(
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
    if (other is! MutationUpdateNotificationSettingsinsertNotificationMutes ||
        runtimeType != other.runtimeType) {
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
