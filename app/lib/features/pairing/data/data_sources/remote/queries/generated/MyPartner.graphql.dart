// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class VariablesQueryMyPartner {
  factory VariablesQueryMyPartner({required String userId}) =>
      VariablesQueryMyPartner._({r'userId': userId});

  VariablesQueryMyPartner._(this._$data);

  factory VariablesQueryMyPartner.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    return VariablesQueryMyPartner._(result$data);
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
    if (other is! VariablesQueryMyPartner || runtimeType != other.runtimeType) {
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

class QueryMyPartner {
  QueryMyPartner({required this.couples, this.$__typename = 'query_root'});

  factory QueryMyPartner.fromJson(Map<String, dynamic> json) {
    final l$couples = json['couples'];
    final l$$__typename = json['__typename'];
    return QueryMyPartner(
      couples: (l$couples as List<dynamic>)
          .map((e) => QueryMyPartnercouples.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<QueryMyPartnercouples> couples;

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
    if (other is! QueryMyPartner || runtimeType != other.runtimeType) {
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

const documentNodeQueryMyPartner = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'MyPartner'),
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
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'members'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'userId'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                      FieldNode(
                        name: NameNode(value: 'profile'),
                        alias: null,
                        arguments: [],
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
                              name: NameNode(value: 'displayName'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'avatarKind'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'city'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: 'pronouns'),
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
QueryMyPartner _parserFnQueryMyPartner(Map<String, dynamic> data) => QueryMyPartner.fromJson(data);
typedef OnQueryCompleteQueryMyPartner = FutureOr<void> Function(
  Map<String, dynamic>?,
  QueryMyPartner?,
);

class OptionsQueryMyPartner extends graphql.QueryOptions<QueryMyPartner> {
  OptionsQueryMyPartner({
    String? operationName,
    required VariablesQueryMyPartner variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyPartner? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryCompleteQueryMyPartner? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyPartner',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(data, data == null ? null : _parserFnQueryMyPartner(data)),
         onError: onError,
         document: documentNodeQueryMyPartner,
         parserFn: _parserFnQueryMyPartner,
       );

  final OnQueryCompleteQueryMyPartner? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptionsQueryMyPartner extends graphql.WatchQueryOptions<QueryMyPartner> {
  WatchOptionsQueryMyPartner({
    String? operationName,
    required VariablesQueryMyPartner variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    QueryMyPartner? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName ?? 'MyPartner',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryMyPartner,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnQueryMyPartner,
       );
}

class FetchMoreOptionsQueryMyPartner extends graphql.FetchMoreOptions {
  FetchMoreOptionsQueryMyPartner({
    required graphql.UpdateQuery updateQuery,
    required VariablesQueryMyPartner variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryMyPartner,
       );
}

extension ClientExtensionQueryMyPartner on graphql.GraphQLClient {
  Future<graphql.QueryResult<QueryMyPartner>> queryMyPartner(OptionsQueryMyPartner options) async =>
      await this.query(options);

  graphql.ObservableQuery<QueryMyPartner> watchQueryMyPartner(WatchOptionsQueryMyPartner options) =>
      this.watchQuery(options);

  void writeQueryMyPartner({
    required QueryMyPartner data,
    required VariablesQueryMyPartner variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryMyPartner),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  QueryMyPartner? readQueryMyPartner({
    required VariablesQueryMyPartner variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryMyPartner),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : QueryMyPartner.fromJson(result);
  }
}

class QueryMyPartnercouples {
  QueryMyPartnercouples({required this.id, required this.members, this.$__typename = 'couples'});

  factory QueryMyPartnercouples.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$members = json['members'];
    final l$$__typename = json['__typename'];
    return QueryMyPartnercouples(
      id: (l$id as String),
      members: (l$members as List<dynamic>)
          .map((e) => QueryMyPartnercouplesmembers.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final List<QueryMyPartnercouplesmembers> members;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$members = members;
    _resultData['members'] = l$members.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$members = members;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, Object.hashAll(l$members.map((v) => v)), l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyPartnercouples || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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

class QueryMyPartnercouplesmembers {
  QueryMyPartnercouplesmembers({
    required this.userId,
    required this.profile,
    this.$__typename = 'coupleMembers',
  });

  factory QueryMyPartnercouplesmembers.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$profile = json['profile'];
    final l$$__typename = json['__typename'];
    return QueryMyPartnercouplesmembers(
      userId: (l$userId as String),
      profile: QueryMyPartnercouplesmembersprofile.fromJson((l$profile as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final QueryMyPartnercouplesmembersprofile profile;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$profile = profile;
    _resultData['profile'] = l$profile.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$profile = profile;
    final l$$__typename = $__typename;
    return Object.hashAll([l$userId, l$profile, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyPartnercouplesmembers || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
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

class QueryMyPartnercouplesmembersprofile {
  QueryMyPartnercouplesmembersprofile({
    required this.id,
    this.displayName,
    required this.avatarKind,
    this.city,
    this.pronouns,
    this.$__typename = 'profiles',
  });

  factory QueryMyPartnercouplesmembersprofile.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$displayName = json['displayName'];
    final l$avatarKind = json['avatarKind'];
    final l$city = json['city'];
    final l$pronouns = json['pronouns'];
    final l$$__typename = json['__typename'];
    return QueryMyPartnercouplesmembersprofile(
      id: (l$id as String),
      displayName: (l$displayName as String?),
      avatarKind: fromJsonEnumAvatarKind_enum((l$avatarKind as String)),
      city: (l$city as String?),
      pronouns: (l$pronouns as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? displayName;

  final EnumAvatarKind_enum avatarKind;

  final String? city;

  final String? pronouns;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$displayName = displayName;
    _resultData['displayName'] = l$displayName;
    final l$avatarKind = avatarKind;
    _resultData['avatarKind'] = toJsonEnumAvatarKind_enum(l$avatarKind);
    final l$city = city;
    _resultData['city'] = l$city;
    final l$pronouns = pronouns;
    _resultData['pronouns'] = l$pronouns;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$displayName = displayName;
    final l$avatarKind = avatarKind;
    final l$city = city;
    final l$pronouns = pronouns;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$displayName, l$avatarKind, l$city, l$pronouns, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! QueryMyPartnercouplesmembersprofile || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$displayName = displayName;
    final lOther$displayName = other.displayName;
    if (l$displayName != lOther$displayName) {
      return false;
    }
    final l$avatarKind = avatarKind;
    final lOther$avatarKind = other.avatarKind;
    if (l$avatarKind != lOther$avatarKind) {
      return false;
    }
    final l$city = city;
    final lOther$city = other.city;
    if (l$city != lOther$city) {
      return false;
    }
    final l$pronouns = pronouns;
    final lOther$pronouns = other.pronouns;
    if (l$pronouns != lOther$pronouns) {
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
