// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteGiftWish {
  factory VariablesMutationDeleteGiftWish({required String id}) =>
      VariablesMutationDeleteGiftWish._({r'id': id});

  VariablesMutationDeleteGiftWish._(this._$data);

  factory VariablesMutationDeleteGiftWish.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteGiftWish._(result$data);
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
    if (other is! VariablesMutationDeleteGiftWish || runtimeType != other.runtimeType) {
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

class MutationDeleteGiftWish {
  MutationDeleteGiftWish({this.deleteGiftIdeas, this.$__typename = 'mutation_root'});

  factory MutationDeleteGiftWish.fromJson(Map<String, dynamic> json) {
    final l$deleteGiftIdeas = json['deleteGiftIdeas'];
    final l$$__typename = json['__typename'];
    return MutationDeleteGiftWish(
      deleteGiftIdeas: l$deleteGiftIdeas == null
          ? null
          : MutationDeleteGiftWishdeleteGiftIdeas.fromJson(
              (l$deleteGiftIdeas as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteGiftWishdeleteGiftIdeas? deleteGiftIdeas;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteGiftIdeas = deleteGiftIdeas;
    _resultData['deleteGiftIdeas'] = l$deleteGiftIdeas?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteGiftIdeas = deleteGiftIdeas;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteGiftIdeas, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteGiftWish || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteGiftIdeas = deleteGiftIdeas;
    final lOther$deleteGiftIdeas = other.deleteGiftIdeas;
    if (l$deleteGiftIdeas != lOther$deleteGiftIdeas) {
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

const documentNodeMutationDeleteGiftWish = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteGiftWish'),
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
            name: NameNode(value: 'deleteGiftIdeas'),
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
MutationDeleteGiftWish _parserFnMutationDeleteGiftWish(Map<String, dynamic> data) =>
    MutationDeleteGiftWish.fromJson(data);
typedef OnMutationCompletedMutationDeleteGiftWish = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteGiftWish?,
);

class OptionsMutationDeleteGiftWish extends graphql.MutationOptions<MutationDeleteGiftWish> {
  OptionsMutationDeleteGiftWish({
    String? operationName,
    required VariablesMutationDeleteGiftWish variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteGiftWish? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteGiftWish? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteGiftWish>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteGiftWish',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationDeleteGiftWish(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteGiftWish,
         parserFn: _parserFnMutationDeleteGiftWish,
       );

  final OnMutationCompletedMutationDeleteGiftWish? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteGiftWish extends graphql.WatchQueryOptions<MutationDeleteGiftWish> {
  WatchOptionsMutationDeleteGiftWish({
    String? operationName,
    required VariablesMutationDeleteGiftWish variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteGiftWish? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteGiftWish',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteGiftWish,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteGiftWish,
       );
}

extension ClientExtensionMutationDeleteGiftWish on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteGiftWish>> mutateDeleteGiftWish(
    OptionsMutationDeleteGiftWish options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteGiftWish> watchMutationDeleteGiftWish(
    WatchOptionsMutationDeleteGiftWish options,
  ) => this.watchMutation(options);
}

class MutationDeleteGiftWishdeleteGiftIdeas {
  MutationDeleteGiftWishdeleteGiftIdeas({
    required this.affected_rows,
    this.$__typename = 'giftIdeas_mutation_response',
  });

  factory MutationDeleteGiftWishdeleteGiftIdeas.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationDeleteGiftWishdeleteGiftIdeas(
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
    if (other is! MutationDeleteGiftWishdeleteGiftIdeas || runtimeType != other.runtimeType) {
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
