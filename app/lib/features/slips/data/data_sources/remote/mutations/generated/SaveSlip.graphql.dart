// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';
import '../../fragments/generated/SlipSummaryFragment.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationSaveSlip {
  factory VariablesMutationSaveSlip({
    required String id,
    required String body,
    required EnumSlipKind_enum kind,
    String? feeling,
    String? planNote,
    bool? forCard,
    DateTime? createdAt,
    EnumSlipCategory_enum? category,
    EnumWorkArea_enum? workArea,
  }) => VariablesMutationSaveSlip._({
    r'id': id,
    r'body': body,
    r'kind': kind,
    if (feeling != null) r'feeling': feeling,
    if (planNote != null) r'planNote': planNote,
    if (forCard != null) r'forCard': forCard,
    if (createdAt != null) r'createdAt': createdAt,
    if (category != null) r'category': category,
    if (workArea != null) r'workArea': workArea,
  });

  VariablesMutationSaveSlip._(this._$data);

  factory VariablesMutationSaveSlip.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$body = data['body'];
    result$data['body'] = (l$body as String);
    final l$kind = data['kind'];
    result$data['kind'] = fromJsonEnumSlipKind_enum((l$kind as String));
    if (data.containsKey('feeling')) {
      final l$feeling = data['feeling'];
      result$data['feeling'] = (l$feeling as String?);
    }
    if (data.containsKey('planNote')) {
      final l$planNote = data['planNote'];
      result$data['planNote'] = (l$planNote as String?);
    }
    if (data.containsKey('forCard')) {
      final l$forCard = data['forCard'];
      result$data['forCard'] = (l$forCard as bool?);
    }
    if (data.containsKey('createdAt')) {
      final l$createdAt = data['createdAt'];
      result$data['createdAt'] = l$createdAt == null
          ? null
          : DateTime.parse((l$createdAt as String));
    }
    if (data.containsKey('category')) {
      final l$category = data['category'];
      result$data['category'] = l$category == null
          ? null
          : fromJsonEnumSlipCategory_enum((l$category as String));
    }
    if (data.containsKey('workArea')) {
      final l$workArea = data['workArea'];
      result$data['workArea'] = l$workArea == null
          ? null
          : fromJsonEnumWorkArea_enum((l$workArea as String));
    }
    return VariablesMutationSaveSlip._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String get body => (_$data['body'] as String);

  EnumSlipKind_enum get kind => (_$data['kind'] as EnumSlipKind_enum);

  String? get feeling => (_$data['feeling'] as String?);

  String? get planNote => (_$data['planNote'] as String?);

  bool? get forCard => (_$data['forCard'] as bool?);

  DateTime? get createdAt => (_$data['createdAt'] as DateTime?);

  EnumSlipCategory_enum? get category => (_$data['category'] as EnumSlipCategory_enum?);

  EnumWorkArea_enum? get workArea => (_$data['workArea'] as EnumWorkArea_enum?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$body = body;
    result$data['body'] = l$body;
    final l$kind = kind;
    result$data['kind'] = toJsonEnumSlipKind_enum(l$kind);
    if (_$data.containsKey('feeling')) {
      final l$feeling = feeling;
      result$data['feeling'] = l$feeling;
    }
    if (_$data.containsKey('planNote')) {
      final l$planNote = planNote;
      result$data['planNote'] = l$planNote;
    }
    if (_$data.containsKey('forCard')) {
      final l$forCard = forCard;
      result$data['forCard'] = l$forCard;
    }
    if (_$data.containsKey('createdAt')) {
      final l$createdAt = createdAt;
      result$data['createdAt'] = l$createdAt == null
          ? null
          : ((v) => v.toUtc().toIso8601String())(l$createdAt);
    }
    if (_$data.containsKey('category')) {
      final l$category = category;
      result$data['category'] = l$category == null ? null : toJsonEnumSlipCategory_enum(l$category);
    }
    if (_$data.containsKey('workArea')) {
      final l$workArea = workArea;
      result$data['workArea'] = l$workArea == null ? null : toJsonEnumWorkArea_enum(l$workArea);
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationSaveSlip || runtimeType != other.runtimeType) {
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
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$feeling = feeling;
    final lOther$feeling = other.feeling;
    if (_$data.containsKey('feeling') != other._$data.containsKey('feeling')) {
      return false;
    }
    if (l$feeling != lOther$feeling) {
      return false;
    }
    final l$planNote = planNote;
    final lOther$planNote = other.planNote;
    if (_$data.containsKey('planNote') != other._$data.containsKey('planNote')) {
      return false;
    }
    if (l$planNote != lOther$planNote) {
      return false;
    }
    final l$forCard = forCard;
    final lOther$forCard = other.forCard;
    if (_$data.containsKey('forCard') != other._$data.containsKey('forCard')) {
      return false;
    }
    if (l$forCard != lOther$forCard) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (_$data.containsKey('createdAt') != other._$data.containsKey('createdAt')) {
      return false;
    }
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (_$data.containsKey('category') != other._$data.containsKey('category')) {
      return false;
    }
    if (l$category != lOther$category) {
      return false;
    }
    final l$workArea = workArea;
    final lOther$workArea = other.workArea;
    if (_$data.containsKey('workArea') != other._$data.containsKey('workArea')) {
      return false;
    }
    if (l$workArea != lOther$workArea) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$body = body;
    final l$kind = kind;
    final l$feeling = feeling;
    final l$planNote = planNote;
    final l$forCard = forCard;
    final l$createdAt = createdAt;
    final l$category = category;
    final l$workArea = workArea;
    return Object.hashAll([
      l$id,
      l$body,
      l$kind,
      _$data.containsKey('feeling') ? l$feeling : const {},
      _$data.containsKey('planNote') ? l$planNote : const {},
      _$data.containsKey('forCard') ? l$forCard : const {},
      _$data.containsKey('createdAt') ? l$createdAt : const {},
      _$data.containsKey('category') ? l$category : const {},
      _$data.containsKey('workArea') ? l$workArea : const {},
    ]);
  }
}

