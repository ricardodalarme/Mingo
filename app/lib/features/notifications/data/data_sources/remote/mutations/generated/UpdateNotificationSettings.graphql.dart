// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:network/network.dart';

class VariablesMutationUpdateNotificationSettings {
  factory VariablesMutationUpdateNotificationSettings({
    required String userId,
    required bool enabled,
    required int cardDay,
    required int cardHour,
    required dynamic mutes,
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
    result$data['mutes'] = decodeJsonb(l$mutes);
    return VariablesMutationUpdateNotificationSettings._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  bool get enabled => (_$data['enabled'] as bool);

  int get cardDay => (_$data['cardDay'] as int);

  int get cardHour => (_$data['cardHour'] as int);

  dynamic get mutes => (_$data['mutes'] as dynamic);

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
    result$data['mutes'] = encodeJsonb(l$mutes);
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
    if (l$mutes != lOther$mutes) {
      return false;
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
    return Object.hashAll([l$userId, l$enabled, l$cardDay, l$cardHour, l$mutes]);
  }
}

class MutationUpdateNotificationSettings {
  MutationUpdateNotificationSettings({
    this.updateNotificationSettings,
    required this.setNotificationMutes,
    this.$__typename = 'mutation_root',
  });

  factory MutationUpdateNotificationSettings.fromJson(Map<String, dynamic> json) {
    final l$updateNotificationSettings = json['updateNotificationSettings'];
    final l$setNotificationMutes = json['setNotificationMutes'];
    final l$$__typename = json['__typename'];
    return MutationUpdateNotificationSettings(
      updateNotificationSettings: l$updateNotificationSettings == null
          ? null
          : MutationUpdateNotificationSettingsupdateNotificationSettings.fromJson(
              (l$updateNotificationSettings as Map<String, dynamic>),
            ),
      setNotificationMutes: (l$setNotificationMutes as List<dynamic>)
          .map(
            (e) => MutationUpdateNotificationSettingssetNotificationMutes.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateNotificationSettingsupdateNotificationSettings? updateNotificationSettings;

  final List<MutationUpdateNotificationSettingssetNotificationMutes> setNotificationMutes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateNotificationSettings = updateNotificationSettings;
    _resultData['updateNotificationSettings'] = l$updateNotificationSettings?.toJson();
    final l$setNotificationMutes = setNotificationMutes;
    _resultData['setNotificationMutes'] = l$setNotificationMutes.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateNotificationSettings = updateNotificationSettings;
    final l$setNotificationMutes = setNotificationMutes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateNotificationSettings,
      Object.hashAll(l$setNotificationMutes.map((v) => v)),
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
    final l$setNotificationMutes = setNotificationMutes;
    final lOther$setNotificationMutes = other.setNotificationMutes;
    if (l$setNotificationMutes.length != lOther$setNotificationMutes.length) {
      return false;
    }
    for (int i = 0; i < l$setNotificationMutes.length; i++) {
      final l$setNotificationMutes$entry = l$setNotificationMutes[i];
      final lOther$setNotificationMutes$entry = lOther$setNotificationMutes[i];
      if (l$setNotificationMutes$entry != lOther$setNotificationMutes$entry) {
        return false;
      }
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
          type: NamedTypeNode(name: NameNode(value: 'jsonb'), isNonNull: true),
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
            name: NameNode(value: 'setNotificationMutes'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'types'),
                      value: VariableNode(name: NameNode(value: 'mutes')),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'type'),
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

class MutationUpdateNotificationSettingssetNotificationMutes {
  MutationUpdateNotificationSettingssetNotificationMutes({
    required this.type,
    this.$__typename = 'notificationMutes',
  });

  factory MutationUpdateNotificationSettingssetNotificationMutes.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$type = json['type'];
    final l$$__typename = json['__typename'];
    return MutationUpdateNotificationSettingssetNotificationMutes(
      type: fromJsonEnumNotificationType_enum((l$type as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumNotificationType_enum type;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$type = type;
    _resultData['type'] = toJsonEnumNotificationType_enum(l$type);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$type = type;
    final l$$__typename = $__typename;
    return Object.hashAll([l$type, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateNotificationSettingssetNotificationMutes ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
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
