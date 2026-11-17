import 'dart:io';

import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// Lock-screen widget variants (`X-148`): circular, rectangular and inline.
///
/// The three families only ever show a symbol and a generic phrase: never a
/// name, a note, a mood, a card state or a time.
class const LockScreenPreviewSection({required final WidgetPayload payload, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final isAndroid = Platform.isAndroid;
    final isNeutral = !payload.isSignedIn || !payload.onLockScreen;
    final label = isNeutral ? l10n.lockReminderShortLabel : l10n.lockScreenGenericPhrase;
    final phrase = isNeutral ? l10n.lockScreenNeutralPhrase : l10n.lockScreenPrivacyRule;
    final symbol = isNeutral ? AppIcons.prohibit : AppIcons.heart_filled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isAndroid)
          BaseEmptyState(
            title: l10n.lockScreenPageTitle,
            text: l10n.lockScreenAndroidUnavailable,
            face: FaceKind.thinking,
          )
        else ...[
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppPalette.neutral900,
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.card)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpace.s20),
              child: Column(
                children: [
                  Text(
                    l10n.lockScreenClockTime,
                    style: context.text.display.copyWith(color: AppPalette.white),
                  ),
                  const SizedBox(height: AppSpace.s4),
                  Text(
                    l10n.lockScreenClockDate,
                    style: context.text.caption.copyWith(color: AppPalette.neutral400),
                  ),
                  const SizedBox(height: AppSpace.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _LockVariant(
                        caption: l10n.lockScreenCircular,
                        child: _CircularVariant(symbol: symbol),
                      ),
                      _LockVariant(
                        caption: l10n.lockScreenRectangular,
                        child: _RectangularVariant(label: label, phrase: phrase, symbol: symbol),
                      ),
                      _LockVariant(
                        caption: l10n.lockScreenInline,
                        child: _InlineVariant(label: label, symbol: symbol),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.lockScreenPrivacyRule),
          if (!payload.onLockScreen) ...[
            const SizedBox(height: AppSpace.s8),
            BaseNote(text: l10n.lockScreenDisabledNote, icon: AppIcons.info),
          ],
          const SizedBox(height: AppSpace.s8),
          BaseNote(text: l10n.howToAddIosLockNote, icon: AppIcons.info),
        ],
      ],
    );
  }
}

class const _LockVariant({required final String caption, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 76, child: Center(child: child)),
        const SizedBox(height: AppSpace.s8),
        Text(caption, style: context.text.micro.copyWith(color: AppPalette.neutral400)),
      ],
    );
  }
}

class const _CircularVariant({required final IconData symbol}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppPalette.neutral800, shape: BoxShape.circle),
      child: AppIcon(icon: symbol, color: AppPalette.white),
    );
  }
}

class const _RectangularVariant({
  required final String label,
  required final String phrase,
  required final IconData symbol,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      padding: const EdgeInsets.all(AppSpace.s10),
      decoration: const BoxDecoration(
        color: AppPalette.neutral800,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppIcon(icon: symbol, size: AppIconSize.xs, color: AppPalette.white),
              const SizedBox(width: AppSpace.s4),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.micro.copyWith(color: AppPalette.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.s4),
          Text(
            phrase,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.text.tab.copyWith(color: AppPalette.neutral400),
          ),
        ],
      ),
    );
  }
}

class const _InlineVariant({required final String label, required final IconData symbol})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(icon: symbol, size: AppIconSize.xs, color: AppPalette.white),
        const SizedBox(width: AppSpace.s4),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.text.micro.copyWith(color: AppPalette.white),
        ),
      ],
    );
  }
}
