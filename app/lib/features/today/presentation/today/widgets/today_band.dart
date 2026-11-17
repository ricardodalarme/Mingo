import 'package:app/features/notifications/presentation/off_banner/widgets/notifications_off_banner.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/open_invite.dart';
import 'package:app/features/today/presentation/today/widgets/today_blocks.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The single notice Hoje shows before its blocks.
///
/// A pending invite outranks no connection, which outranks reminders switched off, so the screen
/// never stacks two bands. The reminders notice decides on the device whether it shows.
class const TodayBand({
  required final TodayHome home,
  required final bool isOffline,
  final Widget notificationsOff = const NotificationsOffBanner(),
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;

    return switch (todayBandFor(home: home, isOffline: isOffline)) {
      TodayBandKind.pendingInvite => Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.s12),
        child: BaseListCard(
          categoryLabel: l10n.pendingInviteTitle,
          category: AppCategory.invite,
          title: l10n.pendingInviteText,
          face: FaceKind.smile,
          onTap: () => openInvite(context),
        ),
      ),
      TodayBandKind.offline => Padding(
        padding: const EdgeInsets.only(bottom: AppSpace.s12),
        child: BaseBanner(text: l10n.offlineBand, icon: AppIcons.cloud),
      ),
      TodayBandKind.notificationsOff => notificationsOff,
    };
  }
}
