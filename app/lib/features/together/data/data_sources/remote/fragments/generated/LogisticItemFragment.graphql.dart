// dart format width=100
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentLogisticItemFragment {
  FragmentLogisticItemFragment({
    required this.id,
    required this.title,
    this.assigneeId,
    required this.authorId,
    this.coupleId,
    this.doneAt,
    this.confirmedAt,
    this.$__typename = 'logisticItems',
  });

  factory FragmentLogisticItemFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$assigneeId = json['assigneeId'];
    final l$authorId = json['authorId'];
    final l$coupleId = json['coupleId'];
    final l$doneAt = json['doneAt'];
    final l$confirmedAt = json['confirmedAt'];
    final l$$__typename = json['__typename'];
    return FragmentLogisticItemFragment(
      id: (l$id as String),
      title: (l$title as String),
      assigneeId: (l$assigneeId as String?),
      authorId: (l$authorId as String),
      coupleId: (l$coupleId as String?),
      doneAt: l$doneAt == null ? null : DateTime.parse((l$doneAt as String)),
      confirmedAt: l$confirmedAt == null ? null : DateTime.parse((l$confirmedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String? assigneeId;

  final String authorId;

  final String? coupleId;

  final DateTime? doneAt;

  final DateTime? confirmedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$assigneeId = assigneeId;
    _resultData['assigneeId'] = l$assigneeId;
    final l$authorId = authorId;
    _resultData['authorId'] = l$authorId;
    final l$coupleId = coupleId;
    _resultData['coupleId'] = l$coupleId;
    final l$doneAt = doneAt;
    _resultData['doneAt'] = l$doneAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$doneAt);
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
    final l$title = title;
    final l$assigneeId = assigneeId;
    final l$authorId = authorId;
    final l$coupleId = coupleId;
    final l$doneAt = doneAt;
    final l$confirmedAt = confirmedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$assigneeId,
      l$authorId,
      l$coupleId,
      l$doneAt,
      l$confirmedAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentLogisticItemFragment || runtimeType != other.runtimeType) {
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
    final l$assigneeId = assigneeId;
    final lOther$assigneeId = other.assigneeId;
    if (l$assigneeId != lOther$assigneeId) {
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
    final l$doneAt = doneAt;
    final lOther$doneAt = other.doneAt;
    if (l$doneAt != lOther$doneAt) {
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

const fragmentDefinitionLogisticItemFragment = FragmentDefinitionNode(
  name: NameNode(value: 'LogisticItemFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'logisticItems'), isNonNull: false),
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
        name: NameNode(value: 'assigneeId'),
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
        name: NameNode(value: 'doneAt'),
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
const documentNodeFragmentLogisticItemFragment = DocumentNode(
  definitions: [fragmentDefinitionLogisticItemFragment],
);

extension ClientExtensionFragmentLogisticItemFragment on graphql.GraphQLClient {
  void writeFragmentLogisticItemFragment({
    required FragmentLogisticItemFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'LogisticItemFragment',
        document: documentNodeFragmentLogisticItemFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentLogisticItemFragment? readFragmentLogisticItemFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'LogisticItemFragment',
          document: documentNodeFragmentLogisticItemFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentLogisticItemFragment.fromJson(result);
  }
}
