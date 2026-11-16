// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSendSlipNow {
  factory VariablesMutationSendSlipNow({required String slipId}) =>
      VariablesMutationSendSlipNow._({r'slipId': slipId});

  VariablesMutationSendSlipNow._(this._$data);

  factory VariablesMutationSendSlipNow.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$slipId = data['slipId'];
    result$data['slipId'] = (l$slipId as String);
    return VariablesMutationSendSlipNow._(result$data);
  }

  Map<String, dynamic> _$data;

  String get slipId => (_$data['slipId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$slipId = slipId;
    result$data['slipId'] = l$slipId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSendSlipNow || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slipId = slipId;
    final lOther$slipId = other.slipId;
    if (l$slipId != lOther$slipId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$slipId = slipId;
    return Object.hashAll([l$slipId]);
  }
}

class MutationSendSlipNow {
  MutationSendSlipNow({required this.sendSlip, this.$__typename = 'mutation_root'});

  factory MutationSendSlipNow.fromJson(Map<String, dynamic> json) {
    final l$sendSlip = json['sendSlip'];
    final l$$__typename = json['__typename'];
    return MutationSendSlipNow(
      sendSlip: (l$sendSlip as List<dynamic>)
          .map((e) => MutationSendSlipNowsendSlip.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationSendSlipNowsendSlip> sendSlip;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$sendSlip = sendSlip;
    _resultData['sendSlip'] = l$sendSlip.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$sendSlip = sendSlip;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$sendSlip.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSendSlipNow || runtimeType != other.runtimeType) {
      return false;
    }
    final l$sendSlip = sendSlip;
    final lOther$sendSlip = other.sendSlip;
    if (l$sendSlip.length != lOther$sendSlip.length) {
      return false;
    }
    for (int i = 0; i < l$sendSlip.length; i++) {
      final l$sendSlip$entry = l$sendSlip[i];
      final lOther$sendSlip$entry = lOther$sendSlip[i];
      if (l$sendSlip$entry != lOther$sendSlip$entry) {
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

const documentNodeMutationSendSlipNow = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SendSlipNow'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'slipId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'sendSlip'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'slipId'),
                      value: VariableNode(name: NameNode(value: 'slipId')),
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
                  name: NameNode(value: 'status'),
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
MutationSendSlipNow _parserFnMutationSendSlipNow(Map<String, dynamic> data) =>
    MutationSendSlipNow.fromJson(data);
typedef OnMutationCompletedMutationSendSlipNow = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSendSlipNow?,
);

class OptionsMutationSendSlipNow extends graphql.MutationOptions<MutationSendSlipNow> {
  OptionsMutationSendSlipNow({
    String? operationName,
    required VariablesMutationSendSlipNow variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSendSlipNow? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSendSlipNow? onCompleted,
    graphql.OnMutationUpdate<MutationSendSlipNow>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SendSlipNow',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationSendSlipNow(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSendSlipNow,
         parserFn: _parserFnMutationSendSlipNow,
       );

  final OnMutationCompletedMutationSendSlipNow? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSendSlipNow extends graphql.WatchQueryOptions<MutationSendSlipNow> {
  WatchOptionsMutationSendSlipNow({
    String? operationName,
    required VariablesMutationSendSlipNow variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSendSlipNow? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SendSlipNow',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSendSlipNow,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSendSlipNow,
       );
}

extension ClientExtensionMutationSendSlipNow on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSendSlipNow>> mutateSendSlipNow(
    OptionsMutationSendSlipNow options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSendSlipNow> watchMutationSendSlipNow(
    WatchOptionsMutationSendSlipNow options,
  ) => this.watchMutation(options);
}

class MutationSendSlipNowsendSlip {
  MutationSendSlipNowsendSlip({required this.id, required this.status, this.$__typename = 'cards'});

  factory MutationSendSlipNowsendSlip.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return MutationSendSlipNowsendSlip(
      id: (l$id as String),
      status: fromJsonEnumCardStatus_enum((l$status as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumCardStatus_enum status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$status = status;
    _resultData['status'] = toJsonEnumCardStatus_enum(l$status);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$status, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSendSlipNowsendSlip || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
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
