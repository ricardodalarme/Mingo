// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class MutationRequestAccountDeletion {
  MutationRequestAccountDeletion({
    this.insertDeletionRequestsOne,
    this.$__typename = 'mutation_root',
  });

  factory MutationRequestAccountDeletion.fromJson(Map<String, dynamic> json) {
    final l$insertDeletionRequestsOne = json['insertDeletionRequestsOne'];
    final l$$__typename = json['__typename'];
    return MutationRequestAccountDeletion(
      insertDeletionRequestsOne: l$insertDeletionRequestsOne == null
          ? null
          : MutationRequestAccountDeletioninsertDeletionRequestsOne.fromJson(
              (l$insertDeletionRequestsOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationRequestAccountDeletioninsertDeletionRequestsOne? insertDeletionRequestsOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertDeletionRequestsOne = insertDeletionRequestsOne;
    _resultData['insertDeletionRequestsOne'] = l$insertDeletionRequestsOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertDeletionRequestsOne = insertDeletionRequestsOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertDeletionRequestsOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationRequestAccountDeletion || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertDeletionRequestsOne = insertDeletionRequestsOne;
    final lOther$insertDeletionRequestsOne = other.insertDeletionRequestsOne;
    if (l$insertDeletionRequestsOne != lOther$insertDeletionRequestsOne) {
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

const documentNodeMutationRequestAccountDeletion = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RequestAccountDeletion'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertDeletionRequestsOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: ObjectValueNode(fields: []),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'requestedAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'purgeAfter'),
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
MutationRequestAccountDeletion _parserFnMutationRequestAccountDeletion(Map<String, dynamic> data) =>
    MutationRequestAccountDeletion.fromJson(data);
typedef OnMutationCompletedMutationRequestAccountDeletion = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationRequestAccountDeletion?,
);

class OptionsMutationRequestAccountDeletion
    extends graphql.MutationOptions<MutationRequestAccountDeletion> {
  OptionsMutationRequestAccountDeletion({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRequestAccountDeletion? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationRequestAccountDeletion? onCompleted,
    graphql.OnMutationUpdate<MutationRequestAccountDeletion>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName ?? 'RequestAccountDeletion',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationRequestAccountDeletion(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationRequestAccountDeletion,
         parserFn: _parserFnMutationRequestAccountDeletion,
       );

  final OnMutationCompletedMutationRequestAccountDeletion? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationRequestAccountDeletion
    extends graphql.WatchQueryOptions<MutationRequestAccountDeletion> {
  WatchOptionsMutationRequestAccountDeletion({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRequestAccountDeletion? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'RequestAccountDeletion',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationRequestAccountDeletion,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationRequestAccountDeletion,
       );
}

extension ClientExtensionMutationRequestAccountDeletion on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationRequestAccountDeletion>> mutateRequestAccountDeletion([
    OptionsMutationRequestAccountDeletion? options,
  ]) async => await this.mutate(options ?? OptionsMutationRequestAccountDeletion());

  graphql.ObservableQuery<MutationRequestAccountDeletion> watchMutationRequestAccountDeletion([
    WatchOptionsMutationRequestAccountDeletion? options,
  ]) => this.watchMutation(options ?? WatchOptionsMutationRequestAccountDeletion());
}

class MutationRequestAccountDeletioninsertDeletionRequestsOne {
  MutationRequestAccountDeletioninsertDeletionRequestsOne({
    required this.requestedAt,
    required this.purgeAfter,
    this.$__typename = 'deletionRequests',
  });

  factory MutationRequestAccountDeletioninsertDeletionRequestsOne.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$requestedAt = json['requestedAt'];
    final l$purgeAfter = json['purgeAfter'];
    final l$$__typename = json['__typename'];
    return MutationRequestAccountDeletioninsertDeletionRequestsOne(
      requestedAt: DateTime.parse((l$requestedAt as String)),
      purgeAfter: DateTime.parse((l$purgeAfter as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime requestedAt;

  final DateTime purgeAfter;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$requestedAt = requestedAt;
    _resultData['requestedAt'] = ((v) => v.toUtc().toIso8601String())(l$requestedAt);
    final l$purgeAfter = purgeAfter;
    _resultData['purgeAfter'] = ((v) => v.toUtc().toIso8601String())(l$purgeAfter);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$requestedAt = requestedAt;
    final l$purgeAfter = purgeAfter;
    final l$$__typename = $__typename;
    return Object.hashAll([l$requestedAt, l$purgeAfter, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationRequestAccountDeletioninsertDeletionRequestsOne ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$requestedAt = requestedAt;
    final lOther$requestedAt = other.requestedAt;
    if (l$requestedAt != lOther$requestedAt) {
      return false;
    }
    final l$purgeAfter = purgeAfter;
    final lOther$purgeAfter = other.purgeAfter;
    if (l$purgeAfter != lOther$purgeAfter) {
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
