// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class MutationSpiceOff {
  MutationSpiceOff({required this.spiceOff, this.$__typename = 'mutation_root'});

  factory MutationSpiceOff.fromJson(Map<String, dynamic> json) {
    final l$spiceOff = json['spiceOff'];
    final l$$__typename = json['__typename'];
    return MutationSpiceOff(
      spiceOff: (l$spiceOff as List<dynamic>)
          .map((e) => MutationSpiceOffspiceOff.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationSpiceOffspiceOff> spiceOff;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceOff = spiceOff;
    _resultData['spiceOff'] = l$spiceOff.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceOff = spiceOff;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$spiceOff.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSpiceOff || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceOff = spiceOff;
    final lOther$spiceOff = other.spiceOff;
    if (l$spiceOff.length != lOther$spiceOff.length) {
      return false;
    }
    for (int i = 0; i < l$spiceOff.length; i++) {
      final l$spiceOff$entry = l$spiceOff[i];
      final lOther$spiceOff$entry = lOther$spiceOff[i];
      if (l$spiceOff$entry != lOther$spiceOff$entry) {
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

const documentNodeMutationSpiceOff = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SpiceOff'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceOff'),
            alias: null,
            arguments: [],
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
MutationSpiceOff _parserFnMutationSpiceOff(Map<String, dynamic> data) =>
    MutationSpiceOff.fromJson(data);
typedef OnMutationCompletedMutationSpiceOff = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSpiceOff?,
);

class OptionsMutationSpiceOff extends graphql.MutationOptions<MutationSpiceOff> {
  OptionsMutationSpiceOff({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceOff? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSpiceOff? onCompleted,
    graphql.OnMutationUpdate<MutationSpiceOff>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName ?? 'SpiceOff',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFnMutationSpiceOff(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSpiceOff,
         parserFn: _parserFnMutationSpiceOff,
       );

  final OnMutationCompletedMutationSpiceOff? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSpiceOff extends graphql.WatchQueryOptions<MutationSpiceOff> {
  WatchOptionsMutationSpiceOff({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceOff? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'SpiceOff',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSpiceOff,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSpiceOff,
       );
}

extension ClientExtensionMutationSpiceOff on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSpiceOff>> mutateSpiceOff([
    OptionsMutationSpiceOff? options,
  ]) async => await this.mutate(options ?? OptionsMutationSpiceOff());

  graphql.ObservableQuery<MutationSpiceOff> watchMutationSpiceOff([
    WatchOptionsMutationSpiceOff? options,
  ]) => this.watchMutation(options ?? WatchOptionsMutationSpiceOff());
}

class MutationSpiceOffspiceOff {
  MutationSpiceOffspiceOff({required this.userId, this.$__typename = 'userSettings'});

  factory MutationSpiceOffspiceOff.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$$__typename = json['__typename'];
    return MutationSpiceOffspiceOff(
      userId: (l$userId as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSpiceOffspiceOff || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
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
