// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateTimeZone {
  factory VariablesMutationUpdateTimeZone({required String profileId, required String timeZone}) =>
      VariablesMutationUpdateTimeZone._({r'profileId': profileId, r'timeZone': timeZone});

  VariablesMutationUpdateTimeZone._(this._$data);

  factory VariablesMutationUpdateTimeZone.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$profileId = data['profileId'];
    result$data['profileId'] = (l$profileId as String);
    final l$timeZone = data['timeZone'];
    result$data['timeZone'] = (l$timeZone as String);
    return VariablesMutationUpdateTimeZone._(result$data);
  }

  Map<String, dynamic> _$data;

  String get profileId => (_$data['profileId'] as String);

  String get timeZone => (_$data['timeZone'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$profileId = profileId;
    result$data['profileId'] = l$profileId;
    final l$timeZone = timeZone;
    result$data['timeZone'] = l$timeZone;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateTimeZone || runtimeType != other.runtimeType) {
      return false;
    }
    final l$profileId = profileId;
    final lOther$profileId = other.profileId;
    if (l$profileId != lOther$profileId) {
      return false;
    }
    final l$timeZone = timeZone;
    final lOther$timeZone = other.timeZone;
    if (l$timeZone != lOther$timeZone) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$profileId = profileId;
    final l$timeZone = timeZone;
    return Object.hashAll([l$profileId, l$timeZone]);
  }
}

class MutationUpdateTimeZone {
  MutationUpdateTimeZone({this.updateProfiles, this.$__typename = 'mutation_root'});

  factory MutationUpdateTimeZone.fromJson(Map<String, dynamic> json) {
    final l$updateProfiles = json['updateProfiles'];
    final l$$__typename = json['__typename'];
    return MutationUpdateTimeZone(
      updateProfiles: l$updateProfiles == null
          ? null
          : MutationUpdateTimeZoneupdateProfiles.fromJson(
              (l$updateProfiles as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateTimeZoneupdateProfiles? updateProfiles;

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
    if (other is! MutationUpdateTimeZone || runtimeType != other.runtimeType) {
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

const documentNodeMutationUpdateTimeZone = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateTimeZone'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'profileId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'timeZone')),
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
                      name: NameNode(value: 'timeZone'),
                      value: VariableNode(name: NameNode(value: 'timeZone')),
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
MutationUpdateTimeZone _parserFnMutationUpdateTimeZone(Map<String, dynamic> data) =>
    MutationUpdateTimeZone.fromJson(data);
typedef OnMutationCompletedMutationUpdateTimeZone = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateTimeZone?,
);

class OptionsMutationUpdateTimeZone extends graphql.MutationOptions<MutationUpdateTimeZone> {
  OptionsMutationUpdateTimeZone({
    String? operationName,
    required VariablesMutationUpdateTimeZone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateTimeZone? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateTimeZone? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateTimeZone>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateTimeZone',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationUpdateTimeZone(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateTimeZone,
         parserFn: _parserFnMutationUpdateTimeZone,
       );

  final OnMutationCompletedMutationUpdateTimeZone? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateTimeZone extends graphql.WatchQueryOptions<MutationUpdateTimeZone> {
  WatchOptionsMutationUpdateTimeZone({
    String? operationName,
    required VariablesMutationUpdateTimeZone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateTimeZone? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateTimeZone',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateTimeZone,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateTimeZone,
       );
}

extension ClientExtensionMutationUpdateTimeZone on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateTimeZone>> mutateUpdateTimeZone(
    OptionsMutationUpdateTimeZone options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateTimeZone> watchMutationUpdateTimeZone(
    WatchOptionsMutationUpdateTimeZone options,
  ) => this.watchMutation(options);
}

class MutationUpdateTimeZoneupdateProfiles {
  MutationUpdateTimeZoneupdateProfiles({
    required this.affected_rows,
    this.$__typename = 'profiles_mutation_response',
  });

  factory MutationUpdateTimeZoneupdateProfiles.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateTimeZoneupdateProfiles(
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
    if (other is! MutationUpdateTimeZoneupdateProfiles || runtimeType != other.runtimeType) {
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
