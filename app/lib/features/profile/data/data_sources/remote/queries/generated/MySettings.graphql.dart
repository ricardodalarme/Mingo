// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';
import '../../fragments/generated/SettingsFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMySettings {
  factory VariablesQueryMySettings({required String userId}) =>
      VariablesQueryMySettings._({r'userId': userId});

  VariablesQueryMySettings._(this._$data);

  factory VariablesQueryMySettings.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryMySettings._(result$data);
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
    if (other is! VariablesQueryMySettings || runtimeType != other.runtimeType) {
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

class QueryMySettings {
  QueryMySettings({this.userSettingsByPk, this.$__typename = 'query_root'});

  factory QueryMySettings.fromJson(Map<String, dynamic> json) {
    final l$userSettingsByPk = json['userSettingsByPk'];
    final l$$__typename = json['__typename'];
    return QueryMySettings(
      userSettingsByPk: l$userSettingsByPk == null
          ? null
          : QueryMySettingsuserSettingsByPk.fromJson((l$userSettingsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryMySettingsuserSettingsByPk? userSettingsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userSettingsByPk = userSettingsByPk;
    _resultData['userSettingsByPk'] = l$userSettingsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userSettingsByPk = userSettingsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userSettingsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMySettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userSettingsByPk = userSettingsByPk;
    final lOther$userSettingsByPk = other.userSettingsByPk;
    if (l$userSettingsByPk != lOther$userSettingsByPk) {
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

const documentNodeQueryMySettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MySettings'),
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
            name: NameNode(value: 'userSettingsByPk'),
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
                FragmentSpreadNode(
                  name: NameNode(value: 'SettingsFragment'),
                  directives: [],
                ),
                FieldNode(
                  name: NameNode(value: 'profile'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'timeZone'),
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
    fragmentDefinitionSettingsFragment,
  ],
);
QueryMySettings _parserFnQueryMySettings(Map<String, dynamic> data) =>
    QueryMySettings.fromJson(data);
typedef OnQueryCompleteQueryMySettings = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMySettings?,
);

class OptionsQueryMySettings extends graphql.QueryOptions<QueryMySettings> {
  OptionsQueryMySettings({
    String? operationName,
    required VariablesQueryMySettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMySettings? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMySettings? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MySettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMySettings(data)),
         onError: onError,
         document: documentNodeQueryMySettings,
         parserFn: _parserFnQueryMySettings,
       );

  final OnQueryCompleteQueryMySettings? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMySettings extends graphql.WatchQueryOptions<QueryMySettings> {
  WatchOptionsQueryMySettings({
    String? operationName,
    required VariablesQueryMySettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMySettings? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MySettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMySettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMySettings,
       );
}

class FetchMoreOptionsQueryMySettings extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMySettings({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMySettings variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMySettings,
       );
}

extension ClientExtensionQueryMySettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMySettings>> queryMySettings(
    OptionsQueryMySettings options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryMySettings> watchQueryMySettings(
    WatchOptionsQueryMySettings options,
  ) => this.watchQuery(options);

  void writeQueryMySettings({
    required QueryMySettings data,
    required VariablesQueryMySettings variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMySettings),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMySettings? readQueryMySettings({
    required VariablesQueryMySettings variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMySettings),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMySettings.fromJson(result);
  }
}

class QueryMySettingsuserSettingsByPk implements FragmentSettingsFragment {
  QueryMySettingsuserSettingsByPk({
    required this.userId,
    required this.theme,
    this.partnerName,
    this.partnerPronouns,
    this.partnerIntent,
    this.togetherSince,
    required this.relationshipStatus,
    this.onboardedAt,
    required this.shareReadReceipts,
    this.phase,
    required this.goals,
    required this.locale,
    this.$__typename = 'userSettings',
    required this.profile,
  });

  factory QueryMySettingsuserSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$theme = json['theme'];
    final l$partnerName = json['partnerName'];
    final l$partnerPronouns = json['partnerPronouns'];
    final l$partnerIntent = json['partnerIntent'];
    final l$togetherSince = json['togetherSince'];
    final l$relationshipStatus = json['relationshipStatus'];
    final l$onboardedAt = json['onboardedAt'];
    final l$shareReadReceipts = json['shareReadReceipts'];
    final l$phase = json['phase'];
    final l$goals = json['goals'];
    final l$locale = json['locale'];
    final l$$__typename = json['__typename'];
    final l$profile = json['profile'];
    return QueryMySettingsuserSettingsByPk(
      userId: (l$userId as String),
      theme: fromJsonEnumAppTheme_enum((l$theme as String)),
      partnerName: (l$partnerName as String?),
      partnerPronouns: l$partnerPronouns == null
          ? null
          : fromJsonEnumPronoun_enum((l$partnerPronouns as String)),
      partnerIntent: l$partnerIntent == null
          ? null
          : fromJsonEnumPartnerIntent_enum((l$partnerIntent as String)),
      togetherSince: l$togetherSince == null ? null : DateTime.parse((l$togetherSince as String)),
      relationshipStatus: fromJsonEnumRelationshipStatus_enum((l$relationshipStatus as String)),
      onboardedAt: l$onboardedAt == null ? null : DateTime.parse((l$onboardedAt as String)),
      shareReadReceipts: (l$shareReadReceipts as bool),
      phase: l$phase == null ? null : fromJsonEnumRelationshipPhase_enum((l$phase as String)),
      goals: (l$goals as List<dynamic>).map((e) => (e as String)).toList(),
      locale: (l$locale as String),
      $__typename: (l$$__typename as String),
      profile: QueryMySettingsuserSettingsByPkprofile.fromJson((l$profile as Map<String, dynamic>)),
    );
  }

  final String userId;

  final EnumAppTheme_enum theme;

  final String? partnerName;

  final EnumPronoun_enum? partnerPronouns;

  final EnumPartnerIntent_enum? partnerIntent;

  final DateTime? togetherSince;

  final EnumRelationshipStatus_enum relationshipStatus;

  final DateTime? onboardedAt;

  final bool shareReadReceipts;

  final EnumRelationshipPhase_enum? phase;

  final List<String> goals;

  final String locale;

  final String $__typename;

  final QueryMySettingsuserSettingsByPkprofile profile;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$theme = theme;
    _resultData['theme'] = toJsonEnumAppTheme_enum(l$theme);
    final l$partnerName = partnerName;
    _resultData['partnerName'] = l$partnerName;
    final l$partnerPronouns = partnerPronouns;
    _resultData['partnerPronouns'] = l$partnerPronouns == null
        ? null
        : toJsonEnumPronoun_enum(l$partnerPronouns);
    final l$partnerIntent = partnerIntent;
    _resultData['partnerIntent'] = l$partnerIntent == null
        ? null
        : toJsonEnumPartnerIntent_enum(l$partnerIntent);
    final l$togetherSince = togetherSince;
    _resultData['togetherSince'] = l$togetherSince == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$togetherSince);
    final l$relationshipStatus = relationshipStatus;
    _resultData['relationshipStatus'] = toJsonEnumRelationshipStatus_enum(l$relationshipStatus);
    final l$onboardedAt = onboardedAt;
    _resultData['onboardedAt'] = l$onboardedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$onboardedAt);
    final l$shareReadReceipts = shareReadReceipts;
    _resultData['shareReadReceipts'] = l$shareReadReceipts;
    final l$phase = phase;
    _resultData['phase'] = l$phase == null ? null : toJsonEnumRelationshipPhase_enum(l$phase);
    final l$goals = goals;
    _resultData['goals'] = l$goals.map((e) => e).toList();
    final l$locale = locale;
    _resultData['locale'] = l$locale;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$profile = profile;
    _resultData['profile'] = l$profile.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$theme = theme;
    final l$partnerName = partnerName;
    final l$partnerPronouns = partnerPronouns;
    final l$partnerIntent = partnerIntent;
    final l$togetherSince = togetherSince;
    final l$relationshipStatus = relationshipStatus;
    final l$onboardedAt = onboardedAt;
    final l$shareReadReceipts = shareReadReceipts;
    final l$phase = phase;
    final l$goals = goals;
    final l$locale = locale;
    final l$$__typename = $__typename;
    final l$profile = profile;
    return Object.hashAll([
      l$userId,
      l$theme,
      l$partnerName,
      l$partnerPronouns,
      l$partnerIntent,
      l$togetherSince,
      l$relationshipStatus,
      l$onboardedAt,
      l$shareReadReceipts,
      l$phase,
      Object.hashAll(l$goals.map((v) => v)),
      l$locale,
      l$$__typename,
      l$profile,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMySettingsuserSettingsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$theme = theme;
    final lOther$theme = other.theme;
    if (l$theme != lOther$theme) {
      return false;
    }
    final l$partnerName = partnerName;
    final lOther$partnerName = other.partnerName;
    if (l$partnerName != lOther$partnerName) {
      return false;
    }
    final l$partnerPronouns = partnerPronouns;
    final lOther$partnerPronouns = other.partnerPronouns;
    if (l$partnerPronouns != lOther$partnerPronouns) {
      return false;
    }
    final l$partnerIntent = partnerIntent;
    final lOther$partnerIntent = other.partnerIntent;
    if (l$partnerIntent != lOther$partnerIntent) {
      return false;
    }
    final l$togetherSince = togetherSince;
    final lOther$togetherSince = other.togetherSince;
    if (l$togetherSince != lOther$togetherSince) {
      return false;
    }
    final l$relationshipStatus = relationshipStatus;
    final lOther$relationshipStatus = other.relationshipStatus;
    if (l$relationshipStatus != lOther$relationshipStatus) {
      return false;
    }
    final l$onboardedAt = onboardedAt;
    final lOther$onboardedAt = other.onboardedAt;
    if (l$onboardedAt != lOther$onboardedAt) {
      return false;
    }
    final l$shareReadReceipts = shareReadReceipts;
    final lOther$shareReadReceipts = other.shareReadReceipts;
    if (l$shareReadReceipts != lOther$shareReadReceipts) {
      return false;
    }
    final l$phase = phase;
    final lOther$phase = other.phase;
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
    final l$locale = locale;
    final lOther$locale = other.locale;
    if (l$locale != lOther$locale) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    final l$profile = profile;
    final lOther$profile = other.profile;
    if (l$profile != lOther$profile) {
      return false;
    }
    return true;
  }
}

class QueryMySettingsuserSettingsByPkprofile {
  QueryMySettingsuserSettingsByPkprofile({required this.timeZone, this.$__typename = 'profiles'});

  factory QueryMySettingsuserSettingsByPkprofile.fromJson(Map<String, dynamic> json) {
    final l$timeZone = json['timeZone'];
    final l$$__typename = json['__typename'];
    return QueryMySettingsuserSettingsByPkprofile(
      timeZone: (l$timeZone as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String timeZone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$timeZone = timeZone;
    _resultData['timeZone'] = l$timeZone;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$timeZone = timeZone;
    final l$$__typename = $__typename;
    return Object.hashAll([l$timeZone, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMySettingsuserSettingsByPkprofile || runtimeType != other.runtimeType) {
      return false;
    }
    final l$timeZone = timeZone;
    final lOther$timeZone = other.timeZone;
    if (l$timeZone != lOther$timeZone) {
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
