import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// What Hoje shows after a fight answer: only the way to repair and the chat, no common cards.
class const ConflictSection({super.key}) extends StatelessWidget {
  static const int _chatTabIndex = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today.conflict;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseFeatureCard(
          tag: l10n.tag,
          question: l10n.title,
          highlightedWord: l10n.highlight,
          supportText: l10n.text,
          face: FaceKind.smile,
          actionText: l10n.repair,
          onAction: () => context.pushRoute(const SosRoute()),
        ),
        const SizedBox(height: AppSpace.s10),
        BaseButton(
          text: l10n.chat,
          variant: .secondary,
          onPressed: () => context.tabsRouter.setActiveIndex(_chatTabIndex),
        ),
      ],
    );
  }
}
