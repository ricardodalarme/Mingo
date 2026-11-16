// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSetSpiceEnabled {
  factory VariablesMutationSetSpiceEnabled({required String userId, required bool enabled}) =>
      VariablesMutationSetSpiceEnabled._({r'userId': userId, r'enabled': enabled});

  VariablesMutationSetSpiceEnabled._(this._$data);

  factory VariablesMutationSetSpiceEnabled.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$enabled = data['enabled'];
    result$data['enabled'] = (l$enabled as bool);
    return VariablesMutationSetSpiceEnabled._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  bool get enabled => (_$data['enabled'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$enabled = enabled;
    result$data['enabled'] = l$enabled;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSetSpiceEnabled || runtimeType != other.runtimeType) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$enabled = enabled;
    return Object.hashAll([l$userId, l$enabled]);
  }
}

class MutationSetSpiceEnabled {
  MutationSetSpiceEnabled({this.updateUserSettings, this.$__typename = 'mutation_root'});

  factory MutationSetSpiceEnabled.fromJson(Map<String, dynamic> json) {
    final l$updateUserSettings = json['updateUserSettings'];
    final l$$__typename = json['__typename'];
    return MutationSetSpiceEnabled(
      updateUserSettings: l$updateUserSettings == null
          ? null
          : MutationSetSpiceEnabledupdateUserSettings.fromJson(
              (l$updateUserSettings as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSetSpiceEnabledupdateUserSettings? updateUserSettings;

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
    if (other is! MutationSetSpiceEnabled || runtimeType != other.runtimeType) {
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

const documentNodeMutationSetSpiceEnabled = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SetSpiceEnabled'),
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
                      name: NameNode(value: 'spiceEnabled'),
                      value: VariableNode(name: NameNode(value: 'enabled')),
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
MutationSetSpiceEnabled _parserFnMutationSetSpiceEnabled(Map<String, dynamic> data) =>
    MutationSetSpiceEnabled.fromJson(data);
typedef OnMutationCompletedMutationSetSpiceEnabled = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSetSpiceEnabled?,
);

class OptionsMutationSetSpiceEnabled extends graphql.MutationOptions<MutationSetSpiceEnabled> {
  OptionsMutationSetSpiceEnabled({
    String? operationName,
    required VariablesMutationSetSpiceEnabled variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetSpiceEnabled? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSetSpiceEnabled? onCompleted,
    graphql.OnMutationUpdate<MutationSetSpiceEnabled>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetSpiceEnabled',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSetSpiceEnabled(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSetSpiceEnabled,
         parserFn: _parserFnMutationSetSpiceEnabled,
       );

  final OnMutationCompletedMutationSetSpiceEnabled? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSetSpiceEnabled
    extends graphql.WatchQueryOptions<MutationSetSpiceEnabled> {
  WatchOptionsMutationSetSpiceEnabled({
    String? operationName,
    required VariablesMutationSetSpiceEnabled variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSetSpiceEnabled? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SetSpiceEnabled',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSetSpiceEnabled,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSetSpiceEnabled,
       );
}

extension ClientExtensionMutationSetSpiceEnabled on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSetSpiceEnabled>> mutateSetSpiceEnabled(
    OptionsMutationSetSpiceEnabled options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSetSpiceEnabled> watchMutationSetSpiceEnabled(
    WatchOptionsMutationSetSpiceEnabled options,
  ) => this.watchMutation(options);
}

class MutationSetSpiceEnabledupdateUserSettings {
  MutationSetSpiceEnabledupdateUserSettings({
    required this.affected_rows,
    this.$__typename = 'userSettings_mutation_response',
  });

  factory MutationSetSpiceEnabledupdateUserSettings.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationSetSpiceEnabledupdateUserSettings(
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
    if (other is! MutationSetSpiceEnabledupdateUserSettings || runtimeType != other.runtimeType) {
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
