// dart format width=100
import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryPartnerTimeZone {
  factory VariablesQueryPartnerTimeZone({required String userId}) =>
      VariablesQueryPartnerTimeZone._({r'userId': userId});

  VariablesQueryPartnerTimeZone._(this._$data);

  factory VariablesQueryPartnerTimeZone.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryPartnerTimeZone._(result$data);
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
    if (other is! VariablesQueryPartnerTimeZone || runtimeType != other.runtimeType) {
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

class QueryPartnerTimeZone {
  QueryPartnerTimeZone({required this.couples, this.$__typename = 'query_root'});

  factory QueryPartnerTimeZone.fromJson(Map<String, dynamic> json) {
    final l$couples = json['couples'];
    final l$$__typename = json['__typename'];
    return QueryPartnerTimeZone(
      couples: (l$couples as List<dynamic>)
          .map((e) => QueryPartnerTimeZonecouples.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryPartnerTimeZonecouples> couples;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$couples = couples;
    _resultData['couples'] = l$couples.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$couples = couples;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$couples.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryPartnerTimeZone || runtimeType != other.runtimeType) {
      return false;
    }
    final l$couples = couples;
    final lOther$couples = other.couples;
    if (l$couples.length != lOther$couples.length) {
      return false;
    }
    for (int i = 0; i < l$couples.length; i++) {
      final l$couples$entry = l$couples[i];
      final lOther$couples$entry = lOther$couples[i];
      if (l$couples$entry != lOther$couples$entry) {
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

const documentNodeQueryPartnerTimeZone = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'PartnerTimeZone'),
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
            name: NameNode(value: 'couples'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'where'),
                value: ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'endedAt'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: '_is_null'),
                            value: BooleanValueNode(value: true),
                          ),
                        ],
                      ),
                    ),
                    ObjectFieldNode(
                      name: NameNode(value: 'members'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: 'userId'),
                            value: ObjectValueNode(
                              fields: [
                                ObjectFieldNode(
                                  name: NameNode(value: '_eq'),
                                  value: VariableNode(name: NameNode(value: 'userId')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ArgumentNode(
                name: NameNode(value: 'limit'),
                value: IntValueNode(value: '1'),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'members'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'where'),
                      value: ObjectValueNode(
                        fields: [
                          ObjectFieldNode(
                            name: NameNode(value: 'userId'),
                            value: ObjectValueNode(
                              fields: [
                                ObjectFieldNode(
                                  name: NameNode(value: '_neq'),
                                  value: VariableNode(name: NameNode(value: 'userId')),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'profile'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'timeZone'),
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
QueryPartnerTimeZone _parserFnQueryPartnerTimeZone(Map<String, dynamic> data) =>
    QueryPartnerTimeZone.fromJson(data);
typedef OnQueryCompleteQueryPartnerTimeZone = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryPartnerTimeZone?,
);

class OptionsQueryPartnerTimeZone extends graphql.QueryOptions<QueryPartnerTimeZone> {
  OptionsQueryPartnerTimeZone({
    String? operationName,
    required VariablesQueryPartnerTimeZone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryPartnerTimeZone? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryPartnerTimeZone? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'PartnerTimeZone',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) =>
                   onComplete(data, data == null ? null : _parserFnQueryPartnerTimeZone(data)),
         onError: onError,
         document: documentNodeQueryPartnerTimeZone,
         parserFn: _parserFnQueryPartnerTimeZone,
       );

  final OnQueryCompleteQueryPartnerTimeZone? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryPartnerTimeZone extends graphql.WatchQueryOptions<QueryPartnerTimeZone> {
  WatchOptionsQueryPartnerTimeZone({
    String? operationName,
    required VariablesQueryPartnerTimeZone variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryPartnerTimeZone? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'PartnerTimeZone',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryPartnerTimeZone,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryPartnerTimeZone,
       );
}

class FetchMoreOptionsQueryPartnerTimeZone extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryPartnerTimeZone({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryPartnerTimeZone variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryPartnerTimeZone,
       );
}

extension ClientExtensionQueryPartnerTimeZone on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryPartnerTimeZone>> queryPartnerTimeZone(
    OptionsQueryPartnerTimeZone options,
  ) async => await this.query(options);

  graphql.ObservableQuery<QueryPartnerTimeZone> watchQueryPartnerTimeZone(
    WatchOptionsQueryPartnerTimeZone options,
  ) => this.watchQuery(options);

  void writeQueryPartnerTimeZone({
    required QueryPartnerTimeZone data,
    required VariablesQueryPartnerTimeZone variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryPartnerTimeZone),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryPartnerTimeZone? readQueryPartnerTimeZone({
    required VariablesQueryPartnerTimeZone variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryPartnerTimeZone),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryPartnerTimeZone.fromJson(result);
  }
}

class QueryPartnerTimeZonecouples {
  QueryPartnerTimeZonecouples({required this.members, this.$__typename = 'couples'});

  factory QueryPartnerTimeZonecouples.fromJson(Map<String, dynamic> json) {
    final l$members = json['members'];
    final l$$__typename = json['__typename'];
    return QueryPartnerTimeZonecouples(
      members: (l$members as List<dynamic>)
          .map((e) => QueryPartnerTimeZonecouplesmembers.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryPartnerTimeZonecouplesmembers> members;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$members = members;
    _resultData['members'] = l$members.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$members = members;
    final l$$__typename = $__typename;
    return Object.hashAll([Object.hashAll(l$members.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryPartnerTimeZonecouples || runtimeType != other.runtimeType) {
      return false;
    }
    final l$members = members;
    final lOther$members = other.members;
    if (l$members.length != lOther$members.length) {
      return false;
    }
    for (int i = 0; i < l$members.length; i++) {
      final l$members$entry = l$members[i];
      final lOther$members$entry = lOther$members[i];
      if (l$members$entry != lOther$members$entry) {
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

class QueryPartnerTimeZonecouplesmembers {
  QueryPartnerTimeZonecouplesmembers({required this.profile, this.$__typename = 'coupleMembers'});

  factory QueryPartnerTimeZonecouplesmembers.fromJson(Map<String, dynamic> json) {
    final l$profile = json['profile'];
    final l$$__typename = json['__typename'];
    return QueryPartnerTimeZonecouplesmembers(
      profile: QueryPartnerTimeZonecouplesmembersprofile.fromJson(
        (l$profile as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final QueryPartnerTimeZonecouplesmembersprofile profile;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$profile = profile;
    _resultData['profile'] = l$profile.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$profile = profile;
    final l$$__typename = $__typename;
    return Object.hashAll([l$profile, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryPartnerTimeZonecouplesmembers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$profile = profile;
    final lOther$profile = other.profile;
    if (l$profile != lOther$profile) {
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

class QueryPartnerTimeZonecouplesmembersprofile {
  QueryPartnerTimeZonecouplesmembersprofile({
    required this.timeZone,
    this.$__typename = 'profiles',
  });

  factory QueryPartnerTimeZonecouplesmembersprofile.fromJson(Map<String, dynamic> json) {
    final l$timeZone = json['timeZone'];
    final l$$__typename = json['__typename'];
    return QueryPartnerTimeZonecouplesmembersprofile(
      timeZone: (l$timeZone as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String timeZone;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$timeZone = timeZone;
    _resultData['timeZone'] = l$timeZone;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$timeZone = timeZone;
    final l$$__typename = $__typename;
    return Object.hashAll([l$timeZone, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryPartnerTimeZonecouplesmembersprofile || runtimeType != other.runtimeType) {
      return false;
    }
    final l$timeZone = timeZone;
    final lOther$timeZone = other.timeZone;
    if (l$timeZone != lOther$timeZone) {
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
