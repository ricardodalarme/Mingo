import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// The moment after a guided repair, before the person chooses to write down what they learned.
class const GuidedDone({required final String sessionId, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.repair.guided.done;

    return BaseMomentContent(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BaseFace(kind: FaceKind.smile, size: FaceSize.showcase),
          const SizedBox(height: AppSpace.s20),
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.title,
              highlight: l10n.highlight,
              style: context.text.titleXl,
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
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton(
            text: l10n.learn,
            onPressed: () => context.router.replace(LearningRoute(sessionId: sessionId)),
          ),
          const SizedBox(height: AppSpace.s10),
          BaseButton(
            text: l10n.close,
            variant: .secondary,
            onPressed: () => context.router.maybePop(),
          ),
        ],
      ),
    );
  }
}
