// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationDeleteLessonProgress {
  factory VariablesMutationDeleteLessonProgress({required String programSlug}) =>
      VariablesMutationDeleteLessonProgress._({r'programSlug': programSlug});

  VariablesMutationDeleteLessonProgress._(this._$data);

  factory VariablesMutationDeleteLessonProgress.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$programSlug = data['programSlug'];
    result$data['programSlug'] = (l$programSlug as String);
    return VariablesMutationDeleteLessonProgress._(result$data);
  }

  Map<String, dynamic> _$data;

  String get programSlug => (_$data['programSlug'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$programSlug = programSlug;
    result$data['programSlug'] = l$programSlug;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationDeleteLessonProgress || runtimeType != other.runtimeType) {
      return false;
    }
    final l$programSlug = programSlug;
    final lOther$programSlug = other.programSlug;
    if (l$programSlug != lOther$programSlug) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$programSlug = programSlug;
    return Object.hashAll([l$programSlug]);
  }
}

class MutationDeleteLessonProgress {
  MutationDeleteLessonProgress({this.deleteLessonProgress, this.$__typename = 'mutation_root'});

  factory MutationDeleteLessonProgress.fromJson(Map<String, dynamic> json) {
    final l$deleteLessonProgress = json['deleteLessonProgress'];
    final l$$__typename = json['__typename'];
    return MutationDeleteLessonProgress(
      deleteLessonProgress: l$deleteLessonProgress == null
          ? null
          : MutationDeleteLessonProgressdeleteLessonProgress.fromJson(
              (l$deleteLessonProgress as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationDeleteLessonProgressdeleteLessonProgress? deleteLessonProgress;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$deleteLessonProgress = deleteLessonProgress;
    _resultData['deleteLessonProgress'] = l$deleteLessonProgress?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$deleteLessonProgress = deleteLessonProgress;
    final l$$__typename = $__typename;
    return Object.hashAll([l$deleteLessonProgress, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationDeleteLessonProgress || runtimeType != other.runtimeType) {
      return false;
    }
    final l$deleteLessonProgress = deleteLessonProgress;
    final lOther$deleteLessonProgress = other.deleteLessonProgress;
    if (l$deleteLessonProgress != lOther$deleteLessonProgress) {
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

const documentNodeMutationDeleteLessonProgress = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteLessonProgress'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'programSlug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'deleteLessonProgress'),
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
MutationDeleteLessonProgress _parserFnMutationDeleteLessonProgress(Map<String, dynamic> data) =>
    MutationDeleteLessonProgress.fromJson(data);
typedef OnMutationCompletedMutationDeleteLessonProgress = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationDeleteLessonProgress?,
);

class OptionsMutationDeleteLessonProgress
    extends graphql.MutationOptions<MutationDeleteLessonProgress> {
  OptionsMutationDeleteLessonProgress({
    String? operationName,
    required VariablesMutationDeleteLessonProgress variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteLessonProgress? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationDeleteLessonProgress? onCompleted,
    graphql.OnMutationUpdate<MutationDeleteLessonProgress>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteLessonProgress',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationDeleteLessonProgress(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationDeleteLessonProgress,
         parserFn: _parserFnMutationDeleteLessonProgress,
       );

  final OnMutationCompletedMutationDeleteLessonProgress? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationDeleteLessonProgress
    extends graphql.WatchQueryOptions<MutationDeleteLessonProgress> {
  WatchOptionsMutationDeleteLessonProgress({
    String? operationName,
    required VariablesMutationDeleteLessonProgress variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationDeleteLessonProgress? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'DeleteLessonProgress',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationDeleteLessonProgress,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationDeleteLessonProgress,
       );
}

extension ClientExtensionMutationDeleteLessonProgress on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationDeleteLessonProgress>> mutateDeleteLessonProgress(
    OptionsMutationDeleteLessonProgress options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationDeleteLessonProgress> watchMutationDeleteLessonProgress(
    WatchOptionsMutationDeleteLessonProgress options,
  ) => this.watchMutation(options);
}

class MutationDeleteLessonProgressdeleteLessonProgress {
  MutationDeleteLessonProgressdeleteLessonProgress({
    required this.affected_rows,
    this.$__typename = 'lessonProgress_mutation_response',
  });

  factory MutationDeleteLessonProgressdeleteLessonProgress.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationDeleteLessonProgressdeleteLessonProgress(
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
    if (other is! MutationDeleteLessonProgressdeleteLessonProgress ||
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
