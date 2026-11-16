// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryOpenGuidedSession {
  QueryOpenGuidedSession({required this.repairSessions, this.$__typename = 'query_root'});

  factory QueryOpenGuidedSession.fromJson(Map<String, dynamic> json) {
    final l$repairSessions = json['repairSessions'];
    final l$$__typename = json['__typename'];
    return QueryOpenGuidedSession(
      repairSessions: (l$repairSessions as List<dynamic>)
          .map((e) => QueryOpenGuidedSessionrepairSessions.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryOpenGuidedSessionrepairSessions> repairSessions;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$repairSessions = repairSessions;
    _resultData['repairSessions'] = l$repairSessions.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$repairSessions = repairSessions;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$repairSessions.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryOpenGuidedSession || runtimeType != other.runtimeType) {
      return false;
    }
    final l$repairSessions = repairSessions;
    final lOther$repairSessions = other.repairSessions;
    if (l$repairSessions.length != lOther$repairSessions.length) {
      return false;
    }
    for (int i = 0; i < l$repairSessions.length; i++) {
      final l$repairSessions$entry = l$repairSessions[i];
      final lOther$repairSessions$entry = lOther$repairSessions[i];
      if (l$repairSessions$entry != lOther$repairSessions$entry) {
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

const documentNodeQueryOpenGuidedSession = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'OpenGuidedSession'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'repairSessions'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'path'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: EnumValueNode(name: NameNode(value: 'guided')),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'completedAt'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_is_null'),
                            value: BooleanValueNode(value: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'createdAt'),
                      value: EnumValueNode(name: NameNode(value: 'desc')),
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
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'step'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'draft'),
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
QueryOpenGuidedSession _parserFnQueryOpenGuidedSession(Map<String, dynamic> data) =>
    QueryOpenGuidedSession.fromJson(data);
typedef OnQueryCompleteQueryOpenGuidedSession = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryOpenGuidedSession?,
);

class OptionsQueryOpenGuidedSession extends graphql.QueryOptions<QueryOpenGuidedSession> {
  OptionsQueryOpenGuidedSession({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryOpenGuidedSession? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryOpenGuidedSession? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'OpenGuidedSession',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryOpenGuidedSession(data)),
         onError: onError,
         document: documentNodeQueryOpenGuidedSession,
         parserFn: _parserFnQueryOpenGuidedSession,
       );

  final OnQueryCompleteQueryOpenGuidedSession? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryOpenGuidedSession extends graphql.WatchQueryOptions<QueryOpenGuidedSession> {
  WatchOptionsQueryOpenGuidedSession({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryOpenGuidedSession? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'OpenGuidedSession',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryOpenGuidedSession,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryOpenGuidedSession,
       );
}

class FetchMoreOptionsQueryOpenGuidedSession extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryOpenGuidedSession({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryOpenGuidedSession);
}

extension ClientExtensionQueryOpenGuidedSession on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryOpenGuidedSession>> queryOpenGuidedSession([
    OptionsQueryOpenGuidedSession? options,
  ]) async => await this.query(options ?? OptionsQueryOpenGuidedSession());

  graphql.ObservableQuery<QueryOpenGuidedSession> watchQueryOpenGuidedSession([
    WatchOptionsQueryOpenGuidedSession? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryOpenGuidedSession());

  void writeQueryOpenGuidedSession({required QueryOpenGuidedSession data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryOpenGuidedSession)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryOpenGuidedSession? readQueryOpenGuidedSession({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryOpenGuidedSession)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryOpenGuidedSession.fromJson(result);
  }
}

class QueryOpenGuidedSessionrepairSessions {
  QueryOpenGuidedSessionrepairSessions({
    required this.id,
    required this.step,
    this.draft,
    this.$__typename = 'repairSessions',
  });

  factory QueryOpenGuidedSessionrepairSessions.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$step = json['step'];
    final l$draft = json['draft'];
    final l$$__typename = json['__typename'];
    return QueryOpenGuidedSessionrepairSessions(
      id: (l$id as String),
      step: (l$step as int),
      draft: (l$draft as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final int step;

  final String? draft;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$step = step;
    _resultData['step'] = l$step;
    final l$draft = draft;
    _resultData['draft'] = l$draft;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$step = step;
    final l$draft = draft;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$step, l$draft, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryOpenGuidedSessionrepairSessions || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$step = step;
    final lOther$step = other.step;
    if (l$step != lOther$step) {
      return false;
    }
    final l$draft = draft;
    final lOther$draft = other.draft;
    if (l$draft != lOther$draft) {
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
