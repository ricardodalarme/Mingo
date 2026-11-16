// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryMyCouple {
  QueryMyCouple({required this.today, this.$__typename = 'query_root'});

  factory QueryMyCouple.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    final l$$__typename = json['__typename'];
    return QueryMyCouple(
      today: (l$today as List<dynamic>)
          .map((e) => QueryMyCoupletoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMyCoupletoday> today;

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
    if (other is! QueryMyCouple || runtimeType != other.runtimeType) {
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

const documentNodeQueryMyCouple = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyCouple'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'today'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '1'),
              ),
            ],
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
QueryMyCouple _parserFnQueryMyCouple(Map<String, dynamic> data) => QueryMyCouple.fromJson(data);
typedef OnQueryCompleteQueryMyCouple = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyCouple?,
);

class OptionsQueryMyCouple extends graphql.QueryOptions<QueryMyCouple> {
  OptionsQueryMyCouple({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyCouple? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyCouple? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'MyCouple',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyCouple(data)),
         onError: onError,
         document: documentNodeQueryMyCouple,
         parserFn: _parserFnQueryMyCouple,
       );

  final OnQueryCompleteQueryMyCouple? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyCouple extends graphql.WatchQueryOptions<QueryMyCouple> {
  WatchOptionsQueryMyCouple({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyCouple? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'MyCouple',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyCouple,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyCouple,
       );
}

class FetchMoreOptionsQueryMyCouple extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyCouple({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryMyCouple);
}

extension ClientExtensionQueryMyCouple on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyCouple>> queryMyCouple([OptionsQueryMyCouple? options]) async =>
      await this.query(options ?? OptionsQueryMyCouple());

  graphql.ObservableQuery<QueryMyCouple> watchQueryMyCouple([WatchOptionsQueryMyCouple? options]) =>
      this.watchQuery(options ?? WatchOptionsQueryMyCouple());

  void writeQueryMyCouple({required QueryMyCouple data, bool broadcast = true}) => this.writeQuery(
    graphql.Request(operation: graphql.Operation(document: documentNodeQueryMyCouple)),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyCouple? readQueryMyCouple({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryMyCouple)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyCouple.fromJson(result);
  }
}

class QueryMyCoupletoday {
  QueryMyCoupletoday({this.userId, this.coupleId, this.$__typename = 'today'});

  factory QueryMyCoupletoday.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$coupleId = json['coupleId'];
    final l$$__typename = json['__typename'];
    return QueryMyCoupletoday(
      userId: (l$userId as String?),
      coupleId: (l$coupleId as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? userId;

  final String? coupleId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
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
    final l$userId = userId;
    final l$coupleId = coupleId;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$coupleId, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyCoupletoday || runtimeType != other.runtimeType) {
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
