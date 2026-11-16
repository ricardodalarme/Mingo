// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryProgramProgress {
  factory VariablesQueryProgramProgress({required String slug}) =>
      VariablesQueryProgramProgress._({r'slug': slug});

  VariablesQueryProgramProgress._(this._$data);

  factory VariablesQueryProgramProgress.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$slug = data['slug'];
    result$data['slug'] = (l$slug as String);
    return VariablesQueryProgramProgress._(result$data);
  }

  Map<String, dynamic> _$data;

  String get slug => (_$data['slug'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$slug = slug;
    result$data['slug'] = l$slug;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryProgramProgress || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$slug = slug;
    return Object.hashAll([l$slug]);
  }
}

class QueryProgramProgress {
  QueryProgramProgress({
    required this.programEnrollments,
    required this.lessonProgress,
    this.$__typename = 'query_root',
  });

  factory QueryProgramProgress.fromJson(Map<String, dynamic> json) {
    final l$programEnrollments = json['programEnrollments'];
    final l$lessonProgress = json['lessonProgress'];
    final l$$__typename = json['__typename'];
    return QueryProgramProgress(
      programEnrollments: (l$programEnrollments as List<dynamic>)
          .map((e) => QueryProgramProgressprogramEnrollments.fromJson((e as Map<String, dynamic>)))
          .toList(),
      lessonProgress: (l$lessonProgress as List<dynamic>)
          .map((e) => QueryProgramProgresslessonProgress.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryProgramProgressprogramEnrollments> programEnrollments;

  final List<QueryProgramProgresslessonProgress> lessonProgress;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$programEnrollments = programEnrollments;
    _resultData['programEnrollments'] = l$programEnrollments.map((e) => e.toJson()).toList();
    final l$lessonProgress = lessonProgress;
    _resultData['lessonProgress'] = l$lessonProgress.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$programEnrollments = programEnrollments;
    final l$lessonProgress = lessonProgress;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$programEnrollments.map((v) => v)),
      Object.hashAll(l$lessonProgress.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryProgramProgress || runtimeType != other.runtimeType) {
      return false;
    }
    final l$programEnrollments = programEnrollments;
    final lOther$programEnrollments = other.programEnrollments;
    if (l$programEnrollments.length != lOther$programEnrollments.length) {
      return false;
    }
    for (int i = 0; i < l$programEnrollments.length; i++) {
      final l$programEnrollments$entry = l$programEnrollments[i];
      final lOther$programEnrollments$entry = lOther$programEnrollments[i];
      if (l$programEnrollments$entry != lOther$programEnrollments$entry) {
        return false;
      }
    }
    final l$lessonProgress = lessonProgress;
    final lOther$lessonProgress = other.lessonProgress;
    if (l$lessonProgress.length != lOther$lessonProgress.length) {
      return false;
    }
    for (int i = 0; i < l$lessonProgress.length; i++) {
      final l$lessonProgress$entry = l$lessonProgress[i];
      final lOther$lessonProgress$entry = lOther$lessonProgress[i];
      if (l$lessonProgress$entry != lOther$lessonProgress$entry) {
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

const documentNodeQueryProgramProgress = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'ProgramProgress'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'slug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'programEnrollments'),
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
                            value: VariableNode(name: NameNode(value: 'slug')),
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
                          value: EnumValueNode(name: NameNode(value: 'asc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '1'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'programSlug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'currentDay'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'completedAt'),
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
            name: NameNode(value: 'lessonProgress'),
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
                            value: VariableNode(name: NameNode(value: 'slug')),
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
                          name: NameNode(value: 'lessonDay'),
                          value: EnumValueNode(name: NameNode(value: 'asc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '100'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'programSlug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'lessonDay'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'status'),
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
QueryProgramProgress _parserFnQueryProgramProgress(Map<String, dynamic> data) =>
    QueryProgramProgress.fromJson(data);
typedef OnQueryCompleteQueryProgramProgress = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryProgramProgress?,
);

class OptionsQueryProgramProgress extends graphql.QueryOptions<QueryProgramProgress> {
  OptionsQueryProgramProgress({
    String? operationName,
    required VariablesQueryProgramProgress variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryProgramProgress? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryProgramProgress? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ProgramProgress',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryProgramProgress(data)),
         onError: onError,
         document: documentNodeQueryProgramProgress,
         parserFn: _parserFnQueryProgramProgress,
       );

  final OnQueryCompleteQueryProgramProgress? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryProgramProgress extends graphql.WatchQueryOptions<QueryProgramProgress> {
  WatchOptionsQueryProgramProgress({
    String? operationName,
    required VariablesQueryProgramProgress variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryProgramProgress? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'ProgramProgress',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryProgramProgress,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryProgramProgress,
       );
}

class FetchMoreOptionsQueryProgramProgress extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryProgramProgress({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryProgramProgress variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryProgramProgress,
       );
}

extension ClientExtensionQueryProgramProgress on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryProgramProgress>> queryProgramProgress(
    OptionsQueryProgramProgress options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryProgramProgress> watchQueryProgramProgress(
    WatchOptionsQueryProgramProgress options,
  ) => this.watchQuery(options);

  void writeQueryProgramProgress({
    required QueryProgramProgress data,
    required VariablesQueryProgramProgress variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryProgramProgress),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryProgramProgress? readQueryProgramProgress({
    required VariablesQueryProgramProgress variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryProgramProgress),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryProgramProgress.fromJson(result);
  }
}

class QueryProgramProgressprogramEnrollments {
  QueryProgramProgressprogramEnrollments({
    required this.programSlug,
    required this.currentDay,
    this.completedAt,
    this.$__typename = 'programEnrollments',
  });

  factory QueryProgramProgressprogramEnrollments.fromJson(Map<String, dynamic> json) {
    final l$programSlug = json['programSlug'];
    final l$currentDay = json['currentDay'];
    final l$completedAt = json['completedAt'];
    final l$$__typename = json['__typename'];
    return QueryProgramProgressprogramEnrollments(
      programSlug: (l$programSlug as String),
      currentDay: (l$currentDay as int),
      completedAt: l$completedAt == null ? null : DateTime.parse((l$completedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String programSlug;

  final int currentDay;

  final DateTime? completedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$programSlug = programSlug;
    _resultData['programSlug'] = l$programSlug;
    final l$currentDay = currentDay;
    _resultData['currentDay'] = l$currentDay;
    final l$completedAt = completedAt;
    _resultData['completedAt'] = l$completedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$completedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$programSlug = programSlug;
    final l$currentDay = currentDay;
    final l$completedAt = completedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$programSlug, l$currentDay, l$completedAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryProgramProgressprogramEnrollments || runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

class QueryProgramProgresslessonProgress {
  QueryProgramProgresslessonProgress({
    required this.programSlug,
    required this.lessonDay,
    required this.status,
    this.$__typename = 'lessonProgress',
  });

  factory QueryProgramProgresslessonProgress.fromJson(Map<String, dynamic> json) {
    final l$programSlug = json['programSlug'];
    final l$lessonDay = json['lessonDay'];
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return QueryProgramProgresslessonProgress(
      programSlug: (l$programSlug as String),
      lessonDay: (l$lessonDay as int),
      status: fromJsonEnumLessonStatus_enum((l$status as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String programSlug;

  final int lessonDay;

  final EnumLessonStatus_enum status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$programSlug = programSlug;
    _resultData['programSlug'] = l$programSlug;
    final l$lessonDay = lessonDay;
    _resultData['lessonDay'] = l$lessonDay;
    final l$status = status;
    _resultData['status'] = toJsonEnumLessonStatus_enum(l$status);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$programSlug = programSlug;
    final l$lessonDay = lessonDay;
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([l$programSlug, l$lessonDay, l$status, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryProgramProgresslessonProgress || runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}
