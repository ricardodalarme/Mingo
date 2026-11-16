// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMyPlus {
  factory VariablesQueryMyPlus({required String userId}) =>
      VariablesQueryMyPlus._({r'userId': userId});

  VariablesQueryMyPlus._(this._$data);

  factory VariablesQueryMyPlus.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryMyPlus._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryMyPlus || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    return Object.hashAll([l$userId]);
  }
}

class QueryMyPlus {
  QueryMyPlus({required this.plusStates, this.$__typename = 'query_root'});

  factory QueryMyPlus.fromJson(Map<String, dynamic> json) {
    final l$plusStates = json['plusStates'];
    final l$$__typename = json['__typename'];
    return QueryMyPlus(
      plusStates: (l$plusStates as List<dynamic>)
          .map((e) => QueryMyPlusplusStates.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMyPlusplusStates> plusStates;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$plusStates = plusStates;
    _resultData['plusStates'] = l$plusStates.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$plusStates = plusStates;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$plusStates.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyPlus || runtimeType != other.runtimeType) {
      return false;
    }
    final l$plusStates = plusStates;
    final lOther$plusStates = other.plusStates;
    if (l$plusStates.length != lOther$plusStates.length) {
      return false;
    }
    for (int i = 0; i < l$plusStates.length; i++) {
      final l$plusStates$entry = l$plusStates[i];
      final lOther$plusStates$entry = lOther$plusStates[i];
      if (l$plusStates$entry != lOther$plusStates$entry) {
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

const documentNodeQueryMyPlus = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyPlus'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'plusStates'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'userId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'userId')),
                          ),
                        ],
                      ),
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
                  name: NameNode(value: 'hasPlus'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'paidByPartner'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'slipsLeftThisMonth'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'cardsLeftThisMonth'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'entitlement'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'plan'),
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
QueryMyPlus _parserFnQueryMyPlus(Map<String, dynamic> data) => QueryMyPlus.fromJson(data);
typedef OnQueryCompleteQueryMyPlus = FutureOr<void> Function(Map<String, dynamic>?, QueryMyPlus?);

class OptionsQueryMyPlus extends graphql.QueryOptions<QueryMyPlus> {
  OptionsQueryMyPlus({
    String? operationName,
    required VariablesQueryMyPlus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyPlus? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyPlus? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyPlus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyPlus(data)),
         onError: onError,
         document: documentNodeQueryMyPlus,
         parserFn: _parserFnQueryMyPlus,
       );

