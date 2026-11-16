// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';
import '../../fragments/generated/CardFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateCardDraft {
  factory VariablesMutationUpdateCardDraft({
    required String cardId,
    String? note,
    required List<InputcardItems_updates> items,
    required List<String> removedItemIds,
  }) => VariablesMutationUpdateCardDraft._({
    r'cardId': cardId,
    if (note != null) r'note': note,
    r'items': items,
    r'removedItemIds': removedItemIds,
  });

  VariablesMutationUpdateCardDraft._(this._$data);

  factory VariablesMutationUpdateCardDraft.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$cardId = data['cardId'];
    result$data['cardId'] = (l$cardId as String);
    if (data.containsKey('note')) {
      final l$note = data['note'];
      result$data['note'] = (l$note as String?);
    }
    final l$items = data['items'];
    result$data['items'] = (l$items as List<dynamic>)
        .map((e) => InputcardItems_updates.fromJson((e as Map<String, dynamic>)))
        .toList();
    final l$removedItemIds = data['removedItemIds'];
    result$data['removedItemIds'] = (l$removedItemIds as List<dynamic>)
        .map((e) => (e as String))
        .toList();
    return VariablesMutationUpdateCardDraft._(result$data);
  }

  Map<String, dynamic> _$data;

  String get cardId => (_$data['cardId'] as String);

  String? get note => (_$data['note'] as String?);

  List<InputcardItems_updates> get items => (_$data['items'] as List<InputcardItems_updates>);

  List<String> get removedItemIds => (_$data['removedItemIds'] as List<String>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$cardId = cardId;
    result$data['cardId'] = l$cardId;
    if (_$data.containsKey('note')) {
      final l$note = note;
      result$data['note'] = l$note;
    }
    final l$items = items;
    result$data['items'] = l$items.map((e) => e.toJson()).toList();
    final l$removedItemIds = removedItemIds;
    result$data['removedItemIds'] = l$removedItemIds.map((e) => e).toList();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateCardDraft || runtimeType != other.runtimeType) {
      return false;
    }
    final l$cardId = cardId;
    final lOther$cardId = other.cardId;
    if (l$cardId != lOther$cardId) {
      return false;
    }
    final l$note = note;
    final lOther$note = other.note;
    if (_$data.containsKey('note') != other._$data.containsKey('note')) {
      return false;
    }
    if (l$note != lOther$note) {
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
    final l$removedItemIds = removedItemIds;
    final lOther$removedItemIds = other.removedItemIds;
    if (l$removedItemIds.length != lOther$removedItemIds.length) {
      return false;
    }
    for (int i = 0; i < l$removedItemIds.length; i++) {
      final l$removedItemIds$entry = l$removedItemIds[i];
      final lOther$removedItemIds$entry = lOther$removedItemIds[i];
      if (l$removedItemIds$entry != lOther$removedItemIds$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$cardId = cardId;
    final l$note = note;
    final l$items = items;
    final l$removedItemIds = removedItemIds;
    return Object.hashAll([
      l$cardId,
      _$data.containsKey('note') ? l$note : const {},
      Object.hashAll(l$items.map((v) => v)),
      Object.hashAll(l$removedItemIds.map((v) => v)),
    ]);
  }
}

class MutationUpdateCardDraft {
  MutationUpdateCardDraft({
    this.updateCardItemsMany,
    this.deleteCardItems,
    this.updateCardsByPk,
    this.$__typename = 'mutation_root',
  });

  factory MutationUpdateCardDraft.fromJson(Map<String, dynamic> json) {
    final l$updateCardItemsMany = json['updateCardItemsMany'];
    final l$deleteCardItems = json['deleteCardItems'];
    final l$updateCardsByPk = json['updateCardsByPk'];
    final l$$__typename = json['__typename'];
    return MutationUpdateCardDraft(
      updateCardItemsMany: (l$updateCardItemsMany as List<dynamic>?)
          ?.map(
            (e) => e == null
                ? null
                : MutationUpdateCardDraftupdateCardItemsMany.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      deleteCardItems: l$deleteCardItems == null
          ? null
          : MutationUpdateCardDraftdeleteCardItems.fromJson(
              (l$deleteCardItems as Map<String, dynamic>),
            ),
      updateCardsByPk: l$updateCardsByPk == null
          ? null
          : FragmentCardFragment.fromJson((l$updateCardsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationUpdateCardDraftupdateCardItemsMany?>? updateCardItemsMany;

  final MutationUpdateCardDraftdeleteCardItems? deleteCardItems;

  final FragmentCardFragment? updateCardsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateCardItemsMany = updateCardItemsMany;
    _resultData['updateCardItemsMany'] = l$updateCardItemsMany?.map((e) => e?.toJson()).toList();
    final l$deleteCardItems = deleteCardItems;
    _resultData['deleteCardItems'] = l$deleteCardItems?.toJson();
    final l$updateCardsByPk = updateCardsByPk;
    _resultData['updateCardsByPk'] = l$updateCardsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateCardItemsMany = updateCardItemsMany;
    final l$deleteCardItems = deleteCardItems;
    final l$updateCardsByPk = updateCardsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateCardItemsMany == null ? null : Object.hashAll(l$updateCardItemsMany.map((v) => v)),
      l$deleteCardItems,
      l$updateCardsByPk,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateCardDraft || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateCardItemsMany = updateCardItemsMany;
    final lOther$updateCardItemsMany = other.updateCardItemsMany;
    if (l$updateCardItemsMany != null && lOther$updateCardItemsMany != null) {
      if (l$updateCardItemsMany.length != lOther$updateCardItemsMany.length) {
        return false;
      }
      for (int i = 0; i < l$updateCardItemsMany.length; i++) {
        final l$updateCardItemsMany$entry = l$updateCardItemsMany[i];
        final lOther$updateCardItemsMany$entry = lOther$updateCardItemsMany[i];
        if (l$updateCardItemsMany$entry != lOther$updateCardItemsMany$entry) {
          return false;
        }
      }
    } else if (l$updateCardItemsMany != lOther$updateCardItemsMany) {
      return false;
    }
    final l$deleteCardItems = deleteCardItems;
    final lOther$deleteCardItems = other.deleteCardItems;
    if (l$deleteCardItems != lOther$deleteCardItems) {
      return false;
    }
    final l$updateCardsByPk = updateCardsByPk;
    final lOther$updateCardsByPk = other.updateCardsByPk;
    if (l$updateCardsByPk != lOther$updateCardsByPk) {
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

const documentNodeMutationUpdateCardDraft = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateCardDraft'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cardId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'note')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'items')),
          type: ListTypeNode(
            type: NamedTypeNode(name: NameNode(value: 'cardItems_updates'), isNonNull: true),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'removedItemIds')),
          type: ListTypeNode(
            type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateCardItemsMany'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'updates'),
                value: VariableNode(name: NameNode(value: 'items')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'affected_rows'),
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
            name: NameNode(value: 'deleteCardItems'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_in'),
                            value: VariableNode(name: NameNode(value: 'removedItemIds')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'affected_rows'),
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
            name: NameNode(value: 'updateCardsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: VariableNode(name: NameNode(value: 'cardId')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'note'),
                      value: VariableNode(name: NameNode(value: 'note')),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'CardFragment'),
                  directives: [],
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
    fragmentDefinitionCardFragment,
  ],
);
MutationUpdateCardDraft _parserFnMutationUpdateCardDraft(Map<String, dynamic> data) =>
    MutationUpdateCardDraft.fromJson(data);
typedef OnMutationCompletedMutationUpdateCardDraft = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateCardDraft?,
);

class OptionsMutationUpdateCardDraft extends graphql.MutationOptions<MutationUpdateCardDraft> {
  OptionsMutationUpdateCardDraft({
    String? operationName,
    required VariablesMutationUpdateCardDraft variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateCardDraft? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateCardDraft? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateCardDraft>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateCardDraft',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationUpdateCardDraft(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateCardDraft,
         parserFn: _parserFnMutationUpdateCardDraft,
       );

  final OnMutationCompletedMutationUpdateCardDraft? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateCardDraft
    extends graphql.WatchQueryOptions<MutationUpdateCardDraft> {
  WatchOptionsMutationUpdateCardDraft({
    String? operationName,
    required VariablesMutationUpdateCardDraft variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateCardDraft? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateCardDraft',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateCardDraft,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateCardDraft,
       );
}

extension ClientExtensionMutationUpdateCardDraft on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateCardDraft>> mutateUpdateCardDraft(
    OptionsMutationUpdateCardDraft options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateCardDraft> watchMutationUpdateCardDraft(
    WatchOptionsMutationUpdateCardDraft options,
  ) => this.watchMutation(options);
}

class MutationUpdateCardDraftupdateCardItemsMany {
  MutationUpdateCardDraftupdateCardItemsMany({
    required this.affected_rows,
    this.$__typename = 'cardItems_mutation_response',
  });

  factory MutationUpdateCardDraftupdateCardItemsMany.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateCardDraftupdateCardItemsMany(
      affected_rows: (l$affected_rows as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int affected_rows;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$affected_rows = affected_rows;
    _resultData['affected_rows'] = l$affected_rows;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$affected_rows = affected_rows;
    final l$$__typename = $__typename;
    return Object.hashAll([l$affected_rows, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateCardDraftupdateCardItemsMany || runtimeType != other.runtimeType) {
      return false;
    }
    final l$affected_rows = affected_rows;
    final lOther$affected_rows = other.affected_rows;
    if (l$affected_rows != lOther$affected_rows) {
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

class MutationUpdateCardDraftdeleteCardItems {
  MutationUpdateCardDraftdeleteCardItems({
    required this.affected_rows,
    this.$__typename = 'cardItems_mutation_response',
  });

  factory MutationUpdateCardDraftdeleteCardItems.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateCardDraftdeleteCardItems(
      affected_rows: (l$affected_rows as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int affected_rows;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$affected_rows = affected_rows;
    _resultData['affected_rows'] = l$affected_rows;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$affected_rows = affected_rows;
    final l$$__typename = $__typename;
    return Object.hashAll([l$affected_rows, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateCardDraftdeleteCardItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$affected_rows = affected_rows;
    final lOther$affected_rows = other.affected_rows;
    if (l$affected_rows != lOther$affected_rows) {
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
