// dart format width=100
import '../../fragments/generated/ListFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationRenameList {
  factory VariablesMutationRenameList({required String id, required String title}) =>
      VariablesMutationRenameList._({r'id': id, r'title': title});

  VariablesMutationRenameList._(this._$data);

  factory VariablesMutationRenameList.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    return VariablesMutationRenameList._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String get title => (_$data['title'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$title = title;
    result$data['title'] = l$title;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationRenameList || runtimeType != other.runtimeType) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    return Object.hashAll([l$id, l$title]);
  }
}

class MutationRenameList {
  MutationRenameList({this.updateListsByPk, this.$__typename = 'mutation_root'});

  factory MutationRenameList.fromJson(Map<String, dynamic> json) {
    final l$updateListsByPk = json['updateListsByPk'];
    final l$$__typename = json['__typename'];
    return MutationRenameList(
      updateListsByPk: l$updateListsByPk == null
          ? null
          : FragmentListFragment.fromJson((l$updateListsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentListFragment? updateListsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateListsByPk = updateListsByPk;
    _resultData['updateListsByPk'] = l$updateListsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateListsByPk = updateListsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateListsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationRenameList || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateListsByPk = updateListsByPk;
    final lOther$updateListsByPk = other.updateListsByPk;
    if (l$updateListsByPk != lOther$updateListsByPk) {
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

const documentNodeMutationRenameList = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RenameList'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'title')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateListsByPk'),
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
                      name: NameNode(value: 'title'),
                      value: VariableNode(name: NameNode(value: 'title')),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'ListFragment'),
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
    fragmentDefinitionListFragment,
  ],
);
MutationRenameList _parserFnMutationRenameList(Map<String, dynamic> data) =>
    MutationRenameList.fromJson(data);
typedef OnMutationCompletedMutationRenameList = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationRenameList?,
);

class OptionsMutationRenameList extends graphql.MutationOptions<MutationRenameList> {
  OptionsMutationRenameList({
    String? operationName,
    required VariablesMutationRenameList variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRenameList? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationRenameList? onCompleted,
    graphql.OnMutationUpdate<MutationRenameList>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'RenameList',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFnMutationRenameList(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationRenameList,
         parserFn: _parserFnMutationRenameList,
       );

  final OnMutationCompletedMutationRenameList? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationRenameList extends graphql.WatchQueryOptions<MutationRenameList> {
  WatchOptionsMutationRenameList({
    String? operationName,
    required VariablesMutationRenameList variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRenameList? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'RenameList',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationRenameList,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationRenameList,
       );
}

extension ClientExtensionMutationRenameList on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationRenameList>> mutateRenameList(
    OptionsMutationRenameList options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationRenameList> watchMutationRenameList(
    WatchOptionsMutationRenameList options,
  ) => this.watchMutation(options);
}
