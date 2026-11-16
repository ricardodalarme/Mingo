// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSaveProfileSetup {
  factory VariablesMutationSaveProfileSetup({
    required String profileId,
    required String displayName,
    EnumPronoun_enum? pronouns,
    required EnumAppTheme_enum theme,
    String? partnerName,
    EnumPronoun_enum? partnerPronouns,
    DateTime? togetherSince,
    required DateTime onboardedAt,
  }) => VariablesMutationSaveProfileSetup._({
    r'profileId': profileId,
    r'displayName': displayName,
    if (pronouns != null) r'pronouns': pronouns,
    r'theme': theme,
    if (partnerName != null) r'partnerName': partnerName,
    if (partnerPronouns != null) r'partnerPronouns': partnerPronouns,
    if (togetherSince != null) r'togetherSince': togetherSince,
    r'onboardedAt': onboardedAt,
  });

  VariablesMutationSaveProfileSetup._(this._$data);

  factory VariablesMutationSaveProfileSetup.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$profileId = data['profileId'];
    result$data['profileId'] = (l$profileId as String);
    final l$displayName = data['displayName'];
    result$data['displayName'] = (l$displayName as String);
    if (data.containsKey('pronouns')) {
      final l$pronouns = data['pronouns'];
      result$data['pronouns'] = l$pronouns == null
          ? null
          : fromJsonEnumPronoun_enum((l$pronouns as String));
    }
    final l$theme = data['theme'];
    result$data['theme'] = fromJsonEnumAppTheme_enum((l$theme as String));
    if (data.containsKey('partnerName')) {
      final l$partnerName = data['partnerName'];
      result$data['partnerName'] = (l$partnerName as String?);
    }
    if (data.containsKey('partnerPronouns')) {
      final l$partnerPronouns = data['partnerPronouns'];
      result$data['partnerPronouns'] = l$partnerPronouns == null
          ? null
          : fromJsonEnumPronoun_enum((l$partnerPronouns as String));
    }
    if (data.containsKey('togetherSince')) {
      final l$togetherSince = data['togetherSince'];
      result$data['togetherSince'] = l$togetherSince == null
          ? null
          : DateTime.parse((l$togetherSince as String));
    }
    final l$onboardedAt = data['onboardedAt'];
    result$data['onboardedAt'] = DateTime.parse((l$onboardedAt as String));
    return VariablesMutationSaveProfileSetup._(result$data);
  }

  Map<String, dynamic> _$data;

  String get profileId => (_$data['profileId'] as String);

  String get displayName => (_$data['displayName'] as String);

  EnumPronoun_enum? get pronouns => (_$data['pronouns'] as EnumPronoun_enum?);

  EnumAppTheme_enum get theme => (_$data['theme'] as EnumAppTheme_enum);

  String? get partnerName => (_$data['partnerName'] as String?);

  EnumPronoun_enum? get partnerPronouns => (_$data['partnerPronouns'] as EnumPronoun_enum?);

  DateTime? get togetherSince => (_$data['togetherSince'] as DateTime?);

  DateTime get onboardedAt => (_$data['onboardedAt'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$profileId = profileId;
    result$data['profileId'] = l$profileId;
    final l$displayName = displayName;
    result$data['displayName'] = l$displayName;
    if (_$data.containsKey('pronouns')) {
      final l$pronouns = pronouns;
      result$data['pronouns'] = l$pronouns == null ? null : toJsonEnumPronoun_enum(l$pronouns);
    }
    final l$theme = theme;
    result$data['theme'] = toJsonEnumAppTheme_enum(l$theme);
    if (_$data.containsKey('partnerName')) {
      final l$partnerName = partnerName;
      result$data['partnerName'] = l$partnerName;
    }
    if (_$data.containsKey('partnerPronouns')) {
      final l$partnerPronouns = partnerPronouns;
      result$data['partnerPronouns'] = l$partnerPronouns == null
          ? null
          : toJsonEnumPronoun_enum(l$partnerPronouns);
    }
    if (_$data.containsKey('togetherSince')) {
      final l$togetherSince = togetherSince;
      result$data['togetherSince'] = l$togetherSince == null
          ? null
          : ((v) => v.toIso8601String().substring(0, 10))(l$togetherSince);
    }
    final l$onboardedAt = onboardedAt;
    result$data['onboardedAt'] = ((v) => v.toUtc().toIso8601String())(l$onboardedAt);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSaveProfileSetup || runtimeType != other.runtimeType) {
      return false;
    }
    final l$profileId = profileId;
    final lOther$profileId = other.profileId;
    if (l$profileId != lOther$profileId) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$pronouns = pronouns;
    final lOther$pronouns = other.pronouns;
    if (_$data.containsKey('pronouns') != other._$data.containsKey('pronouns')) {
      return false;
    }
    if (l$pronouns != lOther$pronouns) {
      return false;
    }
    final l$theme = theme;
    final lOther$theme = other.theme;
    if (l$theme != lOther$theme) {
      return false;
    }
    final l$partnerName = partnerName;
    final lOther$partnerName = other.partnerName;
    if (_$data.containsKey('partnerName') != other._$data.containsKey('partnerName')) {
      return false;
    }
    if (l$partnerName != lOther$partnerName) {
      return false;
    }
    final l$partnerPronouns = partnerPronouns;
    final lOther$partnerPronouns = other.partnerPronouns;
    if (_$data.containsKey('partnerPronouns') != other._$data.containsKey('partnerPronouns')) {
      return false;
    }
    if (l$partnerPronouns != lOther$partnerPronouns) {
      return false;
    }
    final l$togetherSince = togetherSince;
    final lOther$togetherSince = other.togetherSince;
    if (_$data.containsKey('togetherSince') != other._$data.containsKey('togetherSince')) {
      return false;
    }
    if (l$togetherSince != lOther$togetherSince) {
      return false;
    }
    final l$onboardedAt = onboardedAt;
    final lOther$onboardedAt = other.onboardedAt;
    if (l$onboardedAt != lOther$onboardedAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$profileId = profileId;
    final l$displayName = displayName;
    final l$pronouns = pronouns;
    final l$theme = theme;
    final l$partnerName = partnerName;
    final l$partnerPronouns = partnerPronouns;
    final l$togetherSince = togetherSince;
    final l$onboardedAt = onboardedAt;
    return Object.hashAll([
      l$profileId,
      l$displayName,
      _$data.containsKey('pronouns') ? l$pronouns : const {},
      l$theme,
      _$data.containsKey('partnerName') ? l$partnerName : const {},
      _$data.containsKey('partnerPronouns') ? l$partnerPronouns : const {},
      _$data.containsKey('togetherSince') ? l$togetherSince : const {},
      l$onboardedAt,
    ]);
  }
}

