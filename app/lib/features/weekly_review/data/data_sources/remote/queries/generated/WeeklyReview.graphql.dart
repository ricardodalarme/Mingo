// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryWeeklyReview {
  QueryWeeklyReview({required this.weeklyReview, this.$__typename = 'query_root'});

  factory QueryWeeklyReview.fromJson(Map<String, dynamic> json) {
    final l$weeklyReview = json['weeklyReview'];
    final l$$__typename = json['__typename'];
    return QueryWeeklyReview(
      weeklyReview: (l$weeklyReview as List<dynamic>)
          .map((e) => QueryWeeklyReviewweeklyReview.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryWeeklyReviewweeklyReview> weeklyReview;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$weeklyReview = weeklyReview;
    _resultData['weeklyReview'] = l$weeklyReview.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$weeklyReview = weeklyReview;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$weeklyReview.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWeeklyReview || runtimeType != other.runtimeType) {
      return false;
    }
    final l$weeklyReview = weeklyReview;
    final lOther$weeklyReview = other.weeklyReview;
    if (l$weeklyReview.length != lOther$weeklyReview.length) {
      return false;
    }
    for (int i = 0; i < l$weeklyReview.length; i++) {
      final l$weeklyReview$entry = l$weeklyReview[i];
      final lOther$weeklyReview$entry = lOther$weeklyReview[i];
      if (l$weeklyReview$entry != lOther$weeklyReview$entry) {
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

const documentNodeQueryWeeklyReview = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'WeeklyReview'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'weeklyReview'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(fields: []),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'weekStart'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'slips'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'moodsLogged'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'ritualsDone'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'activeDays'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'lowData'),
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
QueryWeeklyReview _parserFnQueryWeeklyReview(Map<String, dynamic> data) =>
    QueryWeeklyReview.fromJson(data);
typedef OnQueryCompleteQueryWeeklyReview = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryWeeklyReview?,
);

class OptionsQueryWeeklyReview extends graphql.QueryOptions<QueryWeeklyReview> {
  OptionsQueryWeeklyReview({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryWeeklyReview? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryWeeklyReview? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'WeeklyReview',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryWeeklyReview(data)),
         onError: onError,
         document: documentNodeQueryWeeklyReview,
         parserFn: _parserFnQueryWeeklyReview,
       );

  final OnQueryCompleteQueryWeeklyReview? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryWeeklyReview extends graphql.WatchQueryOptions<QueryWeeklyReview> {
  WatchOptionsQueryWeeklyReview({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryWeeklyReview? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WeeklyReview',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryWeeklyReview,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryWeeklyReview,
       );
}

class FetchMoreOptionsQueryWeeklyReview extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryWeeklyReview({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryWeeklyReview);
}

extension ClientExtensionQueryWeeklyReview on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryWeeklyReview>> queryWeeklyReview([
    OptionsQueryWeeklyReview? options,
  ]) async => await this.query(options ?? OptionsQueryWeeklyReview());

  graphql.ObservableQuery<QueryWeeklyReview> watchQueryWeeklyReview([
    WatchOptionsQueryWeeklyReview? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryWeeklyReview());

  void writeQueryWeeklyReview({required QueryWeeklyReview data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryWeeklyReview)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryWeeklyReview? readQueryWeeklyReview({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryWeeklyReview)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryWeeklyReview.fromJson(result);
  }
}

class QueryWeeklyReviewweeklyReview {
  QueryWeeklyReviewweeklyReview({
    required this.weekStart,
    required this.slips,
    required this.moodsLogged,
    required this.ritualsDone,
    required this.activeDays,
    required this.lowData,
    this.$__typename = 'weeklyReviews',
  });

  factory QueryWeeklyReviewweeklyReview.fromJson(Map<String, dynamic> json) {
    final l$weekStart = json['weekStart'];
    final l$slips = json['slips'];
    final l$moodsLogged = json['moodsLogged'];
    final l$ritualsDone = json['ritualsDone'];
    final l$activeDays = json['activeDays'];
    final l$lowData = json['lowData'];
    final l$$__typename = json['__typename'];
    return QueryWeeklyReviewweeklyReview(
      weekStart: DateTime.parse((l$weekStart as String)),
      slips: (l$slips as int),
      moodsLogged: (l$moodsLogged as int),
      ritualsDone: (l$ritualsDone as int),
      activeDays: (l$activeDays as int),
      lowData: (l$lowData as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime weekStart;

  final int slips;

  final int moodsLogged;

  final int ritualsDone;

  final int activeDays;

  final bool lowData;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$weekStart = weekStart;
    _resultData['weekStart'] = ((v) => v.toIso8601String().substring(0, 10))(l$weekStart);
    final l$slips = slips;
    _resultData['slips'] = l$slips;
    final l$moodsLogged = moodsLogged;
    _resultData['moodsLogged'] = l$moodsLogged;
    final l$ritualsDone = ritualsDone;
    _resultData['ritualsDone'] = l$ritualsDone;
    final l$activeDays = activeDays;
    _resultData['activeDays'] = l$activeDays;
    final l$lowData = lowData;
    _resultData['lowData'] = l$lowData;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$weekStart = weekStart;
    final l$slips = slips;
    final l$moodsLogged = moodsLogged;
    final l$ritualsDone = ritualsDone;
    final l$activeDays = activeDays;
    final l$lowData = lowData;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$weekStart,
      l$slips,
      l$moodsLogged,
      l$ritualsDone,
      l$activeDays,
      l$lowData,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWeeklyReviewweeklyReview || runtimeType != other.runtimeType) {
      return false;
    }
    final l$weekStart = weekStart;
    final lOther$weekStart = other.weekStart;
    if (l$weekStart != lOther$weekStart) {
      return false;
    }
    final l$slips = slips;
    final lOther$slips = other.slips;
    if (l$slips != lOther$slips) {
      return false;
    }
    final l$moodsLogged = moodsLogged;
    final lOther$moodsLogged = other.moodsLogged;
    if (l$moodsLogged != lOther$moodsLogged) {
      return false;
    }
    final l$ritualsDone = ritualsDone;
    final lOther$ritualsDone = other.ritualsDone;
    if (l$ritualsDone != lOther$ritualsDone) {
      return false;
    }
    final l$activeDays = activeDays;
    final lOther$activeDays = other.activeDays;
    if (l$activeDays != lOther$activeDays) {
      return false;
    }
    final l$lowData = lowData;
    final lOther$lowData = other.lowData;
    if (l$lowData != lOther$lowData) {
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
