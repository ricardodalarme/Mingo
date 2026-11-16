// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationInsertCouplePhoto {
  factory VariablesMutationInsertCouplePhoto({required String coupleId, required String fileId}) =>
      VariablesMutationInsertCouplePhoto._({r'coupleId': coupleId, r'fileId': fileId});

  VariablesMutationInsertCouplePhoto._(this._$data);

  factory VariablesMutationInsertCouplePhoto.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$coupleId = data['coupleId'];
    result$data['coupleId'] = (l$coupleId as String);
    final l$fileId = data['fileId'];
    result$data['fileId'] = (l$fileId as String);
    return VariablesMutationInsertCouplePhoto._(result$data);
  }

  Map<String, dynamic> _$data;

  String get coupleId => (_$data['coupleId'] as String);

  String get fileId => (_$data['fileId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$coupleId = coupleId;
    result$data['coupleId'] = l$coupleId;
    final l$fileId = fileId;
    result$data['fileId'] = l$fileId;
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationInsertCouplePhoto || runtimeType != other.runtimeType) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$coupleId = coupleId;
    final l$fileId = fileId;
    return Object.hashAll([l$coupleId, l$fileId]);
  }
}

class MutationInsertCouplePhoto {
  MutationInsertCouplePhoto({this.insertCouplePhotos, this.$__typename = 'mutation_root'});

  factory MutationInsertCouplePhoto.fromJson(Map<String, dynamic> json) {
    final l$insertCouplePhotos = json['insertCouplePhotos'];
    final l$$__typename = json['__typename'];
    return MutationInsertCouplePhoto(
      insertCouplePhotos: l$insertCouplePhotos == null
          ? null
          : MutationInsertCouplePhotoinsertCouplePhotos.fromJson(
              (l$insertCouplePhotos as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationInsertCouplePhotoinsertCouplePhotos? insertCouplePhotos;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertCouplePhotos = insertCouplePhotos;
    _resultData['insertCouplePhotos'] = l$insertCouplePhotos?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertCouplePhotos = insertCouplePhotos;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertCouplePhotos, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertCouplePhoto || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertCouplePhotos = insertCouplePhotos;
    final lOther$insertCouplePhotos = other.insertCouplePhotos;
    if (l$insertCouplePhotos != lOther$insertCouplePhotos) {
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

const documentNodeMutationInsertCouplePhoto = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InsertCouplePhoto'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'coupleId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'fileId')),
          type: NamedTypeNode(name: NameNode(value: 'uuid'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertCouplePhotos'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'objects'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'coupleId'),
                          value: VariableNode(name: NameNode(value: 'coupleId')),
                        ),
                        ObjectFieldNode(
                          name: NameNode(value: 'fileId'),
                          value: VariableNode(name: NameNode(value: 'fileId')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'affected_rows'),
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
MutationInsertCouplePhoto _parserFnMutationInsertCouplePhoto(Map<String, dynamic> data) =>
    MutationInsertCouplePhoto.fromJson(data);
typedef OnMutationCompletedMutationInsertCouplePhoto = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationInsertCouplePhoto?,
);

class OptionsMutationInsertCouplePhoto extends graphql.MutationOptions<MutationInsertCouplePhoto> {
  OptionsMutationInsertCouplePhoto({
    String? operationName,
    required VariablesMutationInsertCouplePhoto variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertCouplePhoto? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationInsertCouplePhoto? onCompleted,
    graphql.OnMutationUpdate<MutationInsertCouplePhoto>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertCouplePhoto',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationInsertCouplePhoto(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationInsertCouplePhoto,
         parserFn: _parserFnMutationInsertCouplePhoto,
       );

  final OnMutationCompletedMutationInsertCouplePhoto? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationInsertCouplePhoto
    extends graphql.WatchQueryOptions<MutationInsertCouplePhoto> {
  WatchOptionsMutationInsertCouplePhoto({
    String? operationName,
    required VariablesMutationInsertCouplePhoto variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationInsertCouplePhoto? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'InsertCouplePhoto',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationInsertCouplePhoto,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationInsertCouplePhoto,
       );
}

extension ClientExtensionMutationInsertCouplePhoto on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationInsertCouplePhoto>> mutateInsertCouplePhoto(
    OptionsMutationInsertCouplePhoto options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationInsertCouplePhoto> watchMutationInsertCouplePhoto(
    WatchOptionsMutationInsertCouplePhoto options,
  ) => this.watchMutation(options);
}

class MutationInsertCouplePhotoinsertCouplePhotos {
  MutationInsertCouplePhotoinsertCouplePhotos({
    required this.affected_rows,
    this.$__typename = 'couplePhotos_mutation_response',
  });

  factory MutationInsertCouplePhotoinsertCouplePhotos.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationInsertCouplePhotoinsertCouplePhotos(
      affected_rows: (l$affected_rows as int),
      $__typename: (l$$__typename as String),
    );
  }

  final int affected_rows;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$affected_rows = affected_rows;
    _resultData['affected_rows'] = l$affected_rows;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$affected_rows = affected_rows;
    final l$$__typename = $__typename;
    return Object.hashAll([l$affected_rows, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationInsertCouplePhotoinsertCouplePhotos || runtimeType != other.runtimeType) {
      return false;
    }
    final l$affected_rows = affected_rows;
    final lOther$affected_rows = other.affected_rows;
    if (l$affected_rows != lOther$affected_rows) {
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
