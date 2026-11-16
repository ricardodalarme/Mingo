// dart format width=100
import '../../fragments/generated/GameSessionFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryGameSessions {
  QueryGameSessions({
    required this.today,
    required this.gameSessions,
    this.$__typename = 'query_root',
  });

  factory QueryGameSessions.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    final l$gameSessions = json['gameSessions'];
    final l$$__typename = json['__typename'];
    return QueryGameSessions(
      today: (l$today as List<dynamic>)
          .map((e) => QueryGameSessionstoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      gameSessions: (l$gameSessions as List<dynamic>)
          .map((e) => FragmentGameSessionFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryGameSessionstoday> today;

  final List<FragmentGameSessionFragment> gameSessions;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$today = today;
    _resultData['today'] = l$today.map((e) => e.toJson()).toList();
    final l$gameSessions = gameSessions;
    _resultData['gameSessions'] = l$gameSessions.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$today = today;
    final l$gameSessions = gameSessions;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$today.map((v) => v)),
      Object.hashAll(l$gameSessions.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGameSessions || runtimeType != other.runtimeType) {
      return false;
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
    final l$gameSessions = gameSessions;
    final lOther$gameSessions = other.gameSessions;
    if (l$gameSessions.length != lOther$gameSessions.length) {
      return false;
    }
    for (int i = 0; i < l$gameSessions.length; i++) {
      final l$gameSessions$entry = l$gameSessions[i];
      final lOther$gameSessions$entry = lOther$gameSessions[i];
      if (l$gameSessions$entry != lOther$gameSessions$entry) {
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

const documentNodeQueryGameSessions = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GameSessions'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
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
            name: NameNode(value: 'gameSessions'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '40'),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'createdAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'GameSessionFragment'),
                  directives: [],
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
    fragmentDefinitionGameSessionFragment,
  ],
);
QueryGameSessions _parserFnQueryGameSessions(Map<String, dynamic> data) =>
    QueryGameSessions.fromJson(data);
typedef OnQueryCompleteQueryGameSessions = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryGameSessions?,
);

class OptionsQueryGameSessions extends graphql.QueryOptions<QueryGameSessions> {
  OptionsQueryGameSessions({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGameSessions? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryGameSessions? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'GameSessions',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryGameSessions(data)),
         onError: onError,
         document: documentNodeQueryGameSessions,
         parserFn: _parserFnQueryGameSessions,
       );

  final OnQueryCompleteQueryGameSessions? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryGameSessions extends graphql.WatchQueryOptions<QueryGameSessions> {
  WatchOptionsQueryGameSessions({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGameSessions? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'GameSessions',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGameSessions,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryGameSessions,
       );
}

class FetchMoreOptionsQueryGameSessions extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryGameSessions({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryGameSessions);
}

extension ClientExtensionQueryGameSessions on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryGameSessions>> queryGameSessions([
    OptionsQueryGameSessions? options,
  ]) async => await this.query(options ?? OptionsQueryGameSessions());

  graphql.ObservableQuery<QueryGameSessions> watchQueryGameSessions([
    WatchOptionsQueryGameSessions? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryGameSessions());

  void writeQueryGameSessions({required QueryGameSessions data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryGameSessions)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryGameSessions? readQueryGameSessions({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryGameSessions)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryGameSessions.fromJson(result);
  }
}

class QueryGameSessionstoday {
  QueryGameSessionstoday({
    this.userId,
    this.coupleId,
    this.partnerName,
    this.$__typename = 'today',
  });

  factory QueryGameSessionstoday.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$coupleId = json['coupleId'];
    final l$partnerName = json['partnerName'];
    final l$$__typename = json['__typename'];
    return QueryGameSessionstoday(
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
    if (other is! QueryGameSessionstoday || runtimeType != other.runtimeType) {
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
