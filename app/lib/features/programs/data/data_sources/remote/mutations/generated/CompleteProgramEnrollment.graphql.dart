// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationCompleteProgramEnrollment {
  factory VariablesMutationCompleteProgramEnrollment({
    required String programSlug,
    required int currentDay,
    required DateTime completedAt,
  }) => VariablesMutationCompleteProgramEnrollment._({
    r'programSlug': programSlug,
    r'currentDay': currentDay,
    r'completedAt': completedAt,
  });

  VariablesMutationCompleteProgramEnrollment._(this._$data);

  factory VariablesMutationCompleteProgramEnrollment.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$programSlug = data['programSlug'];
    result$data['programSlug'] = (l$programSlug as String);
    final l$currentDay = data['currentDay'];
    result$data['currentDay'] = (l$currentDay as int);
    final l$completedAt = data['completedAt'];
    result$data['completedAt'] = DateTime.parse((l$completedAt as String));
    return VariablesMutationCompleteProgramEnrollment._(result$data);
  }

  Map<String, dynamic> _$data;

  String get programSlug => (_$data['programSlug'] as String);

  int get currentDay => (_$data['currentDay'] as int);

  DateTime get completedAt => (_$data['completedAt'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$programSlug = programSlug;
    result$data['programSlug'] = l$programSlug;
    final l$currentDay = currentDay;
    result$data['currentDay'] = l$currentDay;
    final l$completedAt = completedAt;
    result$data['completedAt'] = ((v) => v.toUtc().toIso8601String())(l$completedAt);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationCompleteProgramEnrollment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$programSlug = programSlug;
    final lOther$programSlug = other.programSlug;
    if (l$programSlug != lOther$programSlug) {
      return false;
    }
    final l$currentDay = currentDay;
    final lOther$currentDay = other.currentDay;
    if (l$currentDay != lOther$currentDay) {
      return false;
    }
    final l$completedAt = completedAt;
    final lOther$completedAt = other.completedAt;
    if (l$completedAt != lOther$completedAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$programSlug = programSlug;
    final l$currentDay = currentDay;
    final l$completedAt = completedAt;
    return Object.hashAll([l$programSlug, l$currentDay, l$completedAt]);
  }
}

class MutationCompleteProgramEnrollment {
  MutationCompleteProgramEnrollment({
    this.updateProgramEnrollments,
    this.$__typename = 'mutation_root',
  });

  factory MutationCompleteProgramEnrollment.fromJson(Map<String, dynamic> json) {
    final l$updateProgramEnrollments = json['updateProgramEnrollments'];
    final l$$__typename = json['__typename'];
    return MutationCompleteProgramEnrollment(
      updateProgramEnrollments: l$updateProgramEnrollments == null
          ? null
          : MutationCompleteProgramEnrollmentupdateProgramEnrollments.fromJson(
              (l$updateProgramEnrollments as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationCompleteProgramEnrollmentupdateProgramEnrollments? updateProgramEnrollments;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateProgramEnrollments = updateProgramEnrollments;
    _resultData['updateProgramEnrollments'] = l$updateProgramEnrollments?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateProgramEnrollments = updateProgramEnrollments;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateProgramEnrollments, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationCompleteProgramEnrollment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateProgramEnrollments = updateProgramEnrollments;
    final lOther$updateProgramEnrollments = other.updateProgramEnrollments;
    if (l$updateProgramEnrollments != lOther$updateProgramEnrollments) {
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

const documentNodeMutationCompleteProgramEnrollment = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CompleteProgramEnrollment'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'programSlug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'currentDay')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'completedAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateProgramEnrollments'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'programSlug'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'programSlug')),
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
                      name: NameNode(value: 'currentDay'),
                      value: VariableNode(name: NameNode(value: 'currentDay')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'completedAt'),
                      value: VariableNode(name: NameNode(value: 'completedAt')),
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
MutationCompleteProgramEnrollment _parserFnMutationCompleteProgramEnrollment(
  Map<String, dynamic> data,
) => MutationCompleteProgramEnrollment.fromJson(data);
typedef OnMutationCompletedMutationCompleteProgramEnrollment = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationCompleteProgramEnrollment?,
);

class OptionsMutationCompleteProgramEnrollment
    extends graphql.MutationOptions<MutationCompleteProgramEnrollment> {
  OptionsMutationCompleteProgramEnrollment({
    String? operationName,
    required VariablesMutationCompleteProgramEnrollment variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationCompleteProgramEnrollment? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationCompleteProgramEnrollment? onCompleted,
    graphql.OnMutationUpdate<MutationCompleteProgramEnrollment>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CompleteProgramEnrollment',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationCompleteProgramEnrollment(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationCompleteProgramEnrollment,
         parserFn: _parserFnMutationCompleteProgramEnrollment,
       );

  final OnMutationCompletedMutationCompleteProgramEnrollment? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationCompleteProgramEnrollment
    extends graphql.WatchQueryOptions<MutationCompleteProgramEnrollment> {
  WatchOptionsMutationCompleteProgramEnrollment({
    String? operationName,
    required VariablesMutationCompleteProgramEnrollment variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationCompleteProgramEnrollment? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CompleteProgramEnrollment',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationCompleteProgramEnrollment,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationCompleteProgramEnrollment,
       );
}

extension ClientExtensionMutationCompleteProgramEnrollment on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationCompleteProgramEnrollment>> mutateCompleteProgramEnrollment(
    OptionsMutationCompleteProgramEnrollment options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationCompleteProgramEnrollment> watchMutationCompleteProgramEnrollment(
    WatchOptionsMutationCompleteProgramEnrollment options,
  ) => this.watchMutation(options);
}

class MutationCompleteProgramEnrollmentupdateProgramEnrollments {
  MutationCompleteProgramEnrollmentupdateProgramEnrollments({
    required this.affected_rows,
    this.$__typename = 'programEnrollments_mutation_response',
  });

  factory MutationCompleteProgramEnrollmentupdateProgramEnrollments.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationCompleteProgramEnrollmentupdateProgramEnrollments(
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
    if (other is! MutationCompleteProgramEnrollmentupdateProgramEnrollments ||
        runtimeType != other.runtimeType) {
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
