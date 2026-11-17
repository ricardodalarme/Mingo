// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class QueryMySpiceAnswers {
  QueryMySpiceAnswers({required this.spiceDesireAnswers, this.$__typename = 'query_root'});

  factory QueryMySpiceAnswers.fromJson(Map<String, dynamic> json) {
    final l$spiceDesireAnswers = json['spiceDesireAnswers'];
    final l$$__typename = json['__typename'];
    return QueryMySpiceAnswers(
      spiceDesireAnswers: (l$spiceDesireAnswers as List<dynamic>)
          .map((e) => QueryMySpiceAnswersspiceDesireAnswers.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMySpiceAnswersspiceDesireAnswers> spiceDesireAnswers;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$spiceDesireAnswers = spiceDesireAnswers;
    _resultData['spiceDesireAnswers'] = l$spiceDesireAnswers.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$spiceDesireAnswers = spiceDesireAnswers;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$spiceDesireAnswers.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMySpiceAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$spiceDesireAnswers = spiceDesireAnswers;
    final lOther$spiceDesireAnswers = other.spiceDesireAnswers;
    if (l$spiceDesireAnswers.length != lOther$spiceDesireAnswers.length) {
      return false;
    }
    for (int i = 0; i < l$spiceDesireAnswers.length; i++) {
      final l$spiceDesireAnswers$entry = l$spiceDesireAnswers[i];
      final lOther$spiceDesireAnswers$entry = lOther$spiceDesireAnswers[i];
      if (l$spiceDesireAnswers$entry != lOther$spiceDesireAnswers$entry) {
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

const documentNodeQueryMySpiceAnswers = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MySpiceAnswers'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'spiceDesireAnswers'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '200'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'contentSlug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'answer'),
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
QueryMySpiceAnswers _parserFnQueryMySpiceAnswers(Map<String, dynamic> data) =>
    QueryMySpiceAnswers.fromJson(data);
typedef OnQueryCompleteQueryMySpiceAnswers = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMySpiceAnswers?,
);

class OptionsQueryMySpiceAnswers extends graphql.QueryOptions<QueryMySpiceAnswers> {
  OptionsQueryMySpiceAnswers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMySpiceAnswers? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMySpiceAnswers? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName ?? 'MySpiceAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMySpiceAnswers(data)),
         onError: onError,
         document: documentNodeQueryMySpiceAnswers,
         parserFn: _parserFnQueryMySpiceAnswers,
       );

  final OnQueryCompleteQueryMySpiceAnswers? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMySpiceAnswers extends graphql.WatchQueryOptions<QueryMySpiceAnswers> {
  WatchOptionsQueryMySpiceAnswers({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMySpiceAnswers? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'MySpiceAnswers',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMySpiceAnswers,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMySpiceAnswers,
       );
}

class FetchMoreOptionsQueryMySpiceAnswers extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMySpiceAnswers({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryMySpiceAnswers);
}

extension ClientExtensionQueryMySpiceAnswers on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMySpiceAnswers>> queryMySpiceAnswers([
    OptionsQueryMySpiceAnswers? options,
  ]) async => await this.query(options ?? OptionsQueryMySpiceAnswers());

  graphql.ObservableQuery<QueryMySpiceAnswers> watchQueryMySpiceAnswers([
    WatchOptionsQueryMySpiceAnswers? options,
  ]) => this.watchQuery(options ?? WatchOptionsQueryMySpiceAnswers());

  void writeQueryMySpiceAnswers({required QueryMySpiceAnswers data, bool broadcast = true}) =>
      this.writeQuery(
        graphql.Request(operation: graphql.Operation(document: documentNodeQueryMySpiceAnswers)),
        data: data.toJson(),
        broadcast: broadcast,
      );

  QueryMySpiceAnswers? readQueryMySpiceAnswers({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(operation: graphql.Operation(document: documentNodeQueryMySpiceAnswers)),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMySpiceAnswers.fromJson(result);
  }
}

class QueryMySpiceAnswersspiceDesireAnswers {
  QueryMySpiceAnswersspiceDesireAnswers({
    required this.contentSlug,
    required this.answer,
    this.$__typename = 'spiceDesireAnswers',
  });

  factory QueryMySpiceAnswersspiceDesireAnswers.fromJson(Map<String, dynamic> json) {
    final l$contentSlug = json['contentSlug'];
    final l$answer = json['answer'];
    final l$$__typename = json['__typename'];
    return QueryMySpiceAnswersspiceDesireAnswers(
      contentSlug: (l$contentSlug as String),
      answer: fromJsonEnumSpiceAnswer_enum((l$answer as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String contentSlug;

  final EnumSpiceAnswer_enum answer;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$contentSlug = contentSlug;
    _resultData['contentSlug'] = l$contentSlug;
    final l$answer = answer;
    _resultData['answer'] = toJsonEnumSpiceAnswer_enum(l$answer);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$contentSlug = contentSlug;
    final l$answer = answer;
    final l$$__typename = $__typename;
    return Object.hashAll([l$contentSlug, l$answer, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMySpiceAnswersspiceDesireAnswers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$contentSlug = contentSlug;
    final lOther$contentSlug = other.contentSlug;
    if (l$contentSlug != lOther$contentSlug) {
      return false;
    }
    final l$answer = answer;
    final lOther$answer = other.answer;
    if (l$answer != lOther$answer) {
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
