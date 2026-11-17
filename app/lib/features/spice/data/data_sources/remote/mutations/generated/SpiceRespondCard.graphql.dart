// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSpiceRespondCard {
  factory VariablesMutationSpiceRespondCard({required String playId, required bool accept}) =>
      VariablesMutationSpiceRespondCard._({r'playId': playId, r'accept': accept});

  VariablesMutationSpiceRespondCard._(this._$data);

  factory VariablesMutationSpiceRespondCard.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$playId = data['playId'];
    result$data['playId'] = (l$playId as String);
    final l$accept = data['accept'];
    result$data['accept'] = (l$accept as bool);
    return VariablesMutationSpiceRespondCard._(result$data);
  }

  Map<String, dynamic> _$data;

  String get playId => (_$data['playId'] as String);

  bool get accept => (_$data['accept'] as bool);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$playId = playId;
    result$data['playId'] = l$playId;
    final l$accept = accept;
    result$data['accept'] = l$accept;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSpiceRespondCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$playId = playId;
    final lOther$playId = other.playId;
    if (l$playId != lOther$playId) {
      return false;
    }
    final l$accept = accept;
    final lOther$accept = other.accept;
    if (l$accept != lOther$accept) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$playId = playId;
    final l$accept = accept;
    return Object.hashAll([l$playId, l$accept]);
  }
}

class MutationSpiceRespondCard {
  MutationSpiceRespondCard({required this.spiceRespondCard, this.$__typename = 'mutation_root'});

  factory MutationSpiceRespondCard.fromJson(Map<String, dynamic> json) {
    final l$spiceRespondCard = json['spiceRespondCard'];
    final l$$__typename = json['__typename'];
    return MutationSpiceRespondCard(
      spiceRespondCard: (l$spiceRespondCard as List<dynamic>)
          .map(
            (e) => MutationSpiceRespondCardspiceRespondCard.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationSpiceRespondCardspiceRespondCard> spiceRespondCard;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceRespondCard = spiceRespondCard;
    _resultData['spiceRespondCard'] = l$spiceRespondCard.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceRespondCard = spiceRespondCard;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$spiceRespondCard.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSpiceRespondCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceRespondCard = spiceRespondCard;
    final lOther$spiceRespondCard = other.spiceRespondCard;
    if (l$spiceRespondCard.length != lOther$spiceRespondCard.length) {
      return false;
    }
    for (int i = 0; i < l$spiceRespondCard.length; i++) {
      final l$spiceRespondCard$entry = l$spiceRespondCard[i];
      final lOther$spiceRespondCard$entry = lOther$spiceRespondCard[i];
      if (l$spiceRespondCard$entry != lOther$spiceRespondCard$entry) {
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

const documentNodeMutationSpiceRespondCard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SpiceRespondCard'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'playId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'accept')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceRespondCard'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'playId'),
                      value: VariableNode(name: NameNode(value: 'playId')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'accept'),
                      value: VariableNode(name: NameNode(value: 'accept')),
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
MutationSpiceRespondCard _parserFnMutationSpiceRespondCard(Map<String, dynamic> data) =>
    MutationSpiceRespondCard.fromJson(data);
typedef OnMutationCompletedMutationSpiceRespondCard = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSpiceRespondCard?,
);

class OptionsMutationSpiceRespondCard extends graphql.MutationOptions<MutationSpiceRespondCard> {
  OptionsMutationSpiceRespondCard({
    String? operationName,
    required VariablesMutationSpiceRespondCard variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceRespondCard? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSpiceRespondCard? onCompleted,
    graphql.OnMutationUpdate<MutationSpiceRespondCard>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SpiceRespondCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSpiceRespondCard(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSpiceRespondCard,
         parserFn: _parserFnMutationSpiceRespondCard,
       );

  final OnMutationCompletedMutationSpiceRespondCard? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSpiceRespondCard
    extends graphql.WatchQueryOptions<MutationSpiceRespondCard> {
  WatchOptionsMutationSpiceRespondCard({
    String? operationName,
    required VariablesMutationSpiceRespondCard variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceRespondCard? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SpiceRespondCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSpiceRespondCard,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSpiceRespondCard,
       );
}

extension ClientExtensionMutationSpiceRespondCard on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSpiceRespondCard>> mutateSpiceRespondCard(
    OptionsMutationSpiceRespondCard options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSpiceRespondCard> watchMutationSpiceRespondCard(
    WatchOptionsMutationSpiceRespondCard options,
  ) => this.watchMutation(options);
}

class MutationSpiceRespondCardspiceRespondCard {
  MutationSpiceRespondCardspiceRespondCard({required this.id, this.$__typename = 'spiceCardPlays'});

  factory MutationSpiceRespondCardspiceRespondCard.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationSpiceRespondCardspiceRespondCard(
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
    if (other is! MutationSpiceRespondCardspiceRespondCard || runtimeType != other.runtimeType) {
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
