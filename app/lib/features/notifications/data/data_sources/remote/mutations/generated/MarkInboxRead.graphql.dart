// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationMarkInboxRead {
  factory VariablesMutationMarkInboxRead({required DateTime readAt}) =>
      VariablesMutationMarkInboxRead._({r'readAt': readAt});

  VariablesMutationMarkInboxRead._(this._$data);

  factory VariablesMutationMarkInboxRead.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$readAt = data['readAt'];
    result$data['readAt'] = DateTime.parse((l$readAt as String));
    return VariablesMutationMarkInboxRead._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime get readAt => (_$data['readAt'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$readAt = readAt;
    result$data['readAt'] = ((v) => v.toUtc().toIso8601String())(l$readAt);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationMarkInboxRead || runtimeType != other.runtimeType) {
      return false;
    }
    final l$readAt = readAt;
    final lOther$readAt = other.readAt;
    if (l$readAt != lOther$readAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$readAt = readAt;
    return Object.hashAll([l$readAt]);
  }
}

class MutationMarkInboxRead {
  MutationMarkInboxRead({this.updateInboxItems, this.$__typename = 'mutation_root'});

  factory MutationMarkInboxRead.fromJson(Map<String, dynamic> json) {
    final l$updateInboxItems = json['updateInboxItems'];
    final l$$__typename = json['__typename'];
    return MutationMarkInboxRead(
      updateInboxItems: l$updateInboxItems == null
          ? null
          : MutationMarkInboxReadupdateInboxItems.fromJson(
              (l$updateInboxItems as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationMarkInboxReadupdateInboxItems? updateInboxItems;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateInboxItems = updateInboxItems;
    _resultData['updateInboxItems'] = l$updateInboxItems?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateInboxItems = updateInboxItems;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateInboxItems, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationMarkInboxRead || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateInboxItems = updateInboxItems;
    final lOther$updateInboxItems = other.updateInboxItems;
    if (l$updateInboxItems != lOther$updateInboxItems) {
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

const documentNodeMutationMarkInboxRead = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MarkInboxRead'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'readAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateInboxItems'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'readAt'),
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
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'readAt'),
                      value: VariableNode(name: NameNode(value: 'readAt')),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'affected_rows'),
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
MutationMarkInboxRead _parserFnMutationMarkInboxRead(Map<String, dynamic> data) =>
    MutationMarkInboxRead.fromJson(data);
typedef OnMutationCompletedMutationMarkInboxRead = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationMarkInboxRead?,
);

class OptionsMutationMarkInboxRead extends graphql.MutationOptions<MutationMarkInboxRead> {
  OptionsMutationMarkInboxRead({
    String? operationName,
    required VariablesMutationMarkInboxRead variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationMarkInboxRead? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationMarkInboxRead? onCompleted,
    graphql.OnMutationUpdate<MutationMarkInboxRead>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MarkInboxRead',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationMarkInboxRead(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationMarkInboxRead,
         parserFn: _parserFnMutationMarkInboxRead,
       );

  final OnMutationCompletedMutationMarkInboxRead? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationMarkInboxRead extends graphql.WatchQueryOptions<MutationMarkInboxRead> {
  WatchOptionsMutationMarkInboxRead({
    String? operationName,
    required VariablesMutationMarkInboxRead variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationMarkInboxRead? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MarkInboxRead',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationMarkInboxRead,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationMarkInboxRead,
       );
}

extension ClientExtensionMutationMarkInboxRead on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationMarkInboxRead>> mutateMarkInboxRead(
    OptionsMutationMarkInboxRead options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationMarkInboxRead> watchMutationMarkInboxRead(
    WatchOptionsMutationMarkInboxRead options,
  ) => this.watchMutation(options);
}

class MutationMarkInboxReadupdateInboxItems {
  MutationMarkInboxReadupdateInboxItems({
    required this.affected_rows,
    this.$__typename = 'inboxItems_mutation_response',
  });

  factory MutationMarkInboxReadupdateInboxItems.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationMarkInboxReadupdateInboxItems(
      affected_rows: (l$affected_rows as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int affected_rows;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$affected_rows = affected_rows;
    _resultData['affected_rows'] = l$affected_rows;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$affected_rows = affected_rows;
    final l$$__typename = $__typename;
    return Object.hashAll([l$affected_rows, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationMarkInboxReadupdateInboxItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$affected_rows = affected_rows;
    final lOther$affected_rows = other.affected_rows;
    if (l$affected_rows != lOther$affected_rows) {
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
