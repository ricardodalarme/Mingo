// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQuerySentPartnerMessages {
  factory VariablesQuerySentPartnerMessages({required String senderId}) =>
      VariablesQuerySentPartnerMessages._({r'senderId': senderId});

  VariablesQuerySentPartnerMessages._(this._$data);

  factory VariablesQuerySentPartnerMessages.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$senderId = data['senderId'];
    result$data['senderId'] = (l$senderId as String);
    return VariablesQuerySentPartnerMessages._(result$data);
  }

  Map<String, dynamic> _$data;

  String get senderId => (_$data['senderId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$senderId = senderId;
    result$data['senderId'] = l$senderId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQuerySentPartnerMessages || runtimeType != other.runtimeType) {
      return false;
    }
    final l$senderId = senderId;
    final lOther$senderId = other.senderId;
    if (l$senderId != lOther$senderId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$senderId = senderId;
    return Object.hashAll([l$senderId]);
  }
}

class QuerySentPartnerMessages {
  QuerySentPartnerMessages({required this.partnerMessages, this.$__typename = 'query_root'});

  factory QuerySentPartnerMessages.fromJson(Map<String, dynamic> json) {
    final l$partnerMessages = json['partnerMessages'];
    final l$$__typename = json['__typename'];
    return QuerySentPartnerMessages(
      partnerMessages: (l$partnerMessages as List<dynamic>)
          .map((e) => QuerySentPartnerMessagespartnerMessages.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QuerySentPartnerMessagespartnerMessages> partnerMessages;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$partnerMessages = partnerMessages;
    _resultData['partnerMessages'] = l$partnerMessages.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$partnerMessages = partnerMessages;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$partnerMessages.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySentPartnerMessages || runtimeType != other.runtimeType) {
      return false;
    }
    final l$partnerMessages = partnerMessages;
    final lOther$partnerMessages = other.partnerMessages;
    if (l$partnerMessages.length != lOther$partnerMessages.length) {
      return false;
    }
    for (int i = 0; i < l$partnerMessages.length; i++) {
      final l$partnerMessages$entry = l$partnerMessages[i];
      final lOther$partnerMessages$entry = lOther$partnerMessages[i];
      if (l$partnerMessages$entry != lOther$partnerMessages$entry) {
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

const documentNodeQuerySentPartnerMessages = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SentPartnerMessages'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'senderId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'partnerMessages'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'senderId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'senderId')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'createdAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '30'),
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
                  name: NameNode(value: 'body'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'mediaFileId'),
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
QuerySentPartnerMessages _parserFnQuerySentPartnerMessages(Map<String, dynamic> data) =>
    QuerySentPartnerMessages.fromJson(data);
typedef OnQueryCompleteQuerySentPartnerMessages = FutureOr<void> Function(
  Map<String, dynamic>?,
  QuerySentPartnerMessages?,
);

class OptionsQuerySentPartnerMessages extends graphql.QueryOptions<QuerySentPartnerMessages> {
  OptionsQuerySentPartnerMessages({
    String? operationName,
    required VariablesQuerySentPartnerMessages variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySentPartnerMessages? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQuerySentPartnerMessages? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SentPartnerMessages',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQuerySentPartnerMessages(data)),
         onError: onError,
         document: documentNodeQuerySentPartnerMessages,
         parserFn: _parserFnQuerySentPartnerMessages,
       );

  final OnQueryCompleteQuerySentPartnerMessages? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQuerySentPartnerMessages
    extends graphql.WatchQueryOptions<QuerySentPartnerMessages> {
  WatchOptionsQuerySentPartnerMessages({
    String? operationName,
    required VariablesQuerySentPartnerMessages variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySentPartnerMessages? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SentPartnerMessages',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQuerySentPartnerMessages,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQuerySentPartnerMessages,
       );
}

class FetchMoreOptionsQuerySentPartnerMessages extends graphql.FetchMoreOptions {
  FetchMoreOptionsQuerySentPartnerMessages({
    required graphql.UpdateQuery updateQuery,
    required VariablesQuerySentPartnerMessages variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQuerySentPartnerMessages,
       );
}

extension ClientExtensionQuerySentPartnerMessages on graphql.GraphQLClient {
  Future<graphql.QueryResult<QuerySentPartnerMessages>> querySentPartnerMessages(
    OptionsQuerySentPartnerMessages options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QuerySentPartnerMessages> watchQuerySentPartnerMessages(
    WatchOptionsQuerySentPartnerMessages options,
  ) => this.watchQuery(options);

  void writeQuerySentPartnerMessages({
    required QuerySentPartnerMessages data,
    required VariablesQuerySentPartnerMessages variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQuerySentPartnerMessages),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QuerySentPartnerMessages? readQuerySentPartnerMessages({
    required VariablesQuerySentPartnerMessages variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQuerySentPartnerMessages),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QuerySentPartnerMessages.fromJson(result);
  }
}

class QuerySentPartnerMessagespartnerMessages {
  QuerySentPartnerMessagespartnerMessages({
    required this.id,
    required this.kind,
    this.body,
    this.mediaFileId,
    required this.createdAt,
    this.$__typename = 'partnerMessages',
  });

  factory QuerySentPartnerMessagespartnerMessages.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$kind = json['kind'];
    final l$body = json['body'];
    final l$mediaFileId = json['mediaFileId'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return QuerySentPartnerMessagespartnerMessages(
      id: (l$id as String),
      kind: fromJsonEnumPartnerMessageKind_enum((l$kind as String)),
      body: (l$body as String?),
      mediaFileId: (l$mediaFileId as String?),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumPartnerMessageKind_enum kind;

  final String? body;

  final String? mediaFileId;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumPartnerMessageKind_enum(l$kind);
    final l$body = body;
    _resultData['body'] = l$body;
    final l$mediaFileId = mediaFileId;
    _resultData['mediaFileId'] = l$mediaFileId;
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
    final l$body = body;
    final l$mediaFileId = mediaFileId;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$kind, l$body, l$mediaFileId, l$createdAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySentPartnerMessagespartnerMessages || runtimeType != other.runtimeType) {
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
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$mediaFileId = mediaFileId;
    final lOther$mediaFileId = other.mediaFileId;
    if (l$mediaFileId != lOther$mediaFileId) {
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
