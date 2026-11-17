// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryReceivedSignals {
  factory VariablesQueryReceivedSignals({required String recipientId}) =>
      VariablesQueryReceivedSignals._({r'recipientId': recipientId});

  VariablesQueryReceivedSignals._(this._$data);

  factory VariablesQueryReceivedSignals.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$recipientId = data['recipientId'];
    result$data['recipientId'] = (l$recipientId as String);
    return VariablesQueryReceivedSignals._(result$data);
  }

  Map<String, dynamic> _$data;

  String get recipientId => (_$data['recipientId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$recipientId = recipientId;
    result$data['recipientId'] = l$recipientId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryReceivedSignals || runtimeType != other.runtimeType) {
      return false;
    }
    final l$recipientId = recipientId;
    final lOther$recipientId = other.recipientId;
    if (l$recipientId != lOther$recipientId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$recipientId = recipientId;
    return Object.hashAll([l$recipientId]);
  }
}

class QueryReceivedSignals {
  QueryReceivedSignals({required this.signals, this.$__typename = 'query_root'});

  factory QueryReceivedSignals.fromJson(Map<String, dynamic> json) {
    final l$signals = json['signals'];
    final l$$__typename = json['__typename'];
    return QueryReceivedSignals(
      signals: (l$signals as List<dynamic>)
          .map((e) => QueryReceivedSignalssignals.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryReceivedSignalssignals> signals;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$signals = signals;
    _resultData['signals'] = l$signals.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$signals = signals;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$signals.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryReceivedSignals || runtimeType != other.runtimeType) {
      return false;
    }
    final l$signals = signals;
    final lOther$signals = other.signals;
    if (l$signals.length != lOther$signals.length) {
      return false;
    }
    for (int i = 0; i < l$signals.length; i++) {
      final l$signals$entry = l$signals[i];
      final lOther$signals$entry = lOther$signals[i];
      if (l$signals$entry != lOther$signals$entry) {
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

const documentNodeQueryReceivedSignals = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'ReceivedSignals'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'recipientId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'signals'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'recipientId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'recipientId')),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'seenAt'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_is_null'),
                            value: BooleanValueNode(value: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'createdAt'),
                      value: EnumValueNode(name: NameNode(value: 'desc')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '20'),
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
                  name: NameNode(value: 'kind'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'value'),
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
                  name: NameNode(value: 'createdAt'),
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
QueryReceivedSignals _parserFnQueryReceivedSignals(Map<String, dynamic> data) =>
    QueryReceivedSignals.fromJson(data);
typedef OnQueryCompleteQueryReceivedSignals = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryReceivedSignals?,
);

class OptionsQueryReceivedSignals extends graphql.QueryOptions<QueryReceivedSignals> {
  OptionsQueryReceivedSignals({
    String? operationName,
    required VariablesQueryReceivedSignals variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryReceivedSignals? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryReceivedSignals? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ReceivedSignals',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryReceivedSignals(data)),
         onError: onError,
         document: documentNodeQueryReceivedSignals,
         parserFn: _parserFnQueryReceivedSignals,
       );

  final OnQueryCompleteQueryReceivedSignals? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryReceivedSignals extends graphql.WatchQueryOptions<QueryReceivedSignals> {
  WatchOptionsQueryReceivedSignals({
    String? operationName,
    required VariablesQueryReceivedSignals variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryReceivedSignals? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ReceivedSignals',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryReceivedSignals,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryReceivedSignals,
       );
}

class FetchMoreOptionsQueryReceivedSignals extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryReceivedSignals({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryReceivedSignals variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryReceivedSignals,
       );
}

extension ClientExtensionQueryReceivedSignals on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryReceivedSignals>> queryReceivedSignals(
    OptionsQueryReceivedSignals options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryReceivedSignals> watchQueryReceivedSignals(
    WatchOptionsQueryReceivedSignals options,
  ) => this.watchQuery(options);

  void writeQueryReceivedSignals({
    required QueryReceivedSignals data,
    required VariablesQueryReceivedSignals variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryReceivedSignals),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryReceivedSignals? readQueryReceivedSignals({
    required VariablesQueryReceivedSignals variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryReceivedSignals),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryReceivedSignals.fromJson(result);
  }
}

class QueryReceivedSignalssignals {
  QueryReceivedSignalssignals({
    required this.id,
    required this.kind,
    this.value,
    this.body,
    this.response,
    this.respondedAt,
    this.seenAt,
    required this.createdAt,
    this.$__typename = 'signals',
  });

  factory QueryReceivedSignalssignals.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$kind = json['kind'];
    final l$value = json['value'];
    final l$body = json['body'];
    final l$response = json['response'];
    final l$respondedAt = json['respondedAt'];
    final l$seenAt = json['seenAt'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return QueryReceivedSignalssignals(
      id: (l$id as String),
      kind: fromJsonEnumSignalKind_enum((l$kind as String)),
      value: (l$value as String?),
      body: (l$body as String?),
      response: l$response == null ? null : fromJsonEnumSignalResponse_enum((l$response as String)),
      respondedAt: l$respondedAt == null ? null : DateTime.parse((l$respondedAt as String)),
      seenAt: l$seenAt == null ? null : DateTime.parse((l$seenAt as String)),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumSignalKind_enum kind;

  final String? value;

  final String? body;

  final EnumSignalResponse_enum? response;

  final DateTime? respondedAt;

  final DateTime? seenAt;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumSignalKind_enum(l$kind);
    final l$value = value;
    _resultData['value'] = l$value;
    final l$body = body;
    _resultData['body'] = l$body;
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
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$kind = kind;
    final l$value = value;
    final l$body = body;
    final l$response = response;
    final l$respondedAt = respondedAt;
    final l$seenAt = seenAt;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$kind,
      l$value,
      l$body,
      l$response,
      l$respondedAt,
      l$seenAt,
      l$createdAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryReceivedSignalssignals || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$value = value;
    final lOther$value = other.value;
    if (l$value != lOther$value) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
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
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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
