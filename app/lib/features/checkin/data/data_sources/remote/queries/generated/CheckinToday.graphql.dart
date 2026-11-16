// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryCheckinToday {
  QueryCheckinToday({required this.today, this.$__typename = 'query_root'});

  factory QueryCheckinToday.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    final l$$__typename = json['__typename'];
    return QueryCheckinToday(
      today: (l$today as List<dynamic>)
          .map((e) => QueryCheckinTodaytoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryCheckinTodaytoday> today;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$today = today;
    _resultData['today'] = l$today.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$today = today;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$today.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCheckinToday || runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

const documentNodeQueryCheckinToday = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'CheckinToday'),
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
                  name: NameNode(value: 'localDate'),
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
QueryCheckinToday _parserFnQueryCheckinToday(Map<String, dynamic> data) =>
    QueryCheckinToday.fromJson(data);
typedef OnQueryCompleteQueryCheckinToday = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryCheckinToday?,
);

class OptionsQueryCheckinToday extends graphql.QueryOptions<QueryCheckinToday> {
  OptionsQueryCheckinToday({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCheckinToday? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryCheckinToday? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'CheckinToday',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryCheckinToday(data)),
         onError: onError,
         document: documentNodeQueryCheckinToday,
         parserFn: _parserFnQueryCheckinToday,
       );

  final OnQueryCompleteQueryCheckinToday? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryCheckinToday extends graphql.WatchQueryOptions<QueryCheckinToday> {
  WatchOptionsQueryCheckinToday({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCheckinToday? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'CheckinToday',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryCheckinToday,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryCheckinToday,
       );
}

class FetchMoreOptionsQueryCheckinToday extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryCheckinToday({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryCheckinToday);
}

extension ClientExtensionQueryCheckinToday on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryCheckinToday>> queryCheckinToday([
    OptionsQueryCheckinToday? options,
  ]) async => await this.query(options ?? OptionsQueryCheckinToday());

  graphql.ObservableQuery<QueryCheckinToday> watchQueryCheckinToday([
    WatchOptionsQueryCheckinToday? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryCheckinToday());

  void writeQueryCheckinToday({required QueryCheckinToday data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryCheckinToday)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryCheckinToday? readQueryCheckinToday({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryCheckinToday)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryCheckinToday.fromJson(result);
  }
}

class QueryCheckinTodaytoday {
  QueryCheckinTodaytoday({
    this.localDate,
    this.partnerName,
    this.userId,
    this.coupleId,
    this.$__typename = 'today',
  });

  factory QueryCheckinTodaytoday.fromJson(Map<String, dynamic> json) {
    final l$localDate = json['localDate'];
    final l$partnerName = json['partnerName'];
    final l$userId = json['userId'];
    final l$coupleId = json['coupleId'];
    final l$$__typename = json['__typename'];
    return QueryCheckinTodaytoday(
      localDate: l$localDate == null ? null : DateTime.parse((l$localDate as String)),
      partnerName: (l$partnerName as String?),
      userId: (l$userId as String?),
      coupleId: (l$coupleId as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime? localDate;

  final String? partnerName;

  final String? userId;

  final String? coupleId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$localDate = localDate;
    _resultData['localDate'] = l$localDate == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$localDate);
    final l$partnerName = partnerName;
    _resultData['partnerName'] = l$partnerName;
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$localDate = localDate;
    final l$partnerName = partnerName;
    final l$userId = userId;
    final l$coupleId = coupleId;
    final l$$__typename = $__typename;
    return Object.hashAll([l$localDate, l$partnerName, l$userId, l$coupleId, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCheckinTodaytoday || runtimeType != other.runtimeType) {
      return false;
    }
    final l$localDate = localDate;
    final lOther$localDate = other.localDate;
    if (l$localDate != lOther$localDate) {
      return false;
    }
    final l$partnerName = partnerName;
    final lOther$partnerName = other.partnerName;
    if (l$partnerName != lOther$partnerName) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}
