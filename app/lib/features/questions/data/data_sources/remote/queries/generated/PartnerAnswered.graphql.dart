// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:network/network.dart';

class VariablesQueryPartnerAnswered {
  factory VariablesQueryPartnerAnswered({required dynamic slugs}) =>
      VariablesQueryPartnerAnswered._({r'slugs': slugs});

  VariablesQueryPartnerAnswered._(this._$data);

  factory VariablesQueryPartnerAnswered.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$slugs = data['slugs'];
    result$data['slugs'] = decodeJsonb(l$slugs);
    return VariablesQueryPartnerAnswered._(result$data);
  }

  Map<String, dynamic> _$data;

  dynamic get slugs => (_$data['slugs'] as dynamic);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$slugs = slugs;
    result$data['slugs'] = encodeJsonb(l$slugs);
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesQueryPartnerAnswered || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slugs = slugs;
    final lOther$slugs = other.slugs;
    if (l$slugs != lOther$slugs) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$slugs = slugs;
    return Object.hashAll([l$slugs]);
  }
}

class QueryPartnerAnswered {
  QueryPartnerAnswered({required this.partnerQuestionStates, this.$__typename = 'query_root'});

  factory QueryPartnerAnswered.fromJson(Map<String, dynamic> json) {
    final l$partnerQuestionStates = json['partnerQuestionStates'];
    final l$$__typename = json['__typename'];
    return QueryPartnerAnswered(
      partnerQuestionStates: (l$partnerQuestionStates as List<dynamic>)
          .map(
            (e) => QueryPartnerAnsweredpartnerQuestionStates.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryPartnerAnsweredpartnerQuestionStates> partnerQuestionStates;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$partnerQuestionStates = partnerQuestionStates;
    _resultData['partnerQuestionStates'] = l$partnerQuestionStates.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$partnerQuestionStates = partnerQuestionStates;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$partnerQuestionStates.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryPartnerAnswered || runtimeType != other.runtimeType) {
      return false;
    }
    final l$partnerQuestionStates = partnerQuestionStates;
    final lOther$partnerQuestionStates = other.partnerQuestionStates;
    if (l$partnerQuestionStates.length != lOther$partnerQuestionStates.length) {
      return false;
    }
    for (int i = 0; i < l$partnerQuestionStates.length; i++) {
      final l$partnerQuestionStates$entry = l$partnerQuestionStates[i];
      final lOther$partnerQuestionStates$entry = lOther$partnerQuestionStates[i];
      if (l$partnerQuestionStates$entry != lOther$partnerQuestionStates$entry) {
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

const documentNodeQueryPartnerAnswered = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'PartnerAnswered'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'slugs')),
          type: NamedTypeNode(name: NameNode(value: 'jsonb'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'partnerQuestionStates'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'questionSlugs'),
                      value: VariableNode(name: NameNode(value: 'slugs')),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'questionSlug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'partnerAnswered'),
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
QueryPartnerAnswered _parserFnQueryPartnerAnswered(Map<String, dynamic> data) =>
    QueryPartnerAnswered.fromJson(data);
typedef OnQueryCompleteQueryPartnerAnswered = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryPartnerAnswered?,
);

class OptionsQueryPartnerAnswered extends graphql.QueryOptions<QueryPartnerAnswered> {
  OptionsQueryPartnerAnswered({
    String? operationName,
    required VariablesQueryPartnerAnswered variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryPartnerAnswered? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryPartnerAnswered? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'PartnerAnswered',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryPartnerAnswered(data)),
         onError: onError,
         document: documentNodeQueryPartnerAnswered,
         parserFn: _parserFnQueryPartnerAnswered,
       );

  final OnQueryCompleteQueryPartnerAnswered? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryPartnerAnswered extends graphql.WatchQueryOptions<QueryPartnerAnswered> {
  WatchOptionsQueryPartnerAnswered({
    String? operationName,
    required VariablesQueryPartnerAnswered variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryPartnerAnswered? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'PartnerAnswered',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryPartnerAnswered,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryPartnerAnswered,
       );
}

class FetchMoreOptionsQueryPartnerAnswered extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryPartnerAnswered({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryPartnerAnswered variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryPartnerAnswered,
       );
}

extension ClientExtensionQueryPartnerAnswered on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryPartnerAnswered>> queryPartnerAnswered(
    OptionsQueryPartnerAnswered options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryPartnerAnswered> watchQueryPartnerAnswered(
    WatchOptionsQueryPartnerAnswered options,
  ) => this.watchQuery(options);

  void writeQueryPartnerAnswered({
    required QueryPartnerAnswered data,
    required VariablesQueryPartnerAnswered variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryPartnerAnswered),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryPartnerAnswered? readQueryPartnerAnswered({
    required VariablesQueryPartnerAnswered variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryPartnerAnswered),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryPartnerAnswered.fromJson(result);
  }
}

class QueryPartnerAnsweredpartnerQuestionStates {
  QueryPartnerAnsweredpartnerQuestionStates({
    required this.questionSlug,
    required this.partnerAnswered,
    this.$__typename = 'questionStates',
  });

  factory QueryPartnerAnsweredpartnerQuestionStates.fromJson(Map<String, dynamic> json) {
    final l$questionSlug = json['questionSlug'];
    final l$partnerAnswered = json['partnerAnswered'];
    final l$$__typename = json['__typename'];
    return QueryPartnerAnsweredpartnerQuestionStates(
      questionSlug: (l$questionSlug as String),
      partnerAnswered: (l$partnerAnswered as bool),
      $__typename: (l$$__typename as String),
    );
  }

  final String questionSlug;

  final bool partnerAnswered;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$questionSlug = questionSlug;
    _resultData['questionSlug'] = l$questionSlug;
    final l$partnerAnswered = partnerAnswered;
    _resultData['partnerAnswered'] = l$partnerAnswered;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$questionSlug = questionSlug;
    final l$partnerAnswered = partnerAnswered;
    final l$$__typename = $__typename;
    return Object.hashAll([l$questionSlug, l$partnerAnswered, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryPartnerAnsweredpartnerQuestionStates || runtimeType != other.runtimeType) {
      return false;
    }
    final l$questionSlug = questionSlug;
    final lOther$questionSlug = other.questionSlug;
    if (l$questionSlug != lOther$questionSlug) {
      return false;
    }
    final l$partnerAnswered = partnerAnswered;
    final lOther$partnerAnswered = other.partnerAnswered;
    if (l$partnerAnswered != lOther$partnerAnswered) {
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
