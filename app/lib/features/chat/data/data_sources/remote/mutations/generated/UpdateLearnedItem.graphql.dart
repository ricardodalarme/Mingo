// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateLearnedItem {
  factory VariablesMutationUpdateLearnedItem({required String id, required String text}) =>
      VariablesMutationUpdateLearnedItem._({r'id': id, r'text': text});

  VariablesMutationUpdateLearnedItem._(this._$data);

  factory VariablesMutationUpdateLearnedItem.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$text = data['text'];
    result$data['text'] = (l$text as String);
    return VariablesMutationUpdateLearnedItem._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String get text => (_$data['text'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$text = text;
    result$data['text'] = l$text;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateLearnedItem || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$text = text;
    final lOther$text = other.text;
    if (l$text != lOther$text) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$text = text;
    return Object.hashAll([l$id, l$text]);
  }
}

class MutationUpdateLearnedItem {
  MutationUpdateLearnedItem({this.updateLearnedItemsByPk, this.$__typename = 'mutation_root'});

  factory MutationUpdateLearnedItem.fromJson(Map<String, dynamic> json) {
    final l$updateLearnedItemsByPk = json['updateLearnedItemsByPk'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLearnedItem(
      updateLearnedItemsByPk: l$updateLearnedItemsByPk == null
          ? null
          : MutationUpdateLearnedItemupdateLearnedItemsByPk.fromJson(
              (l$updateLearnedItemsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateLearnedItemupdateLearnedItemsByPk? updateLearnedItemsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateLearnedItemsByPk = updateLearnedItemsByPk;
    _resultData['updateLearnedItemsByPk'] = l$updateLearnedItemsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateLearnedItemsByPk = updateLearnedItemsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateLearnedItemsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateLearnedItem || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateLearnedItemsByPk = updateLearnedItemsByPk;
    final lOther$updateLearnedItemsByPk = other.updateLearnedItemsByPk;
    if (l$updateLearnedItemsByPk != lOther$updateLearnedItemsByPk) {
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

const documentNodeMutationUpdateLearnedItem = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateLearnedItem'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'text')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateLearnedItemsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: VariableNode(name: NameNode(value: 'id')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'text'),
                      value: VariableNode(name: NameNode(value: 'text')),
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
MutationUpdateLearnedItem _parserFnMutationUpdateLearnedItem(Map<String, dynamic> data) =>
    MutationUpdateLearnedItem.fromJson(data);
typedef OnMutationCompletedMutationUpdateLearnedItem = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateLearnedItem?,
);

class OptionsMutationUpdateLearnedItem extends graphql.MutationOptions<MutationUpdateLearnedItem> {
  OptionsMutationUpdateLearnedItem({
    String? operationName,
    required VariablesMutationUpdateLearnedItem variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLearnedItem? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateLearnedItem? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateLearnedItem>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLearnedItem',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateLearnedItem(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateLearnedItem,
         parserFn: _parserFnMutationUpdateLearnedItem,
       );

  final OnMutationCompletedMutationUpdateLearnedItem? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateLearnedItem
    extends graphql.WatchQueryOptions<MutationUpdateLearnedItem> {
  WatchOptionsMutationUpdateLearnedItem({
    String? operationName,
    required VariablesMutationUpdateLearnedItem variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLearnedItem? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLearnedItem',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateLearnedItem,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateLearnedItem,
       );
}

extension ClientExtensionMutationUpdateLearnedItem on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateLearnedItem>> mutateUpdateLearnedItem(
    OptionsMutationUpdateLearnedItem options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateLearnedItem> watchMutationUpdateLearnedItem(
    WatchOptionsMutationUpdateLearnedItem options,
  ) => this.watchMutation(options);
}

class MutationUpdateLearnedItemupdateLearnedItemsByPk {
  MutationUpdateLearnedItemupdateLearnedItemsByPk({
    required this.id,
    this.$__typename = 'learnedItems',
  });

  factory MutationUpdateLearnedItemupdateLearnedItemsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLearnedItemupdateLearnedItemsByPk(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
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
    if (other is! MutationUpdateLearnedItemupdateLearnedItemsByPk ||
        runtimeType != other.runtimeType) {
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
