// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpdateMood {
  factory VariablesMutationUpdateMood({
    required String id,
    required Inputmoods_set_input changes,
  }) => VariablesMutationUpdateMood._({r'id': id, r'changes': changes});

  VariablesMutationUpdateMood._(this._$data);

  factory VariablesMutationUpdateMood.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$changes = data['changes'];
    result$data['changes'] = Inputmoods_set_input.fromJson((l$changes as Map<String, dynamic>));
    return VariablesMutationUpdateMood._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Inputmoods_set_input get changes => (_$data['changes'] as Inputmoods_set_input);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$changes = changes;
    result$data['changes'] = l$changes.toJson();
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationUpdateMood || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$changes = changes;
    final lOther$changes = other.changes;
    if (l$changes != lOther$changes) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$changes = changes;
    return Object.hashAll([l$id, l$changes]);
  }
}

class MutationUpdateMood {
  MutationUpdateMood({this.updateMoodsByPk, this.$__typename = 'mutation_root'});

  factory MutationUpdateMood.fromJson(Map<String, dynamic> json) {
    final l$updateMoodsByPk = json['updateMoodsByPk'];
    final l$$__typename = json['__typename'];
    return MutationUpdateMood(
      updateMoodsByPk: l$updateMoodsByPk == null
          ? null
          : MutationUpdateMoodupdateMoodsByPk.fromJson((l$updateMoodsByPk as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpdateMoodupdateMoodsByPk? updateMoodsByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateMoodsByPk = updateMoodsByPk;
    _resultData['updateMoodsByPk'] = l$updateMoodsByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateMoodsByPk = updateMoodsByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateMoodsByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpdateMood || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateMoodsByPk = updateMoodsByPk;
    final lOther$updateMoodsByPk = other.updateMoodsByPk;
    if (l$updateMoodsByPk != lOther$updateMoodsByPk) {
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

const documentNodeMutationUpdateMood = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateMood'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'changes')),
          type: NamedTypeNode(name: NameNode(value: 'moods_set_input'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateMoodsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'pk_columns'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: VariableNode(name: NameNode(value: 'id')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: VariableNode(name: NameNode(value: 'changes')),
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
MutationUpdateMood _parserFnMutationUpdateMood(Map<String, dynamic> data) =>
    MutationUpdateMood.fromJson(data);
typedef OnMutationCompletedMutationUpdateMood = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpdateMood?,
);

class OptionsMutationUpdateMood extends graphql.MutationOptions<MutationUpdateMood> {
  OptionsMutationUpdateMood({
    String? operationName,
    required VariablesMutationUpdateMood variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateMood? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpdateMood? onCompleted,
    graphql.OnMutationUpdate<MutationUpdateMood>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateMood',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFnMutationUpdateMood(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateMood,
         parserFn: _parserFnMutationUpdateMood,
       );

  final OnMutationCompletedMutationUpdateMood? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpdateMood extends graphql.WatchQueryOptions<MutationUpdateMood> {
  WatchOptionsMutationUpdateMood({
    String? operationName,
    required VariablesMutationUpdateMood variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpdateMood? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpdateMood',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpdateMood,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpdateMood,
       );
}

extension ClientExtensionMutationUpdateMood on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpdateMood>> mutateUpdateMood(
    OptionsMutationUpdateMood options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpdateMood> watchMutationUpdateMood(
    WatchOptionsMutationUpdateMood options,
  ) => this.watchMutation(options);
}

class MutationUpdateMoodupdateMoodsByPk {
  MutationUpdateMoodupdateMoodsByPk({
    required this.id,
    required this.day,
    required this.mood,
    this.need,
    required this.share,
    this.$__typename = 'moods',
  });

  factory MutationUpdateMoodupdateMoodsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$day = json['day'];
    final l$mood = json['mood'];
    final l$need = json['need'];
    final l$share = json['share'];
    final l$$__typename = json['__typename'];
    return MutationUpdateMoodupdateMoodsByPk(
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
    if (other is! MutationUpdateMoodupdateMoodsByPk || runtimeType != other.runtimeType) {
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
