// dart format width=100
import '../../fragments/generated/CardFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationReopenCard {
  factory VariablesMutationReopenCard({required String cardId}) =>
      VariablesMutationReopenCard._({r'cardId': cardId});

  VariablesMutationReopenCard._(this._$data);

  factory VariablesMutationReopenCard.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$cardId = data['cardId'];
    result$data['cardId'] = (l$cardId as String);
    return VariablesMutationReopenCard._(result$data);
  }

  Map<String, dynamic> _$data;

  String get cardId => (_$data['cardId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$cardId = cardId;
    result$data['cardId'] = l$cardId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationReopenCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$cardId = cardId;
    final lOther$cardId = other.cardId;
    if (l$cardId != lOther$cardId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$cardId = cardId;
    return Object.hashAll([l$cardId]);
  }
}

class MutationReopenCard {
  MutationReopenCard({this.updateCardsByPk, this.$__typename = 'mutation_root'});

  factory MutationReopenCard.fromJson(Map<String, dynamic> json) {
    final l$updateCardsByPk = json['updateCardsByPk'];
    final l$$__typename = json['__typename'];
    return MutationReopenCard(
      updateCardsByPk: l$updateCardsByPk == null
          ? null
          : FragmentCardFragment.fromJson((l$updateCardsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentCardFragment? updateCardsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateCardsByPk = updateCardsByPk;
    _resultData['updateCardsByPk'] = l$updateCardsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateCardsByPk = updateCardsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateCardsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationReopenCard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateCardsByPk = updateCardsByPk;
    final lOther$updateCardsByPk = other.updateCardsByPk;
    if (l$updateCardsByPk != lOther$updateCardsByPk) {
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

const documentNodeMutationReopenCard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ReopenCard'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cardId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateCardsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: VariableNode(name: NameNode(value: 'cardId')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'status'),
                      value: EnumValueNode(name: NameNode(value: 'draft')),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'CardFragment'),
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
    fragmentDefinitionCardFragment,
  ],
);
MutationReopenCard _parserFnMutationReopenCard(Map<String, dynamic> data) =>
    MutationReopenCard.fromJson(data);
typedef OnMutationCompletedMutationReopenCard = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationReopenCard?,
);

class OptionsMutationReopenCard extends graphql.MutationOptions<MutationReopenCard> {
  OptionsMutationReopenCard({
    String? operationName,
    required VariablesMutationReopenCard variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationReopenCard? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationReopenCard? onCompleted,
    graphql.OnMutationUpdate<MutationReopenCard>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ReopenCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFnMutationReopenCard(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationReopenCard,
         parserFn: _parserFnMutationReopenCard,
       );

  final OnMutationCompletedMutationReopenCard? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationReopenCard extends graphql.WatchQueryOptions<MutationReopenCard> {
  WatchOptionsMutationReopenCard({
    String? operationName,
    required VariablesMutationReopenCard variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationReopenCard? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ReopenCard',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationReopenCard,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationReopenCard,
       );
}

extension ClientExtensionMutationReopenCard on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationReopenCard>> mutateReopenCard(
    OptionsMutationReopenCard options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationReopenCard> watchMutationReopenCard(
    WatchOptionsMutationReopenCard options,
  ) => this.watchMutation(options);
}
