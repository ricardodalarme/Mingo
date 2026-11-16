// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMyInbox {
  factory VariablesQueryMyInbox({required int limit}) => VariablesQueryMyInbox._({r'limit': limit});

  VariablesQueryMyInbox._(this._$data);

  factory VariablesQueryMyInbox.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$limit = data['limit'];
    result$data['limit'] = (l$limit as int);
    return VariablesQueryMyInbox._(result$data);
  }

  Map<String, dynamic> _$data;

  int get limit => (_$data['limit'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$limit = limit;
    result$data['limit'] = l$limit;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryMyInbox || runtimeType != other.runtimeType) {
      return false;
    }
    final l$limit = limit;
    final lOther$limit = other.limit;
    if (l$limit != lOther$limit) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$limit = limit;
    return Object.hashAll([l$limit]);
  }
}

class QueryMyInbox {
  QueryMyInbox({required this.inboxItems, this.$__typename = 'query_root'});

  factory QueryMyInbox.fromJson(Map<String, dynamic> json) {
    final l$inboxItems = json['inboxItems'];
    final l$$__typename = json['__typename'];
    return QueryMyInbox(
      inboxItems: (l$inboxItems as List<dynamic>)
          .map((e) => QueryMyInboxinboxItems.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMyInboxinboxItems> inboxItems;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$inboxItems = inboxItems;
    _resultData['inboxItems'] = l$inboxItems.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$inboxItems = inboxItems;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$inboxItems.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyInbox || runtimeType != other.runtimeType) {
      return false;
    }
    final l$inboxItems = inboxItems;
    final lOther$inboxItems = other.inboxItems;
    if (l$inboxItems.length != lOther$inboxItems.length) {
      return false;
    }
    for (int i = 0; i < l$inboxItems.length; i++) {
      final l$inboxItems$entry = l$inboxItems[i];
      final lOther$inboxItems$entry = lOther$inboxItems[i];
      if (l$inboxItems$entry != lOther$inboxItems$entry) {
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

const documentNodeQueryMyInbox = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyInbox'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'limit')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'inboxItems'),
            alias: null,
            arguments: [
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
                value: VariableNode(name: NameNode(value: 'limit')),
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
                  name: NameNode(value: 'type'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'refId'),
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
                  name: NameNode(value: 'readAt'),
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
QueryMyInbox _parserFnQueryMyInbox(Map<String, dynamic> data) => QueryMyInbox.fromJson(data);
typedef OnQueryCompleteQueryMyInbox = FutureOr<void> Function(Map<String, dynamic>?, QueryMyInbox?);

class OptionsQueryMyInbox extends graphql.QueryOptions<QueryMyInbox> {
  OptionsQueryMyInbox({
    String? operationName,
    required VariablesQueryMyInbox variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyInbox? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyInbox? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyInbox',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyInbox(data)),
         onError: onError,
         document: documentNodeQueryMyInbox,
         parserFn: _parserFnQueryMyInbox,
       );

  final OnQueryCompleteQueryMyInbox? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyInbox extends graphql.WatchQueryOptions<QueryMyInbox> {
  WatchOptionsQueryMyInbox({
    String? operationName,
    required VariablesQueryMyInbox variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyInbox? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyInbox',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyInbox,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyInbox,
       );
}

class FetchMoreOptionsQueryMyInbox extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyInbox({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMyInbox variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMyInbox,
       );
}

extension ClientExtensionQueryMyInbox on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyInbox>> queryMyInbox(OptionsQueryMyInbox options) async =>
      await this.query(options);

  graphql.ObservableQuery<QueryMyInbox> watchQueryMyInbox(WatchOptionsQueryMyInbox options) =>
      this.watchQuery(options);

  void writeQueryMyInbox({
    required QueryMyInbox data,
    required VariablesQueryMyInbox variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMyInbox),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyInbox? readQueryMyInbox({
    required VariablesQueryMyInbox variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMyInbox),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyInbox.fromJson(result);
  }
}

class QueryMyInboxinboxItems {
  QueryMyInboxinboxItems({
    required this.id,
    required this.type,
    this.refId,
    required this.createdAt,
    this.readAt,
    this.$__typename = 'inboxItems',
  });

  factory QueryMyInboxinboxItems.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$type = json['type'];
    final l$refId = json['refId'];
    final l$createdAt = json['createdAt'];
    final l$readAt = json['readAt'];
    final l$$__typename = json['__typename'];
    return QueryMyInboxinboxItems(
      id: (l$id as String),
      type: fromJsonEnumNotificationType_enum((l$type as String)),
      refId: (l$refId as String?),
      createdAt: DateTime.parse((l$createdAt as String)),
      readAt: l$readAt == null ? null : DateTime.parse((l$readAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumNotificationType_enum type;

  final String? refId;

  final DateTime createdAt;

  final DateTime? readAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$type = type;
    _resultData['type'] = toJsonEnumNotificationType_enum(l$type);
    final l$refId = refId;
    _resultData['refId'] = l$refId;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$readAt = readAt;
    _resultData['readAt'] = l$readAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$readAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$type = type;
    final l$refId = refId;
    final l$createdAt = createdAt;
    final l$readAt = readAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$type, l$refId, l$createdAt, l$readAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyInboxinboxItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$refId = refId;
    final lOther$refId = other.refId;
    if (l$refId != lOther$refId) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$readAt = readAt;
    final lOther$readAt = other.readAt;
    if (l$readAt != lOther$readAt) {
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
