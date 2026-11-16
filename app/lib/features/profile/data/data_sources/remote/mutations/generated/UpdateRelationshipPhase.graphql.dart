// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateRelationshipPhase {
  factory VariablesMutationUpdateRelationshipPhase({
    required String profileId,
    EnumRelationshipPhase_enum? phase,
  }) => VariablesMutationUpdateRelationshipPhase._({
    r'profileId': profileId,
    if (phase != null) r'phase': phase,
  });

  VariablesMutationUpdateRelationshipPhase._(this._$data);

  factory VariablesMutationUpdateRelationshipPhase.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$profileId = data['profileId'];
    result$data['profileId'] = (l$profileId as String);
    if (data.containsKey('phase')) {
      final l$phase = data['phase'];
      result$data['phase'] = l$phase == null
          ? null
          : fromJsonEnumRelationshipPhase_enum((l$phase as String));
    }
    return VariablesMutationUpdateRelationshipPhase._(result$data);
  }

  Map<String, dynamic> _$data;

  String get profileId => (_$data['profileId'] as String);

  EnumRelationshipPhase_enum? get phase => (_$data['phase'] as EnumRelationshipPhase_enum?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$profileId = profileId;
    result$data['profileId'] = l$profileId;
    if (_$data.containsKey('phase')) {
      final l$phase = phase;
      result$data['phase'] = l$phase == null ? null : toJsonEnumRelationshipPhase_enum(l$phase);
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateRelationshipPhase || runtimeType != other.runtimeType) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$profileId = profileId;
    final l$phase = phase;
    return Object.hashAll([l$profileId, _$data.containsKey('phase') ? l$phase : const {}]);
  }
}

class MutationUpdateRelationshipPhase {
  MutationUpdateRelationshipPhase({this.updateUserSettings, this.$__typename = 'mutation_root'});

  factory MutationUpdateRelationshipPhase.fromJson(Map<String, dynamic> json) {
    final l$updateUserSettings = json['updateUserSettings'];
    final l$$__typename = json['__typename'];
    return MutationUpdateRelationshipPhase(
      updateUserSettings: l$updateUserSettings == null
          ? null
          : MutationUpdateRelationshipPhaseupdateUserSettings.fromJson(
              (l$updateUserSettings as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateRelationshipPhaseupdateUserSettings? updateUserSettings;

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
    if (other is! MutationUpdateRelationshipPhase || runtimeType != other.runtimeType) {
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

const documentNodeMutationUpdateRelationshipPhase = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateRelationshipPhase'),
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
MutationUpdateRelationshipPhase _parserFnMutationUpdateRelationshipPhase(
  Map<String, dynamic> data,
) => MutationUpdateRelationshipPhase.fromJson(data);
typedef OnMutationCompletedMutationUpdateRelationshipPhase = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateRelationshipPhase?,
);

class OptionsMutationUpdateRelationshipPhase
    extends graphql.MutationOptions<MutationUpdateRelationshipPhase> {
  OptionsMutationUpdateRelationshipPhase({
    String? operationName,
    required VariablesMutationUpdateRelationshipPhase variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateRelationshipPhase? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateRelationshipPhase? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateRelationshipPhase>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateRelationshipPhase',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateRelationshipPhase(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateRelationshipPhase,
         parserFn: _parserFnMutationUpdateRelationshipPhase,
       );

  final OnMutationCompletedMutationUpdateRelationshipPhase? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateRelationshipPhase
    extends graphql.WatchQueryOptions<MutationUpdateRelationshipPhase> {
  WatchOptionsMutationUpdateRelationshipPhase({
    String? operationName,
    required VariablesMutationUpdateRelationshipPhase variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateRelationshipPhase? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateRelationshipPhase',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateRelationshipPhase,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateRelationshipPhase,
       );
}

extension ClientExtensionMutationUpdateRelationshipPhase on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateRelationshipPhase>> mutateUpdateRelationshipPhase(
    OptionsMutationUpdateRelationshipPhase options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateRelationshipPhase> watchMutationUpdateRelationshipPhase(
    WatchOptionsMutationUpdateRelationshipPhase options,
  ) => this.watchMutation(options);
}

class MutationUpdateRelationshipPhaseupdateUserSettings {
  MutationUpdateRelationshipPhaseupdateUserSettings({
    required this.affected_rows,
    this.$__typename = 'userSettings_mutation_response',
  });

  factory MutationUpdateRelationshipPhaseupdateUserSettings.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateRelationshipPhaseupdateUserSettings(
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
    if (other is! MutationUpdateRelationshipPhaseupdateUserSettings ||
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
