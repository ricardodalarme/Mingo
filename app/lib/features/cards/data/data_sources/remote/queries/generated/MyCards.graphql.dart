// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMyCards {
  factory VariablesQueryMyCards({int? limit, int? offset}) => VariablesQueryMyCards._({
    if (limit != null) r'limit': limit,
    if (offset != null) r'offset': offset,
  });

  VariablesQueryMyCards._(this._$data);

  factory VariablesQueryMyCards.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('limit')) {
      final l$limit = data['limit'];
      result$data['limit'] = (l$limit as int?);
    }
    if (data.containsKey('offset')) {
      final l$offset = data['offset'];
      result$data['offset'] = (l$offset as int?);
    }
    return VariablesQueryMyCards._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get limit => (_$data['limit'] as int?);

  int? get offset => (_$data['offset'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('limit')) {
      final l$limit = limit;
      result$data['limit'] = l$limit;
    }
    if (_$data.containsKey('offset')) {
      final l$offset = offset;
      result$data['offset'] = l$offset;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryMyCards || runtimeType != other.runtimeType) {
      return false;
    }
    final l$limit = limit;
    final lOther$limit = other.limit;
    if (_$data.containsKey('limit') != other._$data.containsKey('limit')) {
      return false;
    }
    if (l$limit != lOther$limit) {
      return false;
    }
    final l$offset = offset;
    final lOther$offset = other.offset;
    if (_$data.containsKey('offset') != other._$data.containsKey('offset')) {
      return false;
    }
    if (l$offset != lOther$offset) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$limit = limit;
    final l$offset = offset;
    return Object.hashAll([
      _$data.containsKey('limit') ? l$limit : const {},
      _$data.containsKey('offset') ? l$offset : const {},
    ]);
  }
}

class QueryMyCards {
  QueryMyCards({required this.cards, this.$__typename = 'query_root'});

