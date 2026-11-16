// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationInsertLoveStyleResult {
  factory VariablesMutationInsertLoveStyleResult({required List<String> ranked}) =>
      VariablesMutationInsertLoveStyleResult._({r'ranked': ranked});

  VariablesMutationInsertLoveStyleResult._(this._$data);

  factory VariablesMutationInsertLoveStyleResult.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$ranked = data['ranked'];
    result$data['ranked'] = (l$ranked as List<dynamic>).map((e) => (e as String)).toList();
    return VariablesMutationInsertLoveStyleResult._(result$data);
  }

  Map<String, dynamic> _$data;

  List<String> get ranked => (_$data['ranked'] as List<String>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$ranked = ranked;
    result$data['ranked'] = l$ranked.map((e) => e).toList();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationInsertLoveStyleResult || runtimeType != other.runtimeType) {
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
    final l$ranked = ranked;
    return Object.hashAll([Object.hashAll(l$ranked.map((v) => v))]);
  }
}

class MutationInsertLoveStyleResult {
  MutationInsertLoveStyleResult({this.insertQuizResultsOne, this.$__typename = 'mutation_root'});

  factory MutationInsertLoveStyleResult.fromJson(Map<String, dynamic> json) {
    final l$insertQuizResultsOne = json['insertQuizResultsOne'];
    final l$$__typename = json['__typename'];
    return MutationInsertLoveStyleResult(
      insertQuizResultsOne: l$insertQuizResultsOne == null
          ? null
          : MutationInsertLoveStyleResultinsertQuizResultsOne.fromJson(
              (l$insertQuizResultsOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationInsertLoveStyleResultinsertQuizResultsOne? insertQuizResultsOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertQuizResultsOne = insertQuizResultsOne;
    _resultData['insertQuizResultsOne'] = l$insertQuizResultsOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertQuizResultsOne = insertQuizResultsOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertQuizResultsOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertLoveStyleResult || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertQuizResultsOne = insertQuizResultsOne;
    final lOther$insertQuizResultsOne = other.insertQuizResultsOne;
    if (l$insertQuizResultsOne != lOther$insertQuizResultsOne) {
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

const documentNodeMutationInsertLoveStyleResult = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InsertLoveStyleResult'),
      variableDefinitions: [
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
            name: NameNode(value: 'insertQuizResultsOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'quizKey'),
                      value: EnumValueNode(name: NameNode(value: 'loved')),
                    ),
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
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'ranked'),
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
MutationInsertLoveStyleResult _parserFnMutationInsertLoveStyleResult(Map<String, dynamic> data) =>
    MutationInsertLoveStyleResult.fromJson(data);
typedef OnMutationCompletedMutationInsertLoveStyleResult = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationInsertLoveStyleResult?,
);

class OptionsMutationInsertLoveStyleResult
    extends graphql.MutationOptions<MutationInsertLoveStyleResult> {
  OptionsMutationInsertLoveStyleResult({
    String? operationName,
    required VariablesMutationInsertLoveStyleResult variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertLoveStyleResult? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationInsertLoveStyleResult? onCompleted,
    graphql.OnMutationUpdate<MutationInsertLoveStyleResult>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertLoveStyleResult',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationInsertLoveStyleResult(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationInsertLoveStyleResult,
         parserFn: _parserFnMutationInsertLoveStyleResult,
       );

  final OnMutationCompletedMutationInsertLoveStyleResult? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationInsertLoveStyleResult
    extends graphql.WatchQueryOptions<MutationInsertLoveStyleResult> {
  WatchOptionsMutationInsertLoveStyleResult({
    String? operationName,
    required VariablesMutationInsertLoveStyleResult variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertLoveStyleResult? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertLoveStyleResult',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationInsertLoveStyleResult,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationInsertLoveStyleResult,
       );
}

extension ClientExtensionMutationInsertLoveStyleResult on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationInsertLoveStyleResult>> mutateInsertLoveStyleResult(
    OptionsMutationInsertLoveStyleResult options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationInsertLoveStyleResult> watchMutationInsertLoveStyleResult(
    WatchOptionsMutationInsertLoveStyleResult options,
  ) => this.watchMutation(options);
}

class MutationInsertLoveStyleResultinsertQuizResultsOne {
  MutationInsertLoveStyleResultinsertQuizResultsOne({
    required this.id,
    required this.ranked,
    this.$__typename = 'quizResults',
  });

  factory MutationInsertLoveStyleResultinsertQuizResultsOne.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$ranked = json['ranked'];
    final l$$__typename = json['__typename'];
    return MutationInsertLoveStyleResultinsertQuizResultsOne(
      id: (l$id as String),
      ranked: (l$ranked as List<dynamic>).map((e) => (e as String)).toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final List<String> ranked;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$ranked = ranked;
    _resultData['ranked'] = l$ranked.map((e) => e).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$ranked = ranked;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, Object.hashAll(l$ranked.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertLoveStyleResultinsertQuizResultsOne ||
        runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}
