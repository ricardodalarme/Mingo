// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationMarkSensitiveDay {
  factory VariablesMutationMarkSensitiveDay({required DateTime day}) =>
      VariablesMutationMarkSensitiveDay._({r'day': day});

  VariablesMutationMarkSensitiveDay._(this._$data);

  factory VariablesMutationMarkSensitiveDay.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$day = data['day'];
    result$data['day'] = DateTime.parse((l$day as String));
    return VariablesMutationMarkSensitiveDay._(result$data);
  }

  Map<String, dynamic> _$data;

  DateTime get day => (_$data['day'] as DateTime);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$day = day;
    result$data['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationMarkSensitiveDay || runtimeType != other.runtimeType) {
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
    final l$day = day;
    return Object.hashAll([l$day]);
  }
}

class MutationMarkSensitiveDay {
  MutationMarkSensitiveDay({this.insertIntoCycleDaysCollection, this.$__typename = 'Mutation'});

  factory MutationMarkSensitiveDay.fromJson(Map<String, dynamic> json) {
    final l$insertIntoCycleDaysCollection = json['insertIntoCycleDaysCollection'];
    final l$$__typename = json['__typename'];
    return MutationMarkSensitiveDay(
      insertIntoCycleDaysCollection: l$insertIntoCycleDaysCollection == null
          ? null
          : MutationMarkSensitiveDayinsertIntoCycleDaysCollection.fromJson(
              (l$insertIntoCycleDaysCollection as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationMarkSensitiveDayinsertIntoCycleDaysCollection? insertIntoCycleDaysCollection;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertIntoCycleDaysCollection = insertIntoCycleDaysCollection;
    _resultData['insertIntoCycleDaysCollection'] = l$insertIntoCycleDaysCollection?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertIntoCycleDaysCollection = insertIntoCycleDaysCollection;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertIntoCycleDaysCollection, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationMarkSensitiveDay || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertIntoCycleDaysCollection = insertIntoCycleDaysCollection;
    final lOther$insertIntoCycleDaysCollection = other.insertIntoCycleDaysCollection;
    if (l$insertIntoCycleDaysCollection != lOther$insertIntoCycleDaysCollection) {
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

const documentNodeMutationMarkSensitiveDay = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'MarkSensitiveDay'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'day')),
          type: NamedTypeNode(name: NameNode(value: 'Date'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertIntoCycleDaysCollection'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'objects'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'day'),
                          value: VariableNode(name: NameNode(value: 'day')),
                        ),
                        ObjectFieldNode(
                          name: NameNode(value: 'kind'),
                          value: EnumValueNode(name: NameNode(value: 'heavy')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'records'),
                  alias: null,
                  arguments: [],
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
MutationMarkSensitiveDay _parserFnMutationMarkSensitiveDay(Map<String, dynamic> data) =>
    MutationMarkSensitiveDay.fromJson(data);
typedef OnMutationCompletedMutationMarkSensitiveDay = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationMarkSensitiveDay?,
);

class OptionsMutationMarkSensitiveDay extends graphql.MutationOptions<MutationMarkSensitiveDay> {
  OptionsMutationMarkSensitiveDay({
    String? operationName,
    required VariablesMutationMarkSensitiveDay variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationMarkSensitiveDay? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationMarkSensitiveDay? onCompleted,
    graphql.OnMutationUpdate<MutationMarkSensitiveDay>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MarkSensitiveDay',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationMarkSensitiveDay(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationMarkSensitiveDay,
         parserFn: _parserFnMutationMarkSensitiveDay,
       );

  final OnMutationCompletedMutationMarkSensitiveDay? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationMarkSensitiveDay
    extends graphql.WatchQueryOptions<MutationMarkSensitiveDay> {
  WatchOptionsMutationMarkSensitiveDay({
    String? operationName,
    required VariablesMutationMarkSensitiveDay variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationMarkSensitiveDay? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MarkSensitiveDay',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationMarkSensitiveDay,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationMarkSensitiveDay,
       );
}

extension ClientExtensionMutationMarkSensitiveDay on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationMarkSensitiveDay>> mutateMarkSensitiveDay(
    OptionsMutationMarkSensitiveDay options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationMarkSensitiveDay> watchMutationMarkSensitiveDay(
    WatchOptionsMutationMarkSensitiveDay options,
  ) => this.watchMutation(options);
}

class MutationMarkSensitiveDayinsertIntoCycleDaysCollection {
  MutationMarkSensitiveDayinsertIntoCycleDaysCollection({
    required this.records,
    this.$__typename = 'CycleDaysInsertResponse',
  });

  factory MutationMarkSensitiveDayinsertIntoCycleDaysCollection.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$records = json['records'];
    final l$$__typename = json['__typename'];
    return MutationMarkSensitiveDayinsertIntoCycleDaysCollection(
      records: (l$records as List<dynamic>)
          .map(
            (e) => MutationMarkSensitiveDayinsertIntoCycleDaysCollectionrecords.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationMarkSensitiveDayinsertIntoCycleDaysCollectionrecords> records;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$records = records;
    _resultData['records'] = l$records.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$records = records;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$records.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationMarkSensitiveDayinsertIntoCycleDaysCollection ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$records = records;
    final lOther$records = other.records;
    if (l$records.length != lOther$records.length) {
      return false;
    }
    for (int i = 0; i < l$records.length; i++) {
      final l$records$entry = l$records[i];
      final lOther$records$entry = lOther$records[i];
      if (l$records$entry != lOther$records$entry) {
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

class MutationMarkSensitiveDayinsertIntoCycleDaysCollectionrecords {
  MutationMarkSensitiveDayinsertIntoCycleDaysCollectionrecords({
    required this.id,
    required this.day,
    this.$__typename = 'CycleDays',
  });

  factory MutationMarkSensitiveDayinsertIntoCycleDaysCollectionrecords.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$day = json['day'];
    final l$$__typename = json['__typename'];
    return MutationMarkSensitiveDayinsertIntoCycleDaysCollectionrecords(
      id: (l$id as String),
      day: DateTime.parse((l$day as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime day;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$day = day;
    _resultData['day'] = ((v) => v.toIso8601String().substring(0, 10))(l$day);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$day = day;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$day, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationMarkSensitiveDayinsertIntoCycleDaysCollectionrecords ||
        runtimeType != other.runtimeType) {
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
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}
