// dart format width=100
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
  MutationUpdateDisplayName({this.updateProfiles, this.$__typename = 'mutation_root'});

  factory MutationUpdateDisplayName.fromJson(Map<String, dynamic> json) {
    final l$updateProfiles = json['updateProfiles'];
    final l$$__typename = json['__typename'];
    return MutationUpdateDisplayName(
      updateProfiles: l$updateProfiles == null
          ? null
          : MutationUpdateDisplayNameupdateProfiles.fromJson(
              (l$updateProfiles as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateDisplayNameupdateProfiles? updateProfiles;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateProfiles = updateProfiles;
    _resultData['updateProfiles'] = l$updateProfiles?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateProfiles = updateProfiles;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateProfiles, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateDisplayName || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateProfiles = updateProfiles;
    final lOther$updateProfiles = other.updateProfiles;
    if (l$updateProfiles != lOther$updateProfiles) {
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

class MutationUpdateDisplayNameupdateProfiles {
  MutationUpdateDisplayNameupdateProfiles({
    required this.affected_rows,
    this.$__typename = 'profiles_mutation_response',
  });

  factory MutationUpdateDisplayNameupdateProfiles.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateDisplayNameupdateProfiles(
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
    if (other is! MutationUpdateDisplayNameupdateProfiles || runtimeType != other.runtimeType) {
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
