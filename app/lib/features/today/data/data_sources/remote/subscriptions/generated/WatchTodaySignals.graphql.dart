// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class SubscriptionWatchTodaySignals {
  SubscriptionWatchTodaySignals({required this.today});

  factory SubscriptionWatchTodaySignals.fromJson(Map<String, dynamic> json) {
    final l$today = json['today'];
    return SubscriptionWatchTodaySignals(
      today: (l$today as List<dynamic>)
          .map((e) => SubscriptionWatchTodaySignalstoday.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  final List<SubscriptionWatchTodaySignalstoday> today;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$today = today;
    _resultData['today'] = l$today.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$today = today;
    return Object.hashAll([Object.hashAll(l$today.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchTodaySignals || runtimeType != other.runtimeType) {
      return false;
    }
    final l$today = today;
    final lOther$today = other.today;
    if (l$today.length != lOther$today.length) {
      return false;
    }
    for (int i = 0; i < l$today.length; i++) {
      final l$today$entry = l$today[i];
      final lOther$today$entry = lOther$today[i];
      if (l$today$entry != lOther$today$entry) {
        return false;
      }
    }
    return true;
  }
}

const documentNodeSubscriptionWatchTodaySignals = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.subscription,
      name: NameNode(value: 'WatchTodaySignals'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'today'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'localDate'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'partnerId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'partnerName'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'unopenedCards'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'slipsThisWeek'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'slipsTotal'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'hasPendingInvite'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'unseenSignals'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'card'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'status'),
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
                  name: NameNode(value: 'plus'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'hasPlus'),
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
      ),
    ),
  ],
);
SubscriptionWatchTodaySignals _parserFnSubscriptionWatchTodaySignals(Map<String, dynamic> data) =>
    SubscriptionWatchTodaySignals.fromJson(data);

class OptionsSubscriptionWatchTodaySignals
    extends graphql.SubscriptionOptions<SubscriptionWatchTodaySignals> {
  OptionsSubscriptionWatchTodaySignals({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchTodaySignals? typedOptimisticResult,
    graphql.Context? context,
  }) : super(
         operationName: operationName ?? 'WatchTodaySignals',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchTodaySignals,
         parserFn: _parserFnSubscriptionWatchTodaySignals,
       );
}

