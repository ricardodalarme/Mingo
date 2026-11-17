// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QuerySlipsPreference {
  QuerySlipsPreference({required this.userSettings, this.$__typename = 'query_root'});

  factory QuerySlipsPreference.fromJson(Map<String, dynamic> json) {
    final l$userSettings = json['userSettings'];
    final l$$__typename = json['__typename'];
    return QuerySlipsPreference(
      userSettings: (l$userSettings as List<dynamic>)
          .map((e) => QuerySlipsPreferenceuserSettings.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QuerySlipsPreferenceuserSettings> userSettings;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userSettings = userSettings;
    _resultData['userSettings'] = l$userSettings.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userSettings = userSettings;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$userSettings.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySlipsPreference || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userSettings = userSettings;
    final lOther$userSettings = other.userSettings;
    if (l$userSettings.length != lOther$userSettings.length) {
      return false;
    }
    for (int i = 0; i < l$userSettings.length; i++) {
      final l$userSettings$entry = l$userSettings[i];
      final lOther$userSettings$entry = lOther$userSettings[i];
      if (l$userSettings$entry != lOther$userSettings$entry) {
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

const documentNodeQuerySlipsPreference = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SlipsPreference'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'userSettings'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '1'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'slipsDefaultForCard'),
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
QuerySlipsPreference _parserFnQuerySlipsPreference(Map<String, dynamic> data) =>
    QuerySlipsPreference.fromJson(data);
typedef OnQueryCompleteQuerySlipsPreference = FutureOr<void> Function(
  Map<String, dynamic>?,
  QuerySlipsPreference?,
);

class OptionsQuerySlipsPreference extends graphql.QueryOptions<QuerySlipsPreference> {
  OptionsQuerySlipsPreference({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySlipsPreference? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQuerySlipsPreference? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'SlipsPreference',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQuerySlipsPreference(data)),
         onError: onError,
         document: documentNodeQuerySlipsPreference,
         parserFn: _parserFnQuerySlipsPreference,
       );

  final OnQueryCompleteQuerySlipsPreference? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQuerySlipsPreference extends graphql.WatchQueryOptions<QuerySlipsPreference> {
  WatchOptionsQuerySlipsPreference({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySlipsPreference? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'SlipsPreference',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQuerySlipsPreference,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQuerySlipsPreference,
       );
}

class FetchMoreOptionsQuerySlipsPreference extends graphql.FetchMoreOptions {
  FetchMoreOptionsQuerySlipsPreference({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQuerySlipsPreference);
}

extension ClientExtensionQuerySlipsPreference on graphql.GraphQLClient {
  Future<graphql.QueryResult<QuerySlipsPreference>> querySlipsPreference([
    OptionsQuerySlipsPreference? options,
  ]) async => await this.query(options ?? OptionsQuerySlipsPreference());

  graphql.ObservableQuery<QuerySlipsPreference> watchQuerySlipsPreference([
    WatchOptionsQuerySlipsPreference? options,
  ]) => this.watchQuery(options ?? WatchOptionsQuerySlipsPreference());

  void writeQuerySlipsPreference({required QuerySlipsPreference data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQuerySlipsPreference)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QuerySlipsPreference? readQuerySlipsPreference({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQuerySlipsPreference)),
      optimistic: optimistic,
    );
    return result == null ? null : QuerySlipsPreference.fromJson(result);
  }
}

class QuerySlipsPreferenceuserSettings {
  QuerySlipsPreferenceuserSettings({
    required this.slipsDefaultForCard,
    this.$__typename = 'userSettings',
  });

  factory QuerySlipsPreferenceuserSettings.fromJson(Map<String, dynamic> json) {
    final l$slipsDefaultForCard = json['slipsDefaultForCard'];
    final l$$__typename = json['__typename'];
    return QuerySlipsPreferenceuserSettings(
      slipsDefaultForCard: (l$slipsDefaultForCard as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final bool slipsDefaultForCard;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$slipsDefaultForCard = slipsDefaultForCard;
    _resultData['slipsDefaultForCard'] = l$slipsDefaultForCard;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$slipsDefaultForCard = slipsDefaultForCard;
    final l$$__typename = $__typename;
    return Object.hashAll([l$slipsDefaultForCard, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySlipsPreferenceuserSettings || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slipsDefaultForCard = slipsDefaultForCard;
    final lOther$slipsDefaultForCard = other.slipsDefaultForCard;
    if (l$slipsDefaultForCard != lOther$slipsDefaultForCard) {
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
