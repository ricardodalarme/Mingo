// dart format width=100
import '../../../../../../_shared/data/data_sources/remote/generated/schema.graphql.dart';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class FragmentCardFragment {
  FragmentCardFragment({
    required this.id,
    required this.status,
    this.note,
    required this.weekStart,
    this.sentAt,
    this.heldReason,
    required this.items,
    this.$__typename = 'cards',
  });

  factory FragmentCardFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$status = json['status'];
    final l$note = json['note'];
    final l$weekStart = json['weekStart'];
    final l$sentAt = json['sentAt'];
    final l$heldReason = json['heldReason'];
    final l$items = json['items'];
    final l$$__typename = json['__typename'];
    return FragmentCardFragment(
      id: (l$id as String),
      status: fromJsonEnumCardStatus_enum((l$status as String)),
      note: (l$note as String?),
      weekStart: DateTime.parse((l$weekStart as String)),
      sentAt: l$sentAt == null ? null : DateTime.parse((l$sentAt as String)),
      heldReason: l$heldReason == null
          ? null
          : fromJsonEnumHeldReason_enum((l$heldReason as String)),
      items: (l$items as List<dynamic>)
          .map((e) => FragmentCardFragmentitems.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final EnumCardStatus_enum status;

  final String? note;

  final DateTime weekStart;

  final DateTime? sentAt;

  final EnumHeldReason_enum? heldReason;

  final List<FragmentCardFragmentitems> items;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$status = status;
    _resultData['status'] = toJsonEnumCardStatus_enum(l$status);
    final l$note = note;
    _resultData['note'] = l$note;
    final l$weekStart = weekStart;
    _resultData['weekStart'] = ((v) => v.toIso8601String().substring(0, 10))(l$weekStart);
    final l$sentAt = sentAt;
    _resultData['sentAt'] = l$sentAt == null
        ? null
        : ((v) => v.toUtc().toIso8601String())(l$sentAt);
    final l$heldReason = heldReason;
    _resultData['heldReason'] = l$heldReason == null
        ? null
        : toJsonEnumHeldReason_enum(l$heldReason);
    final l$items = items;
    _resultData['items'] = l$items.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$status = status;
    final l$note = note;
    final l$weekStart = weekStart;
    final l$sentAt = sentAt;
    final l$heldReason = heldReason;
    final l$items = items;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$status,
      l$note,
      l$weekStart,
      l$sentAt,
      l$heldReason,
      Object.hashAll(l$items.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentCardFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$note = note;
    final lOther$note = other.note;
    if (l$note != lOther$note) {
      return false;
    }
    final l$weekStart = weekStart;
    final lOther$weekStart = other.weekStart;
    if (l$weekStart != lOther$weekStart) {
      return false;
    }
    final l$sentAt = sentAt;
    final lOther$sentAt = other.sentAt;
    if (l$sentAt != lOther$sentAt) {
      return false;
    }
    final l$heldReason = heldReason;
    final lOther$heldReason = other.heldReason;
    if (l$heldReason != lOther$heldReason) {
      return false;
    }
    final l$items = items;
    final lOther$items = other.items;
    if (l$items.length != lOther$items.length) {
      return false;
    }
    for (int i = 0; i < l$items.length; i++) {
      final l$items$entry = l$items[i];
      final lOther$items$entry = lOther$items[i];
      if (l$items$entry != lOther$items$entry) {
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

const fragmentDefinitionCardFragment = FragmentDefinitionNode(
  name: NameNode(value: 'CardFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'cards'), isNonNull: false),
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
        name: NameNode(value: 'status'),
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
        name: NameNode(value: 'weekStart'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'sentAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'heldReason'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'items'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'order_by'),
            value: ListValueNode(
              values: [
                ObjectValueNode(
                  fields: [
                    ObjectFieldNode(
                      name: NameNode(value: 'position'),
                      value: EnumValueNode(name: NameNode(value: 'asc')),
                    ),
                  ],
                ),
              ],
            ),
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
              name: NameNode(value: 'slipId'),
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
              name: NameNode(value: 'position'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'slip'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: SelectionSetNode(
                selections: [
                  FieldNode(
                    name: NameNode(value: 'category'),
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
);
const documentNodeFragmentCardFragment = DocumentNode(
  definitions: [fragmentDefinitionCardFragment],
);

extension ClientExtensionFragmentCardFragment on graphql.GraphQLClient {
  void writeFragmentCardFragment({
    required FragmentCardFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'CardFragment',
        document: documentNodeFragmentCardFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  FragmentCardFragment? readFragmentCardFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'CardFragment',
          document: documentNodeFragmentCardFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : FragmentCardFragment.fromJson(result);
  }
}

class FragmentCardFragmentitems {
  FragmentCardFragmentitems({
    required this.id,
    this.slipId,
    required this.body,
    required this.position,
    this.slip,
    this.$__typename = 'cardItems',
  });

  factory FragmentCardFragmentitems.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$slipId = json['slipId'];
    final l$body = json['body'];
    final l$position = json['position'];
    final l$slip = json['slip'];
    final l$$__typename = json['__typename'];
    return FragmentCardFragmentitems(
      id: (l$id as String),
      slipId: (l$slipId as String?),
      body: (l$body as String),
      position: (l$position as int),
      slip: l$slip == null
          ? null
          : FragmentCardFragmentitemsslip.fromJson((l$slip as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String? slipId;

  final String body;

  final int position;

  final FragmentCardFragmentitemsslip? slip;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$slipId = slipId;
    _resultData['slipId'] = l$slipId;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$position = position;
    _resultData['position'] = l$position;
    final l$slip = slip;
    _resultData['slip'] = l$slip?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$slipId = slipId;
    final l$body = body;
    final l$position = position;
    final l$slip = slip;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$slipId, l$body, l$position, l$slip, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentCardFragmentitems || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$slipId = slipId;
    final lOther$slipId = other.slipId;
    if (l$slipId != lOther$slipId) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$position = position;
    final lOther$position = other.position;
    if (l$position != lOther$position) {
      return false;
    }
    final l$slip = slip;
    final lOther$slip = other.slip;
    if (l$slip != lOther$slip) {
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

class FragmentCardFragmentitemsslip {
  FragmentCardFragmentitemsslip({
    this.category,
    required this.createdAt,
    this.$__typename = 'slips',
  });

  factory FragmentCardFragmentitemsslip.fromJson(Map<String, dynamic> json) {
    final l$category = json['category'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return FragmentCardFragmentitemsslip(
      category: l$category == null ? null : fromJsonEnumSlipCategory_enum((l$category as String)),
      createdAt: DateTime.parse((l$createdAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final EnumSlipCategory_enum? category;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$category = category;
    _resultData['category'] = l$category == null ? null : toJsonEnumSlipCategory_enum(l$category);
    final l$createdAt = createdAt;
    _resultData['createdAt'] = ((v) => v.toUtc().toIso8601String())(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$category = category;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([l$category, l$createdAt, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! FragmentCardFragmentitemsslip || runtimeType != other.runtimeType) {
      return false;
    }
    final l$category = category;
    final lOther$category = other.category;
    if (l$category != lOther$category) {
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
