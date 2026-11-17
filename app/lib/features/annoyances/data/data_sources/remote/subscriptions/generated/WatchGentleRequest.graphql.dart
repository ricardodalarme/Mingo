// dart format width=100
import '../../fragments/generated/GentleRequestFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesSubscriptionWatchGentleRequest {
  factory VariablesSubscriptionWatchGentleRequest({required String id}) =>
      VariablesSubscriptionWatchGentleRequest._({r'id': id});

  VariablesSubscriptionWatchGentleRequest._(this._$data);

  factory VariablesSubscriptionWatchGentleRequest.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesSubscriptionWatchGentleRequest._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesSubscriptionWatchGentleRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

class SubscriptionWatchGentleRequest {
  SubscriptionWatchGentleRequest({this.gentleRequestsByPk});

  factory SubscriptionWatchGentleRequest.fromJson(Map<String, dynamic> json) {
    final l$gentleRequestsByPk = json['gentleRequestsByPk'];
    return SubscriptionWatchGentleRequest(
      gentleRequestsByPk: l$gentleRequestsByPk == null
          ? null
          : FragmentGentleRequestFragment.fromJson((l$gentleRequestsByPk as Map<String, dynamic>)),
    );
  }

  final FragmentGentleRequestFragment? gentleRequestsByPk;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$gentleRequestsByPk = gentleRequestsByPk;
    _resultData['gentleRequestsByPk'] = l$gentleRequestsByPk?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$gentleRequestsByPk = gentleRequestsByPk;
    return Object.hashAll([l$gentleRequestsByPk]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchGentleRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$gentleRequestsByPk = gentleRequestsByPk;
    final lOther$gentleRequestsByPk = other.gentleRequestsByPk;
    if (l$gentleRequestsByPk != lOther$gentleRequestsByPk) {
      return false;
    }
    return true;
  }
}

const documentNodeSubscriptionWatchGentleRequest = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchGentleRequest'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'gentleRequestsByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'GentleRequestFragment'),
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
    fragmentDefinitionGentleRequestFragment,
  ],
);
SubscriptionWatchGentleRequest _parserFnSubscriptionWatchGentleRequest(Map<String, dynamic> data) =>
    SubscriptionWatchGentleRequest.fromJson(data);

class OptionsSubscriptionWatchGentleRequest
    extends graphql.SubscriptionOptions<SubscriptionWatchGentleRequest> {
  OptionsSubscriptionWatchGentleRequest({
    String? operationName,
    required VariablesSubscriptionWatchGentleRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchGentleRequest? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'WatchGentleRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchGentleRequest,
         parserFn: _parserFnSubscriptionWatchGentleRequest,
       );
}

class WatchOptionsSubscriptionWatchGentleRequest
    extends graphql.WatchQueryOptions<SubscriptionWatchGentleRequest> {
  WatchOptionsSubscriptionWatchGentleRequest({
    String? operationName,
    required VariablesSubscriptionWatchGentleRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchGentleRequest? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'WatchGentleRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchGentleRequest,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchGentleRequest,
       );
}

class FetchMoreOptionsSubscriptionWatchGentleRequest extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchGentleRequest({
    required graphql.UpdateQuery updateQuery,
    required VariablesSubscriptionWatchGentleRequest variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeSubscriptionWatchGentleRequest,
       );
}

extension ClientExtensionSubscriptionWatchGentleRequest on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchGentleRequest>> subscribeWatchGentleRequest(
    OptionsSubscriptionWatchGentleRequest options,
  ) => this.subscribe(options);

  graphql.ObservableQuery<SubscriptionWatchGentleRequest> watchSubscriptionWatchGentleRequest(
    WatchOptionsSubscriptionWatchGentleRequest options,
  ) => this.watchQuery(options);
}
