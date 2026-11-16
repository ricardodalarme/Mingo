// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQuerySlipDetail {
  factory VariablesQuerySlipDetail({required String id}) => VariablesQuerySlipDetail._({r'id': id});

  VariablesQuerySlipDetail._(this._$data);

  factory VariablesQuerySlipDetail.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return VariablesQuerySlipDetail._(result$data);
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
    if (other is! VariablesQuerySlipDetail || runtimeType != other.runtimeType) {
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

class QuerySlipDetail {
  QuerySlipDetail({this.slipsByPk, required this.cardItems, this.$__typename = 'query_root'});

  factory QuerySlipDetail.fromJson(Map<String, dynamic> json) {
    final l$slipsByPk = json['slipsByPk'];
    final l$cardItems = json['cardItems'];
    final l$$__typename = json['__typename'];
    return QuerySlipDetail(
      slipsByPk: l$slipsByPk == null
          ? null
          : QuerySlipDetailslipsByPk.fromJson((l$slipsByPk as Map<String, dynamic>)),
      cardItems: (l$cardItems as List<dynamic>)
          .map((e) => QuerySlipDetailcardItems.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final QuerySlipDetailslipsByPk? slipsByPk;

  final List<QuerySlipDetailcardItems> cardItems;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$slipsByPk = slipsByPk;
    _resultData['slipsByPk'] = l$slipsByPk?.toJson();
    final l$cardItems = cardItems;
    _resultData['cardItems'] = l$cardItems.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$slipsByPk = slipsByPk;
    final l$cardItems = cardItems;
    final l$$__typename = $__typename;
    return Object.hashAll([l$slipsByPk, Object.hashAll(l$cardItems.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySlipDetail || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slipsByPk = slipsByPk;
    final lOther$slipsByPk = other.slipsByPk;
    if (l$slipsByPk != lOther$slipsByPk) {
      return false;
    }
    final l$cardItems = cardItems;
    final lOther$cardItems = other.cardItems;
    if (l$cardItems.length != lOther$cardItems.length) {
      return false;
    }
    for (int i = 0; i < l$cardItems.length; i++) {
      final l$cardItems$entry = l$cardItems[i];
      final lOther$cardItems$entry = lOther$cardItems[i];
      if (l$cardItems$entry != lOther$cardItems$entry) {
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

const documentNodeQuerySlipDetail = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SlipDetail'),
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
            name: NameNode(value: 'slipsByPk'),
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
                FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'body'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'kind'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'feeling'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'planNote'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'forCard'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'category'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'workArea'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'polarity'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'request'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'createdAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'archivedAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'inJar'),
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
            name: NameNode(value: 'cardItems'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'slipId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'id')),
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
                  name: NameNode(value: 'id'),
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
QuerySlipDetail _parserFnQuerySlipDetail(Map<String, dynamic> data) =>
    QuerySlipDetail.fromJson(data);
typedef OnQueryCompleteQuerySlipDetail = FutureOr<void> Function(
  Map<String, dynamic>?,
  QuerySlipDetail?,
);

class OptionsQuerySlipDetail extends graphql.QueryOptions<QuerySlipDetail> {
  OptionsQuerySlipDetail({
    String? operationName,
    required VariablesQuerySlipDetail variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySlipDetail? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQuerySlipDetail? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SlipDetail',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQuerySlipDetail(data)),
         onError: onError,
         document: documentNodeQuerySlipDetail,
         parserFn: _parserFnQuerySlipDetail,
       );

  final OnQueryCompleteQuerySlipDetail? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQuerySlipDetail extends graphql.WatchQueryOptions<QuerySlipDetail> {
  WatchOptionsQuerySlipDetail({
    String? operationName,
    required VariablesQuerySlipDetail variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySlipDetail? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'SlipDetail',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQuerySlipDetail,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQuerySlipDetail,
       );
}

class FetchMoreOptionsQuerySlipDetail extends graphql.FetchMoreOptions {
  FetchMoreOptionsQuerySlipDetail({
    required graphql.UpdateQuery updateQuery,
    required VariablesQuerySlipDetail variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQuerySlipDetail,
       );
}

extension ClientExtensionQuerySlipDetail on graphql.GraphQLClient {
  Future<graphql.QueryResult<QuerySlipDetail>> querySlipDetail(
    OptionsQuerySlipDetail options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QuerySlipDetail> watchQuerySlipDetail(
    WatchOptionsQuerySlipDetail options,
  ) => this.watchQuery(options);

  void writeQuerySlipDetail({
    required QuerySlipDetail data,
    required VariablesQuerySlipDetail variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQuerySlipDetail),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QuerySlipDetail? readQuerySlipDetail({
    required VariablesQuerySlipDetail variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQuerySlipDetail),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QuerySlipDetail.fromJson(result);
  }
}

class QuerySlipDetailslipsByPk {
  QuerySlipDetailslipsByPk({
    required this.id,
    required this.body,
    required this.kind,
    this.feeling,
    this.planNote,
    required this.forCard,
    this.category,
    this.workArea,
    required this.polarity,
    this.request,
    required this.createdAt,
    this.archivedAt,
    required this.inJar,
    this.$__typename = 'slips',
  });

  factory QuerySlipDetailslipsByPk.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$body = json['body'];
    final l$kind = json['kind'];
    final l$feeling = json['feeling'];
    final l$planNote = json['planNote'];
    final l$forCard = json['forCard'];
    final l$category = json['category'];
    final l$workArea = json['workArea'];
    final l$polarity = json['polarity'];
    final l$request = json['request'];
    final l$createdAt = json['createdAt'];
    final l$archivedAt = json['archivedAt'];
    final l$inJar = json['inJar'];
    final l$$__typename = json['__typename'];
    return QuerySlipDetailslipsByPk(
      id: (l$id as String),
      body: (l$body as String),
      kind: fromJsonEnumSlipKind_enum((l$kind as String)),
      feeling: (l$feeling as String?),
      planNote: (l$planNote as String?),
      forCard: (l$forCard as bool),
      category: l$category == null ? null : fromJsonEnumSlipCategory_enum((l$category as String)),
      workArea: l$workArea == null ? null : fromJsonEnumWorkArea_enum((l$workArea as String)),
      polarity: fromJsonEnumSlipPolarity_enum((l$polarity as String)),
      request: (l$request as String?),
      createdAt: DateTime.parse((l$createdAt as String)),
      archivedAt: l$archivedAt == null ? null : DateTime.parse((l$archivedAt as String)),
      inJar: (l$inJar as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String body;

  final EnumSlipKind_enum kind;

  final String? feeling;

  final String? planNote;

  final bool forCard;

  final EnumSlipCategory_enum? category;

  final EnumWorkArea_enum? workArea;

  final EnumSlipPolarity_enum polarity;

  final String? request;

  final DateTime createdAt;

  final DateTime? archivedAt;

  final bool inJar;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumSlipKind_enum(l$kind);
    final l$feeling = feeling;
    _resultData['feeling'] = l$feeling;
    final l$planNote = planNote;
    _resultData['planNote'] = l$planNote;
    final l$forCard = forCard;
    _resultData['forCard'] = l$forCard;
    final l$category = category;
    _resultData['category'] = l$category == null ? null : toJsonEnumSlipCategory_enum(l$category);
    final l$workArea = workArea;
    _resultData['workArea'] = l$workArea == null ? null : toJsonEnumWorkArea_enum(l$workArea);
    final l$polarity = polarity;
    _resultData['polarity'] = toJsonEnumSlipPolarity_enum(l$polarity);
    final l$request = request;
    _resultData['request'] = l$request;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$archivedAt = archivedAt;
    _resultData['archivedAt'] = l$archivedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$archivedAt);
    final l$inJar = inJar;
    _resultData['inJar'] = l$inJar;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$body = body;
    final l$kind = kind;
    final l$feeling = feeling;
    final l$planNote = planNote;
    final l$forCard = forCard;
    final l$category = category;
    final l$workArea = workArea;
    final l$polarity = polarity;
    final l$request = request;
    final l$createdAt = createdAt;
    final l$archivedAt = archivedAt;
    final l$inJar = inJar;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$body,
      l$kind,
      l$feeling,
      l$planNote,
      l$forCard,
      l$category,
      l$workArea,
      l$polarity,
      l$request,
      l$createdAt,
      l$archivedAt,
      l$inJar,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySlipDetailslipsByPk || runtimeType != other.runtimeType) {
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
    if (l$feeling != lOther$feeling) {
      return false;
    }
    final l$planNote = planNote;
    final lOther$planNote = other.planNote;
    if (l$planNote != lOther$planNote) {
      return false;
    }
    final l$forCard = forCard;
    final lOther$forCard = other.forCard;
    if (l$forCard != lOther$forCard) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$workArea = workArea;
    final lOther$workArea = other.workArea;
    if (l$workArea != lOther$workArea) {
      return false;
    }
    final l$polarity = polarity;
    final lOther$polarity = other.polarity;
    if (l$polarity != lOther$polarity) {
      return false;
    }
    final l$request = request;
    final lOther$request = other.request;
    if (l$request != lOther$request) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$archivedAt = archivedAt;
    final lOther$archivedAt = other.archivedAt;
    if (l$archivedAt != lOther$archivedAt) {
      return false;
    }
    final l$inJar = inJar;
    final lOther$inJar = other.inJar;
    if (l$inJar != lOther$inJar) {
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

class QuerySlipDetailcardItems {
  QuerySlipDetailcardItems({required this.id, this.$__typename = 'cardItems'});

  factory QuerySlipDetailcardItems.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$$__typename = json['__typename'];
    return QuerySlipDetailcardItems(id: (l$id as String), $__typename: (l$$__typename as String));
  }

  final String id;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySlipDetailcardItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
