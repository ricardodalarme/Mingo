// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryTodayMood {
  QueryTodayMood({required this.today, required this.moods, this.$__typename = 'query_root'});

  factory QueryTodayMood.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    final l$moods = json['moods'];
    final l$$__typename = json['__typename'];
    return QueryTodayMood(
      today: (l$today as List<dynamic>)
          .map((e) => QueryTodayMoodtoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      moods: (l$moods as List<dynamic>)
          .map((e) => QueryTodayMoodmoods.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryTodayMoodtoday> today;

  final List<QueryTodayMoodmoods> moods;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$today = today;
    _resultData['today'] = l$today.map((e) => e.toJson()).toList();
    final l$moods = moods;
    _resultData['moods'] = l$moods.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$today = today;
    final l$moods = moods;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$today.map((v) => v)),
      Object.hashAll(l$moods.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryTodayMood || runtimeType != other.runtimeType) {
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

const documentNodeQueryTodayMood = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'TodayMood'),
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
                  name: NameNode(value: 'partner'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'sharedMood'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
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
            name: NameNode(value: 'moods'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '1'),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'day'),
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
QueryTodayMood _parserFnQueryTodayMood(Map<String, dynamic> data) => QueryTodayMood.fromJson(data);
typedef OnQueryCompleteQueryTodayMood = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryTodayMood?,
);

class OptionsQueryTodayMood extends graphql.QueryOptions<QueryTodayMood> {
  OptionsQueryTodayMood({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryTodayMood? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryTodayMood? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'TodayMood',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryTodayMood(data)),
         onError: onError,
         document: documentNodeQueryTodayMood,
         parserFn: _parserFnQueryTodayMood,
       );

  final OnQueryCompleteQueryTodayMood? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryTodayMood extends graphql.WatchQueryOptions<QueryTodayMood> {
  WatchOptionsQueryTodayMood({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryTodayMood? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'TodayMood',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryTodayMood,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryTodayMood,
       );
}

class FetchMoreOptionsQueryTodayMood extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryTodayMood({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryTodayMood);
}

extension ClientExtensionQueryTodayMood on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryTodayMood>> queryTodayMood([
    OptionsQueryTodayMood? options,
  ]) async => await this.query(options ?? OptionsQueryTodayMood());

  graphql.ObservableQuery<QueryTodayMood> watchQueryTodayMood([
    WatchOptionsQueryTodayMood? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryTodayMood());

  void writeQueryTodayMood({required QueryTodayMood data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryTodayMood)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryTodayMood? readQueryTodayMood({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryTodayMood)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryTodayMood.fromJson(result);
  }
}

class QueryTodayMoodtoday {
  QueryTodayMoodtoday({this.localDate, this.partnerName, this.partner, this.$__typename = 'today'});

  factory QueryTodayMoodtoday.fromJson(Map<String, dynamic> json) {
    final l$localDate = json['localDate'];
    final l$partnerName = json['partnerName'];
    final l$partner = json['partner'];
    final l$$__typename = json['__typename'];
    return QueryTodayMoodtoday(
      localDate: l$localDate == null ? null : DateTime.parse((l$localDate as String)),
      partnerName: (l$partnerName as String?),
      partner: l$partner == null
          ? null
          : QueryTodayMoodtodaypartner.fromJson((l$partner as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime? localDate;

  final String? partnerName;

  final QueryTodayMoodtodaypartner? partner;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$localDate = localDate;
    _resultData['localDate'] = l$localDate == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$localDate);
    final l$partnerName = partnerName;
    _resultData['partnerName'] = l$partnerName;
    final l$partner = partner;
    _resultData['partner'] = l$partner?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$localDate = localDate;
    final l$partnerName = partnerName;
    final l$partner = partner;
    final l$$__typename = $__typename;
    return Object.hashAll([l$localDate, l$partnerName, l$partner, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryTodayMoodtoday || runtimeType != other.runtimeType) {
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
    final l$partner = partner;
    final lOther$partner = other.partner;
    if (l$partner != lOther$partner) {
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

class QueryTodayMoodtodaypartner {
  QueryTodayMoodtodaypartner({this.sharedMood, this.$__typename = 'profiles'});

  factory QueryTodayMoodtodaypartner.fromJson(Map<String, dynamic> json) {
    final l$sharedMood = json['sharedMood'];
    final l$$__typename = json['__typename'];
    return QueryTodayMoodtodaypartner(
      sharedMood: l$sharedMood == null
          ? null
          : QueryTodayMoodtodaypartnersharedMood.fromJson((l$sharedMood as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryTodayMoodtodaypartnersharedMood? sharedMood;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$sharedMood = sharedMood;
    _resultData['sharedMood'] = l$sharedMood?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$sharedMood = sharedMood;
    final l$$__typename = $__typename;
    return Object.hashAll([l$sharedMood, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryTodayMoodtodaypartner || runtimeType != other.runtimeType) {
      return false;
    }
    final l$sharedMood = sharedMood;
    final lOther$sharedMood = other.sharedMood;
    if (l$sharedMood != lOther$sharedMood) {
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

class QueryTodayMoodtodaypartnersharedMood {
  QueryTodayMoodtodaypartnersharedMood({
    required this.day,
    required this.mood,
    this.need,
    this.$__typename = 'sharedMoods',
  });

  factory QueryTodayMoodtodaypartnersharedMood.fromJson(Map<String, dynamic> json) {
    final l$day = json['day'];
    final l$mood = json['mood'];
    final l$need = json['need'];
    final l$$__typename = json['__typename'];
    return QueryTodayMoodtodaypartnersharedMood(
      day: DateTime.parse((l$day as String)),
      mood: fromJsonEnumMood_enum((l$mood as String)),
      need: l$need == null ? null : fromJsonEnumMoodNeed_enum((l$need as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime day;

  final EnumMood_enum mood;

  final EnumMoodNeed_enum? need;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$day = day;
    _resultData['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    final l$mood = mood;
    _resultData['mood'] = toJsonEnumMood_enum(l$mood);
    final l$need = need;
    _resultData['need'] = l$need == null ? null : toJsonEnumMoodNeed_enum(l$need);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$day = day;
    final l$mood = mood;
    final l$need = need;
    final l$$__typename = $__typename;
    return Object.hashAll([l$day, l$mood, l$need, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryTodayMoodtodaypartnersharedMood || runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

class QueryTodayMoodmoods {
  QueryTodayMoodmoods({
    required this.id,
    required this.day,
    required this.mood,
    this.need,
    required this.share,
    this.$__typename = 'moods',
  });

  factory QueryTodayMoodmoods.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$day = json['day'];
    final l$mood = json['mood'];
    final l$need = json['need'];
    final l$share = json['share'];
    final l$$__typename = json['__typename'];
    return QueryTodayMoodmoods(
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
    if (other is! QueryTodayMoodmoods || runtimeType != other.runtimeType) {
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
