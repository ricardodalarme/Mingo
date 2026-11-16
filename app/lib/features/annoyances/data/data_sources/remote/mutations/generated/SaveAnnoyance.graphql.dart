// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSaveAnnoyance {
  factory VariablesMutationSaveAnnoyance({required String body}) =>
      VariablesMutationSaveAnnoyance._({r'body': body});

  VariablesMutationSaveAnnoyance._(this._$data);

  factory VariablesMutationSaveAnnoyance.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$body = data['body'];
    result$data['body'] = (l$body as String);
    return VariablesMutationSaveAnnoyance._(result$data);
  }

  Map<String, dynamic> _$data;

  String get body => (_$data['body'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$body = body;
    result$data['body'] = l$body;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSaveAnnoyance || runtimeType != other.runtimeType) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$body = body;
    return Object.hashAll([l$body]);
  }
}

class MutationSaveAnnoyance {
  MutationSaveAnnoyance({this.insertAnnoyancesOne, this.$__typename = 'mutation_root'});

  factory MutationSaveAnnoyance.fromJson(Map<String, dynamic> json) {
    final l$insertAnnoyancesOne = json['insertAnnoyancesOne'];
    final l$$__typename = json['__typename'];
    return MutationSaveAnnoyance(
      insertAnnoyancesOne: l$insertAnnoyancesOne == null
          ? null
          : MutationSaveAnnoyanceinsertAnnoyancesOne.fromJson(
              (l$insertAnnoyancesOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationSaveAnnoyanceinsertAnnoyancesOne? insertAnnoyancesOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertAnnoyancesOne = insertAnnoyancesOne;
    _resultData['insertAnnoyancesOne'] = l$insertAnnoyancesOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertAnnoyancesOne = insertAnnoyancesOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertAnnoyancesOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSaveAnnoyance || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertAnnoyancesOne = insertAnnoyancesOne;
    final lOther$insertAnnoyancesOne = other.insertAnnoyancesOne;
    if (l$insertAnnoyancesOne != lOther$insertAnnoyancesOne) {
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

const documentNodeMutationSaveAnnoyance = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SaveAnnoyance'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'body')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertAnnoyancesOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'body'),
                      value: VariableNode(name: NameNode(value: 'body')),
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
                  name: NameNode(value: 'body'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'createdAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'expiresAt'),
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
MutationSaveAnnoyance _parserFnMutationSaveAnnoyance(Map<String, dynamic> data) =>
    MutationSaveAnnoyance.fromJson(data);
typedef OnMutationCompletedMutationSaveAnnoyance = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSaveAnnoyance?,
);

class OptionsMutationSaveAnnoyance extends graphql.MutationOptions<MutationSaveAnnoyance> {
  OptionsMutationSaveAnnoyance({
    String? operationName,
    required VariablesMutationSaveAnnoyance variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSaveAnnoyance? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSaveAnnoyance? onCompleted,
    graphql.OnMutationUpdate<MutationSaveAnnoyance>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SaveAnnoyance',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSaveAnnoyance(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSaveAnnoyance,
         parserFn: _parserFnMutationSaveAnnoyance,
       );

  final OnMutationCompletedMutationSaveAnnoyance? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSaveAnnoyance extends graphql.WatchQueryOptions<MutationSaveAnnoyance> {
  WatchOptionsMutationSaveAnnoyance({
    String? operationName,
    required VariablesMutationSaveAnnoyance variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSaveAnnoyance? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SaveAnnoyance',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSaveAnnoyance,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSaveAnnoyance,
       );
}

extension ClientExtensionMutationSaveAnnoyance on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSaveAnnoyance>> mutateSaveAnnoyance(
    OptionsMutationSaveAnnoyance options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSaveAnnoyance> watchMutationSaveAnnoyance(
    WatchOptionsMutationSaveAnnoyance options,
  ) => this.watchMutation(options);
}

class MutationSaveAnnoyanceinsertAnnoyancesOne {
  MutationSaveAnnoyanceinsertAnnoyancesOne({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.expiresAt,
    this.$__typename = 'annoyances',
  });

  factory MutationSaveAnnoyanceinsertAnnoyancesOne.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$body = json['body'];
    final l$createdAt = json['createdAt'];
    final l$expiresAt = json['expiresAt'];
    final l$$__typename = json['__typename'];
    return MutationSaveAnnoyanceinsertAnnoyancesOne(
      id: (l$id as String),
      body: (l$body as String),
      createdAt: DateTime.parse((l$createdAt as String)),
      expiresAt: DateTime.parse((l$expiresAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String body;

  final DateTime createdAt;

  final DateTime expiresAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$expiresAt = expiresAt;
    _resultData['expiresAt'] = ((v) => v.toUtc().toIso8601String())(l$expiresAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$body = body;
    final l$createdAt = createdAt;
    final l$expiresAt = expiresAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$body, l$createdAt, l$expiresAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSaveAnnoyanceinsertAnnoyancesOne || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$expiresAt = expiresAt;
    final lOther$expiresAt = other.expiresAt;
    if (l$expiresAt != lOther$expiresAt) {
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
