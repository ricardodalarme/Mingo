import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/models/pronoun.dart';

extension EnumPronounMapper on EnumPronoun_enum {
  /// Null for a pronoun this version does not know.
  Pronoun? toModel() => switch (this) {
    EnumPronoun_enum.she => Pronoun.she,
    EnumPronoun_enum.he => Pronoun.he,
    EnumPronoun_enum.name_only => Pronoun.nameOnly,
    EnumPronoun_enum.$unknown => null,
  };
}

extension PronounMapper on Pronoun {
  EnumPronoun_enum toRemote() => switch (this) {
    Pronoun.she => EnumPronoun_enum.she,
    Pronoun.he => EnumPronoun_enum.he,
    Pronoun.nameOnly => EnumPronoun_enum.name_only,
  };
}
