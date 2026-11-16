// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryHistoryOverview {
  factory VariablesQueryHistoryOverview({required String userId, required int year}) =>
      VariablesQueryHistoryOverview._({r'userId': userId, r'year': year});

  VariablesQueryHistoryOverview._(this._$data);

  factory VariablesQueryHistoryOverview.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$year = data['year'];
    result$data['year'] = (l$year as int);
    return VariablesQueryHistoryOverview._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  int get year => (_$data['year'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$year = year;
    result$data['year'] = l$year;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryHistoryOverview || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$year = year;
    final lOther$year = other.year;
    if (l$year != lOther$year) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$year = year;
    return Object.hashAll([l$userId, l$year]);
  }
}

class QueryHistoryOverview {
  QueryHistoryOverview({
    this.profile,
    this.member,
    this.settings,
    required this.storyEvents,
    required this.memories,
    required this.importantDates,
    required this.yearRecaps,
    this.$__typename = 'query_root',
  });

  factory QueryHistoryOverview.fromJson(Map<String, dynamic> json) {
    final l$profile = json['profile'];
    final l$member = json['member'];
    final l$settings = json['settings'];
    final l$storyEvents = json['storyEvents'];
    final l$memories = json['memories'];
    final l$importantDates = json['importantDates'];
    final l$yearRecaps = json['yearRecaps'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverview(
      profile: l$profile == null
          ? null
          : QueryHistoryOverviewprofile.fromJson((l$profile as Map<String, dynamic>)),
      member: l$member == null
          ? null
          : QueryHistoryOverviewmember.fromJson((l$member as Map<String, dynamic>)),
      settings: l$settings == null
          ? null
          : QueryHistoryOverviewsettings.fromJson((l$settings as Map<String, dynamic>)),
      storyEvents: (l$storyEvents as List<dynamic>)
          .map((e) => QueryHistoryOverviewstoryEvents.fromJson((e as Map<String, dynamic>)))
          .toList(),
      memories: (l$memories as List<dynamic>)
          .map((e) => QueryHistoryOverviewmemories.fromJson((e as Map<String, dynamic>)))
          .toList(),
      importantDates: (l$importantDates as List<dynamic>)
          .map((e) => QueryHistoryOverviewimportantDates.fromJson((e as Map<String, dynamic>)))
          .toList(),
      yearRecaps: (l$yearRecaps as List<dynamic>)
          .map((e) => QueryHistoryOverviewyearRecaps.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryHistoryOverviewprofile? profile;

  final QueryHistoryOverviewmember? member;

  final QueryHistoryOverviewsettings? settings;

  final List<QueryHistoryOverviewstoryEvents> storyEvents;

  final List<QueryHistoryOverviewmemories> memories;

  final List<QueryHistoryOverviewimportantDates> importantDates;

  final List<QueryHistoryOverviewyearRecaps> yearRecaps;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$profile = profile;
    _resultData['profile'] = l$profile?.toJson();
    final l$member = member;
    _resultData['member'] = l$member?.toJson();
    final l$settings = settings;
    _resultData['settings'] = l$settings?.toJson();
    final l$storyEvents = storyEvents;
    _resultData['storyEvents'] = l$storyEvents.map((e) => e.toJson()).toList();
    final l$memories = memories;
    _resultData['memories'] = l$memories.map((e) => e.toJson()).toList();
    final l$importantDates = importantDates;
    _resultData['importantDates'] = l$importantDates.map((e) => e.toJson()).toList();
    final l$yearRecaps = yearRecaps;
    _resultData['yearRecaps'] = l$yearRecaps.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$profile = profile;
    final l$member = member;
    final l$settings = settings;
    final l$storyEvents = storyEvents;
    final l$memories = memories;
    final l$importantDates = importantDates;
    final l$yearRecaps = yearRecaps;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$profile,
      l$member,
      l$settings,
      Object.hashAll(l$storyEvents.map((v) => v)),
      Object.hashAll(l$memories.map((v) => v)),
      Object.hashAll(l$importantDates.map((v) => v)),
      Object.hashAll(l$yearRecaps.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverview || runtimeType != other.runtimeType) {
      return false;
    }
    final l$profile = profile;
    final lOther$profile = other.profile;
    if (l$profile != lOther$profile) {
      return false;
    }
    final l$member = member;
    final lOther$member = other.member;
    if (l$member != lOther$member) {
      return false;
    }
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) {
      return false;
    }
    final l$storyEvents = storyEvents;
    final lOther$storyEvents = other.storyEvents;
    if (l$storyEvents.length != lOther$storyEvents.length) {
      return false;
    }
    for (int i = 0; i < l$storyEvents.length; i++) {
      final l$storyEvents$entry = l$storyEvents[i];
      final lOther$storyEvents$entry = lOther$storyEvents[i];
      if (l$storyEvents$entry != lOther$storyEvents$entry) {
        return false;
      }
    }
    final l$memories = memories;
    final lOther$memories = other.memories;
    if (l$memories.length != lOther$memories.length) {
      return false;
    }
    for (int i = 0; i < l$memories.length; i++) {
      final l$memories$entry = l$memories[i];
      final lOther$memories$entry = lOther$memories[i];
      if (l$memories$entry != lOther$memories$entry) {
        return false;
      }
    }
    final l$importantDates = importantDates;
    final lOther$importantDates = other.importantDates;
    if (l$importantDates.length != lOther$importantDates.length) {
      return false;
    }
    for (int i = 0; i < l$importantDates.length; i++) {
      final l$importantDates$entry = l$importantDates[i];
      final lOther$importantDates$entry = lOther$importantDates[i];
      if (l$importantDates$entry != lOther$importantDates$entry) {
        return false;
      }
    }
    final l$yearRecaps = yearRecaps;
    final lOther$yearRecaps = other.yearRecaps;
    if (l$yearRecaps.length != lOther$yearRecaps.length) {
      return false;
    }
    for (int i = 0; i < l$yearRecaps.length; i++) {
      final l$yearRecaps$entry = l$yearRecaps[i];
      final lOther$yearRecaps$entry = lOther$yearRecaps[i];
      if (l$yearRecaps$entry != lOther$yearRecaps$entry) {
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

const documentNodeQueryHistoryOverview = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'HistoryOverview'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'year')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'profilesByPk'),
            alias: NameNode(value: 'profile'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'userId')),
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
                  name: NameNode(value: 'displayName'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'avatarFileId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'avatarKind'),
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
            name: NameNode(value: 'coupleMembersByPk'),
            alias: NameNode(value: 'member'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'userId'),
                value: VariableNode(name: NameNode(value: 'userId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'couple'),
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
                        name: NameNode(value: 'members'),
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
                              name: NameNode(value: 'profile'),
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
                                    name: NameNode(value: 'displayName'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null,
                                  ),
                                  FieldNode(
                                    name: NameNode(value: 'avatarFileId'),
                                    alias: null,
                                    arguments: [],
                                    directives: [],
                                    selectionSet: null,
                                  ),
                                  FieldNode(
                                    name: NameNode(value: 'avatarKind'),
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
          FieldNode(
            name: NameNode(value: 'userSettingsByPk'),
            alias: NameNode(value: 'settings'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'userId'),
                value: VariableNode(name: NameNode(value: 'userId')),
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
                  name: NameNode(value: 'phase'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'togetherSince'),
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
                  name: NameNode(value: 'relationshipStatus'),
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
            name: NameNode(value: 'storyEvents'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'happenedOn'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '51'),
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
                  name: NameNode(value: 'authorId'),
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
                  name: NameNode(value: 'kind'),
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
                  name: NameNode(value: 'happenedOn'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'datePrecision'),
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
            name: NameNode(value: 'memories'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'happenedOn'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '51'),
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
                  name: NameNode(value: 'authorId'),
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
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'body'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'happenedOn'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'datePrecision'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'place'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'origin'),
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
            name: NameNode(value: 'importantDates'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'year'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'month'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
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
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '51'),
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
                  name: NameNode(value: 'authorId'),
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
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'kind'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'month'),
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
                  name: NameNode(value: 'year'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'yearly'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'hidden'),
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
            name: NameNode(value: 'yearRecaps'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'year'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'year')),
                          ),
                        ],
                      ),
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
                  name: NameNode(value: 'year'),
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
                  name: NameNode(value: 'cardsSent'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'cardsReceived'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'memories'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'firsts'),
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
QueryHistoryOverview _parserFnQueryHistoryOverview(Map<String, dynamic> data) =>
    QueryHistoryOverview.fromJson(data);
typedef OnQueryCompleteQueryHistoryOverview = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryHistoryOverview?,
);

class OptionsQueryHistoryOverview extends graphql.QueryOptions<QueryHistoryOverview> {
  OptionsQueryHistoryOverview({
    String? operationName,
    required VariablesQueryHistoryOverview variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryHistoryOverview? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryHistoryOverview? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'HistoryOverview',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryHistoryOverview(data)),
         onError: onError,
         document: documentNodeQueryHistoryOverview,
         parserFn: _parserFnQueryHistoryOverview,
       );

