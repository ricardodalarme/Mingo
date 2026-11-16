// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteStoryEvent {
  factory VariablesMutationDeleteStoryEvent({required String id}) =>
      VariablesMutationDeleteStoryEvent._({r'id': id});

  VariablesMutationDeleteStoryEvent._(this._$data);

  factory VariablesMutationDeleteStoryEvent.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteStoryEvent._(result$data);
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
    if (other is! VariablesMutationDeleteStoryEvent || runtimeType != other.runtimeType) {
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

class MutationDeleteStoryEvent {
  MutationDeleteStoryEvent({this.deleteStoryEvents, this.$__typename = 'mutation_root'});

  factory MutationDeleteStoryEvent.fromJson(Map<String, dynamic> json) {
    final l$deleteStoryEvents = json['deleteStoryEvents'];
    final l$$__typename = json['__typename'];
    return MutationDeleteStoryEvent(
      deleteStoryEvents: l$deleteStoryEvents == null
          ? null
          : MutationDeleteStoryEventdeleteStoryEvents.fromJson(
              (l$deleteStoryEvents as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteStoryEventdeleteStoryEvents? deleteStoryEvents;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteStoryEvents = deleteStoryEvents;
    _resultData['deleteStoryEvents'] = l$deleteStoryEvents?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteStoryEvents = deleteStoryEvents;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteStoryEvents, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteStoryEvent || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteStoryEvents = deleteStoryEvents;
    final lOther$deleteStoryEvents = other.deleteStoryEvents;
    if (l$deleteStoryEvents != lOther$deleteStoryEvents) {
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

const documentNodeMutationDeleteStoryEvent = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteStoryEvent'),
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
            name: NameNode(value: 'deleteStoryEvents'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'id')),
                          ),
                        ],
                      ),
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
MutationDeleteStoryEvent _parserFnMutationDeleteStoryEvent(Map<String, dynamic> data) =>
    MutationDeleteStoryEvent.fromJson(data);
typedef OnMutationCompletedMutationDeleteStoryEvent = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteStoryEvent?,
);

class OptionsMutationDeleteStoryEvent extends graphql.MutationOptions<MutationDeleteStoryEvent> {
  OptionsMutationDeleteStoryEvent({
    String? operationName,
    required VariablesMutationDeleteStoryEvent variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteStoryEvent? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteStoryEvent? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteStoryEvent>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteStoryEvent',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationDeleteStoryEvent(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteStoryEvent,
         parserFn: _parserFnMutationDeleteStoryEvent,
       );

  final OnMutationCompletedMutationDeleteStoryEvent? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteStoryEvent
    extends graphql.WatchQueryOptions<MutationDeleteStoryEvent> {
  WatchOptionsMutationDeleteStoryEvent({
    String? operationName,
    required VariablesMutationDeleteStoryEvent variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteStoryEvent? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteStoryEvent',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteStoryEvent,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteStoryEvent,
       );
}

extension ClientExtensionMutationDeleteStoryEvent on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteStoryEvent>> mutateDeleteStoryEvent(
    OptionsMutationDeleteStoryEvent options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteStoryEvent> watchMutationDeleteStoryEvent(
    WatchOptionsMutationDeleteStoryEvent options,
  ) => this.watchMutation(options);
}

class MutationDeleteStoryEventdeleteStoryEvents {
  MutationDeleteStoryEventdeleteStoryEvents({
    required this.affected_rows,
    this.$__typename = 'storyEvents_mutation_response',
  });

  factory MutationDeleteStoryEventdeleteStoryEvents.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationDeleteStoryEventdeleteStoryEvents(
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
    if (other is! MutationDeleteStoryEventdeleteStoryEvents || runtimeType != other.runtimeType) {
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
