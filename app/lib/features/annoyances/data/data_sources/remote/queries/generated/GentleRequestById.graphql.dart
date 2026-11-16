// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryGentleRequestById {
  factory VariablesQueryGentleRequestById({required String id}) =>
      VariablesQueryGentleRequestById._({r'id': id});

  VariablesQueryGentleRequestById._(this._$data);

  factory VariablesQueryGentleRequestById.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesQueryGentleRequestById._(result$data);
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
    if (other is! VariablesQueryGentleRequestById || runtimeType != other.runtimeType) {
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

class QueryGentleRequestById {
  QueryGentleRequestById({this.gentleRequestsByPk, this.$__typename = 'query_root'});

  factory QueryGentleRequestById.fromJson(Map<String, dynamic> json) {
    final l$gentleRequestsByPk = json['gentleRequestsByPk'];
    final l$$__typename = json['__typename'];
    return QueryGentleRequestById(
      gentleRequestsByPk: l$gentleRequestsByPk == null
          ? null
          : QueryGentleRequestByIdgentleRequestsByPk.fromJson(
              (l$gentleRequestsByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryGentleRequestByIdgentleRequestsByPk? gentleRequestsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$gentleRequestsByPk = gentleRequestsByPk;
    _resultData['gentleRequestsByPk'] = l$gentleRequestsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$gentleRequestsByPk = gentleRequestsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$gentleRequestsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGentleRequestById || runtimeType != other.runtimeType) {
      return false;
    }
    final l$gentleRequestsByPk = gentleRequestsByPk;
    final lOther$gentleRequestsByPk = other.gentleRequestsByPk;
    if (l$gentleRequestsByPk != lOther$gentleRequestsByPk) {
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

const documentNodeQueryGentleRequestById = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GentleRequestById'),
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
            name: NameNode(value: 'gentleRequestsByPk'),
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
                  name: NameNode(value: 'whenText'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'feelText'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'wishText'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'senderId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'recipientId'),
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
                  name: NameNode(value: 'seenAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'thankedAt'),
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
                  name: NameNode(value: 'sender'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'displayName'),
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
                  name: NameNode(value: 'recipient'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'displayName'),
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
QueryGentleRequestById _parserFnQueryGentleRequestById(Map<String, dynamic> data) =>
    QueryGentleRequestById.fromJson(data);
typedef OnQueryCompleteQueryGentleRequestById = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryGentleRequestById?,
);

class OptionsQueryGentleRequestById extends graphql.QueryOptions<QueryGentleRequestById> {
  OptionsQueryGentleRequestById({
    String? operationName,
    required VariablesQueryGentleRequestById variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGentleRequestById? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryGentleRequestById? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'GentleRequestById',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryGentleRequestById(data)),
         onError: onError,
         document: documentNodeQueryGentleRequestById,
         parserFn: _parserFnQueryGentleRequestById,
       );

  final OnQueryCompleteQueryGentleRequestById? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryGentleRequestById extends graphql.WatchQueryOptions<QueryGentleRequestById> {
  WatchOptionsQueryGentleRequestById({
    String? operationName,
    required VariablesQueryGentleRequestById variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryGentleRequestById? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'GentleRequestById',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryGentleRequestById,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryGentleRequestById,
       );
}

class FetchMoreOptionsQueryGentleRequestById extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryGentleRequestById({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryGentleRequestById variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryGentleRequestById,
       );
}

extension ClientExtensionQueryGentleRequestById on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryGentleRequestById>> queryGentleRequestById(
    OptionsQueryGentleRequestById options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryGentleRequestById> watchQueryGentleRequestById(
    WatchOptionsQueryGentleRequestById options,
  ) => this.watchQuery(options);

  void writeQueryGentleRequestById({
    required QueryGentleRequestById data,
    required VariablesQueryGentleRequestById variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryGentleRequestById),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryGentleRequestById? readQueryGentleRequestById({
    required VariablesQueryGentleRequestById variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryGentleRequestById),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryGentleRequestById.fromJson(result);
  }
}

class QueryGentleRequestByIdgentleRequestsByPk {
  QueryGentleRequestByIdgentleRequestsByPk({
    required this.id,
    required this.whenText,
    required this.feelText,
    required this.wishText,
    required this.senderId,
    required this.recipientId,
    this.response,
    this.seenAt,
    this.thankedAt,
    required this.createdAt,
    required this.sender,
    required this.recipient,
    this.$__typename = 'gentleRequests',
  });

  factory QueryGentleRequestByIdgentleRequestsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$whenText = json['whenText'];
    final l$feelText = json['feelText'];
    final l$wishText = json['wishText'];
    final l$senderId = json['senderId'];
    final l$recipientId = json['recipientId'];
    final l$response = json['response'];
    final l$seenAt = json['seenAt'];
    final l$thankedAt = json['thankedAt'];
    final l$createdAt = json['createdAt'];
    final l$sender = json['sender'];
    final l$recipient = json['recipient'];
    final l$$__typename = json['__typename'];
    return QueryGentleRequestByIdgentleRequestsByPk(
      id: (l$id as String),
      whenText: (l$whenText as String),
      feelText: (l$feelText as String),
      wishText: (l$wishText as String),
      senderId: (l$senderId as String),
      recipientId: (l$recipientId as String),
      response: (l$response as String?),
      seenAt: l$seenAt == null ? null : DateTime.parse((l$seenAt as String)),
      thankedAt: l$thankedAt == null ? null : DateTime.parse((l$thankedAt as String)),
      createdAt: DateTime.parse((l$createdAt as String)),
      sender: QueryGentleRequestByIdgentleRequestsByPksender.fromJson(
        (l$sender as Map<String, dynamic>),
      ),
      recipient: QueryGentleRequestByIdgentleRequestsByPkrecipient.fromJson(
        (l$recipient as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String whenText;

  final String feelText;

  final String wishText;

  final String senderId;

  final String recipientId;

  final String? response;

  final DateTime? seenAt;

  final DateTime? thankedAt;

  final DateTime createdAt;

  final QueryGentleRequestByIdgentleRequestsByPksender sender;

  final QueryGentleRequestByIdgentleRequestsByPkrecipient recipient;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$whenText = whenText;
    _resultData['whenText'] = l$whenText;
    final l$feelText = feelText;
    _resultData['feelText'] = l$feelText;
    final l$wishText = wishText;
    _resultData['wishText'] = l$wishText;
    final l$senderId = senderId;
    _resultData['senderId'] = l$senderId;
    final l$recipientId = recipientId;
    _resultData['recipientId'] = l$recipientId;
    final l$response = response;
    _resultData['response'] = l$response;
    final l$seenAt = seenAt;
    _resultData['seenAt'] = l$seenAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$seenAt);
    final l$thankedAt = thankedAt;
    _resultData['thankedAt'] = l$thankedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$thankedAt);
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$sender = sender;
    _resultData['sender'] = l$sender.toJson();
    final l$recipient = recipient;
    _resultData['recipient'] = l$recipient.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$whenText = whenText;
    final l$feelText = feelText;
    final l$wishText = wishText;
    final l$senderId = senderId;
    final l$recipientId = recipientId;
    final l$response = response;
    final l$seenAt = seenAt;
    final l$thankedAt = thankedAt;
    final l$createdAt = createdAt;
    final l$sender = sender;
    final l$recipient = recipient;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$whenText,
      l$feelText,
      l$wishText,
      l$senderId,
      l$recipientId,
      l$response,
      l$seenAt,
      l$thankedAt,
      l$createdAt,
      l$sender,
      l$recipient,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGentleRequestByIdgentleRequestsByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
    final l$senderId = senderId;
    final lOther$senderId = other.senderId;
    if (l$senderId != lOther$senderId) {
      return false;
    }
    final l$recipientId = recipientId;
    final lOther$recipientId = other.recipientId;
    if (l$recipientId != lOther$recipientId) {
      return false;
    }
    final l$response = response;
    final lOther$response = other.response;
    if (l$response != lOther$response) {
      return false;
    }
    final l$seenAt = seenAt;
    final lOther$seenAt = other.seenAt;
    if (l$seenAt != lOther$seenAt) {
      return false;
    }
    final l$thankedAt = thankedAt;
    final lOther$thankedAt = other.thankedAt;
    if (l$thankedAt != lOther$thankedAt) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$sender = sender;
    final lOther$sender = other.sender;
    if (l$sender != lOther$sender) {
      return false;
    }
    final l$recipient = recipient;
    final lOther$recipient = other.recipient;
    if (l$recipient != lOther$recipient) {
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

class QueryGentleRequestByIdgentleRequestsByPksender {
  QueryGentleRequestByIdgentleRequestsByPksender({this.displayName, this.$__typename = 'profiles'});

  factory QueryGentleRequestByIdgentleRequestsByPksender.fromJson(Map<String, dynamic> json) {
    final l$displayName = json['displayName'];
    final l$$__typename = json['__typename'];
    return QueryGentleRequestByIdgentleRequestsByPksender(
      displayName: (l$displayName as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? displayName;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$displayName = displayName;
    final l$$__typename = $__typename;
    return Object.hashAll([l$displayName, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGentleRequestByIdgentleRequestsByPksender ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
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

class QueryGentleRequestByIdgentleRequestsByPkrecipient {
  QueryGentleRequestByIdgentleRequestsByPkrecipient({
    this.displayName,
    this.$__typename = 'profiles',
  });

  factory QueryGentleRequestByIdgentleRequestsByPkrecipient.fromJson(Map<String, dynamic> json) {
    final l$displayName = json['displayName'];
    final l$$__typename = json['__typename'];
    return QueryGentleRequestByIdgentleRequestsByPkrecipient(
      displayName: (l$displayName as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? displayName;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$displayName = displayName;
    final l$$__typename = $__typename;
    return Object.hashAll([l$displayName, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryGentleRequestByIdgentleRequestsByPkrecipient ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
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
