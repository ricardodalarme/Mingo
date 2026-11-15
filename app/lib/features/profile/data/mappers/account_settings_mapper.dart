import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/queries/generated/MySettings.graphql.dart';
import 'package:app/features/profile/data/mappers/relationship_goal_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_phase_mapper.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:design_system/design_system.dart';

extension MySettingsMapper on QueryMySettingsmySettings {
  AccountSettings toModel() => AccountSettings(
    theme: theme.toVariant(),
    profileId: profileId,
    timeZone: timeZone,
    partnerName: partnerName,
    togetherSince: togetherSince,
    onboardedAt: onboardedAt,
    shareReadReceipts: shareReadReceipts,
    phase: phase?.toModel(),
    goals: [for (final goal in goals) ?goal?.toRelationshipGoal()],
    locale: locale,
  );
}

extension EnumAppThemeMapper on EnumAppTheme {
  AppThemeVariant toVariant() => switch (this) {
    .azul => AppThemeVariant.blue,
    .neutro => AppThemeVariant.neutral,
    _ => AppThemeVariant.rose,
  };
}

extension AppThemeVariantMapper on AppThemeVariant {
  EnumAppTheme toServerTheme() => switch (this) {
    .blue => EnumAppTheme.azul,
    .neutral => EnumAppTheme.neutro,
    .rose => EnumAppTheme.rosa,
  };
}
