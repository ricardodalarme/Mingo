import 'package:app/features/ideas/presentation/detail/cubit/idea_detail_cubit.dart';
import 'package:app/features/ideas/presentation/detail/widgets/idea_reason.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The idea as the board draws it: a hero card with the idea, why it was chosen, and the actions.
class const IdeaContent({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.ideaDetail;
    final idea = context.select((IdeaDetailCubit cubit) => cubit.state.current);
    final isDone = context.select((IdeaDetailCubit cubit) => cubit.state.isDone);
    final cubit = context.read<IdeaDetailCubit>();
    if (idea == null) return const SizedBox.shrink();

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseSurfaceCard(
            style: .ring,
            padding: const EdgeInsets.all(AppSpace.s22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BaseTag(text: l10n.label),
                    const Spacer(),
                    const BaseFace(kind: FaceKind.smile, size: FaceSize.small),
                  ],
                ),
                const SizedBox(height: AppSpace.s20),
                AppHighlightedText(
                  text: idea.title,
                  highlight: _longestWord(idea.title),
                  style: context.text.question,
                ),
                if (idea.body != null) ...[
                  const SizedBox(height: AppSpace.s12),
                  Text(
                    idea.body!,
                    style: context.text.body.copyWith(color: context.colors.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpace.s24),
          const IdeaReason(),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton(
            text: isDone ? l10n.done : l10n.willDo,
            isEnabled: !isDone,
            onPressed: cubit.markDone,
          ),
          const SizedBox(height: AppSpace.s10),
          BaseButton(text: l10n.another, variant: .secondary, onPressed: cubit.another),
          const SizedBox(height: AppSpace.s6),
          Center(
            child: BaseTextLink(text: l10n.later, onPressed: () => _pickReminder(context)),
          ),
        ],
      ),
    );
  }

  Future<void> _pickReminder(BuildContext context) async {
    final l10n = context.l10n.ideaDetail;
    final cubit = context.read<IdeaDetailCubit>();
    final choice = await BaseSheet.show<ReminderChoice>(
      context: context,
      title: l10n.laterTitle,
      child: Builder(
        builder: (sheetContext) {
          final labels = {
            ReminderChoice.tonight: l10n.tonight,
            ReminderChoice.tomorrow: l10n.tomorrow,
            ReminderChoice.weekend: l10n.weekend,
          };

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final entry in labels.entries) ...[
                BaseButton(
                  text: entry.value,
                  variant: .secondary,
                  onPressed: () => Navigator.of(sheetContext).pop(entry.key),
                ),
                const SizedBox(height: AppSpace.s10),
              ],
            ],
          );
        },
      ),
    );
    if (choice != null) await cubit.remindLater(choice);
  }

  String _longestWord(String text) {
    final words = text.replaceAll(RegExp('[?.!,]'), '').split(' ');

    return words.reduce((a, b) => b.length > a.length ? b : a);
  }
}
