// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSendGentleRequest {
  factory VariablesMutationSendGentleRequest({
    required String whenText,
    required String feelText,
    required String wishText,
    String? annoyanceId,
  }) => VariablesMutationSendGentleRequest._({
    r'whenText': whenText,
    r'feelText': feelText,
    r'wishText': wishText,
    if (annoyanceId != null) r'annoyanceId': annoyanceId,
  });

  VariablesMutationSendGentleRequest._(this._$data);

  factory VariablesMutationSendGentleRequest.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$whenText = data['whenText'];
    result$data['whenText'] = (l$whenText as String);
    final l$feelText = data['feelText'];
    result$data['feelText'] = (l$feelText as String);
    final l$wishText = data['wishText'];
    result$data['wishText'] = (l$wishText as String);
    if (data.containsKey('annoyanceId')) {
      final l$annoyanceId = data['annoyanceId'];
      result$data['annoyanceId'] = (l$annoyanceId as String?);
    }
    return VariablesMutationSendGentleRequest._(result$data);
  }

  Map<String, dynamic> _$data;

  String get whenText => (_$data['whenText'] as String);

  String get feelText => (_$data['feelText'] as String);

  String get wishText => (_$data['wishText'] as String);

  String? get annoyanceId => (_$data['annoyanceId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$whenText = whenText;
    result$data['whenText'] = l$whenText;
    final l$feelText = feelText;
    result$data['feelText'] = l$feelText;
    final l$wishText = wishText;
    result$data['wishText'] = l$wishText;
    if (_$data.containsKey('annoyanceId')) {
      final l$annoyanceId = annoyanceId;
      result$data['annoyanceId'] = l$annoyanceId;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSendGentleRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$whenText = whenText;
    final lOther$whenText = other.whenText;
    if (l$whenText != lOther$whenText) {
      return false;
    }
    final l$feelText = feelText;
    final lOther$feelText = other.feelText;
    if (l$feelText != lOther$feelText) {
      return false;
    }
    final l$wishText = wishText;
    final lOther$wishText = other.wishText;
    if (l$wishText != lOther$wishText) {
      return false;
    }
    final l$annoyanceId = annoyanceId;
    final lOther$annoyanceId = other.annoyanceId;
    if (_$data.containsKey('annoyanceId') != other._$data.containsKey('annoyanceId')) {
      return false;
    }
    if (l$annoyanceId != lOther$annoyanceId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$whenText = whenText;
    final l$feelText = feelText;
    final l$wishText = wishText;
    final l$annoyanceId = annoyanceId;
    return Object.hashAll([
      l$whenText,
      l$feelText,
      l$wishText,
      _$data.containsKey('annoyanceId') ? l$annoyanceId : const {},
    ]);
  }
}

class MutationSendGentleRequest {
  MutationSendGentleRequest({required this.sendGentleRequest, this.$__typename = 'mutation_root'});

  factory MutationSendGentleRequest.fromJson(Map<String, dynamic> json) {
    final l$sendGentleRequest = json['sendGentleRequest'];
    final l$$__typename = json['__typename'];
    return MutationSendGentleRequest(
      sendGentleRequest: (l$sendGentleRequest as List<dynamic>)
          .map(
            (e) => MutationSendGentleRequestsendGentleRequest.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationSendGentleRequestsendGentleRequest> sendGentleRequest;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$sendGentleRequest = sendGentleRequest;
    _resultData['sendGentleRequest'] = l$sendGentleRequest.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$sendGentleRequest = sendGentleRequest;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$sendGentleRequest.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSendGentleRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$sendGentleRequest = sendGentleRequest;
    final lOther$sendGentleRequest = other.sendGentleRequest;
    if (l$sendGentleRequest.length != lOther$sendGentleRequest.length) {
      return false;
    }
    for (int i = 0; i < l$sendGentleRequest.length; i++) {
      final l$sendGentleRequest$entry = l$sendGentleRequest[i];
      final lOther$sendGentleRequest$entry = lOther$sendGentleRequest[i];
      if (l$sendGentleRequest$entry != lOther$sendGentleRequest$entry) {
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

const documentNodeMutationSendGentleRequest = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SendGentleRequest'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'whenText')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'feelText')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'wishText')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'annoyanceId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'sendGentleRequest'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'whenText'),
                      value: VariableNode(name: NameNode(value: 'whenText')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'feelText'),
                      value: VariableNode(name: NameNode(value: 'feelText')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'wishText'),
                      value: VariableNode(name: NameNode(value: 'wishText')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'annoyanceId'),
                      value: VariableNode(name: NameNode(value: 'annoyanceId')),
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
MutationSendGentleRequest _parserFnMutationSendGentleRequest(Map<String, dynamic> data) =>
    MutationSendGentleRequest.fromJson(data);
typedef OnMutationCompletedMutationSendGentleRequest = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSendGentleRequest?,
);

class OptionsMutationSendGentleRequest extends graphql.MutationOptions<MutationSendGentleRequest> {
  OptionsMutationSendGentleRequest({
    String? operationName,
    required VariablesMutationSendGentleRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSendGentleRequest? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSendGentleRequest? onCompleted,
    graphql.OnMutationUpdate<MutationSendGentleRequest>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SendGentleRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationSendGentleRequest(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationSendGentleRequest,
         parserFn: _parserFnMutationSendGentleRequest,
       );

  final OnMutationCompletedMutationSendGentleRequest? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSendGentleRequest
    extends graphql.WatchQueryOptions<MutationSendGentleRequest> {
  WatchOptionsMutationSendGentleRequest({
    String? operationName,
    required VariablesMutationSendGentleRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSendGentleRequest? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SendGentleRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSendGentleRequest,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSendGentleRequest,
       );
}

extension ClientExtensionMutationSendGentleRequest on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSendGentleRequest>> mutateSendGentleRequest(
    OptionsMutationSendGentleRequest options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSendGentleRequest> watchMutationSendGentleRequest(
    WatchOptionsMutationSendGentleRequest options,
  ) => this.watchMutation(options);
}

class MutationSendGentleRequestsendGentleRequest {
  MutationSendGentleRequestsendGentleRequest({
    required this.id,
    this.$__typename = 'gentleRequests',
  });

  factory MutationSendGentleRequestsendGentleRequest.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationSendGentleRequestsendGentleRequest(
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
    if (other is! MutationSendGentleRequestsendGentleRequest || runtimeType != other.runtimeType) {
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
