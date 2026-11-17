// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QuerySpiceState {
  QuerySpiceState({required this.spiceState, this.$__typename = 'query_root'});

  factory QuerySpiceState.fromJson(Map<String, dynamic> json) {
    final l$spiceState = json['spiceState'];
    final l$$__typename = json['__typename'];
    return QuerySpiceState(
      spiceState: (l$spiceState as List<dynamic>)
          .map((e) => QuerySpiceStatespiceState.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QuerySpiceStatespiceState> spiceState;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceState = spiceState;
    _resultData['spiceState'] = l$spiceState.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceState = spiceState;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$spiceState.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySpiceState || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceState = spiceState;
    final lOther$spiceState = other.spiceState;
    if (l$spiceState.length != lOther$spiceState.length) {
      return false;
    }
    for (int i = 0; i < l$spiceState.length; i++) {
      final l$spiceState$entry = l$spiceState[i];
      final lOther$spiceState$entry = lOther$spiceState[i];
      if (l$spiceState$entry != lOther$spiceState$entry) {
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

const documentNodeQuerySpiceState = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SpiceState'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceState'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'state'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'myLevel'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'coupleLevel'),
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
QuerySpiceState _parserFnQuerySpiceState(Map<String, dynamic> data) =>
    QuerySpiceState.fromJson(data);
typedef OnQueryCompleteQuerySpiceState = FutureOr<void> Function(
  Map<String, dynamic>?,
  QuerySpiceState?,
);

class OptionsQuerySpiceState extends graphql.QueryOptions<QuerySpiceState> {
  OptionsQuerySpiceState({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySpiceState? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQuerySpiceState? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'SpiceState',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQuerySpiceState(data)),
         onError: onError,
         document: documentNodeQuerySpiceState,
         parserFn: _parserFnQuerySpiceState,
       );

  final OnQueryCompleteQuerySpiceState? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQuerySpiceState extends graphql.WatchQueryOptions<QuerySpiceState> {
  WatchOptionsQuerySpiceState({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QuerySpiceState? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'SpiceState',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQuerySpiceState,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQuerySpiceState,
       );
}

class FetchMoreOptionsQuerySpiceState extends graphql.FetchMoreOptions {
  FetchMoreOptionsQuerySpiceState({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQuerySpiceState);
}

extension ClientExtensionQuerySpiceState on graphql.GraphQLClient {
  Future<graphql.QueryResult<QuerySpiceState>> querySpiceState([
    OptionsQuerySpiceState? options,
  ]) async => await this.query(options ?? OptionsQuerySpiceState());

  graphql.ObservableQuery<QuerySpiceState> watchQuerySpiceState([
    WatchOptionsQuerySpiceState? options,
  ]) => this.watchQuery(options ?? WatchOptionsQuerySpiceState());

  void writeQuerySpiceState({required QuerySpiceState data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQuerySpiceState)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QuerySpiceState? readQuerySpiceState({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQuerySpiceState)),
      optimistic: optimistic,
    );
    return result == null ? null : QuerySpiceState.fromJson(result);
  }
}

class QuerySpiceStatespiceState {
  QuerySpiceStatespiceState({
    required this.state,
    this.myLevel,
    this.coupleLevel,
    this.$__typename = 'spiceStates',
  });

  factory QuerySpiceStatespiceState.fromJson(Map<String, dynamic> json) {
    final l$state = json['state'];
    final l$myLevel = json['myLevel'];
    final l$coupleLevel = json['coupleLevel'];
    final l$$__typename = json['__typename'];
    return QuerySpiceStatespiceState(
      state: fromJsonEnumSpiceStage_enum((l$state as String)),
      myLevel: (l$myLevel as int?),
      coupleLevel: (l$coupleLevel as int?),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumSpiceStage_enum state;

  final int? myLevel;

  final int? coupleLevel;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$state = state;
    _resultData['state'] = toJsonEnumSpiceStage_enum(l$state);
    final l$myLevel = myLevel;
    _resultData['myLevel'] = l$myLevel;
    final l$coupleLevel = coupleLevel;
    _resultData['coupleLevel'] = l$coupleLevel;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$state = state;
    final l$myLevel = myLevel;
    final l$coupleLevel = coupleLevel;
    final l$$__typename = $__typename;
    return Object.hashAll([l$state, l$myLevel, l$coupleLevel, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QuerySpiceStatespiceState || runtimeType != other.runtimeType) {
      return false;
    }
    final l$state = state;
    final lOther$state = other.state;
    if (l$state != lOther$state) {
      return false;
    }
    final l$myLevel = myLevel;
    final lOther$myLevel = other.myLevel;
    if (l$myLevel != lOther$myLevel) {
      return false;
    }
    final l$coupleLevel = coupleLevel;
    final lOther$coupleLevel = other.coupleLevel;
    if (l$coupleLevel != lOther$coupleLevel) {
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