class WatchOptionsSubscriptionWatchTodaySignals
    extends graphql.WatchQueryOptions<SubscriptionWatchTodaySignals> {
  WatchOptionsSubscriptionWatchTodaySignals({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    SubscriptionWatchTodaySignals? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName ?? 'WatchTodaySignals',
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeSubscriptionWatchTodaySignals,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFnSubscriptionWatchTodaySignals,
       );
}

class FetchMoreOptionsSubscriptionWatchTodaySignals extends graphql.FetchMoreOptions {
  FetchMoreOptionsSubscriptionWatchTodaySignals({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeSubscriptionWatchTodaySignals);
}

extension ClientExtensionSubscriptionWatchTodaySignals on graphql.GraphQLClient {
  Stream<graphql.QueryResult<SubscriptionWatchTodaySignals>> subscribeWatchTodaySignals([
    OptionsSubscriptionWatchTodaySignals? options,
  ]) => this.subscribe(options ?? OptionsSubscriptionWatchTodaySignals());

  graphql.ObservableQuery<SubscriptionWatchTodaySignals> watchSubscriptionWatchTodaySignals([
    WatchOptionsSubscriptionWatchTodaySignals? options,
  ]) => this.watchQuery(options ?? WatchOptionsSubscriptionWatchTodaySignals());
}

class SubscriptionWatchTodaySignalstoday {
  SubscriptionWatchTodaySignalstoday({
    this.localDate,
    this.partnerId,
    this.partnerName,
    this.unopenedCards,
    this.slipsThisWeek,
    this.slipsTotal,
    this.hasPendingInvite,
    this.unseenSignals,
    this.card,
    this.plus,
    this.$__typename = 'today',
  });

  factory SubscriptionWatchTodaySignalstoday.fromJson(Map<String, dynamic> json) {
    final l$localDate = json['localDate'];
    final l$partnerId = json['partnerId'];
    final l$partnerName = json['partnerName'];
    final l$unopenedCards = json['unopenedCards'];
    final l$slipsThisWeek = json['slipsThisWeek'];
    final l$slipsTotal = json['slipsTotal'];
    final l$hasPendingInvite = json['hasPendingInvite'];
    final l$unseenSignals = json['unseenSignals'];
    final l$card = json['card'];
    final l$plus = json['plus'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchTodaySignalstoday(
      localDate: l$localDate == null ? null : DateTime.parse((l$localDate as String)),
      partnerId: (l$partnerId as String?),
      partnerName: (l$partnerName as String?),
      unopenedCards: (l$unopenedCards as int?),
      slipsThisWeek: (l$slipsThisWeek as int?),
      slipsTotal: (l$slipsTotal as int?),
      hasPendingInvite: (l$hasPendingInvite as bool?),
      unseenSignals: (l$unseenSignals as int?),
      card: l$card == null
          ? null
          : SubscriptionWatchTodaySignalstodaycard.fromJson((l$card as Map<String, dynamic>)),
      plus: l$plus == null
          ? null
          : SubscriptionWatchTodaySignalstodayplus.fromJson((l$plus as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime? localDate;

  final String? partnerId;

  final String? partnerName;

  final int? unopenedCards;

  final int? slipsThisWeek;

  final int? slipsTotal;

  final bool? hasPendingInvite;

  final int? unseenSignals;

  final SubscriptionWatchTodaySignalstodaycard? card;

  final SubscriptionWatchTodaySignalstodayplus? plus;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$localDate = localDate;
    _resultData['localDate'] = l$localDate == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$localDate);
    final l$partnerId = partnerId;
    _resultData['partnerId'] = l$partnerId;
    final l$partnerName = partnerName;
    _resultData['partnerName'] = l$partnerName;
    final l$unopenedCards = unopenedCards;
    _resultData['unopenedCards'] = l$unopenedCards;
    final l$slipsThisWeek = slipsThisWeek;
    _resultData['slipsThisWeek'] = l$slipsThisWeek;
    final l$slipsTotal = slipsTotal;
    _resultData['slipsTotal'] = l$slipsTotal;
    final l$hasPendingInvite = hasPendingInvite;
    _resultData['hasPendingInvite'] = l$hasPendingInvite;
    final l$unseenSignals = unseenSignals;
    _resultData['unseenSignals'] = l$unseenSignals;
    final l$card = card;
    _resultData['card'] = l$card?.toJson();
    final l$plus = plus;
    _resultData['plus'] = l$plus?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$localDate = localDate;
    final l$partnerId = partnerId;
    final l$partnerName = partnerName;
    final l$unopenedCards = unopenedCards;
    final l$slipsThisWeek = slipsThisWeek;
    final l$slipsTotal = slipsTotal;
    final l$hasPendingInvite = hasPendingInvite;
    final l$unseenSignals = unseenSignals;
    final l$card = card;
    final l$plus = plus;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$localDate,
      l$partnerId,
      l$partnerName,
      l$unopenedCards,
      l$slipsThisWeek,
      l$slipsTotal,
      l$hasPendingInvite,
      l$unseenSignals,
      l$card,
      l$plus,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchTodaySignalstoday || runtimeType != other.runtimeType) {
      return false;
    }
    final l$localDate = localDate;
    final lOther$localDate = other.localDate;
    if (l$localDate != lOther$localDate) {
      return false;
    }
    final l$partnerId = partnerId;
    final lOther$partnerId = other.partnerId;
    if (l$partnerId != lOther$partnerId) {
      return false;
    }
    final l$partnerName = partnerName;
    final lOther$partnerName = other.partnerName;
    if (l$partnerName != lOther$partnerName) {
      return false;
    }
    final l$unopenedCards = unopenedCards;
    final lOther$unopenedCards = other.unopenedCards;
    if (l$unopenedCards != lOther$unopenedCards) {
      return false;
    }
    final l$slipsThisWeek = slipsThisWeek;
    final lOther$slipsThisWeek = other.slipsThisWeek;
    if (l$slipsThisWeek != lOther$slipsThisWeek) {
      return false;
    }
    final l$slipsTotal = slipsTotal;
    final lOther$slipsTotal = other.slipsTotal;
    if (l$slipsTotal != lOther$slipsTotal) {
      return false;
    }
    final l$hasPendingInvite = hasPendingInvite;
    final lOther$hasPendingInvite = other.hasPendingInvite;
    if (l$hasPendingInvite != lOther$hasPendingInvite) {
      return false;
    }
    final l$unseenSignals = unseenSignals;
    final lOther$unseenSignals = other.unseenSignals;
    if (l$unseenSignals != lOther$unseenSignals) {
      return false;
    }
    final l$card = card;
    final lOther$card = other.card;
    if (l$card != lOther$card) {
      return false;
    }
    final l$plus = plus;
    final lOther$plus = other.plus;
    if (l$plus != lOther$plus) {
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

class SubscriptionWatchTodaySignalstodaycard {
  SubscriptionWatchTodaySignalstodaycard({required this.status, this.$__typename = 'cards'});

  factory SubscriptionWatchTodaySignalstodaycard.fromJson(Map<String, dynamic> json) {
    final l$status = json['status'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchTodaySignalstodaycard(
      status: fromJsonEnumCardStatus_enum((l$status as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumCardStatus_enum status;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$status = status;
    _resultData['status'] = toJsonEnumCardStatus_enum(l$status);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$status = status;
    final l$$__typename = $__typename;
    return Object.hashAll([l$status, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchTodaySignalstodaycard || runtimeType != other.runtimeType) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
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

class SubscriptionWatchTodaySignalstodayplus {
  SubscriptionWatchTodaySignalstodayplus({this.hasPlus, this.$__typename = 'plusStates'});

  factory SubscriptionWatchTodaySignalstodayplus.fromJson(Map<String, dynamic> json) {
    final l$hasPlus = json['hasPlus'];
    final l$$__typename = json['__typename'];
    return SubscriptionWatchTodaySignalstodayplus(
      hasPlus: (l$hasPlus as bool?),
      $__typename: (l$$__typename as String),
    );
  }

  final bool? hasPlus;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$hasPlus = hasPlus;
    _resultData['hasPlus'] = l$hasPlus;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$hasPlus = hasPlus;
    final l$$__typename = $__typename;
    return Object.hashAll([l$hasPlus, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! SubscriptionWatchTodaySignalstodayplus || runtimeType != other.runtimeType) {
      return false;
    }
    final l$hasPlus = hasPlus;
    final lOther$hasPlus = other.hasPlus;
    if (l$hasPlus != lOther$hasPlus) {
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
