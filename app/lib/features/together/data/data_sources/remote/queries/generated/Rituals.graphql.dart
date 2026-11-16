// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryRituals {
  QueryRituals({required this.rituals, this.$__typename = 'query_root'});

  factory QueryRituals.fromJson(Map<String, dynamic> json) {
    final l$rituals = json['rituals'];
    final l$$__typename = json['__typename'];
    return QueryRituals(
      rituals: (l$rituals as List<dynamic>)
          .map((e) => QueryRitualsrituals.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryRitualsrituals> rituals;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$rituals = rituals;
    _resultData['rituals'] = l$rituals.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$rituals = rituals;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$rituals.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryRituals || runtimeType != other.runtimeType) {
      return false;
    }
    final l$rituals = rituals;
    final lOther$rituals = other.rituals;
    if (l$rituals.length != lOther$rituals.length) {
      return false;
    }
    for (int i = 0; i < l$rituals.length; i++) {
      final l$rituals$entry = l$rituals[i];
      final lOther$rituals$entry = lOther$rituals[i];
      if (l$rituals$entry != lOther$rituals$entry) {
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

const documentNodeQueryRituals = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Rituals'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'rituals'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'archivedAt'),
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
                value: IntValueNode(value: '100'),
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
                  name: NameNode(value: 'cadence'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'weekday'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'atTime'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'reminder'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'logs'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'order_by'),
                      value: ListValueNode(
                        values: [
                          ObjectValueNode(
                            fields: [
                              ObjectFieldNode(
                                name: NameNode(value: 'doneOn'),
                                value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                              ),
                            ],
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
                        name: NameNode(value: 'doneOn'),
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
  ],
);
QueryRituals _parserFnQueryRituals(Map<String, dynamic> data) => QueryRituals.fromJson(data);
typedef OnQueryCompleteQueryRituals = FutureOr<void> Function(Map<String, dynamic>?, QueryRituals?);

class OptionsQueryRituals extends graphql.QueryOptions<QueryRituals> {
  OptionsQueryRituals({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryRituals? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryRituals? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'Rituals',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryRituals(data)),
         onError: onError,
         document: documentNodeQueryRituals,
         parserFn: _parserFnQueryRituals,
       );

  final OnQueryCompleteQueryRituals? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryRituals extends graphql.WatchQueryOptions<QueryRituals> {
  WatchOptionsQueryRituals({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryRituals? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'Rituals',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryRituals,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryRituals,
       );
}

class FetchMoreOptionsQueryRituals extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryRituals({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryRituals);
}

extension ClientExtensionQueryRituals on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryRituals>> queryRituals([OptionsQueryRituals? options]) async =>
      await this.query(options ?? OptionsQueryRituals());

  graphql.ObservableQuery<QueryRituals> watchQueryRituals([WatchOptionsQueryRituals? options]) =>
      this.watchQuery(options ?? WatchOptionsQueryRituals());

  void writeQueryRituals({required QueryRituals data, bool broadcast = true}) => this.writeQuery(
    graphql.Request(operation: graphql.Operation(document: documentNodeQueryRituals)),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryRituals? readQueryRituals({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryRituals)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryRituals.fromJson(result);
  }
}

class QueryRitualsrituals {
  QueryRitualsrituals({
    required this.id,
    required this.title,
    required this.cadence,
    this.weekday,
    this.atTime,
    required this.reminder,
    required this.logs,
    this.$__typename = 'rituals',
  });

  factory QueryRitualsrituals.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$cadence = json['cadence'];
    final l$weekday = json['weekday'];
    final l$atTime = json['atTime'];
    final l$reminder = json['reminder'];
    final l$logs = json['logs'];
    final l$$__typename = json['__typename'];
    return QueryRitualsrituals(
      id: (l$id as String),
      title: (l$title as String),
      cadence: fromJsonEnumRitualCadence_enum((l$cadence as String)),
      weekday: (l$weekday as int?),
      atTime: (l$atTime as String?),
      reminder: (l$reminder as bool),
      logs: (l$logs as List<dynamic>)
          .map((e) => QueryRitualsritualslogs.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final EnumRitualCadence_enum cadence;

  final int? weekday;

  final String? atTime;

  final bool reminder;

  final List<QueryRitualsritualslogs> logs;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$cadence = cadence;
    _resultData['cadence'] = toJsonEnumRitualCadence_enum(l$cadence);
    final l$weekday = weekday;
    _resultData['weekday'] = l$weekday;
    final l$atTime = atTime;
    _resultData['atTime'] = l$atTime;
    final l$reminder = reminder;
    _resultData['reminder'] = l$reminder;
    final l$logs = logs;
    _resultData['logs'] = l$logs.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$cadence = cadence;
    final l$weekday = weekday;
    final l$atTime = atTime;
    final l$reminder = reminder;
    final l$logs = logs;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$cadence,
      l$weekday,
      l$atTime,
      l$reminder,
      Object.hashAll(l$logs.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryRitualsrituals || runtimeType != other.runtimeType) {
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
    final l$cadence = cadence;
    final lOther$cadence = other.cadence;
    if (l$cadence != lOther$cadence) {
      return false;
    }
    final l$weekday = weekday;
    final lOther$weekday = other.weekday;
    if (l$weekday != lOther$weekday) {
      return false;
    }
    final l$atTime = atTime;
    final lOther$atTime = other.atTime;
    if (l$atTime != lOther$atTime) {
      return false;
    }
    final l$reminder = reminder;
    final lOther$reminder = other.reminder;
    if (l$reminder != lOther$reminder) {
      return false;
    }
    final l$logs = logs;
    final lOther$logs = other.logs;
    if (l$logs.length != lOther$logs.length) {
      return false;
    }
    for (int i = 0; i < l$logs.length; i++) {
      final l$logs$entry = l$logs[i];
      final lOther$logs$entry = lOther$logs[i];
      if (l$logs$entry != lOther$logs$entry) {
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

class QueryRitualsritualslogs {
  QueryRitualsritualslogs({required this.doneOn, this.$__typename = 'ritualLogs'});

  factory QueryRitualsritualslogs.fromJson(Map<String, dynamic> json) {
    final l$doneOn = json['doneOn'];
    final l$$__typename = json['__typename'];
    return QueryRitualsritualslogs(
      doneOn: DateTime.parse((l$doneOn as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime doneOn;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$doneOn = doneOn;
    _resultData['doneOn'] = ((v) => v.toIso8601String().substring(0, 10))(l$doneOn);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$doneOn = doneOn;
    final l$$__typename = $__typename;
    return Object.hashAll([l$doneOn, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryRitualsritualslogs || runtimeType != other.runtimeType) {
      return false;
    }
    final l$doneOn = doneOn;
    final lOther$doneOn = other.doneOn;
    if (l$doneOn != lOther$doneOn) {
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
