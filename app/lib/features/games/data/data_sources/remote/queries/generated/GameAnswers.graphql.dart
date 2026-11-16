// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryGameAnswers {
  factory VariablesQueryGameAnswers({required String sessionId}) =>
      VariablesQueryGameAnswers._({r'sessionId': sessionId});

  VariablesQueryGameAnswers._(this._$data);

  factory VariablesQueryGameAnswers.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$sessionId = data['sessionId'];
    result$data['sessionId'] = (l$sessionId as String);
    return VariablesQueryGameAnswers._(result$data);
  }

  Map<String, dynamic> _$data;

  String get sessionId => (_$data['sessionId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$sessionId = sessionId;
    result$data['sessionId'] = l$sessionId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryGameAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$sessionId = sessionId;
    final lOther$sessionId = other.sessionId;
    if (l$sessionId != lOther$sessionId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$sessionId = sessionId;
    return Object.hashAll([l$sessionId]);
  }
}

class QueryGameAnswers {
  QueryGameAnswers({required this.gameAnswers, this.$__typename = 'query_root'});

  factory QueryGameAnswers.fromJson(Map<String, dynamic> json) {
    final l$gameAnswers = json['gameAnswers'];
    final l$$__typename = json['__typename'];
    return QueryGameAnswers(
      gameAnswers: (l$gameAnswers as List<dynamic>)
          .map((e) => QueryGameAnswersgameAnswers.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryGameAnswersgameAnswers> gameAnswers;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$gameAnswers = gameAnswers;
    _resultData['gameAnswers'] = l$gameAnswers.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$gameAnswers = gameAnswers;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$gameAnswers.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGameAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$gameAnswers = gameAnswers;
    final lOther$gameAnswers = other.gameAnswers;
    if (l$gameAnswers.length != lOther$gameAnswers.length) {
      return false;
    }
    for (int i = 0; i < l$gameAnswers.length; i++) {
      final l$gameAnswers$entry = l$gameAnswers[i];
      final lOther$gameAnswers$entry = lOther$gameAnswers[i];
      if (l$gameAnswers$entry != lOther$gameAnswers$entry) {
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

const documentNodeQueryGameAnswers = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GameAnswers'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'sessionId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'gameAnswers'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'sessionId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'sessionId')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '120'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'authorId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'idx'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer'),
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
QueryGameAnswers _parserFnQueryGameAnswers(Map<String, dynamic> data) =>
    QueryGameAnswers.fromJson(data);
typedef OnQueryCompleteQueryGameAnswers = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryGameAnswers?,
);

class OptionsQueryGameAnswers extends graphql.QueryOptions<QueryGameAnswers> {
  OptionsQueryGameAnswers({
    String? operationName,
    required VariablesQueryGameAnswers variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGameAnswers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryGameAnswers? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'GameAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryGameAnswers(data)),
         onError: onError,
         document: documentNodeQueryGameAnswers,
         parserFn: _parserFnQueryGameAnswers,
       );

  final OnQueryCompleteQueryGameAnswers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryGameAnswers extends graphql.WatchQueryOptions<QueryGameAnswers> {
  WatchOptionsQueryGameAnswers({
    String? operationName,
    required VariablesQueryGameAnswers variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGameAnswers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'GameAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGameAnswers,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryGameAnswers,
       );
}

class FetchMoreOptionsQueryGameAnswers extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryGameAnswers({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryGameAnswers variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGameAnswers,
       );
}

extension ClientExtensionQueryGameAnswers on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryGameAnswers>> queryGameAnswers(
    OptionsQueryGameAnswers options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryGameAnswers> watchQueryGameAnswers(
    WatchOptionsQueryGameAnswers options,
  ) => this.watchQuery(options);

  void writeQueryGameAnswers({
    required QueryGameAnswers data,
    required VariablesQueryGameAnswers variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGameAnswers),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryGameAnswers? readQueryGameAnswers({
    required VariablesQueryGameAnswers variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGameAnswers),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryGameAnswers.fromJson(result);
  }
}

class QueryGameAnswersgameAnswers {
  QueryGameAnswersgameAnswers({
    required this.authorId,
    required this.idx,
    required this.answer,
    this.$__typename = 'gameAnswers',
  });

  factory QueryGameAnswersgameAnswers.fromJson(Map<String, dynamic> json) {
    final l$authorId = json['authorId'];
    final l$idx = json['idx'];
    final l$answer = json['answer'];
    final l$$__typename = json['__typename'];
    return QueryGameAnswersgameAnswers(
      authorId: (l$authorId as String),
      idx: (l$idx as int),
      answer: (l$answer as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String authorId;

  final int idx;

  final String answer;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$idx = idx;
    _resultData['idx'] = l$idx;
    final l$answer = answer;
    _resultData['answer'] = l$answer;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$authorId = authorId;
    final l$idx = idx;
    final l$answer = answer;
    final l$$__typename = $__typename;
    return Object.hashAll([l$authorId, l$idx, l$answer, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGameAnswersgameAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
      return false;
    }
    final l$idx = idx;
    final lOther$idx = other.idx;
    if (l$idx != lOther$idx) {
      return false;
    }
    final l$answer = answer;
    final lOther$answer = other.answer;
    if (l$answer != lOther$answer) {
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
