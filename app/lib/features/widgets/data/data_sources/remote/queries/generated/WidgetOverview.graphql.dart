// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryWidgetOverview {
  factory VariablesQueryWidgetOverview({required String userId}) =>
      VariablesQueryWidgetOverview._({r'userId': userId});

  VariablesQueryWidgetOverview._(this._$data);

  factory VariablesQueryWidgetOverview.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryWidgetOverview._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryWidgetOverview || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

class QueryWidgetOverview {
  QueryWidgetOverview({
    required this.today,
    this.me,
    this.settings,
    this.notificationSettingsByPk,
    required this.plusStates,
    required this.partnerNote,
    required this.partnerMood,
    required this.partnerMiss,
    required this.myMood,
    required this.rituals,
    required this.idea,
    this.$__typename = 'query_root',
  });

  factory QueryWidgetOverview.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    final l$me = json['me'];
    final l$settings = json['settings'];
    final l$notificationSettingsByPk = json['notificationSettingsByPk'];
    final l$plusStates = json['plusStates'];
    final l$partnerNote = json['partnerNote'];
    final l$partnerMood = json['partnerMood'];
    final l$partnerMiss = json['partnerMiss'];
    final l$myMood = json['myMood'];
    final l$rituals = json['rituals'];
    final l$idea = json['idea'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverview(
      today: (l$today as List<dynamic>)
          .map((e) => QueryWidgetOverviewtoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
      me: l$me == null ? null : QueryWidgetOverviewme.fromJson((l$me as Map<String, dynamic>)),
      settings: l$settings == null
          ? null
          : QueryWidgetOverviewsettings.fromJson((l$settings as Map<String, dynamic>)),
      notificationSettingsByPk: l$notificationSettingsByPk == null
          ? null
          : QueryWidgetOverviewnotificationSettingsByPk.fromJson(
              (l$notificationSettingsByPk as Map<String, dynamic>),
            ),
      plusStates: (l$plusStates as List<dynamic>)
          .map((e) => QueryWidgetOverviewplusStates.fromJson((e as Map<String, dynamic>)))
          .toList(),
      partnerNote: (l$partnerNote as List<dynamic>)
          .map((e) => QueryWidgetOverviewpartnerNote.fromJson((e as Map<String, dynamic>)))
          .toList(),
      partnerMood: (l$partnerMood as List<dynamic>)
          .map((e) => QueryWidgetOverviewpartnerMood.fromJson((e as Map<String, dynamic>)))
          .toList(),
      partnerMiss: (l$partnerMiss as List<dynamic>)
          .map((e) => QueryWidgetOverviewpartnerMiss.fromJson((e as Map<String, dynamic>)))
          .toList(),
      myMood: (l$myMood as List<dynamic>)
          .map((e) => QueryWidgetOverviewmyMood.fromJson((e as Map<String, dynamic>)))
          .toList(),
      rituals: (l$rituals as List<dynamic>)
          .map((e) => QueryWidgetOverviewrituals.fromJson((e as Map<String, dynamic>)))
          .toList(),
      idea: (l$idea as List<dynamic>)
          .map((e) => QueryWidgetOverviewidea.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryWidgetOverviewtoday> today;

  final QueryWidgetOverviewme? me;

  final QueryWidgetOverviewsettings? settings;

  final QueryWidgetOverviewnotificationSettingsByPk? notificationSettingsByPk;

  final List<QueryWidgetOverviewplusStates> plusStates;

  final List<QueryWidgetOverviewpartnerNote> partnerNote;

  final List<QueryWidgetOverviewpartnerMood> partnerMood;

  final List<QueryWidgetOverviewpartnerMiss> partnerMiss;

  final List<QueryWidgetOverviewmyMood> myMood;

  final List<QueryWidgetOverviewrituals> rituals;

  final List<QueryWidgetOverviewidea> idea;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$today = today;
    _resultData['today'] = l$today.map((e) => e.toJson()).toList();
    final l$me = me;
    _resultData['me'] = l$me?.toJson();
    final l$settings = settings;
    _resultData['settings'] = l$settings?.toJson();
    final l$notificationSettingsByPk = notificationSettingsByPk;
    _resultData['notificationSettingsByPk'] = l$notificationSettingsByPk?.toJson();
    final l$plusStates = plusStates;
    _resultData['plusStates'] = l$plusStates.map((e) => e.toJson()).toList();
    final l$partnerNote = partnerNote;
    _resultData['partnerNote'] = l$partnerNote.map((e) => e.toJson()).toList();
    final l$partnerMood = partnerMood;
    _resultData['partnerMood'] = l$partnerMood.map((e) => e.toJson()).toList();
    final l$partnerMiss = partnerMiss;
    _resultData['partnerMiss'] = l$partnerMiss.map((e) => e.toJson()).toList();
    final l$myMood = myMood;
    _resultData['myMood'] = l$myMood.map((e) => e.toJson()).toList();
    final l$rituals = rituals;
    _resultData['rituals'] = l$rituals.map((e) => e.toJson()).toList();
    final l$idea = idea;
    _resultData['idea'] = l$idea.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$today = today;
    final l$me = me;
    final l$settings = settings;
    final l$notificationSettingsByPk = notificationSettingsByPk;
    final l$plusStates = plusStates;
    final l$partnerNote = partnerNote;
    final l$partnerMood = partnerMood;
    final l$partnerMiss = partnerMiss;
    final l$myMood = myMood;
    final l$rituals = rituals;
    final l$idea = idea;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$today.map((v) => v)),
      l$me,
      l$settings,
      l$notificationSettingsByPk,
      Object.hashAll(l$plusStates.map((v) => v)),
      Object.hashAll(l$partnerNote.map((v) => v)),
      Object.hashAll(l$partnerMood.map((v) => v)),
      Object.hashAll(l$partnerMiss.map((v) => v)),
      Object.hashAll(l$myMood.map((v) => v)),
      Object.hashAll(l$rituals.map((v) => v)),
      Object.hashAll(l$idea.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverview || runtimeType != other.runtimeType) {
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
    final l$me = me;
    final lOther$me = other.me;
    if (l$me != lOther$me) {
      return false;
    }
    final l$settings = settings;
    final lOther$settings = other.settings;
    if (l$settings != lOther$settings) {
      return false;
    }
    final l$notificationSettingsByPk = notificationSettingsByPk;
    final lOther$notificationSettingsByPk = other.notificationSettingsByPk;
    if (l$notificationSettingsByPk != lOther$notificationSettingsByPk) {
      return false;
    }
    final l$plusStates = plusStates;
    final lOther$plusStates = other.plusStates;
    if (l$plusStates.length != lOther$plusStates.length) {
      return false;
    }
    for (int i = 0; i < l$plusStates.length; i++) {
      final l$plusStates$entry = l$plusStates[i];
      final lOther$plusStates$entry = lOther$plusStates[i];
      if (l$plusStates$entry != lOther$plusStates$entry) {
        return false;
      }
    }
    final l$partnerNote = partnerNote;
    final lOther$partnerNote = other.partnerNote;
    if (l$partnerNote.length != lOther$partnerNote.length) {
      return false;
    }
    for (int i = 0; i < l$partnerNote.length; i++) {
      final l$partnerNote$entry = l$partnerNote[i];
      final lOther$partnerNote$entry = lOther$partnerNote[i];
      if (l$partnerNote$entry != lOther$partnerNote$entry) {
        return false;
      }
    }
    final l$partnerMood = partnerMood;
    final lOther$partnerMood = other.partnerMood;
    if (l$partnerMood.length != lOther$partnerMood.length) {
      return false;
    }
    for (int i = 0; i < l$partnerMood.length; i++) {
      final l$partnerMood$entry = l$partnerMood[i];
      final lOther$partnerMood$entry = lOther$partnerMood[i];
      if (l$partnerMood$entry != lOther$partnerMood$entry) {
        return false;
      }
    }
    final l$partnerMiss = partnerMiss;
    final lOther$partnerMiss = other.partnerMiss;
    if (l$partnerMiss.length != lOther$partnerMiss.length) {
      return false;
    }
    for (int i = 0; i < l$partnerMiss.length; i++) {
      final l$partnerMiss$entry = l$partnerMiss[i];
      final lOther$partnerMiss$entry = lOther$partnerMiss[i];
      if (l$partnerMiss$entry != lOther$partnerMiss$entry) {
        return false;
      }
    }
    final l$myMood = myMood;
    final lOther$myMood = other.myMood;
    if (l$myMood.length != lOther$myMood.length) {
      return false;
    }
    for (int i = 0; i < l$myMood.length; i++) {
      final l$myMood$entry = l$myMood[i];
      final lOther$myMood$entry = lOther$myMood[i];
      if (l$myMood$entry != lOther$myMood$entry) {
        return false;
      }
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
    final l$idea = idea;
    final lOther$idea = other.idea;
    if (l$idea.length != lOther$idea.length) {
      return false;
    }
    for (int i = 0; i < l$idea.length; i++) {
      final l$idea$entry = l$idea[i];
      final lOther$idea$entry = lOther$idea[i];
      if (l$idea$entry != lOther$idea$entry) {
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

const documentNodeQueryWidgetOverview = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'WidgetOverview'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
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
                  name: NameNode(value: 'partnerName'),
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
                  name: NameNode(value: 'cardId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'unopenedCards'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'slipsThisWeek'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'slipsTotal'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'slipDays'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'nextDateOn'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'nextDate'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'title'),
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
            name: NameNode(value: 'profilesByPk'),
            alias: NameNode(value: 'me'),
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
                  name: NameNode(value: 'displayName'),
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
                  name: NameNode(value: 'widgetAllowPartnerNotes'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'widgetOnLockScreen'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'widgetShowNames'),
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
            name: NameNode(value: 'notificationSettingsByPk'),
            alias: null,
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
                  name: NameNode(value: 'cardDay'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'cardHour'),
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
            name: NameNode(value: 'plusStates'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'userId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'userId')),
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
                  name: NameNode(value: 'hasPlus'),
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
            name: NameNode(value: 'partnerMessages'),
            alias: NameNode(value: 'partnerNote'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'forWidget'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: BooleanValueNode(value: true),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'senderId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_neq'),
                            value: VariableNode(name: NameNode(value: 'userId')),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'recipientId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'userId')),
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
                value: IntValueNode(value: '1'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'body'),
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
                  name: NameNode(value: 'mediaFileId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'createdAt'),
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
            name: NameNode(value: 'sharedMoods'),
            alias: NameNode(value: 'partnerMood'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'userId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_neq'),
                            value: VariableNode(name: NameNode(value: 'userId')),
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
                          name: NameNode(value: 'updatedAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc')),
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
                  name: NameNode(value: 'mood'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'updatedAt'),
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
            name: NameNode(value: 'signals'),
            alias: NameNode(value: 'partnerMiss'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'kind'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: EnumValueNode(name: NameNode(value: 'miss_us')),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'senderId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_neq'),
                            value: VariableNode(name: NameNode(value: 'userId')),
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
                          value: EnumValueNode(name: NameNode(value: 'desc')),
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
                  name: NameNode(value: 'createdAt'),
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
            name: NameNode(value: 'moods'),
            alias: NameNode(value: 'myMood'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'authorId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'userId')),
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
                  name: NameNode(value: 'mood'),
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
                value: IntValueNode(value: '1'),
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
            name: NameNode(value: 'dailyContent'),
            alias: NameNode(value: 'idea'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'kind'),
                      value: StringValueNode(value: 'daily_idea', isBlock: false),
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
                  name: NameNode(value: 'slug'),
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
QueryWidgetOverview _parserFnQueryWidgetOverview(Map<String, dynamic> data) =>
    QueryWidgetOverview.fromJson(data);
typedef OnQueryCompleteQueryWidgetOverview = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryWidgetOverview?,
);

class OptionsQueryWidgetOverview extends graphql.QueryOptions<QueryWidgetOverview> {
  OptionsQueryWidgetOverview({
    String? operationName,
    required VariablesQueryWidgetOverview variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryWidgetOverview? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryWidgetOverview? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'WidgetOverview',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryWidgetOverview(data)),
         onError: onError,
         document: documentNodeQueryWidgetOverview,
         parserFn: _parserFnQueryWidgetOverview,
       );

  final OnQueryCompleteQueryWidgetOverview? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryWidgetOverview extends graphql.WatchQueryOptions<QueryWidgetOverview> {
  WatchOptionsQueryWidgetOverview({
    String? operationName,
    required VariablesQueryWidgetOverview variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryWidgetOverview? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'WidgetOverview',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryWidgetOverview,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryWidgetOverview,
       );
}

class FetchMoreOptionsQueryWidgetOverview extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryWidgetOverview({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryWidgetOverview variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryWidgetOverview,
       );
}

extension ClientExtensionQueryWidgetOverview on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryWidgetOverview>> queryWidgetOverview(
    OptionsQueryWidgetOverview options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryWidgetOverview> watchQueryWidgetOverview(
    WatchOptionsQueryWidgetOverview options,
  ) => this.watchQuery(options);

  void writeQueryWidgetOverview({
    required QueryWidgetOverview data,
    required VariablesQueryWidgetOverview variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryWidgetOverview),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryWidgetOverview? readQueryWidgetOverview({
    required VariablesQueryWidgetOverview variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryWidgetOverview),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryWidgetOverview.fromJson(result);
  }
}

class QueryWidgetOverviewtoday {
  QueryWidgetOverviewtoday({
    this.userId,
    this.coupleId,
    this.partnerName,
    this.togetherSince,
    this.cardId,
    this.unopenedCards,
    this.slipsThisWeek,
    this.slipsTotal,
    this.slipDays,
    this.nextDateOn,
    this.nextDate,
    this.$__typename = 'today',
  });

  factory QueryWidgetOverviewtoday.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$coupleId = json['coupleId'];
    final l$partnerName = json['partnerName'];
    final l$togetherSince = json['togetherSince'];
    final l$cardId = json['cardId'];
    final l$unopenedCards = json['unopenedCards'];
    final l$slipsThisWeek = json['slipsThisWeek'];
    final l$slipsTotal = json['slipsTotal'];
    final l$slipDays = json['slipDays'];
    final l$nextDateOn = json['nextDateOn'];
    final l$nextDate = json['nextDate'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewtoday(
      userId: (l$userId as String?),
      coupleId: (l$coupleId as String?),
      partnerName: (l$partnerName as String?),
      togetherSince: l$togetherSince == null ? null : DateTime.parse((l$togetherSince as String)),
      cardId: (l$cardId as String?),
      unopenedCards: (l$unopenedCards as int?),
      slipsThisWeek: (l$slipsThisWeek as int?),
      slipsTotal: (l$slipsTotal as int?),
      slipDays: (l$slipDays as List<dynamic>?)?.map((e) => DateTime.parse((e as String))).toList(),
      nextDateOn: l$nextDateOn == null ? null : DateTime.parse((l$nextDateOn as String)),
      nextDate: l$nextDate == null
          ? null
          : QueryWidgetOverviewtodaynextDate.fromJson((l$nextDate as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String? userId;

  final String? coupleId;

  final String? partnerName;

  final DateTime? togetherSince;

  final String? cardId;

  final int? unopenedCards;

  final int? slipsThisWeek;

  final int? slipsTotal;

  final List<DateTime>? slipDays;

  final DateTime? nextDateOn;

  final QueryWidgetOverviewtodaynextDate? nextDate;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$partnerName = partnerName;
    _resultData['partnerName'] = l$partnerName;
    final l$togetherSince = togetherSince;
    _resultData['togetherSince'] = l$togetherSince == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$togetherSince);
    final l$cardId = cardId;
    _resultData['cardId'] = l$cardId;
    final l$unopenedCards = unopenedCards;
    _resultData['unopenedCards'] = l$unopenedCards;
    final l$slipsThisWeek = slipsThisWeek;
    _resultData['slipsThisWeek'] = l$slipsThisWeek;
    final l$slipsTotal = slipsTotal;
    _resultData['slipsTotal'] = l$slipsTotal;
    final l$slipDays = slipDays;
    _resultData['slipDays'] = l$slipDays
        ?.map((e) => ((v) => v.toIso8601String().substring(0, 10))(e))
        .toList();
    final l$nextDateOn = nextDateOn;
    _resultData['nextDateOn'] = l$nextDateOn == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$nextDateOn);
    final l$nextDate = nextDate;
    _resultData['nextDate'] = l$nextDate?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$coupleId = coupleId;
    final l$partnerName = partnerName;
    final l$togetherSince = togetherSince;
    final l$cardId = cardId;
    final l$unopenedCards = unopenedCards;
    final l$slipsThisWeek = slipsThisWeek;
    final l$slipsTotal = slipsTotal;
    final l$slipDays = slipDays;
    final l$nextDateOn = nextDateOn;
    final l$nextDate = nextDate;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$userId,
      l$coupleId,
      l$partnerName,
      l$togetherSince,
      l$cardId,
      l$unopenedCards,
      l$slipsThisWeek,
      l$slipsTotal,
      l$slipDays == null ? null : Object.hashAll(l$slipDays.map((v) => v)),
      l$nextDateOn,
      l$nextDate,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewtoday || runtimeType != other.runtimeType) {
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
    final l$togetherSince = togetherSince;
    final lOther$togetherSince = other.togetherSince;
    if (l$togetherSince != lOther$togetherSince) {
      return false;
    }
    final l$cardId = cardId;
    final lOther$cardId = other.cardId;
    if (l$cardId != lOther$cardId) {
      return false;
    }
    final l$unopenedCards = unopenedCards;
    final lOther$unopenedCards = other.unopenedCards;
    if (l$unopenedCards != lOther$unopenedCards) {
      return false;
    }
    final l$slipsThisWeek = slipsThisWeek;
    final lOther$slipsThisWeek = other.slipsThisWeek;
    if (l$slipsThisWeek != lOther$slipsThisWeek) {
      return false;
    }
    final l$slipsTotal = slipsTotal;
    final lOther$slipsTotal = other.slipsTotal;
    if (l$slipsTotal != lOther$slipsTotal) {
      return false;
    }
    final l$slipDays = slipDays;
    final lOther$slipDays = other.slipDays;
    if (l$slipDays != null && lOther$slipDays != null) {
      if (l$slipDays.length != lOther$slipDays.length) {
        return false;
      }
      for (int i = 0; i < l$slipDays.length; i++) {
        final l$slipDays$entry = l$slipDays[i];
        final lOther$slipDays$entry = lOther$slipDays[i];
        if (l$slipDays$entry != lOther$slipDays$entry) {
          return false;
        }
      }
    } else if (l$slipDays != lOther$slipDays) {
      return false;
    }
    final l$nextDateOn = nextDateOn;
    final lOther$nextDateOn = other.nextDateOn;
    if (l$nextDateOn != lOther$nextDateOn) {
      return false;
    }
    final l$nextDate = nextDate;
    final lOther$nextDate = other.nextDate;
    if (l$nextDate != lOther$nextDate) {
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

class QueryWidgetOverviewtodaynextDate {
  QueryWidgetOverviewtodaynextDate({required this.title, this.$__typename = 'importantDates'});

  factory QueryWidgetOverviewtodaynextDate.fromJson(Map<String, dynamic> json) {
    final l$title = json['title'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewtodaynextDate(
      title: (l$title as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String title;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$title = title;
    _resultData['title'] = l$title;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$$__typename = $__typename;
    return Object.hashAll([l$title, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewtodaynextDate || runtimeType != other.runtimeType) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
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

class QueryWidgetOverviewme {
  QueryWidgetOverviewme({this.displayName, this.$__typename = 'profiles'});

  factory QueryWidgetOverviewme.fromJson(Map<String, dynamic> json) {
    final l$displayName = json['displayName'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewme(
      displayName: (l$displayName as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? displayName;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$displayName = displayName;
    final l$$__typename = $__typename;
    return Object.hashAll([l$displayName, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewme || runtimeType != other.runtimeType) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
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

class QueryWidgetOverviewsettings {
  QueryWidgetOverviewsettings({
    required this.userId,
    this.phase,
    this.togetherSince,
    required this.widgetAllowPartnerNotes,
    required this.widgetOnLockScreen,
    required this.widgetShowNames,
    this.$__typename = 'userSettings',
  });

  factory QueryWidgetOverviewsettings.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$phase = json['phase'];
    final l$togetherSince = json['togetherSince'];
    final l$widgetAllowPartnerNotes = json['widgetAllowPartnerNotes'];
    final l$widgetOnLockScreen = json['widgetOnLockScreen'];
    final l$widgetShowNames = json['widgetShowNames'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewsettings(
      userId: (l$userId as String),
      phase: l$phase == null ? null : fromJsonEnumRelationshipPhase_enum((l$phase as String)),
      togetherSince: l$togetherSince == null ? null : DateTime.parse((l$togetherSince as String)),
      widgetAllowPartnerNotes: (l$widgetAllowPartnerNotes as bool),
      widgetOnLockScreen: (l$widgetOnLockScreen as bool),
      widgetShowNames: (l$widgetShowNames as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final EnumRelationshipPhase_enum? phase;

  final DateTime? togetherSince;

  final bool widgetAllowPartnerNotes;

  final bool widgetOnLockScreen;

  final bool widgetShowNames;

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
    final l$widgetAllowPartnerNotes = widgetAllowPartnerNotes;
    _resultData['widgetAllowPartnerNotes'] = l$widgetAllowPartnerNotes;
    final l$widgetOnLockScreen = widgetOnLockScreen;
    _resultData['widgetOnLockScreen'] = l$widgetOnLockScreen;
    final l$widgetShowNames = widgetShowNames;
    _resultData['widgetShowNames'] = l$widgetShowNames;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$phase = phase;
    final l$togetherSince = togetherSince;
    final l$widgetAllowPartnerNotes = widgetAllowPartnerNotes;
    final l$widgetOnLockScreen = widgetOnLockScreen;
    final l$widgetShowNames = widgetShowNames;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$userId,
      l$phase,
      l$togetherSince,
      l$widgetAllowPartnerNotes,
      l$widgetOnLockScreen,
      l$widgetShowNames,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewsettings || runtimeType != other.runtimeType) {
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
    final l$widgetAllowPartnerNotes = widgetAllowPartnerNotes;
    final lOther$widgetAllowPartnerNotes = other.widgetAllowPartnerNotes;
    if (l$widgetAllowPartnerNotes != lOther$widgetAllowPartnerNotes) {
      return false;
    }
    final l$widgetOnLockScreen = widgetOnLockScreen;
    final lOther$widgetOnLockScreen = other.widgetOnLockScreen;
    if (l$widgetOnLockScreen != lOther$widgetOnLockScreen) {
      return false;
    }
    final l$widgetShowNames = widgetShowNames;
    final lOther$widgetShowNames = other.widgetShowNames;
    if (l$widgetShowNames != lOther$widgetShowNames) {
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

class QueryWidgetOverviewnotificationSettingsByPk {
  QueryWidgetOverviewnotificationSettingsByPk({
    required this.cardDay,
    required this.cardHour,
    this.$__typename = 'notificationSettings',
  });

  factory QueryWidgetOverviewnotificationSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$cardDay = json['cardDay'];
    final l$cardHour = json['cardHour'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewnotificationSettingsByPk(
      cardDay: (l$cardDay as int),
      cardHour: (l$cardHour as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int cardDay;

  final int cardHour;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$cardDay = cardDay;
    _resultData['cardDay'] = l$cardDay;
    final l$cardHour = cardHour;
    _resultData['cardHour'] = l$cardHour;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$cardDay = cardDay;
    final l$cardHour = cardHour;
    final l$$__typename = $__typename;
    return Object.hashAll([l$cardDay, l$cardHour, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewnotificationSettingsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$cardDay = cardDay;
    final lOther$cardDay = other.cardDay;
    if (l$cardDay != lOther$cardDay) {
      return false;
    }
    final l$cardHour = cardHour;
    final lOther$cardHour = other.cardHour;
    if (l$cardHour != lOther$cardHour) {
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

class QueryWidgetOverviewplusStates {
  QueryWidgetOverviewplusStates({this.hasPlus, this.$__typename = 'plusStates'});

  factory QueryWidgetOverviewplusStates.fromJson(Map<String, dynamic> json) {
    final l$hasPlus = json['hasPlus'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewplusStates(
      hasPlus: (l$hasPlus as bool?),
      $__typename: (l$$__typename as String),
    );
  }

  final bool? hasPlus;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$hasPlus = hasPlus;
    _resultData['hasPlus'] = l$hasPlus;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$hasPlus = hasPlus;
    final l$$__typename = $__typename;
    return Object.hashAll([l$hasPlus, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewplusStates || runtimeType != other.runtimeType) {
      return false;
    }
    final l$hasPlus = hasPlus;
    final lOther$hasPlus = other.hasPlus;
    if (l$hasPlus != lOther$hasPlus) {
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

class QueryWidgetOverviewpartnerNote {
  QueryWidgetOverviewpartnerNote({
    this.body,
    required this.kind,
    this.mediaFileId,
    required this.createdAt,
    this.$__typename = 'partnerMessages',
  });

  factory QueryWidgetOverviewpartnerNote.fromJson(Map<String, dynamic> json) {
    final l$body = json['body'];
    final l$kind = json['kind'];
    final l$mediaFileId = json['mediaFileId'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewpartnerNote(
      body: (l$body as String?),
      kind: fromJsonEnumPartnerMessageKind_enum((l$kind as String)),
      mediaFileId: (l$mediaFileId as String?),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String? body;

  final EnumPartnerMessageKind_enum kind;

  final String? mediaFileId;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$body = body;
    _resultData['body'] = l$body;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumPartnerMessageKind_enum(l$kind);
    final l$mediaFileId = mediaFileId;
    _resultData['mediaFileId'] = l$mediaFileId;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$body = body;
    final l$kind = kind;
    final l$mediaFileId = mediaFileId;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$body, l$kind, l$mediaFileId, l$createdAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewpartnerNote || runtimeType != other.runtimeType) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$mediaFileId = mediaFileId;
    final lOther$mediaFileId = other.mediaFileId;
    if (l$mediaFileId != lOther$mediaFileId) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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

class QueryWidgetOverviewpartnerMood {
  QueryWidgetOverviewpartnerMood({
    required this.mood,
    required this.updatedAt,
    this.$__typename = 'sharedMoods',
  });

  factory QueryWidgetOverviewpartnerMood.fromJson(Map<String, dynamic> json) {
    final l$mood = json['mood'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewpartnerMood(
      mood: fromJsonEnumMood_enum((l$mood as String)),
      updatedAt: DateTime.parse((l$updatedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumMood_enum mood;

  final DateTime updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$mood = mood;
    _resultData['mood'] = toJsonEnumMood_enum(l$mood);
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = ((v) => v.toUtc().toIso8601String())(l$updatedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$mood = mood;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$mood, l$updatedAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewpartnerMood || runtimeType != other.runtimeType) {
      return false;
    }
    final l$mood = mood;
    final lOther$mood = other.mood;
    if (l$mood != lOther$mood) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
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

class QueryWidgetOverviewpartnerMiss {
  QueryWidgetOverviewpartnerMiss({required this.createdAt, this.$__typename = 'signals'});

  factory QueryWidgetOverviewpartnerMiss.fromJson(Map<String, dynamic> json) {
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewpartnerMiss(
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$createdAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewpartnerMiss || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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

class QueryWidgetOverviewmyMood {
  QueryWidgetOverviewmyMood({required this.mood, this.$__typename = 'moods'});

  factory QueryWidgetOverviewmyMood.fromJson(Map<String, dynamic> json) {
    final l$mood = json['mood'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewmyMood(
      mood: fromJsonEnumMood_enum((l$mood as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumMood_enum mood;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$mood = mood;
    _resultData['mood'] = toJsonEnumMood_enum(l$mood);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$mood = mood;
    final l$$__typename = $__typename;
    return Object.hashAll([l$mood, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewmyMood || runtimeType != other.runtimeType) {
      return false;
    }
    final l$mood = mood;
    final lOther$mood = other.mood;
    if (l$mood != lOther$mood) {
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

class QueryWidgetOverviewrituals {
  QueryWidgetOverviewrituals({
    required this.id,
    required this.title,
    required this.cadence,
    this.weekday,
    this.atTime,
    this.$__typename = 'rituals',
  });

  factory QueryWidgetOverviewrituals.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$cadence = json['cadence'];
    final l$weekday = json['weekday'];
    final l$atTime = json['atTime'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewrituals(
      id: (l$id as String),
      title: (l$title as String),
      cadence: fromJsonEnumRitualCadence_enum((l$cadence as String)),
      weekday: (l$weekday as int?),
      atTime: (l$atTime as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final EnumRitualCadence_enum cadence;

  final int? weekday;

  final String? atTime;

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
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$title, l$cadence, l$weekday, l$atTime, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewrituals || runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

class QueryWidgetOverviewidea {
  QueryWidgetOverviewidea({
    required this.slug,
    required this.title,
    this.body,
    this.$__typename = 'contentItems',
  });

  factory QueryWidgetOverviewidea.fromJson(Map<String, dynamic> json) {
    final l$slug = json['slug'];
    final l$title = json['title'];
    final l$body = json['body'];
    final l$$__typename = json['__typename'];
    return QueryWidgetOverviewidea(
      slug: (l$slug as String),
      title: (l$title as String),
      body: (l$body as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String slug;

  final String title;

  final String? body;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$slug = slug;
    final l$title = title;
    final l$body = body;
    final l$$__typename = $__typename;
    return Object.hashAll([l$slug, l$title, l$body, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryWidgetOverviewidea || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}
