import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/privacy/data/models/consent.dart';

/// Converts the consent kinds the database stores into the app's enum and back.
extension RemoteConsentKindMapper on EnumConsentKind_enum {
  ConsentKind toModel() => switch (this) {
    EnumConsentKind_enum.analytics => ConsentKind.analytics,
    EnumConsentKind_enum.marketing => ConsentKind.marketing,
    EnumConsentKind_enum.ai => ConsentKind.ai,
    EnumConsentKind_enum.terms => ConsentKind.terms,
    _ => throw ArgumentError('Unknown consent kind: $this'),
  };
}

extension ConsentKindMapper on ConsentKind {
  EnumConsentKind_enum toRemote() => switch (this) {
    ConsentKind.analytics => EnumConsentKind_enum.analytics,
    ConsentKind.marketing => EnumConsentKind_enum.marketing,
    ConsentKind.ai => EnumConsentKind_enum.ai,
    ConsentKind.terms => EnumConsentKind_enum.terms,
  };
}
