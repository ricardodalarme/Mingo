// dart format width=100
import '../../fragments/generated/SpiceChallengeFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSpiceChallengeAct {
  factory VariablesMutationSpiceChallengeAct({required String action}) =>
      VariablesMutationSpiceChallengeAct._({r'action': action});

  VariablesMutationSpiceChallengeAct._(this._$data);

  factory VariablesMutationSpiceChallengeAct.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$action = data['action'];
    result$data['action'] = (l$action as String);
    return VariablesMutationSpiceChallengeAct._(result$data);
  }

  Map<String, dynamic> _$data;

  String get action => (_$data['action'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$action = action;
    result$data['action'] = l$action;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSpiceChallengeAct || runtimeType != other.runtimeType) {
      return false;
    }
    final l$action = action;
    final lOther$action = other.action;
    if (l$action != lOther$action) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$action = action;
    return Object.hashAll([l$action]);
  }
}

class MutationSpiceChallengeAct {
  MutationSpiceChallengeAct({required this.spiceChallengeAct, this.$__typename = 'mutation_root'});

  factory MutationSpiceChallengeAct.fromJson(Map<String, dynamic> json) {
    final l$spiceChallengeAct = json['spiceChallengeAct'];
    final l$$__typename = json['__typename'];
    return MutationSpiceChallengeAct(
      spiceChallengeAct: (l$spiceChallengeAct as List<dynamic>)
          .map((e) => FragmentSpiceChallengeFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<FragmentSpiceChallengeFragment> spiceChallengeAct;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceChallengeAct = spiceChallengeAct;
    _resultData['spiceChallengeAct'] = l$spiceChallengeAct.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceChallengeAct = spiceChallengeAct;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$spiceChallengeAct.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSpiceChallengeAct || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceChallengeAct = spiceChallengeAct;
    final lOther$spiceChallengeAct = other.spiceChallengeAct;
    if (l$spiceChallengeAct.length != lOther$spiceChallengeAct.length) {
      return false;
    }
    for (int i = 0; i < l$spiceChallengeAct.length; i++) {
      final l$spiceChallengeAct$entry = l$spiceChallengeAct[i];
      final lOther$spiceChallengeAct$entry = lOther$spiceChallengeAct[i];
      if (l$spiceChallengeAct$entry != lOther$spiceChallengeAct$entry) {
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

const documentNodeMutationSpiceChallengeAct = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SpiceChallengeAct'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'action')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceChallengeAct'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'action'),
                      value: VariableNode(name: NameNode(value: 'action')),
                    ),
                  ],
                ),
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
    fragmentDefinitionSpiceChallengeFragment,
  ],
);
MutationSpiceChallengeAct _parserFnMutationSpiceChallengeAct(Map<String, dynamic> data) =>
    MutationSpiceChallengeAct.fromJson(data);
typedef OnMutationCompletedMutationSpiceChallengeAct = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSpiceChallengeAct?,
);

class OptionsMutationSpiceChallengeAct extends graphql.MutationOptions<MutationSpiceChallengeAct> {
  OptionsMutationSpiceChallengeAct({
    String? operationName,
    required VariablesMutationSpiceChallengeAct variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceChallengeAct? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSpiceChallengeAct? onCompleted,
    graphql.OnMutationUpdate<MutationSpiceChallengeAct>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SpiceChallengeAct',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationSpiceChallengeAct(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationSpiceChallengeAct,
         parserFn: _parserFnMutationSpiceChallengeAct,
       );

  final OnMutationCompletedMutationSpiceChallengeAct? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSpiceChallengeAct
    extends graphql.WatchQueryOptions<MutationSpiceChallengeAct> {
  WatchOptionsMutationSpiceChallengeAct({
    String? operationName,
    required VariablesMutationSpiceChallengeAct variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSpiceChallengeAct? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SpiceChallengeAct',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSpiceChallengeAct,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSpiceChallengeAct,
       );
}

extension ClientExtensionMutationSpiceChallengeAct on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSpiceChallengeAct>> mutateSpiceChallengeAct(
    OptionsMutationSpiceChallengeAct options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSpiceChallengeAct> watchMutationSpiceChallengeAct(
    WatchOptionsMutationSpiceChallengeAct options,
  ) => this.watchMutation(options);
}
