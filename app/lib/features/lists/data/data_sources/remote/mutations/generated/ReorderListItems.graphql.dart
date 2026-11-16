// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';
import '../../fragments/generated/ListItemFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationReorderListItems {
  factory VariablesMutationReorderListItems({required List<InputlistItems_updates> updates}) =>
      VariablesMutationReorderListItems._({r'updates': updates});

  VariablesMutationReorderListItems._(this._$data);

  factory VariablesMutationReorderListItems.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$updates = data['updates'];
    result$data['updates'] = (l$updates as List<dynamic>)
        .map((e) => InputlistItems_updates.fromJson((e as Map<String, dynamic>)))
        .toList();
    return VariablesMutationReorderListItems._(result$data);
  }

  Map<String, dynamic> _$data;

  List<InputlistItems_updates> get updates => (_$data['updates'] as List<InputlistItems_updates>);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$updates = updates;
    result$data['updates'] = l$updates.map((e) => e.toJson()).toList();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationReorderListItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updates = updates;
    final lOther$updates = other.updates;
    if (l$updates.length != lOther$updates.length) {
      return false;
    }
    for (int i = 0; i < l$updates.length; i++) {
      final l$updates$entry = l$updates[i];
      final lOther$updates$entry = lOther$updates[i];
      if (l$updates$entry != lOther$updates$entry) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final l$updates = updates;
    return Object.hashAll([Object.hashAll(l$updates.map((v) => v))]);
  }
}

class MutationReorderListItems {
  MutationReorderListItems({this.updateListItemsMany, this.$__typename = 'mutation_root'});

  factory MutationReorderListItems.fromJson(Map<String, dynamic> json) {
    final l$updateListItemsMany = json['updateListItemsMany'];
    final l$$__typename = json['__typename'];
    return MutationReorderListItems(
      updateListItemsMany: (l$updateListItemsMany as List<dynamic>?)
          ?.map(
            (e) => e == null
                ? null
                : MutationReorderListItemsupdateListItemsMany.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationReorderListItemsupdateListItemsMany?>? updateListItemsMany;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateListItemsMany = updateListItemsMany;
    _resultData['updateListItemsMany'] = l$updateListItemsMany?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateListItemsMany = updateListItemsMany;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$updateListItemsMany == null ? null : Object.hashAll(l$updateListItemsMany.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationReorderListItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateListItemsMany = updateListItemsMany;
    final lOther$updateListItemsMany = other.updateListItemsMany;
    if (l$updateListItemsMany != null && lOther$updateListItemsMany != null) {
      if (l$updateListItemsMany.length != lOther$updateListItemsMany.length) {
        return false;
      }
      for (int i = 0; i < l$updateListItemsMany.length; i++) {
        final l$updateListItemsMany$entry = l$updateListItemsMany[i];
        final lOther$updateListItemsMany$entry = lOther$updateListItemsMany[i];
        if (l$updateListItemsMany$entry != lOther$updateListItemsMany$entry) {
          return false;
        }
      }
    } else if (l$updateListItemsMany != lOther$updateListItemsMany) {
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

const documentNodeMutationReorderListItems = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ReorderListItems'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'updates')),
          type: ListTypeNode(
            type: NamedTypeNode(name: NameNode(value: 'listItems_updates'), isNonNull: true),
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
            name: NameNode(value: 'updateListItemsMany'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'updates'),
                value: VariableNode(name: NameNode(value: 'updates')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'returning'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                        name: NameNode(value: 'ListItemFragment'),
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
    fragmentDefinitionListItemFragment,
  ],
);
MutationReorderListItems _parserFnMutationReorderListItems(Map<String, dynamic> data) =>
    MutationReorderListItems.fromJson(data);
typedef OnMutationCompletedMutationReorderListItems = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationReorderListItems?,
);

class OptionsMutationReorderListItems extends graphql.MutationOptions<MutationReorderListItems> {
  OptionsMutationReorderListItems({
    String? operationName,
    required VariablesMutationReorderListItems variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationReorderListItems? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationReorderListItems? onCompleted,
    graphql.OnMutationUpdate<MutationReorderListItems>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ReorderListItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationReorderListItems(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationReorderListItems,
         parserFn: _parserFnMutationReorderListItems,
       );

  final OnMutationCompletedMutationReorderListItems? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationReorderListItems
    extends graphql.WatchQueryOptions<MutationReorderListItems> {
  WatchOptionsMutationReorderListItems({
    String? operationName,
    required VariablesMutationReorderListItems variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationReorderListItems? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ReorderListItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationReorderListItems,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationReorderListItems,
       );
}

extension ClientExtensionMutationReorderListItems on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationReorderListItems>> mutateReorderListItems(
    OptionsMutationReorderListItems options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationReorderListItems> watchMutationReorderListItems(
    WatchOptionsMutationReorderListItems options,
  ) => this.watchMutation(options);
}

class MutationReorderListItemsupdateListItemsMany {
  MutationReorderListItemsupdateListItemsMany({
    required this.returning,
    this.$__typename = 'listItems_mutation_response',
  });

  factory MutationReorderListItemsupdateListItemsMany.fromJson(Map<String, dynamic> json) {
    final l$returning = json['returning'];
    final l$$__typename = json['__typename'];
    return MutationReorderListItemsupdateListItemsMany(
      returning: (l$returning as List<dynamic>)
          .map((e) => FragmentListItemFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<FragmentListItemFragment> returning;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$returning = returning;
    _resultData['returning'] = l$returning.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$returning = returning;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$returning.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationReorderListItemsupdateListItemsMany || runtimeType != other.runtimeType) {
      return false;
    }
    final l$returning = returning;
    final lOther$returning = other.returning;
    if (l$returning.length != lOther$returning.length) {
      return false;
    }
    for (int i = 0; i < l$returning.length; i++) {
      final l$returning$entry = l$returning[i];
      final lOther$returning$entry = lOther$returning[i];
      if (l$returning$entry != lOther$returning$entry) {
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
