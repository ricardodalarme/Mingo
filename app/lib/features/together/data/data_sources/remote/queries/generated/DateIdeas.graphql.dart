// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryDateIdeas {
  QueryDateIdeas({required this.savedDateIdeas, this.$__typename = 'query_root'});

  factory QueryDateIdeas.fromJson(Map<String, dynamic> json) {
    final l$savedDateIdeas = json['savedDateIdeas'];
    final l$$__typename = json['__typename'];
    return QueryDateIdeas(
      savedDateIdeas: (l$savedDateIdeas as List<dynamic>)
          .map((e) => QueryDateIdeassavedDateIdeas.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryDateIdeassavedDateIdeas> savedDateIdeas;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$savedDateIdeas = savedDateIdeas;
    _resultData['savedDateIdeas'] = l$savedDateIdeas.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$savedDateIdeas = savedDateIdeas;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$savedDateIdeas.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryDateIdeas || runtimeType != other.runtimeType) {
      return false;
    }
    final l$savedDateIdeas = savedDateIdeas;
    final lOther$savedDateIdeas = other.savedDateIdeas;
    if (l$savedDateIdeas.length != lOther$savedDateIdeas.length) {
      return false;
    }
    for (int i = 0; i < l$savedDateIdeas.length; i++) {
      final l$savedDateIdeas$entry = l$savedDateIdeas[i];
      final lOther$savedDateIdeas$entry = lOther$savedDateIdeas[i];
      if (l$savedDateIdeas$entry != lOther$savedDateIdeas$entry) {
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

const documentNodeQueryDateIdeas = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'DateIdeas'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'savedDateIdeas'),
            alias: null,
            arguments: [
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
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '50'),
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
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'status'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'plannedFor'),
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
QueryDateIdeas _parserFnQueryDateIdeas(Map<String, dynamic> data) => QueryDateIdeas.fromJson(data);
typedef OnQueryCompleteQueryDateIdeas = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryDateIdeas?,
);

class OptionsQueryDateIdeas extends graphql.QueryOptions<QueryDateIdeas> {
  OptionsQueryDateIdeas({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryDateIdeas? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryDateIdeas? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'DateIdeas',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryDateIdeas(data)),
         onError: onError,
         document: documentNodeQueryDateIdeas,
         parserFn: _parserFnQueryDateIdeas,
       );

  final OnQueryCompleteQueryDateIdeas? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryDateIdeas extends graphql.WatchQueryOptions<QueryDateIdeas> {
  WatchOptionsQueryDateIdeas({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryDateIdeas? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'DateIdeas',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryDateIdeas,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryDateIdeas,
       );
}

class FetchMoreOptionsQueryDateIdeas extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryDateIdeas({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryDateIdeas);
}

extension ClientExtensionQueryDateIdeas on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryDateIdeas>> queryDateIdeas([
    OptionsQueryDateIdeas? options,
  ]) async => await this.query(options ?? OptionsQueryDateIdeas());

  graphql.ObservableQuery<QueryDateIdeas> watchQueryDateIdeas([
    WatchOptionsQueryDateIdeas? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryDateIdeas());

  void writeQueryDateIdeas({required QueryDateIdeas data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryDateIdeas)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryDateIdeas? readQueryDateIdeas({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryDateIdeas)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryDateIdeas.fromJson(result);
  }
}

class QueryDateIdeassavedDateIdeas {
  QueryDateIdeassavedDateIdeas({
    required this.id,
    required this.title,
    required this.status,
    this.plannedFor,
    this.$__typename = 'savedDateIdeas',
  });

  factory QueryDateIdeassavedDateIdeas.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$status = json['status'];
    final l$plannedFor = json['plannedFor'];
    final l$$__typename = json['__typename'];
    return QueryDateIdeassavedDateIdeas(
      id: (l$id as String),
      title: (l$title as String),
      status: fromJsonEnumDateIdeaStatus_enum((l$status as String)),
      plannedFor: l$plannedFor == null ? null : DateTime.parse((l$plannedFor as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final EnumDateIdeaStatus_enum status;

  final DateTime? plannedFor;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$status = status;
    _resultData['status'] = toJsonEnumDateIdeaStatus_enum(l$status);
    final l$plannedFor = plannedFor;
    _resultData['plannedFor'] = l$plannedFor == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$plannedFor);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$status = status;
    final l$plannedFor = plannedFor;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$title, l$status, l$plannedFor, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryDateIdeassavedDateIdeas || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$plannedFor = plannedFor;
    final lOther$plannedFor = other.plannedFor;
    if (l$plannedFor != lOther$plannedFor) {
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
