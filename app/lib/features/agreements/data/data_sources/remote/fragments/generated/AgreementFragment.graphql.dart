// dart format width=100
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentAgreementFragment {
  FragmentAgreementFragment({
    required this.id,
    required this.body,
    required this.authorId,
    this.coupleId,
    this.confirmedAt,
    this.$__typename = 'agreements',
  });

  factory FragmentAgreementFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$body = json['body'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$confirmedAt = json['confirmedAt'];
    final l$$__typename = json['__typename'];
    return FragmentAgreementFragment(
      id: (l$id as String),
      body: (l$body as String),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      confirmedAt: l$confirmedAt == null ? null : DateTime.parse((l$confirmedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String body;

  final String authorId;

  final String? coupleId;

  final DateTime? confirmedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$confirmedAt = confirmedAt;
    _resultData['confirmedAt'] = l$confirmedAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$confirmedAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$body = body;
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$confirmedAt = confirmedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$body, l$authorId, l$coupleId, l$confirmedAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentAgreementFragment || runtimeType != other.runtimeType) {
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
    final l$authorId = authorId;
    final lOther$authorId = other.authorId;
    if (l$authorId != lOther$authorId) {
      return false;
    }
    final l$coupleId = coupleId;
    final lOther$coupleId = other.coupleId;
    if (l$coupleId != lOther$coupleId) {
      return false;
    }
    final l$confirmedAt = confirmedAt;
    final lOther$confirmedAt = other.confirmedAt;
    if (l$confirmedAt != lOther$confirmedAt) {
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

const fragmentDefinitionAgreementFragment = FragmentDefinitionNode(
  name: NameNode(value: 'AgreementFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'agreements'), isNonNull: false),
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
        name: NameNode(value: 'authorId'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'coupleId'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'confirmedAt'),
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
const documentNodeFragmentAgreementFragment = DocumentNode(
  definitions: [fragmentDefinitionAgreementFragment],
);

extension ClientExtensionFragmentAgreementFragment on graphql.GraphQLClient {
  void writeFragmentAgreementFragment({
    required FragmentAgreementFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'AgreementFragment',
        document: documentNodeFragmentAgreementFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentAgreementFragment? readFragmentAgreementFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'AgreementFragment',
          document: documentNodeFragmentAgreementFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentAgreementFragment.fromJson(result);
  }
}
