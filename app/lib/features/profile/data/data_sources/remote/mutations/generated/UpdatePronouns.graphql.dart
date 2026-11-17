// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';
import '../../fragments/generated/ProfileFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdatePronouns {
  factory VariablesMutationUpdatePronouns({
    required String profileId,
    EnumPronoun_enum? pronouns,
  }) => VariablesMutationUpdatePronouns._({
    r'profileId': profileId,
    if (pronouns != null) r'pronouns': pronouns,
  });

  VariablesMutationUpdatePronouns._(this._$data);

  factory VariablesMutationUpdatePronouns.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$profileId = data['profileId'];
    result$data['profileId'] = (l$profileId as String);
    if (data.containsKey('pronouns')) {
      final l$pronouns = data['pronouns'];
      result$data['pronouns'] = l$pronouns == null
          ? null
          : fromJsonEnumPronoun_enum((l$pronouns as String));
    }
    return VariablesMutationUpdatePronouns._(result$data);
  }

  Map<String, dynamic> _$data;

  String get profileId => (_$data['profileId'] as String);

  EnumPronoun_enum? get pronouns => (_$data['pronouns'] as EnumPronoun_enum?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$profileId = profileId;
    result$data['profileId'] = l$profileId;
    if (_$data.containsKey('pronouns')) {
      final l$pronouns = pronouns;
      result$data['pronouns'] = l$pronouns == null ? null : toJsonEnumPronoun_enum(l$pronouns);
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdatePronouns || runtimeType != other.runtimeType) {
      return false;
    }
    final l$profileId = profileId;
    final lOther$profileId = other.profileId;
    if (l$profileId != lOther$profileId) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$profileId = profileId;
    final l$pronouns = pronouns;
    return Object.hashAll([l$profileId, _$data.containsKey('pronouns') ? l$pronouns : const {}]);
  }
}

class MutationUpdatePronouns {
  MutationUpdatePronouns({this.updateProfilesByPk, this.$__typename = 'mutation_root'});

  factory MutationUpdatePronouns.fromJson(Map<String, dynamic> json) {
    final l$updateProfilesByPk = json['updateProfilesByPk'];
    final l$$__typename = json['__typename'];
    return MutationUpdatePronouns(
      updateProfilesByPk: l$updateProfilesByPk == null
          ? null
          : FragmentProfileFragment.fromJson((l$updateProfilesByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentProfileFragment? updateProfilesByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateProfilesByPk = updateProfilesByPk;
    _resultData['updateProfilesByPk'] = l$updateProfilesByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateProfilesByPk = updateProfilesByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateProfilesByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdatePronouns || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateProfilesByPk = updateProfilesByPk;
    final lOther$updateProfilesByPk = other.updateProfilesByPk;
    if (l$updateProfilesByPk != lOther$updateProfilesByPk) {
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

const documentNodeMutationUpdatePronouns = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdatePronouns'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'profileId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'pronouns')),
          type: NamedTypeNode(name: NameNode(value: 'Pronoun_enum'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateProfilesByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
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
                FragmentSpreadNode(
                  name: NameNode(value: 'ProfileFragment'),
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
    fragmentDefinitionProfileFragment,
  ],
);
MutationUpdatePronouns _parserFnMutationUpdatePronouns(Map<String, dynamic> data) =>
    MutationUpdatePronouns.fromJson(data);
typedef OnMutationCompletedMutationUpdatePronouns = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdatePronouns?,
);

class OptionsMutationUpdatePronouns extends graphql.MutationOptions<MutationUpdatePronouns> {
  OptionsMutationUpdatePronouns({
    String? operationName,
    required VariablesMutationUpdatePronouns variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdatePronouns? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdatePronouns? onCompleted,
    graphql.OnMutationUpdate<MutationUpdatePronouns>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdatePronouns',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationUpdatePronouns(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdatePronouns,
         parserFn: _parserFnMutationUpdatePronouns,
       );

  final OnMutationCompletedMutationUpdatePronouns? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdatePronouns extends graphql.WatchQueryOptions<MutationUpdatePronouns> {
  WatchOptionsMutationUpdatePronouns({
    String? operationName,
    required VariablesMutationUpdatePronouns variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdatePronouns? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdatePronouns',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdatePronouns,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdatePronouns,
       );
}

extension ClientExtensionMutationUpdatePronouns on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdatePronouns>> mutateUpdatePronouns(
    OptionsMutationUpdatePronouns options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdatePronouns> watchMutationUpdatePronouns(
    WatchOptionsMutationUpdatePronouns options,
  ) => this.watchMutation(options);
}
