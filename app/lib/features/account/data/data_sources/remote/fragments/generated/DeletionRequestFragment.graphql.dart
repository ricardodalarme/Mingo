// dart format width=100
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentDeletionRequestFragment {
  FragmentDeletionRequestFragment({
    required this.requestedAt,
    required this.purgeAfter,
    this.$__typename = 'deletionRequests',
  });

  factory FragmentDeletionRequestFragment.fromJson(Map<String, dynamic> json) {
    final l$requestedAt = json['requestedAt'];
    final l$purgeAfter = json['purgeAfter'];
    final l$$__typename = json['__typename'];
    return FragmentDeletionRequestFragment(
      requestedAt: DateTime.parse((l$requestedAt as String)),
      purgeAfter: DateTime.parse((l$purgeAfter as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final DateTime requestedAt;

  final DateTime purgeAfter;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$requestedAt = requestedAt;
    _resultData['requestedAt'] = ((v) => v.toUtc().toIso8601String())(l$requestedAt);
    final l$purgeAfter = purgeAfter;
    _resultData['purgeAfter'] = ((v) => v.toUtc().toIso8601String())(l$purgeAfter);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$requestedAt = requestedAt;
    final l$purgeAfter = purgeAfter;
    final l$$__typename = $__typename;
    return Object.hashAll([l$requestedAt, l$purgeAfter, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentDeletionRequestFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$requestedAt = requestedAt;
    final lOther$requestedAt = other.requestedAt;
    if (l$requestedAt != lOther$requestedAt) {
      return false;
    }
    final l$purgeAfter = purgeAfter;
    final lOther$purgeAfter = other.purgeAfter;
    if (l$purgeAfter != lOther$purgeAfter) {
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

const fragmentDefinitionDeletionRequestFragment = FragmentDefinitionNode(
  name: NameNode(value: 'DeletionRequestFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'deletionRequests'), isNonNull: false),
  ),
  directives: [],
  selectionSet: SelectionSetNode(
    selections: [
      FieldNode(
        name: NameNode(value: 'requestedAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'purgeAfter'),
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
const documentNodeFragmentDeletionRequestFragment = DocumentNode(
  definitions: [fragmentDefinitionDeletionRequestFragment],
);

extension ClientExtensionFragmentDeletionRequestFragment on graphql.GraphQLClient {
  void writeFragmentDeletionRequestFragment({
    required FragmentDeletionRequestFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'DeletionRequestFragment',
        document: documentNodeFragmentDeletionRequestFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentDeletionRequestFragment? readFragmentDeletionRequestFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'DeletionRequestFragment',
          document: documentNodeFragmentDeletionRequestFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentDeletionRequestFragment.fromJson(result);
  }
}
