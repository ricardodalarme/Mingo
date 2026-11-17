// dart format width=100
import '../../fragments/generated/AgreementFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationAddAgreement {
  factory VariablesMutationAddAgreement({
    required String id,
    required String body,
    String? coupleId,
  }) => VariablesMutationAddAgreement._({
    r'id': id,
    r'body': body,
    if (coupleId != null) r'coupleId': coupleId,
  });

  VariablesMutationAddAgreement._(this._$data);

  factory VariablesMutationAddAgreement.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$body = data['body'];
    result$data['body'] = (l$body as String);
    if (data.containsKey('coupleId')) {
      final l$coupleId = data['coupleId'];
      result$data['coupleId'] = (l$coupleId as String?);
    }
    return VariablesMutationAddAgreement._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String get body => (_$data['body'] as String);

  String? get coupleId => (_$data['coupleId'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$body = body;
    result$data['body'] = l$body;
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
    if (other is! VariablesMutationAddAgreement || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
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
    final l$body = body;
    final l$coupleId = coupleId;
    return Object.hashAll([l$id, l$body, _$data.containsKey('coupleId') ? l$coupleId : const {}]);
  }
}

class MutationAddAgreement {
  MutationAddAgreement({this.insertAgreementsOne, this.$__typename = 'mutation_root'});

  factory MutationAddAgreement.fromJson(Map<String, dynamic> json) {
    final l$insertAgreementsOne = json['insertAgreementsOne'];
    final l$$__typename = json['__typename'];
    return MutationAddAgreement(
      insertAgreementsOne: l$insertAgreementsOne == null
          ? null
          : FragmentAgreementFragment.fromJson((l$insertAgreementsOne as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentAgreementFragment? insertAgreementsOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertAgreementsOne = insertAgreementsOne;
    _resultData['insertAgreementsOne'] = l$insertAgreementsOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertAgreementsOne = insertAgreementsOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertAgreementsOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationAddAgreement || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertAgreementsOne = insertAgreementsOne;
    final lOther$insertAgreementsOne = other.insertAgreementsOne;
    if (l$insertAgreementsOne != lOther$insertAgreementsOne) {
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

const documentNodeMutationAddAgreement = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'AddAgreement'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'body')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
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
            name: NameNode(value: 'insertAgreementsOne'),
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
                      name: NameNode(value: 'body'),
                      value: VariableNode(name: NameNode(value: 'body')),
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
MutationAddAgreement _parserFnMutationAddAgreement(Map<String, dynamic> data) =>
    MutationAddAgreement.fromJson(data);
typedef OnMutationCompletedMutationAddAgreement = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationAddAgreement?,
);

class OptionsMutationAddAgreement extends graphql.MutationOptions<MutationAddAgreement> {
  OptionsMutationAddAgreement({
    String? operationName,
    required VariablesMutationAddAgreement variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationAddAgreement? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationAddAgreement? onCompleted,
    graphql.OnMutationUpdate<MutationAddAgreement>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'AddAgreement',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationAddAgreement(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationAddAgreement,
         parserFn: _parserFnMutationAddAgreement,
       );

  final OnMutationCompletedMutationAddAgreement? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationAddAgreement extends graphql.WatchQueryOptions<MutationAddAgreement> {
  WatchOptionsMutationAddAgreement({
    String? operationName,
    required VariablesMutationAddAgreement variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationAddAgreement? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'AddAgreement',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationAddAgreement,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationAddAgreement,
       );
}

extension ClientExtensionMutationAddAgreement on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationAddAgreement>> mutateAddAgreement(
    OptionsMutationAddAgreement options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationAddAgreement> watchMutationAddAgreement(
    WatchOptionsMutationAddAgreement options,
  ) => this.watchMutation(options);
}
