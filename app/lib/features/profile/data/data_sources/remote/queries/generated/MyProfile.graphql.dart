// dart format width=100
import '../../fragments/generated/ProfileFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMyProfile {
  factory VariablesQueryMyProfile({required String userId}) =>
      VariablesQueryMyProfile._({r'userId': userId});

  VariablesQueryMyProfile._(this._$data);

  factory VariablesQueryMyProfile.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryMyProfile._(result$data);
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
    if (other is! VariablesQueryMyProfile || runtimeType != other.runtimeType) {
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

class QueryMyProfile {
  QueryMyProfile({this.profilesByPk, this.$__typename = 'query_root'});

  factory QueryMyProfile.fromJson(Map<String, dynamic> json) {
    final l$profilesByPk = json['profilesByPk'];
    final l$$__typename = json['__typename'];
    return QueryMyProfile(
      profilesByPk: l$profilesByPk == null
          ? null
          : FragmentProfileFragment.fromJson((l$profilesByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentProfileFragment? profilesByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$profilesByPk = profilesByPk;
    _resultData['profilesByPk'] = l$profilesByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$profilesByPk = profilesByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$profilesByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyProfile || runtimeType != other.runtimeType) {
      return false;
    }
    final l$profilesByPk = profilesByPk;
    final lOther$profilesByPk = other.profilesByPk;
    if (l$profilesByPk != lOther$profilesByPk) {
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

const documentNodeQueryMyProfile = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyProfile'),
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
            name: NameNode(value: 'profilesByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'userId')),
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
QueryMyProfile _parserFnQueryMyProfile(Map<String, dynamic> data) => QueryMyProfile.fromJson(data);
typedef OnQueryCompleteQueryMyProfile = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyProfile?,
);

class OptionsQueryMyProfile extends graphql.QueryOptions<QueryMyProfile> {
  OptionsQueryMyProfile({
    String? operationName,
    required VariablesQueryMyProfile variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyProfile? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyProfile? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyProfile',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyProfile(data)),
         onError: onError,
         document: documentNodeQueryMyProfile,
         parserFn: _parserFnQueryMyProfile,
       );

  final OnQueryCompleteQueryMyProfile? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyProfile extends graphql.WatchQueryOptions<QueryMyProfile> {
  WatchOptionsQueryMyProfile({
    String? operationName,
    required VariablesQueryMyProfile variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyProfile? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyProfile',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyProfile,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyProfile,
       );
}

class FetchMoreOptionsQueryMyProfile extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyProfile({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMyProfile variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMyProfile,
       );
}

extension ClientExtensionQueryMyProfile on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyProfile>> queryMyProfile(OptionsQueryMyProfile options) async =>
      await this.query(options);

  graphql.ObservableQuery<QueryMyProfile> watchQueryMyProfile(WatchOptionsQueryMyProfile options) =>
      this.watchQuery(options);

  void writeQueryMyProfile({
    required QueryMyProfile data,
    required VariablesQueryMyProfile variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMyProfile),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyProfile? readQueryMyProfile({
    required VariablesQueryMyProfile variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMyProfile),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyProfile.fromJson(result);
  }
}
