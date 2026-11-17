// dart format width=100
import '../../fragments/generated/SpiceChallengeFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class MutationSpiceChallenge {
  MutationSpiceChallenge({required this.spiceChallenge, this.$__typename = 'mutation_root'});

  factory MutationSpiceChallenge.fromJson(Map<String, dynamic> json) {
    final l$spiceChallenge = json['spiceChallenge'];
    final l$$__typename = json['__typename'];
    return MutationSpiceChallenge(
      spiceChallenge: (l$spiceChallenge as List<dynamic>)
          .map((e) => FragmentSpiceChallengeFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<FragmentSpiceChallengeFragment> spiceChallenge;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceChallenge = spiceChallenge;
    _resultData['spiceChallenge'] = l$spiceChallenge.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceChallenge = spiceChallenge;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$spiceChallenge.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSpiceChallenge || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceChallenge = spiceChallenge;
    final lOther$spiceChallenge = other.spiceChallenge;
    if (l$spiceChallenge.length != lOther$spiceChallenge.length) {
      return false;
    }
    for (int i = 0; i < l$spiceChallenge.length; i++) {
      final l$spiceChallenge$entry = l$spiceChallenge[i];
      final lOther$spiceChallenge$entry = lOther$spiceChallenge[i];
      if (l$spiceChallenge$entry != lOther$spiceChallenge$entry) {
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

const documentNodeMutationSpiceChallenge = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SpiceChallenge'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceChallenge'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'SpiceChallengeFragment'),
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
    fragmentDefinitionSpiceChallengeFragment,
  ],
);
MutationSpiceChallenge _parserFnMutationSpiceChallenge(Map<String, dynamic> data) =>
    MutationSpiceChallenge.fromJson(data);
typedef OnMutationCompletedMutationSpiceChallenge = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSpiceChallenge?,
);

class OptionsMutationSpiceChallenge extends graphql.MutationOptions<MutationSpiceChallenge> {
  OptionsMutationSpiceChallenge({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceChallenge? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSpiceChallenge? onCompleted,
    graphql.OnMutationUpdate<MutationSpiceChallenge>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName ?? 'SpiceChallenge',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSpiceChallenge(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSpiceChallenge,
         parserFn: _parserFnMutationSpiceChallenge,
       );

  final OnMutationCompletedMutationSpiceChallenge? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSpiceChallenge extends graphql.WatchQueryOptions<MutationSpiceChallenge> {
  WatchOptionsMutationSpiceChallenge({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceChallenge? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'SpiceChallenge',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSpiceChallenge,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSpiceChallenge,
       );
}

extension ClientExtensionMutationSpiceChallenge on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSpiceChallenge>> mutateSpiceChallenge([
    OptionsMutationSpiceChallenge? options,
  ]) async => await this.mutate(options ?? OptionsMutationSpiceChallenge());

  graphql.ObservableQuery<MutationSpiceChallenge> watchMutationSpiceChallenge([
    WatchOptionsMutationSpiceChallenge? options,
  ]) => this.watchMutation(options ?? WatchOptionsMutationSpiceChallenge());
}
