import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/lists/data/models/list_item_status.dart';
import 'package:app/features/lists/data/models/list_kind.dart';

extension EnumListKindMapper on EnumListKind_enum {
  ListKind toModel() => switch (this) {
    EnumListKind_enum.travel => ListKind.travel,
    EnumListKind_enum.restaurants => ListKind.restaurants,
    EnumListKind_enum.movies => ListKind.movies,
    EnumListKind_enum.custom => ListKind.custom,
    EnumListKind_enum.$unknown => throw const FormatException('Unknown list kind'),
  };
}

extension ListKindMapper on ListKind {
  EnumListKind_enum toRemote() => switch (this) {
    ListKind.travel => EnumListKind_enum.travel,
    ListKind.restaurants => EnumListKind_enum.restaurants,
    ListKind.movies => EnumListKind_enum.movies,
    ListKind.custom => EnumListKind_enum.custom,
  };
}

extension EnumListItemStatusMapper on EnumListItemStatus_enum {
  ListItemStatus toModel() => switch (this) {
    EnumListItemStatus_enum.dream => ListItemStatus.dream,
    EnumListItemStatus_enum.planned => ListItemStatus.planned,
    EnumListItemStatus_enum.done => ListItemStatus.done,
    EnumListItemStatus_enum.$unknown => throw const FormatException('Unknown list item status'),
  };
}

extension ListItemStatusMapper on ListItemStatus {
  EnumListItemStatus_enum toRemote() => switch (this) {
    ListItemStatus.dream => EnumListItemStatus_enum.dream,
    ListItemStatus.planned => EnumListItemStatus_enum.planned,
    ListItemStatus.done => EnumListItemStatus_enum.done,
  };
}
