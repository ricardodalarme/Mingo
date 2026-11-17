// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentSlipSummaryFragment {
  FragmentSlipSummaryFragment({
    required this.id,
    required this.body,
    required this.kind,
    this.category,
    required this.forCard,
    required this.createdAt,
    this.$__typename = 'slips',
  });

  factory FragmentSlipSummaryFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$body = json['body'];
    final l$kind = json['kind'];
    final l$category = json['category'];
    final l$forCard = json['forCard'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return FragmentSlipSummaryFragment(
      id: (l$id as String),
      body: (l$body as String),
      kind: fromJsonEnumSlipKind_enum((l$kind as String)),
      category: l$category == null ? null : fromJsonEnumSlipCategory_enum((l$category as String)),
      forCard: (l$forCard as bool),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String body;

  final EnumSlipKind_enum kind;

  final EnumSlipCategory_enum? category;

  final bool forCard;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$kind = kind;
    _resultData['kind'] = toJsonEnumSlipKind_enum(l$kind);
    final l$category = category;
    _resultData['category'] = l$category == null ? null : toJsonEnumSlipCategory_enum(l$category);
    final l$forCard = forCard;
    _resultData['forCard'] = l$forCard;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$body = body;
    final l$kind = kind;
    final l$category = category;
    final l$forCard = forCard;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$body,
      l$kind,
      l$category,
      l$forCard,
      l$createdAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentSlipSummaryFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
      return false;
    }
    final l$forCard = forCard;
    final lOther$forCard = other.forCard;
    if (l$forCard != lOther$forCard) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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

const fragmentDefinitionSlipSummaryFragment = FragmentDefinitionNode(
  name: NameNode(value: 'SlipSummaryFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'slips'), isNonNull: false),
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
        name: NameNode(value: 'body'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'kind'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'category'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'forCard'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'createdAt'),
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
const documentNodeFragmentSlipSummaryFragment = DocumentNode(
  definitions: [fragmentDefinitionSlipSummaryFragment],
);

extension ClientExtensionFragmentSlipSummaryFragment on graphql.GraphQLClient {
  void writeFragmentSlipSummaryFragment({
    required FragmentSlipSummaryFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'SlipSummaryFragment',
        document: documentNodeFragmentSlipSummaryFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentSlipSummaryFragment? readFragmentSlipSummaryFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'SlipSummaryFragment',
          document: documentNodeFragmentSlipSummaryFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentSlipSummaryFragment.fromJson(result);
  }
}
