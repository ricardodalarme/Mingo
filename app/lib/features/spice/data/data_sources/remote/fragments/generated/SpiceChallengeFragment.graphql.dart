// dart format width=100
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentSpiceChallengeFragment {
  FragmentSpiceChallengeFragment({
    required this.id,
    required this.contentSlug,
    required this.acceptedBy,
    required this.doneBy,
    required this.swaps,
    this.$__typename = 'spiceChallenges',
  });

  factory FragmentSpiceChallengeFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$contentSlug = json['contentSlug'];
    final l$acceptedBy = json['acceptedBy'];
    final l$doneBy = json['doneBy'];
    final l$swaps = json['swaps'];
    final l$$__typename = json['__typename'];
    return FragmentSpiceChallengeFragment(
      id: (l$id as String),
      contentSlug: (l$contentSlug as String),
      acceptedBy: (l$acceptedBy as List<dynamic>).map((e) => (e as String)).toList(),
      doneBy: (l$doneBy as List<dynamic>).map((e) => (e as String)).toList(),
      swaps: (l$swaps as int),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String contentSlug;

  final List<String> acceptedBy;

  final List<String> doneBy;

  final int swaps;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$contentSlug = contentSlug;
    _resultData['contentSlug'] = l$contentSlug;
    final l$acceptedBy = acceptedBy;
    _resultData['acceptedBy'] = l$acceptedBy.map((e) => e).toList();
    final l$doneBy = doneBy;
    _resultData['doneBy'] = l$doneBy.map((e) => e).toList();
    final l$swaps = swaps;
    _resultData['swaps'] = l$swaps;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$contentSlug = contentSlug;
    final l$acceptedBy = acceptedBy;
    final l$doneBy = doneBy;
    final l$swaps = swaps;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$contentSlug,
      Object.hashAll(l$acceptedBy.map((v) => v)),
      Object.hashAll(l$doneBy.map((v) => v)),
      l$swaps,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentSpiceChallengeFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$contentSlug = contentSlug;
    final lOther$contentSlug = other.contentSlug;
    if (l$contentSlug != lOther$contentSlug) {
      return false;
    }
    final l$acceptedBy = acceptedBy;
    final lOther$acceptedBy = other.acceptedBy;
    if (l$acceptedBy.length != lOther$acceptedBy.length) {
      return false;
    }
    for (int i = 0; i < l$acceptedBy.length; i++) {
      final l$acceptedBy$entry = l$acceptedBy[i];
      final lOther$acceptedBy$entry = lOther$acceptedBy[i];
      if (l$acceptedBy$entry != lOther$acceptedBy$entry) {
        return false;
      }
    }
    final l$doneBy = doneBy;
    final lOther$doneBy = other.doneBy;
    if (l$doneBy.length != lOther$doneBy.length) {
      return false;
    }
    for (int i = 0; i < l$doneBy.length; i++) {
      final l$doneBy$entry = l$doneBy[i];
      final lOther$doneBy$entry = lOther$doneBy[i];
      if (l$doneBy$entry != lOther$doneBy$entry) {
        return false;
      }
    }
    final l$swaps = swaps;
    final lOther$swaps = other.swaps;
    if (l$swaps != lOther$swaps) {
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

const fragmentDefinitionSpiceChallengeFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SpiceChallengeFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'spiceChallenges'), isNonNull: false),
  ),
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
        name: NameNode(value: 'contentSlug'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'acceptedBy'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'doneBy'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'swaps'),
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
const documentNodeFragmentSpiceChallengeFragment = DocumentNode(
  definitions: [fragmentDefinitionSpiceChallengeFragment],
);

extension ClientExtensionFragmentSpiceChallengeFragment on graphql.GraphQLClient {
  void writeFragmentSpiceChallengeFragment({
    required FragmentSpiceChallengeFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SpiceChallengeFragment',
        document: documentNodeFragmentSpiceChallengeFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentSpiceChallengeFragment? readFragmentSpiceChallengeFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SpiceChallengeFragment',
          document: documentNodeFragmentSpiceChallengeFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentSpiceChallengeFragment.fromJson(result);
  }
}
