// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesMutationCreateSupportRequest {
  factory VariablesMutationCreateSupportRequest({
    required EnumSupportTopic_enum topic,
    required String message,
    String? replyEmail,
    String? appVersion,
  }) => VariablesMutationCreateSupportRequest._({
    r'topic': topic,
    r'message': message,
    if (replyEmail != null) r'replyEmail': replyEmail,
    if (appVersion != null) r'appVersion': appVersion,
  });

  VariablesMutationCreateSupportRequest._(this._$data);

  factory VariablesMutationCreateSupportRequest.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$topic = data['topic'];
    result$data['topic'] = fromJsonEnumSupportTopic_enum((l$topic as String));
    final l$message = data['message'];
    result$data['message'] = (l$message as String);
    if (data.containsKey('replyEmail')) {
      final l$replyEmail = data['replyEmail'];
      result$data['replyEmail'] = (l$replyEmail as String?);
    }
    if (data.containsKey('appVersion')) {
      final l$appVersion = data['appVersion'];
      result$data['appVersion'] = (l$appVersion as String?);
    }
    return VariablesMutationCreateSupportRequest._(result$data);
  }

  Map<String, dynamic> _$data;

  EnumSupportTopic_enum get topic => (_$data['topic'] as EnumSupportTopic_enum);

  String get message => (_$data['message'] as String);

  String? get replyEmail => (_$data['replyEmail'] as String?);

  String? get appVersion => (_$data['appVersion'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$topic = topic;
    result$data['topic'] = toJsonEnumSupportTopic_enum(l$topic);
    final l$message = message;
    result$data['message'] = l$message;
    if (_$data.containsKey('replyEmail')) {
      final l$replyEmail = replyEmail;
      result$data['replyEmail'] = l$replyEmail;
    }
    if (_$data.containsKey('appVersion')) {
      final l$appVersion = appVersion;
      result$data['appVersion'] = l$appVersion;
    }
    return result$data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! VariablesMutationCreateSupportRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$topic = topic;
    final lOther$topic = other.topic;
    if (l$topic != lOther$topic) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$replyEmail = replyEmail;
    final lOther$replyEmail = other.replyEmail;
    if (_$data.containsKey('replyEmail') != other._$data.containsKey('replyEmail')) {
      return false;
    }
    if (l$replyEmail != lOther$replyEmail) {
      return false;
    }
    final l$appVersion = appVersion;
    final lOther$appVersion = other.appVersion;
    if (_$data.containsKey('appVersion') != other._$data.containsKey('appVersion')) {
      return false;
    }
    if (l$appVersion != lOther$appVersion) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$topic = topic;
    final l$message = message;
    final l$replyEmail = replyEmail;
    final l$appVersion = appVersion;
    return Object.hashAll([
      l$topic,
      l$message,
      _$data.containsKey('replyEmail') ? l$replyEmail : const {},
      _$data.containsKey('appVersion') ? l$appVersion : const {},
    ]);
  }
}

class MutationCreateSupportRequest {
  MutationCreateSupportRequest({this.insertSupportRequests, this.$__typename = 'mutation_root'});

  factory MutationCreateSupportRequest.fromJson(Map<String, dynamic> json) {
    final l$insertSupportRequests = json['insertSupportRequests'];
    final l$$__typename = json['__typename'];
    return MutationCreateSupportRequest(
      insertSupportRequests: l$insertSupportRequests == null
          ? null
          : MutationCreateSupportRequestinsertSupportRequests.fromJson(
              (l$insertSupportRequests as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final MutationCreateSupportRequestinsertSupportRequests? insertSupportRequests;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$insertSupportRequests = insertSupportRequests;
    _resultData['insertSupportRequests'] = l$insertSupportRequests?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$insertSupportRequests = insertSupportRequests;
    final l$$__typename = $__typename;
    return Object.hashAll([l$insertSupportRequests, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! MutationCreateSupportRequest || runtimeType != other.runtimeType) {
      return false;
    }
    final l$insertSupportRequests = insertSupportRequests;
    final lOther$insertSupportRequests = other.insertSupportRequests;
    if (l$insertSupportRequests != lOther$insertSupportRequests) {
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

const documentNodeMutationCreateSupportRequest = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CreateSupportRequest'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'topic')),
          type: NamedTypeNode(name: NameNode(value: 'SupportTopic_enum'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'message')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'replyEmail')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'appVersion')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'insertSupportRequests'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'objects'),
                value: ListValueNode(
                  values: [
                    ObjectValueNode(
                      fields: [
                        ObjectFieldNode(
                          name: NameNode(value: 'topic'),
                          value: VariableNode(name: NameNode(value: 'topic')),
                        ),
                        ObjectFieldNode(
                          name: NameNode(value: 'message'),
                          value: VariableNode(name: NameNode(value: 'message')),
                        ),
                        ObjectFieldNode(
                          name: NameNode(value: 'replyEmail'),
                          value: VariableNode(name: NameNode(value: 'replyEmail')),
                        ),
                        ObjectFieldNode(
                          name: NameNode(value: 'appVersion'),
                          value: VariableNode(name: NameNode(value: 'appVersion')),
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
MutationCreateSupportRequest _parserFnMutationCreateSupportRequest(Map<String, dynamic> data) =>
    MutationCreateSupportRequest.fromJson(data);
typedef OnMutationCompletedMutationCreateSupportRequest = FutureOr<void> Function(
  Map<String, dynamic>?,
  MutationCreateSupportRequest?,
);

class OptionsMutationCreateSupportRequest
    extends graphql.MutationOptions<MutationCreateSupportRequest> {
  OptionsMutationCreateSupportRequest({
    String? operationName,
    required VariablesMutationCreateSupportRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationCreateSupportRequest? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompletedMutationCreateSupportRequest? onCompleted,
    graphql.OnMutationUpdate<MutationCreateSupportRequest>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CreateSupportRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFnMutationCreateSupportRequest(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationCreateSupportRequest,
         parserFn: _parserFnMutationCreateSupportRequest,
       );

  final OnMutationCompletedMutationCreateSupportRequest? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptionsMutationCreateSupportRequest
    extends graphql.WatchQueryOptions<MutationCreateSupportRequest> {
  WatchOptionsMutationCreateSupportRequest({
    String? operationName,
    required VariablesMutationCreateSupportRequest variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    MutationCreateSupportRequest? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'CreateSupportRequest',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationCreateSupportRequest,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnMutationCreateSupportRequest,
       );
}

extension ClientExtensionMutationCreateSupportRequest on graphql.GraphQLClient {
  Future<graphql.QueryResult<MutationCreateSupportRequest>> mutateCreateSupportRequest(
    OptionsMutationCreateSupportRequest options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<MutationCreateSupportRequest> watchMutationCreateSupportRequest(
    WatchOptionsMutationCreateSupportRequest options,
  ) => this.watchMutation(options);
}

class MutationCreateSupportRequestinsertSupportRequests {
  MutationCreateSupportRequestinsertSupportRequests({
    required this.affected_rows,
    this.$__typename = 'supportRequests_mutation_response',
  });

  factory MutationCreateSupportRequestinsertSupportRequests.fromJson(Map<String, dynamic> json) {
    final l$affected_rows = json['affected_rows'];
    final l$$__typename = json['__typename'];
    return MutationCreateSupportRequestinsertSupportRequests(
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
    if (other is! MutationCreateSupportRequestinsertSupportRequests ||
        runtimeType != other.runtimeType) {
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
