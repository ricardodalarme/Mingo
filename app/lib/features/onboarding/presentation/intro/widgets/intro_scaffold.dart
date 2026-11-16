import 'package:app/features/onboarding/presentation/intro/cubit/intro_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// The shared frame of the first-use screens: step dashes, a highlighted title and a footer.
class const IntroScaffold({
  required final int stepIndex,
  required final String title,
  required final String highlight,
  required final String subtitle,
  required final Widget body,
  required final Widget footer,
  final bool isFirst = false,
  final bool isClosable = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      appBar: BaseAppBar(
        onBack: isFirst || isClosable ? null : () => context.router.maybePop(),
        onClose: isClosable ? () => context.router.maybePop() : null,
        stepIndicator: BaseStepper(count: introStepCount, currentIndex: stepIndex),
      ),
      body: BaseStackedContent(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpace.s12),
            Semantics(
              header: true,
              child: AppHighlightedText(
                text: title,
                highlight: highlight,
                style: context.text.titleXl,
              ),
            ),
            const SizedBox(height: AppSpace.s8),
            Text(subtitle, style: context.text.body.copyWith(color: context.colors.textSecondary)),
            const SizedBox(height: AppSpace.s24),
            body,
          ],
        ),
        footer: footer,
      ),
    );
  }
}

/// The footer of a screen that can be skipped: a quiet skip beside the main action.
class const IntroFooter({
  required final String skipText,
  required final String continueText,
  required final VoidCallback onSkip,
  required final VoidCallback onContinue,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BaseButton(text: skipText, variant: .secondary, isFullWidth: false, onPressed: onSkip),
        const SizedBox(width: AppSpace.s10),
        Expanded(
          child: BaseButton(text: continueText, onPressed: onContinue),
        ),
      ],
    );
  }
}

/// The footer of a screen that cannot be skipped: one main action.
class const IntroContinueFooter({
  required final String text,
  required final VoidCallback onPressed,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BaseButton(text: text, onPressed: onPressed);
}
