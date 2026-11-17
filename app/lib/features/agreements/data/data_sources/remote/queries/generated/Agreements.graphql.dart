// dart format width=100
import '../../fragments/generated/AgreementFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryAgreements {
  QueryAgreements({required this.agreements, this.$__typename = 'query_root'});

  factory QueryAgreements.fromJson(Map<String, dynamic> json) {
    final l$agreements = json['agreements'];
    final l$$__typename = json['__typename'];
    return QueryAgreements(
      agreements: (l$agreements as List<dynamic>)
          .map((e) => FragmentAgreementFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<FragmentAgreementFragment> agreements;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$agreements = agreements;
    _resultData['agreements'] = l$agreements.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$agreements = agreements;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$agreements.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryAgreements || runtimeType != other.runtimeType) {
      return false;
    }
    final l$agreements = agreements;
    final lOther$agreements = other.agreements;
    if (l$agreements.length != lOther$agreements.length) {
      return false;
    }
    for (int i = 0; i < l$agreements.length; i++) {
      final l$agreements$entry = l$agreements[i];
      final lOther$agreements$entry = lOther$agreements[i];
      if (l$agreements$entry != lOther$agreements$entry) {
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

const documentNodeQueryAgreements = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Agreements'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'agreements'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'archivedAt'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_is_null'),
                            value: BooleanValueNode(value: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'createdAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '100'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'AgreementFragment'),
                  directives: [],
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
    fragmentDefinitionAgreementFragment,
  ],
);
QueryAgreements _parserFnQueryAgreements(Map<String, dynamic> data) =>
    QueryAgreements.fromJson(data);
typedef OnQueryCompleteQueryAgreements = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryAgreements?,
);

class OptionsQueryAgreements extends graphql.QueryOptions<QueryAgreements> {
  OptionsQueryAgreements({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryAgreements? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryAgreements? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'Agreements',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryAgreements(data)),
         onError: onError,
         document: documentNodeQueryAgreements,
         parserFn: _parserFnQueryAgreements,
       );

  final OnQueryCompleteQueryAgreements? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryAgreements extends graphql.WatchQueryOptions<QueryAgreements> {
  WatchOptionsQueryAgreements({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryAgreements? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'Agreements',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryAgreements,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryAgreements,
       );
}

class FetchMoreOptionsQueryAgreements extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryAgreements({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryAgreements);
}

extension ClientExtensionQueryAgreements on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryAgreements>> queryAgreements([
    OptionsQueryAgreements? options,
  ]) async => await this.query(options ?? OptionsQueryAgreements());

  graphql.ObservableQuery<QueryAgreements> watchQueryAgreements([
    WatchOptionsQueryAgreements? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryAgreements());

  void writeQueryAgreements({required QueryAgreements data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryAgreements)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryAgreements? readQueryAgreements({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryAgreements)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryAgreements.fromJson(result);
  }
}
