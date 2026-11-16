// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryQuestionOfTheWeek {
  QueryQuestionOfTheWeek({
    required this.question,
    required this.today,
    this.$__typename = 'query_root',
  });

  factory QueryQuestionOfTheWeek.fromJson(Map<String, dynamic> json) {
    final l$question = json['question'];
    final l$today = json['today'];
    final l$$__typename = json['__typename'];
    return QueryQuestionOfTheWeek(
      question: (l$question as List<dynamic>)
          .map((e) => QueryQuestionOfTheWeekquestion.fromJson((e as Map<String, dynamic>)))
          .toList(),
      today: (l$today as List<dynamic>)
          .map((e) => QueryQuestionOfTheWeektoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryQuestionOfTheWeekquestion> question;

  final List<QueryQuestionOfTheWeektoday> today;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$question = question;
    _resultData['question'] = l$question.map((e) => e.toJson()).toList();
    final l$today = today;
    _resultData['today'] = l$today.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$question = question;
    final l$today = today;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$question.map((v) => v)),
      Object.hashAll(l$today.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryQuestionOfTheWeek || runtimeType != other.runtimeType) {
      return false;
    }
    final l$question = question;
    final lOther$question = other.question;
    if (l$question.length != lOther$question.length) {
      return false;
    }
    for (int i = 0; i < l$question.length; i++) {
      final l$question$entry = l$question[i];
      final lOther$question$entry = lOther$question[i];
      if (l$question$entry != lOther$question$entry) {
        return false;
      }
    }
    final l$today = today;
    final lOther$today = other.today;
    if (l$today.length != lOther$today.length) {
      return false;
    }
    for (int i = 0; i < l$today.length; i++) {
      final l$today$entry = l$today[i];
      final lOther$today$entry = lOther$today[i];
      if (l$today$entry != lOther$today$entry) {
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

const documentNodeQueryQuestionOfTheWeek = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'QuestionOfTheWeek'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'dailyContent'),
            alias: NameNode(value: 'question'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'kind'),
                      value: StringValueNode(value: 'question', isBlock: false),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '1'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'slug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'title'),
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
                  name: NameNode(value: 'tags'),
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
            name: NameNode(value: 'today'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'userId'),
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
                  name: NameNode(value: 'partnerName'),
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
QueryQuestionOfTheWeek _parserFnQueryQuestionOfTheWeek(Map<String, dynamic> data) =>
    QueryQuestionOfTheWeek.fromJson(data);
typedef OnQueryCompleteQueryQuestionOfTheWeek = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryQuestionOfTheWeek?,
);

class OptionsQueryQuestionOfTheWeek extends graphql.QueryOptions<QueryQuestionOfTheWeek> {
  OptionsQueryQuestionOfTheWeek({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryQuestionOfTheWeek? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryQuestionOfTheWeek? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'QuestionOfTheWeek',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryQuestionOfTheWeek(data)),
         onError: onError,
         document: documentNodeQueryQuestionOfTheWeek,
         parserFn: _parserFnQueryQuestionOfTheWeek,
       );

  final OnQueryCompleteQueryQuestionOfTheWeek? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryQuestionOfTheWeek extends graphql.WatchQueryOptions<QueryQuestionOfTheWeek> {
  WatchOptionsQueryQuestionOfTheWeek({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryQuestionOfTheWeek? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'QuestionOfTheWeek',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryQuestionOfTheWeek,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryQuestionOfTheWeek,
       );
}

class FetchMoreOptionsQueryQuestionOfTheWeek extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryQuestionOfTheWeek({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryQuestionOfTheWeek);
}

extension ClientExtensionQueryQuestionOfTheWeek on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryQuestionOfTheWeek>> queryQuestionOfTheWeek([
    OptionsQueryQuestionOfTheWeek? options,
  ]) async => await this.query(options ?? OptionsQueryQuestionOfTheWeek());

  graphql.ObservableQuery<QueryQuestionOfTheWeek> watchQueryQuestionOfTheWeek([
    WatchOptionsQueryQuestionOfTheWeek? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryQuestionOfTheWeek());

  void writeQueryQuestionOfTheWeek({required QueryQuestionOfTheWeek data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryQuestionOfTheWeek)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryQuestionOfTheWeek? readQueryQuestionOfTheWeek({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryQuestionOfTheWeek)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryQuestionOfTheWeek.fromJson(result);
  }
}

class QueryQuestionOfTheWeekquestion {
  QueryQuestionOfTheWeekquestion({
    required this.slug,
    required this.title,
    this.body,
    required this.tags,
    this.$__typename = 'contentItems',
  });

  factory QueryQuestionOfTheWeekquestion.fromJson(Map<String, dynamic> json) {
    final l$slug = json['slug'];
    final l$title = json['title'];
    final l$body = json['body'];
    final l$tags = json['tags'];
    final l$$__typename = json['__typename'];
    return QueryQuestionOfTheWeekquestion(
      slug: (l$slug as String),
      title: (l$title as String),
      body: (l$body as String?),
      tags: (l$tags as List<dynamic>).map((e) => (e as String)).toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String slug;

  final String title;

  final String? body;

  final List<String> tags;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$tags = tags;
    _resultData['tags'] = l$tags.map((e) => e).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$slug = slug;
    final l$title = title;
    final l$body = body;
    final l$tags = tags;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$slug,
      l$title,
      l$body,
      Object.hashAll(l$tags.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryQuestionOfTheWeekquestion || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$tags = tags;
    final lOther$tags = other.tags;
    if (l$tags.length != lOther$tags.length) {
      return false;
    }
    for (int i = 0; i < l$tags.length; i++) {
      final l$tags$entry = l$tags[i];
      final lOther$tags$entry = lOther$tags[i];
      if (l$tags$entry != lOther$tags$entry) {
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

class QueryQuestionOfTheWeektoday {
  QueryQuestionOfTheWeektoday({
    this.userId,
    this.coupleId,
    this.partnerName,
    this.$__typename = 'today',
  });

  factory QueryQuestionOfTheWeektoday.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$coupleId = json['coupleId'];
    final l$partnerName = json['partnerName'];
    final l$$__typename = json['__typename'];
    return QueryQuestionOfTheWeektoday(
      userId: (l$userId as String?),
      coupleId: (l$coupleId as String?),
      partnerName: (l$partnerName as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? userId;

  final String? coupleId;

  final String? partnerName;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$partnerName = partnerName;
    _resultData['partnerName'] = l$partnerName;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$coupleId = coupleId;
    final l$partnerName = partnerName;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$coupleId, l$partnerName, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryQuestionOfTheWeektoday || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$partnerName = partnerName;
    final lOther$partnerName = other.partnerName;
    if (l$partnerName != lOther$partnerName) {
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
