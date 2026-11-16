// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationRecordTemperature {
  factory VariablesMutationRecordTemperature({required EnumTemperatureLevel_enum level}) =>
      VariablesMutationRecordTemperature._({r'level': level});

  VariablesMutationRecordTemperature._(this._$data);

  factory VariablesMutationRecordTemperature.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$level = data['level'];
    result$data['level'] = fromJsonEnumTemperatureLevel_enum((l$level as String));
    return VariablesMutationRecordTemperature._(result$data);
  }

  Map<String, dynamic> _$data;

  EnumTemperatureLevel_enum get level => (_$data['level'] as EnumTemperatureLevel_enum);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$level = level;
    result$data['level'] = toJsonEnumTemperatureLevel_enum(l$level);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationRecordTemperature || runtimeType != other.runtimeType) {
      return false;
    }
    final l$level = level;
    final lOther$level = other.level;
    if (l$level != lOther$level) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$level = level;
    return Object.hashAll([l$level]);
  }
}

class MutationRecordTemperature {
  MutationRecordTemperature({this.insertTemperatureChecks, this.$__typename = 'mutation_root'});

  factory MutationRecordTemperature.fromJson(Map<String, dynamic> json) {
    final l$insertTemperatureChecks = json['insertTemperatureChecks'];
    final l$$__typename = json['__typename'];
    return MutationRecordTemperature(
      insertTemperatureChecks: l$insertTemperatureChecks == null
          ? null
          : MutationRecordTemperatureinsertTemperatureChecks.fromJson(
              (l$insertTemperatureChecks as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationRecordTemperatureinsertTemperatureChecks? insertTemperatureChecks;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertTemperatureChecks = insertTemperatureChecks;
    _resultData['insertTemperatureChecks'] = l$insertTemperatureChecks?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertTemperatureChecks = insertTemperatureChecks;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertTemperatureChecks, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationRecordTemperature || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertTemperatureChecks = insertTemperatureChecks;
    final lOther$insertTemperatureChecks = other.insertTemperatureChecks;
    if (l$insertTemperatureChecks != lOther$insertTemperatureChecks) {
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

const documentNodeMutationRecordTemperature = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RecordTemperature'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'level')),
          type: NamedTypeNode(name: NameNode(value: 'TemperatureLevel_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertTemperatureChecks'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'objects'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'level'),
                          value: VariableNode(name: NameNode(value: 'level')),
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
MutationRecordTemperature _parserFnMutationRecordTemperature(Map<String, dynamic> data) =>
    MutationRecordTemperature.fromJson(data);
typedef OnMutationCompletedMutationRecordTemperature = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationRecordTemperature?,
);

class OptionsMutationRecordTemperature extends graphql.MutationOptions<MutationRecordTemperature> {
  OptionsMutationRecordTemperature({
    String? operationName,
    required VariablesMutationRecordTemperature variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRecordTemperature? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationRecordTemperature? onCompleted,
    graphql.OnMutationUpdate<MutationRecordTemperature>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'RecordTemperature',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationRecordTemperature(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationRecordTemperature,
         parserFn: _parserFnMutationRecordTemperature,
       );

  final OnMutationCompletedMutationRecordTemperature? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationRecordTemperature
    extends graphql.WatchQueryOptions<MutationRecordTemperature> {
  WatchOptionsMutationRecordTemperature({
    String? operationName,
    required VariablesMutationRecordTemperature variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationRecordTemperature? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'RecordTemperature',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationRecordTemperature,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationRecordTemperature,
       );
}

extension ClientExtensionMutationRecordTemperature on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationRecordTemperature>> mutateRecordTemperature(
    OptionsMutationRecordTemperature options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationRecordTemperature> watchMutationRecordTemperature(
    WatchOptionsMutationRecordTemperature options,
  ) => this.watchMutation(options);
}

class MutationRecordTemperatureinsertTemperatureChecks {
  MutationRecordTemperatureinsertTemperatureChecks({
    required this.affected_rows,
    this.$__typename = 'temperatureChecks_mutation_response',
  });

  factory MutationRecordTemperatureinsertTemperatureChecks.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationRecordTemperatureinsertTemperatureChecks(
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
    if (other is! MutationRecordTemperatureinsertTemperatureChecks ||
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
