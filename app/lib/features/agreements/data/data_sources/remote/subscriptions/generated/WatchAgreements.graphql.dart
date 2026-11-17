// dart format width=100
import '../../fragments/generated/AgreementFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchAgreements {
  SubscriptionWatchAgreements({required this.agreements});

  factory SubscriptionWatchAgreements.fromJson(Map<String, dynamic> json) {
    final l$agreements = json['agreements'];
    return SubscriptionWatchAgreements(
      agreements: (l$agreements as List<dynamic>)
          .map((e) => FragmentAgreementFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<FragmentAgreementFragment> agreements;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$agreements = agreements;
    _resultData['agreements'] = l$agreements.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$agreements = agreements;
    return Object.hashAll([Object.hashAll(l$agreements.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchAgreements || runtimeType != other.runtimeType) {
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
    return true;
  }
}

const documentNodeSubscriptionWatchAgreements = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchAgreements'),
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
        ],
      ),
    ),
    fragmentDefinitionAgreementFragment,
  ],
);
SubscriptionWatchAgreements _parserFnSubscriptionWatchAgreements(Map<String, dynamic> data) =>
    SubscriptionWatchAgreements.fromJson(data);

class OptionsSubscriptionWatchAgreements
    extends graphql.SubscriptionOptions<SubscriptionWatchAgreements> {
  OptionsSubscriptionWatchAgreements({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchAgreements? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchAgreements',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchAgreements,
         parserFn: _parserFnSubscriptionWatchAgreements,
       );
}

class WatchOptionsSubscriptionWatchAgreements
    extends graphql.WatchQueryOptions<SubscriptionWatchAgreements> {
  WatchOptionsSubscriptionWatchAgreements({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchAgreements? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchAgreements',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchAgreements,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchAgreements,
       );
}

class FetchMoreOptionsSubscriptionWatchAgreements extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchAgreements({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchAgreements);
}

extension ClientExtensionSubscriptionWatchAgreements on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchAgreements>> subscribeWatchAgreements([
    OptionsSubscriptionWatchAgreements? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchAgreements());

  graphql.ObservableQuery<SubscriptionWatchAgreements> watchSubscriptionWatchAgreements([
    WatchOptionsSubscriptionWatchAgreements? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchAgreements());
}
