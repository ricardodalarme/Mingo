// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteDateIdea {
  factory VariablesMutationDeleteDateIdea({required String id}) =>
      VariablesMutationDeleteDateIdea._({r'id': id});

  VariablesMutationDeleteDateIdea._(this._$data);

  factory VariablesMutationDeleteDateIdea.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesMutationDeleteDateIdea._(result$data);
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
    if (other is! VariablesMutationDeleteDateIdea || runtimeType != other.runtimeType) {
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

class MutationDeleteDateIdea {
  MutationDeleteDateIdea({this.deleteSavedDateIdeas, this.$__typename = 'mutation_root'});

  factory MutationDeleteDateIdea.fromJson(Map<String, dynamic> json) {
    final l$deleteSavedDateIdeas = json['deleteSavedDateIdeas'];
    final l$$__typename = json['__typename'];
    return MutationDeleteDateIdea(
      deleteSavedDateIdeas: l$deleteSavedDateIdeas == null
          ? null
          : MutationDeleteDateIdeadeleteSavedDateIdeas.fromJson(
              (l$deleteSavedDateIdeas as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteDateIdeadeleteSavedDateIdeas? deleteSavedDateIdeas;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteSavedDateIdeas = deleteSavedDateIdeas;
    _resultData['deleteSavedDateIdeas'] = l$deleteSavedDateIdeas?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteSavedDateIdeas = deleteSavedDateIdeas;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteSavedDateIdeas, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteDateIdea || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteSavedDateIdeas = deleteSavedDateIdeas;
    final lOther$deleteSavedDateIdeas = other.deleteSavedDateIdeas;
    if (l$deleteSavedDateIdeas != lOther$deleteSavedDateIdeas) {
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

const documentNodeMutationDeleteDateIdea = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteDateIdea'),
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
            name: NameNode(value: 'deleteSavedDateIdeas'),
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
MutationDeleteDateIdea _parserFnMutationDeleteDateIdea(Map<String, dynamic> data) =>
    MutationDeleteDateIdea.fromJson(data);
typedef OnMutationCompletedMutationDeleteDateIdea = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteDateIdea?,
);

class OptionsMutationDeleteDateIdea extends graphql.MutationOptions<MutationDeleteDateIdea> {
  OptionsMutationDeleteDateIdea({
    String? operationName,
    required VariablesMutationDeleteDateIdea variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteDateIdea? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteDateIdea? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteDateIdea>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteDateIdea',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationDeleteDateIdea(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteDateIdea,
         parserFn: _parserFnMutationDeleteDateIdea,
       );

  final OnMutationCompletedMutationDeleteDateIdea? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteDateIdea extends graphql.WatchQueryOptions<MutationDeleteDateIdea> {
  WatchOptionsMutationDeleteDateIdea({
    String? operationName,
    required VariablesMutationDeleteDateIdea variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteDateIdea? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteDateIdea',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteDateIdea,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteDateIdea,
       );
}

extension ClientExtensionMutationDeleteDateIdea on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteDateIdea>> mutateDeleteDateIdea(
    OptionsMutationDeleteDateIdea options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteDateIdea> watchMutationDeleteDateIdea(
    WatchOptionsMutationDeleteDateIdea options,
  ) => this.watchMutation(options);
}

class MutationDeleteDateIdeadeleteSavedDateIdeas {
  MutationDeleteDateIdeadeleteSavedDateIdeas({
    required this.affected_rows,
    this.$__typename = 'savedDateIdeas_mutation_response',
  });

  factory MutationDeleteDateIdeadeleteSavedDateIdeas.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationDeleteDateIdeadeleteSavedDateIdeas(
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
    if (other is! MutationDeleteDateIdeadeleteSavedDateIdeas || runtimeType != other.runtimeType) {
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