  final OnQueryCompleteQueryHistoryOverview? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryHistoryOverview extends graphql.WatchQueryOptions<QueryHistoryOverview> {
  WatchOptionsQueryHistoryOverview({
    String? operationName,
    required VariablesQueryHistoryOverview variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryHistoryOverview? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'HistoryOverview',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryHistoryOverview,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryHistoryOverview,
       );
}

class FetchMoreOptionsQueryHistoryOverview extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryHistoryOverview({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryHistoryOverview variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryHistoryOverview,
       );
}

extension ClientExtensionQueryHistoryOverview on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryHistoryOverview>> queryHistoryOverview(
    OptionsQueryHistoryOverview options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryHistoryOverview> watchQueryHistoryOverview(
    WatchOptionsQueryHistoryOverview options,
  ) => this.watchQuery(options);

  void writeQueryHistoryOverview({
    required QueryHistoryOverview data,
    required VariablesQueryHistoryOverview variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryHistoryOverview),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryHistoryOverview? readQueryHistoryOverview({
    required VariablesQueryHistoryOverview variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryHistoryOverview),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryHistoryOverview.fromJson(result);
  }
}

class QueryHistoryOverviewprofile {
  QueryHistoryOverviewprofile({
    required this.id,
    this.displayName,
    this.avatarFileId,
    required this.avatarKind,
    this.$__typename = 'profiles',
  });

  factory QueryHistoryOverviewprofile.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$displayName = json['displayName'];
    final l$avatarFileId = json['avatarFileId'];
    final l$avatarKind = json['avatarKind'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewprofile(
      id: (l$id as String),
      displayName: (l$displayName as String?),
      avatarFileId: (l$avatarFileId as String?),
      avatarKind: fromJsonEnumAvatarKind_enum((l$avatarKind as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? displayName;

  final String? avatarFileId;

  final EnumAvatarKind_enum avatarKind;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$avatarFileId = avatarFileId;
    _resultData['avatarFileId'] = l$avatarFileId;
    final l$avatarKind = avatarKind;
    _resultData['avatarKind'] = toJsonEnumAvatarKind_enum(l$avatarKind);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$displayName = displayName;
    final l$avatarFileId = avatarFileId;
    final l$avatarKind = avatarKind;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$displayName, l$avatarFileId, l$avatarKind, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewprofile || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$avatarFileId = avatarFileId;
    final lOther$avatarFileId = other.avatarFileId;
    if (l$avatarFileId != lOther$avatarFileId) {
      return false;
    }
    final l$avatarKind = avatarKind;
    final lOther$avatarKind = other.avatarKind;
    if (l$avatarKind != lOther$avatarKind) {
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

class QueryHistoryOverviewmember {
  QueryHistoryOverviewmember({required this.couple, this.$__typename = 'coupleMembers'});

  factory QueryHistoryOverviewmember.fromJson(Map<String, dynamic> json) {
    final l$couple = json['couple'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewmember(
      couple: QueryHistoryOverviewmembercouple.fromJson((l$couple as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryHistoryOverviewmembercouple couple;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$couple = couple;
    _resultData['couple'] = l$couple.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$couple = couple;
    final l$$__typename = $__typename;
    return Object.hashAll([l$couple, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewmember || runtimeType != other.runtimeType) {
      return false;
    }
    final l$couple = couple;
    final lOther$couple = other.couple;
    if (l$couple != lOther$couple) {
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

class QueryHistoryOverviewmembercouple {
  QueryHistoryOverviewmembercouple({
    required this.id,
    required this.members,
    this.$__typename = 'couples',
  });

  factory QueryHistoryOverviewmembercouple.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$members = json['members'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewmembercouple(
      id: (l$id as String),
      members: (l$members as List<dynamic>)
          .map((e) => QueryHistoryOverviewmembercouplemembers.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final List<QueryHistoryOverviewmembercouplemembers> members;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$members = members;
    _resultData['members'] = l$members.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$members = members;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, Object.hashAll(l$members.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewmembercouple || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$members = members;
    final lOther$members = other.members;
    if (l$members.length != lOther$members.length) {
      return false;
    }
    for (int i = 0; i < l$members.length; i++) {
      final l$members$entry = l$members[i];
      final lOther$members$entry = lOther$members[i];
      if (l$members$entry != lOther$members$entry) {
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

class QueryHistoryOverviewmembercouplemembers {
  QueryHistoryOverviewmembercouplemembers({
    required this.userId,
    required this.profile,
    this.$__typename = 'coupleMembers',
  });

  factory QueryHistoryOverviewmembercouplemembers.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$profile = json['profile'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewmembercouplemembers(
      userId: (l$userId as String),
      profile: QueryHistoryOverviewmembercouplemembersprofile.fromJson(
        (l$profile as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final QueryHistoryOverviewmembercouplemembersprofile profile;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$profile = profile;
    _resultData['profile'] = l$profile.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$profile = profile;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$profile, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewmembercouplemembers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$profile = profile;
    final lOther$profile = other.profile;
    if (l$profile != lOther$profile) {
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

class QueryHistoryOverviewmembercouplemembersprofile {
  QueryHistoryOverviewmembercouplemembersprofile({
    required this.id,
    this.displayName,
    this.avatarFileId,
    required this.avatarKind,
    this.$__typename = 'profiles',
  });

  factory QueryHistoryOverviewmembercouplemembersprofile.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$displayName = json['displayName'];
    final l$avatarFileId = json['avatarFileId'];
    final l$avatarKind = json['avatarKind'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewmembercouplemembersprofile(
      id: (l$id as String),
      displayName: (l$displayName as String?),
      avatarFileId: (l$avatarFileId as String?),
      avatarKind: fromJsonEnumAvatarKind_enum((l$avatarKind as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? displayName;

  final String? avatarFileId;

  final EnumAvatarKind_enum avatarKind;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$avatarFileId = avatarFileId;
    _resultData['avatarFileId'] = l$avatarFileId;
    final l$avatarKind = avatarKind;
    _resultData['avatarKind'] = toJsonEnumAvatarKind_enum(l$avatarKind);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$displayName = displayName;
    final l$avatarFileId = avatarFileId;
    final l$avatarKind = avatarKind;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$displayName, l$avatarFileId, l$avatarKind, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewmembercouplemembersprofile ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$avatarFileId = avatarFileId;
    final lOther$avatarFileId = other.avatarFileId;
    if (l$avatarFileId != lOther$avatarFileId) {
      return false;
    }
    final l$avatarKind = avatarKind;
    final lOther$avatarKind = other.avatarKind;
    if (l$avatarKind != lOther$avatarKind) {
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

class QueryHistoryOverviewsettings {
  QueryHistoryOverviewsettings({
    required this.userId,
    this.phase,
    this.togetherSince,
    this.partnerName,
    required this.relationshipStatus,
    this.$__typename = 'userSettings',
  });

  factory QueryHistoryOverviewsettings.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$phase = json['phase'];
    final l$togetherSince = json['togetherSince'];
    final l$partnerName = json['partnerName'];
    final l$relationshipStatus = json['relationshipStatus'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewsettings(
      userId: (l$userId as String),
      phase: l$phase == null ? null : fromJsonEnumRelationshipPhase_enum((l$phase as String)),
      togetherSince: l$togetherSince == null ? null : DateTime.parse((l$togetherSince as String)),
      partnerName: (l$partnerName as String?),
      relationshipStatus: fromJsonEnumRelationshipStatus_enum((l$relationshipStatus as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final EnumRelationshipPhase_enum? phase;

  final DateTime? togetherSince;

  final String? partnerName;

  final EnumRelationshipStatus_enum relationshipStatus;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$phase = phase;
    _resultData['phase'] = l$phase == null ? null : toJsonEnumRelationshipPhase_enum(l$phase);
    final l$togetherSince = togetherSince;
    _resultData['togetherSince'] = l$togetherSince == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$togetherSince);
    final l$partnerName = partnerName;
    _resultData['partnerName'] = l$partnerName;
    final l$relationshipStatus = relationshipStatus;
    _resultData['relationshipStatus'] = toJsonEnumRelationshipStatus_enum(l$relationshipStatus);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$phase = phase;
    final l$togetherSince = togetherSince;
    final l$partnerName = partnerName;
    final l$relationshipStatus = relationshipStatus;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$userId,
      l$phase,
      l$togetherSince,
      l$partnerName,
      l$relationshipStatus,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewsettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$phase = phase;
    final lOther$phase = other.phase;
    if (l$phase != lOther$phase) {
      return false;
    }
    final l$togetherSince = togetherSince;
    final lOther$togetherSince = other.togetherSince;
    if (l$togetherSince != lOther$togetherSince) {
      return false;
    }
    final l$partnerName = partnerName;
    final lOther$partnerName = other.partnerName;
    if (l$partnerName != lOther$partnerName) {
      return false;
    }
    final l$relationshipStatus = relationshipStatus;
    final lOther$relationshipStatus = other.relationshipStatus;
    if (l$relationshipStatus != lOther$relationshipStatus) {
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

class QueryHistoryOverviewstoryEvents {
  QueryHistoryOverviewstoryEvents({
    required this.id,
    required this.authorId,
    this.coupleId,
    required this.kind,
    this.title,
    required this.happenedOn,
    required this.datePrecision,
    this.$__typename = 'storyEvents',
  });

  factory QueryHistoryOverviewstoryEvents.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$kind = json['kind'];
    final l$title = json['title'];
    final l$happenedOn = json['happenedOn'];
    final l$datePrecision = json['datePrecision'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewstoryEvents(
      id: (l$id as String),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      kind: fromJsonEnumStoryEventKind_enum((l$kind as String)),
      title: (l$title as String?),
      happenedOn: DateTime.parse((l$happenedOn as String)),
      datePrecision: fromJsonEnumDatePrecision_enum((l$datePrecision as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String authorId;

  final String? coupleId;

  final EnumStoryEventKind_enum kind;

  final String? title;

  final DateTime happenedOn;

  final EnumDatePrecision_enum datePrecision;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumStoryEventKind_enum(l$kind);
    final l$title = title;
    _resultData['title'] = l$title;
    final l$happenedOn = happenedOn;
    _resultData['happenedOn'] = ((v) => v.toIso8601String().substring(0, 10))(l$happenedOn);
    final l$datePrecision = datePrecision;
    _resultData['datePrecision'] = toJsonEnumDatePrecision_enum(l$datePrecision);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$kind = kind;
    final l$title = title;
    final l$happenedOn = happenedOn;
    final l$datePrecision = datePrecision;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$authorId,
      l$coupleId,
      l$kind,
      l$title,
      l$happenedOn,
      l$datePrecision,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewstoryEvents || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$happenedOn = happenedOn;
    final lOther$happenedOn = other.happenedOn;
    if (l$happenedOn != lOther$happenedOn) {
      return false;
    }
    final l$datePrecision = datePrecision;
    final lOther$datePrecision = other.datePrecision;
    if (l$datePrecision != lOther$datePrecision) {
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

class QueryHistoryOverviewmemories {
  QueryHistoryOverviewmemories({
    required this.id,
    required this.authorId,
    this.coupleId,
    required this.title,
    this.body,
    required this.happenedOn,
    required this.datePrecision,
    this.place,
    required this.origin,
    this.$__typename = 'memories',
  });

  factory QueryHistoryOverviewmemories.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$title = json['title'];
    final l$body = json['body'];
    final l$happenedOn = json['happenedOn'];
    final l$datePrecision = json['datePrecision'];
    final l$place = json['place'];
    final l$origin = json['origin'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewmemories(
      id: (l$id as String),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      title: (l$title as String),
      body: (l$body as String?),
      happenedOn: DateTime.parse((l$happenedOn as String)),
      datePrecision: fromJsonEnumDatePrecision_enum((l$datePrecision as String)),
      place: (l$place as String?),
      origin: fromJsonEnumMemoryOrigin_enum((l$origin as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String authorId;

  final String? coupleId;

  final String title;

  final String? body;

  final DateTime happenedOn;

  final EnumDatePrecision_enum datePrecision;

  final String? place;

  final EnumMemoryOrigin_enum origin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$happenedOn = happenedOn;
    _resultData['happenedOn'] = ((v) => v.toIso8601String().substring(0, 10))(l$happenedOn);
    final l$datePrecision = datePrecision;
    _resultData['datePrecision'] = toJsonEnumDatePrecision_enum(l$datePrecision);
    final l$place = place;
    _resultData['place'] = l$place;
    final l$origin = origin;
    _resultData['origin'] = toJsonEnumMemoryOrigin_enum(l$origin);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$title = title;
    final l$body = body;
    final l$happenedOn = happenedOn;
    final l$datePrecision = datePrecision;
    final l$place = place;
    final l$origin = origin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$authorId,
      l$coupleId,
      l$title,
      l$body,
      l$happenedOn,
      l$datePrecision,
      l$place,
      l$origin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewmemories || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$happenedOn = happenedOn;
    final lOther$happenedOn = other.happenedOn;
    if (l$happenedOn != lOther$happenedOn) {
      return false;
    }
    final l$datePrecision = datePrecision;
    final lOther$datePrecision = other.datePrecision;
    if (l$datePrecision != lOther$datePrecision) {
      return false;
    }
    final l$place = place;
    final lOther$place = other.place;
    if (l$place != lOther$place) {
      return false;
    }
    final l$origin = origin;
    final lOther$origin = other.origin;
    if (l$origin != lOther$origin) {
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

class QueryHistoryOverviewimportantDates {
  QueryHistoryOverviewimportantDates({
    required this.id,
    required this.authorId,
    this.coupleId,
    required this.title,
    required this.kind,
    required this.month,
    required this.day,
    this.year,
    required this.yearly,
    required this.hidden,
    this.$__typename = 'importantDates',
  });

  factory QueryHistoryOverviewimportantDates.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$title = json['title'];
    final l$kind = json['kind'];
    final l$month = json['month'];
    final l$day = json['day'];
    final l$year = json['year'];
    final l$yearly = json['yearly'];
    final l$hidden = json['hidden'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewimportantDates(
      id: (l$id as String),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      title: (l$title as String),
      kind: fromJsonEnumImportantDateKind_enum((l$kind as String)),
      month: (l$month as int),
      day: (l$day as int),
      year: (l$year as int?),
      yearly: (l$yearly as bool),
      hidden: (l$hidden as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String authorId;

  final String? coupleId;

  final String title;

  final EnumImportantDateKind_enum kind;

  final int month;

  final int day;

  final int? year;

  final bool yearly;

  final bool hidden;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumImportantDateKind_enum(l$kind);
    final l$month = month;
    _resultData['month'] = l$month;
    final l$day = day;
    _resultData['day'] = l$day;
    final l$year = year;
    _resultData['year'] = l$year;
    final l$yearly = yearly;
    _resultData['yearly'] = l$yearly;
    final l$hidden = hidden;
    _resultData['hidden'] = l$hidden;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$title = title;
    final l$kind = kind;
    final l$month = month;
    final l$day = day;
    final l$year = year;
    final l$yearly = yearly;
    final l$hidden = hidden;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$authorId,
      l$coupleId,
      l$title,
      l$kind,
      l$month,
      l$day,
      l$year,
      l$yearly,
      l$hidden,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewimportantDates || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$month = month;
    final lOther$month = other.month;
    if (l$month != lOther$month) {
      return false;
    }
    final l$day = day;
    final lOther$day = other.day;
    if (l$day != lOther$day) {
      return false;
    }
    final l$year = year;
    final lOther$year = other.year;
    if (l$year != lOther$year) {
      return false;
    }
    final l$yearly = yearly;
    final lOther$yearly = other.yearly;
    if (l$yearly != lOther$yearly) {
      return false;
    }
    final l$hidden = hidden;
    final lOther$hidden = other.hidden;
    if (l$hidden != lOther$hidden) {
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

class QueryHistoryOverviewyearRecaps {
  QueryHistoryOverviewyearRecaps({
    this.year,
    this.slips,
    this.cardsSent,
    this.cardsReceived,
    this.memories,
    this.firsts,
    this.ritualsDone,
    this.$__typename = 'yearRecaps',
  });

  factory QueryHistoryOverviewyearRecaps.fromJson(Map<String, dynamic> json) {
    final l$year = json['year'];
    final l$slips = json['slips'];
    final l$cardsSent = json['cardsSent'];
    final l$cardsReceived = json['cardsReceived'];
    final l$memories = json['memories'];
    final l$firsts = json['firsts'];
    final l$ritualsDone = json['ritualsDone'];
    final l$$__typename = json['__typename'];
    return QueryHistoryOverviewyearRecaps(
      year: (l$year as int?),
      slips: (l$slips as int?),
      cardsSent: (l$cardsSent as int?),
      cardsReceived: (l$cardsReceived as int?),
      memories: (l$memories as int?),
      firsts: (l$firsts as int?),
      ritualsDone: (l$ritualsDone as int?),
      $__typename: (l$$__typename as String),
    );
  }

  final int? year;

  final int? slips;

  final int? cardsSent;

  final int? cardsReceived;

  final int? memories;

  final int? firsts;

  final int? ritualsDone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$year = year;
    _resultData['year'] = l$year;
    final l$slips = slips;
    _resultData['slips'] = l$slips;
    final l$cardsSent = cardsSent;
    _resultData['cardsSent'] = l$cardsSent;
    final l$cardsReceived = cardsReceived;
    _resultData['cardsReceived'] = l$cardsReceived;
    final l$memories = memories;
    _resultData['memories'] = l$memories;
    final l$firsts = firsts;
    _resultData['firsts'] = l$firsts;
    final l$ritualsDone = ritualsDone;
    _resultData['ritualsDone'] = l$ritualsDone;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$year = year;
    final l$slips = slips;
    final l$cardsSent = cardsSent;
    final l$cardsReceived = cardsReceived;
    final l$memories = memories;
    final l$firsts = firsts;
    final l$ritualsDone = ritualsDone;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$year,
      l$slips,
      l$cardsSent,
      l$cardsReceived,
      l$memories,
      l$firsts,
      l$ritualsDone,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryHistoryOverviewyearRecaps || runtimeType != other.runtimeType) {
      return false;
    }
    final l$year = year;
    final lOther$year = other.year;
    if (l$year != lOther$year) {
      return false;
    }
    final l$slips = slips;
    final lOther$slips = other.slips;
    if (l$slips != lOther$slips) {
      return false;
    }
    final l$cardsSent = cardsSent;
    final lOther$cardsSent = other.cardsSent;
    if (l$cardsSent != lOther$cardsSent) {
      return false;
    }
    final l$cardsReceived = cardsReceived;
    final lOther$cardsReceived = other.cardsReceived;
    if (l$cardsReceived != lOther$cardsReceived) {
      return false;
    }
    final l$memories = memories;
    final lOther$memories = other.memories;
    if (l$memories != lOther$memories) {
      return false;
    }
    final l$firsts = firsts;
    final lOther$firsts = other.firsts;
    if (l$firsts != lOther$firsts) {
      return false;
    }
    final l$ritualsDone = ritualsDone;
    final lOther$ritualsDone = other.ritualsDone;
    if (l$ritualsDone != lOther$ritualsDone) {
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
