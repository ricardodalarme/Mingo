// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMoodMonth {
  factory VariablesQueryMoodMonth({required DateTime from, required DateTime to}) =>
      VariablesQueryMoodMonth._({r'from': from, r'to': to});

  VariablesQueryMoodMonth._(this._$data);

  factory VariablesQueryMoodMonth.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$from = data['from'];
    result$data['from'] = DateTime.parse((l$from as String));
    final l$to = data['to'];
    result$data['to'] = DateTime.parse((l$to as String));
    return VariablesQueryMoodMonth._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime get from => (_$data['from'] as DateTime);

  DateTime get to => (_$data['to'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$from = from;
    result$data['from'] = ((v) => v.toIso8601String().substring(0, 10))(l$from);
    final l$to = to;
    result$data['to'] = ((v) => v.toIso8601String().substring(0, 10))(l$to);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryMoodMonth || runtimeType != other.runtimeType) {
      return false;
    }
    final l$from = from;
    final lOther$from = other.from;
    if (l$from != lOther$from) {
      return false;
    }
    final l$to = to;
    final lOther$to = other.to;
    if (l$to != lOther$to) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$from = from;
    final l$to = to;
    return Object.hashAll([l$from, l$to]);
  }
}

class QueryMoodMonth {
  QueryMoodMonth({required this.moods, this.$__typename = 'query_root'});

  factory QueryMoodMonth.fromJson(Map<String, dynamic> json) {
    final l$moods = json['moods'];
    final l$$__typename = json['__typename'];
    return QueryMoodMonth(
      moods: (l$moods as List<dynamic>)
          .map((e) => QueryMoodMonthmoods.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMoodMonthmoods> moods;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$moods = moods;
    _resultData['moods'] = l$moods.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$moods = moods;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$moods.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMoodMonth || runtimeType != other.runtimeType) {
      return false;
    }
    final l$moods = moods;
    final lOther$moods = other.moods;
    if (l$moods.length != lOther$moods.length) {
      return false;
    }
    for (int i = 0; i < l$moods.length; i++) {
      final l$moods$entry = l$moods[i];
      final lOther$moods$entry = lOther$moods[i];
      if (l$moods$entry != lOther$moods$entry) {
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

const documentNodeQueryMoodMonth = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MoodMonth'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'from')),
          type: NamedTypeNode(name: NameNode(value: 'date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'to')),
          type: NamedTypeNode(name: NameNode(value: 'date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'moods'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'day'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_gte'),
                            value: VariableNode(name: NameNode(value: 'from')),
                          ),
                          ObjectFieldNode(
                            name: NameNode(value: '_lte'),
                            value: VariableNode(name: NameNode(value: 'to')),
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
                          name: NameNode(value: 'day'),
                          value: EnumValueNode(name: NameNode(value: 'asc')),
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
                  name: NameNode(value: 'mood'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'need'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'share'),
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
QueryMoodMonth _parserFnQueryMoodMonth(Map<String, dynamic> data) => QueryMoodMonth.fromJson(data);
typedef OnQueryCompleteQueryMoodMonth = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMoodMonth?,
);

class OptionsQueryMoodMonth extends graphql.QueryOptions<QueryMoodMonth> {
  OptionsQueryMoodMonth({
    String? operationName,
    required VariablesQueryMoodMonth variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMoodMonth? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMoodMonth? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MoodMonth',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMoodMonth(data)),
         onError: onError,
         document: documentNodeQueryMoodMonth,
         parserFn: _parserFnQueryMoodMonth,
       );

  final OnQueryCompleteQueryMoodMonth? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMoodMonth extends graphql.WatchQueryOptions<QueryMoodMonth> {
  WatchOptionsQueryMoodMonth({
    String? operationName,
    required VariablesQueryMoodMonth variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMoodMonth? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MoodMonth',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMoodMonth,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMoodMonth,
       );
}

class FetchMoreOptionsQueryMoodMonth extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMoodMonth({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMoodMonth variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMoodMonth,
       );
}

extension ClientExtensionQueryMoodMonth on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMoodMonth>> queryMoodMonth(OptionsQueryMoodMonth options) async =>
      await this.query(options);

  graphql.ObservableQuery<QueryMoodMonth> watchQueryMoodMonth(WatchOptionsQueryMoodMonth options) =>
      this.watchQuery(options);

  void writeQueryMoodMonth({
    required QueryMoodMonth data,
    required VariablesQueryMoodMonth variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMoodMonth),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMoodMonth? readQueryMoodMonth({
    required VariablesQueryMoodMonth variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMoodMonth),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMoodMonth.fromJson(result);
  }
}

class QueryMoodMonthmoods {
  QueryMoodMonthmoods({
    required this.id,
    required this.day,
    required this.mood,
    this.need,
    required this.share,
    this.$__typename = 'moods',
  });

  factory QueryMoodMonthmoods.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$day = json['day'];
    final l$mood = json['mood'];
    final l$need = json['need'];
    final l$share = json['share'];
    final l$$__typename = json['__typename'];
    return QueryMoodMonthmoods(
      id: (l$id as String),
      day: DateTime.parse((l$day as String)),
      mood: fromJsonEnumMood_enum((l$mood as String)),
      need: l$need == null ? null : fromJsonEnumMoodNeed_enum((l$need as String)),
      share: fromJsonEnumMoodShare_enum((l$share as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime day;

  final EnumMood_enum mood;

  final EnumMoodNeed_enum? need;

  final EnumMoodShare_enum share;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$day = day;
    _resultData['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    final l$mood = mood;
    _resultData['mood'] = toJsonEnumMood_enum(l$mood);
    final l$need = need;
    _resultData['need'] = l$need == null ? null : toJsonEnumMoodNeed_enum(l$need);
    final l$share = share;
    _resultData['share'] = toJsonEnumMoodShare_enum(l$share);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$day = day;
    final l$mood = mood;
    final l$need = need;
    final l$share = share;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$day, l$mood, l$need, l$share, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMoodMonthmoods || runtimeType != other.runtimeType) {
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
    final l$mood = mood;
    final lOther$mood = other.mood;
    if (l$mood != lOther$mood) {
      return false;
    }
    final l$need = need;
    final lOther$need = other.need;
    if (l$need != lOther$need) {
      return false;
    }
    final l$share = share;
    final lOther$share = other.share;
    if (l$share != lOther$share) {
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
