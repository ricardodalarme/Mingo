// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationGrantAdultConsent {
  factory VariablesMutationGrantAdultConsent({required String version}) =>
      VariablesMutationGrantAdultConsent._({r'version': version});

  VariablesMutationGrantAdultConsent._(this._$data);

  factory VariablesMutationGrantAdultConsent.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$version = data['version'];
    result$data['version'] = (l$version as String);
    return VariablesMutationGrantAdultConsent._(result$data);
  }

  Map<String, dynamic> _$data;

  String get version => (_$data['version'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$version = version;
    result$data['version'] = l$version;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationGrantAdultConsent || runtimeType != other.runtimeType) {
      return false;
    }
    final l$version = version;
    final lOther$version = other.version;
    if (l$version != lOther$version) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$version = version;
    return Object.hashAll([l$version]);
  }
}

class MutationGrantAdultConsent {
  MutationGrantAdultConsent({this.insertConsents, this.$__typename = 'mutation_root'});

  factory MutationGrantAdultConsent.fromJson(Map<String, dynamic> json) {
    final l$insertConsents = json['insertConsents'];
    final l$$__typename = json['__typename'];
    return MutationGrantAdultConsent(
      insertConsents: l$insertConsents == null
          ? null
          : MutationGrantAdultConsentinsertConsents.fromJson(
              (l$insertConsents as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationGrantAdultConsentinsertConsents? insertConsents;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertConsents = insertConsents;
    _resultData['insertConsents'] = l$insertConsents?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertConsents = insertConsents;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertConsents, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationGrantAdultConsent || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertConsents = insertConsents;
    final lOther$insertConsents = other.insertConsents;
    if (l$insertConsents != lOther$insertConsents) {
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

const documentNodeMutationGrantAdultConsent = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'GrantAdultConsent'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'version')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertConsents'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'objects'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'kind'),
                          value: EnumValueNode(name: NameNode(value: 'adult')),
                        ),
                        ObjectFieldNode(
                          name: NameNode(value: 'granted'),
                          value: BooleanValueNode(value: true),
                        ),
                        ObjectFieldNode(
                          name: NameNode(value: 'version'),
                          value: VariableNode(name: NameNode(value: 'version')),
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
MutationGrantAdultConsent _parserFnMutationGrantAdultConsent(Map<String, dynamic> data) =>
    MutationGrantAdultConsent.fromJson(data);
typedef OnMutationCompletedMutationGrantAdultConsent = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationGrantAdultConsent?,
);

class OptionsMutationGrantAdultConsent extends graphql.MutationOptions<MutationGrantAdultConsent> {
  OptionsMutationGrantAdultConsent({
    String? operationName,
    required VariablesMutationGrantAdultConsent variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationGrantAdultConsent? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationGrantAdultConsent? onCompleted,
    graphql.OnMutationUpdate<MutationGrantAdultConsent>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'GrantAdultConsent',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationGrantAdultConsent(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationGrantAdultConsent,
         parserFn: _parserFnMutationGrantAdultConsent,
       );

  final OnMutationCompletedMutationGrantAdultConsent? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationGrantAdultConsent
    extends graphql.WatchQueryOptions<MutationGrantAdultConsent> {
  WatchOptionsMutationGrantAdultConsent({
    String? operationName,
    required VariablesMutationGrantAdultConsent variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationGrantAdultConsent? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'GrantAdultConsent',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationGrantAdultConsent,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationGrantAdultConsent,
       );
}

extension ClientExtensionMutationGrantAdultConsent on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationGrantAdultConsent>> mutateGrantAdultConsent(
    OptionsMutationGrantAdultConsent options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationGrantAdultConsent> watchMutationGrantAdultConsent(
    WatchOptionsMutationGrantAdultConsent options,
  ) => this.watchMutation(options);
}

class MutationGrantAdultConsentinsertConsents {
  MutationGrantAdultConsentinsertConsents({
    required this.affected_rows,
    this.$__typename = 'consents_mutation_response',
  });

  factory MutationGrantAdultConsentinsertConsents.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationGrantAdultConsentinsertConsents(
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
    if (other is! MutationGrantAdultConsentinsertConsents || runtimeType != other.runtimeType) {
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
