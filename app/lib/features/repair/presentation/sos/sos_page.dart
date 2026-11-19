import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// The way in when the couple is fighting: three calm choices, and nothing is sent from here.
@RoutePage()
class const SosPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.repair.sos;

    return BaseView(
      appBar: BaseAppBar(onClose: () => context.router.maybePop()),
      body: BaseStackedContent(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: AppHighlightedText(
                text: l10n.title,
                highlight: l10n.titleHighlight,
                style: context.text.display,
              ),
            ),
            const SizedBox(height: AppSpace.s8),
            Text(
              l10n.subtitle,
              style: context.text.body.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpace.s20),
            BaseListGroup(
              children: [
                BaseListTile(
                  icon: AppIcons.heart,
                  title: l10n.softStartTitle,
                  subtitle: l10n.softStartText,
                  showsChevron: true,
                  onTap: () => context.router.replace(const SoftStartRoute()),
                ),
                BaseListTile(
                  icon: AppIcons.smile,
                  title: l10n.repairTitle,
                  subtitle: l10n.repairText,
                  showsChevron: true,
                  onTap: () => context.router.replace(const TemperatureRoute()),
                ),
                BaseListTile(
                  icon: AppIcons.chat,
                  title: l10n.talkTitle,
                  subtitle: l10n.talkText,
                  showsChevron: true,
                  onTap: () => context.router.replace(ChatRoute()),
                ),
              ],
            ),
            const SizedBox(height: AppSpace.s16),
            BaseNote(text: l10n.note),
          ],
        ),
      ),
    );
  }
}
