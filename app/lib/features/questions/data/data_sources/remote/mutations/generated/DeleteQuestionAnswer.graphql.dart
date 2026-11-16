// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteQuestionAnswer {
  factory VariablesMutationDeleteQuestionAnswer({required String id}) =>
      VariablesMutationDeleteQuestionAnswer._({r'id': id});

  VariablesMutationDeleteQuestionAnswer._(this._$data);

  factory VariablesMutationDeleteQuestionAnswer.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteQuestionAnswer._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationDeleteQuestionAnswer || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

class MutationDeleteQuestionAnswer {
  MutationDeleteQuestionAnswer({
    this.deleteQuestionAnswersByPk,
    this.$__typename = 'mutation_root',
  });

  factory MutationDeleteQuestionAnswer.fromJson(Map<String, dynamic> json) {
    final l$deleteQuestionAnswersByPk = json['deleteQuestionAnswersByPk'];
    final l$$__typename = json['__typename'];
    return MutationDeleteQuestionAnswer(
      deleteQuestionAnswersByPk: l$deleteQuestionAnswersByPk == null
          ? null
          : MutationDeleteQuestionAnswerdeleteQuestionAnswersByPk.fromJson(
              (l$deleteQuestionAnswersByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteQuestionAnswerdeleteQuestionAnswersByPk? deleteQuestionAnswersByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteQuestionAnswersByPk = deleteQuestionAnswersByPk;
    _resultData['deleteQuestionAnswersByPk'] = l$deleteQuestionAnswersByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteQuestionAnswersByPk = deleteQuestionAnswersByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteQuestionAnswersByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteQuestionAnswer || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteQuestionAnswersByPk = deleteQuestionAnswersByPk;
    final lOther$deleteQuestionAnswersByPk = other.deleteQuestionAnswersByPk;
    if (l$deleteQuestionAnswersByPk != lOther$deleteQuestionAnswersByPk) {
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

const documentNodeMutationDeleteQuestionAnswer = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteQuestionAnswer'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'deleteQuestionAnswersByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
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
MutationDeleteQuestionAnswer _parserFnMutationDeleteQuestionAnswer(Map<String, dynamic> data) =>
    MutationDeleteQuestionAnswer.fromJson(data);
typedef OnMutationCompletedMutationDeleteQuestionAnswer = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteQuestionAnswer?,
);

class OptionsMutationDeleteQuestionAnswer
    extends graphql.MutationOptions<MutationDeleteQuestionAnswer> {
  OptionsMutationDeleteQuestionAnswer({
    String? operationName,
    required VariablesMutationDeleteQuestionAnswer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteQuestionAnswer? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteQuestionAnswer? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteQuestionAnswer>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteQuestionAnswer',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationDeleteQuestionAnswer(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteQuestionAnswer,
         parserFn: _parserFnMutationDeleteQuestionAnswer,
       );

  final OnMutationCompletedMutationDeleteQuestionAnswer? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteQuestionAnswer
    extends graphql.WatchQueryOptions<MutationDeleteQuestionAnswer> {
  WatchOptionsMutationDeleteQuestionAnswer({
    String? operationName,
    required VariablesMutationDeleteQuestionAnswer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteQuestionAnswer? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteQuestionAnswer',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteQuestionAnswer,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteQuestionAnswer,
       );
}

extension ClientExtensionMutationDeleteQuestionAnswer on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteQuestionAnswer>> mutateDeleteQuestionAnswer(
    OptionsMutationDeleteQuestionAnswer options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteQuestionAnswer> watchMutationDeleteQuestionAnswer(
    WatchOptionsMutationDeleteQuestionAnswer options,
  ) => this.watchMutation(options);
}

class MutationDeleteQuestionAnswerdeleteQuestionAnswersByPk {
  MutationDeleteQuestionAnswerdeleteQuestionAnswersByPk({
    required this.id,
    this.$__typename = 'questionAnswers',
  });

  factory MutationDeleteQuestionAnswerdeleteQuestionAnswersByPk.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationDeleteQuestionAnswerdeleteQuestionAnswersByPk(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteQuestionAnswerdeleteQuestionAnswersByPk ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
