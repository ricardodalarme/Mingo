// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryChatStatus {
  factory VariablesQueryChatStatus({required String userId}) =>
      VariablesQueryChatStatus._({r'userId': userId});

  VariablesQueryChatStatus._(this._$data);

  factory VariablesQueryChatStatus.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryChatStatus._(result$data);
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
    if (other is! VariablesQueryChatStatus || runtimeType != other.runtimeType) {
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

class QueryChatStatus {
  QueryChatStatus({
    required this.plusStates,
    this.plusLimit,
    this.freeLimit,
    this.userSettingsByPk,
    this.$__typename = 'query_root',
  });

  factory QueryChatStatus.fromJson(Map<String, dynamic> json) {
    final l$plusStates = json['plusStates'];
    final l$plusLimit = json['plusLimit'];
    final l$freeLimit = json['freeLimit'];
    final l$userSettingsByPk = json['userSettingsByPk'];
    final l$$__typename = json['__typename'];
    return QueryChatStatus(
      plusStates: (l$plusStates as List<dynamic>)
          .map((e) => QueryChatStatusplusStates.fromJson((e as Map<String, dynamic>)))
          .toList(),
      plusLimit: l$plusLimit == null
          ? null
          : QueryChatStatusplusLimit.fromJson((l$plusLimit as Map<String, dynamic>)),
      freeLimit: l$freeLimit == null
          ? null
          : QueryChatStatusfreeLimit.fromJson((l$freeLimit as Map<String, dynamic>)),
      userSettingsByPk: l$userSettingsByPk == null
          ? null
          : QueryChatStatususerSettingsByPk.fromJson((l$userSettingsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryChatStatusplusStates> plusStates;

  final QueryChatStatusplusLimit? plusLimit;

  final QueryChatStatusfreeLimit? freeLimit;

  final QueryChatStatususerSettingsByPk? userSettingsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$plusStates = plusStates;
    _resultData['plusStates'] = l$plusStates.map((e) => e.toJson()).toList();
    final l$plusLimit = plusLimit;
    _resultData['plusLimit'] = l$plusLimit?.toJson();
    final l$freeLimit = freeLimit;
    _resultData['freeLimit'] = l$freeLimit?.toJson();
    final l$userSettingsByPk = userSettingsByPk;
    _resultData['userSettingsByPk'] = l$userSettingsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$plusStates = plusStates;
    final l$plusLimit = plusLimit;
    final l$freeLimit = freeLimit;
    final l$userSettingsByPk = userSettingsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$plusStates.map((v) => v)),
      l$plusLimit,
      l$freeLimit,
      l$userSettingsByPk,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryChatStatus || runtimeType != other.runtimeType) {
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
    final l$plusLimit = plusLimit;
    final lOther$plusLimit = other.plusLimit;
    if (l$plusLimit != lOther$plusLimit) {
      return false;
    }
    final l$freeLimit = freeLimit;
    final lOther$freeLimit = other.freeLimit;
    if (l$freeLimit != lOther$freeLimit) {
      return false;
    }
    final l$userSettingsByPk = userSettingsByPk;
    final lOther$userSettingsByPk = other.userSettingsByPk;
    if (l$userSettingsByPk != lOther$userSettingsByPk) {
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

const documentNodeQueryChatStatus = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'ChatStatus'),
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
                  name: NameNode(value: 'chatMessagesLeftToday'),
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
            name: NameNode(value: 'appConfigByPk'),
            alias: NameNode(value: 'plusLimit'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'key'),
                value: StringValueNode(value: 'chat_messages_per_day_plus', isBlock: false),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'value'),
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
            name: NameNode(value: 'appConfigByPk'),
            alias: NameNode(value: 'freeLimit'),
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'key'),
                value: StringValueNode(value: 'chat_messages_per_day_free', isBlock: false),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'value'),
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
                  name: NameNode(value: 'userId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'chatEnabled'),
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
QueryChatStatus _parserFnQueryChatStatus(Map<String, dynamic> data) =>
    QueryChatStatus.fromJson(data);
typedef OnQueryCompleteQueryChatStatus = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryChatStatus?,
);

class OptionsQueryChatStatus extends graphql.QueryOptions<QueryChatStatus> {
  OptionsQueryChatStatus({
    String? operationName,
    required VariablesQueryChatStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryChatStatus? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryChatStatus? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ChatStatus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryChatStatus(data)),
         onError: onError,
         document: documentNodeQueryChatStatus,
         parserFn: _parserFnQueryChatStatus,
       );

  final OnQueryCompleteQueryChatStatus? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryChatStatus extends graphql.WatchQueryOptions<QueryChatStatus> {
  WatchOptionsQueryChatStatus({
    String? operationName,
    required VariablesQueryChatStatus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryChatStatus? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ChatStatus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryChatStatus,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryChatStatus,
       );
}

class FetchMoreOptionsQueryChatStatus extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryChatStatus({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryChatStatus variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryChatStatus,
       );
}

extension ClientExtensionQueryChatStatus on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryChatStatus>> queryChatStatus(
    OptionsQueryChatStatus options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryChatStatus> watchQueryChatStatus(
    WatchOptionsQueryChatStatus options,
  ) => this.watchQuery(options);

  void writeQueryChatStatus({
    required QueryChatStatus data,
    required VariablesQueryChatStatus variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryChatStatus),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryChatStatus? readQueryChatStatus({
    required VariablesQueryChatStatus variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryChatStatus),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryChatStatus.fromJson(result);
  }
}

class QueryChatStatusplusStates {
  QueryChatStatusplusStates({this.chatMessagesLeftToday, this.$__typename = 'plusStates'});

  factory QueryChatStatusplusStates.fromJson(Map<String, dynamic> json) {
    final l$chatMessagesLeftToday = json['chatMessagesLeftToday'];
    final l$$__typename = json['__typename'];
    return QueryChatStatusplusStates(
      chatMessagesLeftToday: (l$chatMessagesLeftToday as int?),
      $__typename: (l$$__typename as String),
    );
  }

  final int? chatMessagesLeftToday;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$chatMessagesLeftToday = chatMessagesLeftToday;
    _resultData['chatMessagesLeftToday'] = l$chatMessagesLeftToday;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$chatMessagesLeftToday = chatMessagesLeftToday;
    final l$$__typename = $__typename;
    return Object.hashAll([l$chatMessagesLeftToday, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryChatStatusplusStates || runtimeType != other.runtimeType) {
      return false;
    }
    final l$chatMessagesLeftToday = chatMessagesLeftToday;
    final lOther$chatMessagesLeftToday = other.chatMessagesLeftToday;
    if (l$chatMessagesLeftToday != lOther$chatMessagesLeftToday) {
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

class QueryChatStatusplusLimit {
  QueryChatStatusplusLimit({required this.value, this.$__typename = 'appConfig'});

  factory QueryChatStatusplusLimit.fromJson(Map<String, dynamic> json) {
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return QueryChatStatusplusLimit(
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryChatStatusplusLimit || runtimeType != other.runtimeType) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
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

class QueryChatStatusfreeLimit {
  QueryChatStatusfreeLimit({required this.value, this.$__typename = 'appConfig'});

  factory QueryChatStatusfreeLimit.fromJson(Map<String, dynamic> json) {
    final l$value = json['value'];
    final l$$__typename = json['__typename'];
    return QueryChatStatusfreeLimit(
      value: (l$value as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String value;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$value = value;
    _resultData['value'] = l$value;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$value = value;
    final l$$__typename = $__typename;
    return Object.hashAll([l$value, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryChatStatusfreeLimit || runtimeType != other.runtimeType) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
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

class QueryChatStatususerSettingsByPk {
  QueryChatStatususerSettingsByPk({
    required this.userId,
    required this.chatEnabled,
    this.$__typename = 'userSettings',
  });

  factory QueryChatStatususerSettingsByPk.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$chatEnabled = json['chatEnabled'];
    final l$$__typename = json['__typename'];
    return QueryChatStatususerSettingsByPk(
      userId: (l$userId as String),
      chatEnabled: (l$chatEnabled as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final bool chatEnabled;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$chatEnabled = chatEnabled;
    _resultData['chatEnabled'] = l$chatEnabled;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$chatEnabled = chatEnabled;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$chatEnabled, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryChatStatususerSettingsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$chatEnabled = chatEnabled;
    final lOther$chatEnabled = other.chatEnabled;
    if (l$chatEnabled != lOther$chatEnabled) {
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
