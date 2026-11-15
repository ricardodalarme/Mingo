import 'package:app/features/account/presentation/sign_out/sign_out_dialog.dart';
import 'package:app/features/safety/presentation/safe_mode/cubit/safe_mode_cubit.dart';
import 'package:app/features/settings/data/repositories/settings_repository.dart';
import 'package:app/features/settings/presentation/discreet/cubit/discreet_mode_cubit.dart';
import 'package:app/features/settings/presentation/home/cubit/settings_home_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The settings root: sections with one line of status each; Safety is always first-level.
@RoutePage()
class const SettingsHomePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppInjector.instance.get<SettingsHomeCubit>()..load()),
        BlocProvider.value(value: AppInjector.instance.get<SafeModeCubit>()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.settingsHome;
    final isAuthenticated = context.select(
      (SettingsHomeCubit cubit) => cubit.state.isAuthenticated,
    );

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BaseStackedContent(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isAuthenticated) ...[const _AccountSection(), const SizedBox(height: AppSpace.s20)],
            const _PreferencesSection(),
            const SizedBox(height: AppSpace.s20),
            const _PrivacySection(),
            if (isAuthenticated) ...[const SizedBox(height: AppSpace.s20), const _AccountActions()],
          ],
        ),
      ),
    );
  }
}

class const _AccountSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.settingsHome;
    final deletionPending = context.select(
      (SettingsHomeCubit cubit) => cubit.state.deletionPending,
    );
    final hasRelationship = context.select(
      (SettingsHomeCubit cubit) => cubit.state.hasRelationship,
    );
    final partnerName = context.select((SettingsHomeCubit cubit) => cubit.state.partnerName);
    final hasPlus = context.select((SettingsHomeCubit cubit) => cubit.state.hasPlus);

    final relationship = partnerName == null
        ? l10n.connected
        : l10n.connectedWith(name: partnerName);
    final plan = switch (hasPlus) {
      null => null,
      true => l10n.planPlus,
      false => l10n.planFree,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (deletionPending) ...[
          BaseBanner(
            text: l10n.pendingBannerSimple,
            actionLabel: l10n.pendingAction,
            variant: BaseBannerVariant.warning,
            icon: AppIcons.warning,
            onAction: () => context.pushRoute(const DeleteAccountRoute()),
          ),
          const SizedBox(height: AppSpace.s16),
        ],
        BaseSectionHeader(title: l10n.accountSection),
        const SizedBox(height: AppSpace.s8),
        BaseListGroup(
          children: [
            BaseListTile(
              title: l10n.profile,
              icon: AppIcons.user,
              showsChevron: true,
              onTap: () => context.pushRoute(const ProfileSettingsRoute()),
            ),
            if (hasRelationship)
              BaseListTile(
                title: l10n.relationship,
                subtitle: relationship,
                icon: AppIcons.heart,
                showsChevron: true,
                onTap: () => context.pushRoute(const RelationshipRoute()),
              ),
            BaseListTile(
              title: l10n.plan,
              subtitle: plan,
              icon: AppIcons.star,
              showsChevron: true,
              onTap: () => context.pushRoute(const PlansRoute()),
            ),
          ],
        ),
      ],
    );
  }
}

