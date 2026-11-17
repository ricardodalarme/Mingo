// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationAddRitual {
  factory VariablesMutationAddRitual({
    required String id,
    required String title,
    required EnumRitualCadence_enum cadence,
    int? weekday,
    String? atTime,
    required bool reminder,
    String? coupleId,
    String? plannerId,
  }) => VariablesMutationAddRitual._({
    r'id': id,
    r'title': title,
    r'cadence': cadence,
    if (weekday != null) r'weekday': weekday,
    if (atTime != null) r'atTime': atTime,
    r'reminder': reminder,
    if (coupleId != null) r'coupleId': coupleId,
    if (plannerId != null) r'plannerId': plannerId,
  });

  VariablesMutationAddRitual._(this._$data);

  factory VariablesMutationAddRitual.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    final l$cadence = data['cadence'];
    result$data['cadence'] = fromJsonEnumRitualCadence_enum((l$cadence as String));
    if (data.containsKey('weekday')) {
      final l$weekday = data['weekday'];
      result$data['weekday'] = (l$weekday as int?);
    }
    if (data.containsKey('atTime')) {
      final l$atTime = data['atTime'];
      result$data['atTime'] = (l$atTime as String?);
    }
    final l$reminder = data['reminder'];
    result$data['reminder'] = (l$reminder as bool);
    if (data.containsKey('coupleId')) {
      final l$coupleId = data['coupleId'];
      result$data['coupleId'] = (l$coupleId as String?);
    }
    if (data.containsKey('plannerId')) {
      final l$plannerId = data['plannerId'];
      result$data['plannerId'] = (l$plannerId as String?);
    }
    return VariablesMutationAddRitual._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String get title => (_$data['title'] as String);

  EnumRitualCadence_enum get cadence => (_$data['cadence'] as EnumRitualCadence_enum);

  int? get weekday => (_$data['weekday'] as int?);

  String? get atTime => (_$data['atTime'] as String?);

  bool get reminder => (_$data['reminder'] as bool);

  String? get coupleId => (_$data['coupleId'] as String?);

  String? get plannerId => (_$data['plannerId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$title = title;
    result$data['title'] = l$title;
    final l$cadence = cadence;
    result$data['cadence'] = toJsonEnumRitualCadence_enum(l$cadence);
    if (_$data.containsKey('weekday')) {
      final l$weekday = weekday;
      result$data['weekday'] = l$weekday;
    }
    if (_$data.containsKey('atTime')) {
      final l$atTime = atTime;
      result$data['atTime'] = l$atTime;
    }
    final l$reminder = reminder;
    result$data['reminder'] = l$reminder;
    if (_$data.containsKey('coupleId')) {
      final l$coupleId = coupleId;
      result$data['coupleId'] = l$coupleId;
    }
    if (_$data.containsKey('plannerId')) {
      final l$plannerId = plannerId;
      result$data['plannerId'] = l$plannerId;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationAddRitual || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$cadence = cadence;
    final lOther$cadence = other.cadence;
    if (l$cadence != lOther$cadence) {
      return false;
    }
    final l$weekday = weekday;
    final lOther$weekday = other.weekday;
    if (_$data.containsKey('weekday') != other._$data.containsKey('weekday')) {
      return false;
    }
    if (l$weekday != lOther$weekday) {
      return false;
    }
    final l$atTime = atTime;
    final lOther$atTime = other.atTime;
    if (_$data.containsKey('atTime') != other._$data.containsKey('atTime')) {
      return false;
    }
    if (l$atTime != lOther$atTime) {
      return false;
    }
    final l$reminder = reminder;
    final lOther$reminder = other.reminder;
    if (l$reminder != lOther$reminder) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (_$data.containsKey('coupleId') != other._$data.containsKey('coupleId')) {
      return false;
    }
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$plannerId = plannerId;
    final lOther$plannerId = other.plannerId;
    if (_$data.containsKey('plannerId') != other._$data.containsKey('plannerId')) {
      return false;
    }
    if (l$plannerId != lOther$plannerId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$cadence = cadence;
    final l$weekday = weekday;
    final l$atTime = atTime;
    final l$reminder = reminder;
    final l$coupleId = coupleId;
    final l$plannerId = plannerId;
    return Object.hashAll([
      l$id,
      l$title,
      l$cadence,
      _$data.containsKey('weekday') ? l$weekday : const {},
      _$data.containsKey('atTime') ? l$atTime : const {},
      l$reminder,
      _$data.containsKey('coupleId') ? l$coupleId : const {},
      _$data.containsKey('plannerId') ? l$plannerId : const {},
    ]);
  }
}

class MutationAddRitual {
  MutationAddRitual({this.insertRitualsOne, this.$__typename = 'mutation_root'});

  factory MutationAddRitual.fromJson(Map<String, dynamic> json) {
    final l$insertRitualsOne = json['insertRitualsOne'];
    final l$$__typename = json['__typename'];
    return MutationAddRitual(
      insertRitualsOne: l$insertRitualsOne == null
          ? null
          : MutationAddRitualinsertRitualsOne.fromJson(
              (l$insertRitualsOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationAddRitualinsertRitualsOne? insertRitualsOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertRitualsOne = insertRitualsOne;
    _resultData['insertRitualsOne'] = l$insertRitualsOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertRitualsOne = insertRitualsOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertRitualsOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationAddRitual || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertRitualsOne = insertRitualsOne;
    final lOther$insertRitualsOne = other.insertRitualsOne;
    if (l$insertRitualsOne != lOther$insertRitualsOne) {
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

const documentNodeMutationAddRitual = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddRitual'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'title')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cadence')),
          type: NamedTypeNode(name: NameNode(value: 'RitualCadence_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'weekday')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'atTime')),
          type: NamedTypeNode(name: NameNode(value: 'time'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'reminder')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'coupleId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'plannerId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertRitualsOne'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'object'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'id'),
                      value: VariableNode(name: NameNode(value: 'id')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'title'),
                      value: VariableNode(name: NameNode(value: 'title')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'cadence'),
                      value: VariableNode(name: NameNode(value: 'cadence')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'weekday'),
                      value: VariableNode(name: NameNode(value: 'weekday')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'atTime'),
                      value: VariableNode(name: NameNode(value: 'atTime')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'reminder'),
                      value: VariableNode(name: NameNode(value: 'reminder')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'coupleId'),
                      value: VariableNode(name: NameNode(value: 'coupleId')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'plannerId'),
                      value: VariableNode(name: NameNode(value: 'plannerId')),
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
MutationAddRitual _parserFnMutationAddRitual(Map<String, dynamic> data) =>
    MutationAddRitual.fromJson(data);
typedef OnMutationCompletedMutationAddRitual = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationAddRitual?,
);

class OptionsMutationAddRitual extends graphql.MutationOptions<MutationAddRitual> {
  OptionsMutationAddRitual({
    String? operationName,
    required VariablesMutationAddRitual variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationAddRitual? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationAddRitual? onCompleted,
    graphql.OnMutationUpdate<MutationAddRitual>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'AddRitual',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFnMutationAddRitual(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationAddRitual,
         parserFn: _parserFnMutationAddRitual,
       );

  final OnMutationCompletedMutationAddRitual? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationAddRitual extends graphql.WatchQueryOptions<MutationAddRitual> {
  WatchOptionsMutationAddRitual({
    String? operationName,
    required VariablesMutationAddRitual variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationAddRitual? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'AddRitual',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationAddRitual,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationAddRitual,
       );
}

extension ClientExtensionMutationAddRitual on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationAddRitual>> mutateAddRitual(
    OptionsMutationAddRitual options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationAddRitual> watchMutationAddRitual(
    WatchOptionsMutationAddRitual options,
  ) => this.watchMutation(options);
}

class MutationAddRitualinsertRitualsOne {
  MutationAddRitualinsertRitualsOne({required this.id, this.$__typename = 'rituals'});

  factory MutationAddRitualinsertRitualsOne.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationAddRitualinsertRitualsOne(
      id: (l$id as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationAddRitualinsertRitualsOne || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
