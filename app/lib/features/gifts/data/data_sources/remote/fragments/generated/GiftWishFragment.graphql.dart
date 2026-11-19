// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentGiftWishFragment {
  FragmentGiftWishFragment({
    required this.id,
    required this.title,
    this.note,
    this.link,
    required this.status,
    required this.authorId,
    this.$__typename = 'giftIdeas',
  });

  factory FragmentGiftWishFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$note = json['note'];
    final l$link = json['link'];
    final l$status = json['status'];
    final l$authorId = json['authorId'];
    final l$$__typename = json['__typename'];
    return FragmentGiftWishFragment(
      id: (l$id as String),
      title: (l$title as String),
      note: (l$note as String?),
      link: (l$link as String?),
      status: fromJsonEnumGiftIdeaStatus_enum((l$status as String)),
      authorId: (l$authorId as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String? note;

  final String? link;

  final EnumGiftIdeaStatus_enum status;

  final String authorId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$note = note;
    _resultData['note'] = l$note;
    final l$link = link;
    _resultData['link'] = l$link;
    final l$status = status;
    _resultData['status'] = toJsonEnumGiftIdeaStatus_enum(l$status);
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$note = note;
    final l$link = link;
    final l$status = status;
    final l$authorId = authorId;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$title, l$note, l$link, l$status, l$authorId, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentGiftWishFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$note = note;
    final lOther$note = other.note;
    if (l$note != lOther$note) {
      return false;
    }
    final l$link = link;
    final lOther$link = other.link;
    if (l$link != lOther$link) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
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

const fragmentDefinitionGiftWishFragment = FragmentDefinitionNode(
  name: NameNode(value: 'GiftWishFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'giftIdeas'), isNonNull: false),
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
        name: NameNode(value: 'title'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'note'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'link'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'status'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'authorId'),
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
const documentNodeFragmentGiftWishFragment = DocumentNode(
  definitions: [fragmentDefinitionGiftWishFragment],
);

extension ClientExtensionFragmentGiftWishFragment on graphql.GraphQLClient {
  void writeFragmentGiftWishFragment({
    required FragmentGiftWishFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'GiftWishFragment',
        document: documentNodeFragmentGiftWishFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentGiftWishFragment? readFragmentGiftWishFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'GiftWishFragment',
          document: documentNodeFragmentGiftWishFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentGiftWishFragment.fromJson(result);
  }
}
