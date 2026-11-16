import 'package:app/features/profile/data/models/pronoun.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The single choice of how a person is addressed in the app's sentences.
class const PronounChips({
  required final Pronoun? selected,
  required final ValueChanged<Pronoun> onChanged,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = context.l10n.pronouns.options;

    return Wrap(
      spacing: AppSpace.s8,
      runSpacing: AppSpace.s8,
      children: [
        for (final pronoun in Pronoun.values)
          BaseChoiceChip(
            label: labels.selectOrFallback(pronoun.name),
            isSelected: selected == pronoun,
            onTap: () => onChanged(pronoun),
          ),
      ],
    );
  }
}
