// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentSettingsFragment {
  FragmentSettingsFragment({
    required this.userId,
    required this.theme,
    this.partnerName,
    this.partnerPronouns,
    this.partnerIntent,
    this.togetherSince,
    required this.relationshipStatus,
    this.onboardedAt,
    required this.shareReadReceipts,
    this.phase,
    required this.goals,
    required this.locale,
    this.$__typename = 'userSettings',
  });

  factory FragmentSettingsFragment.fromJson(Map<String, dynamic> json) {
    final l$userId = json['userId'];
    final l$theme = json['theme'];
    final l$partnerName = json['partnerName'];
    final l$partnerPronouns = json['partnerPronouns'];
    final l$partnerIntent = json['partnerIntent'];
    final l$togetherSince = json['togetherSince'];
    final l$relationshipStatus = json['relationshipStatus'];
    final l$onboardedAt = json['onboardedAt'];
    final l$shareReadReceipts = json['shareReadReceipts'];
    final l$phase = json['phase'];
    final l$goals = json['goals'];
    final l$locale = json['locale'];
    final l$$__typename = json['__typename'];
    return FragmentSettingsFragment(
      userId: (l$userId as String),
      theme: fromJsonEnumAppTheme_enum((l$theme as String)),
      partnerName: (l$partnerName as String?),
      partnerPronouns: l$partnerPronouns == null
          ? null
          : fromJsonEnumPronoun_enum((l$partnerPronouns as String)),
      partnerIntent: l$partnerIntent == null
          ? null
          : fromJsonEnumPartnerIntent_enum((l$partnerIntent as String)),
      togetherSince: l$togetherSince == null ? null : DateTime.parse((l$togetherSince as String)),
      relationshipStatus: fromJsonEnumRelationshipStatus_enum((l$relationshipStatus as String)),
      onboardedAt: l$onboardedAt == null ? null : DateTime.parse((l$onboardedAt as String)),
      shareReadReceipts: (l$shareReadReceipts as bool),
      phase: l$phase == null ? null : fromJsonEnumRelationshipPhase_enum((l$phase as String)),
      goals: (l$goals as List<dynamic>)
          .map((e) => FragmentSettingsFragmentgoals.fromJson((e as Map<String, dynamic>)))
          .toList(),
      locale: (l$locale as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String userId;

  final EnumAppTheme_enum theme;

  final String? partnerName;

  final EnumPronoun_enum? partnerPronouns;

  final EnumPartnerIntent_enum? partnerIntent;

  final DateTime? togetherSince;

  final EnumRelationshipStatus_enum relationshipStatus;

  final DateTime? onboardedAt;

  final bool shareReadReceipts;

  final EnumRelationshipPhase_enum? phase;

  final List<FragmentSettingsFragmentgoals> goals;

  final String locale;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$theme = theme;
    _resultData['theme'] = toJsonEnumAppTheme_enum(l$theme);
    final l$partnerName = partnerName;
    _resultData['partnerName'] = l$partnerName;
    final l$partnerPronouns = partnerPronouns;
    _resultData['partnerPronouns'] = l$partnerPronouns == null
        ? null
        : toJsonEnumPronoun_enum(l$partnerPronouns);
    final l$partnerIntent = partnerIntent;
    _resultData['partnerIntent'] = l$partnerIntent == null
        ? null
        : toJsonEnumPartnerIntent_enum(l$partnerIntent);
    final l$togetherSince = togetherSince;
    _resultData['togetherSince'] = l$togetherSince == null
        ? null
        : ((v) => v.toIso8601String().substring(0, 10))(l$togetherSince);
    final l$relationshipStatus = relationshipStatus;
    _resultData['relationshipStatus'] = toJsonEnumRelationshipStatus_enum(l$relationshipStatus);
    final l$onboardedAt = onboardedAt;
    _resultData['onboardedAt'] = l$onboardedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$onboardedAt);
    final l$shareReadReceipts = shareReadReceipts;
    _resultData['shareReadReceipts'] = l$shareReadReceipts;
    final l$phase = phase;
    _resultData['phase'] = l$phase == null ? null : toJsonEnumRelationshipPhase_enum(l$phase);
    final l$goals = goals;
    _resultData['goals'] = l$goals.map((e) => e.toJson()).toList();
    final l$locale = locale;
    _resultData['locale'] = l$locale;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$theme = theme;
    final l$partnerName = partnerName;
    final l$partnerPronouns = partnerPronouns;
    final l$partnerIntent = partnerIntent;
    final l$togetherSince = togetherSince;
    final l$relationshipStatus = relationshipStatus;
    final l$onboardedAt = onboardedAt;
    final l$shareReadReceipts = shareReadReceipts;
    final l$phase = phase;
    final l$goals = goals;
    final l$locale = locale;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$userId,
      l$theme,
      l$partnerName,
      l$partnerPronouns,
      l$partnerIntent,
      l$togetherSince,
      l$relationshipStatus,
      l$onboardedAt,
      l$shareReadReceipts,
      l$phase,
      Object.hashAll(l$goals.map((v) => v)),
      l$locale,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentSettingsFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$theme = theme;
    final lOther$theme = other.theme;
    if (l$theme != lOther$theme) {
      return false;
    }
    final l$partnerName = partnerName;
    final lOther$partnerName = other.partnerName;
    if (l$partnerName != lOther$partnerName) {
      return false;
    }
    final l$partnerPronouns = partnerPronouns;
    final lOther$partnerPronouns = other.partnerPronouns;
    if (l$partnerPronouns != lOther$partnerPronouns) {
      return false;
    }
    final l$partnerIntent = partnerIntent;
    final lOther$partnerIntent = other.partnerIntent;
    if (l$partnerIntent != lOther$partnerIntent) {
      return false;
    }
    final l$togetherSince = togetherSince;
    final lOther$togetherSince = other.togetherSince;
    if (l$togetherSince != lOther$togetherSince) {
      return false;
    }
    final l$relationshipStatus = relationshipStatus;
    final lOther$relationshipStatus = other.relationshipStatus;
    if (l$relationshipStatus != lOther$relationshipStatus) {
      return false;
    }
    final l$onboardedAt = onboardedAt;
    final lOther$onboardedAt = other.onboardedAt;
    if (l$onboardedAt != lOther$onboardedAt) {
      return false;
    }
    final l$shareReadReceipts = shareReadReceipts;
    final lOther$shareReadReceipts = other.shareReadReceipts;
    if (l$shareReadReceipts != lOther$shareReadReceipts) {
      return false;
    }
    final l$phase = phase;
    final lOther$phase = other.phase;
    if (l$phase != lOther$phase) {
      return false;
    }
    final l$goals = goals;
    final lOther$goals = other.goals;
    if (l$goals.length != lOther$goals.length) {
      return false;
    }
    for (int i = 0; i < l$goals.length; i++) {
      final l$goals$entry = l$goals[i];
      final lOther$goals$entry = lOther$goals[i];
      if (l$goals$entry != lOther$goals$entry) {
        return false;
      }
    }
    final l$locale = locale;
    final lOther$locale = other.locale;
    if (l$locale != lOther$locale) {
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

const fragmentDefinitionSettingsFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SettingsFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'userSettings'), isNonNull: false),
  ),
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
        name: NameNode(value: 'theme'),
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
        name: NameNode(value: 'partnerPronouns'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'partnerIntent'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'togetherSince'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'relationshipStatus'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'onboardedAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'shareReadReceipts'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'phase'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'goals'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'goal'),
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
        name: NameNode(value: 'locale'),
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
);
const documentNodeFragmentSettingsFragment = DocumentNode(
  definitions: [fragmentDefinitionSettingsFragment],
);

