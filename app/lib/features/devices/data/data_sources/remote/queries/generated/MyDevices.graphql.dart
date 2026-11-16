// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryMyDevices {
  QueryMyDevices({required this.devices, this.$__typename = 'query_root'});

  factory QueryMyDevices.fromJson(Map<String, dynamic> json) {
    final l$devices = json['devices'];
    final l$$__typename = json['__typename'];
    return QueryMyDevices(
      devices: (l$devices as List<dynamic>)
          .map((e) => QueryMyDevicesdevices.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMyDevicesdevices> devices;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$devices = devices;
    _resultData['devices'] = l$devices.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$devices = devices;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$devices.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyDevices || runtimeType != other.runtimeType) {
      return false;
    }
    final l$devices = devices;
    final lOther$devices = other.devices;
    if (l$devices.length != lOther$devices.length) {
      return false;
    }
    for (int i = 0; i < l$devices.length; i++) {
      final l$devices$entry = l$devices[i];
      final lOther$devices$entry = lOther$devices[i];
      if (l$devices$entry != lOther$devices$entry) {
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

const documentNodeQueryMyDevices = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyDevices'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'devices'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'order_by'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'lastSeenAt'),
                          value: EnumValueNode(name: NameNode(value: 'desc_nulls_last')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '50'),
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
                  name: NameNode(value: 'platform'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'label'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'lastSeenAt'),
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
QueryMyDevices _parserFnQueryMyDevices(Map<String, dynamic> data) => QueryMyDevices.fromJson(data);
typedef OnQueryCompleteQueryMyDevices = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyDevices?,
);

class OptionsQueryMyDevices extends graphql.QueryOptions<QueryMyDevices> {
  OptionsQueryMyDevices({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyDevices? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyDevices? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'MyDevices',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyDevices(data)),
         onError: onError,
         document: documentNodeQueryMyDevices,
         parserFn: _parserFnQueryMyDevices,
       );

  final OnQueryCompleteQueryMyDevices? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyDevices extends graphql.WatchQueryOptions<QueryMyDevices> {
  WatchOptionsQueryMyDevices({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyDevices? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'MyDevices',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyDevices,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyDevices,
       );
}

class FetchMoreOptionsQueryMyDevices extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyDevices({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryMyDevices);
}

extension ClientExtensionQueryMyDevices on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyDevices>> queryMyDevices([
    OptionsQueryMyDevices? options,
  ]) async => await this.query(options ?? OptionsQueryMyDevices());

  graphql.ObservableQuery<QueryMyDevices> watchQueryMyDevices([
    WatchOptionsQueryMyDevices? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryMyDevices());

  void writeQueryMyDevices({required QueryMyDevices data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryMyDevices)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryMyDevices? readQueryMyDevices({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryMyDevices)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyDevices.fromJson(result);
  }
}

class QueryMyDevicesdevices {
  QueryMyDevicesdevices({
    required this.id,
    required this.platform,
    this.label,
    required this.lastSeenAt,
    this.$__typename = 'devices',
  });

  factory QueryMyDevicesdevices.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$platform = json['platform'];
    final l$label = json['label'];
    final l$lastSeenAt = json['lastSeenAt'];
    final l$$__typename = json['__typename'];
    return QueryMyDevicesdevices(
      id: (l$id as String),
      platform: fromJsonEnumDevicePlatform_enum((l$platform as String)),
      label: (l$label as String?),
      lastSeenAt: DateTime.parse((l$lastSeenAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumDevicePlatform_enum platform;

  final String? label;

  final DateTime lastSeenAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$platform = platform;
    _resultData['platform'] = toJsonEnumDevicePlatform_enum(l$platform);
    final l$label = label;
    _resultData['label'] = l$label;
    final l$lastSeenAt = lastSeenAt;
    _resultData['lastSeenAt'] = ((v) => v.toUtc().toIso8601String())(l$lastSeenAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$platform = platform;
    final l$label = label;
    final l$lastSeenAt = lastSeenAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$platform, l$label, l$lastSeenAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyDevicesdevices || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$platform = platform;
    final lOther$platform = other.platform;
    if (l$platform != lOther$platform) {
      return false;
    }
    final l$label = label;
    final lOther$label = other.label;
    if (l$label != lOther$label) {
      return false;
    }
    final l$lastSeenAt = lastSeenAt;
    final lOther$lastSeenAt = other.lastSeenAt;
    if (l$lastSeenAt != lOther$lastSeenAt) {
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
