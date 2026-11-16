// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationAddImportantDate {
  factory VariablesMutationAddImportantDate({
    required String id,
    required String title,
    required EnumImportantDateKind_enum kind,
    required int month,
    required int day,
    int? year,
    required bool yearly,
    required List<int> remindDays,
    required EnumImportantDateOrigin_enum origin,
    String? holidayKey,
    String? coupleId,
  }) => VariablesMutationAddImportantDate._({
    r'id': id,
    r'title': title,
    r'kind': kind,
    r'month': month,
    r'day': day,
    if (year != null) r'year': year,
    r'yearly': yearly,
    r'remindDays': remindDays,
    r'origin': origin,
    if (holidayKey != null) r'holidayKey': holidayKey,
    if (coupleId != null) r'coupleId': coupleId,
  });

  VariablesMutationAddImportantDate._(this._$data);

  factory VariablesMutationAddImportantDate.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    final l$kind = data['kind'];
    result$data['kind'] = fromJsonEnumImportantDateKind_enum((l$kind as String));
    final l$month = data['month'];
    result$data['month'] = (l$month as int);
    final l$day = data['day'];
    result$data['day'] = (l$day as int);
    if (data.containsKey('year')) {
      final l$year = data['year'];
      result$data['year'] = (l$year as int?);
    }
    final l$yearly = data['yearly'];
    result$data['yearly'] = (l$yearly as bool);
    final l$remindDays = data['remindDays'];
    result$data['remindDays'] = (l$remindDays as List<dynamic>).map((e) => (e as int)).toList();
    final l$origin = data['origin'];
    result$data['origin'] = fromJsonEnumImportantDateOrigin_enum((l$origin as String));
    if (data.containsKey('holidayKey')) {
      final l$holidayKey = data['holidayKey'];
      result$data['holidayKey'] = (l$holidayKey as String?);
    }
    if (data.containsKey('coupleId')) {
      final l$coupleId = data['coupleId'];
      result$data['coupleId'] = (l$coupleId as String?);
    }
    return VariablesMutationAddImportantDate._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String get title => (_$data['title'] as String);

  EnumImportantDateKind_enum get kind => (_$data['kind'] as EnumImportantDateKind_enum);

  int get month => (_$data['month'] as int);

  int get day => (_$data['day'] as int);

  int? get year => (_$data['year'] as int?);

  bool get yearly => (_$data['yearly'] as bool);

  List<int> get remindDays => (_$data['remindDays'] as List<int>);

  EnumImportantDateOrigin_enum get origin => (_$data['origin'] as EnumImportantDateOrigin_enum);

  String? get holidayKey => (_$data['holidayKey'] as String?);

  String? get coupleId => (_$data['coupleId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$title = title;
    result$data['title'] = l$title;
    final l$kind = kind;
    result$data['kind'] = toJsonEnumImportantDateKind_enum(l$kind);
    final l$month = month;
    result$data['month'] = l$month;
    final l$day = day;
    result$data['day'] = l$day;
    if (_$data.containsKey('year')) {
      final l$year = year;
      result$data['year'] = l$year;
    }
    final l$yearly = yearly;
    result$data['yearly'] = l$yearly;
    final l$remindDays = remindDays;
    result$data['remindDays'] = l$remindDays.map((e) => e).toList();
    final l$origin = origin;
    result$data['origin'] = toJsonEnumImportantDateOrigin_enum(l$origin);
    if (_$data.containsKey('holidayKey')) {
      final l$holidayKey = holidayKey;
      result$data['holidayKey'] = l$holidayKey;
    }
    if (_$data.containsKey('coupleId')) {
      final l$coupleId = coupleId;
      result$data['coupleId'] = l$coupleId;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationAddImportantDate || runtimeType != other.runtimeType) {
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
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$month = month;
    final lOther$month = other.month;
    if (l$month != lOther$month) {
      return false;
    }
    final l$day = day;
    final lOther$day = other.day;
    if (l$day != lOther$day) {
      return false;
    }
    final l$year = year;
    final lOther$year = other.year;
    if (_$data.containsKey('year') != other._$data.containsKey('year')) {
      return false;
    }
    if (l$year != lOther$year) {
      return false;
    }
    final l$yearly = yearly;
    final lOther$yearly = other.yearly;
    if (l$yearly != lOther$yearly) {
      return false;
    }
    final l$remindDays = remindDays;
    final lOther$remindDays = other.remindDays;
    if (l$remindDays.length != lOther$remindDays.length) {
      return false;
    }
    for (int i = 0; i < l$remindDays.length; i++) {
      final l$remindDays$entry = l$remindDays[i];
      final lOther$remindDays$entry = lOther$remindDays[i];
      if (l$remindDays$entry != lOther$remindDays$entry) {
        return false;
      }
    }
    final l$origin = origin;
    final lOther$origin = other.origin;
    if (l$origin != lOther$origin) {
      return false;
    }
    final l$holidayKey = holidayKey;
    final lOther$holidayKey = other.holidayKey;
    if (_$data.containsKey('holidayKey') != other._$data.containsKey('holidayKey')) {
      return false;
    }
    if (l$holidayKey != lOther$holidayKey) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$kind = kind;
    final l$month = month;
    final l$day = day;
    final l$year = year;
    final l$yearly = yearly;
    final l$remindDays = remindDays;
    final l$origin = origin;
    final l$holidayKey = holidayKey;
    final l$coupleId = coupleId;
    return Object.hashAll([
      l$id,
      l$title,
      l$kind,
      l$month,
      l$day,
      _$data.containsKey('year') ? l$year : const {},
      l$yearly,
      Object.hashAll(l$remindDays.map((v) => v)),
      l$origin,
      _$data.containsKey('holidayKey') ? l$holidayKey : const {},
      _$data.containsKey('coupleId') ? l$coupleId : const {},
    ]);
  }
}

class MutationAddImportantDate {
  MutationAddImportantDate({this.insertImportantDatesOne, this.$__typename = 'mutation_root'});

  factory MutationAddImportantDate.fromJson(Map<String, dynamic> json) {
    final l$insertImportantDatesOne = json['insertImportantDatesOne'];
    final l$$__typename = json['__typename'];
    return MutationAddImportantDate(
      insertImportantDatesOne: l$insertImportantDatesOne == null
          ? null
          : MutationAddImportantDateinsertImportantDatesOne.fromJson(
              (l$insertImportantDatesOne as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationAddImportantDateinsertImportantDatesOne? insertImportantDatesOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertImportantDatesOne = insertImportantDatesOne;
    _resultData['insertImportantDatesOne'] = l$insertImportantDatesOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertImportantDatesOne = insertImportantDatesOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertImportantDatesOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationAddImportantDate || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertImportantDatesOne = insertImportantDatesOne;
    final lOther$insertImportantDatesOne = other.insertImportantDatesOne;
    if (l$insertImportantDatesOne != lOther$insertImportantDatesOne) {
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

const documentNodeMutationAddImportantDate = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddImportantDate'),
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
          variable: VariableNode(name: NameNode(value: 'kind')),
          type: NamedTypeNode(name: NameNode(value: 'ImportantDateKind_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'month')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'day')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'year')),
          type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'yearly')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'remindDays')),
          type: ListTypeNode(
            type: NamedTypeNode(name: NameNode(value: 'smallint'), isNonNull: true),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'origin')),
          type: NamedTypeNode(name: NameNode(value: 'ImportantDateOrigin_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'holidayKey')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'coupleId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertImportantDatesOne'),
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
                      name: NameNode(value: 'kind'),
                      value: VariableNode(name: NameNode(value: 'kind')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'month'),
                      value: VariableNode(name: NameNode(value: 'month')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'day'),
                      value: VariableNode(name: NameNode(value: 'day')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'year'),
                      value: VariableNode(name: NameNode(value: 'year')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'yearly'),
                      value: VariableNode(name: NameNode(value: 'yearly')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'remindDays'),
                      value: VariableNode(name: NameNode(value: 'remindDays')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'origin'),
                      value: VariableNode(name: NameNode(value: 'origin')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'holidayKey'),
                      value: VariableNode(name: NameNode(value: 'holidayKey')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'coupleId'),
                      value: VariableNode(name: NameNode(value: 'coupleId')),
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
MutationAddImportantDate _parserFnMutationAddImportantDate(Map<String, dynamic> data) =>
    MutationAddImportantDate.fromJson(data);
typedef OnMutationCompletedMutationAddImportantDate = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationAddImportantDate?,
);

class OptionsMutationAddImportantDate extends graphql.MutationOptions<MutationAddImportantDate> {
  OptionsMutationAddImportantDate({
    String? operationName,
    required VariablesMutationAddImportantDate variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationAddImportantDate? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationAddImportantDate? onCompleted,
    graphql.OnMutationUpdate<MutationAddImportantDate>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'AddImportantDate',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationAddImportantDate(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationAddImportantDate,
         parserFn: _parserFnMutationAddImportantDate,
       );

  final OnMutationCompletedMutationAddImportantDate? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationAddImportantDate
    extends graphql.WatchQueryOptions<MutationAddImportantDate> {
  WatchOptionsMutationAddImportantDate({
    String? operationName,
    required VariablesMutationAddImportantDate variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationAddImportantDate? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'AddImportantDate',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationAddImportantDate,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationAddImportantDate,
       );
}

extension ClientExtensionMutationAddImportantDate on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationAddImportantDate>> mutateAddImportantDate(
    OptionsMutationAddImportantDate options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationAddImportantDate> watchMutationAddImportantDate(
    WatchOptionsMutationAddImportantDate options,
  ) => this.watchMutation(options);
}

class MutationAddImportantDateinsertImportantDatesOne {
  MutationAddImportantDateinsertImportantDatesOne({
    required this.id,
    this.$__typename = 'importantDates',
  });

  factory MutationAddImportantDateinsertImportantDatesOne.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return MutationAddImportantDateinsertImportantDatesOne(
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
    if (other is! MutationAddImportantDateinsertImportantDatesOne ||
        runtimeType != other.runtimeType) {
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
