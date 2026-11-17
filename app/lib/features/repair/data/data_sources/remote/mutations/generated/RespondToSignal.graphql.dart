// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationRespondToSignal {
  factory VariablesMutationRespondToSignal({
    required String signalId,
    EnumSignalResponse_enum? response,
    required DateTime seenAt,
  }) => VariablesMutationRespondToSignal._({
    r'signalId': signalId,
    if (response != null) r'response': response,
    r'seenAt': seenAt,
  });

  VariablesMutationRespondToSignal._(this._$data);

  factory VariablesMutationRespondToSignal.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$signalId = data['signalId'];
    result$data['signalId'] = (l$signalId as String);
    if (data.containsKey('response')) {
      final l$response = data['response'];
      result$data['response'] = l$response == null
          ? null
          : fromJsonEnumSignalResponse_enum((l$response as String));
    }
    final l$seenAt = data['seenAt'];
    result$data['seenAt'] = DateTime.parse((l$seenAt as String));
    return VariablesMutationRespondToSignal._(result$data);
  }

  Map<String, dynamic> _$data;

  String get signalId => (_$data['signalId'] as String);

  EnumSignalResponse_enum? get response => (_$data['response'] as EnumSignalResponse_enum?);

  DateTime get seenAt => (_$data['seenAt'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$signalId = signalId;
    result$data['signalId'] = l$signalId;
    if (_$data.containsKey('response')) {
      final l$response = response;
      result$data['response'] = l$response == null
          ? null
          : toJsonEnumSignalResponse_enum(l$response);
    }
    final l$seenAt = seenAt;
    result$data['seenAt'] = ((v) => v.toUtc().toIso8601String())(l$seenAt);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationRespondToSignal || runtimeType != other.runtimeType) {
      return false;
    }
    final l$signalId = signalId;
    final lOther$signalId = other.signalId;
    if (l$signalId != lOther$signalId) {
      return false;
    }
    final l$response = response;
    final lOther$response = other.response;
    if (_$data.containsKey('response') != other._$data.containsKey('response')) {
      return false;
    }
    if (l$response != lOther$response) {
      return false;
    }
    final l$seenAt = seenAt;
    final lOther$seenAt = other.seenAt;
    if (l$seenAt != lOther$seenAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$signalId = signalId;
    final l$response = response;
    final l$seenAt = seenAt;
    return Object.hashAll([
      l$signalId,
      _$data.containsKey('response') ? l$response : const {},
      l$seenAt,
    ]);
  }
}

class MutationRespondToSignal {
  MutationRespondToSignal({this.updateSignalsByPk, this.$__typename = 'mutation_root'});

  factory MutationRespondToSignal.fromJson(Map<String, dynamic> json) {
    final l$updateSignalsByPk = json['updateSignalsByPk'];
    final l$$__typename = json['__typename'];
    return MutationRespondToSignal(
      updateSignalsByPk: l$updateSignalsByPk == null
          ? null
          : MutationRespondToSignalupdateSignalsByPk.fromJson(
              (l$updateSignalsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationRespondToSignalupdateSignalsByPk? updateSignalsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateSignalsByPk = updateSignalsByPk;
    _resultData['updateSignalsByPk'] = l$updateSignalsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateSignalsByPk = updateSignalsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateSignalsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationRespondToSignal || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateSignalsByPk = updateSignalsByPk;
    final lOther$updateSignalsByPk = other.updateSignalsByPk;
    if (l$updateSignalsByPk != lOther$updateSignalsByPk) {
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

const documentNodeMutationRespondToSignal = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RespondToSignal'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'signalId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'response')),
          type: NamedTypeNode(name: NameNode(value: 'SignalResponse_enum'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'seenAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateSignalsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: VariableNode(name: NameNode(value: 'signalId')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'response'),
                      value: VariableNode(name: NameNode(value: 'response')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'seenAt'),
                      value: VariableNode(name: NameNode(value: 'seenAt')),
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
                  name: NameNode(value: 'response'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'respondedAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'seenAt'),
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
MutationRespondToSignal _parserFnMutationRespondToSignal(Map<String, dynamic> data) =>
    MutationRespondToSignal.fromJson(data);
typedef OnMutationCompletedMutationRespondToSignal = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationRespondToSignal?,
);

class OptionsMutationRespondToSignal extends graphql.MutationOptions<MutationRespondToSignal> {
  OptionsMutationRespondToSignal({
    String? operationName,
    required VariablesMutationRespondToSignal variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRespondToSignal? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationRespondToSignal? onCompleted,
    graphql.OnMutationUpdate<MutationRespondToSignal>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'RespondToSignal',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationRespondToSignal(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationRespondToSignal,
         parserFn: _parserFnMutationRespondToSignal,
       );

  final OnMutationCompletedMutationRespondToSignal? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationRespondToSignal
    extends graphql.WatchQueryOptions<MutationRespondToSignal> {
  WatchOptionsMutationRespondToSignal({
    String? operationName,
    required VariablesMutationRespondToSignal variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRespondToSignal? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'RespondToSignal',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationRespondToSignal,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationRespondToSignal,
       );
}

extension ClientExtensionMutationRespondToSignal on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationRespondToSignal>> mutateRespondToSignal(
    OptionsMutationRespondToSignal options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationRespondToSignal> watchMutationRespondToSignal(
    WatchOptionsMutationRespondToSignal options,
  ) => this.watchMutation(options);
}

class MutationRespondToSignalupdateSignalsByPk {
  MutationRespondToSignalupdateSignalsByPk({
    required this.id,
    this.response,
    this.respondedAt,
    this.seenAt,
    this.$__typename = 'signals',
  });

  factory MutationRespondToSignalupdateSignalsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$response = json['response'];
    final l$respondedAt = json['respondedAt'];
    final l$seenAt = json['seenAt'];
    final l$$__typename = json['__typename'];
    return MutationRespondToSignalupdateSignalsByPk(
      id: (l$id as String),
      response: l$response == null ? null : fromJsonEnumSignalResponse_enum((l$response as String)),
      respondedAt: l$respondedAt == null ? null : DateTime.parse((l$respondedAt as String)),
      seenAt: l$seenAt == null ? null : DateTime.parse((l$seenAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumSignalResponse_enum? response;

  final DateTime? respondedAt;

  final DateTime? seenAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$response = response;
    _resultData['response'] = l$response == null ? null : toJsonEnumSignalResponse_enum(l$response);
    final l$respondedAt = respondedAt;
    _resultData['respondedAt'] = l$respondedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$respondedAt);
    final l$seenAt = seenAt;
    _resultData['seenAt'] = l$seenAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$seenAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$response = response;
    final l$respondedAt = respondedAt;
    final l$seenAt = seenAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$response, l$respondedAt, l$seenAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationRespondToSignalupdateSignalsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$response = response;
    final lOther$response = other.response;
    if (l$response != lOther$response) {
      return false;
    }
    final l$respondedAt = respondedAt;
    final lOther$respondedAt = other.respondedAt;
    if (l$respondedAt != lOther$respondedAt) {
      return false;
    }
    final l$seenAt = seenAt;
    final lOther$seenAt = other.seenAt;
    if (l$seenAt != lOther$seenAt) {
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
