// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUnmarkSensitiveDay {
  factory VariablesMutationUnmarkSensitiveDay({required DateTime day}) =>
      VariablesMutationUnmarkSensitiveDay._({r'day': day});

  VariablesMutationUnmarkSensitiveDay._(this._$data);

  factory VariablesMutationUnmarkSensitiveDay.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$day = data['day'];
    result$data['day'] = DateTime.parse((l$day as String));
    return VariablesMutationUnmarkSensitiveDay._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime get day => (_$data['day'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$day = day;
    result$data['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUnmarkSensitiveDay || runtimeType != other.runtimeType) {
      return false;
    }
    final l$day = day;
    final lOther$day = other.day;
    if (l$day != lOther$day) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$day = day;
    return Object.hashAll([l$day]);
  }
}

class MutationUnmarkSensitiveDay {
  MutationUnmarkSensitiveDay({
    required this.deleteFromCycleDaysCollection,
    this.$__typename = 'Mutation',
  });

  factory MutationUnmarkSensitiveDay.fromJson(Map<String, dynamic> json) {
    final l$deleteFromCycleDaysCollection = json['deleteFromCycleDaysCollection'];
    final l$$__typename = json['__typename'];
    return MutationUnmarkSensitiveDay(
      deleteFromCycleDaysCollection:
          MutationUnmarkSensitiveDaydeleteFromCycleDaysCollection.fromJson(
            (l$deleteFromCycleDaysCollection as Map<String, dynamic>),
          ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUnmarkSensitiveDaydeleteFromCycleDaysCollection deleteFromCycleDaysCollection;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteFromCycleDaysCollection = deleteFromCycleDaysCollection;
    _resultData['deleteFromCycleDaysCollection'] = l$deleteFromCycleDaysCollection.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteFromCycleDaysCollection = deleteFromCycleDaysCollection;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteFromCycleDaysCollection, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUnmarkSensitiveDay || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteFromCycleDaysCollection = deleteFromCycleDaysCollection;
    final lOther$deleteFromCycleDaysCollection = other.deleteFromCycleDaysCollection;
    if (l$deleteFromCycleDaysCollection != lOther$deleteFromCycleDaysCollection) {
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

const documentNodeMutationUnmarkSensitiveDay = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UnmarkSensitiveDay'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'day')),
          type: NamedTypeNode(name: NameNode(value: 'Date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'deleteFromCycleDaysCollection'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'filter'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'day'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: 'eq'),
                            value: VariableNode(name: NameNode(value: 'day')),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'kind'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: 'eq'),
                            value: EnumValueNode(name: NameNode(value: 'heavy')),
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
                  name: NameNode(value: 'affectedCount'),
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
MutationUnmarkSensitiveDay _parserFnMutationUnmarkSensitiveDay(Map<String, dynamic> data) =>
    MutationUnmarkSensitiveDay.fromJson(data);
typedef OnMutationCompletedMutationUnmarkSensitiveDay = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUnmarkSensitiveDay?,
);

class OptionsMutationUnmarkSensitiveDay
    extends graphql.MutationOptions<MutationUnmarkSensitiveDay> {
  OptionsMutationUnmarkSensitiveDay({
    String? operationName,
    required VariablesMutationUnmarkSensitiveDay variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUnmarkSensitiveDay? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUnmarkSensitiveDay? onCompleted,
    graphql.OnMutationUpdate<MutationUnmarkSensitiveDay>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UnmarkSensitiveDay',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUnmarkSensitiveDay(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUnmarkSensitiveDay,
         parserFn: _parserFnMutationUnmarkSensitiveDay,
       );

  final OnMutationCompletedMutationUnmarkSensitiveDay? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUnmarkSensitiveDay
    extends graphql.WatchQueryOptions<MutationUnmarkSensitiveDay> {
  WatchOptionsMutationUnmarkSensitiveDay({
    String? operationName,
    required VariablesMutationUnmarkSensitiveDay variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUnmarkSensitiveDay? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UnmarkSensitiveDay',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUnmarkSensitiveDay,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUnmarkSensitiveDay,
       );
}

extension ClientExtensionMutationUnmarkSensitiveDay on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUnmarkSensitiveDay>> mutateUnmarkSensitiveDay(
    OptionsMutationUnmarkSensitiveDay options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUnmarkSensitiveDay> watchMutationUnmarkSensitiveDay(
    WatchOptionsMutationUnmarkSensitiveDay options,
  ) => this.watchMutation(options);
}

class MutationUnmarkSensitiveDaydeleteFromCycleDaysCollection {
  MutationUnmarkSensitiveDaydeleteFromCycleDaysCollection({
    required this.affectedCount,
    this.$__typename = 'CycleDaysDeleteResponse',
  });

  factory MutationUnmarkSensitiveDaydeleteFromCycleDaysCollection.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$affectedCount = json['affectedCount'];
    final l$$__typename = json['__typename'];
    return MutationUnmarkSensitiveDaydeleteFromCycleDaysCollection(
      affectedCount: (l$affectedCount as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int affectedCount;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$affectedCount = affectedCount;
    _resultData['affectedCount'] = l$affectedCount;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$affectedCount = affectedCount;
    final l$$__typename = $__typename;
    return Object.hashAll([l$affectedCount, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUnmarkSensitiveDaydeleteFromCycleDaysCollection ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$affectedCount = affectedCount;
    final lOther$affectedCount = other.affectedCount;
    if (l$affectedCount != lOther$affectedCount) {
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
