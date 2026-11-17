// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';
import '../../fragments/generated/SettingsFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdatePartnerIntent {
  factory VariablesMutationUpdatePartnerIntent({
    required String profileId,
    EnumPartnerIntent_enum? intent,
  }) => VariablesMutationUpdatePartnerIntent._({
    r'profileId': profileId,
    if (intent != null) r'intent': intent,
  });

  VariablesMutationUpdatePartnerIntent._(this._$data);

  factory VariablesMutationUpdatePartnerIntent.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$profileId = data['profileId'];
    result$data['profileId'] = (l$profileId as String);
    if (data.containsKey('intent')) {
      final l$intent = data['intent'];
      result$data['intent'] = l$intent == null
          ? null
          : fromJsonEnumPartnerIntent_enum((l$intent as String));
    }
    return VariablesMutationUpdatePartnerIntent._(result$data);
  }

  Map<String, dynamic> _$data;

  String get profileId => (_$data['profileId'] as String);

  EnumPartnerIntent_enum? get intent => (_$data['intent'] as EnumPartnerIntent_enum?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$profileId = profileId;
    result$data['profileId'] = l$profileId;
    if (_$data.containsKey('intent')) {
      final l$intent = intent;
      result$data['intent'] = l$intent == null ? null : toJsonEnumPartnerIntent_enum(l$intent);
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdatePartnerIntent || runtimeType != other.runtimeType) {
      return false;
    }
    final l$profileId = profileId;
    final lOther$profileId = other.profileId;
    if (l$profileId != lOther$profileId) {
      return false;
    }
    final l$intent = intent;
    final lOther$intent = other.intent;
    if (_$data.containsKey('intent') != other._$data.containsKey('intent')) {
      return false;
    }
    if (l$intent != lOther$intent) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$profileId = profileId;
    final l$intent = intent;
    return Object.hashAll([l$profileId, _$data.containsKey('intent') ? l$intent : const {}]);
  }
}

class MutationUpdatePartnerIntent {
  MutationUpdatePartnerIntent({this.updateUserSettingsByPk, this.$__typename = 'mutation_root'});

  factory MutationUpdatePartnerIntent.fromJson(Map<String, dynamic> json) {
    final l$updateUserSettingsByPk = json['updateUserSettingsByPk'];
    final l$$__typename = json['__typename'];
    return MutationUpdatePartnerIntent(
      updateUserSettingsByPk: l$updateUserSettingsByPk == null
          ? null
          : FragmentSettingsFragment.fromJson((l$updateUserSettingsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentSettingsFragment? updateUserSettingsByPk;

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
    if (other is! MutationUpdatePartnerIntent || runtimeType != other.runtimeType) {
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

const documentNodeMutationUpdatePartnerIntent = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdatePartnerIntent'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'profileId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'intent')),
          type: NamedTypeNode(name: NameNode(value: 'PartnerIntent_enum'), isNonNull: false),
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
                      name: NameNode(value: 'partnerIntent'),
                      value: VariableNode(name: NameNode(value: 'intent')),
                    ),
                  ],
                ),
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
MutationUpdatePartnerIntent _parserFnMutationUpdatePartnerIntent(Map<String, dynamic> data) =>
    MutationUpdatePartnerIntent.fromJson(data);
typedef OnMutationCompletedMutationUpdatePartnerIntent = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdatePartnerIntent?,
);

class OptionsMutationUpdatePartnerIntent
    extends graphql.MutationOptions<MutationUpdatePartnerIntent> {
  OptionsMutationUpdatePartnerIntent({
    String? operationName,
    required VariablesMutationUpdatePartnerIntent variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdatePartnerIntent? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdatePartnerIntent? onCompleted,
    graphql.OnMutationUpdate<MutationUpdatePartnerIntent>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdatePartnerIntent',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdatePartnerIntent(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdatePartnerIntent,
         parserFn: _parserFnMutationUpdatePartnerIntent,
       );

  final OnMutationCompletedMutationUpdatePartnerIntent? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdatePartnerIntent
    extends graphql.WatchQueryOptions<MutationUpdatePartnerIntent> {
  WatchOptionsMutationUpdatePartnerIntent({
    String? operationName,
    required VariablesMutationUpdatePartnerIntent variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdatePartnerIntent? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdatePartnerIntent',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdatePartnerIntent,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdatePartnerIntent,
       );
}

extension ClientExtensionMutationUpdatePartnerIntent on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdatePartnerIntent>> mutateUpdatePartnerIntent(
    OptionsMutationUpdatePartnerIntent options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdatePartnerIntent> watchMutationUpdatePartnerIntent(
    WatchOptionsMutationUpdatePartnerIntent options,
  ) => this.watchMutation(options);
}