class MutationSaveProfileSetup {
  MutationSaveProfileSetup({
    this.updateProfiles,
    this.updateUserSettings,
    this.$__typename = 'mutation_root',
  });

  factory MutationSaveProfileSetup.fromJson(Map<String, dynamic> json) {
    final l$updateProfiles = json['updateProfiles'];
    final l$updateUserSettings = json['updateUserSettings'];
    final l$$__typename = json['__typename'];
    return MutationSaveProfileSetup(
      updateProfiles: l$updateProfiles == null
          ? null
          : MutationSaveProfileSetupupdateProfiles.fromJson(
              (l$updateProfiles as Map<String, dynamic>),
            ),
      updateUserSettings: l$updateUserSettings == null
          ? null
          : MutationSaveProfileSetupupdateUserSettings.fromJson(
              (l$updateUserSettings as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSaveProfileSetupupdateProfiles? updateProfiles;

  final MutationSaveProfileSetupupdateUserSettings? updateUserSettings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateProfiles = updateProfiles;
    _resultData['updateProfiles'] = l$updateProfiles?.toJson();
    final l$updateUserSettings = updateUserSettings;
    _resultData['updateUserSettings'] = l$updateUserSettings?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateProfiles = updateProfiles;
    final l$updateUserSettings = updateUserSettings;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateProfiles, l$updateUserSettings, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSaveProfileSetup || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateProfiles = updateProfiles;
    final lOther$updateProfiles = other.updateProfiles;
    if (l$updateProfiles != lOther$updateProfiles) {
      return false;
    }
    final l$updateUserSettings = updateUserSettings;
    final lOther$updateUserSettings = other.updateUserSettings;
    if (l$updateUserSettings != lOther$updateUserSettings) {
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

const documentNodeMutationSaveProfileSetup = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SaveProfileSetup'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'profileId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'displayName')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'pronouns')),
          type: NamedTypeNode(name: NameNode(value: 'Pronoun_enum'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'theme')),
          type: NamedTypeNode(name: NameNode(value: 'AppTheme_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'partnerName')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'partnerPronouns')),
          type: NamedTypeNode(name: NameNode(value: 'Pronoun_enum'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'togetherSince')),
          type: NamedTypeNode(name: NameNode(value: 'date'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'onboardedAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateProfiles'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
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
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'displayName'),
                      value: VariableNode(name: NameNode(value: 'displayName')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'pronouns'),
                      value: VariableNode(name: NameNode(value: 'pronouns')),
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
            name: NameNode(value: 'updateUserSettings'),
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
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'theme'),
                      value: VariableNode(name: NameNode(value: 'theme')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'partnerName'),
                      value: VariableNode(name: NameNode(value: 'partnerName')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'partnerPronouns'),
                      value: VariableNode(name: NameNode(value: 'partnerPronouns')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'togetherSince'),
                      value: VariableNode(name: NameNode(value: 'togetherSince')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'onboardedAt'),
                      value: VariableNode(name: NameNode(value: 'onboardedAt')),
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
MutationSaveProfileSetup _parserFnMutationSaveProfileSetup(Map<String, dynamic> data) =>
    MutationSaveProfileSetup.fromJson(data);
typedef OnMutationCompletedMutationSaveProfileSetup = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSaveProfileSetup?,
);

class OptionsMutationSaveProfileSetup extends graphql.MutationOptions<MutationSaveProfileSetup> {
  OptionsMutationSaveProfileSetup({
    String? operationName,
    required VariablesMutationSaveProfileSetup variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSaveProfileSetup? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSaveProfileSetup? onCompleted,
    graphql.OnMutationUpdate<MutationSaveProfileSetup>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SaveProfileSetup',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSaveProfileSetup(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSaveProfileSetup,
         parserFn: _parserFnMutationSaveProfileSetup,
       );

  final OnMutationCompletedMutationSaveProfileSetup? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSaveProfileSetup
    extends graphql.WatchQueryOptions<MutationSaveProfileSetup> {
  WatchOptionsMutationSaveProfileSetup({
    String? operationName,
    required VariablesMutationSaveProfileSetup variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSaveProfileSetup? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SaveProfileSetup',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSaveProfileSetup,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSaveProfileSetup,
       );
}

extension ClientExtensionMutationSaveProfileSetup on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSaveProfileSetup>> mutateSaveProfileSetup(
    OptionsMutationSaveProfileSetup options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSaveProfileSetup> watchMutationSaveProfileSetup(
    WatchOptionsMutationSaveProfileSetup options,
  ) => this.watchMutation(options);
}

class MutationSaveProfileSetupupdateProfiles {
  MutationSaveProfileSetupupdateProfiles({
    required this.affected_rows,
    this.$__typename = 'profiles_mutation_response',
  });

  factory MutationSaveProfileSetupupdateProfiles.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationSaveProfileSetupupdateProfiles(
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
    if (other is! MutationSaveProfileSetupupdateProfiles || runtimeType != other.runtimeType) {
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

class MutationSaveProfileSetupupdateUserSettings {
  MutationSaveProfileSetupupdateUserSettings({
    required this.affected_rows,
    this.$__typename = 'userSettings_mutation_response',
  });

  factory MutationSaveProfileSetupupdateUserSettings.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationSaveProfileSetupupdateUserSettings(
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
    if (other is! MutationSaveProfileSetupupdateUserSettings || runtimeType != other.runtimeType) {
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
