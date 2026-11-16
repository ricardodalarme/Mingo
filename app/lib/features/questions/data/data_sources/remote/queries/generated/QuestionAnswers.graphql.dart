// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryQuestionAnswers {
  factory VariablesQueryQuestionAnswers({required String questionSlug}) =>
      VariablesQueryQuestionAnswers._({r'questionSlug': questionSlug});

  VariablesQueryQuestionAnswers._(this._$data);

  factory VariablesQueryQuestionAnswers.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$questionSlug = data['questionSlug'];
    result$data['questionSlug'] = (l$questionSlug as String);
    return VariablesQueryQuestionAnswers._(result$data);
  }

  Map<String, dynamic> _$data;

  String get questionSlug => (_$data['questionSlug'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$questionSlug = questionSlug;
    result$data['questionSlug'] = l$questionSlug;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryQuestionAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$questionSlug = questionSlug;
    final lOther$questionSlug = other.questionSlug;
    if (l$questionSlug != lOther$questionSlug) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$questionSlug = questionSlug;
    return Object.hashAll([l$questionSlug]);
  }
}

class QueryQuestionAnswers {
  QueryQuestionAnswers({required this.questionAnswers, this.$__typename = 'query_root'});

  factory QueryQuestionAnswers.fromJson(Map<String, dynamic> json) {
    final l$questionAnswers = json['questionAnswers'];
    final l$$__typename = json['__typename'];
    return QueryQuestionAnswers(
      questionAnswers: (l$questionAnswers as List<dynamic>)
          .map((e) => QueryQuestionAnswersquestionAnswers.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryQuestionAnswersquestionAnswers> questionAnswers;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$questionAnswers = questionAnswers;
    _resultData['questionAnswers'] = l$questionAnswers.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$questionAnswers = questionAnswers;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$questionAnswers.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryQuestionAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$questionAnswers = questionAnswers;
    final lOther$questionAnswers = other.questionAnswers;
    if (l$questionAnswers.length != lOther$questionAnswers.length) {
      return false;
    }
    for (int i = 0; i < l$questionAnswers.length; i++) {
      final l$questionAnswers$entry = l$questionAnswers[i];
      final lOther$questionAnswers$entry = lOther$questionAnswers[i];
      if (l$questionAnswers$entry != lOther$questionAnswers$entry) {
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

const documentNodeQueryQuestionAnswers = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'QuestionAnswers'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'questionSlug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'questionAnswers'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'questionSlug'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'questionSlug')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '10'),
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
                  name: NameNode(value: 'authorId'),
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
QueryQuestionAnswers _parserFnQueryQuestionAnswers(Map<String, dynamic> data) =>
    QueryQuestionAnswers.fromJson(data);
typedef OnQueryCompleteQueryQuestionAnswers = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryQuestionAnswers?,
);

class OptionsQueryQuestionAnswers extends graphql.QueryOptions<QueryQuestionAnswers> {
  OptionsQueryQuestionAnswers({
    String? operationName,
    required VariablesQueryQuestionAnswers variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryQuestionAnswers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryQuestionAnswers? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'QuestionAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryQuestionAnswers(data)),
         onError: onError,
         document: documentNodeQueryQuestionAnswers,
         parserFn: _parserFnQueryQuestionAnswers,
       );

  final OnQueryCompleteQueryQuestionAnswers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryQuestionAnswers extends graphql.WatchQueryOptions<QueryQuestionAnswers> {
  WatchOptionsQueryQuestionAnswers({
    String? operationName,
    required VariablesQueryQuestionAnswers variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryQuestionAnswers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'QuestionAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryQuestionAnswers,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryQuestionAnswers,
       );
}

class FetchMoreOptionsQueryQuestionAnswers extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryQuestionAnswers({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryQuestionAnswers variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryQuestionAnswers,
       );
}

extension ClientExtensionQueryQuestionAnswers on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryQuestionAnswers>> queryQuestionAnswers(
    OptionsQueryQuestionAnswers options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryQuestionAnswers> watchQueryQuestionAnswers(
    WatchOptionsQueryQuestionAnswers options,
  ) => this.watchQuery(options);

  void writeQueryQuestionAnswers({
    required QueryQuestionAnswers data,
    required VariablesQueryQuestionAnswers variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryQuestionAnswers),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryQuestionAnswers? readQueryQuestionAnswers({
    required VariablesQueryQuestionAnswers variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryQuestionAnswers),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryQuestionAnswers.fromJson(result);
  }
}

class QueryQuestionAnswersquestionAnswers {
  QueryQuestionAnswersquestionAnswers({
    required this.id,
    required this.authorId,
    this.coupleId,
    required this.questionSlug,
    required this.body,
    this.$__typename = 'questionAnswers',
  });

  factory QueryQuestionAnswersquestionAnswers.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$questionSlug = json['questionSlug'];
    final l$body = json['body'];
    final l$$__typename = json['__typename'];
    return QueryQuestionAnswersquestionAnswers(
      id: (l$id as String),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      questionSlug: (l$questionSlug as String),
      body: (l$body as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String authorId;

  final String? coupleId;

  final String questionSlug;

  final String body;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
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
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$questionSlug = questionSlug;
    final l$body = body;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$authorId, l$coupleId, l$questionSlug, l$body, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryQuestionAnswersquestionAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
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