  factory QueryMyCards.fromJson(Map<String, dynamic> json) {
    final l$cards = json['cards'];
    final l$$__typename = json['__typename'];
    return QueryMyCards(
      cards: (l$cards as List<dynamic>)
          .map((e) => QueryMyCardscards.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMyCardscards> cards;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$cards = cards;
    _resultData['cards'] = l$cards.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$cards = cards;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$cards.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyCards || runtimeType != other.runtimeType) {
      return false;
    }
    final l$cards = cards;
    final lOther$cards = other.cards;
    if (l$cards.length != lOther$cards.length) {
      return false;
    }
    for (int i = 0; i < l$cards.length; i++) {
      final l$cards$entry = l$cards[i];
      final lOther$cards$entry = lOther$cards[i];
      if (l$cards$entry != lOther$cards$entry) {
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

const documentNodeQueryMyCards = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyCards'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'limit')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'offset')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'cards'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: VariableNode(name: NameNode(value: 'limit')),
              ),
              ArgumentNode(
                name: NameNode(value: 'offset'),
                value: VariableNode(name: NameNode(value: 'offset')),
              ),
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'status'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: EnumValueNode(name: NameNode(value: 'sent')),
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
                          name: NameNode(value: 'sentAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc')),
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
                  name: NameNode(value: 'authorId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'sentAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'weekStart'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'items'),
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
                  name: NameNode(value: 'reaction'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'reaction'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'reply'),
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
                  name: NameNode(value: 'open'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'openedAt'),
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
QueryMyCards _parserFnQueryMyCards(Map<String, dynamic> data) => QueryMyCards.fromJson(data);
typedef OnQueryCompleteQueryMyCards = FutureOr<void> Function(Map<String, dynamic>?, QueryMyCards?);

class OptionsQueryMyCards extends graphql.QueryOptions<QueryMyCards> {
  OptionsQueryMyCards({
    String? operationName,
    VariablesQueryMyCards? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyCards? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyCards? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables?.toJson() ?? {},
         operationName: operationName ?? 'MyCards',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyCards(data)),
         onError: onError,
         document: documentNodeQueryMyCards,
         parserFn: _parserFnQueryMyCards,
       );

  final OnQueryCompleteQueryMyCards? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyCards extends graphql.WatchQueryOptions<QueryMyCards> {
  WatchOptionsQueryMyCards({
    String? operationName,
    VariablesQueryMyCards? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyCards? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables?.toJson() ?? {},
         operationName: operationName ?? 'MyCards',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyCards,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyCards,
       );
}

class FetchMoreOptionsQueryMyCards extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyCards({
    required graphql.UpdateQuery updateQuery,
    VariablesQueryMyCards? variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables?.toJson() ?? {},
         document: documentNodeQueryMyCards,
       );
}

extension ClientExtensionQueryMyCards on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyCards>> queryMyCards([OptionsQueryMyCards? options]) async =>
      await this.query(options ?? OptionsQueryMyCards());

  graphql.ObservableQuery<QueryMyCards> watchQueryMyCards([WatchOptionsQueryMyCards? options]) =>
      this.watchQuery(options ?? WatchOptionsQueryMyCards());

  void writeQueryMyCards({
    required QueryMyCards data,
    VariablesQueryMyCards? variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMyCards),
      variables: variables?.toJson() ?? const {},
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyCards? readQueryMyCards({VariablesQueryMyCards? variables, bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMyCards),
        variables: variables?.toJson() ?? const {},
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyCards.fromJson(result);
  }
}

class QueryMyCardscards {
  QueryMyCardscards({
    required this.id,
    required this.authorId,
    this.sentAt,
    required this.weekStart,
    required this.items,
    this.reaction,
    this.open,
    this.$__typename = 'cards',
  });

  factory QueryMyCardscards.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$authorId = json['authorId'];
    final l$sentAt = json['sentAt'];
    final l$weekStart = json['weekStart'];
    final l$items = json['items'];
    final l$reaction = json['reaction'];
    final l$open = json['open'];
    final l$$__typename = json['__typename'];
    return QueryMyCardscards(
      id: (l$id as String),
      authorId: (l$authorId as String),
      sentAt: l$sentAt == null ? null : DateTime.parse((l$sentAt as String)),
      weekStart: DateTime.parse((l$weekStart as String)),
      items: (l$items as List<dynamic>)
          .map((e) => QueryMyCardscardsitems.fromJson((e as Map<String, dynamic>)))
          .toList(),
      reaction: l$reaction == null
          ? null
          : QueryMyCardscardsreaction.fromJson((l$reaction as Map<String, dynamic>)),
      open: l$open == null
          ? null
          : QueryMyCardscardsopen.fromJson((l$open as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String authorId;

  final DateTime? sentAt;

  final DateTime weekStart;

  final List<QueryMyCardscardsitems> items;

  final QueryMyCardscardsreaction? reaction;

  final QueryMyCardscardsopen? open;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$sentAt = sentAt;
    _resultData['sentAt'] = l$sentAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$sentAt);
    final l$weekStart = weekStart;
    _resultData['weekStart'] = ((v) => v.toIso8601String().substring(0, 10))(l$weekStart);
    final l$items = items;
    _resultData['items'] = l$items.map((e) => e.toJson()).toList();
    final l$reaction = reaction;
    _resultData['reaction'] = l$reaction?.toJson();
    final l$open = open;
    _resultData['open'] = l$open?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$authorId = authorId;
    final l$sentAt = sentAt;
    final l$weekStart = weekStart;
    final l$items = items;
    final l$reaction = reaction;
    final l$open = open;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$authorId,
      l$sentAt,
      l$weekStart,
      Object.hashAll(l$items.map((v) => v)),
      l$reaction,
      l$open,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyCardscards || runtimeType != other.runtimeType) {
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
    final l$sentAt = sentAt;
    final lOther$sentAt = other.sentAt;
    if (l$sentAt != lOther$sentAt) {
      return false;
    }
    final l$weekStart = weekStart;
    final lOther$weekStart = other.weekStart;
    if (l$weekStart != lOther$weekStart) {
      return false;
    }
    final l$items = items;
    final lOther$items = other.items;
    if (l$items.length != lOther$items.length) {
      return false;
    }
    for (int i = 0; i < l$items.length; i++) {
      final l$items$entry = l$items[i];
      final lOther$items$entry = lOther$items[i];
      if (l$items$entry != lOther$items$entry) {
        return false;
      }
    }
    final l$reaction = reaction;
    final lOther$reaction = other.reaction;
    if (l$reaction != lOther$reaction) {
      return false;
    }
    final l$open = open;
    final lOther$open = other.open;
    if (l$open != lOther$open) {
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

class QueryMyCardscardsitems {
  QueryMyCardscardsitems({required this.id, this.$__typename = 'cardItems'});

  factory QueryMyCardscardsitems.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return QueryMyCardscardsitems(id: (l$id as String), $__typename: (l$$__typename as String));
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyCardscardsitems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

class QueryMyCardscardsreaction {
  QueryMyCardscardsreaction({this.reaction, this.reply, this.$__typename = 'cardReactions'});

  factory QueryMyCardscardsreaction.fromJson(Map<String, dynamic> json) {
    final l$reaction = json['reaction'];
    final l$reply = json['reply'];
    final l$$__typename = json['__typename'];
    return QueryMyCardscardsreaction(
      reaction: (l$reaction as String?),
      reply: (l$reply as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? reaction;

  final String? reply;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$reaction = reaction;
    _resultData['reaction'] = l$reaction;
    final l$reply = reply;
    _resultData['reply'] = l$reply;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$reaction = reaction;
    final l$reply = reply;
    final l$$__typename = $__typename;
    return Object.hashAll([l$reaction, l$reply, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyCardscardsreaction || runtimeType != other.runtimeType) {
      return false;
    }
    final l$reaction = reaction;
    final lOther$reaction = other.reaction;
    if (l$reaction != lOther$reaction) {
      return false;
    }
    final l$reply = reply;
    final lOther$reply = other.reply;
    if (l$reply != lOther$reply) {
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

class QueryMyCardscardsopen {
  QueryMyCardscardsopen({required this.openedAt, this.$__typename = 'cardOpens'});

  factory QueryMyCardscardsopen.fromJson(Map<String, dynamic> json) {
    final l$openedAt = json['openedAt'];
    final l$$__typename = json['__typename'];
    return QueryMyCardscardsopen(
      openedAt: DateTime.parse((l$openedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime openedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$openedAt = openedAt;
    _resultData['openedAt'] = ((v) => v.toUtc().toIso8601String())(l$openedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$openedAt = openedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$openedAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyCardscardsopen || runtimeType != other.runtimeType) {
      return false;
    }
    final l$openedAt = openedAt;
    final lOther$openedAt = other.openedAt;
    if (l$openedAt != lOther$openedAt) {
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
