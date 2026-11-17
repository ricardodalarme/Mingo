// dart format width=100
import '../../fragments/generated/SpiceChallengeFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchSpiceChallenge {
  SubscriptionWatchSpiceChallenge({required this.spiceChallenges});

  factory SubscriptionWatchSpiceChallenge.fromJson(Map<String, dynamic> json) {
    final l$spiceChallenges = json['spiceChallenges'];
    return SubscriptionWatchSpiceChallenge(
      spiceChallenges: (l$spiceChallenges as List<dynamic>)
          .map((e) => FragmentSpiceChallengeFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<FragmentSpiceChallengeFragment> spiceChallenges;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceChallenges = spiceChallenges;
    _resultData['spiceChallenges'] = l$spiceChallenges.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceChallenges = spiceChallenges;
    return Object.hashAll([Object.hashAll(l$spiceChallenges.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchSpiceChallenge || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceChallenges = spiceChallenges;
    final lOther$spiceChallenges = other.spiceChallenges;
    if (l$spiceChallenges.length != lOther$spiceChallenges.length) {
      return false;
    }
    for (int i = 0; i < l$spiceChallenges.length; i++) {
      final l$spiceChallenges$entry = l$spiceChallenges[i];
      final lOther$spiceChallenges$entry = lOther$spiceChallenges[i];
      if (l$spiceChallenges$entry != lOther$spiceChallenges$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchSpiceChallenge = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchSpiceChallenge'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceChallenges'),
            alias: null,
            arguments: [
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
                value: IntValueNode(value: '1'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'SpiceChallengeFragment'),
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
    fragmentDefinitionSpiceChallengeFragment,
  ],
);
SubscriptionWatchSpiceChallenge _parserFnSubscriptionWatchSpiceChallenge(
  Map<String, dynamic> data,
) => SubscriptionWatchSpiceChallenge.fromJson(data);

class OptionsSubscriptionWatchSpiceChallenge
    extends graphql.SubscriptionOptions<SubscriptionWatchSpiceChallenge> {
  OptionsSubscriptionWatchSpiceChallenge({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchSpiceChallenge? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchSpiceChallenge',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchSpiceChallenge,
         parserFn: _parserFnSubscriptionWatchSpiceChallenge,
       );
}

class WatchOptionsSubscriptionWatchSpiceChallenge
    extends graphql.WatchQueryOptions<SubscriptionWatchSpiceChallenge> {
  WatchOptionsSubscriptionWatchSpiceChallenge({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchSpiceChallenge? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchSpiceChallenge',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchSpiceChallenge,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchSpiceChallenge,
       );
}

class FetchMoreOptionsSubscriptionWatchSpiceChallenge extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchSpiceChallenge({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchSpiceChallenge);
}

extension ClientExtensionSubscriptionWatchSpiceChallenge on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchSpiceChallenge>> subscribeWatchSpiceChallenge([
    OptionsSubscriptionWatchSpiceChallenge? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchSpiceChallenge());

  graphql.ObservableQuery<SubscriptionWatchSpiceChallenge> watchSubscriptionWatchSpiceChallenge([
    WatchOptionsSubscriptionWatchSpiceChallenge? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchSpiceChallenge());
}
