// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationInsertQuestionAnswer {
  factory VariablesMutationInsertQuestionAnswer({
    required String questionSlug,
    required String body,
  }) => VariablesMutationInsertQuestionAnswer._({r'questionSlug': questionSlug, r'body': body});

  VariablesMutationInsertQuestionAnswer._(this._$data);

  factory VariablesMutationInsertQuestionAnswer.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$questionSlug = data['questionSlug'];
    result$data['questionSlug'] = (l$questionSlug as String);
    final l$body = data['body'];
    result$data['body'] = (l$body as String);
    return VariablesMutationInsertQuestionAnswer._(result$data);
  }

  Map<String, dynamic> _$data;

  String get questionSlug => (_$data['questionSlug'] as String);

  String get body => (_$data['body'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$questionSlug = questionSlug;
    result$data['questionSlug'] = l$questionSlug;
    final l$body = body;
    result$data['body'] = l$body;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationInsertQuestionAnswer || runtimeType != other.runtimeType) {
      return false;
    }
    final l$questionSlug = questionSlug;
    final lOther$questionSlug = other.questionSlug;
    if (l$questionSlug != lOther$questionSlug) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$questionSlug = questionSlug;
    final l$body = body;
    return Object.hashAll([l$questionSlug, l$body]);
  }
}

class MutationInsertQuestionAnswer {
  MutationInsertQuestionAnswer({this.insertQuestionAnswersOne, this.$__typename = 'mutation_root'});

  factory MutationInsertQuestionAnswer.fromJson(Map<String, dynamic> json) {
    final l$insertQuestionAnswersOne = json['insertQuestionAnswersOne'];
    final l$$__typename = json['__typename'];
    return MutationInsertQuestionAnswer(
      insertQuestionAnswersOne: l$insertQuestionAnswersOne == null
          ? null
          : MutationInsertQuestionAnswerinsertQuestionAnswersOne.fromJson(
              (l$insertQuestionAnswersOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationInsertQuestionAnswerinsertQuestionAnswersOne? insertQuestionAnswersOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertQuestionAnswersOne = insertQuestionAnswersOne;
    _resultData['insertQuestionAnswersOne'] = l$insertQuestionAnswersOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertQuestionAnswersOne = insertQuestionAnswersOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertQuestionAnswersOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertQuestionAnswer || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertQuestionAnswersOne = insertQuestionAnswersOne;
    final lOther$insertQuestionAnswersOne = other.insertQuestionAnswersOne;
    if (l$insertQuestionAnswersOne != lOther$insertQuestionAnswersOne) {
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

const documentNodeMutationInsertQuestionAnswer = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InsertQuestionAnswer'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'questionSlug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'body')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertQuestionAnswersOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'questionSlug'),
                      value: VariableNode(name: NameNode(value: 'questionSlug')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'body'),
                      value: VariableNode(name: NameNode(value: 'body')),
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
                  name: NameNode(value: 'coupleId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'questionSlug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'body'),
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
MutationInsertQuestionAnswer _parserFnMutationInsertQuestionAnswer(Map<String, dynamic> data) =>
    MutationInsertQuestionAnswer.fromJson(data);
typedef OnMutationCompletedMutationInsertQuestionAnswer = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationInsertQuestionAnswer?,
);

class OptionsMutationInsertQuestionAnswer
    extends graphql.MutationOptions<MutationInsertQuestionAnswer> {
  OptionsMutationInsertQuestionAnswer({
    String? operationName,
    required VariablesMutationInsertQuestionAnswer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertQuestionAnswer? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationInsertQuestionAnswer? onCompleted,
    graphql.OnMutationUpdate<MutationInsertQuestionAnswer>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertQuestionAnswer',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationInsertQuestionAnswer(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationInsertQuestionAnswer,
         parserFn: _parserFnMutationInsertQuestionAnswer,
       );

  final OnMutationCompletedMutationInsertQuestionAnswer? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationInsertQuestionAnswer
    extends graphql.WatchQueryOptions<MutationInsertQuestionAnswer> {
  WatchOptionsMutationInsertQuestionAnswer({
    String? operationName,
    required VariablesMutationInsertQuestionAnswer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertQuestionAnswer? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertQuestionAnswer',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationInsertQuestionAnswer,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationInsertQuestionAnswer,
       );
}

extension ClientExtensionMutationInsertQuestionAnswer on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationInsertQuestionAnswer>> mutateInsertQuestionAnswer(
    OptionsMutationInsertQuestionAnswer options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationInsertQuestionAnswer> watchMutationInsertQuestionAnswer(
    WatchOptionsMutationInsertQuestionAnswer options,
  ) => this.watchMutation(options);
}

class MutationInsertQuestionAnswerinsertQuestionAnswersOne {
  MutationInsertQuestionAnswerinsertQuestionAnswersOne({
    required this.id,
    this.coupleId,
    required this.questionSlug,
    required this.body,
    this.$__typename = 'questionAnswers',
  });

  factory MutationInsertQuestionAnswerinsertQuestionAnswersOne.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$coupleId = json['coupleId'];
    final l$questionSlug = json['questionSlug'];
    final l$body = json['body'];
    final l$$__typename = json['__typename'];
    return MutationInsertQuestionAnswerinsertQuestionAnswersOne(
      id: (l$id as String),
      coupleId: (l$coupleId as String?),
      questionSlug: (l$questionSlug as String),
      body: (l$body as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? coupleId;

  final String questionSlug;

  final String body;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$questionSlug = questionSlug;
    _resultData['questionSlug'] = l$questionSlug;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$coupleId = coupleId;
    final l$questionSlug = questionSlug;
    final l$body = body;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$coupleId, l$questionSlug, l$body, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertQuestionAnswerinsertQuestionAnswersOne ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$questionSlug = questionSlug;
    final lOther$questionSlug = other.questionSlug;
    if (l$questionSlug != lOther$questionSlug) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
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
