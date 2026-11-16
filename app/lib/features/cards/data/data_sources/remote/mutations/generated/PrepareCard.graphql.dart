// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:network/network.dart';

class MutationPrepareCard {
  MutationPrepareCard({required this.prepareCard, this.$__typename = 'mutation_root'});

  factory MutationPrepareCard.fromJson(Map<String, dynamic> json) {
    final l$prepareCard = json['prepareCard'];
    final l$$__typename = json['__typename'];
    return MutationPrepareCard(
      prepareCard: (l$prepareCard as List<dynamic>)
          .map((e) => MutationPrepareCardprepareCard.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationPrepareCardprepareCard> prepareCard;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$prepareCard = prepareCard;
    _resultData['prepareCard'] = l$prepareCard.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$prepareCard = prepareCard;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$prepareCard.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationPrepareCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$prepareCard = prepareCard;
    final lOther$prepareCard = other.prepareCard;
    if (l$prepareCard.length != lOther$prepareCard.length) {
      return false;
    }
    for (int i = 0; i < l$prepareCard.length; i++) {
      final l$prepareCard$entry = l$prepareCard[i];
      final lOther$prepareCard$entry = lOther$prepareCard[i];
      if (l$prepareCard$entry != lOther$prepareCard$entry) {
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

const documentNodeMutationPrepareCard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'PrepareCard'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'prepareCard'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'cardId'),
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
                  name: NameNode(value: 'status'),
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
                  name: NameNode(value: 'note'),
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
MutationPrepareCard _parserFnMutationPrepareCard(Map<String, dynamic> data) =>
    MutationPrepareCard.fromJson(data);
typedef OnMutationCompletedMutationPrepareCard = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationPrepareCard?,
);

class OptionsMutationPrepareCard extends graphql.MutationOptions<MutationPrepareCard> {
  OptionsMutationPrepareCard({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationPrepareCard? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationPrepareCard? onCompleted,
    graphql.OnMutationUpdate<MutationPrepareCard>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName ?? 'PrepareCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationPrepareCard(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationPrepareCard,
         parserFn: _parserFnMutationPrepareCard,
       );

  final OnMutationCompletedMutationPrepareCard? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationPrepareCard extends graphql.WatchQueryOptions<MutationPrepareCard> {
  WatchOptionsMutationPrepareCard({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationPrepareCard? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'PrepareCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationPrepareCard,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationPrepareCard,
       );
}

extension ClientExtensionMutationPrepareCard on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationPrepareCard>> mutatePrepareCard([
    OptionsMutationPrepareCard? options,
  ]) async => await this.mutate(options ?? OptionsMutationPrepareCard());

  graphql.ObservableQuery<MutationPrepareCard> watchMutationPrepareCard([
    WatchOptionsMutationPrepareCard? options,
  ]) => this.watchMutation(options ?? WatchOptionsMutationPrepareCard());
}

class MutationPrepareCardprepareCard {
  MutationPrepareCardprepareCard({
    required this.cardId,
    required this.kind,
    required this.status,
    required this.weekStart,
    this.note,
    required this.items,
    this.$__typename = 'preparedCards',
  });

  factory MutationPrepareCardprepareCard.fromJson(Map<String, dynamic> json) {
    final l$cardId = json['cardId'];
    final l$kind = json['kind'];
    final l$status = json['status'];
    final l$weekStart = json['weekStart'];
    final l$note = json['note'];
    final l$items = json['items'];
    final l$$__typename = json['__typename'];
    return MutationPrepareCardprepareCard(
      cardId: (l$cardId as String),
      kind: fromJsonEnumCardKind_enum((l$kind as String)),
      status: fromJsonEnumCardStatus_enum((l$status as String)),
      weekStart: DateTime.parse((l$weekStart as String)),
      note: (l$note as String?),
      items: decodeJsonb(l$items),
      $__typename: (l$$__typename as String),
    );
  }

  final String cardId;

  final EnumCardKind_enum kind;

  final EnumCardStatus_enum status;

  final DateTime weekStart;

  final String? note;

  final dynamic items;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$cardId = cardId;
    _resultData['cardId'] = l$cardId;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumCardKind_enum(l$kind);
    final l$status = status;
    _resultData['status'] = toJsonEnumCardStatus_enum(l$status);
    final l$weekStart = weekStart;
    _resultData['weekStart'] = ((v) => v.toIso8601String().substring(0, 10))(l$weekStart);
    final l$note = note;
    _resultData['note'] = l$note;
    final l$items = items;
    _resultData['items'] = encodeJsonb(l$items);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$cardId = cardId;
    final l$kind = kind;
    final l$status = status;
    final l$weekStart = weekStart;
    final l$note = note;
    final l$items = items;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$cardId,
      l$kind,
      l$status,
      l$weekStart,
      l$note,
      l$items,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationPrepareCardprepareCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$cardId = cardId;
    final lOther$cardId = other.cardId;
    if (l$cardId != lOther$cardId) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$weekStart = weekStart;
    final lOther$weekStart = other.weekStart;
    if (l$weekStart != lOther$weekStart) {
      return false;
    }
    final l$note = note;
    final lOther$note = other.note;
    if (l$note != lOther$note) {
      return false;
    }
    final l$items = items;
    final lOther$items = other.items;
    if (l$items != lOther$items) {
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
