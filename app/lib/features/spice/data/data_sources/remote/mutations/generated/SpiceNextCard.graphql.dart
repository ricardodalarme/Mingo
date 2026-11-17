// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class MutationSpiceNextCard {
  MutationSpiceNextCard({required this.spiceNextCard, this.$__typename = 'mutation_root'});

  factory MutationSpiceNextCard.fromJson(Map<String, dynamic> json) {
    final l$spiceNextCard = json['spiceNextCard'];
    final l$$__typename = json['__typename'];
    return MutationSpiceNextCard(
      spiceNextCard: (l$spiceNextCard as List<dynamic>)
          .map((e) => MutationSpiceNextCardspiceNextCard.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationSpiceNextCardspiceNextCard> spiceNextCard;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceNextCard = spiceNextCard;
    _resultData['spiceNextCard'] = l$spiceNextCard.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceNextCard = spiceNextCard;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$spiceNextCard.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSpiceNextCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceNextCard = spiceNextCard;
    final lOther$spiceNextCard = other.spiceNextCard;
    if (l$spiceNextCard.length != lOther$spiceNextCard.length) {
      return false;
    }
    for (int i = 0; i < l$spiceNextCard.length; i++) {
      final l$spiceNextCard$entry = l$spiceNextCard[i];
      final lOther$spiceNextCard$entry = lOther$spiceNextCard[i];
      if (l$spiceNextCard$entry != lOther$spiceNextCard$entry) {
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

const documentNodeMutationSpiceNextCard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SpiceNextCard'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceNextCard'),
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
                  name: NameNode(value: 'contentSlug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'proposedBy'),
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
MutationSpiceNextCard _parserFnMutationSpiceNextCard(Map<String, dynamic> data) =>
    MutationSpiceNextCard.fromJson(data);
typedef OnMutationCompletedMutationSpiceNextCard = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSpiceNextCard?,
);

class OptionsMutationSpiceNextCard extends graphql.MutationOptions<MutationSpiceNextCard> {
  OptionsMutationSpiceNextCard({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceNextCard? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSpiceNextCard? onCompleted,
    graphql.OnMutationUpdate<MutationSpiceNextCard>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName ?? 'SpiceNextCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSpiceNextCard(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSpiceNextCard,
         parserFn: _parserFnMutationSpiceNextCard,
       );

  final OnMutationCompletedMutationSpiceNextCard? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSpiceNextCard extends graphql.WatchQueryOptions<MutationSpiceNextCard> {
  WatchOptionsMutationSpiceNextCard({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceNextCard? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'SpiceNextCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSpiceNextCard,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSpiceNextCard,
       );
}

extension ClientExtensionMutationSpiceNextCard on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSpiceNextCard>> mutateSpiceNextCard([
    OptionsMutationSpiceNextCard? options,
  ]) async => await this.mutate(options ?? OptionsMutationSpiceNextCard());

  graphql.ObservableQuery<MutationSpiceNextCard> watchMutationSpiceNextCard([
    WatchOptionsMutationSpiceNextCard? options,
  ]) => this.watchMutation(options ?? WatchOptionsMutationSpiceNextCard());
}

class MutationSpiceNextCardspiceNextCard {
  MutationSpiceNextCardspiceNextCard({
    required this.id,
    required this.contentSlug,
    required this.proposedBy,
    this.$__typename = 'spiceCardPlays',
  });

  factory MutationSpiceNextCardspiceNextCard.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$contentSlug = json['contentSlug'];
    final l$proposedBy = json['proposedBy'];
    final l$$__typename = json['__typename'];
    return MutationSpiceNextCardspiceNextCard(
      id: (l$id as String),
      contentSlug: (l$contentSlug as String),
      proposedBy: (l$proposedBy as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String contentSlug;

  final String proposedBy;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$contentSlug = contentSlug;
    _resultData['contentSlug'] = l$contentSlug;
    final l$proposedBy = proposedBy;
    _resultData['proposedBy'] = l$proposedBy;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$contentSlug = contentSlug;
    final l$proposedBy = proposedBy;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$contentSlug, l$proposedBy, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSpiceNextCardspiceNextCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$contentSlug = contentSlug;
    final lOther$contentSlug = other.contentSlug;
    if (l$contentSlug != lOther$contentSlug) {
      return false;
    }
    final l$proposedBy = proposedBy;
    final lOther$proposedBy = other.proposedBy;
    if (l$proposedBy != lOther$proposedBy) {
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
