// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMyNotificationSettings {
  factory VariablesQueryMyNotificationSettings({required String userId}) =>
      VariablesQueryMyNotificationSettings._({r'userId': userId});

  VariablesQueryMyNotificationSettings._(this._$data);

  factory VariablesQueryMyNotificationSettings.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryMyNotificationSettings._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryMyNotificationSettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

class QueryMyNotificationSettings {
  QueryMyNotificationSettings({
    this.notificationSettingsByPk,
    required this.notificationMutes,
    this.$__typename = 'query_root',
  });

  factory QueryMyNotificationSettings.fromJson(Map<String, dynamic> json) {
    final l$notificationSettingsByPk = json['notificationSettingsByPk'];
    final l$notificationMutes = json['notificationMutes'];
    final l$$__typename = json['__typename'];
    return QueryMyNotificationSettings(
      notificationSettingsByPk: l$notificationSettingsByPk == null
          ? null
          : QueryMyNotificationSettingsnotificationSettingsByPk.fromJson(
              (l$notificationSettingsByPk as Map<String, dynamic>),
            ),
      notificationMutes: (l$notificationMutes as List<dynamic>)
          .map(
            (e) =>
                QueryMyNotificationSettingsnotificationMutes.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryMyNotificationSettingsnotificationSettingsByPk? notificationSettingsByPk;

  final List<QueryMyNotificationSettingsnotificationMutes> notificationMutes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$notificationSettingsByPk = notificationSettingsByPk;
    _resultData['notificationSettingsByPk'] = l$notificationSettingsByPk?.toJson();
    final l$notificationMutes = notificationMutes;
    _resultData['notificationMutes'] = l$notificationMutes.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$notificationSettingsByPk = notificationSettingsByPk;
    final l$notificationMutes = notificationMutes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$notificationSettingsByPk,
      Object.hashAll(l$notificationMutes.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyNotificationSettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$notificationSettingsByPk = notificationSettingsByPk;
    final lOther$notificationSettingsByPk = other.notificationSettingsByPk;
    if (l$notificationSettingsByPk != lOther$notificationSettingsByPk) {
      return false;
    }
    final l$notificationMutes = notificationMutes;
    final lOther$notificationMutes = other.notificationMutes;
    if (l$notificationMutes.length != lOther$notificationMutes.length) {
      return false;
    }
    for (int i = 0; i < l$notificationMutes.length; i++) {
      final l$notificationMutes$entry = l$notificationMutes[i];
      final lOther$notificationMutes$entry = lOther$notificationMutes[i];
      if (l$notificationMutes$entry != lOther$notificationMutes$entry) {
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

const documentNodeQueryMyNotificationSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyNotificationSettings'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'notificationSettingsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'userId'),
                value: VariableNode(name: NameNode(value: 'userId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'enabled'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'cardDay'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'cardHour'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'dailyMax'),
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
            name: NameNode(value: 'notificationMutes'),
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
QueryMyNotificationSettings _parserFnQueryMyNotificationSettings(Map<String, dynamic> data) =>
    QueryMyNotificationSettings.fromJson(data);
typedef OnQueryCompleteQueryMyNotificationSettings = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyNotificationSettings?,
);

class OptionsQueryMyNotificationSettings extends graphql.QueryOptions<QueryMyNotificationSettings> {
  OptionsQueryMyNotificationSettings({
    String? operationName,
    required VariablesQueryMyNotificationSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyNotificationSettings? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyNotificationSettings? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyNotificationSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(
                 data,
                 data == null ? null : _parserFnQueryMyNotificationSettings(data),
               ),
         onError: onError,
         document: documentNodeQueryMyNotificationSettings,
         parserFn: _parserFnQueryMyNotificationSettings,
       );

  final OnQueryCompleteQueryMyNotificationSettings? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyNotificationSettings
    extends graphql.WatchQueryOptions<QueryMyNotificationSettings> {
  WatchOptionsQueryMyNotificationSettings({
    String? operationName,
    required VariablesQueryMyNotificationSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyNotificationSettings? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyNotificationSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyNotificationSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyNotificationSettings,
       );
}

class FetchMoreOptionsQueryMyNotificationSettings extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyNotificationSettings({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMyNotificationSettings variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMyNotificationSettings,
       );
}

extension ClientExtensionQueryMyNotificationSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyNotificationSettings>> queryMyNotificationSettings(
    OptionsQueryMyNotificationSettings options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryMyNotificationSettings> watchQueryMyNotificationSettings(
    WatchOptionsQueryMyNotificationSettings options,
  ) => this.watchQuery(options);

  void writeQueryMyNotificationSettings({
    required QueryMyNotificationSettings data,
    required VariablesQueryMyNotificationSettings variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMyNotificationSettings),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyNotificationSettings? readQueryMyNotificationSettings({
    required VariablesQueryMyNotificationSettings variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMyNotificationSettings),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyNotificationSettings.fromJson(result);
  }
}

class QueryMyNotificationSettingsnotificationSettingsByPk {
  QueryMyNotificationSettingsnotificationSettingsByPk({
    required this.enabled,
    required this.cardDay,
    required this.cardHour,
    required this.dailyMax,
    this.$__typename = 'notificationSettings',
  });

  factory QueryMyNotificationSettingsnotificationSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$enabled = json['enabled'];
    final l$cardDay = json['cardDay'];
    final l$cardHour = json['cardHour'];
    final l$dailyMax = json['dailyMax'];
    final l$$__typename = json['__typename'];
    return QueryMyNotificationSettingsnotificationSettingsByPk(
      enabled: (l$enabled as bool),
      cardDay: (l$cardDay as int),
      cardHour: (l$cardHour as int),
      dailyMax: (l$dailyMax as int),
      $__typename: (l$$__typename as String),
    );
  }

  final bool enabled;

  final int cardDay;

  final int cardHour;

  final int dailyMax;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$enabled = enabled;
    _resultData['enabled'] = l$enabled;
    final l$cardDay = cardDay;
    _resultData['cardDay'] = l$cardDay;
    final l$cardHour = cardHour;
    _resultData['cardHour'] = l$cardHour;
    final l$dailyMax = dailyMax;
    _resultData['dailyMax'] = l$dailyMax;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$enabled = enabled;
    final l$cardDay = cardDay;
    final l$cardHour = cardHour;
    final l$dailyMax = dailyMax;
    final l$$__typename = $__typename;
    return Object.hashAll([l$enabled, l$cardDay, l$cardHour, l$dailyMax, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyNotificationSettingsnotificationSettingsByPk ||
        runtimeType != other.runtimeType) {
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
    final l$dailyMax = dailyMax;
    final lOther$dailyMax = other.dailyMax;
    if (l$dailyMax != lOther$dailyMax) {
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

class QueryMyNotificationSettingsnotificationMutes {
  QueryMyNotificationSettingsnotificationMutes({
    required this.type,
    this.$__typename = 'notificationMutes',
  });

  factory QueryMyNotificationSettingsnotificationMutes.fromJson(Map<String, dynamic> json) {
    final l$type = json['type'];
    final l$$__typename = json['__typename'];
    return QueryMyNotificationSettingsnotificationMutes(
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
    if (other is! QueryMyNotificationSettingsnotificationMutes ||
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
