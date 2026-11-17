// dart format width=100
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentAnnoyanceFragment {
  FragmentAnnoyanceFragment({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.expiresAt,
    this.$__typename = 'annoyances',
  });

  factory FragmentAnnoyanceFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$body = json['body'];
    final l$createdAt = json['createdAt'];
    final l$expiresAt = json['expiresAt'];
    final l$$__typename = json['__typename'];
    return FragmentAnnoyanceFragment(
      id: (l$id as String),
      body: (l$body as String),
      createdAt: DateTime.parse((l$createdAt as String)),
      expiresAt: DateTime.parse((l$expiresAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String body;

  final DateTime createdAt;

  final DateTime expiresAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$expiresAt = expiresAt;
    _resultData['expiresAt'] = ((v) => v.toUtc().toIso8601String())(l$expiresAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$body = body;
    final l$createdAt = createdAt;
    final l$expiresAt = expiresAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$body, l$createdAt, l$expiresAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentAnnoyanceFragment || runtimeType != other.runtimeType) {
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
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$expiresAt = expiresAt;
    final lOther$expiresAt = other.expiresAt;
    if (l$expiresAt != lOther$expiresAt) {
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

const fragmentDefinitionAnnoyanceFragment = FragmentDefinitionNode(
  name: NameNode(value: 'AnnoyanceFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'annoyances'), isNonNull: false),
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
        name: NameNode(value: 'createdAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'expiresAt'),
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
const documentNodeFragmentAnnoyanceFragment = DocumentNode(
  definitions: [fragmentDefinitionAnnoyanceFragment],
);

extension ClientExtensionFragmentAnnoyanceFragment on graphql.GraphQLClient {
  void writeFragmentAnnoyanceFragment({
    required FragmentAnnoyanceFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'AnnoyanceFragment',
        document: documentNodeFragmentAnnoyanceFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentAnnoyanceFragment? readFragmentAnnoyanceFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'AnnoyanceFragment',
          document: documentNodeFragmentAnnoyanceFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentAnnoyanceFragment.fromJson(result);
  }
}
