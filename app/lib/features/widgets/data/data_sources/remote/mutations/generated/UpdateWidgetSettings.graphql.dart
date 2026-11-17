// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateWidgetSettings {
  factory VariablesMutationUpdateWidgetSettings({
    required String userId,
    required bool showNames,
    required bool allowPartnerNotes,
  }) => VariablesMutationUpdateWidgetSettings._({
    r'userId': userId,
    r'showNames': showNames,
    r'allowPartnerNotes': allowPartnerNotes,
  });

  VariablesMutationUpdateWidgetSettings._(this._$data);

  factory VariablesMutationUpdateWidgetSettings.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$showNames = data['showNames'];
    result$data['showNames'] = (l$showNames as bool);
    final l$allowPartnerNotes = data['allowPartnerNotes'];
    result$data['allowPartnerNotes'] = (l$allowPartnerNotes as bool);
    return VariablesMutationUpdateWidgetSettings._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  bool get showNames => (_$data['showNames'] as bool);

  bool get allowPartnerNotes => (_$data['allowPartnerNotes'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$showNames = showNames;
    result$data['showNames'] = l$showNames;
    final l$allowPartnerNotes = allowPartnerNotes;
    result$data['allowPartnerNotes'] = l$allowPartnerNotes;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateWidgetSettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$showNames = showNames;
    final lOther$showNames = other.showNames;
    if (l$showNames != lOther$showNames) {
      return false;
    }
    final l$allowPartnerNotes = allowPartnerNotes;
    final lOther$allowPartnerNotes = other.allowPartnerNotes;
    if (l$allowPartnerNotes != lOther$allowPartnerNotes) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$showNames = showNames;
    final l$allowPartnerNotes = allowPartnerNotes;
    return Object.hashAll([l$userId, l$showNames, l$allowPartnerNotes]);
  }
}

class MutationUpdateWidgetSettings {
  MutationUpdateWidgetSettings({this.updateUserSettings, this.$__typename = 'mutation_root'});

  factory MutationUpdateWidgetSettings.fromJson(Map<String, dynamic> json) {
    final l$updateUserSettings = json['updateUserSettings'];
    final l$$__typename = json['__typename'];
    return MutationUpdateWidgetSettings(
      updateUserSettings: l$updateUserSettings == null
          ? null
          : MutationUpdateWidgetSettingsupdateUserSettings.fromJson(
              (l$updateUserSettings as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateWidgetSettingsupdateUserSettings? updateUserSettings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateUserSettings = updateUserSettings;
    _resultData['updateUserSettings'] = l$updateUserSettings?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateUserSettings = updateUserSettings;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateUserSettings, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateWidgetSettings || runtimeType != other.runtimeType) {
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

const documentNodeMutationUpdateWidgetSettings = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateWidgetSettings'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'showNames')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'allowPartnerNotes')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
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
                      name: NameNode(value: 'widgetShowNames'),
                      value: VariableNode(name: NameNode(value: 'showNames')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'widgetAllowPartnerNotes'),
                      value: VariableNode(name: NameNode(value: 'allowPartnerNotes')),
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
MutationUpdateWidgetSettings _parserFnMutationUpdateWidgetSettings(Map<String, dynamic> data) =>
    MutationUpdateWidgetSettings.fromJson(data);
typedef OnMutationCompletedMutationUpdateWidgetSettings = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateWidgetSettings?,
);

class OptionsMutationUpdateWidgetSettings
    extends graphql.MutationOptions<MutationUpdateWidgetSettings> {
  OptionsMutationUpdateWidgetSettings({
    String? operationName,
    required VariablesMutationUpdateWidgetSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateWidgetSettings? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateWidgetSettings? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateWidgetSettings>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateWidgetSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateWidgetSettings(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateWidgetSettings,
         parserFn: _parserFnMutationUpdateWidgetSettings,
       );

  final OnMutationCompletedMutationUpdateWidgetSettings? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateWidgetSettings
    extends graphql.WatchQueryOptions<MutationUpdateWidgetSettings> {
  WatchOptionsMutationUpdateWidgetSettings({
    String? operationName,
    required VariablesMutationUpdateWidgetSettings variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateWidgetSettings? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateWidgetSettings',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateWidgetSettings,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateWidgetSettings,
       );
}

extension ClientExtensionMutationUpdateWidgetSettings on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateWidgetSettings>> mutateUpdateWidgetSettings(
    OptionsMutationUpdateWidgetSettings options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateWidgetSettings> watchMutationUpdateWidgetSettings(
    WatchOptionsMutationUpdateWidgetSettings options,
  ) => this.watchMutation(options);
}

class MutationUpdateWidgetSettingsupdateUserSettings {
  MutationUpdateWidgetSettingsupdateUserSettings({
    required this.affected_rows,
    this.$__typename = 'userSettings_mutation_response',
  });

  factory MutationUpdateWidgetSettingsupdateUserSettings.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateWidgetSettingsupdateUserSettings(
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
    if (other is! MutationUpdateWidgetSettingsupdateUserSettings ||
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
