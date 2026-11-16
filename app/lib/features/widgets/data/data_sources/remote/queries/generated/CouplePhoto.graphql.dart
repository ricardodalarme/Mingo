// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryCouplePhoto {
  factory VariablesQueryCouplePhoto({required String userId}) =>
      VariablesQueryCouplePhoto._({r'userId': userId});

  VariablesQueryCouplePhoto._(this._$data);

  factory VariablesQueryCouplePhoto.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryCouplePhoto._(result$data);
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
    if (other is! VariablesQueryCouplePhoto || runtimeType != other.runtimeType) {
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

class QueryCouplePhoto {
  QueryCouplePhoto({this.coupleMembersByPk, this.$__typename = 'query_root'});

  factory QueryCouplePhoto.fromJson(Map<String, dynamic> json) {
    final l$coupleMembersByPk = json['coupleMembersByPk'];
    final l$$__typename = json['__typename'];
    return QueryCouplePhoto(
      coupleMembersByPk: l$coupleMembersByPk == null
          ? null
          : QueryCouplePhotocoupleMembersByPk.fromJson(
              (l$coupleMembersByPk as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryCouplePhotocoupleMembersByPk? coupleMembersByPk;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$coupleMembersByPk = coupleMembersByPk;
    _resultData['coupleMembersByPk'] = l$coupleMembersByPk?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$coupleMembersByPk = coupleMembersByPk;
    final l$$__typename = $__typename;
    return Object.hashAll([l$coupleMembersByPk, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCouplePhoto || runtimeType != other.runtimeType) {
      return false;
    }
    final l$coupleMembersByPk = coupleMembersByPk;
    final lOther$coupleMembersByPk = other.coupleMembersByPk;
    if (l$coupleMembersByPk != lOther$coupleMembersByPk) {
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

const documentNodeQueryCouplePhoto = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'CouplePhoto'),
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
            name: NameNode(value: 'coupleMembersByPk'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'userId'),
                value: VariableNode(name: NameNode(value: 'userId')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'couple'),
                  alias: null,
                  arguments: [],
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
                        name: NameNode(value: 'photo'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'coupleId'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'fileId'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'uploadedBy'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'updatedAt'),
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
QueryCouplePhoto _parserFnQueryCouplePhoto(Map<String, dynamic> data) =>
    QueryCouplePhoto.fromJson(data);
typedef OnQueryCompleteQueryCouplePhoto = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryCouplePhoto?,
);

class OptionsQueryCouplePhoto extends graphql.QueryOptions<QueryCouplePhoto> {
  OptionsQueryCouplePhoto({
    String? operationName,
    required VariablesQueryCouplePhoto variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCouplePhoto? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryCouplePhoto? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CouplePhoto',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryCouplePhoto(data)),
         onError: onError,
         document: documentNodeQueryCouplePhoto,
         parserFn: _parserFnQueryCouplePhoto,
       );

  final OnQueryCompleteQueryCouplePhoto? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryCouplePhoto extends graphql.WatchQueryOptions<QueryCouplePhoto> {
  WatchOptionsQueryCouplePhoto({
    String? operationName,
    required VariablesQueryCouplePhoto variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryCouplePhoto? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CouplePhoto',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryCouplePhoto,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryCouplePhoto,
       );
}

class FetchMoreOptionsQueryCouplePhoto extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryCouplePhoto({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryCouplePhoto variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryCouplePhoto,
       );
}

extension ClientExtensionQueryCouplePhoto on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryCouplePhoto>> queryCouplePhoto(
    OptionsQueryCouplePhoto options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryCouplePhoto> watchQueryCouplePhoto(
    WatchOptionsQueryCouplePhoto options,
  ) => this.watchQuery(options);

  void writeQueryCouplePhoto({
    required QueryCouplePhoto data,
    required VariablesQueryCouplePhoto variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryCouplePhoto),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryCouplePhoto? readQueryCouplePhoto({
    required VariablesQueryCouplePhoto variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryCouplePhoto),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryCouplePhoto.fromJson(result);
  }
}

class QueryCouplePhotocoupleMembersByPk {
  QueryCouplePhotocoupleMembersByPk({required this.couple, this.$__typename = 'coupleMembers'});

  factory QueryCouplePhotocoupleMembersByPk.fromJson(Map<String, dynamic> json) {
    final l$couple = json['couple'];
    final l$$__typename = json['__typename'];
    return QueryCouplePhotocoupleMembersByPk(
      couple: QueryCouplePhotocoupleMembersByPkcouple.fromJson((l$couple as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryCouplePhotocoupleMembersByPkcouple couple;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$couple = couple;
    _resultData['couple'] = l$couple.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$couple = couple;
    final l$$__typename = $__typename;
    return Object.hashAll([l$couple, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCouplePhotocoupleMembersByPk || runtimeType != other.runtimeType) {
      return false;
    }
    final l$couple = couple;
    final lOther$couple = other.couple;
    if (l$couple != lOther$couple) {
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

class QueryCouplePhotocoupleMembersByPkcouple {
  QueryCouplePhotocoupleMembersByPkcouple({
    required this.id,
    this.photo,
    this.$__typename = 'couples',
  });

  factory QueryCouplePhotocoupleMembersByPkcouple.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$photo = json['photo'];
    final l$$__typename = json['__typename'];
    return QueryCouplePhotocoupleMembersByPkcouple(
      id: (l$id as String),
      photo: l$photo == null
          ? null
          : QueryCouplePhotocoupleMembersByPkcouplephoto.fromJson(
              (l$photo as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final QueryCouplePhotocoupleMembersByPkcouplephoto? photo;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$photo = photo;
    _resultData['photo'] = l$photo?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$photo = photo;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$photo, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCouplePhotocoupleMembersByPkcouple || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$photo = photo;
    final lOther$photo = other.photo;
    if (l$photo != lOther$photo) {
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

class QueryCouplePhotocoupleMembersByPkcouplephoto {
  QueryCouplePhotocoupleMembersByPkcouplephoto({
    required this.coupleId,
    required this.fileId,
    required this.uploadedBy,
    required this.updatedAt,
    this.$__typename = 'couplePhotos',
  });

  factory QueryCouplePhotocoupleMembersByPkcouplephoto.fromJson(Map<String, dynamic> json) {
    final l$coupleId = json['coupleId'];
    final l$fileId = json['fileId'];
    final l$uploadedBy = json['uploadedBy'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return QueryCouplePhotocoupleMembersByPkcouplephoto(
      coupleId: (l$coupleId as String),
      fileId: (l$fileId as String),
      uploadedBy: (l$uploadedBy as String),
      updatedAt: DateTime.parse((l$updatedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String coupleId;

  final String fileId;

  final String uploadedBy;

  final DateTime updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$fileId = fileId;
    _resultData['fileId'] = l$fileId;
    final l$uploadedBy = uploadedBy;
    _resultData['uploadedBy'] = l$uploadedBy;
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = ((v) => v.toUtc().toIso8601String())(l$updatedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$coupleId = coupleId;
    final l$fileId = fileId;
    final l$uploadedBy = uploadedBy;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$coupleId, l$fileId, l$uploadedBy, l$updatedAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryCouplePhotocoupleMembersByPkcouplephoto ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$fileId = fileId;
    final lOther$fileId = other.fileId;
    if (l$fileId != lOther$fileId) {
      return false;
    }
    final l$uploadedBy = uploadedBy;
    final lOther$uploadedBy = other.uploadedBy;
    if (l$uploadedBy != lOther$uploadedBy) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
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
