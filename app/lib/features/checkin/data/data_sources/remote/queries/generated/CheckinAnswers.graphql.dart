// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryCheckinAnswers {
  factory VariablesQueryCheckinAnswers({required DateTime weekStart, required String coupleId}) =>
      VariablesQueryCheckinAnswers._({r'weekStart': weekStart, r'coupleId': coupleId});

  VariablesQueryCheckinAnswers._(this._$data);

  factory VariablesQueryCheckinAnswers.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$weekStart = data['weekStart'];
    result$data['weekStart'] = DateTime.parse((l$weekStart as String));
    final l$coupleId = data['coupleId'];
    result$data['coupleId'] = (l$coupleId as String);
    return VariablesQueryCheckinAnswers._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime get weekStart => (_$data['weekStart'] as DateTime);

  String get coupleId => (_$data['coupleId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$weekStart = weekStart;
    result$data['weekStart'] = ((v) => v.toIso8601String().substring(0, 10))(l$weekStart);
    final l$coupleId = coupleId;
    result$data['coupleId'] = l$coupleId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryCheckinAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$weekStart = weekStart;
    final lOther$weekStart = other.weekStart;
    if (l$weekStart != lOther$weekStart) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$weekStart = weekStart;
    final l$coupleId = coupleId;
    return Object.hashAll([l$weekStart, l$coupleId]);
  }
}

class QueryCheckinAnswers {
  QueryCheckinAnswers({required this.checkins, this.$__typename = 'query_root'});

  factory QueryCheckinAnswers.fromJson(Map<String, dynamic> json) {
    final l$checkins = json['checkins'];
    final l$$__typename = json['__typename'];
    return QueryCheckinAnswers(
      checkins: (l$checkins as List<dynamic>)
          .map((e) => QueryCheckinAnswerscheckins.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryCheckinAnswerscheckins> checkins;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$checkins = checkins;
    _resultData['checkins'] = l$checkins.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$checkins = checkins;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$checkins.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCheckinAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$checkins = checkins;
    final lOther$checkins = other.checkins;
    if (l$checkins.length != lOther$checkins.length) {
      return false;
    }
    for (int i = 0; i < l$checkins.length; i++) {
      final l$checkins$entry = l$checkins[i];
      final lOther$checkins$entry = lOther$checkins[i];
      if (l$checkins$entry != lOther$checkins$entry) {
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

const documentNodeQueryCheckinAnswers = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'CheckinAnswers'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'weekStart')),
          type: NamedTypeNode(name: NameNode(value: 'date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'coupleId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'checkins'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'weekStart'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'weekStart')),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'coupleId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'coupleId')),
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
                  name: NameNode(value: 'weekStart'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer1'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer2'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer3'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer4'),
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
QueryCheckinAnswers _parserFnQueryCheckinAnswers(Map<String, dynamic> data) =>
    QueryCheckinAnswers.fromJson(data);
typedef OnQueryCompleteQueryCheckinAnswers = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryCheckinAnswers?,
);

class OptionsQueryCheckinAnswers extends graphql.QueryOptions<QueryCheckinAnswers> {
  OptionsQueryCheckinAnswers({
    String? operationName,
    required VariablesQueryCheckinAnswers variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCheckinAnswers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryCheckinAnswers? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CheckinAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryCheckinAnswers(data)),
         onError: onError,
         document: documentNodeQueryCheckinAnswers,
         parserFn: _parserFnQueryCheckinAnswers,
       );

  final OnQueryCompleteQueryCheckinAnswers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryCheckinAnswers extends graphql.WatchQueryOptions<QueryCheckinAnswers> {
  WatchOptionsQueryCheckinAnswers({
    String? operationName,
    required VariablesQueryCheckinAnswers variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCheckinAnswers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CheckinAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryCheckinAnswers,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryCheckinAnswers,
       );
}

class FetchMoreOptionsQueryCheckinAnswers extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryCheckinAnswers({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryCheckinAnswers variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryCheckinAnswers,
       );
}

extension ClientExtensionQueryCheckinAnswers on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryCheckinAnswers>> queryCheckinAnswers(
    OptionsQueryCheckinAnswers options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryCheckinAnswers> watchQueryCheckinAnswers(
    WatchOptionsQueryCheckinAnswers options,
  ) => this.watchQuery(options);

  void writeQueryCheckinAnswers({
    required QueryCheckinAnswers data,
    required VariablesQueryCheckinAnswers variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryCheckinAnswers),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryCheckinAnswers? readQueryCheckinAnswers({
    required VariablesQueryCheckinAnswers variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryCheckinAnswers),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryCheckinAnswers.fromJson(result);
  }
}

class QueryCheckinAnswerscheckins {
  QueryCheckinAnswerscheckins({
    required this.id,
    required this.authorId,
    required this.weekStart,
    this.answer1,
    this.answer2,
    this.answer3,
    this.answer4,
    this.$__typename = 'checkins',
  });

  factory QueryCheckinAnswerscheckins.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$authorId = json['authorId'];
    final l$weekStart = json['weekStart'];
    final l$answer1 = json['answer1'];
    final l$answer2 = json['answer2'];
    final l$answer3 = json['answer3'];
    final l$answer4 = json['answer4'];
    final l$$__typename = json['__typename'];
    return QueryCheckinAnswerscheckins(
      id: (l$id as String),
      authorId: (l$authorId as String),
      weekStart: DateTime.parse((l$weekStart as String)),
      answer1: (l$answer1 as String?),
      answer2: (l$answer2 as String?),
      answer3: (l$answer3 as String?),
      answer4: (l$answer4 as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String authorId;

  final DateTime weekStart;

  final String? answer1;

  final String? answer2;

  final String? answer3;

  final String? answer4;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$weekStart = weekStart;
    _resultData['weekStart'] = ((v) => v.toIso8601String().substring(0, 10))(l$weekStart);
    final l$answer1 = answer1;
    _resultData['answer1'] = l$answer1;
    final l$answer2 = answer2;
    _resultData['answer2'] = l$answer2;
    final l$answer3 = answer3;
    _resultData['answer3'] = l$answer3;
    final l$answer4 = answer4;
    _resultData['answer4'] = l$answer4;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$authorId = authorId;
    final l$weekStart = weekStart;
    final l$answer1 = answer1;
    final l$answer2 = answer2;
    final l$answer3 = answer3;
    final l$answer4 = answer4;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$authorId,
      l$weekStart,
      l$answer1,
      l$answer2,
      l$answer3,
      l$answer4,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCheckinAnswerscheckins || runtimeType != other.runtimeType) {
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
    final l$weekStart = weekStart;
    final lOther$weekStart = other.weekStart;
    if (l$weekStart != lOther$weekStart) {
      return false;
    }
    final l$answer1 = answer1;
    final lOther$answer1 = other.answer1;
    if (l$answer1 != lOther$answer1) {
      return false;
    }
    final l$answer2 = answer2;
    final lOther$answer2 = other.answer2;
    if (l$answer2 != lOther$answer2) {
      return false;
    }
    final l$answer3 = answer3;
    final lOther$answer3 = other.answer3;
    if (l$answer3 != lOther$answer3) {
      return false;
    }
    final l$answer4 = answer4;
    final lOther$answer4 = other.answer4;
    if (l$answer4 != lOther$answer4) {
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
