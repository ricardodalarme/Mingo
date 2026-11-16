// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class MutationUnpair {
  MutationUnpair({required this.unpair, this.$__typename = 'mutation_root'});

  factory MutationUnpair.fromJson(Map<String, dynamic> json) {
    final l$unpair = json['unpair'];
    final l$$__typename = json['__typename'];
    return MutationUnpair(
      unpair: (l$unpair as List<dynamic>)
          .map((e) => MutationUnpairunpair.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationUnpairunpair> unpair;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$unpair = unpair;
    _resultData['unpair'] = l$unpair.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$unpair = unpair;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$unpair.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUnpair || runtimeType != other.runtimeType) {
      return false;
    }
    final l$unpair = unpair;
    final lOther$unpair = other.unpair;
    if (l$unpair.length != lOther$unpair.length) {
      return false;
    }
    for (int i = 0; i < l$unpair.length; i++) {
      final l$unpair$entry = l$unpair[i];
      final lOther$unpair$entry = lOther$unpair[i];
      if (l$unpair$entry != lOther$unpair$entry) {
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

const documentNodeMutationUnpair = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'Unpair'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'unpair'),
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
MutationUnpair _parserFnMutationUnpair(Map<String, dynamic> data) => MutationUnpair.fromJson(data);
typedef OnMutationCompletedMutationUnpair = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUnpair?,
);

class OptionsMutationUnpair extends graphql.MutationOptions<MutationUnpair> {
  OptionsMutationUnpair({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUnpair? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUnpair? onCompleted,
    graphql.OnMutationUpdate<MutationUnpair>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName ?? 'Unpair',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFnMutationUnpair(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationUnpair,
         parserFn: _parserFnMutationUnpair,
       );

  final OnMutationCompletedMutationUnpair? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUnpair extends graphql.WatchQueryOptions<MutationUnpair> {
  WatchOptionsMutationUnpair({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUnpair? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'Unpair',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUnpair,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUnpair,
       );
}

extension ClientExtensionMutationUnpair on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUnpair>> mutateUnpair([
    OptionsMutationUnpair? options,
  ]) async => await this.mutate(options ?? OptionsMutationUnpair());

  graphql.ObservableQuery<MutationUnpair> watchMutationUnpair([
    WatchOptionsMutationUnpair? options,
  ]) => this.watchMutation(options ?? WatchOptionsMutationUnpair());
}

class MutationUnpairunpair {
  MutationUnpairunpair({required this.id, this.$__typename = 'profiles'});

  factory MutationUnpairunpair.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationUnpairunpair(id: (l$id as String), $__typename: (l$$__typename as String));
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
    if (other is! MutationUnpairunpair || runtimeType != other.runtimeType) {
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
