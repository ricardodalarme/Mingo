// dart format width=100
import '../../fragments/generated/ProfileFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateDisplayName {
  factory VariablesMutationUpdateDisplayName({
    required String profileId,
    required String displayName,
  }) =>
      VariablesMutationUpdateDisplayName._({r'profileId': profileId, r'displayName': displayName});

  VariablesMutationUpdateDisplayName._(this._$data);

  factory VariablesMutationUpdateDisplayName.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$profileId = data['profileId'];
    result$data['profileId'] = (l$profileId as String);
    final l$displayName = data['displayName'];
    result$data['displayName'] = (l$displayName as String);
    return VariablesMutationUpdateDisplayName._(result$data);
  }

  Map<String, dynamic> _$data;

  String get profileId => (_$data['profileId'] as String);

  String get displayName => (_$data['displayName'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$profileId = profileId;
    result$data['profileId'] = l$profileId;
    final l$displayName = displayName;
    result$data['displayName'] = l$displayName;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateDisplayName || runtimeType != other.runtimeType) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$profileId = profileId;
    final l$displayName = displayName;
    return Object.hashAll([l$profileId, l$displayName]);
  }
}

class MutationUpdateDisplayName {
  MutationUpdateDisplayName({this.updateProfilesByPk, this.$__typename = 'mutation_root'});

  factory MutationUpdateDisplayName.fromJson(Map<String, dynamic> json) {
    final l$updateProfilesByPk = json['updateProfilesByPk'];
    final l$$__typename = json['__typename'];
    return MutationUpdateDisplayName(
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
    if (other is! MutationUpdateDisplayName || runtimeType != other.runtimeType) {
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

const documentNodeMutationUpdateDisplayName = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateDisplayName'),
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
                      name: NameNode(value: 'displayName'),
                      value: VariableNode(name: NameNode(value: 'displayName')),
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
MutationUpdateDisplayName _parserFnMutationUpdateDisplayName(Map<String, dynamic> data) =>
    MutationUpdateDisplayName.fromJson(data);
typedef OnMutationCompletedMutationUpdateDisplayName = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateDisplayName?,
);

class OptionsMutationUpdateDisplayName extends graphql.MutationOptions<MutationUpdateDisplayName> {
  OptionsMutationUpdateDisplayName({
    String? operationName,
    required VariablesMutationUpdateDisplayName variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateDisplayName? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateDisplayName? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateDisplayName>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateDisplayName',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateDisplayName(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateDisplayName,
         parserFn: _parserFnMutationUpdateDisplayName,
       );

  final OnMutationCompletedMutationUpdateDisplayName? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateDisplayName
    extends graphql.WatchQueryOptions<MutationUpdateDisplayName> {
  WatchOptionsMutationUpdateDisplayName({
    String? operationName,
    required VariablesMutationUpdateDisplayName variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateDisplayName? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateDisplayName',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateDisplayName,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateDisplayName,
       );
}

extension ClientExtensionMutationUpdateDisplayName on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateDisplayName>> mutateUpdateDisplayName(
    OptionsMutationUpdateDisplayName options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateDisplayName> watchMutationUpdateDisplayName(
    WatchOptionsMutationUpdateDisplayName options,
  ) => this.watchMutation(options);
}
