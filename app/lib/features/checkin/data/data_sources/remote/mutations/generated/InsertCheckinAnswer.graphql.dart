// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationInsertCheckinAnswer {
  factory VariablesMutationInsertCheckinAnswer({required Inputcheckins_insert_input answers}) =>
      VariablesMutationInsertCheckinAnswer._({r'answers': answers});

  VariablesMutationInsertCheckinAnswer._(this._$data);

  factory VariablesMutationInsertCheckinAnswer.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$answers = data['answers'];
    result$data['answers'] = Inputcheckins_insert_input.fromJson(
      (l$answers as Map<String, dynamic>),
    );
    return VariablesMutationInsertCheckinAnswer._(result$data);
  }

  Map<String, dynamic> _$data;

  Inputcheckins_insert_input get answers => (_$data['answers'] as Inputcheckins_insert_input);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$answers = answers;
    result$data['answers'] = l$answers.toJson();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationInsertCheckinAnswer || runtimeType != other.runtimeType) {
      return false;
    }
    final l$answers = answers;
    final lOther$answers = other.answers;
    if (l$answers != lOther$answers) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$answers = answers;
    return Object.hashAll([l$answers]);
  }
}

class MutationInsertCheckinAnswer {
  MutationInsertCheckinAnswer({this.insertCheckinsOne, this.$__typename = 'mutation_root'});

  factory MutationInsertCheckinAnswer.fromJson(Map<String, dynamic> json) {
    final l$insertCheckinsOne = json['insertCheckinsOne'];
    final l$$__typename = json['__typename'];
    return MutationInsertCheckinAnswer(
      insertCheckinsOne: l$insertCheckinsOne == null
          ? null
          : MutationInsertCheckinAnswerinsertCheckinsOne.fromJson(
              (l$insertCheckinsOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationInsertCheckinAnswerinsertCheckinsOne? insertCheckinsOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertCheckinsOne = insertCheckinsOne;
    _resultData['insertCheckinsOne'] = l$insertCheckinsOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertCheckinsOne = insertCheckinsOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertCheckinsOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertCheckinAnswer || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertCheckinsOne = insertCheckinsOne;
    final lOther$insertCheckinsOne = other.insertCheckinsOne;
    if (l$insertCheckinsOne != lOther$insertCheckinsOne) {
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

const documentNodeMutationInsertCheckinAnswer = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InsertCheckinAnswer'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'answers')),
          type: NamedTypeNode(name: NameNode(value: 'checkins_insert_input'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertCheckinsOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: VariableNode(name: NameNode(value: 'answers')),
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
                  name: NameNode(value: 'weekStart'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer1'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer2'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer3'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer4'),
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
MutationInsertCheckinAnswer _parserFnMutationInsertCheckinAnswer(Map<String, dynamic> data) =>
    MutationInsertCheckinAnswer.fromJson(data);
typedef OnMutationCompletedMutationInsertCheckinAnswer = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationInsertCheckinAnswer?,
);

class OptionsMutationInsertCheckinAnswer
    extends graphql.MutationOptions<MutationInsertCheckinAnswer> {
  OptionsMutationInsertCheckinAnswer({
    String? operationName,
    required VariablesMutationInsertCheckinAnswer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertCheckinAnswer? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationInsertCheckinAnswer? onCompleted,
    graphql.OnMutationUpdate<MutationInsertCheckinAnswer>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertCheckinAnswer',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationInsertCheckinAnswer(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationInsertCheckinAnswer,
         parserFn: _parserFnMutationInsertCheckinAnswer,
       );

  final OnMutationCompletedMutationInsertCheckinAnswer? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationInsertCheckinAnswer
    extends graphql.WatchQueryOptions<MutationInsertCheckinAnswer> {
  WatchOptionsMutationInsertCheckinAnswer({
    String? operationName,
    required VariablesMutationInsertCheckinAnswer variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertCheckinAnswer? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertCheckinAnswer',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationInsertCheckinAnswer,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationInsertCheckinAnswer,
       );
}

extension ClientExtensionMutationInsertCheckinAnswer on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationInsertCheckinAnswer>> mutateInsertCheckinAnswer(
    OptionsMutationInsertCheckinAnswer options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationInsertCheckinAnswer> watchMutationInsertCheckinAnswer(
    WatchOptionsMutationInsertCheckinAnswer options,
  ) => this.watchMutation(options);
}

class MutationInsertCheckinAnswerinsertCheckinsOne {
  MutationInsertCheckinAnswerinsertCheckinsOne({
    required this.id,
    required this.weekStart,
    this.answer1,
    this.answer2,
    this.answer3,
    this.answer4,
    this.$__typename = 'checkins',
  });

  factory MutationInsertCheckinAnswerinsertCheckinsOne.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$weekStart = json['weekStart'];
    final l$answer1 = json['answer1'];
    final l$answer2 = json['answer2'];
    final l$answer3 = json['answer3'];
    final l$answer4 = json['answer4'];
    final l$$__typename = json['__typename'];
    return MutationInsertCheckinAnswerinsertCheckinsOne(
      id: (l$id as String),
      weekStart: DateTime.parse((l$weekStart as String)),
      answer1: (l$answer1 as String?),
      answer2: (l$answer2 as String?),
      answer3: (l$answer3 as String?),
      answer4: (l$answer4 as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime weekStart;

  final String? answer1;

  final String? answer2;

  final String? answer3;

  final String? answer4;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$weekStart = weekStart;
    _resultData['weekStart'] = ((v) => v.toIso8601String().substring(0, 10))(l$weekStart);
    final l$answer1 = answer1;
    _resultData['answer1'] = l$answer1;
    final l$answer2 = answer2;
    _resultData['answer2'] = l$answer2;
    final l$answer3 = answer3;
    _resultData['answer3'] = l$answer3;
    final l$answer4 = answer4;
    _resultData['answer4'] = l$answer4;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$weekStart = weekStart;
    final l$answer1 = answer1;
    final l$answer2 = answer2;
    final l$answer3 = answer3;
    final l$answer4 = answer4;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$weekStart,
      l$answer1,
      l$answer2,
      l$answer3,
      l$answer4,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertCheckinAnswerinsertCheckinsOne ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$weekStart = weekStart;
    final lOther$weekStart = other.weekStart;
    if (l$weekStart != lOther$weekStart) {
      return false;
    }
    final l$answer1 = answer1;
    final lOther$answer1 = other.answer1;
    if (l$answer1 != lOther$answer1) {
      return false;
    }
    final l$answer2 = answer2;
    final lOther$answer2 = other.answer2;
    if (l$answer2 != lOther$answer2) {
      return false;
    }
    final l$answer3 = answer3;
    final lOther$answer3 = other.answer3;
    if (l$answer3 != lOther$answer3) {
      return false;
    }
    final l$answer4 = answer4;
    final lOther$answer4 = other.answer4;
    if (l$answer4 != lOther$answer4) {
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
