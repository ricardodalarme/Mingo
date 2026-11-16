import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The screen that celebrates two people connecting.
class const ConnectedMoment({
  required final String? selfName,
  required final String? partnerName,
  required final VoidCallback onDone,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.acceptInvite.connected;

    return BaseMomentContent(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseAvatarPair(
            size: .large,
            selfInitials: _initial(selfName),
            partnerInitials: _initial(partnerName),
          ),
          const SizedBox(height: AppSpace.s24),
          Semantics(
            header: true,
            liveRegion: true,
            child: AppHighlightedText(
              text: l10n.title,
              highlight: l10n.titleHighlight,
              style: context.text.display,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpace.s12),
          Text(
            l10n.text,
            textAlign: TextAlign.center,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
      footer: BaseButton(text: l10n.goToToday, onPressed: onDone),
    );
  }

  String _initial(String? name) =>
      name == null || name.isEmpty ? '?' : name.substring(0, 1).toUpperCase();
}
