import 'package:app/features/questions/data/models/question_thread.dart';
import 'package:app/features/questions/presentation/questions/cubit/questions_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const QuestionsAnswerView({
  required final QuestionThread thread,
  final VoidCallback? onSkip,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.questions;
    final draft = context.select((QuestionsCubit cubit) => cubit.state.draft);
    final isSaving = context.select((QuestionsCubit cubit) => cubit.state.isSaving);
    final isEditing = context.select((QuestionsCubit cubit) => cubit.state.isEditing);
    final cubit = context.read<QuestionsCubit>();
    final name = thread.prompt.partnerName;
    final body = thread.prompt.body;

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(header: true, child: Text(thread.prompt.title, style: context.text.question)),
          if (body != null && body.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpace.s10),
            Text(body, style: context.text.body.copyWith(color: context.colors.textSecondary)),
          ],
          const SizedBox(height: AppSpace.s12),
          Text(
            thread.partnerHasAnswered
                ? l10n.partnerAnsweredNote
                : name == null || name.trim().isEmpty
                ? l10n.partnerSeesAfterFallback
                : l10n.partnerSeesAfter(name: name),
            style: context.text.bodySm.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s22),
          BaseTextArea(
            text: draft.value,
            hint: l10n.answerHint,
            maxLength: answerMaxLength,
            isEnabled: !isSaving,
            errorText: l10n.answerErrors.selectOrNull(draft.errorName),
            onChanged: cubit.onDraftChanged,
          ),
          if (thread.isSolo) ...[
            const SizedBox(height: AppSpace.s10),
            BaseNote(text: l10n.soloNote),
          ],
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton.primary(text: l10n.save, isLoading: isSaving, onPressed: cubit.save),
          const SizedBox(height: AppSpace.s6),
          if (isEditing)
            BaseButton.text(
              text: l10n.cancel,
              onPressed: isSaving ? null : cubit.cancelEditing,
              isFullWidth: true,
            )
          else
            BaseButton.text(
              text: l10n.skip,
              onPressed: isSaving ? null : onSkip,
              isFullWidth: true,
            ),
        ],
      ),
    );
  }
}
