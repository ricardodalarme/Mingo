import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/dates/data/models/important_date_kind.dart';

extension EnumImportantDateKindMapper on EnumImportantDateKind_enum {
  ImportantDateKind toModel() => switch (this) {
    EnumImportantDateKind_enum.relationship => ImportantDateKind.relationship,
    EnumImportantDateKind_enum.birthday => ImportantDateKind.birthday,
    EnumImportantDateKind_enum.first => ImportantDateKind.first,
    EnumImportantDateKind_enum.holiday => ImportantDateKind.holiday,
    EnumImportantDateKind_enum.trip => ImportantDateKind.trip,
    EnumImportantDateKind_enum.reunion => ImportantDateKind.reunion,
    EnumImportantDateKind_enum.custom => ImportantDateKind.custom,
    EnumImportantDateKind_enum.$unknown => ImportantDateKind.custom,
  };
}

extension ImportantDateKindMapper on ImportantDateKind {
  EnumImportantDateKind_enum toRemote() => switch (this) {
    ImportantDateKind.relationship => EnumImportantDateKind_enum.relationship,
    ImportantDateKind.birthday => EnumImportantDateKind_enum.birthday,
    ImportantDateKind.first => EnumImportantDateKind_enum.first,
    ImportantDateKind.holiday => EnumImportantDateKind_enum.holiday,
    ImportantDateKind.trip => EnumImportantDateKind_enum.trip,
    ImportantDateKind.reunion => EnumImportantDateKind_enum.reunion,
    ImportantDateKind.custom => EnumImportantDateKind_enum.custom,
  };
}

extension ImportantDateOriginMapper on ImportantDateOrigin {
  EnumImportantDateOrigin_enum toRemote() => switch (this) {
    ImportantDateOrigin.manual => EnumImportantDateOrigin_enum.manual,
    ImportantDateOrigin.auto => EnumImportantDateOrigin_enum.auto,
    ImportantDateOrigin.chat => EnumImportantDateOrigin_enum.chat,
  };
}
