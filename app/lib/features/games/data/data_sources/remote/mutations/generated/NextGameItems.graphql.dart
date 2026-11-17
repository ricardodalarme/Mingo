// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationNextGameItems {
  factory VariablesMutationNextGameItems({required String game, int? count}) =>
      VariablesMutationNextGameItems._({r'game': game, if (count != null) r'count': count});

  VariablesMutationNextGameItems._(this._$data);

  factory VariablesMutationNextGameItems.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$game = data['game'];
    result$data['game'] = (l$game as String);
    if (data.containsKey('count')) {
      final l$count = data['count'];
      result$data['count'] = (l$count as int?);
    }
    return VariablesMutationNextGameItems._(result$data);
  }

  Map<String, dynamic> _$data;

  String get game => (_$data['game'] as String);

  int? get count => (_$data['count'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$game = game;
    result$data['game'] = l$game;
    if (_$data.containsKey('count')) {
      final l$count = count;
      result$data['count'] = l$count;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationNextGameItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$game = game;
    final lOther$game = other.game;
    if (l$game != lOther$game) {
      return false;
    }
    final l$count = count;
    final lOther$count = other.count;
    if (_$data.containsKey('count') != other._$data.containsKey('count')) {
      return false;
    }
    if (l$count != lOther$count) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$game = game;
    final l$count = count;
    return Object.hashAll([l$game, _$data.containsKey('count') ? l$count : const {}]);
  }
}

class MutationNextGameItems {
  MutationNextGameItems({required this.nextGameItems, this.$__typename = 'mutation_root'});

  factory MutationNextGameItems.fromJson(Map<String, dynamic> json) {
    final l$nextGameItems = json['nextGameItems'];
    final l$$__typename = json['__typename'];
    return MutationNextGameItems(
      nextGameItems: (l$nextGameItems as List<dynamic>)
          .map((e) => MutationNextGameItemsnextGameItems.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<MutationNextGameItemsnextGameItems> nextGameItems;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$nextGameItems = nextGameItems;
    _resultData['nextGameItems'] = l$nextGameItems.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$nextGameItems = nextGameItems;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$nextGameItems.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationNextGameItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$nextGameItems = nextGameItems;
    final lOther$nextGameItems = other.nextGameItems;
    if (l$nextGameItems.length != lOther$nextGameItems.length) {
      return false;
    }
    for (int i = 0; i < l$nextGameItems.length; i++) {
      final l$nextGameItems$entry = l$nextGameItems[i];
      final lOther$nextGameItems$entry = lOther$nextGameItems[i];
      if (l$nextGameItems$entry != lOther$nextGameItems$entry) {
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

const documentNodeMutationNextGameItems = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'NextGameItems'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'game')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'count')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'nextGameItems'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'args'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'game'),
                      value: VariableNode(name: NameNode(value: 'game')),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'count'),
                      value: VariableNode(name: NameNode(value: 'count')),
                    ),
                  ],
                ),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'slug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'title'),
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
MutationNextGameItems _parserFnMutationNextGameItems(Map<String, dynamic> data) =>
    MutationNextGameItems.fromJson(data);
typedef OnMutationCompletedMutationNextGameItems = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationNextGameItems?,
);

class OptionsMutationNextGameItems extends graphql.MutationOptions<MutationNextGameItems> {
  OptionsMutationNextGameItems({
    String? operationName,
    required VariablesMutationNextGameItems variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationNextGameItems? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationNextGameItems? onCompleted,
    graphql.OnMutationUpdate<MutationNextGameItems>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'NextGameItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) =>
                   onCompleted(data, data == null ? null : _parserFnMutationNextGameItems(data)),
         update: update,
         onError: onError,
         document: documentNodeMutationNextGameItems,
         parserFn: _parserFnMutationNextGameItems,
       );

  final OnMutationCompletedMutationNextGameItems? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationNextGameItems extends graphql.WatchQueryOptions<MutationNextGameItems> {
  WatchOptionsMutationNextGameItems({
    String? operationName,
    required VariablesMutationNextGameItems variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationNextGameItems? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'NextGameItems',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationNextGameItems,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationNextGameItems,
       );
}

extension ClientExtensionMutationNextGameItems on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationNextGameItems>> mutateNextGameItems(
    OptionsMutationNextGameItems options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationNextGameItems> watchMutationNextGameItems(
    WatchOptionsMutationNextGameItems options,
  ) => this.watchMutation(options);
}

class MutationNextGameItemsnextGameItems {
  MutationNextGameItemsnextGameItems({
    required this.slug,
    required this.title,
    this.body,
    this.$__typename = 'contentItems',
  });

  factory MutationNextGameItemsnextGameItems.fromJson(Map<String, dynamic> json) {
    final l$slug = json['slug'];
    final l$title = json['title'];
    final l$body = json['body'];
    final l$$__typename = json['__typename'];
    return MutationNextGameItemsnextGameItems(
      slug: (l$slug as String),
      title: (l$title as String),
      body: (l$body as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String slug;

  final String title;

  final String? body;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$slug = slug;
    final l$title = title;
    final l$body = body;
    final l$$__typename = $__typename;
    return Object.hashAll([l$slug, l$title, l$body, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationNextGameItemsnextGameItems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
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
