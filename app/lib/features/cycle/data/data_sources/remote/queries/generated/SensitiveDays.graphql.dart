// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QuerySensitiveDays {
  QuerySensitiveDays({this.today, required this.cycleDaysCollection, this.$__typename = 'Query'});

  factory QuerySensitiveDays.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    final l$cycleDaysCollection = json['cycleDaysCollection'];
    final l$$__typename = json['__typename'];
    return QuerySensitiveDays(
      today: l$today == null
          ? null
          : QuerySensitiveDaystoday.fromJson((l$today as Map<String, dynamic>)),
      cycleDaysCollection: QuerySensitiveDayscycleDaysCollection.fromJson(
        (l$cycleDaysCollection as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final QuerySensitiveDaystoday? today;

  final QuerySensitiveDayscycleDaysCollection cycleDaysCollection;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$today = today;
    _resultData['today'] = l$today?.toJson();
    final l$cycleDaysCollection = cycleDaysCollection;
    _resultData['cycleDaysCollection'] = l$cycleDaysCollection.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$today = today;
    final l$cycleDaysCollection = cycleDaysCollection;
    final l$$__typename = $__typename;
    return Object.hashAll([l$today, l$cycleDaysCollection, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySensitiveDays || runtimeType != other.runtimeType) {
      return false;
    }
    final l$today = today;
    final lOther$today = other.today;
    if (l$today != lOther$today) {
      return false;
    }
    final l$cycleDaysCollection = cycleDaysCollection;
    final lOther$cycleDaysCollection = other.cycleDaysCollection;
    if (l$cycleDaysCollection != lOther$cycleDaysCollection) {
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

const documentNodeQuerySensitiveDays = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SensitiveDays'),
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
            name: NameNode(value: 'cycleDaysCollection'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'first'),
                value: IntValueNode(value: '1000'),
              ),
              ArgumentNode(
                name: NameNode(value: 'filter'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'kind'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: 'eq'),
                            value: EnumValueNode(name: NameNode(value: 'heavy')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'orderBy'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'day'),
                          value: EnumValueNode(name: NameNode(value: 'DescNullsLast')),
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
                FieldNode(
                  name: NameNode(value: 'edges'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'node'),
                        alias: null,
                        arguments: [],
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
                              name: NameNode(value: 'day'),
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
QuerySensitiveDays _parserFnQuerySensitiveDays(Map<String, dynamic> data) =>
    QuerySensitiveDays.fromJson(data);
typedef OnQueryCompleteQuerySensitiveDays = FutureOr<void> Function(
  Map<String, dynamic>?,
  QuerySensitiveDays?,
);

class OptionsQuerySensitiveDays extends graphql.QueryOptions<QuerySensitiveDays> {
  OptionsQuerySensitiveDays({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySensitiveDays? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQuerySensitiveDays? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'SensitiveDays',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQuerySensitiveDays(data)),
         onError: onError,
         document: documentNodeQuerySensitiveDays,
         parserFn: _parserFnQuerySensitiveDays,
       );

  final OnQueryCompleteQuerySensitiveDays? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQuerySensitiveDays extends graphql.WatchQueryOptions<QuerySensitiveDays> {
  WatchOptionsQuerySensitiveDays({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySensitiveDays? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'SensitiveDays',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQuerySensitiveDays,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQuerySensitiveDays,
       );
}

class FetchMoreOptionsQuerySensitiveDays extends graphql.FetchMoreOptions {
  FetchMoreOptionsQuerySensitiveDays({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQuerySensitiveDays);
}

extension ClientExtensionQuerySensitiveDays on graphql.GraphQLClient {
  Future<graphql.QueryResult<QuerySensitiveDays>> querySensitiveDays([
    OptionsQuerySensitiveDays? options,
  ]) async => await this.query(options ?? OptionsQuerySensitiveDays());

  graphql.ObservableQuery<QuerySensitiveDays> watchQuerySensitiveDays([
    WatchOptionsQuerySensitiveDays? options,
  ]) => this.watchQuery(options ?? WatchOptionsQuerySensitiveDays());

  void writeQuerySensitiveDays({required QuerySensitiveDays data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQuerySensitiveDays)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QuerySensitiveDays? readQuerySensitiveDays({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQuerySensitiveDays)),
      optimistic: optimistic,
    );
    return result == null ? null : QuerySensitiveDays.fromJson(result);
  }
}

class QuerySensitiveDaystoday {
  QuerySensitiveDaystoday({this.localDate, this.$__typename = 'TodayState'});

  factory QuerySensitiveDaystoday.fromJson(Map<String, dynamic> json) {
    final l$localDate = json['localDate'];
    final l$$__typename = json['__typename'];
    return QuerySensitiveDaystoday(
      localDate: l$localDate == null ? null : DateTime.parse((l$localDate as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime? localDate;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$localDate = localDate;
    _resultData['localDate'] = l$localDate == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$localDate);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$localDate = localDate;
    final l$$__typename = $__typename;
    return Object.hashAll([l$localDate, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySensitiveDaystoday || runtimeType != other.runtimeType) {
      return false;
    }
    final l$localDate = localDate;
    final lOther$localDate = other.localDate;
    if (l$localDate != lOther$localDate) {
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

class QuerySensitiveDayscycleDaysCollection {
  QuerySensitiveDayscycleDaysCollection({
    required this.edges,
    this.$__typename = 'CycleDaysConnection',
  });

  factory QuerySensitiveDayscycleDaysCollection.fromJson(Map<String, dynamic> json) {
    final l$edges = json['edges'];
    final l$$__typename = json['__typename'];
    return QuerySensitiveDayscycleDaysCollection(
      edges: (l$edges as List<dynamic>)
          .map(
            (e) => QuerySensitiveDayscycleDaysCollectionedges.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QuerySensitiveDayscycleDaysCollectionedges> edges;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$edges = edges;
    _resultData['edges'] = l$edges.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$edges = edges;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$edges.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySensitiveDayscycleDaysCollection || runtimeType != other.runtimeType) {
      return false;
    }
    final l$edges = edges;
    final lOther$edges = other.edges;
    if (l$edges.length != lOther$edges.length) {
      return false;
    }
    for (int i = 0; i < l$edges.length; i++) {
      final l$edges$entry = l$edges[i];
      final lOther$edges$entry = lOther$edges[i];
      if (l$edges$entry != lOther$edges$entry) {
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

class QuerySensitiveDayscycleDaysCollectionedges {
  QuerySensitiveDayscycleDaysCollectionedges({
    required this.node,
    this.$__typename = 'CycleDaysEdge',
  });

  factory QuerySensitiveDayscycleDaysCollectionedges.fromJson(Map<String, dynamic> json) {
    final l$node = json['node'];
    final l$$__typename = json['__typename'];
    return QuerySensitiveDayscycleDaysCollectionedges(
      node: QuerySensitiveDayscycleDaysCollectionedgesnode.fromJson(
        (l$node as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final QuerySensitiveDayscycleDaysCollectionedgesnode node;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$node = node;
    _resultData['node'] = l$node.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$node = node;
    final l$$__typename = $__typename;
    return Object.hashAll([l$node, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySensitiveDayscycleDaysCollectionedges || runtimeType != other.runtimeType) {
      return false;
    }
    final l$node = node;
    final lOther$node = other.node;
    if (l$node != lOther$node) {
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

class QuerySensitiveDayscycleDaysCollectionedgesnode {
  QuerySensitiveDayscycleDaysCollectionedgesnode({
    required this.id,
    required this.day,
    this.$__typename = 'CycleDays',
  });

  factory QuerySensitiveDayscycleDaysCollectionedgesnode.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$day = json['day'];
    final l$$__typename = json['__typename'];
    return QuerySensitiveDayscycleDaysCollectionedgesnode(
      id: (l$id as String),
      day: DateTime.parse((l$day as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime day;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$day = day;
    _resultData['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$day = day;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$day, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySensitiveDayscycleDaysCollectionedgesnode ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$day = day;
    final lOther$day = other.day;
    if (l$day != lOther$day) {
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