class MutationSaveSlip {
  MutationSaveSlip({this.insertSlipsOne, this.$__typename = 'mutation_root'});

  factory MutationSaveSlip.fromJson(Map<String, dynamic> json) {
    final l$insertSlipsOne = json['insertSlipsOne'];
    final l$$__typename = json['__typename'];
    return MutationSaveSlip(
      insertSlipsOne: l$insertSlipsOne == null
          ? null
          : FragmentSlipSummaryFragment.fromJson((l$insertSlipsOne as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final FragmentSlipSummaryFragment? insertSlipsOne;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertSlipsOne = insertSlipsOne;
    _resultData['insertSlipsOne'] = l$insertSlipsOne?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertSlipsOne = insertSlipsOne;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertSlipsOne, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationSaveSlip || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertSlipsOne = insertSlipsOne;
    final lOther$insertSlipsOne = other.insertSlipsOne;
    if (l$insertSlipsOne != lOther$insertSlipsOne) {
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

const documentNodeMutationSaveSlip = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SaveSlip'),
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
          variable: VariableNode(name: NameNode(value: 'kind')),
          type: NamedTypeNode(name: NameNode(value: 'SlipKind_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'feeling')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'planNote')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'forCard')),
          type: NamedTypeNode(name: NameNode(value: 'Boolean'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'createdAt')),
          type: NamedTypeNode(name: NameNode(value: 'timestamptz'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'category')),
          type: NamedTypeNode(name: NameNode(value: 'SlipCategory_enum'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'workArea')),
          type: NamedTypeNode(name: NameNode(value: 'WorkArea_enum'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertSlipsOne'),
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
                      name: NameNode(value: 'kind'),
                      value: VariableNode(name: NameNode(value: 'kind')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'feeling'),
                      value: VariableNode(name: NameNode(value: 'feeling')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'planNote'),
                      value: VariableNode(name: NameNode(value: 'planNote')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'forCard'),
                      value: VariableNode(name: NameNode(value: 'forCard')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'createdAt'),
                      value: VariableNode(name: NameNode(value: 'createdAt')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'category'),
                      value: VariableNode(name: NameNode(value: 'category')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'workArea'),
                      value: VariableNode(name: NameNode(value: 'workArea')),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'on_conflict'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'constraint'),
                      value: EnumValueNode(name: NameNode(value: 'slips_pkey')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'update_columns'),
                      value: ListValueNode(
                        values: [
                          EnumValueNode(name: NameNode(value: 'body')),
                          EnumValueNode(name: NameNode(value: 'kind')),
                          EnumValueNode(name: NameNode(value: 'feeling')),
                          EnumValueNode(name: NameNode(value: 'planNote')),
                          EnumValueNode(name: NameNode(value: 'forCard')),
                          EnumValueNode(name: NameNode(value: 'category')),
                          EnumValueNode(name: NameNode(value: 'workArea')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'SlipSummaryFragment'),
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
    fragmentDefinitionSlipSummaryFragment,
  ],
);
MutationSaveSlip _parserFnMutationSaveSlip(Map<String, dynamic> data) =>
    MutationSaveSlip.fromJson(data);
typedef OnMutationCompletedMutationSaveSlip = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationSaveSlip?,
);

class OptionsMutationSaveSlip extends graphql.MutationOptions<MutationSaveSlip> {
  OptionsMutationSaveSlip({
    String? operationName,
    required VariablesMutationSaveSlip variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSaveSlip? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationSaveSlip? onCompleted,
    graphql.OnMutationUpdate<MutationSaveSlip>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SaveSlip',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(data, data == null ? null : _parserFnMutationSaveSlip(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationSaveSlip,
         parserFn: _parserFnMutationSaveSlip,
       );

  final OnMutationCompletedMutationSaveSlip? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationSaveSlip extends graphql.WatchQueryOptions<MutationSaveSlip> {
  WatchOptionsMutationSaveSlip({
    String? operationName,
    required VariablesMutationSaveSlip variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationSaveSlip? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SaveSlip',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationSaveSlip,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationSaveSlip,
       );
}

extension ClientExtensionMutationSaveSlip on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationSaveSlip>> mutateSaveSlip(
    OptionsMutationSaveSlip options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationSaveSlip> watchMutationSaveSlip(
    WatchOptionsMutationSaveSlip options,
  ) => this.watchMutation(options);
}
