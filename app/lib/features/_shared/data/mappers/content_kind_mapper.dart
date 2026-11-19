import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/_shared/data/models/content_kind.dart';

extension ContentKindMapper on ContentKind {
  EnumContentKind_enum toRemote() => switch (this) {
    ContentKind.question => EnumContentKind_enum.question,
    ContentKind.meOrYou => EnumContentKind_enum.me_or_you,
    ContentKind.howWell => EnumContentKind_enum.how_well,
    ContentKind.neverHaveWe => EnumContentKind_enum.never_have_we,
    ContentKind.mission => EnumContentKind_enum.mission,
  };
}
