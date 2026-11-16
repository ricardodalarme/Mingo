// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationUpsertCouplePhoto {
  factory VariablesMutationUpsertCouplePhoto({required String coupleId, required String fileId}) =>
      VariablesMutationUpsertCouplePhoto._({r'coupleId': coupleId, r'fileId': fileId});

  VariablesMutationUpsertCouplePhoto._(this._$data);

  factory VariablesMutationUpsertCouplePhoto.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$coupleId = data['coupleId'];
    result$data['coupleId'] = (l$coupleId as String);
    final l$fileId = data['fileId'];
    result$data['fileId'] = (l$fileId as String);
    return VariablesMutationUpsertCouplePhoto._(result$data);
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
    if (other is! VariablesMutationUpsertCouplePhoto || runtimeType != other.runtimeType) {
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

class MutationUpsertCouplePhoto {
  MutationUpsertCouplePhoto({this.updateCouplePhotos, this.$__typename = 'mutation_root'});

  factory MutationUpsertCouplePhoto.fromJson(Map<String, dynamic> json) {
    final l$updateCouplePhotos = json['updateCouplePhotos'];
    final l$$__typename = json['__typename'];
    return MutationUpsertCouplePhoto(
      updateCouplePhotos: l$updateCouplePhotos == null
          ? null
          : MutationUpsertCouplePhotoupdateCouplePhotos.fromJson(
              (l$updateCouplePhotos as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationUpsertCouplePhotoupdateCouplePhotos? updateCouplePhotos;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateCouplePhotos = updateCouplePhotos;
    _resultData['updateCouplePhotos'] = l$updateCouplePhotos?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateCouplePhotos = updateCouplePhotos;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateCouplePhotos, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationUpsertCouplePhoto || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateCouplePhotos = updateCouplePhotos;
    final lOther$updateCouplePhotos = other.updateCouplePhotos;
    if (l$updateCouplePhotos != lOther$updateCouplePhotos) {
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

const documentNodeMutationUpsertCouplePhoto = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpsertCouplePhoto'),
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
            name: NameNode(value: 'updateCouplePhotos'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'coupleId'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_eq'),
                            value: VariableNode(name: NameNode(value: 'coupleId')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: '_set'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'fileId'),
                      value: VariableNode(name: NameNode(value: 'fileId')),
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
MutationUpsertCouplePhoto _parserFnMutationUpsertCouplePhoto(Map<String, dynamic> data) =>
    MutationUpsertCouplePhoto.fromJson(data);
typedef OnMutationCompletedMutationUpsertCouplePhoto = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationUpsertCouplePhoto?,
);

class OptionsMutationUpsertCouplePhoto extends graphql.MutationOptions<MutationUpsertCouplePhoto> {
  OptionsMutationUpsertCouplePhoto({
    String? operationName,
    required VariablesMutationUpsertCouplePhoto variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpsertCouplePhoto? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationUpsertCouplePhoto? onCompleted,
    graphql.OnMutationUpdate<MutationUpsertCouplePhoto>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpsertCouplePhoto',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationUpsertCouplePhoto(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpsertCouplePhoto,
         parserFn: _parserFnMutationUpsertCouplePhoto,
       );

  final OnMutationCompletedMutationUpsertCouplePhoto? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationUpsertCouplePhoto
    extends graphql.WatchQueryOptions<MutationUpsertCouplePhoto> {
  WatchOptionsMutationUpsertCouplePhoto({
    String? operationName,
    required VariablesMutationUpsertCouplePhoto variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationUpsertCouplePhoto? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'UpsertCouplePhoto',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationUpsertCouplePhoto,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationUpsertCouplePhoto,
       );
}

extension ClientExtensionMutationUpsertCouplePhoto on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationUpsertCouplePhoto>> mutateUpsertCouplePhoto(
    OptionsMutationUpsertCouplePhoto options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationUpsertCouplePhoto> watchMutationUpsertCouplePhoto(
    WatchOptionsMutationUpsertCouplePhoto options,
  ) => this.watchMutation(options);
}

class MutationUpsertCouplePhotoupdateCouplePhotos {
  MutationUpsertCouplePhotoupdateCouplePhotos({
    required this.affected_rows,
    this.$__typename = 'couplePhotos_mutation_response',
  });

  factory MutationUpsertCouplePhotoupdateCouplePhotos.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationUpsertCouplePhotoupdateCouplePhotos(
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
    if (other is! MutationUpsertCouplePhotoupdateCouplePhotos || runtimeType != other.runtimeType) {
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
