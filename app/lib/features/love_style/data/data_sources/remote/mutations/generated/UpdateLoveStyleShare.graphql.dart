// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateLoveStyleShare {
  factory VariablesMutationUpdateLoveStyleShare({required String id, DateTime? sharedAt}) =>
      VariablesMutationUpdateLoveStyleShare._({
        r'id': id,
        if (sharedAt != null) r'sharedAt': sharedAt,
      });

  VariablesMutationUpdateLoveStyleShare._(this._$data);

  factory VariablesMutationUpdateLoveStyleShare.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    if (data.containsKey('sharedAt')) {
      final l$sharedAt = data['sharedAt'];
      result$data['sharedAt'] = l$sharedAt == null ? null : DateTime.parse((l$sharedAt as String));
    }
    return VariablesMutationUpdateLoveStyleShare._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  DateTime? get sharedAt => (_$data['sharedAt'] as DateTime?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('sharedAt')) {
      final l$sharedAt = sharedAt;
      result$data['sharedAt'] = l$sharedAt == null
          ? null
          : ((v) => v.toUtc().toIso8601String())(l$sharedAt);
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateLoveStyleShare || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$sharedAt = sharedAt;
    final lOther$sharedAt = other.sharedAt;
    if (_$data.containsKey('sharedAt') != other._$data.containsKey('sharedAt')) {
      return false;
    }
    if (l$sharedAt != lOther$sharedAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$sharedAt = sharedAt;
    return Object.hashAll([l$id, _$data.containsKey('sharedAt') ? l$sharedAt : const {}]);
  }
}

class MutationUpdateLoveStyleShare {
  MutationUpdateLoveStyleShare({this.updateQuizResults, this.$__typename = 'mutation_root'});

  factory MutationUpdateLoveStyleShare.fromJson(Map<String, dynamic> json) {
    final l$updateQuizResults = json['updateQuizResults'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLoveStyleShare(
      updateQuizResults: l$updateQuizResults == null
          ? null
          : MutationUpdateLoveStyleShareupdateQuizResults.fromJson(
              (l$updateQuizResults as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateLoveStyleShareupdateQuizResults? updateQuizResults;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateQuizResults = updateQuizResults;
    _resultData['updateQuizResults'] = l$updateQuizResults?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateQuizResults = updateQuizResults;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateQuizResults, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateLoveStyleShare || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateQuizResults = updateQuizResults;
    final lOther$updateQuizResults = other.updateQuizResults;
    if (l$updateQuizResults != lOther$updateQuizResults) {
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

const documentNodeMutationUpdateLoveStyleShare = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateLoveStyleShare'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'sharedAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateQuizResults'),
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
                            value: VariableNode(name: NameNode(value: 'id')),
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
                      name: NameNode(value: 'sharedAt'),
                      value: VariableNode(name: NameNode(value: 'sharedAt')),
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
MutationUpdateLoveStyleShare _parserFnMutationUpdateLoveStyleShare(Map<String, dynamic> data) =>
    MutationUpdateLoveStyleShare.fromJson(data);
typedef OnMutationCompletedMutationUpdateLoveStyleShare = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateLoveStyleShare?,
);

class OptionsMutationUpdateLoveStyleShare
    extends graphql.MutationOptions<MutationUpdateLoveStyleShare> {
  OptionsMutationUpdateLoveStyleShare({
    String? operationName,
    required VariablesMutationUpdateLoveStyleShare variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLoveStyleShare? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateLoveStyleShare? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateLoveStyleShare>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLoveStyleShare',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateLoveStyleShare(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateLoveStyleShare,
         parserFn: _parserFnMutationUpdateLoveStyleShare,
       );

  final OnMutationCompletedMutationUpdateLoveStyleShare? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateLoveStyleShare
    extends graphql.WatchQueryOptions<MutationUpdateLoveStyleShare> {
  WatchOptionsMutationUpdateLoveStyleShare({
    String? operationName,
    required VariablesMutationUpdateLoveStyleShare variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLoveStyleShare? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLoveStyleShare',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateLoveStyleShare,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateLoveStyleShare,
       );
}

extension ClientExtensionMutationUpdateLoveStyleShare on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateLoveStyleShare>> mutateUpdateLoveStyleShare(
    OptionsMutationUpdateLoveStyleShare options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateLoveStyleShare> watchMutationUpdateLoveStyleShare(
    WatchOptionsMutationUpdateLoveStyleShare options,
  ) => this.watchMutation(options);
}

class MutationUpdateLoveStyleShareupdateQuizResults {
  MutationUpdateLoveStyleShareupdateQuizResults({
    required this.affected_rows,
    this.$__typename = 'quizResults_mutation_response',
  });

  factory MutationUpdateLoveStyleShareupdateQuizResults.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLoveStyleShareupdateQuizResults(
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
    if (other is! MutationUpdateLoveStyleShareupdateQuizResults ||
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
