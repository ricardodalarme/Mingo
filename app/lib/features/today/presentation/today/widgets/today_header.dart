import 'package:app/features/notifications/presentation/bell/widgets/inbox_bell_button.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/open_invite.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';

/// Avatars or the invite chip beside the settings button, then the greeting and the date.
class const TodayHeader({
  required final TodayHome home,
  final String? selfName,
  final bool isFirstDay = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;
    final now = clock.now();
    final name = selfName;
    final greeting = name == null
        ? l10n.greetingNoName
        : isFirstDay
        ? l10n.firstDayGreeting(name: name)
        : switch (now.hour) {
            < 12 => l10n.greetingMorning(name: name),
            < 18 => l10n.greetingAfternoon(name: name),
            _ => l10n.greetingEvening(name: name),
          };
    final dateLine = isFirstDay
        ? l10n.firstDaySubtitle
        : l10n.dateLine(
            weekday: l10n.weekdays[now.weekday - 1],
            day: now.day,
            month: l10n.months[now.month - 1],
          );
    final timeIcon = now.hour >= 18 || now.hour < 6 ? AppIcons.moon : AppIcons.sun;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (home.isPaired)
              BaseAvatarPair(
                selfInitials: _initial(name),
                partnerInitials: _initial(home.partnerName),
                onTap: () => context.pushRoute(const PartnerProfileRoute()),
                semanticLabel: l10n.partnerProfile,
              )
            else
              BaseAvatarPair(
                selfInitials: _initial(name),
                onTap: () => openInvite(context),
                semanticLabel: l10n.invitePerson,
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpace.s8,
              children: [
                BaseRoundButton(
                  icon: AppIcons.shield,
                  semanticLabel: context.l10n.repair.sos.action,
                  onPressed: () => context.pushRoute(const SosRoute()),
                ),
                const InboxBellButton(),
                BaseRoundButton(
                  icon: AppIcons.settings,
                  semanticLabel: context.l10n.settingsHome.title,
                  onPressed: () => context.pushRoute(const SettingsHomeRoute()),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpace.s24),
        Semantics(
          header: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Text(greeting, style: context.text.titleLg)),
              const SizedBox(width: AppSpace.s8),
              Padding(
                padding: const EdgeInsets.only(top: AppSpace.s2),
                child: AppIcon(icon: timeIcon, color: context.colors.accentLabel),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpace.s4),
        Text(dateLine, style: context.text.bodySm.copyWith(color: context.colors.textSecondary)),
      ],
    );
  }

  String _initial(String? name) =>
      name == null || name.isEmpty ? '' : name.substring(0, 1).toUpperCase();
}