  final OnQueryCompleteQueryMyPlus? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyPlus extends graphql.WatchQueryOptions<QueryMyPlus> {
  WatchOptionsQueryMyPlus({
    String? operationName,
    required VariablesQueryMyPlus variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyPlus? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyPlus',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyPlus,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyPlus,
       );
}

class FetchMoreOptionsQueryMyPlus extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyPlus({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMyPlus variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMyPlus,
       );
}

extension ClientExtensionQueryMyPlus on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyPlus>> queryMyPlus(OptionsQueryMyPlus options) async =>
      await this.query(options);

  graphql.ObservableQuery<QueryMyPlus> watchQueryMyPlus(WatchOptionsQueryMyPlus options) =>
      this.watchQuery(options);

  void writeQueryMyPlus({
    required QueryMyPlus data,
    required VariablesQueryMyPlus variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMyPlus),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyPlus? readQueryMyPlus({required VariablesQueryMyPlus variables, bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMyPlus),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyPlus.fromJson(result);
  }
}

class QueryMyPlusplusStates {
  QueryMyPlusplusStates({
    this.hasPlus,
    this.paidByPartner,
    this.slipsLeftThisMonth,
    this.cardsLeftThisMonth,
    this.entitlement,
    this.$__typename = 'plusStates',
  });

  factory QueryMyPlusplusStates.fromJson(Map<String, dynamic> json) {
    final l$hasPlus = json['hasPlus'];
    final l$paidByPartner = json['paidByPartner'];
    final l$slipsLeftThisMonth = json['slipsLeftThisMonth'];
    final l$cardsLeftThisMonth = json['cardsLeftThisMonth'];
    final l$entitlement = json['entitlement'];
    final l$$__typename = json['__typename'];
    return QueryMyPlusplusStates(
      hasPlus: (l$hasPlus as bool?),
      paidByPartner: (l$paidByPartner as bool?),
      slipsLeftThisMonth: (l$slipsLeftThisMonth as int?),
      cardsLeftThisMonth: (l$cardsLeftThisMonth as int?),
      entitlement: l$entitlement == null
          ? null
          : QueryMyPlusplusStatesentitlement.fromJson((l$entitlement as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final bool? hasPlus;

  final bool? paidByPartner;

  final int? slipsLeftThisMonth;

  final int? cardsLeftThisMonth;

  final QueryMyPlusplusStatesentitlement? entitlement;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$hasPlus = hasPlus;
    _resultData['hasPlus'] = l$hasPlus;
    final l$paidByPartner = paidByPartner;
    _resultData['paidByPartner'] = l$paidByPartner;
    final l$slipsLeftThisMonth = slipsLeftThisMonth;
    _resultData['slipsLeftThisMonth'] = l$slipsLeftThisMonth;
    final l$cardsLeftThisMonth = cardsLeftThisMonth;
    _resultData['cardsLeftThisMonth'] = l$cardsLeftThisMonth;
    final l$entitlement = entitlement;
    _resultData['entitlement'] = l$entitlement?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$hasPlus = hasPlus;
    final l$paidByPartner = paidByPartner;
    final l$slipsLeftThisMonth = slipsLeftThisMonth;
    final l$cardsLeftThisMonth = cardsLeftThisMonth;
    final l$entitlement = entitlement;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$hasPlus,
      l$paidByPartner,
      l$slipsLeftThisMonth,
      l$cardsLeftThisMonth,
      l$entitlement,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyPlusplusStates || runtimeType != other.runtimeType) {
      return false;
    }
    final l$hasPlus = hasPlus;
    final lOther$hasPlus = other.hasPlus;
    if (l$hasPlus != lOther$hasPlus) {
      return false;
    }
    final l$paidByPartner = paidByPartner;
    final lOther$paidByPartner = other.paidByPartner;
    if (l$paidByPartner != lOther$paidByPartner) {
      return false;
    }
    final l$slipsLeftThisMonth = slipsLeftThisMonth;
    final lOther$slipsLeftThisMonth = other.slipsLeftThisMonth;
    if (l$slipsLeftThisMonth != lOther$slipsLeftThisMonth) {
      return false;
    }
    final l$cardsLeftThisMonth = cardsLeftThisMonth;
    final lOther$cardsLeftThisMonth = other.cardsLeftThisMonth;
    if (l$cardsLeftThisMonth != lOther$cardsLeftThisMonth) {
      return false;
    }
    final l$entitlement = entitlement;
    final lOther$entitlement = other.entitlement;
    if (l$entitlement != lOther$entitlement) {
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

class QueryMyPlusplusStatesentitlement {
  QueryMyPlusplusStatesentitlement({
    required this.plan,
    required this.status,
    this.$__typename = 'entitlements',
  });

  factory QueryMyPlusplusStatesentitlement.fromJson(Map<String, dynamic> json) {
    final l$plan = json['plan'];
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return QueryMyPlusplusStatesentitlement(
      plan: fromJsonEnumEntitlementPlan_enum((l$plan as String)),
      status: fromJsonEnumEntitlementStatus_enum((l$status as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumEntitlementPlan_enum plan;

  final EnumEntitlementStatus_enum status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$plan = plan;
    _resultData['plan'] = toJsonEnumEntitlementPlan_enum(l$plan);
    final l$status = status;
    _resultData['status'] = toJsonEnumEntitlementStatus_enum(l$status);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$plan = plan;
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([l$plan, l$status, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyPlusplusStatesentitlement || runtimeType != other.runtimeType) {
      return false;
    }
    final l$plan = plan;
    final lOther$plan = other.plan;
    if (l$plan != lOther$plan) {
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
