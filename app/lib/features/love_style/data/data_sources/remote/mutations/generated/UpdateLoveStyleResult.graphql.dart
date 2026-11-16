// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateLoveStyleResult {
  factory VariablesMutationUpdateLoveStyleResult({
    required String id,
    required List<String> ranked,
  }) => VariablesMutationUpdateLoveStyleResult._({r'id': id, r'ranked': ranked});

  VariablesMutationUpdateLoveStyleResult._(this._$data);

  factory VariablesMutationUpdateLoveStyleResult.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$ranked = data['ranked'];
    result$data['ranked'] = (l$ranked as List<dynamic>).map((e) => (e as String)).toList();
    return VariablesMutationUpdateLoveStyleResult._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  List<String> get ranked => (_$data['ranked'] as List<String>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$ranked = ranked;
    result$data['ranked'] = l$ranked.map((e) => e).toList();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateLoveStyleResult || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$ranked = ranked;
    final lOther$ranked = other.ranked;
    if (l$ranked.length != lOther$ranked.length) {
      return false;
    }
    for (int i = 0; i < l$ranked.length; i++) {
      final l$ranked$entry = l$ranked[i];
      final lOther$ranked$entry = lOther$ranked[i];
      if (l$ranked$entry != lOther$ranked$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$ranked = ranked;
    return Object.hashAll([l$id, Object.hashAll(l$ranked.map((v) => v))]);
  }
}

class MutationUpdateLoveStyleResult {
  MutationUpdateLoveStyleResult({this.updateQuizResults, this.$__typename = 'mutation_root'});

  factory MutationUpdateLoveStyleResult.fromJson(Map<String, dynamic> json) {
    final l$updateQuizResults = json['updateQuizResults'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLoveStyleResult(
      updateQuizResults: l$updateQuizResults == null
          ? null
          : MutationUpdateLoveStyleResultupdateQuizResults.fromJson(
              (l$updateQuizResults as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateLoveStyleResultupdateQuizResults? updateQuizResults;

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
    if (other is! MutationUpdateLoveStyleResult || runtimeType != other.runtimeType) {
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

const documentNodeMutationUpdateLoveStyleResult = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateLoveStyleResult'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'ranked')),
          type: ListTypeNode(
            type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            isNonNull: true,
          ),
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
                      name: NameNode(value: 'ranked'),
                      value: VariableNode(name: NameNode(value: 'ranked')),
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
MutationUpdateLoveStyleResult _parserFnMutationUpdateLoveStyleResult(Map<String, dynamic> data) =>
    MutationUpdateLoveStyleResult.fromJson(data);
typedef OnMutationCompletedMutationUpdateLoveStyleResult = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateLoveStyleResult?,
);

class OptionsMutationUpdateLoveStyleResult
    extends graphql.MutationOptions<MutationUpdateLoveStyleResult> {
  OptionsMutationUpdateLoveStyleResult({
    String? operationName,
    required VariablesMutationUpdateLoveStyleResult variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLoveStyleResult? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateLoveStyleResult? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateLoveStyleResult>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLoveStyleResult',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateLoveStyleResult(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateLoveStyleResult,
         parserFn: _parserFnMutationUpdateLoveStyleResult,
       );

  final OnMutationCompletedMutationUpdateLoveStyleResult? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateLoveStyleResult
    extends graphql.WatchQueryOptions<MutationUpdateLoveStyleResult> {
  WatchOptionsMutationUpdateLoveStyleResult({
    String? operationName,
    required VariablesMutationUpdateLoveStyleResult variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLoveStyleResult? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLoveStyleResult',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateLoveStyleResult,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateLoveStyleResult,
       );
}

extension ClientExtensionMutationUpdateLoveStyleResult on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateLoveStyleResult>> mutateUpdateLoveStyleResult(
    OptionsMutationUpdateLoveStyleResult options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateLoveStyleResult> watchMutationUpdateLoveStyleResult(
    WatchOptionsMutationUpdateLoveStyleResult options,
  ) => this.watchMutation(options);
}

class MutationUpdateLoveStyleResultupdateQuizResults {
  MutationUpdateLoveStyleResultupdateQuizResults({
    required this.affected_rows,
    this.$__typename = 'quizResults_mutation_response',
  });

  factory MutationUpdateLoveStyleResultupdateQuizResults.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLoveStyleResultupdateQuizResults(
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
    if (other is! MutationUpdateLoveStyleResultupdateQuizResults ||
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
