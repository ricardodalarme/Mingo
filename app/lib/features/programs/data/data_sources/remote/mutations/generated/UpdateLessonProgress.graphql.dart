// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateLessonProgress {
  factory VariablesMutationUpdateLessonProgress({
    required String programSlug,
    required int lessonDay,
    required EnumLessonStatus_enum status,
  }) => VariablesMutationUpdateLessonProgress._({
    r'programSlug': programSlug,
    r'lessonDay': lessonDay,
    r'status': status,
  });

  VariablesMutationUpdateLessonProgress._(this._$data);

  factory VariablesMutationUpdateLessonProgress.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$programSlug = data['programSlug'];
    result$data['programSlug'] = (l$programSlug as String);
    final l$lessonDay = data['lessonDay'];
    result$data['lessonDay'] = (l$lessonDay as int);
    final l$status = data['status'];
    result$data['status'] = fromJsonEnumLessonStatus_enum((l$status as String));
    return VariablesMutationUpdateLessonProgress._(result$data);
  }

  Map<String, dynamic> _$data;

  String get programSlug => (_$data['programSlug'] as String);

  int get lessonDay => (_$data['lessonDay'] as int);

  EnumLessonStatus_enum get status => (_$data['status'] as EnumLessonStatus_enum);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$programSlug = programSlug;
    result$data['programSlug'] = l$programSlug;
    final l$lessonDay = lessonDay;
    result$data['lessonDay'] = l$lessonDay;
    final l$status = status;
    result$data['status'] = toJsonEnumLessonStatus_enum(l$status);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateLessonProgress || runtimeType != other.runtimeType) {
      return false;
    }
    final l$programSlug = programSlug;
    final lOther$programSlug = other.programSlug;
    if (l$programSlug != lOther$programSlug) {
      return false;
    }
    final l$lessonDay = lessonDay;
    final lOther$lessonDay = other.lessonDay;
    if (l$lessonDay != lOther$lessonDay) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$programSlug = programSlug;
    final l$lessonDay = lessonDay;
    final l$status = status;
    return Object.hashAll([l$programSlug, l$lessonDay, l$status]);
  }
}

class MutationUpdateLessonProgress {
  MutationUpdateLessonProgress({this.updateLessonProgress, this.$__typename = 'mutation_root'});

  factory MutationUpdateLessonProgress.fromJson(Map<String, dynamic> json) {
    final l$updateLessonProgress = json['updateLessonProgress'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLessonProgress(
      updateLessonProgress: l$updateLessonProgress == null
          ? null
          : MutationUpdateLessonProgressupdateLessonProgress.fromJson(
              (l$updateLessonProgress as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateLessonProgressupdateLessonProgress? updateLessonProgress;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateLessonProgress = updateLessonProgress;
    _resultData['updateLessonProgress'] = l$updateLessonProgress?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateLessonProgress = updateLessonProgress;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateLessonProgress, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateLessonProgress || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateLessonProgress = updateLessonProgress;
    final lOther$updateLessonProgress = other.updateLessonProgress;
    if (l$updateLessonProgress != lOther$updateLessonProgress) {
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

const documentNodeMutationUpdateLessonProgress = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateLessonProgress'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'programSlug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'lessonDay')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'status')),
          type: NamedTypeNode(name: NameNode(value: 'LessonStatus_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateLessonProgress'),
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
                    ObjectFieldNode(
                      name: NameNode(value: 'lessonDay'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'lessonDay')),
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
                      name: NameNode(value: 'status'),
                      value: VariableNode(name: NameNode(value: 'status')),
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
MutationUpdateLessonProgress _parserFnMutationUpdateLessonProgress(Map<String, dynamic> data) =>
    MutationUpdateLessonProgress.fromJson(data);
typedef OnMutationCompletedMutationUpdateLessonProgress = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateLessonProgress?,
);

class OptionsMutationUpdateLessonProgress
    extends graphql.MutationOptions<MutationUpdateLessonProgress> {
  OptionsMutationUpdateLessonProgress({
    String? operationName,
    required VariablesMutationUpdateLessonProgress variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLessonProgress? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateLessonProgress? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateLessonProgress>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLessonProgress',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpdateLessonProgress(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateLessonProgress,
         parserFn: _parserFnMutationUpdateLessonProgress,
       );

  final OnMutationCompletedMutationUpdateLessonProgress? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateLessonProgress
    extends graphql.WatchQueryOptions<MutationUpdateLessonProgress> {
  WatchOptionsMutationUpdateLessonProgress({
    String? operationName,
    required VariablesMutationUpdateLessonProgress variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateLessonProgress? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateLessonProgress',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateLessonProgress,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateLessonProgress,
       );
}

extension ClientExtensionMutationUpdateLessonProgress on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateLessonProgress>> mutateUpdateLessonProgress(
    OptionsMutationUpdateLessonProgress options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateLessonProgress> watchMutationUpdateLessonProgress(
    WatchOptionsMutationUpdateLessonProgress options,
  ) => this.watchMutation(options);
}

class MutationUpdateLessonProgressupdateLessonProgress {
  MutationUpdateLessonProgressupdateLessonProgress({
    required this.affected_rows,
    this.$__typename = 'lessonProgress_mutation_response',
  });

  factory MutationUpdateLessonProgressupdateLessonProgress.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpdateLessonProgressupdateLessonProgress(
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
    if (other is! MutationUpdateLessonProgressupdateLessonProgress ||
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
