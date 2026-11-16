// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationInsertMood {
  factory VariablesMutationInsertMood({
    required EnumMood_enum mood,
    EnumMoodNeed_enum? need,
    required EnumMoodShare_enum share,
    required DateTime day,
  }) => VariablesMutationInsertMood._({
    r'mood': mood,
    if (need != null) r'need': need,
    r'share': share,
    r'day': day,
  });

  VariablesMutationInsertMood._(this._$data);

  factory VariablesMutationInsertMood.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$mood = data['mood'];
    result$data['mood'] = fromJsonEnumMood_enum((l$mood as String));
    if (data.containsKey('need')) {
      final l$need = data['need'];
      result$data['need'] = l$need == null ? null : fromJsonEnumMoodNeed_enum((l$need as String));
    }
    final l$share = data['share'];
    result$data['share'] = fromJsonEnumMoodShare_enum((l$share as String));
    final l$day = data['day'];
    result$data['day'] = DateTime.parse((l$day as String));
    return VariablesMutationInsertMood._(result$data);
  }

  Map<String, dynamic> _$data;

  EnumMood_enum get mood => (_$data['mood'] as EnumMood_enum);

  EnumMoodNeed_enum? get need => (_$data['need'] as EnumMoodNeed_enum?);

  EnumMoodShare_enum get share => (_$data['share'] as EnumMoodShare_enum);

  DateTime get day => (_$data['day'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$mood = mood;
    result$data['mood'] = toJsonEnumMood_enum(l$mood);
    if (_$data.containsKey('need')) {
      final l$need = need;
      result$data['need'] = l$need == null ? null : toJsonEnumMoodNeed_enum(l$need);
    }
    final l$share = share;
    result$data['share'] = toJsonEnumMoodShare_enum(l$share);
    final l$day = day;
    result$data['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationInsertMood || runtimeType != other.runtimeType) {
      return false;
    }
    final l$mood = mood;
    final lOther$mood = other.mood;
    if (l$mood != lOther$mood) {
      return false;
    }
    final l$need = need;
    final lOther$need = other.need;
    if (_$data.containsKey('need') != other._$data.containsKey('need')) {
      return false;
    }
    if (l$need != lOther$need) {
      return false;
    }
    final l$share = share;
    final lOther$share = other.share;
    if (l$share != lOther$share) {
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
    final l$mood = mood;
    final l$need = need;
    final l$share = share;
    final l$day = day;
    return Object.hashAll([l$mood, _$data.containsKey('need') ? l$need : const {}, l$share, l$day]);
  }
}

class MutationInsertMood {
  MutationInsertMood({this.insertMoodsOne, this.$__typename = 'mutation_root'});

  factory MutationInsertMood.fromJson(Map<String, dynamic> json) {
    final l$insertMoodsOne = json['insertMoodsOne'];
    final l$$__typename = json['__typename'];
    return MutationInsertMood(
      insertMoodsOne: l$insertMoodsOne == null
          ? null
          : MutationInsertMoodinsertMoodsOne.fromJson((l$insertMoodsOne as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationInsertMoodinsertMoodsOne? insertMoodsOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertMoodsOne = insertMoodsOne;
    _resultData['insertMoodsOne'] = l$insertMoodsOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertMoodsOne = insertMoodsOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertMoodsOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertMood || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertMoodsOne = insertMoodsOne;
    final lOther$insertMoodsOne = other.insertMoodsOne;
    if (l$insertMoodsOne != lOther$insertMoodsOne) {
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

const documentNodeMutationInsertMood = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InsertMood'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'mood')),
          type: NamedTypeNode(name: NameNode(value: 'Mood_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'need')),
          type: NamedTypeNode(name: NameNode(value: 'MoodNeed_enum'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'share')),
          type: NamedTypeNode(name: NameNode(value: 'MoodShare_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'day')),
          type: NamedTypeNode(name: NameNode(value: 'date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertMoodsOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'mood'),
                      value: VariableNode(name: NameNode(value: 'mood')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'need'),
                      value: VariableNode(name: NameNode(value: 'need')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'share'),
                      value: VariableNode(name: NameNode(value: 'share')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'day'),
                      value: VariableNode(name: NameNode(value: 'day')),
                    ),
                  ],
                ),
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
                  name: NameNode(value: 'day'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'mood'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'need'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'share'),
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
MutationInsertMood _parserFnMutationInsertMood(Map<String, dynamic> data) =>
    MutationInsertMood.fromJson(data);
typedef OnMutationCompletedMutationInsertMood = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationInsertMood?,
);

class OptionsMutationInsertMood extends graphql.MutationOptions<MutationInsertMood> {
  OptionsMutationInsertMood({
    String? operationName,
    required VariablesMutationInsertMood variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertMood? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationInsertMood? onCompleted,
    graphql.OnMutationUpdate<MutationInsertMood>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertMood',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFnMutationInsertMood(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationInsertMood,
         parserFn: _parserFnMutationInsertMood,
       );

  final OnMutationCompletedMutationInsertMood? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationInsertMood extends graphql.WatchQueryOptions<MutationInsertMood> {
  WatchOptionsMutationInsertMood({
    String? operationName,
    required VariablesMutationInsertMood variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertMood? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertMood',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationInsertMood,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationInsertMood,
       );
}

extension ClientExtensionMutationInsertMood on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationInsertMood>> mutateInsertMood(
    OptionsMutationInsertMood options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationInsertMood> watchMutationInsertMood(
    WatchOptionsMutationInsertMood options,
  ) => this.watchMutation(options);
}

class MutationInsertMoodinsertMoodsOne {
  MutationInsertMoodinsertMoodsOne({
    required this.id,
    required this.day,
    required this.mood,
    this.need,
    required this.share,
    this.$__typename = 'moods',
  });

  factory MutationInsertMoodinsertMoodsOne.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$day = json['day'];
    final l$mood = json['mood'];
    final l$need = json['need'];
    final l$share = json['share'];
    final l$$__typename = json['__typename'];
    return MutationInsertMoodinsertMoodsOne(
      id: (l$id as String),
      day: DateTime.parse((l$day as String)),
      mood: fromJsonEnumMood_enum((l$mood as String)),
      need: l$need == null ? null : fromJsonEnumMoodNeed_enum((l$need as String)),
      share: fromJsonEnumMoodShare_enum((l$share as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime day;

  final EnumMood_enum mood;

  final EnumMoodNeed_enum? need;

  final EnumMoodShare_enum share;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$day = day;
    _resultData['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    final l$mood = mood;
    _resultData['mood'] = toJsonEnumMood_enum(l$mood);
    final l$need = need;
    _resultData['need'] = l$need == null ? null : toJsonEnumMoodNeed_enum(l$need);
    final l$share = share;
    _resultData['share'] = toJsonEnumMoodShare_enum(l$share);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$day = day;
    final l$mood = mood;
    final l$need = need;
    final l$share = share;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$day, l$mood, l$need, l$share, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertMoodinsertMoodsOne || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$day = day;
    final lOther$day = other.day;
    if (l$day != lOther$day) {
      return false;
    }
    final l$mood = mood;
    final lOther$mood = other.mood;
    if (l$mood != lOther$mood) {
      return false;
    }
    final l$need = need;
    final lOther$need = other.need;
    if (l$need != lOther$need) {
      return false;
    }
    final l$share = share;
    final lOther$share = other.share;
    if (l$share != lOther$share) {
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
