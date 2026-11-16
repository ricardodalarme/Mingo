// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteLogisticItem {
  factory VariablesMutationDeleteLogisticItem({required String id}) =>
      VariablesMutationDeleteLogisticItem._({r'id': id});

  VariablesMutationDeleteLogisticItem._(this._$data);

  factory VariablesMutationDeleteLogisticItem.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteLogisticItem._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationDeleteLogisticItem || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

class MutationDeleteLogisticItem {
  MutationDeleteLogisticItem({this.deleteLogisticItems, this.$__typename = 'mutation_root'});

  factory MutationDeleteLogisticItem.fromJson(Map<String, dynamic> json) {
    final l$deleteLogisticItems = json['deleteLogisticItems'];
    final l$$__typename = json['__typename'];
    return MutationDeleteLogisticItem(
      deleteLogisticItems: l$deleteLogisticItems == null
          ? null
          : MutationDeleteLogisticItemdeleteLogisticItems.fromJson(
              (l$deleteLogisticItems as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteLogisticItemdeleteLogisticItems? deleteLogisticItems;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteLogisticItems = deleteLogisticItems;
    _resultData['deleteLogisticItems'] = l$deleteLogisticItems?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteLogisticItems = deleteLogisticItems;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteLogisticItems, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteLogisticItem || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteLogisticItems = deleteLogisticItems;
    final lOther$deleteLogisticItems = other.deleteLogisticItems;
    if (l$deleteLogisticItems != lOther$deleteLogisticItems) {
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

const documentNodeMutationDeleteLogisticItem = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteLogisticItem'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'deleteLogisticItems'),
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
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'id')),
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
MutationDeleteLogisticItem _parserFnMutationDeleteLogisticItem(Map<String, dynamic> data) =>
    MutationDeleteLogisticItem.fromJson(data);
typedef OnMutationCompletedMutationDeleteLogisticItem = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteLogisticItem?,
);

class OptionsMutationDeleteLogisticItem
    extends graphql.MutationOptions<MutationDeleteLogisticItem> {
  OptionsMutationDeleteLogisticItem({
    String? operationName,
    required VariablesMutationDeleteLogisticItem variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteLogisticItem? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteLogisticItem? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteLogisticItem>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteLogisticItem',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationDeleteLogisticItem(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteLogisticItem,
         parserFn: _parserFnMutationDeleteLogisticItem,
       );

  final OnMutationCompletedMutationDeleteLogisticItem? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteLogisticItem
    extends graphql.WatchQueryOptions<MutationDeleteLogisticItem> {
  WatchOptionsMutationDeleteLogisticItem({
    String? operationName,
    required VariablesMutationDeleteLogisticItem variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteLogisticItem? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteLogisticItem',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteLogisticItem,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteLogisticItem,
       );
}

extension ClientExtensionMutationDeleteLogisticItem on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteLogisticItem>> mutateDeleteLogisticItem(
    OptionsMutationDeleteLogisticItem options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteLogisticItem> watchMutationDeleteLogisticItem(
    WatchOptionsMutationDeleteLogisticItem options,
  ) => this.watchMutation(options);
}

class MutationDeleteLogisticItemdeleteLogisticItems {
  MutationDeleteLogisticItemdeleteLogisticItems({
    required this.affected_rows,
    this.$__typename = 'logisticItems_mutation_response',
  });

  factory MutationDeleteLogisticItemdeleteLogisticItems.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationDeleteLogisticItemdeleteLogisticItems(
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
    if (other is! MutationDeleteLogisticItemdeleteLogisticItems ||
        runtimeType != other.runtimeType) {
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