class const _PreferencesSection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.settingsHome;
    final isAuthenticated = context.select(
      (SettingsHomeCubit cubit) => cubit.state.isAuthenticated,
    );
    final hasRelationship = context.select(
      (SettingsHomeCubit cubit) => cubit.state.hasRelationship,
    );
    final notificationsOn = context.select(
      (SettingsHomeCubit cubit) => cubit.state.notificationsOn,
    );
    final locale = AppInjector.instance.get<SettingsRepository>().get().locale;
    final safeModeOn = context.select((SafeModeCubit cubit) => cubit.state.isOn);

    final notifications = switch (notificationsOn) {
      null => null,
      true => l10n.on,
      false => l10n.off,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseSectionHeader(title: l10n.preferencesSection),
        const SizedBox(height: AppSpace.s8),
        BaseListGroup(
          children: [
            if (isAuthenticated) ...[
              BaseListTile(
                title: l10n.notifications,
                subtitle: notifications,
                icon: AppIcons.bell,
                showsChevron: true,
                onTap: () => context.pushRoute(const NotificationPreferencesRoute()),
              ),
              BaseListTile(
                title: l10n.devices,
                icon: AppIcons.smartphone,
                showsChevron: true,
                onTap: () => context.pushRoute(const DevicesRoute()),
              ),
            ],
            BaseListTile(
              title: l10n.theme,
              value: _themeLabel(context),
              icon: AppIcons.sparkle,
              showsChevron: true,
              onTap: () => context.pushRoute(const SettingsThemeRoute()),
            ),
            BaseListTile(
              title: l10n.language,
              value: locale == 'en'
                  ? context.l10n.language.languageEnglish
                  : context.l10n.language.languagePortuguese,
              icon: AppIcons.globe,
              showsChevron: true,
              onTap: () => context.pushRoute(const LanguageRoute()),
            ),
            if (isAuthenticated) ...[
              BaseListTile(
                title: l10n.weeklyCard,
                icon: AppIcons.mail,
                showsChevron: true,
                onTap: () => context.pushRoute(const SundayCardRoute()),
              ),
              if (hasRelationship && !safeModeOn)
                BaseListTile(
                  title: l10n.spice,
                  icon: AppIcons.heart,
                  showsChevron: true,
                  onTap: () => context.pushRoute(const SpiceRoute()),
                ),
              BaseListTile(
                title: context.l10n.widgets.settingsTitle,
                subtitle: context.l10n.widgets.settingsSubtitle,
                icon: AppIcons.smartphone,
                showsChevron: true,
                onTap: () => context.pushRoute(const WidgetsGalleryRoute()),
              ),
            ],
          ],
        ),
      ],
    );
  }

  String _themeLabel(BuildContext context) {
    final l10n = context.l10n.profileSetup;

    return switch (AppThemeScope.of(context)) {
      AppThemeVariant.rose => l10n.themeRose,
      AppThemeVariant.blue => l10n.themeBlue,
      AppThemeVariant.neutral => l10n.themeNeutral,
    };
  }
}

class const _PrivacySection() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.settingsHome;
    final isAuthenticated = context.select(
      (SettingsHomeCubit cubit) => cubit.state.isAuthenticated,
    );
    final hasRelationship = context.select(
      (SettingsHomeCubit cubit) => cubit.state.hasRelationship,
    );
    final discreetOn = context.select((DiscreetModeCubit cubit) => cubit.state.isOn);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseSectionHeader(title: l10n.privacySection),
        const SizedBox(height: AppSpace.s8),
        BaseListGroup(
          children: [
            if (hasRelationship)
              BaseListTile(
                title: l10n.privacy,
                subtitle: l10n.privacyStatus,
                icon: AppIcons.lock,
                showsChevron: true,
                onTap: () => context.pushRoute(const PrivacyHubRoute()),
              ),
            if (isAuthenticated)
              BaseListTile(
                title: l10n.discreet,
                subtitle: discreetOn ? l10n.discreetOn : l10n.discreetOff,
                icon: AppIcons.eye_off,
                showsChevron: true,
                onTap: () => context.pushRoute(const DiscreetModeRoute()),
              ),
            if (isAuthenticated)
              BaseListTile(
                title: context.l10n.sensitiveDays.entryTitle,
                subtitle: context.l10n.sensitiveDays.entrySupport,
                icon: AppIcons.calendar,
                showsChevron: true,
                onTap: () => context.pushRoute(const SensitiveDaysRoute()),
              ),
            BaseListTile(
              title: l10n.safety,
              subtitle: l10n.safetyStatus,
              icon: AppIcons.shield,
              showsChevron: true,
              onTap: () => context.pushRoute(const SafeModeRoute()),
            ),
            BaseListTile(
              title: l10n.help,
              subtitle: l10n.helpStatus,
              icon: AppIcons.help,
              showsChevron: true,
              onTap: () => context.pushRoute(const HelpRoute()),
            ),
          ],
        ),
      ],
    );
  }
}

class const _AccountActions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.settingsHome;

    return BaseListGroup(
      children: [
        BaseListTile(
          title: l10n.signOut,
          icon: AppIcons.logout,
          onTap: () => showSignOutDialog(context),
        ),
        BaseListTile(
          title: l10n.deleteAccount,
          icon: AppIcons.trash,
          isDestructive: true,
          onTap: () => context.pushRoute(const DeleteAccountRoute()),
        ),
      ],
    );
  }
}
