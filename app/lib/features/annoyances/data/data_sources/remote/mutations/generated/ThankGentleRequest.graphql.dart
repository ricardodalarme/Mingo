// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationThankGentleRequest {
  factory VariablesMutationThankGentleRequest({required String requestId, required String body}) =>
      VariablesMutationThankGentleRequest._({r'requestId': requestId, r'body': body});

  VariablesMutationThankGentleRequest._(this._$data);

  factory VariablesMutationThankGentleRequest.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$requestId = data['requestId'];
    result$data['requestId'] = (l$requestId as String);
    final l$body = data['body'];
    result$data['body'] = (l$body as String);
    return VariablesMutationThankGentleRequest._(result$data);
  }

  Map<String, dynamic> _$data;

  String get requestId => (_$data['requestId'] as String);

  String get body => (_$data['body'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$requestId = requestId;
    result$data['requestId'] = l$requestId;
    final l$body = body;
    result$data['body'] = l$body;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationThankGentleRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$requestId = requestId;
    final lOther$requestId = other.requestId;
    if (l$requestId != lOther$requestId) {
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
    final l$requestId = requestId;
    final l$body = body;
    return Object.hashAll([l$requestId, l$body]);
  }
}

class MutationThankGentleRequest {
  MutationThankGentleRequest({
    required this.thankGentleRequest,
    this.$__typename = 'mutation_root',
  });

  factory MutationThankGentleRequest.fromJson(Map<String, dynamic> json) {
    final l$thankGentleRequest = json['thankGentleRequest'];
    final l$$__typename = json['__typename'];
    return MutationThankGentleRequest(
      thankGentleRequest: (l$thankGentleRequest as List<dynamic>)
          .map(
            (e) =>
                MutationThankGentleRequestthankGentleRequest.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationThankGentleRequestthankGentleRequest> thankGentleRequest;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$thankGentleRequest = thankGentleRequest;
    _resultData['thankGentleRequest'] = l$thankGentleRequest.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$thankGentleRequest = thankGentleRequest;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$thankGentleRequest.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationThankGentleRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$thankGentleRequest = thankGentleRequest;
    final lOther$thankGentleRequest = other.thankGentleRequest;
    if (l$thankGentleRequest.length != lOther$thankGentleRequest.length) {
      return false;
    }
    for (int i = 0; i < l$thankGentleRequest.length; i++) {
      final l$thankGentleRequest$entry = l$thankGentleRequest[i];
      final lOther$thankGentleRequest$entry = lOther$thankGentleRequest[i];
      if (l$thankGentleRequest$entry != lOther$thankGentleRequest$entry) {
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

const documentNodeMutationThankGentleRequest = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'ThankGentleRequest'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'requestId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
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
            name: NameNode(value: 'thankGentleRequest'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'requestId'),
                      value: VariableNode(name: NameNode(value: 'requestId')),
                    ),
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
MutationThankGentleRequest _parserFnMutationThankGentleRequest(Map<String, dynamic> data) =>
    MutationThankGentleRequest.fromJson(data);
typedef OnMutationCompletedMutationThankGentleRequest = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationThankGentleRequest?,
);

class OptionsMutationThankGentleRequest
    extends graphql.MutationOptions<MutationThankGentleRequest> {
  OptionsMutationThankGentleRequest({
    String? operationName,
    required VariablesMutationThankGentleRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationThankGentleRequest? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationThankGentleRequest? onCompleted,
    graphql.OnMutationUpdate<MutationThankGentleRequest>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ThankGentleRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationThankGentleRequest(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationThankGentleRequest,
         parserFn: _parserFnMutationThankGentleRequest,
       );

  final OnMutationCompletedMutationThankGentleRequest? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationThankGentleRequest
    extends graphql.WatchQueryOptions<MutationThankGentleRequest> {
  WatchOptionsMutationThankGentleRequest({
    String? operationName,
    required VariablesMutationThankGentleRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationThankGentleRequest? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ThankGentleRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationThankGentleRequest,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationThankGentleRequest,
       );
}

extension ClientExtensionMutationThankGentleRequest on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationThankGentleRequest>> mutateThankGentleRequest(
    OptionsMutationThankGentleRequest options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationThankGentleRequest> watchMutationThankGentleRequest(
    WatchOptionsMutationThankGentleRequest options,
  ) => this.watchMutation(options);
}

class MutationThankGentleRequestthankGentleRequest {
  MutationThankGentleRequestthankGentleRequest({required this.id, this.$__typename = 'slips'});

  factory MutationThankGentleRequestthankGentleRequest.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationThankGentleRequestthankGentleRequest(
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
    if (other is! MutationThankGentleRequestthankGentleRequest ||
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
