// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationAnswerSpiceDesire {
  factory VariablesMutationAnswerSpiceDesire({
    required String slug,
    required EnumSpiceAnswer_enum answer,
  }) => VariablesMutationAnswerSpiceDesire._({r'slug': slug, r'answer': answer});

  VariablesMutationAnswerSpiceDesire._(this._$data);

  factory VariablesMutationAnswerSpiceDesire.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$slug = data['slug'];
    result$data['slug'] = (l$slug as String);
    final l$answer = data['answer'];
    result$data['answer'] = fromJsonEnumSpiceAnswer_enum((l$answer as String));
    return VariablesMutationAnswerSpiceDesire._(result$data);
  }

  Map<String, dynamic> _$data;

  String get slug => (_$data['slug'] as String);

  EnumSpiceAnswer_enum get answer => (_$data['answer'] as EnumSpiceAnswer_enum);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$slug = slug;
    result$data['slug'] = l$slug;
    final l$answer = answer;
    result$data['answer'] = toJsonEnumSpiceAnswer_enum(l$answer);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationAnswerSpiceDesire || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$answer = answer;
    final lOther$answer = other.answer;
    if (l$answer != lOther$answer) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$slug = slug;
    final l$answer = answer;
    return Object.hashAll([l$slug, l$answer]);
  }
}

class MutationAnswerSpiceDesire {
  MutationAnswerSpiceDesire({this.insertSpiceDesireAnswersOne, this.$__typename = 'mutation_root'});

  factory MutationAnswerSpiceDesire.fromJson(Map<String, dynamic> json) {
    final l$insertSpiceDesireAnswersOne = json['insertSpiceDesireAnswersOne'];
    final l$$__typename = json['__typename'];
    return MutationAnswerSpiceDesire(
      insertSpiceDesireAnswersOne: l$insertSpiceDesireAnswersOne == null
          ? null
          : MutationAnswerSpiceDesireinsertSpiceDesireAnswersOne.fromJson(
              (l$insertSpiceDesireAnswersOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationAnswerSpiceDesireinsertSpiceDesireAnswersOne? insertSpiceDesireAnswersOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertSpiceDesireAnswersOne = insertSpiceDesireAnswersOne;
    _resultData['insertSpiceDesireAnswersOne'] = l$insertSpiceDesireAnswersOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertSpiceDesireAnswersOne = insertSpiceDesireAnswersOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertSpiceDesireAnswersOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationAnswerSpiceDesire || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertSpiceDesireAnswersOne = insertSpiceDesireAnswersOne;
    final lOther$insertSpiceDesireAnswersOne = other.insertSpiceDesireAnswersOne;
    if (l$insertSpiceDesireAnswersOne != lOther$insertSpiceDesireAnswersOne) {
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

const documentNodeMutationAnswerSpiceDesire = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AnswerSpiceDesire'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'slug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'answer')),
          type: NamedTypeNode(name: NameNode(value: 'SpiceAnswer_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertSpiceDesireAnswersOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'contentSlug'),
                      value: VariableNode(name: NameNode(value: 'slug')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'answer'),
                      value: VariableNode(name: NameNode(value: 'answer')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'on_conflict'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'constraint'),
                      value: EnumValueNode(name: NameNode(value: 'spice_desire_answers_pkey')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'update_columns'),
                      value: ListValueNode(
                        values: [EnumValueNode(name: NameNode(value: 'answer'))],
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
                  name: NameNode(value: 'contentSlug'),
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
MutationAnswerSpiceDesire _parserFnMutationAnswerSpiceDesire(Map<String, dynamic> data) =>
    MutationAnswerSpiceDesire.fromJson(data);
typedef OnMutationCompletedMutationAnswerSpiceDesire = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationAnswerSpiceDesire?,
);

class OptionsMutationAnswerSpiceDesire extends graphql.MutationOptions<MutationAnswerSpiceDesire> {
  OptionsMutationAnswerSpiceDesire({
    String? operationName,
    required VariablesMutationAnswerSpiceDesire variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationAnswerSpiceDesire? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationAnswerSpiceDesire? onCompleted,
    graphql.OnMutationUpdate<MutationAnswerSpiceDesire>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'AnswerSpiceDesire',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationAnswerSpiceDesire(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationAnswerSpiceDesire,
         parserFn: _parserFnMutationAnswerSpiceDesire,
       );

  final OnMutationCompletedMutationAnswerSpiceDesire? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationAnswerSpiceDesire
    extends graphql.WatchQueryOptions<MutationAnswerSpiceDesire> {
  WatchOptionsMutationAnswerSpiceDesire({
    String? operationName,
    required VariablesMutationAnswerSpiceDesire variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationAnswerSpiceDesire? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'AnswerSpiceDesire',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationAnswerSpiceDesire,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationAnswerSpiceDesire,
       );
}

extension ClientExtensionMutationAnswerSpiceDesire on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationAnswerSpiceDesire>> mutateAnswerSpiceDesire(
    OptionsMutationAnswerSpiceDesire options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationAnswerSpiceDesire> watchMutationAnswerSpiceDesire(
    WatchOptionsMutationAnswerSpiceDesire options,
  ) => this.watchMutation(options);
}

class MutationAnswerSpiceDesireinsertSpiceDesireAnswersOne {
  MutationAnswerSpiceDesireinsertSpiceDesireAnswersOne({
    required this.contentSlug,
    this.$__typename = 'spiceDesireAnswers',
  });

  factory MutationAnswerSpiceDesireinsertSpiceDesireAnswersOne.fromJson(Map<String, dynamic> json) {
    final l$contentSlug = json['contentSlug'];
    final l$$__typename = json['__typename'];
    return MutationAnswerSpiceDesireinsertSpiceDesireAnswersOne(
      contentSlug: (l$contentSlug as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String contentSlug;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$contentSlug = contentSlug;
    _resultData['contentSlug'] = l$contentSlug;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$contentSlug = contentSlug;
    final l$$__typename = $__typename;
    return Object.hashAll([l$contentSlug, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationAnswerSpiceDesireinsertSpiceDesireAnswersOne ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$contentSlug = contentSlug;
    final lOther$contentSlug = other.contentSlug;
    if (l$contentSlug != lOther$contentSlug) {
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
