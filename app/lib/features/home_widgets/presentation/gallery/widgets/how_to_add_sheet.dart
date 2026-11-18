import 'dart:io';

import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// Opens the platform-specific "how to add" guide (`X-145`).
///
/// The app never adds a home widget itself and asks for no extra permission.
Future<void> showHowToAddSheet(BuildContext context) {
  final l10n = context.l10n.homeWidgets;
  final isAndroid = Platform.isAndroid;

  return BaseSheet.show<void>(
    context: context,
    title: l10n.howToAddTitle,
    subtitle: l10n.howToAddSubtitle,
    child: _HowToAddBody(isAndroid: isAndroid),
  );
}

class const _HowToAddBody({required final bool isAndroid}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final steps = isAndroid
        ? [l10n.howToAddAndroidStep1, l10n.howToAddAndroidStep2, l10n.howToAddAndroidStep3]
        : [l10n.howToAddIosStep1, l10n.howToAddIosStep2, l10n.howToAddIosStep3];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < steps.length; index++) ...[
          _StepRow(number: index + 1, text: steps[index]),
          if (index < steps.length - 1) const SizedBox(height: AppSpace.s12),
        ],
        const SizedBox(height: AppSpace.s20),
        BaseNote(text: l10n.howToAddNote, icon: AppIcons.info),
      ],
    );
  }
}

class const _StepRow({required final int number, required final String text})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSpace.s24,
          height: AppSpace.s24,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: colors.accentSoft, shape: BoxShape.circle),
          child: Text('$number', style: context.text.micro.copyWith(color: colors.accentOnSoft)),
        ),
        const SizedBox(width: AppSpace.s12),
        Expanded(
          child: Text(text, style: context.text.body.copyWith(color: colors.textPrimary)),
        ),
      ],
    );
  }
}