extension ClientExtensionFragmentSettingsFragment on graphql.GraphQLClient {
  void writeFragmentSettingsFragment({
    required FragmentSettingsFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SettingsFragment',
        document: documentNodeFragmentSettingsFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentSettingsFragment? readFragmentSettingsFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SettingsFragment',
          document: documentNodeFragmentSettingsFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentSettingsFragment.fromJson(result);
  }
}

class FragmentSettingsFragmentgoals {
  FragmentSettingsFragmentgoals({required this.goal, this.$__typename = 'userGoals'});

  factory FragmentSettingsFragmentgoals.fromJson(Map<String, dynamic> json) {
    final l$goal = json['goal'];
    final l$$__typename = json['__typename'];
    return FragmentSettingsFragmentgoals(
      goal: fromJsonEnumRelationshipGoal_enum((l$goal as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumRelationshipGoal_enum goal;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$goal = goal;
    _resultData['goal'] = toJsonEnumRelationshipGoal_enum(l$goal);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$goal = goal;
    final l$$__typename = $__typename;
    return Object.hashAll([l$goal, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentSettingsFragmentgoals || runtimeType != other.runtimeType) {
      return false;
    }
    final l$goal = goal;
    final lOther$goal = other.goal;
    if (l$goal != lOther$goal) {
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
