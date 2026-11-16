// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationRevokeLoveStyleShare {
  factory VariablesMutationRevokeLoveStyleShare({required String id}) =>
      VariablesMutationRevokeLoveStyleShare._({r'id': id});

  VariablesMutationRevokeLoveStyleShare._(this._$data);

  factory VariablesMutationRevokeLoveStyleShare.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationRevokeLoveStyleShare._(result$data);
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
    if (other is! VariablesMutationRevokeLoveStyleShare || runtimeType != other.runtimeType) {
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

class MutationRevokeLoveStyleShare {
  MutationRevokeLoveStyleShare({
    this.deletePartnerMessagesByPk,
    this.$__typename = 'mutation_root',
  });

  factory MutationRevokeLoveStyleShare.fromJson(Map<String, dynamic> json) {
    final l$deletePartnerMessagesByPk = json['deletePartnerMessagesByPk'];
    final l$$__typename = json['__typename'];
    return MutationRevokeLoveStyleShare(
      deletePartnerMessagesByPk: l$deletePartnerMessagesByPk == null
          ? null
          : MutationRevokeLoveStyleSharedeletePartnerMessagesByPk.fromJson(
              (l$deletePartnerMessagesByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationRevokeLoveStyleSharedeletePartnerMessagesByPk? deletePartnerMessagesByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deletePartnerMessagesByPk = deletePartnerMessagesByPk;
    _resultData['deletePartnerMessagesByPk'] = l$deletePartnerMessagesByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deletePartnerMessagesByPk = deletePartnerMessagesByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deletePartnerMessagesByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationRevokeLoveStyleShare || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deletePartnerMessagesByPk = deletePartnerMessagesByPk;
    final lOther$deletePartnerMessagesByPk = other.deletePartnerMessagesByPk;
    if (l$deletePartnerMessagesByPk != lOther$deletePartnerMessagesByPk) {
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

const documentNodeMutationRevokeLoveStyleShare = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RevokeLoveStyleShare'),
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
            name: NameNode(value: 'deletePartnerMessagesByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
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
MutationRevokeLoveStyleShare _parserFnMutationRevokeLoveStyleShare(Map<String, dynamic> data) =>
    MutationRevokeLoveStyleShare.fromJson(data);
typedef OnMutationCompletedMutationRevokeLoveStyleShare = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationRevokeLoveStyleShare?,
);

class OptionsMutationRevokeLoveStyleShare
    extends graphql.MutationOptions<MutationRevokeLoveStyleShare> {
  OptionsMutationRevokeLoveStyleShare({
    String? operationName,
    required VariablesMutationRevokeLoveStyleShare variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRevokeLoveStyleShare? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationRevokeLoveStyleShare? onCompleted,
    graphql.OnMutationUpdate<MutationRevokeLoveStyleShare>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'RevokeLoveStyleShare',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationRevokeLoveStyleShare(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationRevokeLoveStyleShare,
         parserFn: _parserFnMutationRevokeLoveStyleShare,
       );

  final OnMutationCompletedMutationRevokeLoveStyleShare? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationRevokeLoveStyleShare
    extends graphql.WatchQueryOptions<MutationRevokeLoveStyleShare> {
  WatchOptionsMutationRevokeLoveStyleShare({
    String? operationName,
    required VariablesMutationRevokeLoveStyleShare variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRevokeLoveStyleShare? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'RevokeLoveStyleShare',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationRevokeLoveStyleShare,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationRevokeLoveStyleShare,
       );
}

extension ClientExtensionMutationRevokeLoveStyleShare on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationRevokeLoveStyleShare>> mutateRevokeLoveStyleShare(
    OptionsMutationRevokeLoveStyleShare options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationRevokeLoveStyleShare> watchMutationRevokeLoveStyleShare(
    WatchOptionsMutationRevokeLoveStyleShare options,
  ) => this.watchMutation(options);
}

class MutationRevokeLoveStyleSharedeletePartnerMessagesByPk {
  MutationRevokeLoveStyleSharedeletePartnerMessagesByPk({
    required this.id,
    this.$__typename = 'partnerMessages',
  });

  factory MutationRevokeLoveStyleSharedeletePartnerMessagesByPk.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationRevokeLoveStyleSharedeletePartnerMessagesByPk(
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
    if (other is! MutationRevokeLoveStyleSharedeletePartnerMessagesByPk ||
        runtimeType != other.runtimeType) {
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
